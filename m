Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C27A1A275
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147359; cv=none; b=Dyt8+pQ2WjNxPRqYhtkrVjQG/nItIK6YVtNmjFTE3CCegC3t6IrhNb5AYPCEK7F9yUA4Aid2tqM/HqDAFV9a9A27+ZDx/n5+Ut0dDMoCigbm4x1Wuf2b/+fK9E1aQqleRf8aTmkw1tPX2c5XMYaMfYgdjeJ8NIODoUZFnc26Pqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147359; c=relaxed/simple;
	bh=YF6kd9hmLWVQKjBu0ToIcShnPDbAzRGZ7eJVhKyeTUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6VB5juJK9tmC3Xrk4hYgP8yU5Ko7EUYQhQR9vb3dxGM20IqklHCyF2qtXbJKwPPRJXlW+C2fReSAuUh26hsSgR72DPAMIVN0mBFMqsQS2Ab3L6ZJngyCzr0mavL7RXwgf5rHwSFq9aPoiXQB5JqBVOclsw6qvHfyKaRTqZwACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WveFR4F2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WveFR4F2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954dff6536so771055e9.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 17:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786147357; x=1786752157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D6/sjT1kD6rW5fJpUKxpvE85ofDIionXj5ELrodhOLE=;
        b=WveFR4F2OnoBj9G6CJGE/UVvoL26eCbGIljj8vPK7C/1wbm+JUUecFkA+GVUbxediL
         Lb4e4kFioY/6XdWlM+TF6xQetzC0dqouEEAd5EOnYkQRA7xEGHWU2k1hV+UWPDdQNnnw
         UD3pBzgBJsoolsZGLuLa/KOEX0Vsor3m/7KghS1dD0Gs1GuSbVL3CbQ7xx90Sea59LGI
         cIjUhHiDhHsynTssHxPWKL20lzCdiGxQ4u1qcG5JuPICVTJwG2JjJ4Zi16DFvJjUKfVT
         WPtZyecp13xaN9VEfsN/ggtP8dhtFceCay9XzSwSTHYlZYNaORR/eOdUMplz1jvvIC2E
         V3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786147357; x=1786752157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D6/sjT1kD6rW5fJpUKxpvE85ofDIionXj5ELrodhOLE=;
        b=cc2P9tLUrEBz0L1VTA6TLCZ05hkQRQX2Ab4Vuhr8kRymz38A7aT0vCP1PaFoaB4zge
         IqhWFRTNmLUK0QvQpKfrWe4PWFmrAERv5fDqmSrj0u+mwy8bWyUEHYjUDBSviCI9avy1
         AJUp1KxuWyjndkENjnaRY1A8Ix189f7q6cETc8P3GEk/v/wT9+PoKCYUqFmSoB3ILje3
         iTFiuL6i6Wb+FcvJxBln/YoUNEoTFwsGwRZ+fL3ttm78eC3ojiHQn3DWXcLiFhDHxBIn
         p/lJRunu24TRASgAxDtkXGyZ+m6YpyvM1+XdQZUCKq+dUp2E3z1Xf8g5MKYVHmXVN0KK
         1UXQ==
X-Gm-Message-State: AOJu0Yw6JsXsr4aGAByenj99rdXfFAnK6+hV6JioTURqvPmiVzBIxAaJ
	7JbKU8emw2y77y3qNkVxBL8g98lA7zQbayVbN7mNY8Jcj+5rIgInkKTF
X-Gm-Gg: AR+sD11s1YwDwcVsH346CpU9DUJ+zfLYyB6wHG4/pZsXnb1dSn4eMQKyVhsjQAUB6Ai
	mwFG+59joH75V90ToaAuvNCxQyGdmI/aYCB7KpK+uabkw8AXbs7xjzBZbFRz0ocqUld8ZPpueDY
	LfiR4HD6eQKB4uv2Bcv3OIf3CyV8ZjsQaK6bUny2uQc+YS1dKhMBYgDMjRwcwBTx0UlAldIcc3H
	4s6q0W0DGx2O2mw9tGKq4A41FbLZiwB2s1lJvuB6kdpJ9Bg1TDZgAYjm6R262i5Lkp+S/X2yjW7
	mEDSCY708eHRuD+QdEzAlQRbBoDg0s+uHyD9bko8ep9B0KJW4ZJ6GbTAx6rbGW6rR6t1Yc1RLiC
	/76XI7W629rIWcVTUnJOOt6eSTvCH79KudkSc8Zs09juUDUH2mA05hmsTGUhaTcGsF9wvYCNgD+
	btujVpadHBmRbvbQ1MBLSdKgtKm/xV7UgQj6y0yYHA6U0X14AqNv00kt33jqCzxwvpow2rKxrSh
	qRPTWFDwiXslFB1QFfSffo8tBWdtbpnJcZA45z9WfEhUJXvpTW+pH9IPKiEEB2zgqVp9z0KmN+p
	d5ayYIt2h8aS2iGCU/Hkaefrl+VKj3vJDb/C6bnggUHHsnlar3HtEl676v2nXoYxU0z4D9DYzrU
	Nh8b9iu4QttBPl6jgf1+009V6iuX3rCgm1UMPYmsVLoigeImiSQ+8nm6zvUg3WdbOddEH79nuN7
	1F7LI=
