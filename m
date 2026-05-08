Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322A3EDAB9
	for <git@vger.kernel.org>; Fri,  8 May 2026 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249750; cv=none; b=A3bd9cYFvqUvSRMu5zdSWZKEAipRebvWyBuF2vfXZMOdOwNyToQzcqGGaMACWacQZwmZu7bgqyCCo86MeGqNa5RcymNPZA/vdOmQbuHF8ydv59ooD3wU+iH2Np4IQ8cypCbdNobjnR8GIVIAkC5rnNlzyG0Kag88TWVmSV3+iNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249750; c=relaxed/simple;
	bh=2jay1NjsJwZHzSWVs/RMxPhIYwI8J/a3rgmWx6SO6yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UT9Rlua92KKwSPg9rlLmzxih0qwxMux4YhCQ/dyyeZrXc+vh0BR+W7ScZuebNuYO8TxA1FCaAK2BCrXFbfBKDFzh1IsjeUgZ8p/9RlPT2P0S2eofuAhd6Pvvqr+5iGNUH02Oe3MTi65PlF3MGJvzGmKdZ8AVWenbTMS3RR1RXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI8mDFRH; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI8mDFRH"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7bdc947aa88so16917257b3.3
        for <git@vger.kernel.org>; Fri, 08 May 2026 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778249748; x=1778854548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1dslkJw+sD47ByOcHMxaWxSbYgYmxXjduPNQO42PmI=;
        b=PI8mDFRHQMiQLCN1OFrq6jSTeKfZ4qvtASWbvOkL3owqLZRySXgoOhIDh4LLw0uJ7b
         WBrVrby2GyzfN/1uj0VPC4qkvI4osOGko0XxNWXPaqKj8gpLPuEQLZ69e9u9HWzoR9cB
         mFzOizDAqSt2pLmtNQ9zJdvxm0VNlwKY82F+DIY/w+9enNOt9cGxV2N2UZiCvRsn5GQV
         X8EkR30IuP4zQb+aDyP+bMGkRv/WX3zFBQtFLQC4klSQRzBzs/K6NDBKmmAN73SdTlYZ
         7jWeLb0lkd3IYvAQgfb7XeJEWPhSzVUXzkOCncdSuSg+fv86iE2iOWZI+aiSBBuXzFOj
         mgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778249748; x=1778854548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1dslkJw+sD47ByOcHMxaWxSbYgYmxXjduPNQO42PmI=;
        b=qHJNlbvdYgMGh4ZJh7fGL1HiLO01HYMFv2iLA5Ax6bc/IiTWnZ/OEiYXrybMCvtxUT
         n08fXDPFjaNYkM020axsaAh0evVfEjzJqVKpNOOBH8HYdn85vvs7iXfgqwg3/5KYhYBD
         oelmNiyEAlZEhh6HK5w7CIZ0pFDT4+3LBoNayLdHSfYjRP/Q6KNv9OQTX7o0xNSQa49x
         809atfenCzXz0PDbVnVAWriVG6IrZs99bFxwY4uPQxGU0cuOCK8KlyvW130cLdPscIqn
         YBqituQVZ1P0T+OIe/0BNMLQI1sd9g6ekD2rA9eukEpbgfbVp7/PzUiBCVR9t63IawF9
         VWoA==
X-Gm-Message-State: AOJu0YzZnYCNE4V+J+h4sf3UPE8T6dnKdsrEK0xHq21u/T7A2GqUSb3T
	XdweBf3InCmJoi4liP7n9A3tSDmBj8C1KTlXgJp08y0hl4aQFZPDdFOacUNwa03E
X-Gm-Gg: Acq92OEGp8eGlCcNCjQmi3QXkZ9M5qjhSPRq296ryVLzQ98lsytshSploeaMZuKATuM
	lawj4PaHpL8QXH5NjPp+cwTF49rNL6s4a1kvDF4pIG5t5s2GuJsNHnu1pvvbT0aL2oZQLWP8aNs
	b21jOtbrQzDuFouzuzKyw0IT4UgrfbJjnwUNyQy61NN9eP7Ac+AzaYYFapOdbZq2DbwsH0JThnn
	qtibQTm3DGazODrMEBP3jRuF4ui9b3r2TV+o47zA4g4c/5zdKt4VwVAa3sw+m+/ItUeVcOwDLqR
	QjT+PDYE1oEsXc3AM24o1LyaZGIZ0vJTnrSmQ5G1AXS2s0b8bqUW54BLvZlgK/P/1vlR7KXcoB4
	XyCAbQAITi8oznPyx5w6qAEK6pV4Oir738qsNgNB5yxToCH7vh9NFth031WOoADia0pOs718OCN
	030kHDpBO9KeavzjgY+jSDiFeargW8WeJG+tPxKcajVuIPAAAhei+uxMdbJaBqlFHl5f93vLX1j
	XhVQpEsqJwFx/rDqA==
