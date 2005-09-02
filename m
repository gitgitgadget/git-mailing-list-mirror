From: Linus Torvalds <torvalds@osdl.org>
Subject: Ugly "git pull .." merge messages
Date: Fri, 2 Sep 2005 00:46:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509011117130.6795@evo.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 02 09:46:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB6Fb-0006gj-R6
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 09:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbVIBHqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 03:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbVIBHqM
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 03:46:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030536AbVIBHqM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 03:46:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j827k7Bo029431
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Sep 2005 00:46:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j827k5Vm028081;
	Fri, 2 Sep 2005 00:46:06 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8008>


Junio, I think this happened when you rewrote the pull/push stuff to do
shorthands..

Lately, "git pull" generates a lot of extra crud in the single-line commit
message, which is annoying because a lot of tools will thus actually not
show enough of the line to be valid.

For example, it used to get rid of the ".git" at the end, and it didn't
bother to say "HEAD". So

    Merge HEAD from master.kernel.org:/home/rmk/linux-2.6-arm.git

used to be just

    Merge master.kernel.org:/home/rmk/linux-2.6-arm

which is actually much nicer. It tends to fit in the gitk description
window.

In this example:

    Merge refs/heads/release from master.kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6

I had manually removed the ".git" (since git-fetch-pack will happily add
it back), so it doesn't have the ".git" at the end of the message, but
instead it has a ref-name that is the internal git path rather than the
path that I actually specified. Now, we didn't use to be shorter, but at
least it used to be more readable, with

    Merge 'release' branch of master.kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6

(Ok, it's slightly shorter, but not much - but my point is that it's
actually more readable).

Could we get the nicer messages back, please?

		Linus
