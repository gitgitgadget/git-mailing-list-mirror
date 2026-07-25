Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86D33C18B
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784980539; cv=none; b=CFzKz8585hqzWx+lmgWicdBJCewiquILh9RTLpCZXpOosFA1XTldFckm1g5n+h5xsFWcuBLV2Nt3gB/iY5QB9/m/0mKvNwviWdn/UpF2ubg8T44sMRbaeb1YGidg8a4XoNQ6ho7NZSGHN1j8k6vqhNaEWERvx6uwpVcRFZnbrMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784980539; c=relaxed/simple;
	bh=A5dGfWzBmJ7L+wTIlvNYFhD6Q93NweaPwsmMJWWosiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lD6YGaJl5UXpUgwO93RKJhGYEmnqfPOPHeru27xe3zv8o3F7F4MZv+mrxDZ2vqYuPgH5y4XAf08TugWlRvTuzHvVvblThQpmjNyiR3StYYvHpLoHNSiyQHiWuUppMYtslGM90i5dwTttaMkNdgBWKkvZLIsht3+eGm4mFFrfUx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNUTRHip; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNUTRHip"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso8223435e9.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784980536; x=1785585336; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jEbmruWYqErPnBJD+O0tZRV6HJqoLUy5/y+lHhbMWSc=;
        b=PNUTRHipaiKP31lQL0mUv5QVORGGWfwProNhO9uN9DAPw9B9k10BJ3UFmdL0MBVhhz
         D4fJwjia0fSbfTixXZ2hzFLy4yPANMUBmB4vt3ZMjyGU7lLQQaiEgT30LE+RRDPzYCWN
         MX5i1VCOKpdaov8I6VSTmNVnFUDs8Pz9zZDEjSfztPPVrLBfFaLrG6G15sq5VKnm+E9m
         QK4Jo2mNAqv5Ch1k5wH8iJRwRcO5UcJMOUDsM+3Jsvnt38enDIqszAKoQdUkcuzFdUF+
         0R0EovBgyUTlyKkcJ4ftPyFRICwVe7mqAFVy3U9OwhmqZGhyYuFms8xAq/a6AjTG40R5
         7I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784980536; x=1785585336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jEbmruWYqErPnBJD+O0tZRV6HJqoLUy5/y+lHhbMWSc=;
        b=AtxRsqkaejuJRya+u1D9e94a23co272iAmDsCyNVI9S3/q7gu76yKsINKJxvRTs/pj
         iTp9MpSTPvqh4VJb6HAn4cfsxaxiSgCxil9tzmiCUEmTQDaKp1l/tY7tFNvBCdo/BBVL
         0FuhXZLBiglg9MjI3aAyM1NV4xMAVsnBYsP1Dd7AUc0W0cWpXFx+WfynrH2Mr6Tjv4Bs
         9EZD+5a8Is9sD9mBZgpmZ1peb5dN85T+6r7UyefgCMy646w0d3pYju4uwstz6c0KYWt0
         JkILDvY7uFWsnGdTpRzEu6Zm6LvjHaIWx+sIhno3tjf87LWfJ61DqjmXvksrMIMkJ90C
         VZ7w==
X-Gm-Message-State: AOJu0YzprbFDKNhbw6kmS8kIhPq978TTz2YI3tlKB2O8wAtD3dlFDVQv
	SNF9oaBvMU1dLYQIqsO3pqX9ro4yr9MpddclYIkUtOhDGQwKuCEn0UNxVRaPqgYo
X-Gm-Gg: AR+sD12irrrTsRrCVUkzQhmuZ92UOhArl2E48XiVKwrgeyxAzXIdjePOCBtoWw0J9iV
	KdmoSeGldweKwvJMHihCFwjKOTN55RVIGv2XTyXD1jDkKm2cQs02f91fgr5gmE09jNhXEDGK+UG
	btTdkIDXaFM61qTzReobP4PQLoAWn/FGmzwadrTvop9Y0rK7ousL6rXL2yPx32oSrBPl5+ayOsY
	5DCvyDV9y1AGaZ03aZqjTjcA9iUOKr/A7ZkKroRq/vEAtWjgPvb8J/eO6avrk/Nv+615zmnCD5J
	jIe5IJ4zWbb+f8XoBOUOEUv01tMbU2qYPIdXRYgEWPcm8+qE7EWmBb161W6PPtcy3Lzpq+or+H2
	qE0tn7heZIPx4okvBrscIPf1GCteAr+ci4qabE3xPNe2BfxVypOO31HVgyq/rDhR6IGZsOuECMv
	CeUfc61aoIvd3LCGUqQumZJBiK/RdVjJWdo7FKAia3XmkTViMUy0yxfSJrPi0SMPErVpUm0+nso
	QJm8iAMGwg/tRSGgQ9X5QaLD0TTugmtpEDq62zvTnvKqkyncuxo5umZmcQ5XwHDIw/HWkVyKQzk
	wIXx5U6lMxRNg1ENuFoRLx60PJe9+ckzq2mpoOT1bb6PgaMVsjZu1Id+EKXvnPxVowlr4dqrD6y
	MxvGThUHOHDwPA9gCfY9kZAP3NUkHEN6HuS/igsuyocVOAN4FczS0VisXG93mzUf+97kCk/9mrA
	==
X-Received: by 2002:a05:600c:1d0d:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-496b56ffdecmr26539265e9.16.1784980535834;
        Sat, 25 Jul 2026 04:55:35 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (132.red-37-158-18.dynamicip.rima-tde.net. [37.158.18.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4858e86sm41700515e9.1.2026.07.25.04.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:55:35 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 25 Jul 2026 13:55:05 +0200
Subject: [PATCH GSoC 4/5] serve: advertise type capability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-objecttype-support-v1-4-2d4ca3bbabf1@gmail.com>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
In-Reply-To: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 Pablo Sabater <pabloosabaterr@gmail.com>
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
 t/t1017-cat-file-remote-object-info.sh | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

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
index 116862f9d0..175f778cc9 100755
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
+		echo $hello_type >expect &&
 		git cat-file --batch-command="%(objecttype)" >actual <<-EOF &&
 		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
 		EOF

-- 
2.54.0

