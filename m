Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D33E372691
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518282; cv=pass; b=lcgGRhHTmFZEtq5J5vz2hXw+VishZN0y0C2BmDEUgcjKiOIxYldfF5O2wWkMb92mXgyAt9tT8408IOk38TVYsXLCFei5nJBRvgYUBqbNFiBbT6S58Wx/G9E/PAS1VBCFhVwq6l04s0z8CewDINlrpg/gkt9f1GpAmqOM/KLBBVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518282; c=relaxed/simple;
	bh=/ebxjxd8X3zBrgnRUj2zZ3RfMC7NDYhA9inWBL+S2X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASjiLRxPs6eCmmxGdHD/kN7LjzFyiu5/5UpK3Th58YOugKV/VwEEKkr4e703GPJ1n+HlWN8ssO/Sa/d/FwtcxTV7adENeRbBB6I7K+VIjgxcFEJQHHEUrR3ozuJB7LhH6uqsb1SGkjXvse5vpsg6lbBBKFOt86nGTHsBBAWeAks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=MJySKSnX; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="MJySKSnX"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-667bae10ba3so693573d50.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786518279; cv=none;
        d=google.com; s=arc-20260327;
        b=T4tgJSXVJCR62s97NR5SAq5Tg3+/TikR7ojMth0NZkwpB74j5A4z0YaQB58q+/Yu09
         p5JUrv23BDtKCHYpCesuN7tqY5kbGxYPpdUt7Dps8yetWPtaAfsesftjsU8IuUgXnjir
         bnRg/PjQXUMxSDPlCzKKKACaWJyttz1Ch2R2bwTP5ppDb5pGTx/R/jcO42u+WCaJK0CD
         gSVBpThwcJekI8obKunmJ9zcGBftkgjja0V3TRtRhLS8dRloR2maJ7LAX4OiZQvIwgr8
         mflSJkjWaDznsr+c+UdGa14ZxVgkfZw25WcWwsx8vSOvKstEdJp1AUPbWDbZ/TLmlJqj
         dFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WERvQx8atquBZBFX2H8dq0T3vmMHnJIABCmsU4+NP70=;
        fh=BQ0XVOLJC38R6bRgUdMymUvij8sSAp4FpapS1B82dpc=;
        b=WrYnl7uAJsXl6RL3kpSNEkC8V5AWNekElxkrhcLRuEcx881k5Hx1PPLcpUDtDnlY57
         9kvwx9OFS+qw94uXuOU2178wFoI62JiRGqFPKQxn1w8AXgWEb069Nhy73xspmc1Mrpv1
         GhEMGB2K+PfWSxFpbJi64PiE3TeqGdgY325VhhTwmj1uA7zY+VWK4KXcgpdkaIu1rFOZ
         eotVigPpLLaTtCscn+feTW4MmnfDIZnBSYQvbVumFv3gYjYTsCXc0gQKZz3qK6EvH0EW
         NoIjZq8d9vO22SJkJvV6Ce4RaA/4p/rlJ5cHFq2/SVUqTH6/ebYcx1qOtKYWbgkXBgJJ
         VnxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1786518279; x=1787123079; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WERvQx8atquBZBFX2H8dq0T3vmMHnJIABCmsU4+NP70=;
        b=MJySKSnXjAXUMi/d10rVPzJKGaecpENkJ/GaXvLjy8EUzVFf7OZO8xn5Nj3BcrVI4l
         hSOayl5yNkZ4D+i781o5+vhZmWFCHXvIhDQfi4YBlyxTLKrhyIYEOawM+KJ51rqLRoca
         rt4DiViuL785e+mPwgVm99xoXGGugmNfjP9aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786518279; x=1787123079;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WERvQx8atquBZBFX2H8dq0T3vmMHnJIABCmsU4+NP70=;
        b=rGoKZVSTzgkzA0Tp58ajuNbJJLyBmVlgUeoIddS4Aw2FSAKQgreV10i8G4wbXG4DIj
         wSfEsHjA+9+ieMsiSn9A6H68gMGFAZPfidPedrxGTxkfRVDns/wZ1uhw1WvbJ3SFthWv
         asZmDDSEFcf3iUqpd/yH61mAtEbZYZHGaxg1DOiBMz0kxFtRlTyHPViVoVVJwIoQ4DTL
         4rrFeqWvoflt62ikkORN+XVzGJp0+ofbDnHt9IY/WFQznjBlTd4tWknk//T1JLcEi8o5
         UsFHhLAbxqwx6HlTyAH4R+a7iOWlvSFQclc/lSI5UK9Fh/s1OxPBGoKAfrJIlWApEcZH
         5Rbw==
