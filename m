Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.230.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604038;
	b=yG8UrB/AL9WTy6PP7PMc7IP6ARNWEwP2vtQOgAxiLeftKxIslCxCgoPXgahNzZUpR8pE
	 yADPwePBKcyEgVp390oulosUcF1kfgSSCZq9opU0uWMuPxo8PQqmRgdfcIacy7Gsn7dpb
	 EkrK0mqzlSv6/sTDgC2F4Db24jk3ufxdxAVR6KX2e4+kgUF5vTLOx/mTl9n67z+U7aLNx
	 0cE5/mtUoQIfLc+8Dq3GjVol8feG3XLUL+6mf6PUE9iOtQ3qSXas0a2cwlz371Gbln0YL
	 8lgVtLzBvaTNRdDAqHbcO48jaCi1u5WOG57NCZOIB64p9NLojj3XtRsGp21z9i44vMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ATnFPkbuUiTqK6O/SIxdtvUBkaQIucPum/SMYpWi8yw=;
	b=AYlWqmURk6dgYTrZdHHUV2UfVPsyeKGNzC3fXWuTBORvbahDbzTcXcfXaX8+9uM0xx+V
	 ja9lXPOwyFLy/xY8h/InleoEq3NwvRaHnPiyo2jcRtb2al24oXoh9SZRC8KRWX+w6uras
	 F6XtoTJuiNEkUCaxbhdK40Qfw0qtxK/HoNP6x5h7sTmH77Jub6+f6C35cyW1d9Hv19G/W
	 CKW4H4kj3m/JrulcDJcBZ8k/JN0rltp1JZEF2xAPnXWJ1/19EzwLPkT5qqCicZBXfmOp7
	 16DbWMDHgNEHDhA28QRcXL/+9kwa3fyqpQbjcyTYjpa4Re43flyobLf84q2OqVVoaTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=a6PQ96Wx;
	arc=none smtp.remote-ip=74.125.230.203
