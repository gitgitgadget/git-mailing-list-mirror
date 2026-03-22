Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C6437DEB6
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774209264; cv=none; b=E79Pnhr8Bgif8nWeWFejK71HvAnuYeNdDr4OZVTDYJ77mIGGwWMxfcwsGpEFQ7Rsv8PpXX1JBJK4hnlxEYyS/vyXiq5GqBg98g3qC09y7NRXEPwiwimxSXFxQNJvK15JE58DChdQAFZWI53qz3XoWWg09v/C3dW8t3MOnKaYCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774209264; c=relaxed/simple;
	bh=6y6JFTmPrc1GG1Bn9Y1c6ROMuGuxYuxoWKSqCSqG4q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAVzwNq6+U1+Sj6lVEW3mNOWYcTjubx7xLNS2ogC+fxK9X+ysZe/l96HRUX9wSZ5eTgOvYLFi9SrvmtApRbr+hzk+kYq+ZfA6tPmSzz5BVXzYMqjER9bSdApJjjshb6Er1ZJgpS5rQ3/1fwf3fsh1CcPeE5iS3c9XctkchzBiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvX7Zyj3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvX7Zyj3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fe655187so29513645e9.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 12:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774209261; x=1774814061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dP3hvLaElAhACUzqMPieEIsL3uN2L5OwVHxwiJ7OeQ=;
        b=RvX7Zyj37CKKzLa1X9c/auJWFDAMgxDpH9cEXBhHM5kZtekIeoq6SvcS05KE27bxxh
         BgJCtnkCM1WLFOTa0tiSB3R73NQ3t+EFQjq9OYW+9Mps3v5PlsOyae1qz9EOE4ecbhdu
         V55ZjFQ6l4kVVWCw/Er71cUVcNEOyDUeajsG80oN+AvO8e6llV5qbiESaiNNySTq0Dmx
         4F7OoG1SewFlaKu2vKsJV6dWXMihb5OxggENSjDcirdnzQBae+o9tXSPwX9xlPUil+Ke
         FlJxI2eFMzhWmSfpDMdki46Ms/hjU/13k/jJcddOaOZDe8WHI2ZrJzZEDbtGFE+S5L/S
         FWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774209261; x=1774814061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1dP3hvLaElAhACUzqMPieEIsL3uN2L5OwVHxwiJ7OeQ=;
        b=T6QBbCzx+K5WGrwrrt1+WtuI+r1mN5dbkd3ZINbdv8PQAbFDey81w+IcYwi+12R2Lr
         f9kwtVtPNPSi0fidj+goZprg9dhHCZn83deAJYxG77yFhdZFmV4LP3/f9n6Iza7o5AC0
         m4UYUWo7MYrxV5krJ43/0q3J+qRF3Pn3JmOOGBbeSYqGTYA3+gdfH/d3BZu4M3bt1yZb
         AjPRKw2T4bp5+Gtj6USfgm6L6YovEK4lSIzAvp0rsaFvCzx2Waw+nYvNLrx0r/2pUteX
         EjCv5h6umkBdb4wXBYFuDjLk2GEE0nF4SgGgMUv0XjAE4L+ZnokU8YT2yuCDxCYQUHgF
         W+lA==
X-Gm-Message-State: AOJu0Yx45I00ZhL40r9YgBdEL4NMrYzkGvSyzwY49DXaD7zxtCjThl8L
	YjGSBVa5+53M/r7Ip0CpT4DOMvMtkyxHNvbI6/0QG54EVzOV17P9wC/YykSGOFfdUyUJUA==
