From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 14 Oct 2006 18:40:55 +0200
Organization: At home
Message-ID: <egr3ud$nqm$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Sat Oct 14 18:41:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYmZY-0006Ue-Iy
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 18:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422714AbWJNQlK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 12:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422721AbWJNQlK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 12:41:10 -0400
Received: from main.gmane.org ([80.91.229.2]:26066 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422714AbWJNQlJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Oct 2006 12:41:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GYmZC-0006Ow-40
	for git@vger.kernel.org; Sat, 14 Oct 2006 18:40:54 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Oct 2006 18:40:54 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Oct 2006 18:40:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28882>

Jon Smirl wrote:

> It refers to this comparison chart between source control systems.
> http://bazaar-vcs.org/RcsComparisons

It is quite obvious that comparison of programs of given type (SMC)
on some program site (Bazaar-NG) is usually biased towards said program,
perhaps unconsciously: by emphasizing the features which were important
for developers of said program.
 
> Does it accurately reflect the current status of git? Is their
> assessment of git's rename capability correct?

For example simple namespace for git: you can use shortened sha1
(even to only 6 characters, although usually 8 are used), you can
use tags, you can use ref^m~n syntax.

I'm not sure about "No" in "Supports Repository". Git supports multiple
branches in one repository, and what's better supports development using
multiple branches, but cannot for example do a diff or a cherry-pick
between repositories (well, you can use git-format-patch/git-am to
cherry-pick changes between repositories...).

About "checkouts", i.e. working directories with repository elsewhere:
you can use GIT_DIR environmental variable or "git --git-dir" option,
or symlinks, and if Nguyen Thai Ngoc D proposal to have .gitdir/.git
"symref"-like file to point to repository passes, we can use that.

Partial checkouts are only partially supported as of now; it means
you have to do some lowe level stuff to do partial checkout, and be
carefull when comitting. BTW it depends what you mean by partial
checkout, but they are somewhat incompatibile with atomic commits
to snapshot based repository.

Git supports renames in its own way; it doesn't use file ids, nor
remember renames (the new "note" header for use e.g. by porcelains 
didn't pass if I remember correctly). But it does *detect* moving
_contents_, and even *copying* _contents_ when requested. And of
course it detect renames in merges.

Git doesn't have some "plugin framework", but because it has many
"plumbing" commands, it is easy to add new commands, and also new
merge strategies, using shell scripts, Perl, Python and of course C.
So the answer would be "Somewhat", as git has plugable merge strategies,
or even "Yes" at it is easy to add new git command.

> They want changes via IRC. "Please discuss changes to this table on
> the freenode IRC network channel #bzr, or on the mailing list."

Gaah, subscribe-to-post mailing list!
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
