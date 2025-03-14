Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C51FECA2
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959630; cv=none; b=iOkuZxLZW5qZFs1AzOA/9DZmkTaaCS2Z0IEJdCZDJzZ5kVL/VKTxlJNTCBbs+jVUyFlx6nFgC4qKrKmqUm6vBoEZC+/l6TsQJIAromlmouOIXPPTUQ0ZrHO4p5k9PbRp9Qd2WqGqAx4ZkPJTXNcB8QFN9rlhjHavS9n1iOUKkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959630; c=relaxed/simple;
	bh=ir1fbO+c7ATvtss6TI9ZUFzEE9Ngc4CID04EFt4Ygt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJKjEi4KdGLlA9v0+C4RM8bEduubEwqCKBTkQ3OWUwOd2iZzYLa5aN86Jft78u0fKMkn8a+FPBzH1hK+svyp/bUNclrWENA4Bmdrt6IpYd3/Xwh19YUnakoIXitojrETRre42fqfe9lK/aaMqlHQhgnNvial7NZgikrTuJBQFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAmChVkp; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAmChVkp"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4767e969b94so33635811cf.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741959628; x=1742564428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CSr9jHEsC24NfvoxzYpIn7Nbgzu1xTeI4asWcV0Byeg=;
        b=SAmChVkpwlXMmPelz2cV2L3Yp2Hdyj4/Lo1TGZOAY2g/HyC7ZioP6kdVFBru8iGGY0
         H0MvGShdQj5QSuwaThbHXG0WTNJr+7toUFDHac1duXPfD1ds1/SzxgieqJfPT7jc/YfU
         3ozmVt/6nliPouDn4pWO5OpaRwOsJMPMxZ4O6h+/kw4n3nkp6w+BIH7bubHZBcMOTQLQ
         cZsK+iz+RU//kMuD3QCB8ZuOfREbMtOEUvggeM9YemM3vbgANPcP10SGfGwPUSzR3puR
         seywX4r45ZmrSWu5OkZ4VACGAuFXxab3fI5qAvBuiD65nbXHYHEhIvxdFbew/ORhb9Zx
         TZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741959628; x=1742564428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSr9jHEsC24NfvoxzYpIn7Nbgzu1xTeI4asWcV0Byeg=;
        b=ut4TcDIIktgLImfDqrwLhv/6uFn8oU6XeGRL5l2YbbTm6WjSE9yhltUFPxMZF+1TYE
         Z4GiPF9NPayQYUbqe5yW3jDY9egN13lK99C6Gd3jfQrSfwlm61X0lvkCGT4arJsT7p0k
         +ZZW4pXmIPpbAg320vBbfkDbgTQHA7/ALXn4FuqMixMBkkQx69sbN+2C81hUBogexPVY
         vnfn3QKoN0DuF2rpX8WFT8YGbIv9dfaVUO70WKo59syTig3oAkrD0sCEiRd+XZzdLer2
         UFLKRmwg1D6mFTZq9uiCZ+PaHR9juNvixnwKSWYKDJPIgfs0CqU5MZ9YUvlS0AjSs4+K
         pumQ==
X-Gm-Message-State: AOJu0YwD47eCYjMG7G+PGwImo5Vp6xqsb/LSXAapGSPdg6MufjUG5j+f
	dPw6tIbU/5AGx2wt5xCqpyCil2l49XG9ALe6vo3t4qdVGuS/NDWqP+2L0oLhDbe6ldo6PXAZdm7
	Art6rDV780/fmpQEtYSxI+I98HvsNz+7a
X-Gm-Gg: ASbGnctnvEsyGyKIIbGAXaCbCBuF18kBPIVet3az0YEv4vMm16XtC8xF/89CnKZP+PO
	KOw5zv11AMb6es/kQSwcpCHP6IJGeViF5s5lr3hXCCz1h9qoEIJVPxWbMC28tsIzsgHW2ixzm24
	X3f5OJ0kueEW9/lEpdA5AK0kK9tT8ETobiJ+TS5pvDCJBpHnCr0Zg+npHlJTEPjC8KlXbH7A==
X-Google-Smtp-Source: AGHT+IEAaBbE4Ut8XEyuDljgLr3BjpEdGY5fTUi5QONSvVh8R5NID9Fek5bLVCMnBIOQFNPRZNfTLxORoJ0REavoez8=
X-Received: by 2002:ac8:5a46:0:b0:476:b79b:2e34 with SMTP id
 d75a77b69052e-476c81b821bmr38781741cf.39.1741959627850; Fri, 14 Mar 2025
 06:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312081534.75536-1-jayatheerthkulkarni2005@gmail.com> <CALnO6CCvo+EiabE3LG2pmPZhM=M9_d80Mp_MyozXmHjE9srAWg@mail.gmail.com>
In-Reply-To: <CALnO6CCvo+EiabE3LG2pmPZhM=M9_d80Mp_MyozXmHjE9srAWg@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 14 Mar 2025 19:10:16 +0530
X-Gm-Features: AQ5f1JoP1wmRRByAHddmV_QuoyrRPG6mOoiLR6Jk5e0onTMBwl1l3YBJO_0vjO8
Message-ID: <CA+rGoLfrJ-+QVb5=zc=j84sM=MTz3nt8NMYgXVZdfYf70AuDZA@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] Update MyFirstContribution.adoc to current codebase
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey Ben,
thanks for the response

>
> I'm in a poor position to judge, but I suspect reviewing this commit
> would be easier if each bullet was a separate commit. See
> Documentation/SubmittingPatches [[separate-commits]] (HTML:
> https://git-scm.com/docs/SubmittingPatches#separate-commits).
>
Actually that's an amazing point. I was thinking the same and will
start a new patch with individual bullet patches within a thread as
soon as possible.

>
> Agreed as discussed in the other thread, thanks for doing this!
>
> >
> > ...
> > @@ -149,8 +143,14 @@ subcommand and contained within `builtin/`. So it makes sense to implement your
> >  command in `builtin/psuh.c`. Create that file, and within it, write the entry
> >  point for your command in a function matching the style and signature:
> >
> > +The following line represents the function signature for any builtin/<filename.c> file that we add:
>
> This line doesn't look necessary, or should at least replace the
> sentence immediately prior (which shows up in the hunk context).
>

Ok I will once check and make sure the updated patch has this rectified.
Thanks for the feedback

> > +----

>
>
> --
> D. Ben Knoble

Thanks,
Jay
