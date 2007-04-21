From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Fri, 20 Apr 2007 17:47:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704201743130.4634@qynat.qvtvafvgr.pbz>
References: <200704171041.46176.andyparkins@gmail.com> 
 <7v7isbpb0p.fsf@assigned-by-dhcp.cox.net>  <200704171235.34793.andyparkins@gmail.com>
 <f091c7$grp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-631839363-1177116430=:4634"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 03:20:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf4Gv-0007AZ-0q
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 03:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbXDUBUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 21:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbXDUBUM
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 21:20:12 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:40682 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754021AbXDUBUL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 21:20:11 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Fri, 20 Apr 2007 18:20:11 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Fri, 20 Apr 2007 18:20:08 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <f091c7$grp$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45143>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-631839363-1177116430=:4634
Content-Type: TEXT/PLAIN; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 20 Apr 2007, Jakub Narebski wrote:

> Andy Parkins wrote:
>
>>>  * We do not do the borrowing from working tree when doing
>>>    grep_sha1(), but when we grep inside a file from working tree
>>>    with grep_file(), we do not currently make it go through
>>>    convert_to_git() to fix line endings.  Maybe we should, if
>>>    only for consistency.
>>
>> I'd actually argue not - git-grep searches the working tree.  The expanded
>> keywords are in the working tree.  Take the CRLF case - I'm a clueless user,
>> who only understands the system I'm working on.  I want to search for all the
>> line endings, so I do git-grep "\r\n" - that should work, because I'm
>> searching my working tree.
>
> Actually, "git grep" can search both the working tree (default), but also
> an index (--cached), or specified tree (or tree-ish). The same with
> "git diff": it can work on tree (repository), index, working tree version,
> now I think in [almost] any combination.
>
> Think what keyword expansion means to all this... Well, you can have -kk
> to expand/not expand keywords, but this is avoiding issue, not solving it

how is git-grep on the working tree any different than just useing grep? the 
value in the git-* versions of system commands are that they work on the 
history, index, etc wher ethe normal system tools don't.

in this particular case, since the git user can do a git-grep of the working 
tree, or a git-grep of HEAD (or of the index), I don't think that it hurts much 
either way.

if git-grep of the working tree converts things to the checked-in version before 
the pattern match, the user can still use grep  to go through the checked-out 
version

if git-grep of the working tree doesn't convert things to the checked-in version 
before the pattern match, the user can stil use git-grep HEAD or --cached to go 
through the checked-in version.

David Lang
--8323328-631839363-1177116430=:4634--
