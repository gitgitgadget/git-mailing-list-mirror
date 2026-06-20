Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9540D566
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781951831; cv=none; b=bi715V0YspvisiDe2F3RiaJ3eo9nBjGQQ1Ln2suV5SR+PO91aI4J8T2c0TrXFyZbDWWA4a+rR5dMo0hB9r738Ig3TpEFULfatNcgfa63Cp+u/AhSmTB1aYthm3asg7ISc3BReZnlJqqiGuujuujial80NBq7u8rjcaL2bzPO1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781951831; c=relaxed/simple;
	bh=RfqvOGOvyB4Mb6JPP+236vw0ZgcU19zSWg5nyEbvPas=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dM3DEyKsSf9lQrHFalGWMnQ/xTLNENtaCoZ95qFFBcL+kZi2RzxjV+O0gh0XobfSqyhbDlxAa57yZieb4fj1KEczScSfhV5/4cW+oDMvqr7aI/wk5c4IGJRq7XLhwjYLx8+HNWutWaU8QWPqT1FBA9PDBBZFSKbJN7nVU+RPNwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQVjmSAz; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQVjmSAz"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-13809223fd4so3158710c88.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781951829; x=1782556629; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcwFZIjogyAbpJgqemIJw9Qkaet4tTPeOWccKD9MQ3g=;
        b=pQVjmSAzzHDUHbKMNvmL9EpM0hR5XN5wJyQYvhCtnWh0KCRYL5E4Yfsv9AFMOzJ+CM
         kk2+4WsQkwQtabGmVDjfTrn6al7Q5lv35VOifZoduMdNrZK++qXjNrV27TJUYlQm0vzK
         p882KW/r9MthDqwb+dFHWs03ZDKyD4EDhgfh24ZSi/fS2xRk9+GUKu0ACKM1icFopUEj
         TrZ+BaYfH7/wGX8p5BKvR9pfWsqlsRT7AhGHEXkRrZfHWjIuRYsveNKB/3l3Z8ClcN1+
         7LqkVYRd3Z1wQKpdrMy/c8E0eSxmI/o4Oa9U6qm3iyjE8HXG2zFyP1Mbp10FakIyc7zi
         uFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781951829; x=1782556629;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcwFZIjogyAbpJgqemIJw9Qkaet4tTPeOWccKD9MQ3g=;
        b=oonXUX74q/Eas8Xvgh7ryjnEIjibBTSfa981ZBgCqjI7oeNJbVXdTnkejORp404lmL
         sUBr01WyS1dvwWUqUyCAKQw3f9wcxs/4Ed5G7JXOm+ZZPKVcut+kMugwiBVE1p/y7gIM
         CPDhqHgL+ZSoP5/hSTS7KwEw6szeWta8IMyPRUl2W9HA2p7pQg1fwSz2zTB8nit+EgW1
         0GTL11FZ5vapcLyx+WOf1R2MpAXqptkdQZBQY10s1hdQk+ZJQ4v0tlgfaqMIvk/Xq3Ry
         gDEIp6hi6yNmlIcvQWAnok65AE4m/mtYsjpDR1sqgoD+OBWccOb9lvjaDpn25Mk1T0S1
         WIUw==
X-Gm-Message-State: AOJu0YzoKGuQYvQASnErLFWAKM1TutIEUFu3ecfQ/eGMkVfEfK0FR+k+
	kn7yo3lCXpTRHlq+8is5qC/P7xdoPKZaSaJTC5/UzwkIGe9TpdSkoiIoae01RgBu
X-Gm-Gg: AfdE7cl+bXq+AHd2ded9d2wczxBGGoYsb3qcWS++DgCFDODGppfcepr2hVPk9weU0wu
	+8sOAMu5TTPOfW+S1zeBsJ6RNEoUXCJ8XUO/f+xnGX9xIBkXBNI6d2CMItVM9+FNEmUiSgV8HjP
	It8FHfksdPvuTQiBbIfPAp9d+YyGtuth3VbYqwhnMv/9oTFC5LZMqoSoDeh9o7sxCHIRgCmIlgO
	rVVUWQ3G2lrhKApwBF0hhPYiAFDFTc+bbPmhZHk8sPYEh8H2o4pP+wgzQWFgxEqS1wmTWzXdHFa
	I2Cs17Y7T5XhVLuPs5i/96qUR1HOTnbZPrGbNJMPNkpccKwwBv1MwIu3Tx6wVETT3Hbx20DIj8o
	tHP2cbef86F96N7MgYXBgTYQrf8yqGnDXBvAHIpaKbezWNDSDXVlziKEyoEvPTvVf/nvsZ9M6aE
	/Tj2LC7qVkJYKhn3Wq
X-Received: by 2002:a05:7022:98d:b0:139:85c2:d7b1 with SMTP id a92af1059eb24-139a380ed56mr3144944c88.15.1781951828968;
        Sat, 20 Jun 2026 03:37:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.54.243])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add59d2bsm2077394c88.9.2026.06.20.03.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 03:37:06 -0700 (PDT)
Message-Id: <ed12a5cb5b76925cff08d2ab61efeda382b4477a.1781951820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jun 2026 10:36:56 +0000
Subject: [PATCH/RFC 3/6] commit-reach: terminate merge-base walk when one
 paint side is exhausted
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add an early termination check to paint_down_to_common() using the
per-side counters introduced in the previous commit. Once the walk
enters the finite-generation region, terminate early when one side's
exclusive count drops to zero -- no new merge-base can form without
both paint sides meeting.

The check also waits for pending_merge_bases to reach zero, ensuring
all merge-base candidates have been popped and recorded before
exiting.

The INFINITY gate ensures correctness: commits without a commit-graph
entry have GENERATION_NUMBER_INFINITY and are ordered by commit date,
which is not topologically reliable. The optimization only fires
once the walk enters the finite-generation region where ordering
guarantees hold.

On large repositories with commit-graph, this yields 100-1000x
speedups for merge-base queries where one side (e.g. a PR branch) is
much smaller than the other.

Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index ba1e896f0f..fcd1ad0167 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -201,6 +201,19 @@ static int paint_down_to_common(struct repository *r,
 		if (queue.p1_count + queue.p2_count +
 		    queue.pending_merge_bases == 0)
 			break;
+
+		/*
+		 * Side exhaustion: a new merge-base can only form
+		 * when both PARENT1-only and PARENT2-only commits
+		 * remain in the queue.  In the finite-generation
+		 * region the queue is ordered topologically, so
+		 * no future step can add paint to visited commits
+		 * and an exhausted side cannot reappear.
+		 */
+		if (generation < GENERATION_NUMBER_INFINITY &&
+		    queue.pending_merge_bases == 0 &&
+		    (queue.p1_count == 0 || queue.p2_count == 0))
+			break;
 	}
 
 	clear_prio_queue(&queue.pq);
-- 
gitgitgadget

