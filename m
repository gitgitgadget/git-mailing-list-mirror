Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350E2F1FFC
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265976; cv=none; b=R2WZ9Ks8ynJ2YGNl48sRreooDXPPn6JsAse5FukvoE5RXIzSKee4G/DWkNfriwBnaaHzQMCtFLAbSGu6u2AtpAtms//JNM+2TwbI89XDGHvaNye5XQtAFzSiWC4NaRsH9qK1FJfJ9zuCUmtS7QSM0gWjc710lymYbEzrSNf7SeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265976; c=relaxed/simple;
	bh=D/AgnHVqBcw8Qc67W0Z4jsKvBKEqtsk2ymvihEe9W+o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k67hM+zRSOQsE7vpYNdyopZgbAheFstgV0Fw9UfQyx44ZXFIuOU/dgAIttw2oo3sRmHPqqngcdeNLWT3AyewcpKouVheLluteHJmK1aI144ZAJdrr2isTy1FCDCMsHHJ46jFlrV/WDPs/7SoYr4IT13xuE+Vk8hqM/82TXwJ180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ4SrGou; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ4SrGou"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so61493995e9.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776265972; x=1776870772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5y0rrhRJNNE3l/P8xNAhrQJxWG8MWSBD+auNykfIsA=;
        b=dZ4SrGou8SwIgdbeIvwvjppNJRmuT1Rx+BkT19M+ab6x+MkxUK7PevnTbRRzsAI3ik
         WdJMA58Po15/BEeFeHpcy7dA6J51a4GWYeq3+trAvL3+qdeBw0MU6jz1lpT8kDHspEod
         SIADfMWlOAevXtrIFxHvVEgIEVLjoLvA4q8aQ7Li+Np4RyotSf+xX+nUvC3/MhZhaVBr
         klE/UzZYfShEqOzvMnK70/3NnIucdsXNz8J+Y3rPI9mdqLT3QJmRjdj2y8SKgLaQevnM
         GopsN0VAGTR2FijabKNYURPX40L8OGRmKm4BP+1Vun0UAgm0Qm0aAPFhPJdOyMPh9GJJ
         Wxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265972; x=1776870772;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T5y0rrhRJNNE3l/P8xNAhrQJxWG8MWSBD+auNykfIsA=;
        b=Sxm622gQoXFL1Y2KgwQEuMpWnFQgbl4alm60wslKS8mMBJWZn7aXEp9FVT1mfg9mip
         tqsp1Myulml3OJ31s0Sj95MkloihFT5CuVY1Y1Mq1grcxHB7aQ3jMzyeTzCyuT4adqQd
         KnZI+9lMikOvqFuNeJ+ZdskSEeQn2itHUYNKkh7FPUTmkUOEoUOiT+Nc4fE7rw+ZXRSe
         d+lGyus/Z7Ymaketw4c6ypXphkD0gbPMekaaLRXItadsyU1Xgx7YbSjeENp7IKlgyeCd
         Yw8ulq4PITw1o6P9hJlsmuddVjQH0VmwqOr7xt9ZsxZy3DgvN7UR9ZiuUEonvyoeRnBr
         BAXA==
X-Gm-Message-State: AOJu0Yyih7souBHSc16ol8voz0Xvcl5xvrwCGh7FTBUAat/ii7ycjoKJ
	xk3HQwY+l7YPyw+nKK3pRMgmIoN05jZ5ZeNHwng4L/wOW038GyjUiT+w
X-Gm-Gg: AeBDieupPFDyhT9wG0MEJlhK8cLpMoKjaKejA235k4DGrAe+bbptytjKCECeFwwJyod
	2OVQ7E1IiVB+2G8P5x/MnG8KmwH3OAAli3fyElvxBtxnrp4xVobst8MUaMhlR7P4L/Pu/MN7Fwb
	Am9gC/HuUMkh2TbaRzeFp7c+3KmwjWnjLV2G7OmP3iH5zdg3Pg/5WJjwOtfP27HHF/VEV/Mhd3e
	42UtM8Z5kRnbevjWcC/7T79Xi24WbGmbtaQQOlYPPiU0YJ/GrepEg9ABvliwovXM2G/A9ybZzeq
	eVUasSw0KiBovh7W9gfpRCrhK0to9JUMIet7YxBDqRMS461OQjppGSZSlv/C8lv7myOcgOqpttn
	YtPOkjsdH8tAXG6WAf94e2TZ6JReNV1l/UvzXuPdzeubfivYncMUElNR6EZBoyQejxR3ovi2Qfx
	whNeKlk0jUmK3bN29D7uooxzaAIuoTDrrTkNvC6EEd6vs6+lsiw+WQqJf1n2UK+bnEeNQgL5/LA
	Twif7Uze/r20kem
X-Received: by 2002:a05:600c:4451:b0:485:1878:7b8c with SMTP id 5b1f17b1804b1-488d684c6bdmr256404995e9.18.1776265970692;
        Wed, 15 Apr 2026 08:12:50 -0700 (PDT)
Received: from RTX ([79.117.197.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488eddba112sm145159745e9.0.2026.04.15.08.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:12:49 -0700 (PDT)
Date: Wed, 15 Apr 2026 17:12:48 +0200
From: Jimmy Aguilar Mena <kratsbinovish@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	kratsbinovish@gmail.com
Subject: Re: [RFC] worktree: add --recurse-submodules support to git worktree
 add
Message-ID: <ad-pAL9wDZ-KDfcn@RTX>
Reply-To: 823d30b3-b355-430b-b8af-c8421a87b0aa@gmail.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Phillip,

Good catch — let me clarify what the script actually places on disk.

The hardlink copy does not go into $GIT_COMMON_DIR/modules/ (which
both worktrees would then share). It goes into each worktree's own
gitdir entry:

cp -al $GIT_COMMON_DIR/modules \
        $GIT_COMMON_DIR/worktrees/$id/modules

So worktree A uses $GIT_COMMON_DIR/modules/sub/ and worktree B uses
$GIT_COMMON_DIR/worktrees/B/modules/sub/ — these are physically
separate directory trees with separate paths.

Within those trees the files start out as hardlinks (same inode), but
that only affects disk space accounting. It does not mean the data is
shared. Git writes files atomically by writing to a lock file and then
calling rename(2), which gives the path a new inode. So the first time
git touches HEAD, index, or any ref in one worktree's submodule
gitdir, the rename breaks that hardlink and the file becomes
independent. The other worktree's copy is untouched.

The only files that stay hardlinked forever are pack files and loose
object files — precisely because git objects are immutable by
design. Two pack files with the same content should share the same
disk blocks; there is no correctness issue.

The net effect is the same separation git worktree already provides
for the outer repo (HEAD and index under
$GIT_COMMON_DIR/worktrees/$id/, objects shared under
$GIT_COMMON_DIR/objects/), but achieved through the filesystem rather
than explicit gitdir configuration. A native --recurse-submodules
implementation should do the same thing explicitly — probably by
running the equivalent of git -C <sub-gitdir> worktree add for each
submodule, which would give each submodule its own proper worktrees/
structure rather than relying on the hardlink + rename behaviour.


Signed-off-by: Jimmy Aguilar Mena kratsbinovish@gmail.com
