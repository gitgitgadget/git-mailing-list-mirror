Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512111;
	b=5n56ovvO29TKP2DNLV+skUJXyeXtLyFv5q4wsB8W5zo7ZCxxqCsRiuWTaH5Bs8+BymVo
	 6GlR2ctgfY+suqCrYd9uCWix4FjEXxnFznidU7latirqKeHZX0tjjVDunxupgYMpUW+TZ
	 AhTtNk2MAgLp35z7AYQcKYqYRSXU7Omvk34bfHOftaJD+qi7sszNFLb79FmcUqQHmRthp
	 BmUhiNtCCEHOp33PoLY2g9sQsltUhjifvNhb3xH1DhUF6cpxoWf6uD7sfkNXEFhjxKVJB
	 THIOthyea4CExZAPbjrV7veFS7aGtJDdUpjQCmuJsg9WnxsNoCEIfWJtcWbhulux0Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V1sf00p4h2qemA8ouSO9REJj3oRiCNUJh+MpUEwaR3s=;
	b=kj4MuerhIAJ01uSYg7shzmH1NXcPgyyiCpTb/zB8CpEmmXkN5LqX3Urlk52JqamUG8fg
	 niCvKIOXcE/tfacFMsUqmm0KqUot7oaBRaKIdUCYh/A1Ek/mmx+bCVVKnbPOJKY5sXcMw
	 VjH2iuYfFUrAT8B6qFuU7/QTs+aOoD2vVNJf3RdncUrMS/1vZWmcTiPrSkSPWZQQvSLYR
	 OyGU34jNGrTs8cK7lfyM7ICIqVCJEdah2+Rl1LZvl1RWu6INkARRuPR1Y1vLSWKyHP4we
	 Gpq2syAc76QkY6sCjVtvb04YVCl6N3Y+Iw96cYGBj+PueMNewEPq+K/4Q+bxB1Z0ADA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="q9Qig/C2";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA0606A31C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAFA0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q9Qig/C2
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so226485e9.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792512109; x=1793116909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V1sf00p4h2qemA8ouSO9REJj3oRiCNUJh+MpUEwaR3s=;
        b=q9Qig/C2D4+tVzbFe+dHxeFdWMc/Hi6aUFCvB4fWZSZGQ+z782NyZPYKNmh1HHfDSK
         nUbOUmTxq1qpwzvb58/uJDp62Tl6pxPhwj/7h3Ws5tU1wyPrww69BCXERJOdXcib8tON
         yKG5PEwpNuzddzZCgRaINj+vn9AQhMybQ/O8WQIw7L6+s0CjLORuJiVhCGSo4t+S8ZxG
         a9MgJOCu1xiKH3e+Dyb2ySmSTTIt2KsdOZ4v9CfjBebwr5PpM4ZdDcTdTsg/5Gdo1VvL
         hu7WSr/hLN1cC91amle5U4tALB8CtCcpgsakyhdiXUy1NjC4fZEB2d1kvTz0ioal4fuM
         Iz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792512109; x=1793116909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V1sf00p4h2qemA8ouSO9REJj3oRiCNUJh+MpUEwaR3s=;
        b=tYLC100iRzbmHgJujorhIiHHplIfjGRqJPsa4le5jcawmL1SUTAKz01/2BXZB6W2rM
         KgKyMP8NVpISYb1Ko089ndSPgZl8ncWU+vN+9BnyqSvu7QPGF/1r+iAsjeSzZfxzTJHN
         2Mdl5KI0Z5ZIGHsg6TyLzAIqw4M7zA4lWfJP4Po9e7rR1u7rHOQGwKUObtctCPrP256e
         AhSvv1wRdT4fXqwmQwFEE8g2bgwJ7tmZWZR0t6Uyz/31tmhxw1l+EzND6LOo2eMLUk68
         LFr/VZTE2G6R3F07vuExT+tcdVmuPz87SZ17bi16s17MXlamhnrCuzF4+TwqHbX/d6sg
         fZpw==
X-Gm-Message-State: AFq9FYJzZJSopXWWW2137An/a+HWXDl3ulID/vDRYFcHOn6d54+/D37T
	x3h1DkhYbsAxIF8nLPSXt7eZQ80xK+sfgKjcSKQv/NTsfy1pzUsassfKFZUD43Vz
