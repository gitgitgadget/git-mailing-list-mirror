Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC0358372
	for <git@vger.kernel.org>; Wed,  6 May 2026 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107418; cv=none; b=mhvotUNxq0O7pEnZaSr+z7AJbgD8Jrn/DvuCHkSh2udxsJaXXX5k3ISES83QCJV+P6ndUEuhaUxYQQ34SOjtZSZzSBGpuGF4rOTqJ+l938QDfPabZRuES1uw0L49HoaUAmJXWTDMLcsBckBS+/O5Q2yoTivid0JPlGzH/2B5lYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107418; c=relaxed/simple;
	bh=lUL5tsgX9lkQe6s8thp4y0ovupzIJQu5gCX6RMKc39U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dktWw8bjjh3OhewFqhdYkUJiAdt6HVkEv8m3yXWXNGpHNW7T0Tyq23iLlfTUoM+JeeRnIMS60Z1i54aQ0sSzOvm0jAi4li7N+BuwRiMkpHLLcfPzhaFz2iFcAtTx7kwkLc5vGfLne8oUupd+0Zb2znrMUStre6bWi2pM0BMgO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O85u/u3v; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O85u/u3v"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f30a4601bbso244315eec.1
        for <git@vger.kernel.org>; Wed, 06 May 2026 15:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778107411; x=1778712211; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTS41l/neqh/2ebLcroamoZAT59InKvroh5DNsqioI0=;
        b=O85u/u3vTq9LQoWuNJV8T+S8MmVVdhjBePukljMlL3SOn4y2fnTuNBc92BnEWcY+Fm
         GLcxN7vewMhowQ4NvE7SAtJWxO4S7bH/z5ZBRb4L1AZKbDfznCryaH56/xVahTekep8B
         1vmCuF0agoz4eLQsBatouCbF9K6C0u5qDWXK3qFtWb6cZIn4l2CHPLv8fmhxs6HVbXHu
         KFFQEQhC3MQoGQYw7RH2SKpKZ1qbx8mJBbbk4+YHWHmW2vITZYcwfHs98fFJInubYNMK
         uHNiKA+SNhhcK2eiGM86/FlZGIcWN+++N/77lhvFBj5niPVo95EajWpvNLf+ZhPAKKUg
         j3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778107411; x=1778712211;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jTS41l/neqh/2ebLcroamoZAT59InKvroh5DNsqioI0=;
        b=Eeiy2hVJbiO4Lp/YCxaaJjac62T25kOmrjEBNO5VeGPuYfN2hsg3jbN78YcrPW34Iz
         ygqp565q8tibb/z+ax4sw6//ESBOJyfKz+qIpM3Q4FynMY0tgaZJjhjMpA1SUV698dyi
         FuxrqsSvSgsgMbp32uPZgo0F4ewtiTyU2r61fgl8uV1QJZnssww9V6iBiAnd8uSJSLWu
         bur5PMp2D9MMEh8VnLQurwNGBaBebdI4L+CuJ4V3ISUi/ACykQ25MNRcwGGMtdD+GviJ
         CGcW1kayZfxzLu7uBHm0XWPqhjurpZRxLFXSUBsXUzG2qvBFvOuMw0Gdk+lEocNnrrUb
         o4/Q==
X-Gm-Message-State: AOJu0YzXKbJfMqsYkDOt1pRS65uM7B5G90+s/Jc0ufxDJzmEKRx3vJdO
	zBg6Z2AWjVRhbm8dgLwL6hBheram0LjCM8ifrFTIReXYrNvVnY3jAczbTexS6Q==
X-Gm-Gg: AeBDiesAuRJ9zLhGxahvfWJr21fNZ2FNO0AXElrlWT883ycVKz0Apwms6iYCriM82xz
	xG0d2jIq/iPssKqqON+HfjKgLTf3J8YNC8Yt1ia8391YoT+drVRMkd7I1LD/NCB2sxQp2TaKTjZ
	41/Ixj1++Qj2eHdQBsLtF5sRdHqhGtYdXmDtQDxEL9ENmU6Brarg+Qa9QKfaQIcdpS6B+WQVGrT
	ztvlapAGtmygW69wBHbOKqZ/zuacYGkeSdvLz1EBRxy4iUE2Nav5f9DBRdtEwI59MrEXRoHb6Gh
	MNqCyOAfJsCnhYHsy1v9Jjx4Te2c4D8EwfzbKmcYTyc9pG6GdZiXpC7VhnzMN/zdtkktRzDFPWy
	d0uBAEfD4/5lH9DtFa1hz/nOQ7teOZaCEBs790a/UDdReoAMQU+4hPpGacYHmh2MCnkmtBnbyOD
	uUqIGJMwcJ5IdWbTWS5mF2p8BNKQerD7dn6qt4Rw==
X-Received: by 2002:a05:7300:3b24:b0:2e2:27bb:a4a2 with SMTP id 5a478bee46e88-2f54c480e37mr3128480eec.13.1778107411043;
        Wed, 06 May 2026 15:43:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56cec763fsm5687404eec.4.2026.05.06.15.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:43:30 -0700 (PDT)
Message-Id: <1dfbd26d757e7e610f8ef8058d839f103059b733.1778107405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
References: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 May 2026 22:43:22 +0000
Subject: [PATCH/RFC 3/5] history.adoc: describe merge-replay support and its
 limits
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
Cc: Elijah Newren <newren@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Replace the blanket "does not (yet) work with histories that contain
merges" caveat now that 2-parent merges are supported via the R/O/N
algorithm. Spell out what works (the user's manual conflict
resolution and any semantic edits inside the merge are preserved
through the replay), what is intentionally out of scope (octopus
merges; symbol-level extrapolation when rewriting parents pulls in
genuinely new content), and what still requires interactive rebase
(merges that would actually conflict on replay).

Assisted-by: Claude Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-history.adoc | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 24dc907033..56328a7c59 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -40,13 +40,26 @@ at once.
 LIMITATIONS
 -----------
 
-This command does not (yet) work with histories that contain merges. You
-should use linkgit:git-rebase[1] with the `--rebase-merges` flag instead.
-
-Furthermore, the command does not support operations that can result in merge
-conflicts. This limitation is by design as history rewrites are not intended to
-be stateful operations. The limitation can be lifted once (if) Git learns about
-first-class conflicts.
+This command supports two-parent merge commits in the rewrite path:
+the auto-remerged tree of the original parents, the merge commit
+itself, and the auto-merged tree of the rewritten parents are
+combined so that the user's manual conflict resolution (textual or
+semantic) is preserved through the replay. Octopus merges (more than
+two parents) are not supported and are rejected with an error.
+
+The replay propagates the textual diffs the user actually made in
+the merge commit. It does _not_ extrapolate symbol-level intent: if
+rewriting the parents pulls in genuinely new content (for example, a
+new caller of a function that the merge renamed), that new content
+is _not_ rewritten by the replay and may need a follow-up edit.
+Symbol-aware refactoring is out of scope here, just as it is for
+plain rebase.
+
+The command does not support operations that can result in merge
+conflicts on the replayed merge itself. This limitation is by design
+as history rewrites are not intended to be stateful operations. Use
+linkgit:git-rebase[1] with the `--rebase-merges` flag when the
+rewrite is expected to require interactive conflict resolution.
 
 COMMANDS
 --------
-- 
gitgitgadget