X-Gm-Gg: ATEYQzzOFmNoTjngGBKI6DIXXPzzEzFlwEjGtUQECSUCv+LHxa0rJXHdtA8FsFqUR9P
	ap/3zWyyLbm/bVGSD/K+1kML973ZOI12ZmkMyk3P9lkQzRRmJPYI2HcuZC0sEr/BExD9xG1tl0n
	/2roGt8xao+fjdDj30yMhIF4oijmZlxXK/O94H+7aR/Hw1qrHAbsVfGcEDq+Be2R6Fo5VvizHTh
	NHAZ53EbMdXMMirFjwh1+CJh9GZOwI+WBMGhasZkWRQOH9ElCMvNoetzosleaeWoeezGdExnQwY
	zfiRjDlddi7Trdl7NPhmTMz37+yyWZ0vbslKSym0VWUAF0kyRQA2DHOnMOa5VRySvCh3vm9Vl/d
	BCw9zhADi8Lv1BxZ3tECkcqzg3/wrEDxAryHIg1YGKvy1O+WgbhJwU5V+1jZECY7uyPmfS/tbIk
	zU9nOn27ShyOz2BUQiIR1Vdfcn6t3bBEjEoZVlGc28BXg4WdpYkXUKDe528GJ+8x/ch+g1/FU42
	rbfDy8SMfH1Uuh0qE1ouZVUe5+PUyr2IZ8Fua+BjDk0XRFHKuU2jcQy3jk=
X-Received: by 2002:a05:600c:3490:b0:487:300:d9ca with SMTP id 5b1f17b1804b1-4870300db54mr96570025e9.31.1774209261238;
        Sun, 22 Mar 2026 12:54:21 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe89b781sm64166335e9.12.2026.03.22.12.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 12:54:20 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	gitster@pobox.com,
	j6t@kdbg.org,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH WIP RFC v3 0/3] graph: add --graph-lane-limit option
Date: Sun, 22 Mar 2026 20:54:03 +0100
Message-ID: <20260322195406.108280-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317220929.120746-1-pabloosabaterr@gmail.com>
References: <20260317220929.120746-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When viewing the history of a repository that has many branches, the graph output
can become very wide easily, making it difficult to read and sometimes pushing the 
commit messages to the right and breaking the format. 

Introduce --graph-lane-limit option to truncate the graph at n + 1/2 lanes (n lanes
plus the column between the lane and the truncation mark). Lanes over the limit
are replaced with '.' keeping the graph readable and shows all the information
about the visible lanes.

commit mark '*' is shown in two cases:

- When the commit lives on a visible lane.
- When the commit lives on the first hidden lane (n+1) this case instead of
  '.' it will show '*' to show that there is a commit in the first hidden lane.

Any commit on deeper branches won't show any mark, but the commit subject will 
still be shown.

Coming from graph_output_commit_line, merge-lanes with no relevant information
on the visible lanes (neither commit or parent lives on a visible lane) are
skipped making the graph more compact.

The original idea to limit columns was noted as a TODO in
c12172d2ea (Add history graph API, 2008-05-04), which mentions
gitk's behavior. This does not implement gitk-style column
rearrangement; it only truncates the visual output.

RFC and WIP:

1. On lane-limited graphs, there are collapsing, merge and padding lanes that don't
   add any information to the graph.

     - graph_output_collapsing_line mixes state handling and graph rendering, skipping
       this function entirely, as is done with post-merge, would corrupt the mapping
       so the function needs to be run but returning an empty buffer is not expected
       by the callers and produces blank lanes.

     - Suppressing redundant lanes like merges or collapses that come from graph_next_line().
       graph_show_remainder() and graph_show_commit_msg() emits newlines hoping that
       all lines will have content to print, returning an empty buffer to them
       results in blank lines because of newlines being duplicated. graph_show_remainder
       would be called from two places with different newlines needs, to make
       this work graph_show_remainder() needs to be refactored. Doing this will result
       in shorter graphs with less redundant lines on lane-limited graphs. Given that
       the graph.c code is 17 years old is this desired ?

2. To keep the most information rendered on lane-limited graphs, collapsing and
   merges are rendered as usual but when the collapse or merge to hidden lanes, 
   the information about from where and to where it goes it lost, are they still
   useful ? if not, it could be desirable to remove them like in point 1.

Pablo Sabater (3):
  graph: add --graph-lane-limit option
  graph: truncate graph visual output
  graph: add documentation and testing about --graph-lane-limit

 Documentation/rev-list-options.adoc |   5 ++
 graph.c                             | 130 ++++++++++++++++++++++++----
 graph.h                             |   2 +
 revision.c                          |  11 +++
 revision.h                          |   1 +
 t/t4215-log-skewed-merges.sh        |  53 ++++++++++++
 6 files changed, 185 insertions(+), 17 deletions(-)


base-commit: dc6ecd5354dca88d51b6d6562777fc8fc10d77e1
-- 
2.43.0

