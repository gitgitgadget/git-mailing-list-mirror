Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040981;
	b=NXHMRiyRvU5vjfR8OZb/RpiKs3WWrPE92aauGHm2Qchn7YvlnYR7lkv5oR0OB1G+/oW9
	 OOxN/kTENOF2xH0OeO5rNNuuhJ9XFNq5MWzsMx/N6uI8rMT2YgdOy9gVF4QjHBv4FaBVL
	 xo/DFS9NPhNRuNemUWFuuNONqJZRFNG2VEopFi0NJA4FFe96aFyTiJHQ+D+Qa2Xy92ye1
	 RoF9pkfOF0z8yWyOMiZIfK0ysOEjuW8z5H4yKEa4n4vxxgS27BBNtyjybF1LGM8XGKmUD
	 1kwyJ52M6AoNcAMZ6PLX79QSujUa8l4xZTlBcSG+FX49tAhhUmBuIZCvGWgw1iBqV4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=LbJB5CdXxSfUgwirvRb4pFA5dgDSTCKJGZuFQm4GrWQ=;
	b=y9r0UMr4dgJEVpM0Wz9SZV/vlK14D5RemSpBpD7fLrFse6sxs2bB9lbVNHCzGszQ3Kck
	 zAs/ESWuebkmqk2DPX48W+hPWKHVPpIUUDuaPTQ9GkxjiEoD/Z5AYgGw8xBp58evoL0o/
	 qcRvNQANMprqGu7v+yRKly7RhFn+9hoidLOQbUlDus+t/DZF0r8KcNEDn+Kz5eZv0cnVd
	 23+gsjTChCejcOOQ/0scmwrMB4Yq+qco0bRiQQipKekTP2GOhzLKDzAmM3wWUTsSrK6kh
	 YyBPJx3gdTh3HLXGfctrWdpd80My8fALEiKuJxCKWkEfUGf8XB7TznmoIu2Fuelcecw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOVzAwTB;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7C3606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B7C3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOVzAwTB
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ed0e2015aaso5553315ad.3
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040980; x=1794645780; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LbJB5CdXxSfUgwirvRb4pFA5dgDSTCKJGZuFQm4GrWQ=;
        b=gOVzAwTBWSBYIpfVti7idUp2PEYzWr1uono0f/O/l+K5QT5BNe6itj+pIN8y5wVLmA
         0nPL58nwxfqkvzS2a9aXZlnfvGSHgMb4In5aZB2hHZljMvz7skN31LqrgNnxJMrCxorn
         AIl9ryK784dxiIAVkwEWdiNGnr/gyquMF0d9TgyjPGvqnUP4oW+2ZXt0J0paBquH0iL0
         TJxu/INtbtyunzjMmZCscS8qDMmbj8qrwW5FvjX4dDjRAsYMuTQZq2lbYxXO7Dz7Z3z8
         lUz+JCJpVBrBAXhQnK//B2IWYHztiWQJNB703EcqPh+WW6fjXcHrBcNZuPYQ+EHp4ALW
         MCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040980; x=1794645780;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LbJB5CdXxSfUgwirvRb4pFA5dgDSTCKJGZuFQm4GrWQ=;
        b=0dsK8Ukd8ITozBlmTGAXkjopnuoPUeEdIU04CsA8xvCx6Ik+nGANOhufQwqqa26awM
         zqIh634kxt9TUgMH9F2cf6965iVh1ntU+Z4XH47gjzXSIYxyw40uWZI+BKpJeUAFMMRH
         +js8XFYNKtsoEeBPwWIzZXv7G2TY2BsVWTqDx8Mjg3LaNsHfU/UofNrd0uEzfMLfwNCK
         YJy2YBvU8vge2Cy7CR946cgkJuMxmvKsqkCM46HoLXIRS7z+s4J50rP+RF+ZzFZrSAAU
         HUUJmxntQY3qnSaZkU6lSMfye7g1SVb8XdKQO+hDm0DwzRnnCIlr9N8rD0ZTT0g2LBSZ
         E6bA==