X-Received: by 2002:a05:690c:c115:b0:79a:d2ba:3c24 with SMTP id 00721157ae682-7bdf5efb30dmr130912147b3.41.1778249747810;
        Fri, 08 May 2026 07:15:47 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90fb:c300::2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66525651sm106405117b3.3.2026.05.08.07.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:15:46 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Caleb White <cdwhite3@pm.me>,
	Calvin Wan <calvinwan@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Andrew Berry <andrew@furrypaws.ca>,
	Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2] ignore: note info/exclude lives in GIT_COMMON_DIR, not GIT_DIR
Date: Fri,  8 May 2026 10:14:14 -0400
Message-ID: <d58b6e921d3005c6170fc6c47f175214acb3fa68.1778249267.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.54.0.564.ge3ee0a11b5.dirty
In-Reply-To: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
References: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gitignore(5) says that the per-repository ignore file is
$GIT_DIR/info/exclude, but in a worktree that is not the case:

    git rev-parse --git-path info/exclude
    /path/to/main/worktree/.git/info/exclude
    git rev-parse --git-common-dir
    /path/to/main/worktree/.git

We actually use $GIT_COMMON_DIR/info/exclude. Adjust the documentation
to say so.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes (benknoble/commits):
    Changes in v2:
    
    Only adjust the documentation.
    
    brian points out that a more general extension would allow using more
    info/ files as "per-worktree," which I don't have the impetus to
    implement myself.
    
    Phillip and Junio asked for a concrete use case:
    
        A colleague is developing a tool for managing the "skill files" of
        various LLM tools (Claude, Windsurf, etc.). The files have
        requirements that make it hard to generically ignore them (e.g.,
        filenames and front-matter have to match), but different tasks
        (corresponding to worktrees) may want different active skills, so it
        is desirable to ignore the files. Think of this like node_modules.
    
        Unfortunately, since per-worktree ignores don't work, the current
        solution is to put a .gitignore file in the corresponding directory
        with the installed skills that ignores itself and the installed
        skills.
    
    Since overall reactions seem fairly negative (or require a more general
    extension, which I think is probably the right course but not simply
    implemented), I've opted to adjust the docs. They originally confused
    me, as I was surprised when my colleague reported that per-worktree
    ignores didn't work (the docs imply they should by use of $GIT_DIR).
    
    Link to v1: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
    
    v1 notes:
    
    Discussed briefly at https://lore.kernel.org/git/CALnO6CCXmA+ATT7CuyWkU6P8qmLCCpMi5Ppr1c78s0heznpVyw@mail.gmail.com/T
    
    This is based on next (4f69b47b94 (Merge branch 'ps/test-set-e-clean'
    into next, 2026-04-23)) but cleanly applies to master (94f057755b (Git
    2.54, 2026-04-19)) and seen (50541634cb (Merge branch
    'js/parseopt-subcommand-autocorrection' into seen, 2026-04-23)).

 Documentation/gitignore.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.adoc b/Documentation/gitignore.adoc
index a3d24e5c34..c423b650de 100644
--- a/Documentation/gitignore.adoc
+++ b/Documentation/gitignore.adoc
@@ -7,7 +7,7 @@ gitignore - Specifies intentionally untracked files to ignore
 
 SYNOPSIS
 --------
-$XDG_CONFIG_HOME/git/ignore, $GIT_DIR/info/exclude, .gitignore
+$XDG_CONFIG_HOME/git/ignore, $GIT_COMMON_DIR/info/exclude, .gitignore
 
 DESCRIPTION
 -----------
@@ -34,7 +34,7 @@ precedence, the last matching pattern decides the outcome):
    includes such `.gitignore` files in its repository, containing patterns for
    files generated as part of the project build.
 
- * Patterns read from `$GIT_DIR/info/exclude`.
+ * Patterns read from `$GIT_COMMON_DIR/info/exclude`.
 
  * Patterns read from the file specified by the configuration
    variable `core.excludesFile`.

base-commit: 4f69b47b940100b02630f745a52f9d9850f122b2
-- 
2.54.0.564.ge3ee0a11b5.dirty

