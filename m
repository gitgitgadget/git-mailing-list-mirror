Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580134;
	b=nae3qDk7tqH+4HW/P53vziu2ZIk+hFTJ86JSrVF2M9yHLiTCyYIRWvNYV5dPjaeNUii6
	 qrcUMbMBXOPsq+0u7Cvzb9zFTefQc+03x7pygudr99iUXFEz4fmbQvUOO1p9l6IheO3Re
	 38kKsbdljOvndQUj/BMFOnbpIxEq3Z8i0Uqw6yBBZ12K4kXkpi1P4VVX+eWvuki49qzho
	 S7Ku7m8whTlgMk4kZAtYl0ObWQUpxDyHeR/vmtFSXi9A3kwl5goSh7u672McWBKmoaHdr
	 z753kGac8yTjUlmatPGczLkWmvyYA1/sZZf0VlejIRjo3DxYMu7hjkLOgT/VrBhCifg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WgvVB0BventMA44qkTZomkF4CYy5OC6Sjw91Zj/HK7k=;
	b=42FrJVxzOYMjFIelBsSEwaXhQC29crykLKG86rZZXwgQVHwLceL4FPsTOCaAhPB1rs5K
	 hEaWZb8NMbHMxVCK8V5bWvldS+04FTuO/0yTPrlFT3buJntxYIkFn4Il6VzGhEwVanRY1
	 7ee5vHqaTmxvNNYY1Zdw1rgRM1C2cBLFGQjqx8wcb3FgXbRpST0bqEa2qwktZyVzAbov3
	 RlvQy4P7vDn+kpN6WDYR03XfolPylCbiZWPut8Ldzu7cQSEe9QMzWENmb9BX1rXNlwKWT
	 w3xyi5mQKOuRO+do1FB/L3jKjpuh0ehDE72hRY+PPhf1H1saqdavew2bYQwmw13pJRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vnCQnOqr;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89998606A881
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89998606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vnCQnOqr
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so3351675e9.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 06:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794580133; x=1795184933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WgvVB0BventMA44qkTZomkF4CYy5OC6Sjw91Zj/HK7k=;
        b=vnCQnOqrr7l1M/EWabQpRGHeZqE4JH8iRwas0h9BVRWe8Z5qdSqWy64e7UZBvweYLr
         InPGlRQZ+dLEqU6iWY/HroPIt2iGpFN9OQSSChzSU0Yc8rRZ84Bc3mdYRW5xjfx9MJre
         GL7WDeEcf2LkyhKd0KIbX2XtDGFCLyg5He3zLVsGHWa05gJNNgGUHknVImS8TyQtzRE0
         C0LAkUgphkFnIWdOvkmPU0cxexQSRS7vBYOJhhzTvfumoWnsiw8rUXz0HR7atdHVleL7
         D+7LyrdQKePbvOh5UMl+Ar7cmKB3fZkVMs8U9T3f/HKLpVR881tl9Mnn6oBgPnhLp2Tb
         tRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794580133; x=1795184933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WgvVB0BventMA44qkTZomkF4CYy5OC6Sjw91Zj/HK7k=;
        b=1I3b15h9rfRxC40e2qh54WNwU7VeS4LLGcHtnv8nRWW/2riSHY01sjPhA5aNWL7XYh
         GRIHuAgG6iqPK12CYNe/RFq+956d8ZafaB8AFLta+vshjGj4Rgf+CQfM5a7WW/fzDv1+
         3ejBd18jdiJpn+IRwAtPOCLNNv4N9jEjTcGsRnH0MvM/yVA8bHy9HBxszqNDAbXFktuX
         Pjrt+UZZbKdyWNK6AQbVAS7mgwkpjFlFh6hSPAyN7nKO+tTGJj2906GmOzuB4xG+Gen8
         W42YD67W/w0kVOEhafPkzH6YHrMMSIHnHBKNOVJsnc4tsLxXVgjfYvuY4zpszQ9CTm5U
         NQMw==
X-Gm-Message-State: APuU4Z+KSiH8zg0/TfUFbedhfq+HbavyLY3TKV8r7YHsdVbWnG6iN+7D
	+RK2HEOIq+3lEm/dEX+KrZOsGQNS0Ne3ovMYzNUBxYgvBhDqNPTsIOXKuO1FyrT8
