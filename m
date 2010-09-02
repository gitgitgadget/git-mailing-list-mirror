From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 21/25] gettextize: git-tag tag_template message
Date: Thu,  2 Sep 2010 19:40:42 +0000
Message-ID: <1283456446-22577-22-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:42:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFgT-0006jt-Ra
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687Ab0IBTmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:42:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50195 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672Ab0IBTma (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:42:30 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so81343wyb.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=nrTH+UeEXzFjYY/dvndSzVACkjtqboLI2+CqpFtFn8E=;
        b=tMjROynQBxg5T7Zcz3iBVMH0Q9MECr5GJhSNwyfcvDUuZuIMgCWbqypsMUZzIHcqwx
         k4/xETH78eUyWXVLeXH2oXb/oVUtnAyD9T0NgG0yUmrKqvhwLt8XzZ7ULCspAqjCZPL0
         EMuFDtQjX38hLyn4hZENHi9Pyhgg1ZKySkYWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AM+pOqrgzJYBL+4zNh86T04VKYCp6DFXOglKF7NyGJoTlQRn0H8zoebVc5awgn+UDW
         OEkugMLiBB50Zri0OzExSgDCNF2qePeIFmJPXQLyxfoICXWpHGb0Stxx1q6zq0mq1ux7
         deHMEXBMYv4BH5VamlKljIvyji3yGQ+up9e2g=
Received: by 10.227.145.5 with SMTP id b5mr37651wbv.189.1283456549630;
        Thu, 02 Sep 2010 12:42:29 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.42.28
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:42:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155182>

Mark the tag_template message as translatable with N_() and then use
it later with _().

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/tag.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 7870d87..4841621 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -215,10 +215,10 @@ static int do_sign(struct strbuf *buffer)
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
@@ -313,7 +313,7 @@ static void create_tag(const unsigned char *object,=
 const char *tag,
 		if (!is_null_sha1(prev))
 			write_tag_body(fd, prev);
 		else
-			write_or_die(fd, tag_template, strlen(tag_template));
+			write_or_die(fd, _(tag_template), strlen(_(tag_template)));
 		close(fd);
=20
 		if (launch_editor(path, buf, NULL)) {
--=20
1.7.2.2.614.g1dc9
