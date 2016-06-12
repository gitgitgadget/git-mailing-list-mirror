From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 19/27] t5500, t5539: tests for shallow depth since a specific date
Date: Sun, 12 Jun 2016 17:54:01 +0700
Message-ID: <20160612105409.22156-20-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:56:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC346-0003u4-Ay
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbcFLK4V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:56:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35694 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbcFLK4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:56:20 -0400
Received: by mail-pf0-f196.google.com with SMTP id t190so8464889pfb.2
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XgOZlWerte4wZZ9+7C911fb0eN5ho4h2qz13buNAZDc=;
        b=UG/h5Cp7XCWle/BSJ4oX/WTjnw7zOnhPI+weRXo7faSNHKcmVAqFZS0BF7d9VbrC/g
         MfWv/TAoD8Wu6MeZP+9giv0XvhOrf/M9CkhDmcCNC73khEm/GONb+VrlkmOic9is+W/9
         IkOYyom2fICdw1IKMjAUdnqZfhwLwMDpuqKiz9NYSosQje1ZpXbgQy1Us2qTvPaViteu
         +eePR3vASXzE3fLdBqXoIYcKDP09uUSMrSSY58B5a6I7fOyZhexcC3yynszwhL1GcxIi
         Co2S5D0blWcqi9/D1DsiJFv4GxykRb6+vJOvhVtTW+6hvqpDHelSbjZo6EN5YEilvAvX
         mreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XgOZlWerte4wZZ9+7C911fb0eN5ho4h2qz13buNAZDc=;
        b=LdCw9wpZJ8arzs+J3Qc6CCAzbssgUI9ho/2GlRebIaETpGI9P+HA/p4SZ/n/3AK3/f
         LZZXQ6kDsYq5STUvCF4BPtUE4Ji8C9xgDMAR/owqg/RB86lK4CitsbHC6FkE8Bgc0T3h
         qz/LIp5c3BmOZPI+xqupSGhGmp0FIVz6Mu1VnCBXXAWAN4TYym2VCtE9DPy0IdXhXPx1
         A/zbwFAv0psAjUNQPnoTW0jACt663x3qgyYantNn5gF0L1dE51P6wnabKmWn1IhNTIGl
         p6qH5V1QaUi+Yo8HduI44sCQOSkk/6Ix7PY9xzqK6hgBGm+bSSZ1Rs+5Xr1le/eA7IQa
         GxYQ==
X-Gm-Message-State: ALyK8tL9wBAkmG1V/vrD5fgNxjJCUxx03AGj4ysxyl8IGP/mrwlIsXZabG1gx5rqH6Ll/Q==
X-Received: by 10.98.79.90 with SMTP id d87mr14224867pfb.120.1465728979345;
        Sun, 12 Jun 2016 03:56:19 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id v184sm29836864pfb.24.2016.06.12.03.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:56:18 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:56:14 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297127>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
