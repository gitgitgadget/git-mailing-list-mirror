Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839190;
	b=mtJ4w1WGQ4LU+usBpAEPqCDn9k2qgyonNfzJG3IdQDTKXjXMV6AcCxesovv5SP2Bs12r
	 tAFi6o/lLMc1NhfSe25N2fO0H9FgSjxS9NkvgMKZjuFnO3hIHQy86t7VoebwqtJFiuwhZ
	 hzYxI6y79rCh7U98cVu2YftstZC+uAHDcA5Qm7714DGwmkKQEdkQUMI9j0LceNHafTwI0
	 xtrZMsc8v1F1m3gS5LbZIEkjkvGT4aaVq9/Rjug4ABHvHZPmKVX0vlDvekGr8Oo8K2/ox
	 Olf9UNsenSlLlPEy0DbBeRH9Sj/1L31dpn4tQ1ptdX12qpMBmtuPGUuC/ybKHXHFGMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WZvDDKyU5EkjWfIn5aQ/UfSYFyXMmdIHP6nXIS0iXd0=;
	b=SbpVNqhZoK+f4PXtRws/czGdtxlDTi2YK5yvHkW+L2/ciFkfSrk+oT58qPwUWODr1uJh
	 8/RzqhcDve0+oL5gk1XFMfkRU1YhULCzckZ3bPGPJ+w54baUuytekUyw5Y3DVbgmaCQrj
	 9ThD/lOxX/son0COC7ng4PzzkHYb1Kc2qyQgdnc/7RMqcfy6cmYR31qZ32DeakIsXAX+3
	 mWa3C/F+k4xxXWAydntAOJXe3ki83zzLUQ03c7x+aKccN0SKOKq/zXJkSkzJnhKbTqjPY
	 /4syc31kdMs1Vfco/RVxEQecaOX0/ClaVhPj0suiraLrDfpNuAHnHLAot6I+XCS9h2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wxJufyja;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D6606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 00:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 117D6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wxJufyja
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso2690283a12.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 16:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793839188; x=1794443988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WZvDDKyU5EkjWfIn5aQ/UfSYFyXMmdIHP6nXIS0iXd0=;
        b=wxJufyjacw3Oy2sIbTjngkeoN3/UUSPh6a958K6jxuc+GiS7M7xt7VplBF2wRIV2qt
         ZWZXhll8Hr8iue3a7iUxInbLn8UaSfisCUFDo1VuiVaSevN9nlgxK1/EGakwAdLRKBNp
         JkHH5tlgP92NNmXaVqhafga3AdQuv09ipbx3E3HlzbklgzYrC8ynbbNchcaQLl3UyWf/
         A1+AziOIMXUeq6CtyKbeJ1/o4/4X0FlbbZbYj95bh9zQymS6QntYy9RFYMzRvRIcnpm0
         kC7qtumMbBklegNjt4XYzwkrTleyrgQaZW4C43Ge9229/9sCqGyWPOx6X29ZeojMv5g4
         twLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793839188; x=1794443988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WZvDDKyU5EkjWfIn5aQ/UfSYFyXMmdIHP6nXIS0iXd0=;
        b=oqNkd0TYoFwBsBqDhJfIOb3d+xIMbzqJmMU82MwyXb/c4dbZkpCndY3TR84QHk/1QK
         UJmXIFMvfVBL52cZtwdrUVZPCRHSe89Fhr8uYrH5hgtlqAmk9ikCp4mb+SPZupQxM33S
         T2PG+M+hzGS7F8I7omoqufUrH4kN2kEguArmGL4sl9Ea1AlRd4cLr9zLQNFOrCJA7+1B
         W7oLPWsNNStittLoLihiooZnR2o1WYDQWgsE4hWak6JtgrQJjDyIKVdP0gcCwXPvzKKw
         293xDo+F5waCMxtbdDTEQ2su0GMmqsRxNAOiPXp133uoRt1WgnggR7Chkdw7jEWoWVgy
         uUwA==
X-Gm-Message-State: APuU4Z/1DpR9v1+qzsdXVm5ZjgzYgT42yqAjIOFsn65NWzWzgFRA7WZs
	7fTeHGibD2jgVnbIo2Fehkpz3l3bPKdp41qpjbmXpIWJJavHVySbLDjMymB9UUEv
