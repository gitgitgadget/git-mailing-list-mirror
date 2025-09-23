Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91E305042
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656712; cv=none; b=Mmusr1+SS8UM8GGq3/jBWEGAkboFMC5Ke5gZKmMosct73L1MSatsQafWDtQ5fzozrASbxx36VZdmu/qbxh4InSYdgCn3h5uYGNfydcHnOMJ07kkMGha1TORb/kBrrBw06Rk1Se/Q/w983vYQmizAtQY5HIKwhcOeUDhy/k+BjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656712; c=relaxed/simple;
	bh=s6FoP6rsTkKVh0jyDbNOsdQE5/s0YB6PpOt9Cj7exOs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I2599OBo8d9TDSCqdy3TUv3mrQw0hjjRSUh5mjG4TO4FrYW3xOu1O6MGGvvPYlqqSZDIxx+Ma8tmLCLth22NeCuStVO5y3Mjl3VQ8Q9EM8aGwPHGmXff3V8aZyDCwKOp9GyBITjDG+7zLFnEAu1VvbFDEwOM2VgeqLaUjLkMqEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2Q6ukPO; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2Q6ukPO"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8ca2e53c37bso218059839f.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758656710; x=1759261510; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gip/vi+1x27mVei3wwIqhR96rZiM3c+isDxtcSiWIX0=;
        b=H2Q6ukPOKuygqKZiH3p21CaZXg63XRhKPq57dvAzdGTXeMNehYGYr6eSOgP2Yejj7u
         U3j0J5qCMbuKkTs5kiWX1fQdAbwwFbWUKx/pGFUk0+9vLH88psJh3Bwp3oYMqr27hzdE
         pN87/SPGD3FTX7iI761RScle30m+8iSHJQFpeSZZNW4pQjveLdT3yJm1nd3HfiPmjWxI
         xf7ebKXTdngACT7yTysw2jvqIF4wfMbU1j181pqHR3EG2wUyPzWG12FXh1O+Hk4qFP06
         uas1DLm5MRpn4FJFD3Hjbueb3tBVS28WLYLxG5NOlNw41hfylywGk5YwnCAcWPiVCQUT
         OaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656710; x=1759261510;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gip/vi+1x27mVei3wwIqhR96rZiM3c+isDxtcSiWIX0=;
        b=iZjMq1vtcsADkFV1uP6DCho6vUaQw9lT92VInk8HZbCnj5x0ls+YPEfThdUcZQJYkx
         Uuof5EMue8YoUwcz3Gf0m4GRPeYt7sWDIrLA4/IoeLRtd3atSlTaCIdEi2D+Zt+vQjtb
         FXmB+Ye6ibTYnC1I/Yd5pQ1GQPIL8ZFF/NOsCgdiratHtz7KiPziwqF95rzmn6gVnrZI
         hRuQHuMhSTICqttba6J7tH/7hTebgmspTSfneQjOXFY6A22paRYAn8VFRgZnZdxm7CNw
         kN+PCjsxbSP5rWRXweNEhf0mCf6k37ORZu0jpxRhiZNsMEU68ZE6X/oGcHXilVrmqmKi
         OA1g==
X-Gm-Message-State: AOJu0Yzzz7OhPQLU0O4Z5dpOGQwWJwwYRntveqsX+clLfCCjjRfXMN8c
	EpSCOu/JicdWwgHu5LOCqZVd2f6zRiUqy4hfrOv1p2si74I/pwm94ENprbbY9TCX
X-Gm-Gg: ASbGncuUfu8rdg+oTmJh+3oyIcD+zu7KtV4VwJLP2fTrjK6NRitRdCvps/lqExDpV+m
	fNO3TI6XzxNrdbR73Vgq3TI5OHB50leTL6wH/6sjzB4+OqfIwI0vsyZJME0k8aaf9HLWOdPMb34
	RgAN8oOpn1ZsQZSZO8I42p1aUEqH+9gVxKKGmiV9PcAhUkXggYEmIxUWkdt3AYLvT+zXWSxljtQ
	+72vppfTDfUhGgWQHmkAhIypEIeszydz2mKkzwAfQihEvsty32ER0A/ld2vyddarwWaX2aVzXW0
	S7vY2i/Yxubtb4K9XtpI91o0FoInE3z0FuGvC8g0vBlnV2aIf3D/zFv0ZVkpoXvVbCnzK6ERPPn
	1u1492QaPxAjIgth13hFCRsTK9Q==
X-Google-Smtp-Source: AGHT+IHKQX0oXvF6/Isj1BK233hHtswhhNItgmO0m8xaDAeRwE/F3w5+3aENgq1xKUH7XPSGx/fVyQ==
X-Received: by 2002:a05:6602:6b19:b0:887:3efb:6114 with SMTP id ca18e2360f4ac-8e1b8fc458amr760276439f.1.1758656709839;
        Tue, 23 Sep 2025 12:45:09 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.130.210])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a4804376a0sm565058439f.19.2025.09.23.12.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:45:08 -0700 (PDT)
Message-Id: <ffbb9d7c6aff77f9a1caed86a20bcc6b9afe66e7.1758656702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 19:45:00 +0000
Subject: [PATCH 2/4] doc: git-pull: clarify options for integrating remote
 branch
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback:

- One user is confused about the current default ("I was convinced that
  the git default was still to merge on pull")
- One user is confused about why "git fetch" isn't mentioned earlier
- One user says they always forget what the arguments to `git pull` are
  and that it's not immediately obvious that `--no-rebase` means "merge"
- One user wants `--ff-only` to be mentioned

Resolve this by listing the options for integrating the the remote
branch. This should help users figure out at a glance which one they
want to do, and make it clearer that --ff-only is the default.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-pull.adoc | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 50af7fde81..61d18fef36 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -15,17 +15,20 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Incorporates changes from a remote repository into the current branch.
-If the current branch is behind the remote, then by default it will
-fast-forward the current branch to match the remote.  If the current
-branch and the remote have diverged, the user needs to specify how to
-reconcile the divergent branches with `--rebase` or `--no-rebase` (or
-the corresponding configuration option in `pull.rebase`).
-
-More precisely, `git pull` runs `git fetch` with the given parameters
-and then depending on configuration options or command line flags,
-will call either `git rebase` or `git merge` to reconcile diverging
-branches.
+Integrate changes from a remote repository into the current branch.
+
+First, `git pull` runs `git fetch` with the same arguments to fetch
+remote branch(es). Then it integrates the remote branch into the current
+branch. There are 4 main options for integrating the remote branch:
+
+1. `git pull --ff-only` will only do "fast-forward" updates: it
+   fails if the remote branch has diverged. This is the default.
+2. `git pull --rebase` runs `git rebase`
+3. `git pull --no-rebase` runs `git merge`.
+4. `git pull --squash` runs `git merge --squash`
+
+You can also set the configuration options `pull.rebase`, `pull.squash`,
+or `pull.ff` with your preferred behaviour.
 
 Assume the following history exists and the current branch is
 "`master`":
-- 
gitgitgadget