X-Gm-Gg: AYBFou1rUXUrrtEqZ9z/tHud0A1AT2oIDUsgXmyulGy+xIfUumDQ+5EPVk8ofKNXkum
	RaRr/tNZkWwGji2r6jSxuwNmU/YGGV+uGEBO+ERDvkZMGwVwqsWFSwM2Eqp3lxjZauKrOgFZzkh
	RHyBlk71WiMnvNWwcfRUX8iZcUw1Plja8zB8/vRkVFC/T24qPyWxyB5o7cBWh5jaSSOZxItMoPJ
	mLq3vqt4VA/RW3GqpllmiMNx9L/EHOaV99VOUHoo0Bk3z2tfVhEAitLaUhRwStISRLTrytj6FGb
	hHahW0m/jrFSWhBq7UMa/iHWS2M45iCWDrHYVZ9g2SZ/EhqPu0NRmVrmPYOgaLE9cUBQsigXwKL
	7W3CKo/vBuvmKzEaiX5QjCjw/LtrnRh+owg4qvMjrqMgSt13VfAyYY3xRdf3CkIG32NCNFsHXJz
	lxcIr0HsZMKrHmR94fLj/b5wXSM5bL7fTCuuMejFDn1uQrRfYkMtFhnU/Ld9PYVpV5f1XuRP5OU
	hNO9q6VjOGF3Hw274g6SNrV87WGogDFur6ddokIxVeH
X-Received: by 2002:a05:600c:1f87:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4a1fba8b15bmr3324215e9.9.1792512108835;
        Tue, 20 Oct 2026 09:01:48 -0700 (PDT)
Received: from Stealth.zuku.co.ke ([197.237.143.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e91sm7157410f8f.54.2026.10.20.09.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:01:48 -0700 (PDT)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com,
	Dorine Tipo <dorine.a.tipo@gmail.com>
Subject: [Outreachy PATCH v2 0/2] t0410: fix exit code and hash assumptions in the missing-tree test
Date: Tue, 20 Oct 2026 19:01:25 +0300
Message-Id: <20261020160127.29096-1-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014134504.1152225-1-dorine.a.tipo@gmail.com>
References: <20261014134504.1152225-1-dorine.a.tipo@gmail.com>
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

This series cleans up the 'rev-list stops traversal at missing and
promised tree' test in t0410.

Changes since v1:
 - 1/2: expanded the log message to note that the original pipeline
   silently assumed the first tree in the ls-tree output was the one
   we wanted, and that naming a_dir explicitly is an improvement.
   Thanks, Junio.
 - 2/2: unchanged.

I ran the full test suite with both SHA-1 and SHA-256, and it passes.

Dorine Tipo (2):
  t0410: use rev-parse to get the subtree OID
  t0410: keep git's exit code in test_grep calls

 t/t0410-partial-clone.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Range-diff against v1:
1:  b8f514e0a2 ! 1:  dcf6c7da4c t0410: use rev-parse to get the subtree OID
    @@ Commit message
     
         The pipeline goes against t/README which says not to pipe the output
         of a git command, since only the last command's exit code is kept.
    -    'cut -b13-52' also assumes a 40-character SHA-1 name, so under SHA-256
    -    TREE2 holds an abbreviated OID.
    +    It also silently assumes that the first tree in the ls-tree output is
    +    the one we want, without checking which path it is stored at.
    +    And 'cut -b13-52' also assumes a 40-character SHA-1 name, so under
    +    SHA-256 TREE2 holds an abbreviated OID.
     
    -    Use 'git rev-parse HEAD:a_dir' instead. It returns the full OID in a
    -    single command, the same way TREE is computed with
    -    'git rev-parse foo^{tree}' just above.
    +    Use 'git rev-parse HEAD:a_dir' instead. It names the directory we are
    +    interested in explicitly and returns the full OID in a single command,
    +    the same way TREE is computed with 'git rev-parse foo^{tree}' just
    +    above.
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
     
      ## t/t0410-partial-clone.sh ##
2:  5823e65a88 = 2:  f810625e77 t0410: keep git's exit code in test_grep calls
-- 
2.34.1

