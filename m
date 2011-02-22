From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 12/73] gettextize: git-add "did not match any files" message
Date: Tue, 22 Feb 2011 23:41:31 +0000
Message-ID: <1298418152-27789-13-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:48:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1xV-0001bt-SR
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818Ab1BVXr1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:47:27 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:33701 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058Ab1BVXnn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:43 -0500
Received: by bwz10 with SMTP id 10so3866742bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UnfvA3d4dab91WAHFtNagf2/oHrJ0ST7a6g3wLjCReo=;
        b=DWcVDp8JKjqOQZ4HwOx9fXE0sHZgf+Xaio3agvQnXFF5Zlalw7SBdEtD8Oo4R/rkyp
         LxmY5ApxFf2BP1SmHXgrZCv/WTRYi9gFRko2RgE02bCGjWJlcl00+C/40JGZBZuMcsiK
         RLz1deYcJUTnefXH7dshQKoTachmmmxH+kNUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VcEmi2IHUiZwifbzXXOK+oyl2XkKKqJBSnRcp3Ya/55+oPGGUhlJsaJe8Ym6P6yJYQ
         FzLFUadkB2OfXEeGUw9LnzovpGjDAeArWRrEknd+VRCN6vx2O9/rgXjVcEIZUAUnOm0A
         8DKxXsgarqlAzPjtckwlc9g8C7V/xVGsfL7Ro=
Received: by 10.204.7.4 with SMTP id b4mr3120198bkb.189.1298418222338;
        Tue, 22 Feb 2011 15:43:42 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.41
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:41 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167659>

Make the "did not match any files" message translatable, and skip the
test that checks for it when the C_LOCALE_OUTPUT prereq is not
present.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/add.c  |    2 +-
 t/t3700-add.sh |    8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 21776ac..ffbd459 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -451,7 +451,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 					if (excluded(&dir, pathspec[i], &dtype))
 						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
 				} else
-					die("pathspec '%s' did not match any files",
+					die(_("pathspec '%s' did not match any files"),
 					    pathspec[i]);
 			}
 		}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index ac115ed..7de42fa 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -268,8 +268,12 @@ test_expect_success 'git add --dry-run of existing=
 changed file' "
=20
 test_expect_success 'git add --dry-run of non-existing file' "
 	echo ignored-file >>.gitignore &&
-	test_must_fail git add --dry-run track-this ignored-file >actual 2>&1=
 &&
-	echo \"fatal: pathspec 'ignored-file' did not match any files\" | tes=
t_cmp - actual
+	test_must_fail git add --dry-run track-this ignored-file >actual 2>&1
+"
+
+test_expect_success C_LOCALE_OUTPUT 'git add --dry-run of an existing =
file output' "
+	echo \"fatal: pathspec 'ignored-file' did not match any files\" >expe=
ct &&
+	test_cmp expect actual
 "
=20
 cat >expect.err <<\EOF
--=20
1.7.2.3
