From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 4/4] diff --stat: use most of the space for file names
Date: Fri, 10 Feb 2012 00:58:41 +0100
Message-ID: <1328831921-27272-5-git-send-email-zbyszek@in.waw.pl>
References: <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 01:24:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RveID-0004cD-74
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 01:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab2BJAYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 19:24:46 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52318 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767Ab2BJAYo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 19:24:44 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1Rvdtd-0001gR-MF; Fri, 10 Feb 2012 00:59:30 +0100
X-Mailer: git-send-email 1.7.9.rc2.127.gcb239
In-Reply-To: <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190350>

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 diff.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 8406a0d..6220190 100644
--- a/diff.c
+++ b/diff.c
@@ -1343,7 +1343,8 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 	}
=20
 	width =3D options->stat_width ? options->stat_width : term_columns();
-	name_width =3D options->stat_name_width ? options->stat_name_width : =
50;
+	name_width =3D options->stat_name_width ? options->stat_name_width
+		: term_columns() - 20; /* the graph defaults to 20 columns */
 	count =3D options->stat_count ? options->stat_count : data->nr;
=20
 	/* Sanity: give at least 5 columns to the graph,
--=20
1.7.9.rc2.127.gcb239
