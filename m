Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA882B9BC
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 06:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340263; cv=none; b=MOkETAicDHaKPt329+5mXIW4KRMd0lcKIX0E3//p2jjWIeo7rqHo3koRFNx8WCXacjmSpc3D+oh+ysTtwFxFHUzhAr95N8IGSHo/UMMdIox0cwnbyZHBjXSXyQ16FqdU27hA/GkJlfndEfiA6ox57F44UE0df4Ryig4tdGLnUTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340263; c=relaxed/simple;
	bh=mvvpIQKQZLDYaZGZ9yTcLnMRMD3JCdleA9XiB1f4Chs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xrt6eBPQf4NG9e9Hq6DJeLiHoypx0SXgTiG5OViBYm7DXJyjrqmLJXpP5tWR/1ooWj1eNejk0B9HUUrBp6xT4jT3F1izKaztEEtw7VAxzZdKLgqh+3sk4RQvVXImJwI0uO16CKnnu49bVGQ5n31Q5n2ue9KZqpHYiVO+noZ7k5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/c21jzy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/c21jzy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f4a4fbb35so7428995ad.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 22:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739340261; x=1739945061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQQRwUIEOndeYcTZat/PjSa8e43oGu1aHp2pJorluDw=;
        b=I/c21jzyM+E6y4x8fWyaiecgBgKUYaW3eCh0RfoVN6BDDxqrr3sJBv4x30j3MOFJex
         y/iBROd4UnVg3mGk28+fIdQOUMtSPvTpVhI8d6EgQsHRJPR/njkSEU2eGtEOnxZNCLXS
         3iySrCNgun/CDRIC6XqVf+SFXgmc4of2ETod6bgGAY3ZpfhFkIEmjcfNSteE5JyXlnB7
         NJhKN1UXsk8GswX7xe+e19ASLYgbwlukvpoZmOP+TsT4l4H1Gx7AXiAQQCo6w0FLBSUw
         ji2FY0QiHYZbKO/DNs34E106gEcTkiX/ed8c/8Bps/CFF2WvC3CqGtROQEOutnYs3+TF
         4GKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739340261; x=1739945061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQQRwUIEOndeYcTZat/PjSa8e43oGu1aHp2pJorluDw=;
        b=DtZysmmMFHpuBPA8FIawnLz0dJ8Pt0u/Lj/D48I+mYrldl+rmad+QseqAH2sJ4DQPa
         RpCSqV4pjCKuVxQ+Ltr7AxpmM6sgI+n8Mc46U06RahqGEuotQ9d9giCfNxhrx16K0xKf
         ZgYBoSQkcSRyfnqdtcCVNczpngDFNoa1LKB3gzza+oY+PRcTrgqN1TgQdFKkZi0LGU+B
         e4Xz7BbXH2Q4G1iHRbQPIObdT5PNfqWR7pWZInfsNDjujru+58Srb3S9ysVSzmaq2NXs
         qX15SqqUkx2DlCGJ2NZmQRTbesR9vCGVRAEUPEzgghO5JmlZC5whFTSsXzWRuwE35R37
         7Ouw==
X-Gm-Message-State: AOJu0Yz7P0cYOQVF5qElmfHIAuyAePdjo7yfcnXHmzAtCXt88ROw8khe
	Mr0dcE79mdurcx/r4W6/uuTsSc0QqTTsIt/HK9LZFykxYv/+r1RxgStkBA==
X-Gm-Gg: ASbGncvsD+DcVvGpbOd/WEQlp4DxVCdw77ExSK7ELUlHKTY11/Lu1bl5KCOChU0Uwo5
	aEGpwANOMI17EBbiuiEMjmLTm82pnpf6U15W5ZBUAOXp9tmDkVtWTXtlU3nuRXpzbcbJYE7+2x8
	dHeHLXVxxXiKQqMQRqiiH4k9uWfuvux2yPnNGQYXzt4gmfSFdgLBACyK48ohwGN9zn+hawW4nEq
	+oVfcy38nnbSJzyxN/nytLISVrUMTir9uJG1FIDzjuvVPoYV9E4q+4Zi9K4vcwzuENLFa9cSfZL
	XIzDtOi6pPZckR7wXzd4BR3JKg==
X-Google-Smtp-Source: AGHT+IEBRowUOOcw2FUytCSWqvcXdgEYCwO1QwlZjc4BFFKAHdOlPwGXSgQ/mVo/13Me+vu1/eqJXg==
X-Received: by 2002:a17:902:f14d:b0:21f:81cf:454a with SMTP id d9443c01a7336-21fb6f54a04mr65988345ad.22.1739340261184;
        Tue, 11 Feb 2025 22:04:21 -0800 (PST)
Received: from localhost.localdomain ([172.56.121.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53f6e2633sm5747411a12.16.2025.02.11.22.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:04:20 -0800 (PST)
From: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/6] xdiff: move sign comparison warning guard into each file
Date: Tue, 11 Feb 2025 22:04:13 -0800
Message-ID: <20250212060418.1645241-1-davvid@gmail.com>
X-Mailer: git-send-email 2.48.1.643.g32d702c6e8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow each file to fix the warnings guarded by the macro separately by
moving the definition from the shared xinclude.h into each file that
needs it.

xmerge.c and xprepare.c do not contain any signed vs. unsigned
comparisons so the definition was not included in these files.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 xdiff/xemit.c      | 2 ++
 xdiff/xhistogram.c | 2 ++
 xdiff/xinclude.h   | 2 --
 xdiff/xpatience.c  | 3 +++
 xdiff/xutils.c     | 2 ++
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 75f0fe4986..2b394a4806 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -20,6 +20,8 @@
  *
  */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "xinclude.h"
 
 static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 16a8fe2f3f..3d2b190fa6 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -41,6 +41,8 @@
  * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "xinclude.h"
 
 #define MAX_PTR	UINT_MAX
diff --git a/xdiff/xinclude.h b/xdiff/xinclude.h
index 7e56542526..a4285ac0eb 100644
--- a/xdiff/xinclude.h
+++ b/xdiff/xinclude.h
@@ -23,8 +23,6 @@
 #if !defined(XINCLUDE_H)
 #define XINCLUDE_H
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "xmacros.h"
 #include "xdiff.h"
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index a2d8955537..b0ba421b28 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -19,6 +19,9 @@
  *  Davide Libenzi <davidel@xmailserver.org>
  *
  */
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "xinclude.h"
 
 /*
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 9e36f24875..169edff5ab 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -20,6 +20,8 @@
  *
  */
 
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
 #include "xinclude.h"
 
 
-- 
2.48.1.643.g61982db19f

