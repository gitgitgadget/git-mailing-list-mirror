Received: from mail-pz2-f25.google.com (mail-pz2-f25.google.com [74.125.228.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE350EBFE
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695708; cv=pass; b=gP6crVV2C92IKB2ZPLVWnzLg5v4345hKGodHrNxz7AYTVysPNiIYKmYZP3D+xwn5jbEsnZsZV8xweo4eL0ODqzL0e3BNY0cDXST/z8DD9Jg+WV9xgZ8ju+7MAB7JHOu+cDUapV79nBmd0XJHLmkV6nbagkE87aPLaRIoLw1ZXig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695708; c=relaxed/simple;
	bh=oWFjvCAvbBfEYFnaHruYWAT2Yi4zoYm+/e219qoscDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYL1xjD260Id2qTCu0fg+rOJYvwTmhwCApkiVl+M05AdkxsHcaSrVvfSVADBlcjyHLj3HfHTzACYjflUZMH0XrLAdSKZqpozzkpHyaOJ5BaQmqwWixDhyTlKVJkEiDsD2Qf4GeltZ9d454aeloc/OXB09KTJ1t1gPaxTnFJu6ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWJGAIBQ; arc=pass smtp.client-ip=74.125.228.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWJGAIBQ"
Received: by mail-pz2-f25.google.com with SMTP id 41be03b00d2f7-cc7c058617aso621410a12.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 08:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790695700; cv=none;
        d=google.com; s=arc-20260327;
        b=peuAtM620wv6O4ufNZtSfeR/Y5Av+OKOrfeFhyKfsq4a/MpizlSHyIn4HZyC65UfSl
         Qh2BU3NKsvxXnxEoJ4cAn4iwY5iualzyTKJoAHgLeQ5muhx2LN9MyMk6xgVUZnZEMbwH
         TAqtEigJ1tXWEqWYeCAEIrC9I8Cgqh1xKAm3Lb999Fvv5+n+bdZPZPamzol6ESpzKqnO
         hiZK59itKLNxHcfJYP+MD6FZHeOkRONNwJmxevwfVE1Ov4cftwf/95uytIfxQPtXrsDc
         Ke63UF4mw4HVBy32cHCXByPgfqMlldtzXKGRBp50wea49lJyiBCG4QNIT9X+QCdDMewP
         VLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oWFjvCAvbBfEYFnaHruYWAT2Yi4zoYm+/e219qoscDA=;
        fh=t4cW7moj+nE/1NuGRSRVolDrU175PqxZNdaymhZfnIY=;
        b=ZDz6iIbqXCr9zh4lPFBagEJs1KsvK3GqgawSS8ukCY0RFjCrEYvHjNQYxtgzMSclZ6
         D+9rK8L5nUWgwt2itnWglpQ2ktB1RO8H+SOOVuc9ADY9+d5BLVTJjrHKtnuQoAjRCzqJ
         f7/RGosmeadlv/EGCblg9DIYeSzA+40dNzSQwraqgLLQL3RKta52s/UjvbqyfigWoWEy
         uM0CIetriJ0YVP7bFZAH/OfR9o2f2/bf/XYR3J/viDjq+TN91dIexlgKkRFCEHFr/Vjz
         yglyOsH1hWedwXxdINjhXGXhVvzc6ss4N1v3dyZkMOwn2komK+fx+38x0hoRVYzod89Y
         eGng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695700; x=1791300500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oWFjvCAvbBfEYFnaHruYWAT2Yi4zoYm+/e219qoscDA=;
        b=PWJGAIBQ/pm10rtbpSXUH4hVkzoLcq5z9iRC6VBEFA7YDFp31LG2xdUwWzfF+tKv9m
         9T+Eqhl9BbBQcOh+8vu6g/fGPnohJS6P1JTnS/vG4AvpBTy5cODXlSOa8uy+VH/U+/bh
         Wb4kH6Ec6n9/1ecr6ecyZx5vDc2oghv3ZgeoXyzY7cy3nRI8ypNNnExZElNWtDR3IWq4
         SPhs/g5WO4ZirOFakGCC/Q0OfzaQDWVsvybDZ42gXSpeLNe3qjgYuEYFpj8WLCWF2lzr
         UE7SarG1M/C7Lno/tJBytUOmcG6HKnwo/OGDjCj47QhktDQgZ9dxQy8DOlMKjm3gcEZT
         TcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695700; x=1791300500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oWFjvCAvbBfEYFnaHruYWAT2Yi4zoYm+/e219qoscDA=;
        b=sgFOgzlYp7bnKie8cTg54u75d9SwcU4TECP3peenfuFwOUDA2t1h/uiCz5ZT/Mef7x
         lfBnkn+0gpjkOMaeFwHK7lRmbY9WxlZ57YA5lxF0anX7MrgvTYAaNMdYKmR6lFKqBDvN
         gi3S9NHv1rAlgLOHqY12mWCRr56JMIl2OWwQ7ICU5NEgVMu9nEMwM/6HElGNAucTNKlG
         4uAxAjOO0LLPr5to5iyS1wXD26r52TLgkMrBTqU3CqrgJCXqA9oFQ5e44++HSAOx9gVY
         ZZIVup4YaN1X6NWyHI9NtjJ1eXlRKg5U+ZM7igEbFJx67zgbkJDZ+Ju8uZUKdknlnwgz
         /Q2w==
X-Forwarded-Encrypted: i=1; AKwUvBxUjZcr89D4ZPJ70RyULcilzX/PJu5Qpi7msORLmz+yJsrPCrU149q37id54nX2TWh+Wlw=@vger.kernel.org
X-Gm-Message-State: AFuF++lX0TTWladCIoVgZiTCMzzGGgL7Im5JecBg1jru7YGv67T/4vtc
	Q77sRe1b/3orAvmRrSGmCyWLWI3OPUrSC5ZBvqc7kewxNbNjv9QepRogcC5HKTkjyAnezM1rCFm
	LtUdyPOiUo33VRqDsTtHpIF5B4nFieYfKVY58
X-Gm-Gg: AYBFou0sWhtrGRwRIm4OZTk7T3cUPh5K8joURFmCrfBIC6/ynXU8xs3U6ODWw6hbEcw
	AqSwemQPSt/QemQJo3s/VW3mjIRszVe4eLCXO7WyfRiPR/yDjejxGwr46Xb2boaIj2fkoMO0dNj
	dwzsiWiHt8tEctE3Drwx7niUft6o+QA6v07laWyGouLWvdT/CMgkgYzIedofZoH3tmKBmzy2JKj
	O866Azvsc+UbzL+1xQrjBzmC0iqy+0xjS3aqFdXfRTIgWvM8s8v9SQ9ifSoixaer03IN271UdfF
	3EOMH251Y3f77XfX+1tCBP9SjOIaOgH9AhiL/DICYGhHskbezLct2W6wpjDo/6G0yAvg/MxZZ82
	045B72syiSpk3dHOxBchE1dCZ+2qNqmhHGeI54cZeXG09Nej7q+MrmizuQNHRkbsRGLTpL+T9kC
	ouIbcNuqxc
X-Received: by 2002:a05:6a20:3d1d:b0:3d7:b3c1:cc34 with SMTP id
 adf61e73a8af0-3de0e76e738mr13534651637.26.1790695700184; Tue, 29 Sep 2026
 08:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com> <CAHwyqnXLAQgTen2nu6xX63ch7Z9V8kZ-c3zbZgw_xwEVYaz=oA@mail.gmail.com>
In-Reply-To: <CAHwyqnXLAQgTen2nu6xX63ch7Z9V8kZ-c3zbZgw_xwEVYaz=oA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 29 Sep 2026 11:28:08 -0400
X-Gm-Features: AclHuK-q8Dg3NE0-RtTu_t7Mx_IVMa4KBs9vsjTwjYzTuIWXnqVvznJhIMa7Wio
Message-ID: <CALnO6CC4fS0LWe6ta7B-C3dQXSjfYhab-e=EHdneRRqfa9mAZw@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 9:53=E2=80=AFAM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> > Anyway, I can see how this would all be fairly expensive---on one repo
> > I work in, git-range-diff can be somewhat slow depending on how many
> > commits are in the range, I think. I don't know if it's worth trying
> > to state that for folks, though? If we ever make improvements to
> > performance, we'd have to remember to remove the "this may be slow"
> > text.
>
> It was much slower in my first iterations, so running this on my local
> Git repo now does not feel painfully slow. Although slower than
> without this feature.
>
> We might hide it behind a feature flag?

I could imagine wanting a CSV-style value for the option, like
"--delete-merged=3Dsquashed,rebased" vs. "--delete-merged=3Dmerged"
(current default), or something. But I'd have to think about whether
I'm suggesting that only to work around performance or to also support
actual use cases. Mostly I think people just want to go "gah, delete
merged branches" and not think about it further=E2=80=A6 hm.

--=20
D. Ben Knoble
