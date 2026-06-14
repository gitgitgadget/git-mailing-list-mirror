Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E231714B
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781437685; cv=pass; b=kbmMQRQIDiPppPkSWPhSc4Kzp5Rn8WspE2V0zRYQHve0bY+Nu6gqsUv9FGYZdZo0Jiva4Zc7xXzj1U9/eNIg7uupf6fax2wsfaCP1AZAoUlADeeBbIXPlAmmCArjQIQzlztDnK3qJWITnQI/xdJEY8sBZAIGc09Yd/FKWpOdisA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781437685; c=relaxed/simple;
	bh=OoYqtVb+Zztbv6NfkXPh7FOOvpBhAy0zUvqIifAWDM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/JBK69lBXlyc2QRMNH46fDDaevICD1WOhPwEkrNUGRk8F8S2CgoLpkTJofbZYZ4Qkk787HGaSS2gLq6RRjsF9JDBINcaoR1noKt91tHwheT524eAQhIkChVgcRl4Z8BZVXsGBIY2KMLNhxDVbsTcly/U+1T+EdBwI1oHytQP6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=A8aGKcMk; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="A8aGKcMk"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-660e9fe3c3aso1342228d50.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 04:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781437683; cv=none;
        d=google.com; s=arc-20240605;
        b=SC/kcbk5NvOisWxvY9wPxLyKMTDJHO6SPjU/ua98jRQvoeqygWwsujioyBg9kYMIq6
         cEvRMuUwkpUNJ3AjC+14MBfiqRVsZfDnd/AprbHUg54pLjPglhvNPpAXAt4Ff2CUukrv
         vpm761SHeBd2jYYL+gZyOF0ARSwmX1rYa0+ZvGmt+pCA1KwN9cvq51Gx2SAPVPLTLLdg
         hFBoaBWt1Me2reBZlbltqdV3AkM8htRisLM/P/cKScb/gEapPJTfA+XevTIoLaixeyJh
         129C2e59gIZS7yL7CMWAmYnZyDg+WG6S5rcliEI6gXxeBvO7ZZr2q02U628w7kWgXwbJ
         qdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OoYqtVb+Zztbv6NfkXPh7FOOvpBhAy0zUvqIifAWDM0=;
        fh=rPb5C4Z3hxwAL7thMBaVgRiNwznHyHW+RN710asG530=;
        b=cWMM6ZpHlYAa9U/FCia11QlmU30je36PaVHrBylaOmxeNhqZsi9p275LvEABJdhFPn
         KGNgFCmhBOz9IjGbjBbz+pSIwoSXkwibuzW8ioA587L7mPiqql/5sGJ36hWy1+6Z0ije
         3HACfSCIw8vYlwjZQZIsMmiPpMrOyb1mjsoSvfj6cLxe0FRnvUYug7v/vbHUDdpestX0
         FOltNxBkdfmU7hWYeFy7LcLGZ9Dvwvn97jwahfT0FizRMyW0wZPZQXFDoBuvlMUC4tkZ
         P/XPgn8r2Mh0B3FMAnuX7bIplQbL0dcG3K5LxbwWR43rZUtlZcfk2K5f29UhsKRKuDQ4
         +DRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1781437683; x=1782042483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OoYqtVb+Zztbv6NfkXPh7FOOvpBhAy0zUvqIifAWDM0=;
        b=A8aGKcMkBi9Vn1f91jluctV7dt+pgXjt4oq+vybLi9UQ/HUwpZOeKVaGo929BuN7Xi
         HEjdjb/YU9ceFrQxZnenqLwvgCVl/ASeqjFSrpaL8sL6AP/Oznco6SmkAkqwOYv1/I4h
         HlozLAzjc3uhT/SP0Gys3gTPqhBda4EAIPJv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781437683; x=1782042483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoYqtVb+Zztbv6NfkXPh7FOOvpBhAy0zUvqIifAWDM0=;
        b=RWDCd/dLLlvysbgoTG/WBCYdRa5h2kl4K5yezJBsdGGrgEOmmQuaUyMiNWMSy36RH7
         oBDX0XGpl+eBwgNMkVL2z+j6P3fq+EDvDmJaBlF6pwHusfM9iCPaOaqVLInVlgsIvGov
         lmHvT7x5a72MnzS7uTTXalad0upJqvOYlAfh7VcuV3CjWekcCS13vbsCDyvisNRWdnh+
         5Sd7chDDin5+NkKR2kyjGfrbz5FkEq1Dwldgmf+chj08QIXFg32NHguEbPoHwsLe32N0
         /gyyqxKL54j67A0c39rpJseiriryw+eL+9AsdWI/FDPXzC4mRxTAetWqEwd+ovgt8xkE
         G70g==
