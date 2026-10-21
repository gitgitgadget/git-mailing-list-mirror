Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618522;
	b=lUUYYMhe1qsenqlxbw9nU4JUoz3xXUsxPV89UfXKpKXcHb07z4ISiQ+Ocqlj8I+g4WiZ
	 ATjunacmKazCSg/kuAwZ+795UNWntrqDbfLMc5FFlnIpx0w2G7JrTc09j/t5BneH79QrN
	 KMS9Qh+8hVaS9zw66978DHD1y7NDcKimrzXJJEqG+ZpwuZ7Bck4vAMQBXtaG1y+mlO+u/
	 FCvcTmyLfLmmK/iWg7/50eQSz3ha8I1kaKtM4td0Hr1drEOcS+ADTk9AEl5DR5LkyuOp7
	 Tj09M+/dlXOo8xaX1ZIWEejk50LhTBQp1VjNWyocIXezzrhyLrGESinEfobUL0Zp8Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=iaOUvhuNLg7dudJfZURF2MklWU8+9J3BkBky4x67Daw=;
	b=mHrLJb/kY4FVBHNP7CYcOC8C0QrrjYDBoMSSV7C5tlVCrX9g01pCIeh31gpN4qGjykRd
	 W81gyuN2oQNM4wPzmCcJIcInb52FZpZD7F61EmuZl722IcNLfiihysqxvJqiXlSbL9I/z
	 3Da5jbDS/w3IsaNM+qopqdWshQ3eYbR+VobIjh4ZYhCSKBslmiMr8MPwNElac9tAA9+kF
	 lPWtmLGwmRYLY9yOaNPZdoXoCIezthNffrdMKFkWy/yuJrlZwVdQDA8m2j/8OlM9YaL5j
	 5e3DzUK2KegT6lRX2moIevMMDu4pxLgvXFKF990sFL8jnJW+WBcDJRQoMN75+edsMzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wc76AEdw;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E60606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16E60606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wc76AEdw
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4a77761ff8aso597363fac.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792618521; x=1793223321; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iaOUvhuNLg7dudJfZURF2MklWU8+9J3BkBky4x67Daw=;
        b=Wc76AEdwMFdZcHuqYbvvFxs+yKBMDTKW8AgWb11CWIRF4uXuDxO22iBAZ81NW8xG0M
         mTcQmW51d2qj6JCjYpBJAGgZe7YutDdSmhnFvU6FEvkuC8gJoFsQWuikha4pJcZcMT+u
         VRl3pQoqiBkHizVul/mBz5zTereKjX0Hv2UknhqvHHJUqj/swNaJkpFq4YvOlZ80Nt/V
         3YAAYbxZanqF4ta0zvTWCJkjRykoozJB+dpBXJRwi5qU0Mlbz8nwOMagPUwLrfmFV5rz
         v/2ucqNvNsP2nH7BFyx2tO6Cc8kQHo/adfI+/s5E7mF5frh4W0/I5JRSMcZGybfwDIu2
         Nhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792618521; x=1793223321;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iaOUvhuNLg7dudJfZURF2MklWU8+9J3BkBky4x67Daw=;
        b=Q7vhck+PwVBJd3holeefQsKFO294m/Shj3MJX6cNvXu95020UxgCr2r0eESbkWCKdb
         mPljvGbn1tH1CHh0j1XoRVTTcWb3jkP08DwbRv6/C0oLnib5NeLH9meAbge6gqKxvhIq
         uWdm7R3+Xyeb77XvktbYNpHPll9S8/59TvMDslkdiFnWcKE2A8VrYjrCefrUQIoj++pi
         QcRzTRYii2kh+K0+AMdaqvN9VnEJUFYGobTOLQIp3PRGU6E4CVoSRMh1MMeswK5I6fKE
         Tr3MZzGSYnhawR7Rm3MRrNK9DoyfRPEqUaYhJbIhZXS/JMTd48sBoU0ggz3q1g1g96q5
         SLHg==
X-Gm-Message-State: AFq9FYLZi3rPdztyVT6qN39oyH3IXkOask23ee1XhFpNVTx9lWG4IDT/
	WRTc707VDgIY1MwYTxx8hs3kmdY1MIedX+ZuvL6U1QF24AidDyBDeaEEAjOjRw==
