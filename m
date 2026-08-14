Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFDA46DFEC
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714182; cv=pass; b=UrhnKe7KN489LnOcz3PK7F749fT7+Cu4KLgR/TMzXdWDYrxPkM0WCGJ2SC+x3VPCJqUxxWlAPss/LmRZTzTtIajff01TaPHaRnASyofM5m1qxqjReXd4cUL1Y9lcWkr3MaLUnJppbnQbfthNspzMEnyOdxIEwd6mNlkgCYzROd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714182; c=relaxed/simple;
	bh=9a2FHzsnd3yDmJgKTfuzzffgIGzCGtM1PS7jvygq2D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uIBojq2ltr7o0SgOFvlJ83UcNRVLelecf0qhFSSw/ynol+2VHUueZcOOu47zWrp5ZbiZ6Z10FWnsYOTGnNIXeibI0R6JECG+YAP4y41p6oNXH50tkJzvqt4EQuVx/g0pub87xTLXfJtYOBry+IwQ6rxXu/z2UaPy3MZFlR9Wy0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=relGtW7K; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="relGtW7K"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4a427e628a9so287990b6e.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 06:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786714179; cv=none;
        d=google.com; s=arc-20260327;
        b=GCpf9Dp9VmoOapQbNj8s8Kb5pCUnDUjgPjVVNIe3LtdjyOP8hr5EdxHQCuA7WiXT0v
         JipZUib0FeiQC9hBigFXSRZKy5vgOH1NJHEdFJxCFdHeGsqS8ctTBbqBJE6CnG3Ly6fi
         0KXucPhMYdzl0TKb0DAJmnjLXq5TYTOP5rSL3lNaoyo27ltaZuatjdgkrF4JAR/da04L
         WzdXbzAQoCglN4DAZDuvKiaVpZtXQSIu1Src+bEir9UD7QZEOEOtIw/RyCbY+aOKUtl6
         C01EdLGvQwwQs1SDUanhqmVMwctJAmoMX0uLmALP2iCHESiop2uqSfG3TjyQWnSTq3M9
         TPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=9a2FHzsnd3yDmJgKTfuzzffgIGzCGtM1PS7jvygq2D4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=gPR5zargb7cfMuigvynMgL/c5jpVhshRG1QgJ2oUZt9zu3ZivjWa+5pLnRRlI7ZX24
         +Vp/SxWZVzA8vb8OBVH/X2YlWBTBONoWkYBW1WlfPLnF/uxADE5c4bY0Id/ywPul+2aE
         gmjBWvpdxKPWDKBMmoyw5TtUCEup7JBbgg+to6CxLhvOhqVqDfKfd7owmfgs8OgSncEB
         WF15pX8ySnfr2d//4qAZhqKcZHi3qD0kvaXo3rHkSnH88QxNSCahh9W85tBE0+cKRdMW
         OahfayzKyAXCLB3wHHXS1/Z/q6gDo3WOpPvPYSsf/pkIPesvyuGQW7X89ISQvTQhD/dK
         cwxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714179; x=1787318979; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9a2FHzsnd3yDmJgKTfuzzffgIGzCGtM1PS7jvygq2D4=;
        b=relGtW7KFhNkFSoGNkTsA3tztcsb4/g1aegW3A577lhqfYQ3N3QE/JoFV1LPO/2HIX
         RDs13W1iasO6sEoAY9UQuh1KaZKqCatcq1DQxppNck1SFfiLJMrn+bCqKQs4WyBuPGbt
         /9uSVXmVEFjXR3zGkwhZN8maPyjrOgq8iYWZHnULsxsigEDjrCvxIRp0PhYuT07kOykH
         dO0V7jObpwfwhjhXV4vVB4YRtwVFctck2PRTSdylkBBlnXpkLGbm2luuAmgXlu4eaGHg
         IKBV/TxoSKcfZor3KJYvJ7fTcDUpeIb4B44RATR5Isodeh+PzZx9hfDWAfaqqIKB7BuP
         X65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714179; x=1787318979;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9a2FHzsnd3yDmJgKTfuzzffgIGzCGtM1PS7jvygq2D4=;
        b=DQkGLWxJaJprU4/MAwKpJhxpl151loc+MQ1qd4Thud++jaK7JJIskiN84Gx9EDwejx
         S5e27B5ziFyhbP96ORgNJcQIxicaVMvMI+lr9mkGmiRN5FNN0WoY9Af9V8Gu5svIcBwr
         05RxKKt6tDEmSGriT9SrnQrsE6X4hdmMwi0H7XP4EIVBmt3/1kr37YADroXDOIlqG5F8
         jPpFmD6ESeeUIfeo/VIE28cAxbBTBTFFFl0qOghGzTPDTMRgo3mgNT7WGeGmJzymSsGn
         jjKnBzLdcPuR7a+en4kpl4Jlk6XpNar7kt7UaVyOVDoKRBBu5Gd7/DLzwCz3mOF8MEuI
         myyw==
