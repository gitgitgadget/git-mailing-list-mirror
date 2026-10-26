Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010025;
	b=veBgUsGtbIajvvqBUq0x14Duqe6vWVawtDpfKtuVMdxKd3pywsh6RbBCekUY8TQ42YJv
	 LB4NkVofemdazPhwCGe3qpvh3WedPI918EXtwKqx684mAw8bgnvzu8s41BZiQs2Goq5oh
	 Z5q/Neah5678MjnpRfz1N3Bx47/qfEQ7+VyTFXZ5ySkLFWH7BMRoI5mjydG0imwx6CXP4
	 ZCQfOIFT+iGjcKSx+5n6obH/o3Y800/CbUXJX+7YURn0RYxsXr8xjbyTKw3R3yR4BFURt
	 L2Ydtf1yKcMftKDpQaIypbHzSQUAJ9jmCdXBKYmz3xUn6/cfhUslUJbVy4PCEUt5O4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jxzN7Vjz69wEgDTIef0JUEUgTLgUWlFgUp67WuxdvhA=;
	b=YD13ZWq+wpe6dP8J8pKbJxny44XLJRAp3A6V2T2J6V/rQfe2QSlc7mKieX8asCD6g6XY
	 T1Y9lF1+I19FUxweN8GGOBQmtBc8NbqJSrNKxan1WjRulCmz3AQg7odAB+EzU3c9m2nlA
	 5/uXTAGLe7DB9Hp9OZkW56jair804eCRXO9+vSgI7TvzbHYnH2xWsR1SYep7RMmt5aRC3
	 jiJddIXga6HuliUT76JT2BVc4X711WNG6AxJOMwV3xVCCJzxTKQnW2vI3eeglLFOdqksh
	 rjvlerfaWceymKU0T1yzfYBIaEO1tVB2nXP7luKivVZjCoi0rVhxF3aH770aFFypZgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BkvqxOpX;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF3F606A334
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BF3F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BkvqxOpX
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so4882155e9.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793010023; x=1793614823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jxzN7Vjz69wEgDTIef0JUEUgTLgUWlFgUp67WuxdvhA=;
        b=BkvqxOpXge7lruihdyrA0E/jDKWvCO1xdFS/iP8erlx6FTH+TiHBRrgFYJ3IF/hluN
         F116CiujcVvnPP6lwgpDtvy/eNLHptoDZAu0wF9Ine93Thlx804tzzpBG7iF1zFKJhxO
         WxVosU4zL8Nx3TnEJZN9/rqylE9yZPJnC9p9jIAyn3tchFXBxCvueSPu1IHP/eZ4IZwc
         M1LnDHHsiOLRInPEou/dM9LLvKPZycdXPViNsY90dmkHNHfyjRCAdU7XzTI40xOhmfar
         L59KYrwc3PGxRBHPjpgwaBD8hijEIpCBDb1BDfIN/k945ZRcxpQWun+ADEz/xj7s4fd5
         QmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010023; x=1793614823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jxzN7Vjz69wEgDTIef0JUEUgTLgUWlFgUp67WuxdvhA=;
        b=ywP0WmvGGCyXyZShd9ce1nyYJLca8t1Y3SvgRH2FmRrY1nXlOiL/hqOOG9WKKAIBsI
         ZsWj16dAaOM98qkJS/Kg7BxMokLKKs9dMprpiYOH8KHBHl6JsWq6yqrh+yBpqQF2R7m3
         /papyzwJhCMCDuBfj2rt0j+v1LnEnC30ZQxNAHtavPz5VcmMi69o2cMumH2fQ9SqnJ2s
         3HM80WMUnuUyZFn07aKhPS/RDTV3x3RpHiivHEER/Qg8Fwi3yMKf9MleHkq6DZIqWCFb
         c3587QzqHQnYnfFCXUGsDJ1v8DMOONC7KJBuyybLdpeO+wKo2+1uBB/Hbpt+e8hMcfA7
         VqhA==
X-Gm-Message-State: AFq9FYLXqLQPL83KT4ZRKeB7xZOnQM2ylyDdKFRoL55LrtpBoNCk7Hw7
	VpCVWteyZKJrvd+Pdsli8DoFwfNPb5tn9V6RICyOfARwe7JNKjGjryFr2TzBwTSK
