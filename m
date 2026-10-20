Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520363;
	b=5h6et+cohDJ7+Utk0LSfADFbIHJI8Qn60SMzwg0ADIkTZ3D62fVK07PEonS/3GJYJDxZ
	 a30DZSOgBJttKKDbq6gE2gth7f3W8/WtVPpcOanlFJJf+nPda5kQ8L+t9Lz01CvA6QxFj
	 0hWb7jpaPPhhOrRRUAs+OmI4hadu1jdvD6N/G+CEp3/cFDiKUncwfN1/ueyvNQCXFVvTu
	 MZQKoDl8QWZkitpo63YrWan9Nc15bFm2+q3QXWYKO/g58BynQHLVSYz7uwUQ9m8oIyjQ3
	 Oktx0qtFissZc41hdjuiLWa22DyZ1NgqlNgFhkh4fkLC6HgWhaHMcHPD4+BGf/nuu2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=l4mXMIyhyAxdZTpkt+z8VK3K9t1yW1ypuoZi1K7p/qQ=;
	b=rwHfDhVM5CHuBVHAcda9arFZGpSE0FqFSND0XXOy7YqpsTvgOxUADMQ/VEgh6u0zsOm8
	 bplQN/QUCPP7v6+vcVivLF74F87xrm3DGtJwTbdHXaijV0CIu66TzNsHHN08fNT8mJ4TU
	 Lz5G3VQ1cZEvCw0Raa0xa5+NiHgBghf2smtHtJ/RQkVly2ZFCf5JBg+brqv3mbZDoR1EX
	 uP/Y2wa54iakIENYxeMgqSF2NVgbk/1JPkY71bzXMLASUFda5WCnftUGEO6A7c0R0dO+2
	 xXKTfhguX54sCVgP3m10svh6tJY5DJGF/kjUBj0CGvf6S3fUcaZckD9dF0vhBtn5QFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="lv/RRnbc";
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA48606A321
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FA48606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lv/RRnbc
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-53dda625f63so2109749b6e.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 11:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520362; x=1793125162; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l4mXMIyhyAxdZTpkt+z8VK3K9t1yW1ypuoZi1K7p/qQ=;
        b=lv/RRnbcP2Tce/yEjXhg2cMj4MKsTvPJjYBdH6kGCTFdFw9sxa3sJa1NmpKiSvfpAX
         +5O+4ZXxDxt5cZgyh3iw2c42/4k3ZpWL3WxJOlWVQ0hduzuTmAae5AuM3/Jah6lTs5gz
         HVaJfs5AJ0AebXy6ULGiza2yywF3oP5MKVzNRkqLGKXWxyV+l3lOnwTsnQo4gB/2mTsQ
         ng/KkCWHgfOuoy9xaM2WZ4fWef+ksBJmNN1l2R43jmj5MFWMC11TU9kCiSfR8Tor70WL
         5yu2cymQDQPClNnipVFzRQ3wiVUTig4pCyU8YwloayFLoyJT95sau2i3TlC3I9kjRH8v
         3WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520362; x=1793125162;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l4mXMIyhyAxdZTpkt+z8VK3K9t1yW1ypuoZi1K7p/qQ=;
        b=UqVUAxUOA3trSIWULb80VBgEuaRYSZBZ6iQgj7KEN8zpOKBC+4/kODIkkga4pLba12
         dkKbI4Doy4fUrC+0WUGh0Uoj8iVo77qVGkeeYosjTikVhfEBs1sUpK/AD8QBrXwYXt2m
         cpWzlTalgCAA6j2ozvCgaN9QYH9yBJIMijo5PFkwUsEs8sSX+CKE+HfebsqO12NqohjL
         MGFpsljz32/V7Qo2Jl592yPu8aUO4oKC2X6WowvGvGo4FfSohSJtIgTfqopZ7Is6N+dA
         8+HCxPFADMXG2yR35LOplwL/kjaHZe9sVwrBooDjuyExgFkY9XrCp7+4yqCowBD2fzdh
         O/kg==
X-Gm-Message-State: AFq9FYKG6Ambr9Lb300BUESKujeFFiOufYPabGBErRUwYoXGf7MqBeUl
	lLdpPhqTaJ4Ae9giLPGM+5P42lKAfqows1tYmTwulvqLv5LVKhAWfuOhmeKTS1UX
