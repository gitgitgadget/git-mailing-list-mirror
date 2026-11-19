Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116176;
	b=kJ1KHFux1Cpb1CI4YBYjuhnZtTPl7YD9JLwN4aSn5JpXzI5wjNo1IPRzp2pogSv2XVcN
	 an1/KimY0tw3V20HsUd4BX053xcBw9+Ww20d5MSIAFIhUVlxzQtzpr4SEofpduEuDVFaz
	 DSXiXhhJWT+sxthimL9fd5Wrq3ZqxadZAwjw6sZ8AyvMqm0u75j4rKRsgQj/neSiQ6YQk
	 yZhmacdg7emFX0+wreNZnqpnU99YSLbYPzu4C4PkI0aIJC7wDPHbAAOBZ8UsIHAyps68z
	 9O99BwQehLKzK3pG3iIoUqNS9b20Y/8bAzKXXZnA1D9iW2pGvkTGBQnXCy4SiRhbFIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=qVPLeMA4CU+gu9V6EibjAAC8e2DDtr8/edyewaoziUE=;
	b=mWQVtTbMR90Gnq3HMgopb5tkfJkfFm7s/FMUa9nSBoyDD3ruUsXIKjtpBLeeSinEF/gz
	 7U8RxehmEOUyYZ/7qoVusmGhiDizqZ8i3IdhUoajNRLbLx6iB5QfaH3Bvl7mRtfHUi2PH
	 sJJYgq7hDf140rTcjtnWlsffDG/pugxxOJTGKHhKU2sgNlLu+mF8qvoLcW24MPRiUsWqF
	 +zIfi0FtaBxqUXICsXwmPaeiSLd3m/Ze7cuMS3WcFfhqZZ3eK516hujgTEbyMypjN+2i4
	 5xosNl5eq9iu0QGOAcjHFTTRK1gHAHgyN6raRJLNa3ZlI1cDoSTu8vsA4svQrg8dEGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RROjEDuA;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C98606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 19:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95C98606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RROjEDuA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a20e41008cso257355e9.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116174; x=1795720974; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qVPLeMA4CU+gu9V6EibjAAC8e2DDtr8/edyewaoziUE=;
        b=RROjEDuA87skks465QyWQhzYdRfy/w3V3qOH4Pd8OeeX8Wl4mDrOwTPIpM+dpNWBR4
         1OEXsoUNqP+M5mzEIsnXRQKa70ChGSkayvaM+xvD/My0E5QogohHpCbC6ghO3Py5pyK0
         2SYz2ater0Kkp4PH3vbH32KypgapAkTvBmGXaFyBNk/otveJnf+LIbOnkLqLNz8Z8kT7
         8/4WpFOZJst7g9HekCon2CCTooBCkEom1iODbpTuTTanrc7tnvFuN06T0Dl3Ipv0ArBA
         D8EIkAywBfLDmj5r8kK34E1cuEtorZYoXeTbhYvflPj2ZYxkKKzYJiweu+jbjgcB0gzg
         MdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116174; x=1795720974;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qVPLeMA4CU+gu9V6EibjAAC8e2DDtr8/edyewaoziUE=;
        b=CviUtgNItjJKjXLc/HuliZ1QS4ZOgG/39t2PUBBiHQZVQPD6alerC0MDc693+YuMtG
         6zdHPEYpMa1VxWM3EQQcUFz/a726/qWTPE/tp31s6llFPa8UPnChWoiK0OL3/SBEbjOX
         QflXfaznqeAMDzHEVkP5d2ZRPsr3lQ7HZfhbruW/p7enoVLcDlVCGevqw2DCFVkzDyX6
         cXfEZejQiXUEszApsEREy1LGrl96knTG4haoXoWsdIGtVXfubg6wkHIlsV87u7uQzSmM
         24NiS6PntVF21JQCR289tEGBsPHXzV3/Y9btk44bqzPXfm+bYb7kz+wmmG43CMlclZiV
         Srwg==
X-Gm-Message-State: APuU4Z/wPG8pk4GBB9XbiR/QpEX8dkSx6PUm7u20I0fxkk9NKb7BYdTN
	bhiYTLCs4U3BCTWcamkn7DysBG+vIyoQKEpIsdSSXL+YFL41J2tG+vIAGlAswbxc4gMcZI+GQQd
	nuIyGpBjy8yDX52vpxQIxFXwvhdmtHrWEx95mN8/tFh9UmcHpoeG+jM50hsKSkLQ38korSmTWAM
	Mw4/cPuhPFijD6wVDQjjZLJQ==
X-Received: from wmox16.prod.google.com ([2002:a05:600c:1790:b0:4a1:dfb3:2e66])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e02:b0:4a4:4d57:8462
 with SMTP id 5b1f17b1804b1-4bb88812b1cmr12409295e9.24.1795116173880; Thu, 19
 Nov 2026 11:22:53 -0800 (PST)
Date: Thu, 19 Nov 2026 20:22:52 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192252.2674835-1-dmnk@google.com>
Subject: [PATCH] mv: check symlink leading path on force overwrite
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Lucas Zamboni Orioli <lucaszam0@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, dmnk+artist@google.com, 
	Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 062d90b2a8 (mv: reject a destination whose leading path is
missing or a symlink, 2026-07-30) taught cmd_mv() to reject destinations
whose leading path contains a symbolic link via
has_symlink_leading_path(). Its "mv -f" test used a dangling symlink, so
lstat(dst, &st) failed with ENOENT and fell through to the new check.

When the target file beyond the symlinked directory already exists on
disk, lstat(dst, &st) succeeds, "-f" clears "bad = NULL", and the
unconditional "goto act_on_entry" skips src_for_dst,
has_symlink_leading_path(), and the sparse-checkout checks, overwriting
the file through the symlink.

Only jump to act_on_entry when "bad" is non-NULL so forced overwrites
still run the remaining destination checks.

Signed-off-by: Dominik Maier <dmnk@google.com>
---
 builtin/mv.c  |  3 ++-
 t/t7001-mv.sh | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 373d4aeba3..9c801e9cbb 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -440,7 +440,8 @@ int cmd_mv(int argc,
 				} else
 					bad = _("Cannot overwrite");
 			}
-			goto act_on_entry;
+			if (bad)
+				goto act_on_entry;
 		}
 		if (string_list_has_string(&src_for_dst, dst)) {
 			bad = _("multiple sources for the same target");
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 719562a118..37815aadd1 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -207,6 +207,20 @@ test_expect_success SYMLINKS 'mv -f does not follow a symlinked leading path' '
 	test_grep "destination is beyond a symbolic link" actual
 '
 
+test_expect_success SYMLINKS 'mv -f does not overwrite existing target beyond a symlinked leading path' '
+	git reset --hard &&
+	rm -rf from target_dir &&
+	mkdir from target_dir &&
+	echo contents >from/src &&
+	echo keep >target_dir/dst &&
+	ln -s ../target_dir from/link &&
+	git add from/src from/link &&
+	test_must_fail git mv -f from/src from/link/dst 2>actual &&
+	test_grep "destination is beyond a symbolic link" actual &&
+	echo keep >expect &&
+	test_cmp expect target_dir/dst
+'
+
 test_expect_success 'mv --dry-run detects non-existent destination parent directory' '
 	git reset --hard &&
 	rm -rf from && mkdir from &&
-- 
2.56.1.750.gf70dc682cf-goog

