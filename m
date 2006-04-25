From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 19:36:30 +0200
Organization: At home
Message-ID: <e2lmm3$rts$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org> <e2lijt$aco$1@sea.gmane.org> <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Apr 25 19:36:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYRSb-0000vF-Hw
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 19:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWDYRgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 13:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWDYRgQ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 13:36:16 -0400
Received: from main.gmane.org ([80.91.229.2]:3985 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751214AbWDYRgQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 13:36:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYRSQ-0000t4-Fy
	for git@vger.kernel.org; Tue, 25 Apr 2006 19:36:14 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 19:36:14 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 19:36:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19155>

Linus Torvalds wrote:

> On Tue, 25 Apr 2006, Jakub Narebski wrote:
>> 
>> The generic commit links "related" which is fsck-able at least and "note"
>> which is not. It is idea somewhat on the level of providing _extended
>> attributes_ in VFS in Linux kernel, IMVHO.
> 
> And nobody actually uses extended attributes either, do they?

Fedora's SELinux does use them, IIRC.

Well, people do use X-* headers in mail (sean's example), and some of them
got promoted from X-* to ordinary mail header status.

> Plus it's _not_ fsck'able, since the thing doesn't even have any valid
> semantics. You guys can't even agree on whether the object must exist or
> not.

Erm, further on we did agree 
  http://permalink.gmane.org/gmane.comp.version-control.git/19142
  (Message-Id: <7vmzeax9gj.fsf@assigned-by-dhcp.cox.net>). 
"related" links means that object must exist. "note" is what name says, just
note and doesn't even need to point to object.

> For exactly the same reason, git should not track it when a developer says
> "I think this commit is related to that commit". It's not hard data, that
> has hard and clear semantics.
> 
> Once you start adding data that has no clear semantics, you're screwed. At
> that point, it's a "track guesses" game, not a "track contents" game.

Well, the best example, i.e. remembering cherry picking has well defined
semantic (added when cherry-picking, used when merging, object does need
not to exist) but not well defined form. Currently the convention for
free-form is used, which has its advantages and disadvantages as pointed
out by Junio.


[somewhat unrelated note]
> Git tracks contents, and the well-defined history of how those contents
> came to be. Git does NOT track "additional notes" left by the developer
> that have weak semantics. Git does not track when a developer says "I
> renamed a file".

But I'd like Git to remember when I corrected false positives in "rename"
detection during merge, and added undetected automatically renames/file
contents copying and/or moving. Whether it would be done by saving the
information in commit header, commit free-for, or somewhere else...

-- 
Jakub Narebski
Warsaw, Poland