X-Gm-Gg: AYBFou2KDKW+xQ926KqoI1y6aNsbRX9sI4sL3QS15t/pGe5yyy+pXTxP4XdxAnYMTD2
	OFqpbGgdyogh68mmaKfJhknqNgh/6gijYfBZQEQCpu6iD/repr2OJ5ML9cjee3KCUjNnVvNLtGg
	eQLrMWX97UsPwMDsc7ndPCsPM/EDWpRRZNQKMqrX/Rbuw/aMK1OgLurpgQHCdC89Bl0Cypx+XGe
	yj9ZiAwUmFUdXVOPaq0zgoWn0Vfrw3Nfy32K/ioRJbwNtvP602z++PIcwBI888HcVmILJNSY6yF
	CuNJ5fyyQ+i1zuX5ASyqgYxvuMdHJAFDnNnpAcIJI9keBEDGR6bP73xrX7VL3nfyR+3/l8L8SzU
	c8VgRVvU4A9w3pwCWDtj4lw25soyXyDKGOyWz37Y0iSnFz0alurZHVLo72aUplCMYo5RqjyRHiN
	Y5Bw6TsJ9aBwN1uktX5Ktdgh2SPiWz3UW39bOfs4h+E8ipYVyYr2KB2JFxdDJljR99L/TGbFnDI
	YImQUVvFf6q0NubcpYVS2Mu4B56DfnqRTBhIu3/hJOkLmt28p3dIwoCSOcXf1SbiZOYj5NzlGUx
	tNTYNMPZ74yitkLdgaI0m7sv/AaogyS5FwyW9sL1PY8GkFop03T+0tDghQWEwXTWyzjJYIwxEbl
	n6CPyAvLF6ZOljrgdcK9KbpXv6vg8B/KtD0M8A7Fl5vVPLhe3hcs=
X-Received: by 2002:a05:600c:1daa:b0:4a2:59:f568 with SMTP id 5b1f17b1804b1-4bb55a481ccmr53815615e9.14.1794580132611;
        Fri, 13 Nov 2026 06:28:52 -0800 (PST)
Received: from KURSA (ipservice-092-208-105-158.092.208.pools.vodafone-ip.de. [92.208.105.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac1159sm60033285e9.4.2026.11.13.06.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 06:28:52 -0800 (PST)
From: Caspar Duregger <caspar.duregger@gmail.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Caspar Duregger <caspar.duregger@gmail.com>
Subject: [PATCH 2/4] object-name: let GET_OID_GENTLY affect only failing lookups
Date: Fri, 13 Nov 2026 15:28:02 +0100
Message-ID: <20261113142804.7465-3-caspar.duregger@gmail.com>
X-Mailer: git-send-email 2.56.1.windows.1
In-Reply-To: <20260212040708.GA1894049@coredump.intra.peff.net>
References: <20260212040708.GA1894049@coredump.intra.peff.net>
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

393bbb21c9 (object-name: make get_oid quietly return an error,
2025-06-12) introduced GET_OID_GENTLY so that a caller can turn the
die() on an exhausted reflog into an error return. The check was
placed after the if/else cascade that decides whether the lookup
succeeded, though, so passing the flag also turns two successful
lookups into errors:

 - "ref@{<date>}" older than the reflog;

 - "ref@{N}" for a reflog with N entries.

This was questioned in review [1], but the code was merged as-is.

Make the check a branch of the cascade, just before the die(), so
that the flag changes only how a failing lookup fails. With the flag,
"ref@{<date>}" then resolves to the oldest known value and "ref@{N}"
to the "old" side of the oldest entry, as they do without it.

The only gentle caller so far is "git stash export", which can now
export "stash@{<date>}" like "git stash show" can show it. The oldest
entry of a stash reflog normally has a null "old" side, so
"stash@{N}" past the end keeps failing.

[1] https://lore.kernel.org/git/xmqqa5745ttw.fsf@gitster.g/

Signed-off-by: Caspar Duregger <caspar.duregger@gmail.com>
---
 object-name.c    | 9 ++++-----
 t/t3903-stash.sh | 9 +++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/object-name.c b/object-name.c
index 13e4dc0f21..c066a7d6a2 100644
--- a/object-name.c
+++ b/object-name.c
@@ -812,17 +812,16 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 				 * still fill in the oid with the "old" value,
 				 * which we can use.
 				 */
-			} else if (!(flags & GET_OID_GENTLY)) {
+			} else if (flags & GET_OID_GENTLY) {
+				free(real_ref);
+				return -1;
+			} else {
 				if (flags & GET_OID_QUIETLY) {
 					exit(128);
 				}
 				die(_("log for '%.*s' only has %d entries"),
 				    len, str, co_cnt);
 			}
-			if (flags & GET_OID_GENTLY) {
-				free(real_ref);
-				return -1;
-			}
 		}
 	}
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70c6031958..74ac66f22e 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1557,6 +1557,15 @@ test_expect_success 'stash export can accept specified stashes' '
 	test_line_count = 2 actual
 '
 
+test_expect_success 'stash export resolves stash reflog selectors like rev-parse' '
+	git stash clear &&
+	git stash import refs/heads/bar &&
+	git stash export --to-ref refs/heads/oldest "stash@{1970-01-02}" &&
+	test_cmp_rev t-stash0 oldest^2 &&
+	test_must_fail git stash export --print stash@{2} 2>err &&
+	test_grep "unable to find stash entry stash@{2}" err
+'
+
 test_expect_success 'stash export rejects invalid arguments' '
 	test_must_fail git stash export --print --to-ref refs/heads/invalid 2>err &&
 	test_grep "exactly one of --print and --to-ref is required" err &&
-- 
2.56.1.windows.1