X-Forwarded-Encrypted: i=1; AHgh+RroFOSGOuiHN+Lgsudt/tR0J9hfRkrWfnEYxdvrpkYeE2H5TakSbjBrZxXPAfvBi6L1Rt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2pJTCC00ixr3kF85S3NCfPwuo+p+dmDL2+wae+Naa2rvSK3r
	l6ephVqOB/UTIh7VxchyOYJ+auy7gwXop58nNVls8to+NA2DRm5Uv0COI/DlSzx10GzYSUA7+j/
	ZU+GCqAVaT1+omCMJ/fmuu8BkcpfRIshKtvSvHtRiJ1r9KhtlAhvnsv/4cw==
X-Gm-Gg: AR+sD12EmPcMD9YkJtU6nTJzLv4Oj+HVkr+VWtYUDOQ/Bj8LaZWu6o0rnY861g6iSSV
	CzbtU7qTX+/ImiBIhHec3d12o63vmXtIpisVa+A+2VGI3oPJVkb91A3CBd834Fld4fo+K1wYRQV
	QMwfnBs+0U165y8tXTISght3kaLQ5IblWVwkkeY2GwhPZuHpDG8/Dvh7s0g0QPCdrbLFM8uEs6M
	rrKBey7OyikNuUv/3sRWVFzdQNfBPkHFsssreKbPP8+Qb9FBwzWIfuQBDIyYaP2+3+Gl7HnlkAb
	R6SAoTiOkGFr0B9tS02+l7XQzf6awsR/w7A4hEhNIK4r
X-Received: by 2002:a05:690e:138c:b0:667:bae0:e55e with SMTP id
 956f58d0204a3-66b3412e3d1mr1343054d50.4.1786518279085; Wed, 12 Aug 2026
 00:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com> <CABPp-BENLi7kBBu9QsN87aQY5C0kamzsKpXZTKYcHZk+WX11ng@mail.gmail.com>
In-Reply-To: <CABPp-BENLi7kBBu9QsN87aQY5C0kamzsKpXZTKYcHZk+WX11ng@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 12 Aug 2026 09:04:26 +0200
X-Gm-Features: AUfX_mzyh0fgmVq3dZjiBkEoWWuqV-0ovuVNVtJa6POg0Dd4Pzwn8Cd1vgBBgi0
Message-ID: <CAL71e4NMdOeL0Mwngpw9qn=sSctFEVMPiYEiWQ=LT+Ct-mP02Q@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Elijah Newren <newren@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Aug 2026 at 08:23, Elijah Newren <newren@gmail.com> wrote:
>
> I am quite pleased with how this series has turned out.  Not only does
> it provide nice speedups, I think the structure of the series is
> particularly nicely set up in a way that helps guide the discovery of
> the idea behind the optimization for others to read, documents and
> tests everything logically and thoroughly, and was a pleasant read.
>
> I brought up several issues in previous versions, and this round
> addresses them all.

That's very much appreciated, I know this has been a lot of content
to review and there has been some unfortunate churn, especially
around the textual sections.

> >       +For v1, `paint_down_to_common()` falls back to pure commit-date
> >      -+ordering via `compare_commits_by_commit_date`.  Because commit
> >      ++ordering via `compare_commits_by_commit_date`. Because commit
> >       +dates are not monotonic (clock skew, rebases, etc.), the queue
> >       +may visit commits out of topological order.
>
> Don't think for a second that I didn't notice you murdering these
> double spaces.  You villain!  ;-)

Yes, well spotted -- this was unfortunate but needed I think.
I realized that this document was inconsistent, so I decided
to standardize on single spaces because that was the smaller
change and it also aligned with other technical documents
(such as commit-graph.adoc) ...

> >   3:  f857577e0c !  3:  6208bcf3b3 t6600: add test cases for side-exhaustion edge cases
>
> ...and now you're just toying with us.  :-)

... and here I just restored your tests to their original glory,
despite making the patch series as a whole feel a bit inconsistent.

Overall though, I wonder if it would be useful to codify a
preference for double or single spacing after periods, even if
that (obviously) does not imply we should reformat the entire
code-base directly.

> Okay, my last two range-diff comments were just jokes, but more
> serious now: I think you did a nice job on the re-splitting.  Thanks
> for doing that!

Thank you, writing documentation feels harder (for me)
than coding, but I'm somewhat happy with the end state now :)

- Kristofer
