From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH] Consistently use perl from /usr/bin/ for scripts
Date: Tue,  1 May 2012 22:18:18 +0200
Message-ID: <1335903498-583-1-git-send-email-zbyszek@in.waw.pl>
References: <20120501175500.GA24258@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 22:18:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPJXA-0001eI-Pg
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 22:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875Ab2EAUSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 16:18:47 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35811 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab2EAUSq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 16:18:46 -0400
Received: from ip-78-30-111-99.free.aero2.net.pl ([78.30.111.99] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SPJWz-0004pL-9Z; Tue, 01 May 2012 22:18:41 +0200
X-Mailer: git-send-email 1.7.10.539.g8ecdfe
In-Reply-To: <20120501175500.GA24258@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196739>

While the majority of scripts use '#!/usr/bin/perl', some use
'#!/usr/bin/env perl'. In the end there is no difference, because the
Makefile rewrites "#!.*perl" with "#!$PERL_PATH" in scripted
Porcelains before installing. Nevertheless, the second form can be
misleading, because it suggests that perl found first in $PATH will be
used.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 git-relink.perl |    2 +-
 git-svn.perl    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-relink.perl b/git-relink.perl
index e136732..f29285c 100755
--- a/git-relink.perl
+++ b/git-relink.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/env perl
+#!/usr/bin/perl
 # Copyright 2005, Ryan Anderson <ryan@michonline.com>
 # Distribution permitted under the GPL v2, as distributed
 # by the Free Software Foundation.
diff --git a/git-svn.perl b/git-svn.perl
index 427da9e..9bec808 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/env perl
+#!/usr/bin/perl
 # Copyright (C) 2006, Eric Wong <normalperson@yhbt.net>
 # License: GPL v2 or later
 use 5.008;
--=20
1.7.10.539.g8ecdfe