X-Gm-Gg: AYBFou07y/Oqttjmpso2imeWsiS37wxjEOUOrntM1Z+UgDHW5CiCVAzzKDbA+TYkcti
	+RirXtaLVaAujfmyaW9psjrgYu8VgUwflgXhO6nqBQPSo/duVMvdcgL+QOG2g8pMYhdTfVoM0ng
	nE2RZuxwsYqmDNBcJ+NkykiAWrnVgvcG/9G8yLrw8GV8rF5o93SMO/IJYYbgLuhXo41W9XJtC/d
	TEmexUjSzxMOs7yvVLQPI8RdN/lz+6fxtET/Ur7atBSHCQ9PdeZT+aRCmvebInDpZY+tZVcvvGg
	tPjKoaCB5r+XkrTk1sr3sBK04RB+tgbJ50IEMDueE00MH21u6CaxPveKyYe76HfUx7uyheSuBIu
	WBrJVGAB/cii5VJt2PUmYSc/KRmfLJ5YheOiJsGBcJy/LJ3jO1brISykXWddGZgur1uEpdR2DEO
	QgHsHxK6LcF5IFuxb0Ou8SyupzvFpsMxO2g8FvUJKRFwqDZaVxEfvxoh91wMl7Y66DyuqEAACga
	KZljh3KeOM91bA7RL2dOZ5MZLU2BpzIMw9EBwbWi7RKwNuJWhA4XsfiXyM=
X-Received: by 2002:a05:6808:3091:b0:4f4:4eef:52cc with SMTP id 5614622812f47-553596ffeddmr2902114b6e.43.1792618520920;
        Wed, 21 Oct 2026 14:35:20 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.57])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b583fd57sm2850011b6e.8.2026.10.21.14.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:35:19 -0700 (PDT)
Message-Id: <pull.2268.v2.git.1792618518.gitgitgadget@gmail.com>
In-Reply-To: <pull.2268.git.1792458904027.gitgitgadget@gmail.com>
References: <pull.2268.git.1792458904027.gitgitgadget@gmail.com>
From: "tsukasa-ino via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 21:35:15 +0000
Subject: [PATCH v2 0/3] checkout: finish switch when tracking config cannot be written
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
stays on the old branch, and the changes are left staged. The hint printed
at that point was also wrong: it suggested origin/refs/heads/.

1/3 strips refs/heads/ from the hint. 2/3 makes setup_tracking() return an
error instead of calling exit(). No behavior change yet. 3/3 makes switch
and checkout finish the switch and exit with status 0, as push -u, clone and
fetch already do. git branch still fails.

Changes since v1:

 * 1/3: the test now compares the whole hint message, as suggested by Harald
   Nordgren. It also checks that the command in the hint works once the lock
   is removed, as suggested by Junio
   (https://lore.kernel.org/git/xmqq7bjcup46.fsf@gitster.g/).
 * 2/3 and 3/3 are new. They implement the direction agreed on the bug
   report thread (https://lore.kernel.org/git/xmqqecdjsryk.fsf@gitster.g/).

Making the switch fully atomic, so that a failure undoes the worktree, the
index, the ref and the config, is left for a separate topic.

tsukasa inoue (3):
  branch: strip refs/heads/ from the --set-upstream-to hint
  branch: return an error from setup_tracking()
  checkout: finish switching when the tracking config cannot be written

 branch.c                  | 43 +++++++++++++++++++++++----------------
 branch.h                  | 21 +++++++++++--------
 builtin/branch.c          | 17 +++++++++++-----
 builtin/checkout.c        |  6 ++++++
 t/t2027-checkout-track.sh | 20 ++++++++++++++++++
 t/t2060-switch.sh         | 20 ++++++++++++++++++
 t/t3200-branch.sh         | 38 ++++++++++++++++++++++++++++++++++
 7 files changed, 135 insertions(+), 30 deletions(-)


base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2268%2FtsukasaI%2Ffix%2Fbranch-upstream-hint-shortname-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2268/tsukasaI/fix/branch-upstream-hint-shortname-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2268

Range-diff vs v1:

 1:  14eac9118e ! 1:  e705918378 branch: strip refs/heads/ from the --set-upstream-to hint
     @@ t/t3200-branch.sh: test_expect_success '--set-upstream-to fails on locked config
      +	>.git/config.lock &&
      +	test_must_fail git -c core.configLockTimeout=0 \
      +		branch --set-upstream-to=hintremote/hintbranch hint-local 2>err &&
     -+	test_grep "git branch --set-upstream-to=hintremote/hintbranch\$" err &&
     -+	test_grep ! "refs/heads/" err
     ++	cat >expect <<-\EOF &&
     ++	hint:
     ++	hint: After fixing the error cause you may try to fix up
     ++	hint: the remote tracking information by invoking:
     ++	hint:   git branch --set-upstream-to=hintremote/hintbranch
     ++	EOF
     ++	grep "^hint:" err >actual &&
     ++	test_cmp expect actual &&
     ++	rm -f .git/config.lock &&
     ++	git branch --set-upstream-to=hintremote/hintbranch hint-local &&
     ++	test_cmp_config hintremote branch.hint-local.remote &&
     ++	test_cmp_config refs/heads/hintbranch branch.hint-local.merge
      +'
      +
       test_expect_success 'use --set-upstream-to modify HEAD' '
 -:  ---------- > 2:  4d2cbaf170 branch: return an error from setup_tracking()
 -:  ---------- > 3:  be94ac75bf checkout: finish switching when the tracking config cannot be written

-- 
gitgitgadget
