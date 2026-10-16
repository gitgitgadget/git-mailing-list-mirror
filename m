Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D243F8CB
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140245; cv=pass; b=IQU6KADqLeROjd3hhGV1a1ztMCwV2BHwao0bhjly51FbRz+PYUAPr7YMtqvS+a4TseGMGLSQ8xb1HpPvNipMZaqwFFNuOgFYZEWPWd8lpmjQ3/RBLX+4dTTdDIfoOwZjL0HRmn/nvm5yBwEC/m9kd+ZjnF1mRobdAYqZua9gu5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140245; c=relaxed/simple;
	bh=t7eXBcskw513egon5AtV8uxGKao9JJXj5W20Uc/ChJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5K4Uy8oNE6rM03z8iq4l571f1oO/8L9ViIwCrDqlEVVqia8eEk8rR3TKz//b+jVS3vaSm8Zm71hq7CovQkEM3D5hyoqyYrWIV4paj9hjFSDsxJHebvIUWEEpn5qjgiCuaTHAn5EUpqLklJkuoX/fgmCyVYy+ZM8rvT0LNDrfUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8/IGbQN; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8/IGbQN"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so3770524a12.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 01:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792140240; cv=none;
        d=google.com; s=arc-20260327;
        b=rRkdzV5Bud2fsIX+4XKbjZFSUFz5zIkGcfxVRiFZQhTyFwljyh5i4o5eVwy54pbCwB
         xfkG37ysYApx52+S9TRDU6zN5fLmYAbCyUEUuT+XqnWJflURXo3T7CMAogqN/lzaLvMl
         Ikl+Z6W1JTTjHg5ZnblalhYG2t1QPKWMSoMh9CYmilL3bFWt1y/oqpyt5Ct1jENSF5/H
         lrfV3b6wiiNxjytaKXrb171IhNdQ0f4fVFDUJ68dG9jgBJWhCbUTHAxvqshY1jejLqia
         nIhxoVybN11XCwSM+EdCQ8/+ezzb7+G2RvggMHWXJxqPf0hyjvPi/eY3lMD8XMG9Eb+q
         loiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t7eXBcskw513egon5AtV8uxGKao9JJXj5W20Uc/ChJY=;
        fh=iZpTGr5uDxpJQIiB2gnsOviK/P2xq8nkp2IPFf/lhoY=;
        b=Ay8QN6tRmb+6ZAsMztNSP7lmK0H26IUOEd/6AzoEpFR3ECB8HxuC+bC/jlP58Dwhdd
         XRGotDvM1MwhugugwrqKZrDE7OkrsHYHPGYS8JFmY8OQKKNg+sKPjYKKcaM0+Exj0WXx
         mH+GG/NplaYqBa6fH7dxN4nFFpKgEwbbOgtlEU65dnvMsl+8G3ssJmTeTdiy+uKYq8OX
         nXzCZqzBy7fRSZ1ItNV5LEy5cEWV9zPW/u+LNCby7Nz3vw8pXaMRLGex7+XUV6b4ugz0
         n5wn5OK+KD+5aJWYxkwkROINYcnWnTDoGrp29J4EO5b8zbW0lG+rRmUq9Q4+gDxKUUqk
         wLqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792140240; x=1792745040; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7eXBcskw513egon5AtV8uxGKao9JJXj5W20Uc/ChJY=;
        b=k8/IGbQN3HEQvwGthLcW5c/uHwMkPuqmhHjNfjrqHw87Et0se6ewLDr8dYG21W2w7H
         AbF2/zC19DNKj69tiEaTzSVIg9s4j1utNpYbHQRw69JrJSGAs7EfW65MxvDtZYxfYbJQ
         8ogIQSbpG0mxe1pD1SQ+pWczeP5Z1KplNM0JuInyOEsdySLGwEPfMrlqUKLvA+z1BbJ8
         +ohuJwQRCKSCu56QMHnz3sesF697j2M1KSDhuQ0Watca2t+/7Ts7Ui74lLXVCr0Od5dO
         ca4ftL8T2FC2vrVOqLaE1lxDNuwd640vsHVEY4Nx9ovPYjbAcYNuGpsMunQ7h9WjKfnY
         6Qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140240; x=1792745040;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t7eXBcskw513egon5AtV8uxGKao9JJXj5W20Uc/ChJY=;
        b=jF0ttlanYdQMjJNzpwdtbRF9YWKahMbYivhIXHZbhMJd6YPFrsPnMruCBCZdSTHcl5
         5jiOBBne/4U7e8sjIqIcPoXNMGn+36AihQpqwei3QUbAr7Fzl5Bm2z/z48GjMaeUba0D
         de1FNuMmhgxJapvBrr8GDHj11lqa3ih/YIETLSsykSIyZPpxIMvDFyI1PyQG+ISHaB3y
         RLZxVqDqph6q66oLEnJrP100YRY7R25eP0BNN6k2hWbDl/uFUFHfsBGIpUuwxYUwtyNa
         n5kbfVbF9lO+3670z982/BotqUAogbxkjUqZ/YsQ/BLhs0YbdnTdGuqih5LRW+G5UVYK
         orTw==