X-Gm-Message-State: AOJu0YwQwytHl/RKy+1Hduj7YnQN58cUOOCH3V4Ew2HmC3upAhUe4DE6
	oPGlpVRAL+HeZt7h4sEfo5s+CT3duBu9blMMPNoh7mqI48ByBKzA4ZqJG0v3fcCAxwT+JpAranF
	C6eh+8YGOkkFl7p0xM6f5/EqTogKKNfAgnX6L
X-Gm-Gg: AR+sD11ok9vwTqig2SKlCBDzcq8qXiexj73bgUUbVC/FuRLcoqkfD7vptqf7sI/BmMo
	1cdWjAgWkiVnGIW3LItiaQQCtErEpOP76dVTaxFPBF0mOO8PkzOCRY1fKylr432CltLnT3KdLVc
	tsT4ofDmu/c+Z0ayVvr4CYGmrw7YHH0S3PErwaOVdMOqUc0VBkT6Gaw/Uz2s15fiKCvuzpWppvg
	/iYMvGdgeDFz0H6a+u/myk/meOYKu94bCDP968XXz+4wQO5sx3J0/1okbR0ZGvX3Z8tFvUVMFG6
	qoHSvoU4048uJcZUViHiGx0vW+r8ca3ptTENhIXyR7kylvyUqwZY7PHhwffpMqYUHdLol8ojswE
	omCA=
X-Received: by 2002:a05:6820:1989:b0:6a1:3ee1:d679 with SMTP id
 006d021491bc7-6b0d6905a55mr4697333eaf.30.1786714179543; Fri, 14 Aug 2026
 06:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOqWQbKn88m=OBDF7W8bBPjeOxtRsvNmhsqNy9AryMKrOKtLUA@mail.gmail.com>
 <7d0e9933-1a5f-4755-8bc5-fa4fea42f61c@app.fastmail.com> <CAOqWQb+YzvVeqS85qYjQKK8jrUqDwV01eKqC8i1jgT886ixCwA@mail.gmail.com>
In-Reply-To: <CAOqWQb+YzvVeqS85qYjQKK8jrUqDwV01eKqC8i1jgT886ixCwA@mail.gmail.com>
From: Peter Morris <mrpmorris@gmail.com>
Date: Fri, 14 Aug 2026 14:29:26 +0100
X-Gm-Features: AUfX_mwTmmoaV6edCekwj007OhZk3b3ms4wVRHOwtK0g5oVtAlo4bF0mPO79zA8
Message-ID: <CAOqWQb+XY_u2OUNnBJ9GBGBz8B73ocHWp+V1tDBS-4a5-OviYA@mail.gmail.com>
Subject: Re: [RFC] git worktree: use filesystem cloning where supported
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The PR says it only supports Linux and macOS, but ReFS
is available on Windows too.

I believe that if the source and destination are on the same ReFS
volume the Windows CopyFile API will use block cloning automatically,
so if CopyFile were used we would get this for free on Windows Dev
Drives.

> [snip]
> Kristoffer Haugsbakk said:
> https://lore.kernel.org/git/pull.2317.git.git.1780685368.gitgitgadget@gmail.com/
