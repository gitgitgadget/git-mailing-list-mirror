From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 51/73] gettextize: git-tag tag_template message
Date: Tue, 22 Feb 2011 23:42:10 +0000
Message-ID: <1298418152-27789-52-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w4-0000rs-DA
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab1BVXo0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:26 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:52041 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab1BVXoX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:23 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3867035bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=YtWbcz7HQnnwkzrsihRU5nkXpb+J+PRHnkWqjsVn+zY=;
        b=vAI3ecX7F8o6a5sr6ZzVLJ/mXsc6+iWnL92LAEU3eCHYSBaubbBtPTvp1t/wyYMkql
         9ZvlEgVl0tnFzBfFNHX+aBhKE3mJwjXs+ZAHCf4rNS0kAqJ1rmXhAYKIobgk6shNyuIT
         at4pD5LqQhHp3Yn9sjNm48JFnHHX2QV3tNohE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IcVPmoY7QreoJEaVjn8npKjOJ7rpFnRf+kTvxWyVunDJwz/JKXrvEDplGKFf9dRlQr
         pcG0D/fx0k0ypFC8/RZPncF3HX87SLcOOilP4G3/wBbXuJkaVwHAlIzbJ1Fx1lJPFVEr
         P051ofQnXvxOBwSxxg0M6eTeXxHDXV1lIqSMc=
Received: by 10.204.121.73 with SMTP id g9mr3061120bkr.37.1298418263069;
        Tue, 22 Feb 2011 15:44:23 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.22
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:22 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167636>

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
index 3e7baaf..1dedfd0 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1121,6 +1121,7 @@ test_expect_success \
 '
=20
 test_expect_success \
+	C_LOCALE_OUTPUT \
 	'message in editor has initial comment: first line' '
 	# check the first line --- should be empty
 	echo >first.expect &&
--=20
1.7.2.3
