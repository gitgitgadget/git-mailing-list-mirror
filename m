From: Pete Wyckoff <pw@padd.com>
Subject: Re: [RFC PATCH 0/3] git-p4: move to toplevel
Date: Mon, 13 Feb 2012 18:32:45 -0500
Message-ID: <20120213233245.GA29582@padd.com>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
 <7vehtyec64.fsf@alter.siamese.dyndns.org>
 <20120213203709.GA31671@ecki>
 <7vhayuctwm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 00:33:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx5OF-0004Th-Sd
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 00:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758384Ab2BMXcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 18:32:51 -0500
Received: from honk.padd.com ([74.3.171.149]:50435 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758347Ab2BMXcv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 18:32:51 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 1292124A6;
	Mon, 13 Feb 2012 15:32:50 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 14343313C6; Mon, 13 Feb 2012 18:32:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vhayuctwm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190689>

gitster@pobox.com wrote on Mon, 13 Feb 2012 13:20 -0800:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> >> Erm,... do you really need the alias if you add git-p4 in a directory on
> >> your $PATH?
> >
> > With recent git versions, this has stopped working.
> 
> Erm, I am confused.
> 
> 	$ git --exec-path
> 	/home/junio/g/Debian-6.X-x86_64/git-jch/libexec/git-core
> 	$ type git-hello
> 	bash: type: git-hello: not found
> 	$ cat >~/bin/common/git-hello <<EOF
> 	#!/bin/sh
> 	echo hello world
> 	EOF
> 	$ chmod +x ~/bin/common/git-hello
> 	$ type git-hello
> 	git-hello is /home/junio/bin/common/git-hello
> 	$ git hello
> 	hello world
> 
> What am I missing???

Neat.  I never knew this worked.  That lets me remove quite a
few aliases.  Apparently this has been possible since the
conversion from git.sh to git.c.

I tried to find where in the documentation this is talked about,
or where it should go.  This doesn't feel like the best spot,
though.

------------8<-----------

>From 574669898aa891ffe3e785b280ac36177116658e Mon Sep 17 00:00:00 2001
From: Pete Wyckoff <pw@padd.com>
Date: Mon, 13 Feb 2012 18:17:10 -0500
Subject: [PATCH] document git-<command> can be found in PATH

Explain up front to users that arbitrary git "commands" can
be found anywhere in the PATH.  For example, ~/bin/git-hello
will be invoked by "git hello".
---
 Documentation/git.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index f7e201f..0ef7f40 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -30,6 +30,8 @@ introduction.
 
 The '<command>' is either a name of a Git command (see below) or an alias
 as defined in the configuration file (see linkgit:git-config[1]).
+A '<command>' can also refer to an executable with the name git-'<command>'
+anywhere in your PATH.
 
 Formatted and hyperlinked version of the latest git
 documentation can be viewed at
-- 
1.7.9.193.g1d4a5.dirty
