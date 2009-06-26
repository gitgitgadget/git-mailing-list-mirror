From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: Support multiple branch and tag paths in the
	svn repository.
Date: Fri, 26 Jun 2009 11:11:00 -0700
Message-ID: <20090626181100.GA25118@dcvr.yhbt.net>
References: <4A3A4945.6050307@drmicha.warpmail.net> <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net> <4A3F9A44.8070805@xiplink.com> <4A410A90.1090101@xiplink.com> <20090625093602.GA3997@dcvr.yhbt.net> <7v3a9o0x48.fsf@alter.siamese.dyndns.org> <20090626003338.GA591@dcvr.yhbt.net> <4A445A29.90907@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 20:11:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKFtE-0001qh-4G
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 20:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbZFZSK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 14:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752251AbZFZSK5
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 14:10:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55661 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbZFZSK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 14:10:57 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583D51F44D;
	Fri, 26 Jun 2009 18:11:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A445A29.90907@op5.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122314>

Andreas Ericsson <ae@op5.se> wrote:
> Eric Wong wrote:
>> Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Wong <normalperson@yhbt.net> writes:
>>>
>>>> Acked and and pushed out to git://git.bogomips.org/git-svn along with a
>>>> followup patch ...
>>> Hmmm...
>>>
>>> t9138-git-svn-multiple-branches.sh does not seem to pass for me.
>>>
>>>     ...
>>>     A    svn_project/tags_A/1.0
>>>     A    svn_project/tags_A/1.0/a.file
>>>     Checked out revision 3.
>>>     ./test-lib.sh: line 329: .: filename argument required
>>>     .: usage: . filename [arguments]
>>>     FATAL: Unexpected exit with code 2
>>
>> Oops, I wasn't reading the test too closely[1], this should fix it:
>>
>> From 1ad8ff7b49f508ad37081a709d4230833564eca2 Mon Sep 17 00:00:00 2001
>> From: Eric Wong <normalperson@yhbt.net>
>> Date: Thu, 25 Jun 2009 16:09:59 -0700
>> Subject: [PATCH] t9138: remove stray "." in tests
>>
>> This breaks bash and probably some other shells, but worked
>> fine with dash in my limited testing.
>
> Please reword to "The stray dots break bash and ..."
> Right now it reads as if the patch itself breaks bash et al.

Oops, reworded to:

    t9138: remove stray dot in test which broke bash

    The stray dot broke bash and probably some other shells,
    but worked fine with dash in my limited testing.

And pushed out to git://git.bogomips.org/git-svn

There's also some other changes in there that have been sitting a while
that may have been lost in the shuffle in the weeks I was offline:

Ben Jackson (3):
      Add 'git svn help [cmd]' which works outside a repo.
      git-svn: speed up find_rev_before
      Add 'git svn reset' to unwind 'git svn fetch'

Eric Wong (2):
      git-svn: convert globs to regexps for branch destinations
      t9138: remove stray dot in test which broke bash

Marc Branchaud (1):
      git svn: Support multiple branch and tag paths in the svn repository.

Thomas Rast (1):
      git-svn: let 'dcommit $rev' work on $rev instead of HEAD

-- 
Eric Wong
