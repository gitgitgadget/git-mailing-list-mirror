Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D3429ACC8
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314723; cv=none; b=cdPS6Wbhgx72zqq71lTcgni7IYFpmukWAJxUWNiDk9Tcmv8D3R1l9mGB2N8wnIvMlLr7nfTXeV3Yj4dfbn9ThYXr+UDg7XqYoppJbeFnLArLEVI6KTbXnF5W9r2f/ZEeWoeZH/2pBbsvLgvB6+Q+ITJtCvIKZ9Sf6qKvapYSnF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314723; c=relaxed/simple;
	bh=UhQv4EbUYpg19/Jx/X0/xM5K7iEHaKiYzRHf1jMLySM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yy477KJ/iJi++GRDATBgcj5gsAyaB5l0C3xlRc0601tf8g1Z+I8/sC0FPk9W7Vx21bYZxj8vGmXlEZAb+kYcFBGPP2KFZaQp03bI0N1k3A0n1/+T35CDCUT1KA9UyRn3OgovryhtGDaJD+gzxn9QX15W/XWrgzrNr2Bq3a3zEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhmEYPNs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhmEYPNs"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442ea341570so6080875e9.1
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314720; x=1747919520; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiaAXctjQaSjhnyhenFNlvR4V53fY6d38of0o9+ihaI=;
        b=BhmEYPNsClyIVWXk5p+V5baJGdKe1Tw0XzSz00PbjssMn64S1s9ZkizaGQtMpOa21C
         FgefjWbbVuyHMe2iBEUPZLaGxzli2vljR7bXnYbS2aCJtrUt5QAY6gGx4fXaWBCZ5brW
         u+acj4YdE3ycBdCefOHHuAdLnkN3Ewg5YXzIDTdq7w/mwcKZxjYwy7gELnq4RnvxexxJ
         UvhBfTkS+AI/3ay5l+ol57xRcTbDUY8qsun5gSK4H6JbUVe/7oCiHyrbTDY/BCU7XkV4
         WEah1sqR6R4HJF+Mz9Cs/pCECHrWxyv0rGs2E6NAOjhG/6e8w7zTU1npRqA49bxxm0to
         3hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314720; x=1747919520;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiaAXctjQaSjhnyhenFNlvR4V53fY6d38of0o9+ihaI=;
        b=UFl/cjWiRdTTW5prvOVapjFdZD3cMBzvLY49UBhsv7Jlf+8AYc63CSgmOKrU7Y79VU
         QpAWFFipQ3LaAOPSvw3U/5AE1f9ZqgDkfo8EP+fkF6CR48ONjANoes7PxH+A47eE8HiW
         Yg2+Hyj4RdiZjbBpLJiZ8oF9x4/1+QDeXcSATxUhqIpmivjMP7jK0BD++zAqiBt1sFkC
         NiyV8clB9u9+pjQPGPeTuddOjarFipqWoX7bHwGG0itqYENgUC5RBGJGsaYyRhbyGz3Z
         IyQeGLt1YVxFhu/80N5I9VAZuCzsnNCcbrTX4MSswSEOWnFuB1plX9bqwAWEKQtJHwBw
         x3Lw==
X-Gm-Message-State: AOJu0YxzTp8fNHlrHXWseEP56s6kY2GQ3J5eAXt36sCkvldKk1O3QeAa
	3K+t9TY7Y5SDNA5FP3EJ+bQs1MVLgCVvill5xev49sZtKewvklUj6wkvNQ==
X-Gm-Gg: ASbGnctfeqdTIn9gW+WeEcgL295Kl+zF/FC7pe+AD+q5H6U79/sVfYWmq6K6hcl+/nM
	qMTO0++sINM0dNzHid07Bt5hq3L1IXDurF+6Ox3o5QO8bkaOGQqCrDSyOq00ZAg58h5ZUl+QXGq
	3HVd7jOi0nEcv0tEFuN2zDmB2rUL7fZzNBcerxHCuOU5zxFSCyTFReQDVsYI+2Nnet/9YRwhFNG
	km4k1R43RphKKOKXmRYnLu1Mka2+O+s9Zd+4vt0dOh4W2/L+1iE1qsJvjbKRlU4007qto37X57j
	1gu3Z7shoNNzTU/CVm/yMvZEG4COaMbv2kXAf2gK29cLSSoQDKIX
X-Google-Smtp-Source: AGHT+IFjpLrJ36DLQuXP8Stqan39ygIXNjkFnZPPV5mNWjxUeTIZ9mDvI17asxIxtqSWzwOHWQ+DxQ==
X-Received: by 2002:a05:600c:3d0c:b0:43c:f6c6:578c with SMTP id 5b1f17b1804b1-442f96eaaa7mr25949645e9.15.1747314719817;
        Thu, 15 May 2025 06:11:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f33690f0sm68466355e9.1.2025.05.15.06.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:11:59 -0700 (PDT)
Message-Id: <077bcab206f5bfc9fc10a28ad7b726a6ec16c2bb.1747314709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 13:11:47 +0000
Subject: [PATCH 09/11] commit-graph: avoid using stale stack addresses
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The code is a bit too hard to reason about to fully assess whether the
`fill_commit_graph_info()` function is called at all after
`write_commit_graph()` returns (and hence the stack variable
`topo_levels` goes out of context).

Let's simply make sure that the stack address is no longer used at that
stage, thereby making the code quite a bit easier to reason about.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-graph.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 9f0115dac9b5..d052c1bf15c5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2683,6 +2683,15 @@ cleanup:
 	oid_array_clear(&ctx.oids);
 	clear_topo_level_slab(&topo_levels);
 
+	if (ctx.r->objects->commit_graph) {
+		struct commit_graph *g = ctx.r->objects->commit_graph;
+
+		while (g) {
+			g->topo_levels = NULL;
+			g = g->base_graph;
+		}
+	}
+
 	for (i = 0; i < ctx.num_commit_graphs_before; i++)
 		free(ctx.commit_graph_filenames_before[i]);
 	free(ctx.commit_graph_filenames_before);
-- 
gitgitgadget

