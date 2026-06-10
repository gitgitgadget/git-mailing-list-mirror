Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66003DB313
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093512; cv=pass; b=Jo80kR1kNSL2JrStce7Lnto0u1/N7MBriSyAO/Vpm3nt76D1bsufTjIPhNb5juswadDRJt3HC1zFoboeQZxtDzBPcRbY+TKV9S3HfqEaYhPZItHVbYcQSiru6I8RZYeOJdeVjCamMpKhMNZzTVtH1or02AcmrAMlnV/YsIEep3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093512; c=relaxed/simple;
	bh=XdoWssq5Xc1iu7rPXzkuEEB202UMc2tcsMCXsMAO9qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nN3Ci1j7ieV7yaQwshpQwh6CPdDdnwjEnWay75XFteong5+N+gMq01n3xVqRvlatkUXAnS1YGKOp7pToNRLvjE/g6tV3mjgawKn5gOUm15KEPqpUPGkDGruvv1t62PN27LtH/6IWXwA68Ahd6NUvQvmKEZEEuBRPvLFGLBQ/Kao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jp3dYDKy; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp3dYDKy"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa68d9d4a3so7559983e87.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 05:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781093509; cv=none;
        d=google.com; s=arc-20240605;
        b=Gcvt674wq8GbmwH/0JOP3cVRjI4bA4pRJCykwMkCRXWaPc8IZzT/RgzNZTxt/ct2w/
         77UqNcqAmRfa85HQBXEmm0cdlvbLFTJ/gGjtjedr8PTpHU91FYr8AFnLDvQC3wgiHKgT
         Hz+5jqDQLcMQBQMesRb8sdLi+AgzoDfaLtcaGL3gRI8NxStT9Qz92r9Ye5jNu9fF2D40
         3PxEtuIs+VmSs2wHbg0SBjUQP5oT+QQnajzNKmAj9zYSwXikXLvkvDeR0AZ+HBv4utcS
         bTdOaMrIontr3VlXIEbvi0UNDWwJiuZlQAGDk5UYvrI3OJDBDYmk4kWmvXAWKTTJ2Es6
         Bvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XdoWssq5Xc1iu7rPXzkuEEB202UMc2tcsMCXsMAO9qA=;
        fh=npDOvImh7nfybJW6lm+j3eFsSJoNjaAC+zc3YeuW39o=;
        b=iOq39k2Lg4TGw4QnY+1YQrm5upSz+MafXa3eF3hJ4I2CQyDkSAMnMtXZTX0K7ZzZBe
         VmNI5fpJMUYUjiNlrPGjR9lQ7olRrudoJlUkTXOidoy+B5smGR2dTiVoGDkes3LPNjs6
         cdYxbMB144Us4WUyG4zsG0i71QcZH66xt8d12h6oV9LQZLT5XmWYr/fpgeXRWxaFZuaB
         MLWwxmGc+Gl86eF3kEBLovOnogHolLcxcFais9xMSEx6m2uladnssGEWHvjeTvFdRxlu
         ng0USYhakvbj2FJdVezqsNv6XqyC3oC4zfWp8dqGgIkl81QM62YoZ+8eibCkSBTkgA+P
         141w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781093509; x=1781698309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XdoWssq5Xc1iu7rPXzkuEEB202UMc2tcsMCXsMAO9qA=;
        b=Jp3dYDKyAiJgIw4aJ0VIWDAfQz700S7b+lH972eXoZZt3oYsP/2Y7Kg9WJ33mWaEM1
         JL215VC4mfkzHfOVgBqN/PbMQcl+RAQW5wA8NCNj1hnfFm9cpnFsUyCrpF25H4qIi38U
         3Q2CclouWBC45m1mgzx3d50/JwhaYTWOpPE84E3aLVOV9KGM7xo7zOuNGEz2MDHqDqiw
         WkWQy7hyww+8gFeA2E5zWm7dTse6uJyu7/rxAdtxZaukJNuegu06xMhQ5M+maxtq5XsM
         PRGc/IVPvu2zjLmpM2Pwfg0HtjQQUehBTqBQgORRvUBuDpgPJ6C3zGYXU7316xbFwMvI
         qdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781093509; x=1781698309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdoWssq5Xc1iu7rPXzkuEEB202UMc2tcsMCXsMAO9qA=;
        b=pRqoA4vdxRbAZa/1vhOWt+G46h2/AAhRI2ciNwmDnB8rKqX3rV7aFHw55YXP/Q7T50
         tO41eIGTmk7JLU7IJHShbKzuAYGvs2c8cdV4lTYsWaE6L9g3Wqvs+0yTjydYiLQE++6H
         PIEVmcVcTjz7KLBnw91ZZzshlD6/g1Q7YEl1OZ+e40h93uFnOjhP0diraLAJ2YUS0Pa3
         V8/E+KmOYDikpD1xCsB9HaB4Gw9+/VSdUuu3jwz0WFEv5kbzSLUpUgOzjxucj45t1fJH
         I90qVkK6PfDE8gWCFxVWfQO0DN0amErNMULEtYOM3Z0M2UKmh3Y6f6KJ/f5MxFJGTFXS
         CyEg==