Received: from mail-qk2-f11.google.com (mail-qk2-f11.google.com [74.125.230.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED154606A328
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED154606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=a6PQ96Wx
Received: by mail-qk2-f11.google.com with SMTP id af79cd13be357-93e490d7b48so31285285a.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1792604037; x=1793208837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ATnFPkbuUiTqK6O/SIxdtvUBkaQIucPum/SMYpWi8yw=;
        b=a6PQ96Wx2yuVSMWYaFVFWLuzAHB49t5fHbuVsslEMBTPcpGl+AbZe7MLOd2sQZ8XlO
         r1q4tVagl9/nv75kha9ds5wPXUW1xO2K2hyvLXHHFzrYoQ0vDqCyKy0waDO7K8WPZ5v8
         wTW/mRGyDC9mhQvhZcjxHKwRXOvdNRK2LWHicWizatcoDxjy72nSXI1WvvaKWeQxxqTh
         VECSQBU6ljqtQGzSdtiZfkDyfOEBBAKIxjwaR+fkcyXMbxtdBG3xiXLhCr0FVWdyH0cJ
         QE0llR6i3QuQ+QNLvtcHnF2I3gV4/uuZn+xqWJzsm4j4ns6O+5k6kcBdr+j8m5FaWLyS
         fZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604037; x=1793208837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ATnFPkbuUiTqK6O/SIxdtvUBkaQIucPum/SMYpWi8yw=;
        b=MJf8KWGVQD4rzchWq8XK6FKIDhZRjfxdxSlPNIQTq9RublW360DBP/Ku7AanX5ckub
         h/K2LS8QmiJJTkaGAMASM+DRAdrbKpDPjuLwR36E9BjWZII1F9nL46VpFDvzFrM2170k
         5VcDN49pzv/TS10VEfa9sqSP/1T/TGr6ejZ6E5A03IzOyEVDMD+KtZA43VL1viCGNxGr
         glrGDS9x/Nh0+j9jboqjQRiCewS3mngCrvSz4a2B1KUscEJW5VLE1KbP6k16ru8Fulz1
         aTDJxhkD/dI9JblmzTUpgAhGbbPBkkjewucsNU7P8eySVx8ZLripYjCCyrXAlB2ay6TM
         asdA==
X-Gm-Message-State: AFq9FYLXF1UD1DBI2kJPpA3xdlc3z7+uAsyMZj41jAT4r4snC6o9p8m6
	rVMB+i89ERgDILI5ZBkcWf0HJcOL1eqBSPMF0fxw50HQnMaSdxg+Hg8Rl6BuJ0URsYm8Oqx551B
	azB9XuWI0N18M8wI239dYc45lmhyxt3SAdtue/fhheicxlAUgv5dOUsfYy+T2wMmhW4m3KHL2G5
	12V7bszmXphgxtXEJ3Yk0uUVVDjUck9UzMz3uPQowQGzuZfH4i7kxu6PUAaPxBmJtLqXAUxgIr1
	c2sFn4HgAm6x0CKACgfMRoioymnWwahafeDywtulKhWLRU2
X-Gm-Gg: AYBFou3/5kIBxnhFb2/pCayv935utaH0kyH0MWEMpBPpbY4drenBzI2BPgxbSHw4/nN
	VSE2ZQ6qcLGoKDEPrJdeiNFdBui0rCt8YPZUJ1lIiQpLBGrbU+Io27lJAq8VTbcT6TlmivG32Xe
	v5o+mhtJVvmWoUV/nnG1LYfjILARf1vW/plWY89rDl7a1SctDuq4sMNX2FnXzYTAxiW6moVo99T
	j5CcCb/IfwIp6jEX3jdYPtkhB5Zovv4XX4KW2GWWm49DKOAzae86SvL7WcvuyShjYG6HLDGPNux
	Dpqw9gRid4kSCaShOIad+JGlkawQHSojFtYbotQ9LqIzkHBPd42DG9H/HbM5oGwLS9dvtR9rtnz
	PKBbidrdCaPz85wfuz+VFkB8tzmNlLtctQC8M7ZHGSzmYC9/EQP3jt9oiO6KZRYopyy9At7Nd3i
	SpDeCudi3DLIYQunXdMn+z1T6VlThBTv/sF4whx1oqw737I5EJTT2uhXglUfVUUizS30F6i+8FA
	aNtDjQ19N8Zv+BVDnkRtmMSjVj/OdpxjLXYDDT5R0cGFpfykGodPOXXT3mdfGln2lGQbws9U+GM
	/Cxxi8qIaYi/YWrjEI4NN+ROUP4U1prcpsfl+sZhJLwZHCR2x6adyrZJ3uFvSWpYo5ORJgbhJwY
	Lb7V6es/P35MVy+JFa/+ZtTkT2oTSkSWI1JEyf7IYOwjZPqM79ByXcXe0Gzt4B7ZqiKVjDKIEaT
	MxzFvAjQdF8YwX+BIG9vuYYo55ZAjz9fVoQQBRU9EKEjJJoNRcxEm1V+//iJISn/EQe3ddQw==
X-Received: by 2002:a05:620a:6011:b0:93f:11ee:ba1a with SMTP id af79cd13be357-93f57f91849mr520100985a.48.1792604036594;
        Wed, 21 Oct 2026 10:33:56 -0700 (PDT)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10b71583sm30001186d6.15.2026.10.21.10.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:33:56 -0700 (PDT)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	haraldnordgren@gmail.com,
	sunshine@sunshineco.com,
	ben.knoble@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [RFC PATCH 0/1] worktree list: add --merged and --no-merged
Date: Wed, 21 Oct 2026 13:33:36 -0400
Message-ID: <20261021173350.67854-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
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

I keep one worktree per topic. When a topic lands, its branch stays
checked out in that worktree, so "git branch --delete-merged" skips
it, and there is no direct way to ask which worktrees are done. In
the --delete-merged squash thread [1] I said I would send an RFC for
this. Here it is.

This patch teaches "git worktree list" the --merged and --no-merged
filters that "git branch", "git tag" and "git for-each-ref" already
have, applied to the HEAD of each worktree:

    $ git worktree list --merged origin/main
    /src/proj            1a2b3c4 [main]
    /src/proj-topic-a    5d6e7f8 [topic-a]
    /src/proj-fix-b      9a8b7c6 (detached HEAD)

It only lists. Removing stays a separate step with "git worktree
remove", which already refuses a dirty or locked worktree and the
main worktree, so a script can do:

    git worktree list --porcelain --merged origin/main |
    sed -n "s/^worktree //p" |
    while read -r wt; do git worktree remove "$wt"; done

The test is strict reachability, the same as "git branch --merged".
A worktree whose topic was squash or rebase merged upstream is not
listed. If Harald's "has this landed" check ends up as a helper, a
later option could use it here too, but I kept that out of this RFC.

Questions for the list:

 1. The main worktree is filtered like any other, so it is usually
    listed. "git branch --merged" also lists the current branch, so
    I kept that. Should it be left out instead?

 2. The commit defaults to HEAD, like the ref filters. For cleanup,
    each worktree's branch upstream would often be the more useful
    default, but that is a different meaning for the same option
    name. Is HEAD the right default?

 3. I reused struct ref_filter and OPT_MERGED from ref-filter.h, so
    the parsing, the default and the error messages match the other
    commands. It only needs the two commit lists. Is that acceptable,
    or would you prefer a small local option callback? If the reuse
    is fine, --contains and --points-at could follow the same way.

 4. Is a later "git worktree remove --merged <commit>" (with
    --dry-run) wanted, or should removal stay in scripts?

[1] https://lore.kernel.org/git/pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com/

Jasper Mayone (1):
  worktree list: add --merged and --no-merged

 Documentation/git-worktree.adoc |  24 +++++-
 builtin/worktree.c              |  80 +++++++++++++++++++-
 t/t2402-worktree-list.sh        | 125 ++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+), 3 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
2.56.0