X-Gm-Message-State: APuU4Z8HUSaQ3ovnizlDWa6FziiJoZAGk8ScozFKg+e/hL91iJUPiAbX
	fwUP+YkxVX5jndcTMfnQG0CCCmWp16SoeIV992yFepbbhokHYXPFgRnV+Q+FhOPO
X-Gm-Gg: AYBFou2GaxFZT5LCWlfnxZiCVwTRBkoj5ylYGfmadD1eA5iAhwzc2s2eNu3qjY87UKl
	WAJQR4dKJlSmuakcTy24UmgL7DNXZq/s6MorV0FBcrcaQ5g7jvEa9XQZ6LCjY50jb5PMLzeFPB9
	pKDsKJ8bt33Hu65R4v62OIUD9TxFsmmpiA6//wmXlxWVQ4/jCjUUT9wQKmBmTfMEIfkCjhf9WDc
	IeXhsHvoltDAaAJG/KH0J1qpmD3sezWiUnfP3fBaq7ZIoZ34uc56oA44sGRaIp2bBZl5R8FxEqC
	mRa/2VtiJAVsPhL/xvACzrMGbOGJ86u6njhMsmwgHIEYmU2lqaiVqBOYuAwyInWiZ2ZognP2rMA
	/JP88MJbrKRy42RWCZZL1P2E8yFVckBIDW2C3PP3I+t5tz6Va2BaU50qyStyvcThx+k18PeYunj
	mCT2f71An6N/ehy9GBppLanUIXrLly1ODNKjm6seJrTqUg9rkW6Oq1gu+4pBhSuuIV3sJp+FZJr
	jteZdx6uvMyB1/0N0Vtxpzk2aaHc/72dtEispye8XPPJ/bO3U6qtbsQ8V4cg7jKnt4ATpM9qFa2
	mrr4d7z9hFZ/G1us/h47cMNjgZebs1WPnA==
X-Received: by 2002:a17:90b:2645:b0:3b0:accf:5c66 with SMTP id 98e67ed59e1d1-3b0db721fcemr4407427a91.49.1794040980401;
        Sat, 07 Nov 2026 00:43:00 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a7fbcbsm1265457a12.25.2026.11.07.00.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:42:59 -0800 (PST)
Message-Id: <e95249fb51b681b9d9db3bfb3368e1b3257337fd.1794040968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:38 +0000
Subject: [PATCH 06/15] remote: handle NULL value for remote.<name>.tagOpt
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

A remote.<name>.tagOpt without a value makes "git fetch",
"git remote" and "git status" segfault: handle_config() passes the
NULL value to strcmp().

Reject a missing value with config_error_nonbool(), as handle_config()
already does for remote.<name>.url and remote.<name>.pushurl.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 remote.c          | 2 ++
 t/t5505-remote.sh | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/remote.c b/remote.c
index 71170f36a9..024cfc547d 100644
--- a/remote.c
+++ b/remote.c
@@ -556,6 +556,8 @@ static int handle_config(const char *key, const char *value,
 		else
 			error(_("more than one uploadpack given, using the first"));
 	} else if (!strcmp(subkey, "tagopt")) {
+		if (!value)
+			return config_error_nonbool(key);
 		if (!strcmp(value, "--no-tags"))
 			remote->fetch_tags = -1;
 		else if (!strcmp(value, "--tags"))
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5fbfcb0848..bec2e51afa 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -90,6 +90,11 @@ test_expect_success 'remote information for the origin' '
 	)
 '
 
+test_expect_success 'tagOpt needs a value' '
+	test_must_fail git -C test -c remote.origin.tagOpt remote 2>err &&
+	test_grep "missing value for .remote.origin.tagopt." err
+'
+
 test_expect_success 'add another remote' '
 	(
 		cd test &&
-- 
gitgitgadget

