Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637500;
	b=xhWgkXhZCvDJ6cOXQSMVMsZKoGyUWbSbwlv1pEkWSGYoj7C1x2TGVFXwkOe5TLM3w0ex
	 tikV8cQ4RILvCa7j2IG2Zpg1YFWF0mAHSyjO2aqpqYYpdjp66ngdNfS8eqGNGP/qtKN2I
	 Jn692xUxrJjWI4iYAUKvwJnO4fYPeFatBLMC9Cxeafc0kojbBM6IDAQXTQfA2D1ownhqX
	 sE/f9IMHZKS8HXP3mRVd0EkAsYjDX1nz+/uU8p3VHf8zSyyqVBc2AI5GQE0Cnh0uL57tM
	 k5w+5Kug+41uwiz2OLylrwQWe0uWNEXfs2ugysw02/pIHM30Th90MPnYBfTdWo49Ryw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=bQjWlS+zoIgLZBYXu2UTP8g+cWSR4hoKBrfhZB3npOg=;
	b=tswtpOzunEQ1pYzZToUgeo5/FCcgnVUJvUJU3W105+77HIZRVWiwPVX67adz8aHB9U0G
	 cTa7sN+7B3yAZ4fZw7kQFakv5kGjOnQ3us+hTxh3IiFm9Tr+3UXHTbVtpy9oEk8sdldHa
	 KbUpPsDH7htXsxDe1p9F3cry9sMvcG82pA1QOfaJyfw33Sa2HN0NECAopE49kGX1cHFSi
	 cMkgw+DXbmlvSS4I9pGwdBqX9mBg0kTx/yJY4ier5+YKm7qbHcFoWqtjkwsYlu1QXRDlD
	 MdtZDmUMHfcaB6GhGvunkG2TnZxcoAeTohz3FgCKLNe53rqjJ9VBKrpFGQNvAJEdyyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IyNlPDmv;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC6606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 02:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7AC6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IyNlPDmv
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a070781f63so611363b3a.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 19:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637499; x=1793242299; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bQjWlS+zoIgLZBYXu2UTP8g+cWSR4hoKBrfhZB3npOg=;
        b=IyNlPDmvqQh6UNb6oyFftR4bVsaXCGIC98DFgICv7d3q0pC0y9wwNtclXmecX1uazA
         fUfDrPu3iPJP4ipbMRgFA82m+iGmy2gwP2k5lGhqkHMeIa1rLhFtl9Azb/Lq+lMps9mQ
         uYeEJD/yh1Ox9vtcb3J/B2gwabP+dor2TdItnGmNyybW1zF2YcAgHxO35ayUQOVBIK9s
         A51CTsOzH0sAu0CAZnWaCPBbJa+jcOL8VPR3GsCOCBdw/CKX+kQbo2xXsrScKde8dh2N
         Sp2kikflua/vWXfSiQCJZaY3ibFb85KLPWXmn+RUj6lyVeYzc0ewVx/N6gpi2tMjvq7L
         nXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637499; x=1793242299;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bQjWlS+zoIgLZBYXu2UTP8g+cWSR4hoKBrfhZB3npOg=;
        b=1NGXxDCIkZooMbSdvNFZMCoA5Dlk+QioxkiV4nQCoBaYvYqyPqXxwgU+VOGAlOKf22
         hxLDjmafT9hhla0R9MNuNXTT/XWouapXkWHlKxk9PBrNlx83qKYBj8KzccsMEj8m/rda
         SJQJaMOBQiPyMPsQfFF6Cz+8DRMobh7y32poLm+x9ge6XIQjlmWuB/AV3Ra2ZnL9Y3um
         sS63Hia0KcMAYR4uJ1hIVQgbDH10JMNm4P/kDcIO7Z+a/E2DZioAHT7vDyiFG8KLWQWh
         1VTEbA7uYyVgihE6zxPMPUu3IyR2phWu8WlqXpdIWtlBe1DmmyEHlhA+5xhhkq79l6B0
         7AYQ==
X-Gm-Message-State: AFq9FYKqBRMD/LSQDHQEr7xpOS7hGV7YT+7eYDIPdT/t2zsQNdptqSVA
	WVxVnULc492+zi/Fb82On6aMqP1l8J/Z5UxSsw6MIFdyVKKVZXtkhrmyCdIXWg==
