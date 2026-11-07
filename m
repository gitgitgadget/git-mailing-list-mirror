Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040978;
	b=JgtHXTxzf8WFGKA1S5YQ95nKa8z9MNwnnXFBIOw54G8km+vutz03vaIKu/Zm3LD+cGDo
	 6xK+yKCWDi2iQOdFloVgjFPPvAHyuUkOrQJEdwK35lRtxrTIvbQt3kRIDuUNsTV0Juxya
	 4euV2PAJwjkvSKCIyNaBIKGjMmH9t6eGb4GTOEEgihBcW/r4S4i/O881Wy2/aPs7eMeMF
	 GoKb/DUI6dMRS+7Ks611laCPsEH/OJs3CFKSehnn/yPUN+2hify/AcXDumpW/n+LmKtRx
	 AFw09WhpAZg5PTl+3TTXtfZd1WmbunvBicVBdpGH+zZuB91dk6DafNPfs8b3eVyVLuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=UqgeZ8MpgIwQ2IVyGU2W8sN9gFZV8tYaYaah+tA2zUM=;
	b=uXQ5Ewkv1VXRsC9T3Lku3VIoFejmqRp/xdEzx5Kj3uaX+GmK4sQQ+ks7VYfBbBi9ll0w
	 XhlenGkOFLywDMjWyHAOd9UqEtiXGXQ20yRwzdx6cfO58nKThaTrDxexdB59BLy/0Q5EC
	 bB1/CkhPQUkeIXPkBppI+TpU82uBHPeHqC/9LV+CK87DXKkc4pBO1XTmU6msJpubsiewu
	 jV+gs1dVzo8kNbWT6kliXLb+hvi0lkgtY2zi7vRshVRw37pRiPqLUWKHcqsGIAYjDw/R/
	 LOAtIXbSzvQXbNvnbs+2dRVptP1y/DLWGGpmFvAw7iSO/VLv6rGyQXx6+XU8m8W6sxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDvAL6ix;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7462606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7462606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDvAL6ix
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso196990a91.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040977; x=1794645777; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UqgeZ8MpgIwQ2IVyGU2W8sN9gFZV8tYaYaah+tA2zUM=;
        b=IDvAL6ixutapX6sHDCWjHNP2STv/4zuVhWdJBJQ9+Y9nseyLEymFk01Lnv4/kb5HYz
         za3w0f6tzWaBxBYXGBPNHCRx5Q8vgs0m9shFwAiy2VVvyNXbY6cHiWb03JUu2I2Ak/tY
         N0zgKo0QMHkCtczxnKVshdPpb4NOy0K2Zo4FCXjAA+qAabC0jcb2v1XgQFzAksJXzS0y
         270EZ90Hoq46k0rP2SUzF1FCxzkIX/ouAHcNKMLW90OmQiLNm8D8poE4QkLqhsPU5J+V
         RkeAucu+c9m12Muet70fAxiOSVXofX7W73mTWNtJp9+MM3PCTQKRcZScFA978DK3XrsK
         0U6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040977; x=1794645777;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UqgeZ8MpgIwQ2IVyGU2W8sN9gFZV8tYaYaah+tA2zUM=;
        b=OWyatgOdYwunMC2MmqKuelwQVc+zUoQYuCer4lI6N7YYd6gVhi0+MqCErOwxTLXEZ0
         cXNaeiko3zjh+fADRuwR41iZDietcFhDIyPsqfOV1JdEuyAVDmIf/Zm4ce+zlV6SH1pJ
         AS0FZ1bl65Ddw6FhtsRp2UDDlHVftYVT6TiEeL2RG157+2mBc8ancGAkMe1C2tbo4H8i
         94JcY/21H2YmjIwQ37uSbei9ay6MQsBiyLVLZECiWtVXjNSoXf1Pz3vSM5lMcrB23e/U
         pvh42Nj3Jy4ydF9yf8D+tPGrXeJ2H9XVIDw0CDu140qftJHjZYmvPUjKEJifm9PowCmL
         m/Aw==
