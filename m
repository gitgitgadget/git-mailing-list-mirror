Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84589456DE9
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827446; cv=none; b=XYBnwddLZ+zOCMuIcRG626wpmpEBCR6mRsezzD1cY1r+GOt22zEVxR+CepUs7fnWyNT/W4K6J5AMokXMRABJ0qDTyAkty5znSghpTsz9Cx1K6BZkKGLl5SQVvsirX5mplj+334pngz5semOFrFSztefaE+B5nBH9PnBc4A+Y6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827446; c=relaxed/simple;
	bh=F6TmlcrPd5bCfvTmbwgucV2yvB/665IpdGW9DRcyZFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqz9fgzVHWjYjnGDDpMeYf3gdG7Mbps0j9n6jZdLmVQ0D3Dhr/aHgo4NLM8/b8pHgSc+rK3t415sCqB8lmy5AZprW9EVmpzvIOL9wc5M8vgvvHMJHLlCGje0+WCLJAz6qJ8z7oCzYWG2/hLGqoCmxEljlR5EP4oWf5trtTfuhF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNsSABfE; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNsSABfE"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ae8541a2f0so18027937b3.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827444; x=1792432244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OUD8yx4B4LP8H1U52Rp7h51HY3qxUlcPfuxIckcvtCI=;
        b=KNsSABfEgDIwMnYw5u0K/UruMQPAauJGcZQ7yazxr3tcjNPmkIArTHP5PWhDYVsbr2
         oHI1BAX6zQcGW3Jq26g/uEiP1aNUbgWKafXZRs6St7T00tFc4394YJpt0V3ITga7FESc
         1nKgdzh85D+/tNrHF6DOB3gv/7b1u+kB8X+Q5OMbn891MNq6cU/mwUfy0Mw/xkZlmutb
         cJ1c7uHgaJOOkwRFj/pZ1ElOjfkdF9dvCUakqbsaouS2/nBjofk3OJ4wt0j1ihYyiPhM
         DdHHgFoVq0NakpQl+ksAg3uLn54k4gyOIp0x5lf6bL4lWr6Wtj3yCmP2dhwYLy3wKF0q
         1fxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827444; x=1792432244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUD8yx4B4LP8H1U52Rp7h51HY3qxUlcPfuxIckcvtCI=;
        b=IH0b7uHOclBxm2tBteqbPJgQDzsyjtPi0nd3UxbTFhaQOB3bYf/WcHyQKyGAGLpKtZ
         tK648ml76abFEqu+PDitTMH/T1sh9E6a5ScU6YB7dO1jsUa/brPkWCSUxP0Lbk33gkfn
         I5ZC44ntDGH3R2I+G31G+ktFJz+czbOIfCvHBEHDLbu7mRVW36yigxvY0nDY5vTc8qk8
         8ASvZ1p4IUSkHcAReCgDeBLLEspOf9WH1TpyFuTMoMlPyDYGYnDCwxNBle5ZmsIi4h6e
         O6x8oHsbFV8pWs6p0gpaOf9QmD+jKIfuXwOHQTntnKhWgMyXLlA+ZDGvtAEBvJ928NGA
         YXaQ==
X-Gm-Message-State: AFq9FYKfC2A4AOsAsGRXLzCcjG4a01dKjOaB5ixysq1GJ1OIpecBoC/t
	Nzf/lkil2yYOOQyhTezNx3OalEAqXvuosL9jD3F2DVRg77/IHJuWxEJIM6hshA==
X-Gm-Gg: AYBFou2ocl8M6lAn2WZGrdqHCbgV4R5NE6yI/oidTgJ/Z5kMlMATv8Rmnjq7VdhZN+l
	o0OeUQCivYuuH5FNhL0J/IP+3vrZWrsS+2zINL1LFoNRVEYSDoqrU9vcRN+b8X1lVls/E1tJ/nD
	Xb0mx4/a4G+YH5tcXzHgOhnEABz3nLtH7Q7YHoDTHUbUZhULrnvxKD41boxDDAF3hZ4QRbTJfmk
	bP1iF40r5rF+7tnaZmeDUpWjJ5Tu29x9KviU0tRRyY9QoQgHMSHwRA+XZNm9V5+eMeF/YSgq3ur
	fk7k1+meE+Z7sun/75mnyp8hAVs613/LU5oRIi8WQN5/ZLSI9Tbxpcq0EpXI6meeI41mmbZVkMJ
	SxaC4vYt/KQzhUD0/DMJ0QpxO/POHKnE8VMdP3dsE0zqXF1QiFsZ6WV735pZ9o+nBrcqpmABm3g
	in0WBrtuhxv11I8yHY34VXtZ4Y0QbvHRWw6cACMrfpWRQVjuzzvM+g/n1+8dGeUddsrIfpp5dE4
	bh3gO0pZOnGioAIuN4/WRJo2Dm1cnPyprDnx6GHMgWwbZx8VCHV+ddLMOGFVjiog5ui8dkGF6+a
	He7+ScQcBqTfq+snB1lyDjsdg4AqM1yd
X-Received: by 2002:a05:690c:c3a6:b0:8b0:b12d:6c48 with SMTP id 00721157ae682-8b0b12d71bcmr3339387b3.1.1791827430636;
        Mon, 12 Oct 2026 10:50:30 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07ee8603fsm36797127b3.4.2026.10.12.10.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:50:28 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH 0/5] stash completion miscellany
Date: Mon, 12 Oct 2026 13:48:26 -0400
Message-ID: <cover.1791827304.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.184.g5a00b4a6e9.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This short patch series takes care of a few paper cuts in stash
completion. The first patch is a small code cleanup I noticed a while
back while working on bfc1b34859 (completion: add stash import, export,
2026-02-07), I think. The next 2 take care of a problem I've been having
with Zsh's completion of stashes (cf. Unix & Linux SE [1]).

[1]: https://unix.stackexchange.com/q/807580/301073

The final 2 are not only about completion; I noticed we were
special-casing save completion, did some digging, and was a bit confused
by the status of "git stash save". So, I figured while I was here I
would start a conversation about (a) restoring the git-stash(1) manual
to it's "no save" version and (b) ripping out the special case.

These last 2 may be controversial, and I'm not particularly attached to
them, so if they need to be dropped I won't really complain. OTOH,
what's the point of a deprecated subcommand we still advertise? ;)

Generated-with: git format-patch @{u}.. -o p

[1/5] completion: simplify stash subcommand completion
[2/5] completion: extract common stash listing code
[3/5] completion: fix Zsh handling of stash names
[4/5] doc: drop usage mentions of "git stash save"
[5/5] completion: drop "stash save" completion altogether

 Documentation/git-stash.adoc           |  2 --
 builtin/stash.c                        |  1 -
 contrib/completion/git-completion.bash | 22 +++++++++++++---------
 contrib/completion/git-completion.zsh  |  5 +++++
 4 files changed, 18 insertions(+), 12 deletions(-)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.56.0.184.g5a00b4a6e9.dirty