X-Gm-Gg: AYBFou356DteZztuvoSVmjfIOILxpNCcGgZ3OjmL+L+wLIGAjziELtMG4cNRYGAmvL4
	Z7mpQ013MTcKGo/3xxacloXnPDLZqAnm6Us67GYseeoG1D2t28kuPPM3CFyrgaz/IH2CaECX3Y8
	C+sMnJ3LoYfHB8x/mOE7lBfheXVdOqdPB+q3LWFFgqwi7a7Mb9y0ydG1IlVJx1A1DB3nbyTnUUH
	PE3i+lFYrJLIqWK+d/rP6CaYr+iYfb0F2Uc+dVg6nRhdah2HBgqXUNzUk252luXb/p/VBknUo8K
	5JX7PlFoujkO0uy0o8CPW1GbWoxl+AlZqA5DeSoP9loEOWmYUW+E7DtyNAT3d1kqCf5OQpfIijL
	Skr/e8b7RKfdUebN0dcrmd6EOyBAppVGggPrehp+wT5vDqY6IgOZFG1yjfwpju2MczNOBNkTrI6
	6o7AFNW/FYYhZLgngw/286/ofspKPu2eRAuKNsiZ0XRGT6l9NZvSgYs0cuRCpP5XgFeGtz4yTe8
	Ro=
X-Received: by 2002:a05:6808:4f5e:b0:4e6:cc78:edc6 with SMTP id 5614622812f47-53ccf007d60mr9826321b6e.39.1792520361957;
        Tue, 20 Oct 2026 11:19:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.89.125.200])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b57486ebsm40248b6e.9.2026.10.20.11.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:19:19 -0700 (PDT)
Message-Id: <3db167c9d1449916d84f82151d68de9460512c3d.1792520353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
References: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 18:19:13 +0000
Subject: [PATCH 2/2] hook: accept .enabled and .parallel given without a value
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
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
    Patrick Steinhardt <ps@pks.im>,
    Emily Shaffer <nasamuffin@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

hook.<name>.enabled and hook.<name>.parallel are booleans, and
git-config(1) documents a boolean without a value as true. But
hook_config_lookup_all() rejects every hook.<name>.<key> that has no
value, so "git -c hook.lint.parallel hook run pre-commit" fails with
"missing value for 'hook.lint.parallel'", and so does a bare
"parallel" under [hook "lint"]. The same happens with .enabled, for a
hook as well as for an event.

Keep rejecting a missing value for the other keys. For .enabled and
.parallel, pass it to git_parse_maybe_bool(), which takes it as true.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 hook.c          |  3 ++-
 t/t1800-hook.sh | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 5e756cb353..c500fec33e 100644
--- a/hook.c
+++ b/hook.c
@@ -184,7 +184,8 @@ static int hook_config_lookup_all(const char *key, const char *value,
 		return 0;
 	}
 
-	if (!value)
+	/* .enabled and .parallel are bools, where a missing value means true */
+	if (!value && strcmp(subkey, "enabled") && strcmp(subkey, "parallel"))
 		return config_error_nonbool(key);
 
 	/* Extract name, ensuring it is null-terminated. */
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 27cb0eb01c..223c399ef0 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -516,6 +516,17 @@ test_expect_success 'globally disabled hook can be re-enabled locally' '
 	test_cmp expected actual
 '
 
+test_expect_success 'hook.<friendly-name>.enabled without a value means true' '
+	test_config_global hook.global-hook.event "test-hook" &&
+	test_config_global hook.global-hook.command "echo \"global-hook ran\"" &&
+	test_config_global hook.global-hook.enabled false &&
+
+	echo "global-hook ran" >expected &&
+	git -c hook.global-hook.enabled \
+		hook run --allow-unknown-hook-name test-hook 2>actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'configured hooks run before hookdir hook' '
 	setup_hookdir &&
 	test_config hook.first.event "pre-commit" &&
@@ -1080,6 +1091,17 @@ test_expect_success 'hook.jobs=-1 resolves to online_cpus()' '
 	test_grep "\"region_enter\".*\"hook\".*\"test-hook\".*\"max:$cpus\"" trace.txt
 '
 
+test_expect_success 'hook.<friendly-name>.parallel without a value means true' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "true" &&
+	test_config hook.jobs 2 &&
+
+	GIT_TRACE2_EVENT="$(pwd)/trace-parallel.txt" \
+		git -c hook.hook-1.parallel \
+		hook run --allow-unknown-hook-name test-hook >out 2>err &&
+	test_grep "\"region_enter\".*\"hook\".*\"test-hook\".*\"max:2\"" trace-parallel.txt
+'
+
 test_expect_success 'hook.<event>.jobs=-1 resolves to online_cpus()' '
 	test_config hook.hook-1.event test-hook &&
 	test_config hook.hook-1.command "true" &&
-- 
gitgitgadget