X-Gm-Message-State: AOJu0YzD4ly9hVHAd2Yfw5T190Yd9rzxk57OyztLi9igTqmeoWPhPjW4
	Qd9sUDY0UnCNTwSFJzxYkpIjsE0yN4R21beaTgYa+c/r0MVb2E1S+UDeja2RY+VD4WZ5oVQpfyn
	H596gVd/a0Hz8xkCsIfHkVuC6gKIAcB8=
X-Gm-Gg: Acq92OEfdYjvXAECNO/eAgpx+CI2NagpgI2ShI3RsotSQv+/om8zRhy+X/8yBX1zTgg
	AOMNSjmbpdJc874ny9rUJS+H8jhDVs3CA1CnROCb4rg89mGqH4/pS/INT9DCcBEf86k3uMLzLjl
	ug0U+SXLxH/qFysKYCZ62RIjq0jXgQiPPPn0/kZt0ft738XFDgCJBN8gY1IKxevUmGMkbx0Rm1Y
	Mq0bBok3hy1dk4Tlwj+oA3V7HcgUTG3n+9gF8QH65jUCLbXhcLwqE+M8laer5WOmjVl+0CoV82A
	dHDy1OTqrvwb58kQDaPsJQX3uTZGMXk7HsJH/uuYjTOBQ80QrijmFYMsKaE530HbEE/C2svvePq
	QrcP44iwODdgJd5WWoCpa5zaid7fgkJ2YcACS
X-Received: by 2002:a05:6512:138a:b0:5aa:638c:f2fb with SMTP id
 2adb3069b0e04-5aa87b509c3mr6551371e87.12.1781093508740; Wed, 10 Jun 2026
 05:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-4-jayatheerthkulkarni2005@gmail.com>
 <aicDOlJdUrgMi3sA@denethor> <CA+rGoLdpkuigWXqNSk3bS7-uhtzCizkPx2GGtNaTyy5J1SF7Rg@mail.gmail.com>
 <aighAZXRtLaz6sg8@denethor>
In-Reply-To: <aighAZXRtLaz6sg8@denethor>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 10 Jun 2026 17:41:35 +0530
X-Gm-Features: AVVi8CexNVnGHEel714nPsuxn0ZzvhGsSPJjLYKv8KJiCAvx2CBX-JwhRzEOf68
Message-ID: <CA+rGoLcz_U70XTQn1_D6U7Qjfmdz7rbpKZxds2zBhPr2hYxw6g@mail.gmail.com>
Subject: Re: [GSoC PATCH v2 3/4] repo: add path.gitdir with absolute and
 relative suffix formatting
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, a3205153416@gmail.com, gitster@pobox.com, 
	kumarayushjha123@gmail.com, lucasseikioshiro@gmail.com, 
	phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"

>
> Intercepting PATH_FORMAT_DEFAULT in print_path() and overriding it to
> the appropriate default needed for the specific path printed by
> git-rev-parse(1), as shown above, seems reasonable to me.
>
> But I do think that PATH_FORMAT_DEFAULT should have an actual default in
> format_path(). Otherwise we would have an enum value that requires
> callers to explicitly handle prior to invoking format_path() which would
> also be rather awkward. IMO, it probably wouldn't be a big deal to just
> say PATH_FORMAT_DEFAULT is treated as PATH_FORMAT_UNMODIFIED when passed
> to format_path() and document it. In practice, our rev-parse use-case
> would always replace PATH_FORMAT_DEFAULT with the appropriate value
> prior to invoking format_path().
>

Makes sense. I'll have format_path() treat PATH_FORMAT_DEFAULT as
PATH_FORMAT_UNMODIFIED
internally and document it, so there's no unhandled enum value.
print_path() in rev-parse will still intercept PATH_FORMAT_DEFAULT
and replace it with the path-specific default before calling format_path(),
so in practice it won't fall through to the unmodified behavior.
Almost done with v3 this was the only one left.

Thanks for taking time!
