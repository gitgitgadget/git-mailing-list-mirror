Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795297599;
	b=JFVTKCIK/UylvejixUxUTpEFk1bcmFxhezvQu8qSLFh3EQivMBYYwYi/H43OAXpM5+hm
	 TTf/almvUSISshgrpFJXoyyxAnXduM8+bmRtcBOG3AUaPwmS5jPC6B9MqdbhCkxivglAs
	 EpDeKuXsmfEpMcF7hV0K391IEdsZfone3hkdYPv/8wqQj011p/+0BcXeOPmIqr1hrZoJh
	 kZJLfUcQvtz4/gdbaChEVg4GC7plmrFKpjIanRy634B3uuWSOhZPunNPUZDoa1LOaseXN
	 uh4LVr8h8hMiqCur5FE7UVPc9nblEfaltRmuHdDRVsuDm6Bt4LK04cL3IQOAmgB22+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795297599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OkOpLiWIL6D/OT4dzC728Wk7NGcIcqe4uyqjMjpCTIw=;
	b=FIJc5+ZgYX5ksCGENwXZ232LAopkc1h36hwUi30vg5hAxAbVnl6hA2jsQPZ4BP6noq4j
	 rOpdpRU20fCMo3RImadnYJh+4/nJOKdu25V/kvGnHfpn6BgF98MEEQet2FKzpRwwM/tmP
	 qepyU/QL4Ig7TZb8Q5yJQq+xfN6MeCe+9a9j2Pwp3oLYBxhDXf30ANrYXEkXKFMFnGMH/
	 jfoVx3wIl9FpdQygk1gy7oLd6Mw1g7tpNV5UaOI/jBVEnxxRMgSWniwhQcX7RcJvpApYp
	 yX19RT5Ucam2eciyFEdt+1nOoCSiogiM4QTQTMxEzo1ZdXF97mVdvvhmYG8mVU+jvAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fXJqUfSv;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296BD606A336
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 21:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 296BD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fXJqUfSv
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so15404165e9.3
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 13:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795297597; x=1795902397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OkOpLiWIL6D/OT4dzC728Wk7NGcIcqe4uyqjMjpCTIw=;
        b=fXJqUfSv4HFzANbL+rYK/viUAU0prkvSBYX7qZg8qG4a+Z+Z10bh/PahuvzVwfU4WH
         HUvL3txWSQYV3euf1/J22XOb2fpZMfWY5zpPGrg3FIe6LbBD/Z3qD2cQs+Wa9oZcHlKF
         pGqN7GMti8jcyDZ0BfoaEPmRAvfX7R6KrXLNRmS5++2lj+7qgW0ktjdNLOItrRgl1hOd
         TyvpgsXtX+9UMTpSQGhui7DnvqSc9rW4FyY0/B9Yor8kSORauiXow7PFPEX513YvRzK1
         XNg4kERZOmuBshzJBEniZdbi9IO4c+K7OSo7FSc8HVkdHK1TI+Vxf6G7eEP6amEHumu/
         KbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795297597; x=1795902397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OkOpLiWIL6D/OT4dzC728Wk7NGcIcqe4uyqjMjpCTIw=;
        b=KSaqeqkMOz+0SLTp5rV14wqSFglqd01Dwr+ojsvNw/YBCnCtCysHMNmkD7po/HuLUm
         KekIAUPN4s/1FZ62162aGN+/9vgju8Fpsl4BU3LAQU2DfQQUUfH80XpyeeTxskPCvs0P
         JD1l3z8oUuJNarLvijqORHfTguZh8pqr+XeAGPgjCNe6Vyu6JqIOS8lgXC/J4YPBGGWO
         rLwwX6cvoGUVuZroQUfc8L0qRxIEEdX74vxkzznFyfjxtTUlToXTOfDNvwtQUC1NUnxn
         KQ4MuCdpg8a3eAZaUFUC8Qn1bEe3nQuZZKkthUs+47yIXHtxY1USF8wFLrJ0FEpHV9Xp
         ooMw==