X-Gm-Gg: AYBFou333jMTypxzdGD7uKXQwTVuRJ8SFpVxGn1x/Eku4d9zH8Zo6C0gHJmFgVIC2ec
	bqjjtMQONriBzjK4qenrCe66VGpwEHpIEaKxSQZsYQgzAeLh+1nVOcU+8Rnkah3DgYrrhO3g49F
	p5xKQP/ubqCe6UPdx0Ge8HdTApvScB53OVj0qDzyrQhTVwekT3bysadfVpKQXKJAGn2dXIBpt3z
	+sWt+cUBSAJtPD9Sy6UpTevxlDOxuyZi5tD7eGnxdLrzOCSLoVZ66cJHpVrTHCdl6sfdK/i6mnj
	VazwdNG3vkXl5dg22svruI6HKq8GIEnj2hkvdSKjjj6AXpnR0PehvriSf+fctmXrd2RKAKnUO+h
	xJMkA/Kj9lnDS1pmunrKNrTz59nLxR+uKYhSsYvS7v2B3iWiOuBTXGl1rBeBr8t0D+Nx537aLBB
	kBSjGVNRq0TPW7VPdpN5GpXEuV9m2Wqs+ZVvta3IO8gvj+rf4GK39M0WDvmBf0+JFTK19y+G8Cs
	VjoHEEZ8GS3Vxl77DZwLLoHiP9ZNSn5FGS/aGgDMtW1hJL3dkTEpa3Mbg==
X-Received: by 2002:a05:6a00:180f:b0:899:465d:c8ff with SMTP id d2e1a72fcca58-8a089d05d6dmr3064418b3a.13.1792637498960;
        Wed, 21 Oct 2026 19:51:38 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.2.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895c060asm1482116b3a.22.2026.10.21.19.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:51:37 -0700 (PDT)
Message-Id: <pull.2275.git.1792637495.gitgitgadget@gmail.com>
From: "tsukasa-ino via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 02:51:33 +0000
Subject: [PATCH 0/2] checkout: finish switch when tracking config cannot be written
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    tsukasa-ino <inoue.tsukasa.4@gmail.com>

When the tracking config cannot be written (for example, because
.git/config.lock exists), git switch -c and checkout -b stop halfway. The
worktree, the index and the new branch ref are already updated, but HEAD
stays on the old branch, and the changes are left staged.

 * 1/2 makes setup_tracking() return an error instead of calling exit(). No
   behavior change yet.
 * 2/2 makes switch and checkout finish the switch and exit with status 0,
   as push -u, clone and fetch already do. git branch still fails.

These patches were first sent as part of v2 of a series that also fixed the
hint
(https://lore.kernel.org/git/pull.2268.v2.git.1792618518.gitgitgadget@gmail.com/).
Junio asked whether they can be treated separately from the hint fix
(https://lore.kernel.org/git/xmqq7bjalmpt.fsf@gitster.g/), and I replied
that they can
(https://lore.kernel.org/git/CAP8tz2KOXHLjc5V1o1tZZWSsgOjVrp-ekH7H5KszBGK+hRqwrg@mail.gmail.com/).
The direction was agreed in the bug report thread
(https://lore.kernel.org/git/xmqqecdjsryk.fsf@gitster.g/).

Making the switch fully atomic, so that a failure undoes the worktree, the
index, the ref and the config, is left for a separate topic.

tsukasa inoue (2):
  branch: return an error from setup_tracking()
  checkout: finish switching when the tracking config cannot be written

 branch.c                  | 35 +++++++++++++++++++++--------------
 branch.h                  | 21 +++++++++++++--------
 builtin/branch.c          | 17 ++++++++++++-----
 builtin/checkout.c        |  6 ++++++
 t/t2027-checkout-track.sh | 20 ++++++++++++++++++++
 t/t2060-switch.sh         | 20 ++++++++++++++++++++
 t/t3200-branch.sh         | 13 +++++++++++++
 7 files changed, 105 insertions(+), 27 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2275%2FtsukasaI%2Ffix%2Fcheckout-tracking-config-failure-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2275/tsukasaI/fix/checkout-tracking-config-failure-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2275
-- 
gitgitgadget
