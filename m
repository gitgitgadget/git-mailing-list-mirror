Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021135;
	b=WnRSXIiaviIfcauMVnIoKqAmComXBFX6t5SZz9NBvIS+2SVrFgJQRxLCIQab1FbKzOG1
	 MySicaMX8LWc9o4UAgTFRK5hN4XkTfEk+Szj3WlpdMag1EAZDxsBRXWKzLyRckim9z9BR
	 sBumf7tvAYp0UYNztuCN5e4X2HSmTHAdxuoBGOtey8Km3dWT6zP7tRywFMDMnVd0+sEUi
	 w1Vp7BiyUFkwnlMll0cAMbYtxBvGGdiXR3MyA1zO2+XvGXhMSfeGXwXUtcaHdtp4p1hat
	 FkeEH3ZNMQiIawKXC7jp7FllCv4uTsC8SQpqljW3l2EQQsie+9vZJAI001U2TwxInDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uReRclG9gbeQ+deik9baztfT/t1Mp06rDGlwcYnm494=;
	b=ZLDJG0qnoeYQ+3dUkJmNEwcgftTZxx5Rt74vfQ+nfIrwRrqHdsFeULZCpAwn8XJmVAf8
	 psaHZt56PafgGlRUtr2zIWVdblhTDfU7vWARHNnmV9shKFwGiW0yPUSFwIWAZ0SsrDbUD
	 krk4BVg6PgKzM9J2Ejzm1R4I2mG2+iw+0rorLd758tHg2ewa/tP1PiiovXsSdiUhF2Wmp
	 jExDt4nP4hDtCjE8SwrrbWH99oqOQtgv4XPIznLuh3kauTt0wqupKihBGI2DX8ksRFrnM
	 8xvjUWgjb4fqAorRU9QCQHZSUwKIHTgfFKIdz9CjO4cJL8fHiXE+aMT5Ez8jyA3Z4KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CnRQSJKD;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB0606A322
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0CB0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CnRQSJKD
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso19235885e9.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793021133; x=1793625933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uReRclG9gbeQ+deik9baztfT/t1Mp06rDGlwcYnm494=;
        b=CnRQSJKDccRzXezOHRugz51b6DA1lGCVUCfFbcq4of2S7/G15WeUU+bDQZZrEY3a+i
         AmQAibAIoTRHkDTyt35UGU/iPxo5qAj0lv3fC7qKnDrR4/BCaxxVpVALS/Z5/b5JZnGM
         OumKVg5N6ly736LbFjGd5/XyULYNXrMzj+3F54agkWVXp4oFFVJAg12DUb2JZDyCqHNg
         pW+qw76vjPsOSyGxxmT9Pi+nH5JcKaaSMq+5nUd/QxYoOFbKEQDviHly9PivrutseaWh
         Xon5x21qUk5ftXyR1jmIMp6rMnhqplPaNkZQCtmcJm59fUu7ylqsDOR5J9prFXzF0heV
         /gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021133; x=1793625933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uReRclG9gbeQ+deik9baztfT/t1Mp06rDGlwcYnm494=;
        b=v5QkFswuSltAif5XIvYaBP2qV1hiLrjeqWHKnymxOynsoVE5dP7bnH83W1VcPzToJZ
         SZ9eleigU7gHNky1tpFJfA8Kuodxs9FAq7XAEVAFzSSq/kgzNY6wE+Xcb5FvFXr958pQ
         iPZKQbGGbu9mq0bYr2ewQz8kr2RYL90QIbjX3zmQ/Wo4VQO7vID1YLdTOTMdLlM6QiYB
         vVq+2lhrVhv79wVd6gNLXlwZicmyj8daWcZoocmUA3+ZOwv9gle3w4Cmuyz+ftDadkaJ
         k7I8VgMiuClQFiU33F5Cg/ageFDirSuTLRxhCQ2+EYHFPyztNDuh/zg8n2w7ZTnmf76s
         MSfg==
X-Gm-Message-State: AFq9FYJGhW61+nJ6leySBAwruNRjHJxxiBM8xUlNuvlrleGeJ2KVeocJ
	/fFuU37S5gFnyWAH1StJK+v7Z0ssn+oKX8S/jYb0X8A999V+DF+ShzkIuq6XxWBcMQ==
X-Gm-Gg: AYBFou3I2KB6TTxcwB94rlDpPj2xttBuQ+mNk3qni51SgZRgNQ2kNXX8fgZd8nZpBSI
	MLFb5petlR0/tFyIIA1zhHVhW3RSC8OtOtLsLM3cdO690UGbyoylg+CFBJDAKqJNgOk8KnqsDCQ
	tUHCf62bmtLTPkGitOndtT+Jkj/rYSVqUl4lVineZ32g+oTE3S5gChgRMQyIvfb/SlZby5IwfI8
	a6cNRafty+wLSAtbUOzSbiFO/JV/JNACrlUK9XnP6gll7MuhKn+IeOei6nNczNEhrKyzKf+BqFa
	WuqxKjw2yrWaSO9OV30fXJW3A7EbE6vtgRxZMueL9Mr5+k6toNO8ZxorQFs0ZW7CJ1Nu3X4zbEk
	5Zl6/Zz62lue4sxnWs+jMj4DS8VXpFA7kWFpULPzsByAFydwq0JejFgAo9E3ZiSIswYWEsszThj
	qlNbPCgXWpNrK3z5wJZh49nImLlonLv2jPiam+oblBD1JHX4/zRI4jheQhtpoUagU2Bf8k5x8p/
	yrhSiZ4Vk6w/ql6eaHS1uARWOgcR16fXk58+rmwK6oqN2x9oInfpyVE/vvkGPmn0F4kB2g+29cR
	URXPePCEOgd49g9wUWv590eaVw==
X-Received: by 2002:a05:600c:a00c:b0:4a1:7d9b:d4ae with SMTP id 5b1f17b1804b1-4a35ac9d1b7mr121773825e9.5.1793021133065;
        Mon, 26 Oct 2026 06:25:33 -0700 (PDT)
Received: from localhost.localdomain ([129.0.101.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb8e0sm15915106f8f.29.2026.10.26.06.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:25:32 -0700 (PDT)
From: Fien Dora <fiendora5@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	phillip.wood123@gmail.com
Subject: [Outreachy PATCH] t1402: test --no-allow-onelevel option precedence
Date: Mon, 26 Oct 2026 14:25:25 +0100
Message-ID: <20261026132525.45414-1-fiendora5@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git allows later command-line options to override earlier ones.
Added tests to verify that --no-allow-onelevel overrides
--allow-onelevel and vice versa.

This ensures that the expected behavior is preserved if the
argument-parsing code changes in the future.

Signed-off-by: Fien Dora <fiendora5@gmail.com>
---
 t/t1402-check-ref-format.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 9dd64662b2..6036df0210 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -74,6 +74,8 @@ invalid_ref 'heads/foo*/bar*' --refspec-pattern
 ref='foo'
 invalid_ref "$ref"
 valid_ref "$ref" --allow-onelevel
+invalid_ref "$ref" '--allow-onelevel --no-allow-onelevel'
+valid_ref "$ref" '--no-allow-onelevel --allow-onelevel'
 invalid_ref "$ref" --refspec-pattern
 valid_ref "$ref" '--refspec-pattern --allow-onelevel'
 invalid_ref "$ref" --normalize
-- 
2.50.1 (Apple Git-155)