X-Gm-Gg: AYBFou0X1Oj9JuPQKLoicS7JxWDBUB30crXE6QV5OS6CdUTvPncMRTzRmm1Pj2d7emG
	hU1c8USgsD3BZl5+7KkO6FzQ7EPRAX/5JSy47OaQCsPgmKTAAymop4KYHrbS1jSYKqlSEXbAcwc
	0ugqFXnicwobWKtN4mdLlJc7Ve6J6Yik2VXEsWymwsE48xt3eKfQcNbMlOpaJb4fQTWz7VzO1UY
	a0+b0sGcnEmCiZF0heQNSgx95xGRNS8giqEZ4jUj/aoTGEnSdtnk/YQZNtt8aj0fSmejQGQpfG3
	QRhS3JxO+4WkHA2pQrFSxfruru/HsWI9Ll2yI7+nW7O8hVBncBS0b66I6nJk+IIIcyQE3n4dE3L
	bxUEbSAj+JLQDMEb01ANnZyyGpZ2rOTve+hf+8zeR2I70vZN3M0/TKGhoMzxcdHo6i9TrUPK4ib
	q78pCb2RntdNgvvpW8148foykvx84o/X40+UAfXEu7/I7WHR1dyLTKezNyK37JArsGYPD2nGWIJ
	xYRHKmcBvtfK1tIzPD2l+S+aKVZx9cciJFrQe2+2qj7JcQ8MMOr8xWKKA==
X-Received: by 2002:a05:600c:6749:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4a35ad01261mr106641335e9.2.1793010023241;
        Mon, 26 Oct 2026 03:20:23 -0700 (PDT)
Received: from debian ([102.89.45.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d6f6fsm179599585e9.12.2026.10.26.03.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:20:22 -0700 (PDT)
From: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
To: git@vger.kernel.org
Cc: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>,
	Christian Couder <christian.cogituder@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: [PATCH] t5300: modernize test path checks in t5300
Date: Mon, 26 Oct 2026 06:20:13 -0400
Message-ID: <20261026102017.2689-1-ogundipesolataiwo12@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f6092.dirty
In-Reply-To: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
References: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
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

This commit improves test t5300-pack-object by converting old-style
path checks to use the `test_path_is_file` helper function.

Signed-off-by: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
---
 t/t5300-pack-object.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index aac139e6a0..e5ce478484 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -283,11 +283,11 @@ test_expect_success 'survive missing objects/pack directory' '
 		GOP=.git/objects/pack &&
 		rm -fr $GOP &&
 		git index-pack --stdin --keep=test <../test-3-${packname_3}.pack &&
-		test -f $GOP/pack-${packname_3}.pack &&
+		test_path_is_file $GOP/pack-${packname_3}.pack &&
 		cmp $GOP/pack-${packname_3}.pack ../test-3-${packname_3}.pack &&
-		test -f $GOP/pack-${packname_3}.idx &&
+		test_path_is_file $GOP/pack-${packname_3}.idx &&
 		cmp $GOP/pack-${packname_3}.idx ../test-3-${packname_3}.idx &&
-		test -f $GOP/pack-${packname_3}.keep
+		test_path_is_file $GOP/pack-${packname_3}.keep
 	)
 '

@@ -376,7 +376,7 @@ test_expect_success 'build pack index for an existing pack' '
 	rm -f test-4.keep &&
 	git index-pack --keep=why test-4.pack &&
 	cmp test-1-${packname_1}.idx test-4.idx &&
-	test -f test-4.keep &&
+	test_path_is_file test-4.keep &&

 	:
 '
@@ -616,7 +616,7 @@ test_expect_success 'setup: fake a SHA1 hash collision' '
 		cd corrupt &&
 		long_a=$(git hash-object -w ../a | sed -e "s!^..!&/!") &&
 		long_b=$(git hash-object -w ../b | sed -e "s!^..!&/!") &&
-		test -f	.git/objects/$long_b &&
+		test_path_is_file .git/objects/$long_b &&
 		cp -f	.git/objects/$long_a \
 			.git/objects/$long_b
 	)
--
2.56.0.116.g6de20f6092.dirty