X-Gm-Message-State: AOJu0YzcCS4y5FFDKIkYrjPdK2qiHpPnz2Lhiuckbr88Q0WHihgwoda5
	6OfC1Kc5mucIf5lSbYyi4mr15+mI3Ztb2oNJ24FQCPrDKHkr6Bkz8+eeLWcy/nDNxZPP3dIJlgU
	YJpcoyAdmBCpiF4aj3758aVLc31oBBQVBHXca/P+fqQ==
X-Gm-Gg: Acq92OGI//QdDNRM/lQwgHc2sYmENVhzKmFelFWTInm5xDxzN0qcLOj6ktpsxS7K6v7
	0Hu/Ap0SR/mEYyxv4snjMubg6WAkPY8JRwSiwnanQnPkXu53bpv7d7gy0IQgmFyhso88hTdTPtL
	4WkhkNeo1DcX4AOcYkmjxIMzvHiG68AdIwtXCpJxgVJ1hPJsvQdNXEKgfrRH7609hmbMuvg/Ywc
	6uJYCE1+FXAkEe+JiKOJxOF0Ej7Ehuc6KfKQIiqeg+eWZXog210/5n1FNqKGDX4fu2g1lf0pU3I
	umwkrVw=
X-Received: by 2002:a05:690e:14cc:b0:660:5df1:f22f with SMTP id
 956f58d0204a3-662782cf74dmr7684221d50.34.1781437683119; Sun, 14 Jun 2026
 04:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL71e4Mp7ewv0UGS8j=iTq6quyxLXzrr0uNDbWR8JKaOsTSVyA@mail.gmail.com>
 <CABPp-BGq8a-3ocJ+1HCgJutw1SBUvFg6YxtUamryfgEMx3qDYQ@mail.gmail.com>
In-Reply-To: <CABPp-BGq8a-3ocJ+1HCgJutw1SBUvFg6YxtUamryfgEMx3qDYQ@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sun, 14 Jun 2026 13:47:51 +0200
X-Gm-Features: AVVi8CevgvOKNjMANJAr5GgBuv0jRIvDl3dIlVicPhaaEhpf-VcQOE9lavMBuFw
Message-ID: <CAL71e4Ps-2_0+uuZu43N9pFnXBemoAohPs_eyRJf8taXHJPAXQ@mail.gmail.com>
Subject: Re: [RFC] commit-reach: terminate merge-base walk when one paint side
 is exhausted
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Jun 2026 at 06:32, Elijah Newren <newren@gmail.com> wrote:
> Wow...it appears this optimization was discovered by 3 separate
> people in the last month. This optimization was implemented and
> is live at GitHub...but it feels incomplete to me because my
> version doesn't handle both sides having an infinite generation
> number (it just falls back to the old algorithm when that
> happens).

It is nice to know that multiple people converged on the same idea
independently -- that gives me a lot of confidence that we are
exploiting a real and useful property of the graph/walk structure.

> I uploaded my version at
> https://github.com/gitgitgadget/git/pull/2150.

I uploaded mine at
https://github.com/gitgitgadget/git/pull/2149 (draft, still
iterating on the series).

I realize this is getting into implementation details before
the idea itself has been discussed on the list. I am happy to wait
with a formal patch submission until there is more consensus on the
approach -- but since you shared your implementation, I wanted to
compare notes while it is fresh.

I integrated your new t6600 test cases into my branch -- thanks!
They exercise important edge cases that my original tests missed.
I also extended the perf test to cover the case where both tips
are outside the commit-graph.

After looking at your implementation, I also moved from a
max-pointer scheme to per-side counters. We ended up with slightly
different implementations, but they are tracking the same underlying
condition: whether either paint side still has non-stale exclusive
commits remaining.

The main behavioral difference is handling of commits outside the
commit-graph. Your version disables the optimization once both
sides have touched such commits, while mine only enables the break
after the walk reaches the finite-generation region. This still
allows the optimization to fire when both tips start outside the
graph, as soon as the walk crosses into commits covered by the
commit-graph.

> Do you want to take this over, rebase it, and extend to the
> infinite generation number case? Or do you want me to rebase
> and see it through after my vacation? Or some other mixture?

I am happy to keep working on this -- starting from either your
branch or mine, or some hybrid. I do not have a strong preference
for which version it would be based on, but if either of them lands
I would be happy. Enjoy your vacation!

Thanks,
Kristofer