X-Gm-Message-State: APuU4Z8RGJjHAQaRBCVe9ITYdfFBiRHNDlFeUHu7WlpPLUYyyae14LKO
	cnO44aUrQPURMZsWY/N/ngWAIVTAhqHihJMng02hjViXYfkNshYJbeSnEss9iHrZ
X-Gm-Gg: AZFdTZdyn9FjQ9q8vdTArrPCaf8s0oOQQ4WLsxzYZlJX8G/HKUabO+9F0XsKd0T3T22
	JsFMCf+YG0D/bv5Qln2LHiuC2l9JXCpxe2XO7JQoy/8xb+K21x5Vjf+M19HLJ4HUIXl37Y0GIRq
	AHk12wUdoZQoiFYKTE2raNaPiBpvQZBcXASAO3ADI0lqs6a87iJcBu7tIbHgVtO2kgfzmtKiMem
	uR1ljrhqyPJQ2ccphAuShEOYXgNPV+WzgMx0xjKfrGoMm+YU+bwdUklsWAJTw75AUtM6hhCFX3K
	BryFcuNaccKcnGWH8qVOFIPW99yEvBazdAf0BunPUsGcrUvC/szh2msFBEk59I05aIhrnVmYo8v
	OUyborVfX9Sf7CgKahT4izDM0xlhUXlPQPBdiDSCbbbLsWhOdpHyRxzdi52PeKIL5nBEEBXliWa
	5LiEIu9wEtKmLh3LK5wHMK9UAuT9MTpaiXL3pajqkTWwQAm/iU/xXWvtB4Ryjc+ZKlW1FZ/xAFu
	46nl8NH6KElHQeZjA0NMmN4ciADQ+6vVmLRqR00BmGmcPVswPKlehZPbbLBQBYQsZ7LYB4nVp4S
	zPTW1ICgLOhd7WG4jTF9q/TRvO1wDFDv5C17hZej9QlMxlxxKuZ50HLdzwnpLgVHQCACpDi9tZ4
	wHORw8gEMOm10phOShMCXTVVDGMIC20qr6rU5V04aJuKFBZw=
X-Received: by 2002:a05:600c:828e:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4bb88785a99mr150587825e9.0.1795297597563;
        Sat, 21 Nov 2026 13:46:37 -0800 (PST)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net ([131.189.143.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm211800125e9.15.2026.11.21.13.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:46:35 -0800 (PST)
From: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 1/2] fetch: test that --force clobbers a changed tag
Date: Sat, 21 Nov 2026 21:46:32 +0000
Message-ID: <20261121214633.1523706-2-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121214633.1523706-1-orgads@gmail.com>
References: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
 <20261121214633.1523706-1-orgads@gmail.com>
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

Changed tags can be force-fetched with a "+" refspec or with --force,
but only the refspec was tested. The test also didn't check that the
tag was actually updated, only that fetch succeeded.

Add the --force case, and check the tag after each forced fetch.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 t/t5516-fetch-push.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2f46ddc9ba..68e0e2de27 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1160,6 +1160,12 @@ test_force_push_tag () {
 test_force_push_tag "lightweight tag" "-f"
 test_force_push_tag "annotated tag" "-f -a -m'tag message'"
 
+check_child1_tag () {
+	git rev-parse testTag >expect &&
+	git -C ../child1 rev-parse testTag >actual &&
+	test_cmp expect actual
+}
+
 test_force_fetch_tag () {
 	tag_type_description=$1
 	tag_args=$2
@@ -1177,7 +1183,12 @@ test_force_fetch_tag () {
 			git commit -m 'file1' &&
 			git tag $tag_args testTag &&
 			test_must_fail git -C ../child1 fetch origin tag testTag &&
-			git -C ../child1 fetch origin '+refs/tags/*:refs/tags/*'
+			git -C ../child1 fetch origin '+refs/tags/*:refs/tags/*' &&
+			check_child1_tag &&
+			git tag $tag_args testTag HEAD^ &&
+			test_must_fail git -C ../child1 fetch origin tag testTag &&
+			git -C ../child1 fetch --force origin tag testTag &&
+			check_child1_tag
 		)
 	"
 }
-- 
2.53.0

