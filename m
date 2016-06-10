From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/27] t5500, t5539: tests for shallow depth since a specific date
Date: Fri, 10 Jun 2016 19:27:06 +0700
Message-ID: <20160610122714.3341-20-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:32:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLZ6-0001XR-Mx
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932924AbcFJM33 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:29:29 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36484 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932915AbcFJM32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:29:28 -0400
Received: by mail-pa0-f65.google.com with SMTP id fg1so5022934pad.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1KteRw+LhUkYtUeyyGuL4wtzMDL4l98fnHJIvzPe+2k=;
        b=CV+g1sQEveM2Y3jDdKNfbIaw+uvof+b545tV6rwgFlRCvG7JDxOyO5QmJSTZnET4PV
         ItGdS09IGWIfEEVuRU7RPgiO4a2Um+/+ykOwypJg5b7VydilDfDm2Nty4q6WM9/Jigya
         lrFZA8nhYVtcRutfLbRgmsaM4dzimlP4phx781A3GrPL845Hf7lyk5UnI8oaGPxPhEcN
         NIrb03fxhuqBr5U+0zI093wAMQTN06rVGf/eJ1uVJjdSswFrLcQt5TrxlTTOXyC9M+4s
         rx09T1wDuxCmOPN+amC33NFTOgDif4REn0uMNFgfNeOBXKG2IHCftfM9O+QKRAeeG5/r
         PGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1KteRw+LhUkYtUeyyGuL4wtzMDL4l98fnHJIvzPe+2k=;
        b=kYab1hdJ8bkiu7W6vds46qlOYoqHNr67kAUDZLnCq5qAufR7utjGcqScZi5M0Dhe6A
         16oFw/y2LRoWc9adIzpikkBeRoFRAZPGyQlHPBYk26+latjH8bsvNVxvpw4Dw94erjXo
         XtvlyNHn3t6qSMhuz5n1nD37TnQS0szaORDBbaUmLmKztku27b4CeP7X0nKPJeXJY/A2
         GuQAhYb0uVSFlPOTzx8hPiz83xiz293ZvP7lMRen7oANyVijqfOqcsPL2e1Jx8Pjjdv0
         ggrc1tNq3/0FVg1KEw5wDp23BWJGl3kMvZUq2hVkbqmisJGOXunDZ913HDJWKbncgxAU
         nrEg==
X-Gm-Message-State: ALyK8tLJYQLeOssB9IVrJqYg50LNpinnJpx21f1/uY5iD2rOtfbCTUvo5X/t+w3DlWUtuA==
X-Received: by 10.66.249.234 with SMTP id yx10mr2136948pac.29.1465561766338;
        Fri, 10 Jun 2016 05:29:26 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id d8sm17481540pfg.72.2016.06.10.05.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:29:25 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:29:21 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296999>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5500-fetch-pack.sh         | 24 ++++++++++++++++++++++++
 t/t5539-fetch-http-shallow.sh | 25 +++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index e5f83bf..26f050d 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -637,4 +637,28 @@ test_expect_success MINGW 'fetch-pack --diag-url c=
:repo' '
 	check_prot_path c:repo file c:repo
 '
=20
+test_expect_success 'clone shallow since ...' '
+	test_create_repo shallow-since &&
+	(
+	cd shallow-since &&
+	GIT_COMMITTER_DATE=3D"100000000 +0700" git commit --allow-empty -m on=
e &&
+	GIT_COMMITTER_DATE=3D"200000000 +0700" git commit --allow-empty -m tw=
o &&
+	GIT_COMMITTER_DATE=3D"300000000 +0700" git commit --allow-empty -m th=
ree &&
+	git clone --shallow-since "300000000 +0700" "file://$(pwd)/." ../shal=
low11 &&
+	git -C ../shallow11 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'fetch shallow since ...' '
+	git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
+	git -C shallow11 log --pretty=3Dtformat:%s origin/master >actual &&
+	cat >expected <<-\EOF &&
+	three
+	two
+	EOF
+	test_cmp expected actual
+'
+
 test_done
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow=
=2Esh
index 37a4335..704753c 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -73,5 +73,30 @@ test_expect_success 'no shallow lines after receivin=
g ACK ready' '
 	)
 '
=20
+test_expect_success 'clone shallow since ...' '
+	test_create_repo shallow-since &&
+	(
+	cd shallow-since &&
+	GIT_COMMITTER_DATE=3D"100000000 +0700" git commit --allow-empty -m on=
e &&
+	GIT_COMMITTER_DATE=3D"200000000 +0700" git commit --allow-empty -m tw=
o &&
+	GIT_COMMITTER_DATE=3D"300000000 +0700" git commit --allow-empty -m th=
ree &&
+	mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-since.git" &&
+	git clone --shallow-since "300000000 +0700" $HTTPD_URL/smart/shallow-=
since.git ../shallow11 &&
+	git -C ../shallow11 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'fetch shallow since ...' '
+	git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
+	git -C shallow11 log --pretty=3Dtformat:%s origin/master >actual &&
+	cat >expected <<-\EOF &&
+	three
+	two
+	EOF
+	test_cmp expected actual
+'
+
 stop_httpd
 test_done
--=20
2.8.2.524.g6ff3d78
