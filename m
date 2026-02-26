Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4EB3D4125
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772143210; cv=pass; b=QlJ6jR/C/IpiJTIud28EHn2T72ZcCMcKgw5Q++VtneE6og5dhQYHGh/9Xe4bQnnb2rGbCGt/3LlBNW7Jz3mGcL4Y4xIYV9I5cqorygwFl67IPXQArkV+Cazl0HZESN6u4vm92HGXyg4sKoIKVRiaLGeNtXPyE9VQ8U4kFB4L2yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772143210; c=relaxed/simple;
	bh=yqoXmxGhI0lMDQzQLcA9q03Koj3AyOtcI6nJmMiSayU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iv2hJ7EmKhEvQxFqRLYhXnRHtEPFJfjrpPqKfZx7ur2DwjkQF8lCaBXiTpjUJSJO0WHZoYTo0bZvRzEf4HQ4J1Baef+joo0mWM3O18ed4lCVIY8vEMaQcdsAOABAC5Y7pTVfFGoDOnfkgRXS/tigyZdpdeFe1TApu/crS1NCmok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqDRHdWM; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqDRHdWM"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5ff19e7476bso478496137.0
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 14:00:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772143208; cv=none;
        d=google.com; s=arc-20240605;
        b=S104IiPOMAHTaHXQadGFdR3HPP3pOanKPSruYeca458/tXxZVzfPwaQWuqxdhGK1Ge
         XFO5LLLjFTD1VBzHMT1aQosITlH9bazEyGXBzvcnx2jwcMM9dDl5lCNrOXGPH2gyWDFz
         OBsqB7PFlBB0Rp21Q+utYwnEwo2f4tiUY8yUvS/TpvG3nd8XgTRbP1aPGtouAi5pFDIp
         qG4JXQLgyV2Fd1YyiMF2K32RssPH1RTOo0LvjENB8kIb4btx/qKNRxqkJMBCpknHaATx
         /qpYG8di5/yGnOqQbGGlhDn1YGf4qgpkeflq3O9QB5xM19NBITb7ZgKMgiXdKNK40DFG
         TKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yqoXmxGhI0lMDQzQLcA9q03Koj3AyOtcI6nJmMiSayU=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=FixaH0bxKwr0EFDPPa63JPGnid6+IKaAWQCHnrp1d655JczmwaXCfvpXEWs/7X8jcm
         hZBmqcNGgVaXbS2Vx6J3Qt70HFkTVU84rC5Qeky/KBWGtz2bFpWhjRcQexwJy+UE8LYi
         CvflmPbZOYtjB/Q6w/0sb3EXVeZcT7xpFWF0nAw2wXDWoZeQHRE3JgsZkLAgHH25vibK
         ih9wwlGV5jbBfYaAXMlcKO95gfK1UQEoTaOwGjobzXlJ+nNeNWdztM3impd8LJKDquJ6
         r5wtKcxZkMEvzh1pLnwuvWiSMdUNW6rbXLD+DMMfwz0ClydjTkhjB870Vl2iJx6t6tdB
         YyPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772143208; x=1772748008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yqoXmxGhI0lMDQzQLcA9q03Koj3AyOtcI6nJmMiSayU=;
        b=XqDRHdWMyLvLKo7xugfBtqaL2C28er0MrcOYMvrpjHMAb/ituGf8idNIJ7J4aptTkK
         VMdevD6RZtDH9uxYJHvrjBA0iOrhZ9xOY2iJVDIETB8sAd82a/fmVMUrJFXvL1KsoNd/
         cSrOLzmR3vgZ5z/rJm8ycWdA12wP5FN9Id41fgO97/w+nM6AQ14IFHRp8ZGhyGRBRbyR
         jS4a+LPF3QlpsFawCVUeHdfL7TodStFNZ/koSo4qPUJ2jaLxJrYmiHhEwr9LWgS3YiSO
         FP8O38Iu4G24/Z7/ZA0WY4/W9nVxNRy3njdhlPDeL6qQ5WtBsn1Yhh097QKMxNEJPDo9
         PQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772143208; x=1772748008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqoXmxGhI0lMDQzQLcA9q03Koj3AyOtcI6nJmMiSayU=;
        b=AQxk1c/cXlklUcYf00LgImY/2fhG9RokIpf2FL/xuRRNGKjIUXtx3RI34ekiHNjFit
         0Kwi/ER0oqcRlOGaFYmnjEk76Bi/SZneEXKjoCwkcBUH+AeM8+nLNBM0j9L5KHClLFEn
         8TyHqL/fathotuNNf1FHMKwPFNt/nricXhqCvHK71O/y7iblrO1nuBu7uX6KpFHLkpdW
         1MFpK9P9LuVWDoOSDJv/ubP7CyJY2fztIxzZkX7Vj1BaXlE3bJlJcfyU1QBy7eOrfXO7
         NqCqmJ1hlT2WWxSlRPpS17jdz+eh/rxq23fvlbLkyRfH/UAkk4Ctq/MR+MJNsVYkPmxf
         EPeA==
X-Gm-Message-State: AOJu0Yzz44BeLrlwfgAiMJskiPNqk/kAO3hRbYRJdwm4MadDTTV1aCgP
	rQzvVOyHjqwL7/RWCQ5zVBxKQWZCNAbFbtCNk52GUMWavY90nFN8Z0Tn8NzRRiZ5vzS8waeQZET
	5FOkVyB7fwvC2ZOLJqJwYxsnAV7/+6Ds=
X-Gm-Gg: ATEYQzy9dFVYncj4k38D2LZTdlitmV37z2ddcUoUQ0cjmjHfQ7UeFT0CjdwAi8Pk/9C
	GRWf6Orqt8e0BfMulSfP+TOCiHBFwtpJDSclySaCFb3UGA+5b12dy1uzStfbaSFr0s98rqOQKY9
	N/sVpEEWG4Ava/BOaGrM+OUlw6KGdyOngguKyEYenszMEppGHe3lmXVqGs7eOIs7gE4AdKSX36v
	BilG+Z7pon1FbNzjUoZ+WjyZ0liW/lLA573ORDvSGB+oVddwwy0SXKBFoe7UeGz2fHVwd0pZXZb
	EaXLyEbqUhw2ZkyUuTvEZeWXGEF2cRP0HZwJLwI=
X-Received: by 2002:a05:6102:38cf:b0:5db:fe41:747b with SMTP id
 ada2fe7eead31-5ff32393a55mr399319137.18.1772143207969; Thu, 26 Feb 2026
 14:00:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqiki0ivgy.fsf@gitster.g> <20251226185725.51201-1-usmanakinyemi202@gmail.com>
 <xmqq7brzw4qa.fsf@gitster.g>
In-Reply-To: <xmqq7brzw4qa.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 27 Feb 2026 03:29:57 +0530
X-Gm-Features: AaiRm523dfDTmCMRs20QnoIsW-RLLX5yy-eorkhfpsn_rRXbioelbxkudv_sVDg
Message-ID: <CAPSxiM-iAEZeuyqyUhzj-+W7jq80nXedduV2UDza2qxmWmFSmw@mail.gmail.com>
Subject: Re: [Bug] With "[remotes] group = a b c", "git push group" does not work
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Best,
> > Usman Akinyemi
>
> Did anything happen after this?
Thanks for the nodge.

Started working on this and have some patches already but, being busy to
finalize it. I will be sending it by next week.

Thanks.
