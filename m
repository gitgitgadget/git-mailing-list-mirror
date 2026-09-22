Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05663E49DD
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 04:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790050509; cv=pass; b=aP4HUe2zqqTAm/2kkM//kcuuLTFpcG5qpkENvpXv5oQz9vYx+KNdkqOKVgwRAZconoYZf8UKDmzcMqlCBNl6aYurpPHMeYD6vyXPX+kXtgC+jj0/vIe8UYVl2acsorHC1XB0aHzB6KIFkSRRoSVa6ubBfhq0cvAqEvIIjH3+dLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790050509; c=relaxed/simple;
	bh=zlV7HzBQiYqJZtaPddkpoVPUAmPcyrDgkLtliJ7oH1w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OT8eYzqH8Hqed+Yv90zu0yROfx7aPzuaSUNtOQF0LrRKuQyBPDwj2upJOPobR7RUaxmA9aQnJJJe59hYzt7IhndvEq+VMCKb+szRoWcZL/N5rdu9KfkCVHFPee6p3UvcHWYCBrcD7I+iN0YkY9L5rvhKM7x0Pxv9yWaDn+dqm4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTM3KcOZ; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTM3KcOZ"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a36de66c0dso35772111fa.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 21:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790050505; cv=none;
        d=google.com; s=arc-20260327;
        b=UYxJJv0W+CpuI4S7OO5jQe8c0gImZHUmw90gHhmOjdHwhUADGePzD3avz+g5h6d5oJ
         qyOzCiGI6DKjvs76xYUI0fPzn7zoLfvMQfk862WGwzGzbOOO3dr4waO6OdhLbDRfb3HF
         t7BZxRDIELUiReSHx8Pl8LhlnVUpkZAU65FBn1/WIxWWR6bFvg1z3bBx2AQsAftIyYjj
         x+a8Q9ay92UWgcLpJzE+HKhkHW/lz/ZtjGB0a01hbdGVjoVsYCmYN0EDhsS5kr3aGipS
         12l24p4Dsu5xmba0pxdz1ouAw2oxH9LmL+/CqZl7dJttWoN0O2yd81tS6LMoOwtcvZh7
         UN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=zlV7HzBQiYqJZtaPddkpoVPUAmPcyrDgkLtliJ7oH1w=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=J9E4JQC2iWxf8dGezSpS/n4mr/U870DU/gWlp9R2xu0xrDh+csRG8qV9DPyXAI8HQS
         VRhBFrdtCDFG4dIxX8tfczekarpHwRTWQaKqfuoWR85P1IdE/cU1IQf58lo8gL+w1EsJ
         cqR2j3mA0DHM3dpF6bs31Z9z5YQbmGeHqSa2W5JSYVbURBX/cHH437z2aEhwY5q04Mnr
         3ppTMgcqMkZ96ZL95mHtxDwClFERpvlwWgB6ExZpdewzRMo2ezUnkzNOJKH5i8wkesDO
         /5pHK6TqTrfniVcKW57lxBIWTZibi1BVLSjpJKbLORdWlbgpZNvyFbvT5cdCfHcAI+sU
         myjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790050505; x=1790655305; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zlV7HzBQiYqJZtaPddkpoVPUAmPcyrDgkLtliJ7oH1w=;
        b=mTM3KcOZsqY4JN1mWxiRo4FXMN+7DbSmz+p0vxy6PD0921bBS7OL4p60eWbWFFmaZT
         54ak9EIxMLiRsDuRfI+qT/5mv+IgVQg0DBhDKFC2E8dTt7RF2R4WtQajUSwSLkJsjbWf
         eLNKa2/p4n3Vf+yC7S2JGBfD5+ur64U/jkoru2dbUemXB8CsjSb26mBJT70NLcqBYuHY
         Hni+CmX1+gKp7+00fSSNUBKdFUep+/+FC2R6sCGXEQIB0WqYiulGMFAhBc2Mh6nAxPTI
         Nhy4ulctj1q2sNHG0qPUCSUR4fykTVwJ8m3AxnL1SjGZiU2GgPeqJ45F7KfCtg5UN5fG
         aNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790050505; x=1790655305;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlV7HzBQiYqJZtaPddkpoVPUAmPcyrDgkLtliJ7oH1w=;
        b=fLBf5cXLDAyI/7qw7odiZEEj4MSBu+KI+1Vgfzq18QbhhIiNe2TbS6TU9mht1/kGJV
         bs22Rd9CBZ7mSyG1VsAMnfzhKN2Nc7u2jUQ260hwhZSmV5zEdsxB5ka2PRYYtIPxwsoV
         4SRIDTIMAo83S1GDtiJgMRKhnFz/4efLrbc2z9RLQoLh2fHORXpzW438vvGVr0kjmoBm
         yaWJvg6OM6lZ0Hr1zZJTeyzhiyQFPpyC4qZk0d+QY1zZDGlq3/KA3vX9OCW8U4IBnZeY
         OKQE4h6r01C6pysbYTh0ycYyMS8CvNnUVhDGp5iak/Ry5CCTAnksl7ig1W1c0+kdvqCH
         Al+A==
X-Gm-Message-State: AFuF++nDB/6Zja0RdD+YZYXSpycDvYk3V07tXH7VpTVdKK4Yp0FeulTI
	jkgh+O6gGz4kjJ5sQklxkfavLuFG7xbTToqecky6hlEPeupB3KHBUd/w/1XE7TkBMGVKF8UNvCx
	hlHqn19a5eya9nmb/AG1+uhfhwdrdULXzGJmF
X-Gm-Gg: AYBFou1TA4OVz1SbhHKK1bwdbx8Sj9rMZU7sKv1ja5hraHvk02yyTAjkHjKoV1yb0rr
	9Ve9qk8NVSDEkjGxilwxOvF1qrLeIirZ8988b74Ay9lizZEtKbxo1s0mBz5qR47CcPU3+ZUNyrR
	0T2eautOaYmgyFlGqKbr9A4xQImYSGKmmEyrig06SJB9dL17Khhp1RtHBCy5b1fKC3KY+1C+4Z1
	tAFqfzefBEATXGvzP/Tx7NtLxhtE2r3BqhT/mZj53Zt6oQxJ0xUait1ZSv4q67p7XQGXEn3pD4s
	cF9C4YO9T8YohxGqc1IOSmMfNpBolxMvSDNQM+JLjBVrd8Drtw2p
X-Received: by 2002:a05:651c:199f:b0:3a3:7682:49a1 with SMTP id
 38308e7fff4ca-3a5fc0a8e42mr26887621fa.22.1790050505392; Mon, 21 Sep 2026
 21:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhonghua Zhu <secondsquare@gmail.com>
Date: Tue, 22 Sep 2026 12:14:52 +0800
X-Gm-Features: AcwNN1V_cGU4aOpQdbsZmEKkDtFnn6T1TUVjSm3v-zcEKsbLKcKS_709ZLNdJiA
Message-ID: <CAMkxerhJjjv-WUw2xte_2hyJ9vZ8MrRyaTRV_YERoxFAo0qE-g@mail.gmail.com>
Subject: mono repos and permission settings
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I wrote an app to let git host mono repos and have permission settings.
The app is composed by client and server sides, which are decoupled.
The client is setting sparse-checkout rules, but will filter dir and
files by server's auth response.
The server is a proxy layer through upstreams like github/gitlab, but
with per user's permission settings, which is absent in git world

Link: https://github.com/zhuzhonghua/blackgit
