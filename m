Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A5E345740
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370389; cv=none; b=jWJx5qINChIdnEuteuf24TkVRz/8SHnr7kdrk7TW9SNp8FI6EmZRBIbIBTW3ripRExoxwoYY7xlmni9GqZMa/1dZWWtsabH6yMxqzuqQgLebmbFpw2qWxyUUv7Cz1nNp1ExAYEECm7Z7HVzxQa4sePrP3GCe4fSiKDZHzhm2UNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370389; c=relaxed/simple;
	bh=oQJr5YlF/6jCcqeI/kRcJ0ouEyCH5TuqOuoRc9f7evM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXIwpfifqNReVGNbEAsd2Jlqu7/X1KPplyC09K+s6dUlPDm3/lBcH2SBV6d69TTGLlKwM5XAo1wspgIxSXgtb8Kix3/yubzVlcydHNQwj3yHVjeh93VC0E/eurDqOUbAfvVEbX9KH2wNFGoa+RGiOuv2ojR23D5rqGKV2KZVbtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChT2nYfT; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChT2nYfT"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a79998d35aso15315015ad.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 01:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770370389; x=1770975189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4177legnpo0s8KmfMo/Of9kPzaHTHz3fsChAQiq1OM=;
        b=ChT2nYfTCVnvWJGa0KnFdpQ9QUmUIeOl9oa3kzl2hcWP1FNzEL6MMVFV46KMNxyKka
         U1dJte+zw20omKK8J7bWA6bkEtWLuuNxexPoVDvJ5cErZToFSo62R1OOSnEQ/fi/KvrK
         +vpC5ETf6syrf9MkrYbSDzNEfFNTNyipldicUK5Ul5ZZOv86oUmHHuSo0eRW4erwKE/v
         TXIORYX69YNzRCH1v9HpaDxTgWf7rR2CRSnOAP93ploRnBuqzBwbUa2UvSTov89oJOpT
         uFJeh7TCPPu7b1qJ+tsgWYl81wpxXh1SDl5xLZdlcdzhGD5LhlDjCd4eovtR63xQktnC
         AokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770370389; x=1770975189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k4177legnpo0s8KmfMo/Of9kPzaHTHz3fsChAQiq1OM=;
        b=WpPTTj/m1ucQKbSn9KObYhu+PpSq+KXUuqINOWvJuQpVi4U0cFjzOTmwxyRE5rsUeb
         4u+LREBWJdoOjNv+ZVMdwW9lOVEVvW7u8k9/1USRWIYxhw4O3y4TPxKY14eQT0yprf+i
         KOgdwI1UPRYBWxj5FZlYH8kqJDwpnjNaSil56pDyyrUPxpPFZiCriPdwtNViGt9gOvNd
         3A4UgJ6D+eMRoJP2fbqopAiRn2NXTmLhfw8VrFlcflZItKGPd3GQ2kX8YNaSBG7t6oUK
         reemdocirPnHBkvQltQo+Hfqud0iPKhIRqdFbv0dQ31g6N7NWTDNk3gLwUc43+uR8hy3
         Cu6A==
X-Gm-Message-State: AOJu0YzKuOd4/IknGfJ+jE69x/PKWdxDAfLPJGdN83qsEXBcijX5BgdA
	T6PP7qNlncFAP9PVImQrjLqLciSIAxVV5u46UGGuSgNNL5P2O/srohuXCtKFk0ys
X-Gm-Gg: AZuq6aKRWLaOTX9OW9YdL+Utghb9kfiJ4XQPyISAEZlHPELPxyUswCeXr3L31NG6nkQ
	T9hRnnBPfCQX3P2UvnudW3VzxL7EnTbTSDBwOdOrNuFjUWFR2MLAeeGmR7pKQkBxfwqTVA4XPuh
	xvjrhr5Yf/4GrAfacDYi+DvoavUnioziXH5P4tM/lcS8nyJiXiLYibndDoThsfCjjwxLTMTrO5p
	Sn01K7lSCbAxPXUBnGLDqiwS/DNCdOE+zmKzIVRZHr9PDQG08qLnNPNmF5SIkwe8CPfJuF0Qo59
	yBRyeK+2YTd42ju2se2JKAgrb97Q5gSPIoNimAp/ElWsFTDFBmz0Q4FrHmBxonbiEa0sTqRcVCs
	1IhHNSD0CK2EVeUz+gTmnrbGBCTkGR/NOtrOaPBghAd5+Ierzv/azYwFORHkJDrylX1egMJ0l2P
	sv9IWkVzOK+3NWSJOUOtPouZkxHkLiUYygdcq3/98PWraAle4=
X-Received: by 2002:a17:902:d58a:b0:29f:2944:9774 with SMTP id d9443c01a7336-2a9521f3218mr21720365ad.33.1770370388798;
        Fri, 06 Feb 2026 01:33:08 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:2479:7de1:4f9f:e55e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c9189bsm18937755ad.36.2026.02.06.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:33:08 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status through function parameters
Date: Fri,  6 Feb 2026 15:02:29 +0530
Message-ID: <20260206093257.1178858-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAOLa=ZR21J6sPDh0cUgzv+td70Mwck1-Ev-43OtZ7mYBX17z5A@mail.gmail.com>
References: <CAOLa=ZR21J6sPDh0cUgzv+td70Mwck1-Ev-43OtZ7mYBX17z5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> 
> >> > Some functions in wt-status.c relied on the_repository because no
> >> > repository instance was available in their local scope.
> >> > There is also a specific case in wt_status_check_rebase() where the
> >> > worktree can be NULL, so accessing wt->repo may lead to a segfault.
> >> >
> >> > Update these functions to accept a struct repository or struct
> >> > wt_status parameter, and adjust callers accordingly. Replace the
> >> > remaining uses of the_repository in these functions with the
> >> > passed-in repository instance.
> >> >
> >> > This removes the use of the_repository global variable from
> >> > wt-status.c completely.
> >> >
> >>
> >> Okay, but this doesn't fix the issue I stated in the previous commit. I
> >> do wonder if we can re-order the commits and pass the repo struct to
> >> functions like 'get_branch()'.
> >
> > Sorry, I didn’t fully think through what you were pointing out in the
> > previous version. I initially assumed you were only referring to the
> > specific call involving wt_status_check_rebase(NULL, state).
> >
> > So struct worktree *wt is not guaranteed to be defined and can be
> > NULL. Because of that, relying on wt->repo is unsafe.
> > Instead, rather than depending on the worktree for repository access (wt->repo),
> > we can pass struct repository explicitly through the relevant call
> > stack, like in functions get_branch() and wt_status_check_bisect().
> > I hope I have understood it correctly.
> >
> > Best,
> > Shreyansh
> 
> I would say its not that black and white. There's a lot of context
> around it. There are places where `struct worktree *wt` should
> definitely be defined. So we have to take it on a case by case basis.
> Which is what makes these refactors a bit tricky.

But lets say if we do pass struct repository explicitly wherever it is doubtful,
rather than relying on worktree, does it have any downside ?
