Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D802E36F4
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289160; cv=none; b=KGHhFUcwBN59E+YCmmeNB/0YSLzyyo3NW+vo8ExPXdxlsL9Z3HdILYScVctEGCAZEWo1ibH9uk2BYfQ+Qqly1g/Hg5jWeQCB3eFv/j7Snxxts/5DGJEk5DBbxt+nOorBmdq2HXYtKxzaPXYH+IhqN1hFaQ4gouYLpWW+G6i2iMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289160; c=relaxed/simple;
	bh=jVnUVRZxemW9WDaeBCvNl0lwTOV0YsgoR3f81PoZfoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nB+kvVnVwhV6ddFyuWOYIUPU4qzgikrjYWQNvVUEckMMte3nyJ0thO2+dJGA04w+AAMswIpSr8bhYdh8jGAgHwe2eKw0FFZT4/fR+KgYAW/Gbk6nMokVcTW8fy9Hoi+ngAFtj7cX+5BCKUN92B9aQpax8raLxpW2SrJIHMntcWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5nXJtmI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5nXJtmI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24009eeb2a7so30845705ad.0
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 23:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754289158; x=1754893958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D1kYwrpoJs4nYm280YUNknzUppvkuAVGr6CR+4eWk2Y=;
        b=L5nXJtmIHFDTMCYedmBhE1L+Yy/3DgYdeoupf1XPQzbS4E8Lu+BxtHmmNtbY4LPpAU
         3Tvq7ZBqFW2YUuKwI4QZOXkNmwTKSwYX9HB/q20FJbjAHkkDY7FChGthQuqmZQDD7B6J
         zMF6WtTgTCsOc+cE0NO96xV5BcL0QoH1bJd/O3nIILDaow/fPY4dzOi8k4Bxb1W2dRe8
         0Mqs71C7b51WJbkSUx1bdd6TvOSy4Nc09DI87+QE8s8+aNxJKcWyhghNyRFKiuD2uRDc
         URNS7r4aGaTX/Fa6dv8pAGi5iYXNd9JFM6AbxJ3HY8j4CgvH/FyOh3wnGbWMgofaB5Op
         FS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754289158; x=1754893958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1kYwrpoJs4nYm280YUNknzUppvkuAVGr6CR+4eWk2Y=;
        b=f0aB4R9eNu3ujXJHjmcH6zyvRuyZzq6h91kPV/MPZPzczDL9vkfXUC111p2TwUJPL1
         V2rNIjKXt4zL/uz1wk/Du4EIQQCF/Um8bFJWMOGsZ55WEmex7gPzuxYfZz1PogFMLZWi
         N64Ov7HDrYOXV4eIJRxJXQhOoIDIKFnXPrXh7WVv5MscVQ8BbR5EYfhW8vBx3C4ODyHK
         kaMChB8HGVCWEo3p2MZsPK1+gPMHGB2L4tGtZdZkGZxuLn0Uc5hL1shwULjoBp3GjVaL
         RYJnhsmJtcHLOau8S7cUQtcjyiNkrWFwZrz+Eqkyl3RT4bwF/hISJ9wgFAj2rIqDqdAn
         en4w==
X-Forwarded-Encrypted: i=1; AJvYcCW0NrOHD8CRq8/aVoyUubP4oqExDT9Pt6NlwwA9GfB81YjuxTgPzFIF2hDzVr4qbop++iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBiBadsrexVNx2tKTd38hGCCOTKmZO8w72Q/o0f/vV+qAv4vp8
	GtX71jr/6RZM6S9UV/vFANxAFMsVEZpOe2dzNOwhPj1K/1wlCH5GBHwTDIY9ozWqnTe/wGBJqRt
	Dv7yovD/ApyY+9bd/T7hz40STW5Oyxek=
X-Gm-Gg: ASbGncsLIkIP4Ep2TBGB+punlj841CgfdCp77g9z90XEzExaxwZVQ5YPg3LC7SB+X0g
	r0UfVwnNfTebec0WaiJWjNlWJiD5knkRlsEJYKzZKFf160hbv9HTZfF6D/5PSlVyyxQ7Ff4Fm20
	hS/KFEeTJ1G6JBnJGE+gtFvjEKXkmwXVroN0Ul4eILcoWWC7hB3XvPTKTHWTpyLnoB1GeMB4eQ7
	gTmuewn
X-Google-Smtp-Source: AGHT+IE28w4QtnGoa8kK+xLVIzL7geww90LR7IsLSVQYjsqK2daPL33T9AfOXS5QgKQKlw9VFqJZcrTxY4XTamRT+oE=
X-Received: by 2002:a17:902:f685:b0:240:468c:83e7 with SMTP id
 d9443c01a7336-24246f2cc00mr94901395ad.3.1754289158166; Sun, 03 Aug 2025
 23:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-1-meetsoni3017@gmail.com> <20250731090040.1625303-4-meetsoni3017@gmail.com>
 <2d2f823d-6e85-44a0-85d2-d45d4dc287fc@gmail.com> <xmqqseibm7ap.fsf@gitster.g> <c4d9b25a-2a62-41bf-90e6-455c62b03aa3@gmail.com>
In-Reply-To: <c4d9b25a-2a62-41bf-90e6-455c62b03aa3@gmail.com>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Mon, 4 Aug 2025 12:02:25 +0530
X-Gm-Features: Ac12FXwpDgQZtsZ7-Et5B_sm10VexkfSk2NdybhaX2RRMVe9lN0fZ39bbSt9NfI
Message-ID: <CAPhwyn28L87xu6iPmSC=z6LdvSaN94J0wM9mH6jaC0kGncv_kA@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH v4 3/5] builtin/refs: add list subcommand
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com, 
	karthik.188@gmail.com, sunshine@sunshineco.com, 
	John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 21:19, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 01/08/2025 15:43, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
[snip]
> > If it
> > is not doing anything useful, perhaps we should make it match any
> > letter, without getting constrained by hierarchy boundaries?  IOW,
> > a "fix" might be to make sure the following happens?
> >
> >   - "refs/heads/m*" matches all local branches whose name starts with
> >     'm' like 'morning', but not the ones inside subhierarchies that
> >     start with 'm' like 'mid/night'.
> >
> >   - "refs/heads/m**" matches all local branches whose name starts
> >     with 'm' and in the ones inside subhierarchies that start with
> >     'm'.
>
> That sounds like a good idea
>
> Thanks
>
> Phillip
>
Hi Junio and Phillip,

Thanks for the valuable discussion.

I think it makes the most sense to implement the ** wildcard enhancement in a
separate patch series. The goals are logically different, and separating them
will be better for the commit history.

I'll start working on that series and will send it for review once this one is
wrapped up.

Thanks.
