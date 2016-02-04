From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 18/25] t5500, t5539: tests for shallow depth since a specific date
Date: Thu,  4 Feb 2016 16:03:54 +0700
Message-ID: <1454576641-29615-19-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:06:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFri-0007Mo-CA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965493AbcBDJGJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:06:09 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34204 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965502AbcBDJF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:05:58 -0500
Received: by mail-pf0-f182.google.com with SMTP id o185so38438752pfb.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gqvxwmH5jJ7XiXkV32hcxzRP7mp1bhSxUpj+zjRTlYg=;
        b=EoxjkTWUGFRwJn6ztL3Vdvz3DCeE3BGeMcFyDQSS+4YM52r2S007R/pQBfa/jUPkQ5
         rzh9pN+csFP52UOXLOt09q8kys/UwR1IT9y4kWn1oeL6nDf7Y/fPJCw0REoa+jYywJ/v
         HZEO6sq+9XZGNS8yXPp3st+Dj18AeHfFB4C3lGvUlR2KUnAz6oPlL+rkGv6l79BxcXYG
         KUBUITgtrz/bMBzVC7fHMre6agzU5GxNt5M5QOsolgVO3yptmn1Sd8hefMtMv2dEyvEe
         2UksyRxsjKtVUgM/1jM5divvO2jfzvSgnwx6MdRI1sfMgjpCxNH39fgNzk0p3MDWiqwX
         ArIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=gqvxwmH5jJ7XiXkV32hcxzRP7mp1bhSxUpj+zjRTlYg=;
        b=T992vBxfWnOtLCEAiivhe31+D+KYuDIUI+VPIeFY2IVgEITzzIiICisAgRZJet1hfX
         Gz1nJPfyq8PjfENFE+PQC7ni59IA/HCBGoMS77LyxUeOWKcAA4Gy2PIxUOfAGYvmbjZ7
         PpYGHtk64ENzTqvixlho8fb7FGiGuxzlJP98AqJkPZiNvDHA23MJq9ty30LJMYrn8mF8
         MTv7yXAWk5Cu/XOjWMiUIffmDmtu5smhUdQobFc/HStBhU8nmEAUOwZAUX5bGzTIEgtW
         jlgDd2y5S7ZsnZa83qljgyZwnXIW2ne76TT3Wwzgpa0Y/QtclKjP9V1IL/9CBGi22XJZ
         rmhA==
X-Gm-Message-State: AG10YOSXLum0dR4+A1bwIUbZaImXolqc0BcD58IztOfts87GqxJn0QLcA+kvjY/eIcebjQ==
X-Received: by 10.98.7.14 with SMTP id b14mr9500545pfd.40.1454576757962;
        Thu, 04 Feb 2016 01:05:57 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id y26sm15323599pfi.88.2016.02.04.01.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:05:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:06:10 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285431>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5500-fetch-pack.sh         | 22 ++++++++++++++++++++++
 t/t5539-fetch-http-shallow.sh | 24 ++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index e5f83bf..453c571 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -637,4 +637,26 @@ test_expect_success MINGW 'fetch-pack --diag-url c=
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
+	echo three >expected &&
+	echo two  >>expected &&
+	test_cmp expected actual
+'
+
 test_done
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow=
=2Esh
index 37a4335..2a96ab3 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -73,5 +73,29 @@ test_expect_success 'no shallow lines after receivin=
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
+	echo three >expected &&
+	echo two  >>expected &&
+	test_cmp expected actual
+'
+
+
 stop_httpd
 test_done
--=20
2.7.0.377.g4cd97dd