X-Received: by 2002:a05:600c:3ba6:b0:495:779a:ed33 with SMTP id 5b1f17b1804b1-49959e0c481mr149928205e9.7.1786147356524;
        Fri, 07 Aug 2026 17:02:36 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm72424525e9.2.2026.08.07.17.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:02:36 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 02:02:24 +0200
Subject: [PATCH GSoC v6 09/10] serve: advertise type capability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v6-9-e5cdaf27a49c@gmail.com>
References: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
In-Reply-To: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The server and the client can handle type requests but the client won't
ask for it until the server advertises it.

Add type to the advertised capabilities so the client knows that it can
request it.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 serve.c                                |  4 ++--
 t/t1017-cat-file-remote-object-info.sh | 26 ++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/serve.c b/serve.c
index 2b07d922b3..2ce513cf2d 100644
--- a/serve.c
+++ b/serve.c
@@ -97,9 +97,9 @@ static int object_info_advertise(struct repository *r, struct strbuf *value)
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
-	/* Currently only size is supported */
+	/* Currently only size and type are supported */
 	if (value && advertise_object_info)
-		strbuf_addstr(value, "size");
+		strbuf_addstr(value, "size type");
 	return advertise_object_info;
 }
 
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index 116862f9d0..190c45eefc 100755
--- a/t/t1017-cat-file-remote-object-info.sh
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -7,6 +7,7 @@ test_description='git cat-file --batch-command with remote-object-info command'
 
 hello_content="Hello World"
 hello_size=$(strlen "$hello_content")
+hello_type="blob"
 hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
 hello_short_oid=$(git rev-parse --short "$hello_oid")
 
@@ -19,6 +20,7 @@ unstored_oid=$(echo_without_newline "$unstored_content" | git hash-object --stdi
 # file name is hello, which is 5 characters
 # a space is 1 character and a null is 1 character
 tree_size=$(($(test_oid rawsz) + 13))
+tree_type="tree"
 
 commit_message="Initial commit"
 
@@ -31,6 +33,7 @@ commit_message="Initial commit"
 # An easier way to calculate is: 1. use `git cat-file commit <commit hash> | wc -c`,
 # to get 177, 2. then deduct 40 hex characters to get 137
 commit_size=$(($(test_oid hexsz) + 137))
+commit_type="commit"
 
 tag_header_without_oid="type blob
 tag hellotag
@@ -44,6 +47,7 @@ $tag_description"
 
 tag_oid=$(echo_without_newline "$tag_content" | git hash-object -t tag --stdin -w)
 tag_size=$(strlen "$tag_content")
+tag_type="tag"
 
 set_transport_variables () {
 	hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
@@ -256,14 +260,12 @@ test_expect_success 'remote-object-info does not die on missing oid like info' '
 	)
 '
 
-# This tests depends on %(objecttype) not being supported yet, once supported
-# it needs to be updated.
-test_expect_success 'unsupported placeholder on remote returns empty string' '
+test_expect_success 'objecttype is supported by remote-object-info' '
 	(
 		set_transport_variables "$daemon_parent" &&
 		cd "$daemon_parent/daemon_client_empty" &&
 
-		echo "" >expect &&
+		echo "$hello_type" >expect &&
 		git cat-file --batch-command="%(objecttype)" >actual <<-EOF &&
 		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
 		EOF
@@ -271,6 +273,22 @@ test_expect_success 'unsupported placeholder on remote returns empty string' '
 	)
 '
 
+test_expect_success 'unsupported placeholders on remote return empty string' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		fmt="%(objectmode) %(objectsize:disk) %(rest) %(deltabase)" &&
+
+		# The hardcoded SPs between the atoms are respected.
+		echo "   " >expect &&
+		git cat-file --batch-command="$fmt" >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'requesting only objectname echoes back' '
 	(
 		set_transport_variables "$daemon_parent" &&

-- 
2.54.0

