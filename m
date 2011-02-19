From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 50/72] gettextize: git-tag tag_template message
Date: Sat, 19 Feb 2011 19:24:33 +0000
Message-ID: <1298143495-3681-51-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTr-0003Eb-3F
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171Ab1BST2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079Ab1BST2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:09 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=pccrxzrOVQJco0quBAKoBfQAJg1EXl6tDahglcQ39tA=;
        b=u0cCJ9CiN3t0XDpYmKXtgYoeoLdF7IbbyxM6ttaTjC+UbZaasgK/sv1UPIRob/QGhV
         9Nt8S9+YUS1TQ3dV0PP2ET8M3CPBUV5g91bz6t+oaIkpv54yeF4sSpJvWn2PBZJyuNAn
         jvU6FDQcdNLqgt6NuLBVP6TmI1vsmJsH8KYtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=u6s9lseER2ALZMyws2bhe7YKMR/3MgNWtUa+npd1jHW+PZDUozJ2f904LJG/vJ1eZW
         G+/PcQ3Ltajp1ZCBhm7N4G1cIZ4vCFVVkW5wY8h5xVt87prRO/2kSyC4Nn2rIFbYmSvU
         nIQY7lqDOSpwHNyloOJGEGipAHi4xwogSsqAE=
Received: by 10.14.127.136 with SMTP id d8mr2432280eei.35.1298143688922;
        Sat, 19 Feb 2011 11:28:08 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.08
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:08 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167338>

Mark the tag_template message as translatable with N_() and then use
it later with _(). We need to skip a test under GETTEXT_POISON that
relies on the output having a leading newline.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/tag.c  |    6 +++---
 t/t7004-tag.sh |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 4bed7c2..4242e27 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -213,10 +213,10 @@ static int do_sign(struct strbuf *buffer)
 }
=20
 static const char tag_template[] =3D
-	"\n"
+	N_("\n"
 	"#\n"
 	"# Write a tag message\n"
-	"#\n";
+	"#\n");
=20
 static void set_signingkey(const char *value)
 {
@@ -305,7 +305,7 @@ static void create_tag(const unsigned char *object,=
 const char *tag,
 		if (!is_null_sha1(prev))
 			write_tag_body(fd, prev);
 		else
-			write_or_die(fd, tag_template, strlen(tag_template));
+			write_or_die(fd, _(tag_template), strlen(_(tag_template)));
 		close(fd);
=20
 		if (launch_editor(path, buf, NULL)) {
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 3e7baaf..99d1fbc 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1121,6 +1121,7 @@ test_expect_success \
 '
=20
 test_expect_success \
+	NO_GETTEXT_POISON \
 	'message in editor has initial comment: first line' '
 	# check the first line --- should be empty
 	echo >first.expect &&
--=20
1.7.2.3
