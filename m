From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH] commit: more compact summary and without extra quotes
Date: Mon, 19 Jan 2009 23:45:16 +0100
Message-ID: <1232405116-2359-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 23:46:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP2tV-0007xZ-Rm
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 23:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbZASWp3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 17:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbZASWp2
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 17:45:28 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:41077 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbZASWp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 17:45:27 -0500
Received: by bwz14 with SMTP id 14so9583479bwz.13
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 14:45:26 -0800 (PST)
Received: by 10.223.115.131 with SMTP id i3mr663527faq.95.1232405125245;
        Mon, 19 Jan 2009 14:45:25 -0800 (PST)
Received: from localhost (p5B0D718A.dip.t-dialin.net [91.13.113.138])
        by mx.google.com with ESMTPS id y15sm10211070fkd.12.2009.01.19.14.45.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jan 2009 14:45:24 -0800 (PST)
X-Mailer: git-send-email 1.6.1.258.g7ff14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106396>

Original:
[master]: created d9a5491: "foo:bar"

While with the patch it becomes:
[master d9a5491] foo:bar

As discussed in the git mailing list:

http://marc.info/?l=3Dgit&m=3D122765031208922&w=3D2

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 builtin-commit.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 2f0b00a..b159af2 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -883,7 +883,7 @@ static void print_summary(const char *prefix, const=
 unsigned char *sha1)
 {
 	struct rev_info rev;
 	struct commit *commit;
-	static const char *format =3D "format:%h: \"%s\"";
+	static const char *format =3D "format:%h] %s";
 	unsigned char junk_sha1[20];
 	const char *head =3D resolve_ref("HEAD", junk_sha1, 0, NULL);
=20
@@ -910,7 +910,7 @@ static void print_summary(const char *prefix, const=
 unsigned char *sha1)
 	rev.diffopt.break_opt =3D 0;
 	diff_setup_done(&rev.diffopt);
=20
-	printf("[%s%s]: created ",
+	printf("[%s%s ",
 		!prefixcmp(head, "refs/heads/") ?
 			head + 11 :
 			!strcmp(head, "HEAD") ?
--=20
1.6.1.258.g7ff14
