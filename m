Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7DD429009
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890481; cv=none; b=urqfoolIp7awPytx5VRtHCsKH1GEV7Mau0uAhEAiIx2hrMnVd6UO0CfevxNyz4C/8GoBiHmaHtmWuezntMuZEKMBqs2srWrgDA6D9Wuj9QburuNl5no25WDU866Fs3JuC0+GyDnBhfrpmYUtf+eaHzHpiO0F70vR0W5I0f1xqHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890481; c=relaxed/simple;
	bh=N/GZEqZQagnA3ziQU3wxUG1qUpD7eJ9n4QtzlmzZVFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPy5WBqSoBILvmL4qDIQkIYd24yT+YujwURLbag3xzz2czlK1B9zwx1l6xysPzJu3G9NsviyF2HsUkn6Zl9ryJO1rszPTXoSiDJYa1T5qv35j6htS2wyLqMw0iDoz7IL0cVtMDEjIeDSX/dnQeAlshLnN9yJud/O+8MhE4KIyzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtXQmWkO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtXQmWkO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so2129535e9.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784890473; x=1785495273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nwfyweLB4c/VAp27bK4XZttL8/Wv2oEOK0DLBVaYDK8=;
        b=EtXQmWkOWvo85iNEYRAr5baFPUlSrjOjywLsZl6LVaNsbbws/Fxl70OWqCcblK48TY
         s7SOd331i/DOmKCmBOpvtMONsAWUuCtJ9mqnrT4IHYCW4Ds+3sEvuu0xPrnEq7qwBaYO
         M+nO40ttgyxF0kKXnJYxRYugEDN3g5l2+AGjJwosjecn5pL7yBgHi3xaWudJB0JnucFd
         mgpwFvBIs49W2ow1clh+goqV6rS9QLmQapE2S9DEaOnPAnwuuALuf6DWCkpuWJLTbUMV
         rKBK0Ucrhm+jCNgXnZ8dUlyMbhb/byzi3HREwnd++iCE+qy/FiY1dbaZLCHXMRHwm0xH
         vgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890473; x=1785495273;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nwfyweLB4c/VAp27bK4XZttL8/Wv2oEOK0DLBVaYDK8=;
        b=pzr90TaeRiFh8F8Z9mGc71KogKrrazLPPb7crqu3yk1WgDKVJe4pKLAw6yr6LFJuVY
         AOLv9HXFvEtTqcxcb+nKActgrtL96KMBzyf743wQWOmq9i0gpdQ0X4eOTlDmwBsr0neC
         3Jw30qKthksxa0rB227gtzCWQSrcy2ZORWPegKVQ73ZHzV3EWAknWeAbQMJCZkMK14jE
         2PJ23hDTl1WYOqOQ0cdFaKFY3nVtHGO3tLA/1cAWJv9+drWkewfuLh8xuBx0VumfvSqi
         4eP+Xo1YIf+yXaSdrANxgGsoTyzIq+46EQwsR3inlT5kzgXSbvgMPr6qNxMuPiDFzwxJ
         lBtw==
X-Gm-Message-State: AOJu0Yy/Jv1IcU5Bv3P9IrK/+yZhzUpVgHbHw3lSxLh3JlFtUliwNzNq
	xFm3tVpVTb/WfGvEIzWaP8QmXvI3PufSIbKDK5RquSgJWdBkdamytwwgtpGjQXds
X-Gm-Gg: AR+sD11TGSDTdUpHeI15Yojr97dyw4kpSZ9a0WiUsbUtcqPcm8EiE5ls2T+sm8TWSW4
	PyA7LPusWmV3LXCikwvbj3d0Pn8R9NlyVSXMQmGMGyQCRdb0c8kVZuN1iD2sxHsepySr0p9uZJr
	Y0p7KmO7u2c9NxuNB13dOejPG449at68g2yXr0dM+JoH9l4EoxcdInfUEEprAtskPnWvmglzuRW
	99c4JnkenVjk2dGbPc2OCImxEQoYefBREPH7x/dakQhm4uH2ylrKJOZEtT37Ux9aullLdGKgeMM
	xE9Xh0/6pCYyEG54guX5zUWSWepTbep7VGw2jz9GuJoYklX/njTugMbXiV9/R89BV3wtfKpsZYl
	GXYEWh5AKZoLxqx0RFBFbQB0B0Z43xNwO/04jJV43xAnyWjlLV21bxFq/fJ1NL/pAW8INvZmSuu
	qXq4p+lz8XXZULQ5anpBCubO+KNBUh8VfyFrhU/Vs95VL3Z7wXKLBhItZXVveJR8vUdXbIRXWVs
	kPXhGzfr4eyxZOcP/bJu8PtUrZfkmm7Tx25FFV/zN/T7hUUquMwcHth/e1oTXi3Rj74TGIS0thB
	F6lOjgAq2dZGArJqYZunVi3uYIJZNdFJ+YJM
X-Received: by 2002:a05:600c:6d90:b0:493:c8c6:4989 with SMTP id 5b1f17b1804b1-49573cc162amr52011365e9.6.1784890472588;
        Fri, 24 Jul 2026 03:54:32 -0700 (PDT)
Received: from localhost.localdomain ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm41797645e9.0.2026.07.24.03.54.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 03:54:32 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	szeder.dev@gmail.com,
	toon@iotcl.com
Subject: [PATCH GSoC v21 05/13] fetch-pack: use unsigned int for hash_algo variable
Date: Fri, 24 Jul 2026 12:54:16 +0200
Message-ID: <20260724-ps-eric-work-rebase-v21-5-ba67f024fdff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
References: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
 <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

hash_algo_by_name() returns unsigned int, but it is stored in
hash_algo variable as int. This goes unnoticed because of:

	DISABLE_SIGN_COMPARE_WARNINGS

On 'fetch-pack.c'

On a subsequent commit this function will be moved to 'connect.c' that
would notice this.

Change hash_algo variable type to match its return type, also make it
const because they are never modified.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 65ebfec09f..f1e64160fc 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1397,7 +1397,7 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	}
 
 	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
+		const unsigned int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
 			die(_("mismatched algorithms: client %s; server %s"),
 			    the_hash_algo->name, hash_name);

-- 
2.54.0