X-Gm-Message-State: APuU4Z9fjXbEBrNBvomHDlG3378/PLo8KI7bOr8dztcVREvsj6uGZ0S+
	DADKbXzdWVGKK6Fj6hkCUqz6VNB4TxZI9AIxomMkotuqI2PHj/RNoOLtddeu+k09
X-Gm-Gg: AYBFou37ptMvq9dWHP/ZWbr6g3trCDbWkaDBn7EEz0D9SGrWQdO4xNYsDxTru/Q7tSO
	GZPEWapGNDjtK4u7704bdcvur5KagUAw4dnOHyAvS4GKYz/Zket64iGdd2inl8eAfNMd9q6o7ei
	xhJo7f3fg6L838gbSv2wOLBlQprqzlIn3Wkv78leW6ro249EKFM+OPTqW8eJS+KkeIp8yNSASP0
	Hb0FftOccNo6Df7lnLzTbW/DGno6DyHLTQUq5465OvltVT6OhZxIZq710E2OS6Pw+9E2/A8jRA4
	I27KotAOOiZVqP0XItiBCq8zVqOHxvg139iCldnwWtSesVKWkP91foswR3fuKG/cOjHHYGcIKV6
	2s+Q17UVWwTuIHlPwt+NBwPEEFyW4XlUS3CbsSIDKiT4NDnO6cSp7n8QwMab8ez7HnmAulErKVS
	CwMIUbf8DMJUTUXspUpjwQyB7x2pIYEHCbtLaVRPNw1uy3C8DBhUdK/Zk62Voks7WtlddadYv+K
	595soWcAAoUf0BvB0GJfldb1RMYWM/7nBto/e+UMmhF8e1WqwOVXCiFhXYzDckxDIs8725TK5Oc
	sXnbUgK7f43a9zXmZ/XpERiJGwjB3Hr3EQ==
X-Received: by 2002:a17:90b:3e8a:b0:3ab:d26b:c2df with SMTP id 98e67ed59e1d1-3b106365f2amr969326a91.27.1794040977320;
        Sat, 07 Nov 2026 00:42:57 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101e3e513sm1599988a91.4.2026.11.07.00.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:42:56 -0800 (PST)
Message-Id: <4eb7085084b880f90705799d523ab554fd1cabd3.1794040968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:36 +0000
Subject: [PATCH 04/15] bundle-uri: handle NULL value for
 fetch.bundleCreationToken
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A fetch.bundleCreationToken without a value makes "git fetch" and
"git clone --bundle-uri" segfault when the bundle list uses the
creationToken heuristic: fetch_bundles_by_token() passes the NULL
value to sscanf().

The function already treats a token that does not parse as 0, as if
no bundles had been fetched before, so it downloads them and then
stores the new token. Treat a missing value the same way.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 bundle-uri.c                |  3 ++-
 t/t5558-clone-bundle-uri.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 2bb2eb99e4..7de17634cf 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -572,7 +572,8 @@ static int fetch_bundles_by_token(struct repository *r,
 	if (!repo_config_get_value(r,
 				   "fetch.bundlecreationtoken",
 				   &creationTokenStr)) {
-		if (sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) != 1)
+		if (!creationTokenStr ||
+		    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) != 1)
 			maxCreationToken = 0;
 		if (bundles.items[0]->creationToken <= maxCreationToken) {
 			free(bundles.items);
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index f81f1f8db7..e86ed7d30c 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -346,6 +346,26 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
 	test_grep ! "refs/bundles/heads/" refs
 '
 
+test_expect_success 'fetch treats fetch.bundleCreationToken without a value as 0' '
+	test_when_finished "rm -rf token-without-value" &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+		creationToken = 1
+	EOF
+
+	git clone --no-local clone-from token-without-value &&
+	git -C token-without-value \
+		-c fetch.bundleURI="file://$(pwd)/bundle-list" \
+		-c fetch.bundleCreationToken fetch origin &&
+	test_cmp_config -C token-without-value 1 fetch.bundlecreationtoken
+'
+
 test_expect_success 'negotiation: bundle with part of wanted commits' '
 	test_when_finished "rm -f trace*.txt" &&
 	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
-- 
gitgitgadget