X-Gm-Gg: AYBFou1SY9slel9GbSun5tMVRa0pqO/MCEkSXqL8MbCdwVh9Gt2dPMW6e4wLygkTihf
	XPtyJpRnoVmGRO/+42zedmTR/HZwHyNKeu+5wndLsdnTyYmDIBBqyEZG54lg8soxILWJ/6TK4en
	mkWz4OnC8uk63+0EsRsP7V1GTbCTwizehKmnOrUrgstSunHhXrxAbY7iarllxtnRsWWC5gSHGDP
	cbx0NdS5WSf83Hcki9hLsjFW8iiYDpZAt4NUNJH1LuDY55Y6XrD92vk75+v2Xj1RHQhu8AdcbUs
	HfTLls6zoOgJ63lwtJ///kMUOW289RGSyfJnMle39Dmza36YF8nt78PcIWBHXlY+uV+SZqceDD7
	jd1zXD8izkd6Fouckh2McNrBijpvLPheupxWd2aBZY4KTj8ULtWm5ZykFOLs9XQLad82lnXT6o3
	YGOuGxDLEBVMKgJDTpoOsQ2ddkb6vNS011PCEBy+svIX4aRkCZVYSqbsTId7Nhn8TTRpNBh13pJ
	larPY9QyqzxPdB3uk34I/cUst/rsQ0oQ3ihDKRBd2gqx+kYJwUL8KMCEOShHY3cYyUxs0EGPvro
	ueaJ5iiNNb5zHGgICzFqbXnB0dZ3QXqNHtXruChCkb6D4iEMApFdh5twPVx5yNGov2g/zyjLef0
	JvURrTzQuMA7jORhr1b252pIFSUt0em3CFKGJ
X-Received: by 2002:a05:6402:5020:b0:6b3:d0a0:3a2d with SMTP id 4fb4d7f45d1cf-6b4d3370d36mr13387902a12.1.1793839188301;
        Wed, 04 Nov 2026 16:39:48 -0800 (PST)
Received: from HP ([105.163.158.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac7fa76sm1236883a12.28.2026.11.04.16.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 16:39:47 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: l.s.r@web.de,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	herroyalpriestess@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v4 3/3] t0012: catch builtins that keep NO_PARSEOPT after conversion
Date: Thu,  5 Nov 2026 03:39:13 +0300
Message-ID: <20261105003914.708836-3-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.299.g39a9a95557
In-Reply-To: <20261105003914.708836-1-tangajoris@gmail.com>
References: <20261029231621.48958-1-tangajoris@gmail.com>
 <20261105003914.708836-1-tangajoris@gmail.com>
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

When a builtin is converted to parse-options, the NO_PARSEOPT flag in
git.c has to be removed by hand. No test checks this. The previous
commit removes the flag from four builtins where it was left behind.

Add a test that runs "git <cmd> --git-completion-helper" for every
builtin left out of "git --list-cmds=parseopt". The test fails if the
command prints an option starting with "--". Without the previous
commit, it fails for diff-pairs, fast-import and patch-id.

The test skips diff, diff-files, diff-index, diff-tree and rev-list,
because they print the diff options. It also skips rev-parse, because
it prints the argument back. It does not catch var, because var only
has short options (like -l) and the helper only lists long options.

Suggested-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
Kaartic, I put your test in a separate patch for now, so it is easy to
find. I'm happy to squash it into 2/3 if you prefer it there.

 t/t0012-help.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index b0a3fdbbbc..41197c67e2 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -267,4 +267,29 @@ do
 	'
 done <builtins
 
+test_expect_success 'generate list of builtins without parse-options' '
+	git --list-cmds=parseopt >parseopt &&
+	tr " " "\n" <parseopt | sort >sorted-parseopt &&
+	sort builtins >sorted-builtins &&
+	comm -23 sorted-builtins sorted-parseopt >no-parseopt
+'
+
+while read builtin
+do
+	case "$builtin" in
+	# these answer with the diff options
+	diff|diff-files|diff-index|diff-tree|rev-list)
+		continue ;;
+	# rev-parse prints unknown arguments back
+	rev-parse)
+		continue ;;
+	esac
+
+	test_expect_success "$builtin does not answer --git-completion-helper" '
+		test_might_fail git $builtin --git-completion-helper \
+			</dev/null >output 2>/dev/null &&
+		test_grep ! "^--" output
+	'
+done <no-parseopt
+
 test_done
-- 
2.43.0

