From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/26] t5500, t5539: tests for shallow depth since a specific date
Date: Wed, 13 Apr 2016 19:55:02 +0700
Message-ID: <1460552110-5554-19-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:57:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKLq-0004V8-34
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030831AbcDMM4u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:56:50 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33779 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030810AbcDMM4s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:56:48 -0400
Received: by mail-pa0-f68.google.com with SMTP id vv3so3864315pab.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=szXeupnRAcrKQymWkN7yWeIPqkxfeJlCxvx6Ix3PkBg=;
        b=RBMxrl1RmWPhixMBXNk2IsOCgLxHiaAqCKC9bykDBX0gVnqmlDoBcCqhDE1aR7ZGvZ
         3wCve5EMuo4FOZRTgmuJSFYAH+fERUtmPMHsnHxSROQDJSLIHDIzOyGcTy7hIMEVknyD
         MmePw8jW51EZQu8fZqfqvYqqWTMs7Rw16HvJYWnc+/vUtBJQzpsMwmgnWf8rZkZw0AF7
         A8eYTdoMcjt8tKezyC/yBj3uHUNe/v22FS4EaN7CICDEMOtNqGqHJkStFXrddJ1QvEJc
         AjEPKp8g5h8qw+euyhX3uHiIRrCTvLzCtXwDD3K3rrb7bnywcE4Rsp/duvqI8JVmCPkk
         DXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=szXeupnRAcrKQymWkN7yWeIPqkxfeJlCxvx6Ix3PkBg=;
        b=FmO5x9B/HzY5PYIY2G4l+sfBeoHmPPprhle6K+hH+wvxdJHYWOf+S7h30Y8CdI+A7U
         IODQmMO3Rv79ucqpmL54hiRguqPm61WIIhTf5vkCMbYPo54ApuzmIhGHCWznRleyFRdb
         PJ4EVpLqlHenT8nJQfx2jVDkjHDZKHGCBGfKT0IygluYJ1UTFtcyo1A3uQnG27C1DOUh
         ZMwnNfwhRVmomcjGnnFayiC6NxAg9rvtjkE6RAMd+fzA5+uq87wqCjLz4ME0Xzhy+v9t
         vYk5D5vBrA6iRdzskybJuc14JlL9jNuOZXvkFYxLGeBc+wodK5LTjnqI0N2U7ii++lq/
         PjKg==
X-Gm-Message-State: AOPr4FVbvZK5qEtISDGby94qvzHTXs8x/vgoAhxdYUapTE6pW3FmoPJk8Y47wbif0MYWzw==
X-Received: by 10.66.139.9 with SMTP id qu9mr12680192pab.101.1460552208103;
        Wed, 13 Apr 2016 05:56:48 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id g74sm51084749pfj.1.2016.04.13.05.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:56:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:56:54 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291413>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5500-fetch-pack.sh         | 24 ++++++++++++++++++++++++
 t/t5539-fetch-http-shallow.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

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
index 37a4335..6d77ca7 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -73,5 +73,31 @@ test_expect_success 'no shallow lines after receivin=
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
+
 stop_httpd
 test_done
--=20
2.8.0.rc0.210.gd302cd2