X-Gm-Message-State: AFq9FYKrmqvczsHQCZAD/3fkjpo+voI82hiPLS27NrFiElPgdDv5v2hY
	WFDsBVH4Yzs9JQIul+IliHjFSR+tWEW6gA6wb/H0eTRAmy3QDcwVJF3dgSkszi93T/dzQdfd5U2
	HyYmwLcL6uKad59RLitiPG8y/mSp4OmD3vg==
X-Gm-Gg: AYBFou19XFh7kUclpZDula0AP96pWIwGhFm3vRhj3Raq54VAXE1QVF758AWeMaT4n6l
	S71/OhxkkgTG6PfU1aKz4bjcWRIHtTJ6rEFrmSQ7RX63Ah1WUzdhkt7ospy8MTpurzXUtI7RlFy
	dT9yVM5FxNToRT8+WCPIdjfo0dOA+q2+esBAUj71/fEZdh5NLtcrCibfrehigEBVzr9A6FzB5lq
	d0XW068xTZMb1D4MFIQBO+L5TTkfHPuTbVIjYc1pPPajq7w7lvbnwQkvpEN/H60Qa2nYlKcjmGi
	Cmn6sa+DotdL0Vg+xipB2OlW1V4dS27C9kt5bNP/am3V30mGozKfa41l
X-Received: by 2002:a05:6402:42ca:b0:6b1:b0f3:35d4 with SMTP id
 4fb4d7f45d1cf-6b1b0f33886mr12796715a12.11.1792140240497; Fri, 16 Oct 2026
 01:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 16 Oct 2026 10:43:23 +0200
X-Gm-Features: AclHuK-4yYoxUZ_o9dSQ2wP_CM2T3RH_1zfS6uqQnWlMnZDbdOQp5S_tZjzxO_U
Message-ID: <CAHwyqnU3Y+kGOB7-E73dr53OV8dTcjNzZWU0jYSLf14=j4Ygmw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Address overflows pointed out by Coverity
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

> This patch series is part of my effort to bring Git for Windows' Coverity
> reports down to zero; Previous patch series have been merged in 347fe8a91b5
> (Merge branch 'js/coverity-fixes', 2026-07-16), 0b75ef5168c (Merge branch
> 'js/coverity-fixes-null-safety', 2026-07-19), fcc8c931b53 (Merge branch
> 'js/coverity-unchecked-returns-fix', 2026-08-24) and 8bc9c7fcfd8 (Merge
> branch 'js/coverity-fixes', 2026-10-03).

Nice! Can Coverty run as part of GitHub CI? If so, once we have it
down to zero, we can enable it to stop issues from creeping back in
over time.


Harald
