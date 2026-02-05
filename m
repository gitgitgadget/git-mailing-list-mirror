Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C492F5498
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313327; cv=none; b=f0ZLGt2VecV5TuyaqQ9P6ZWOcQpHRst3UnidOm0RxlSb5yX1mD6NPc8X9lcXquD7Lhx9tWGR/yUao2kpOQ42oI6dcDIkf2SmuNiTAXloFzfMoEg8QXtTvDJMSIFeSdLhJNUbxlBNNCqEDvGSSPbPShwnNfBKzk295L/+3PKR8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313327; c=relaxed/simple;
	bh=RwdEpterEvIJmHPalPsJmTDEM3OgivV3XDi4aUMZjps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icDYH/zFtN9jWKbQkdVgC9/vOH7QsCAGu44LW66r8QnGO3VaP5xEDhVT/GKkuwZP8U/9QJ+pCHFSFkuFfwF5M9C8s4TaNbidVkLK8mmU9SB1eDyj/dJE2Fb3RYYkJ3pfrUOJsla9NMAsc1zPdBJb0F/2k+5a2puaJo7DvvQOvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WflYvu4j; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WflYvu4j"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a12ed4d205so8398585ad.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 09:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770313326; x=1770918126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCDjuyi7jfkf2bt3oMhyIz8eeSZwKZqAzn0OwPZFZIc=;
        b=WflYvu4j4dV7jBOAJqTnOYjr0OUSGktPF6fgidos1OZRHqerY78bQqBx0m9C+0wDjV
         Vd6bi2N1tuZjxGq9IdJ8JON9MWLeFrNAut/Q4eKm689CEsLa9s633y9Pg4hwY88+EBxD
         IZa0VIU6hZglp79hLhZGBsN66Ew7hR7cfPoAYRCmb3y5a0eWcT9J1Hrr6KuLk7UTAGy3
         yfnkde55YgPhXG+CSoVEWyTocwnapPdI74YA/OWSegpYhytz8iYHxu2JB2xw1/y7SuOj
         cP3VJrVc8yna9n95ntgRHp/W+xsexnMUZQ1JRHNRlkwo81CwwTXFoVa1TnEs2ym1uwJr
         hycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770313326; x=1770918126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OCDjuyi7jfkf2bt3oMhyIz8eeSZwKZqAzn0OwPZFZIc=;
        b=DncTn1wrBzKtcQWZ2TJpngoEYVRGwiibZi+8D78TTUotWEj76rtH95PecuwrjVI9LP
         3Hd8fDhf5hhY4Zy6Mk0IcklnuuGLje/r5jlyfyLSrdafuw/bjmjHwWRfMqVM+cBwiEeW
         bjJF0ZUslmr4D0iYNq6hVyk9zDi0LNdVpgvW0QXy2a9MhBKBPo/aXeomh+WXkcqhm4Sv
         P0ttwXr8MqPfZWJK9bgS3+QkekbQRSKuudl8z2C9U29USNrnpu0SlPPxR4KmyHFAbHc8
         +JJpAjI46Yz+2qYjMjnnIr5dcV4vpw/8mvQN2DJ7XDi31z4RaYoyK/eGs9ypGr0SifS0
         fHCg==
X-Gm-Message-State: AOJu0Yx1wdkTmj3qsOLSo62ARNB9cFBSZBlsRpLJTbMUbWYipU9EAKlW
	XRycvfR/Uh6koY4mBYKLEIascoDX3dqgi2ZQeKEIULY4XLHo6xhZjLWszp61Ng==
X-Gm-Gg: AZuq6aLhD4Cu8egrijGvBacOvgj+G90dcj4vARpTG+sndpQPSq+LE0UaO5Edr9rooaB
	u4GplJS2lDQpgTmrwJGHXZxeBWzohRfCzFR5l0OQbuC2npVTdJxO+sgv21JlEVkHY8coREUB2qN
	loDrEBjZ2hqV+B0ex+XbVnRXRvmV0vSH1Fgo97pCXLmC7kELWUB5MMM81ljWD8NASnudtNphfu7
	gR18vDAdjXjXciAJ/OlvJok9asI8MHjXCJ3kdP9/xAPuO+8LmUuqscb8jXzAP6KqPbBQ0ece/vL
	skHYMorUqFz3zuOphuZfAL4WrpLBMj2P00REMJn3fRXNQ4v/SfbuhbmfoaZibaIANtWK9BNses7
	fyUo2g2zc9Ed/Hz9s801hg3uCUZipIT8VxGkm1ucORlg/wHPR/rTg9a3hl7aFNdH7gCAiolP0cQ
	P2lzLoCUr7JhH+fl/EtpKxIG31TcxS0DMhWc932PtXU8jpLvs=
X-Received: by 2002:a17:903:38c3:b0:29e:c2dd:85ea with SMTP id d9443c01a7336-2a951633a66mr651825ad.11.1770313326182;
        Thu, 05 Feb 2026 09:42:06 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:92cd:6412:7a93:e84e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93397c472sm56659715ad.89.2026.02.05.09.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:42:05 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH V2 1/3] wt-status: replace uses of the_repository with local repository instances
Date: Thu,  5 Feb 2026 23:11:45 +0530
Message-ID: <20260205174153.61802-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <c1349ba0-656f-43c0-a451-14a97dd158b8@gmail.com>
References: <c1349ba0-656f-43c0-a451-14a97dd158b8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> On 05/02/2026 12:18, Shreyansh Paliwal wrote:
> >>
> >> One question, did you run the entire test suite with these changes? I
> >> would hope that we have tests which would fail if my inference is
> >> correct. If not, there's a gap in our tests too.
> > 
> > You’re right, I hadn’t run the tests initially, as I assumed
> > this was a refactor-only change.
> 
> The whole point of regression tests is to check that refactors do not 
> change the behavior. If you have an account on github or gitlab there 
> are some instructions for setting the up the CI to run when you push in 
> Documentation/SumbittingPatches.

Got it, I will look into it.

Best,
Shreyansh
