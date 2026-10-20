Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792487857;
	b=oEnzxV/r98mYJS1h09q+yWz/oWCWYI+zSWlf/rrvQiPQgn69O7i1Lrr25rn8pt8DRF2M
	 PzeLnLmaJk5r+Akq5U9LOWMoXF++c11y7PnE/MKquHhZefb3a8TnTPZBuUKkSRkzUsshB
	 /igZND8VF6mJpG/n3Tm1KaBh6HYPT0G5698Mg1+7aUoFOLAlmuLdM64oI38shEeGvmLtv
	 qtXNngsW1AKHrjnAsuv/bjcfxwZtrKqrPWPgyYxQOPfv8qtD2XEJlFp4lTe0rAbQBAN5D
	 LlufeLK1zeBbFf58dISNPdtsDg/f0zx+KZHx+TL2iMBXVNPKMHc7hyhhxLzoHFCM1Sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ak9FelZOmzx3bVjtWn5Am/qpZB9vbJ15q2bStlzMsCU=;
	b=Er75y4S2JRl6IsmVrQdZmlAycOLiVHAchU4q+GIiXZDklZpL3oPMSgLx6kGhM+piRtwn
	 2Ig5w5b2ZgmYJ2TFJwGY/z7zkZEBWoRNTdEqjFkVqLwFdpaVVcyANFsm14bpZEnMc+nXQ
	 3tXB/h2o+x9668yiJVw5P00UVc312hNEp+aT9cUS687fi/wzX2V4ZT8Vu3wspws+6fpfk
	 aecxRdRvXci4/QvvQWmWAYwSTRRPhwKQgrkfzSeSDeFiB2Sih1LuYD3RJoNio+HU4d9qE
	 Vj7YlCKwH6OUqnd66k9xCV7tlkmnyrhU4OGsmw3076MtxZkOXvaaeWpdYl/zf7Ydzow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eO1+wAKV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497F606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3497F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eO1+wAKV
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so4541083a12.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 02:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792487855; cv=none;
        d=google.com; s=arc-20260327;
        b=UBItIUmfF2g1i1myWmte0TvXDzrvAxK2GqqHQkGZwZtmA672xiX5XvrIXefzQPa0Sm
         y6K7D+eSykulMVwAv2/Vu6nfdC1HCenjxipiGdR5z0e+TaxdvUhakkbdHyJLbxubDOAp
         DhvoWpKvQLt301SwuwnoRIWp+ga6bVuvbbIA05byLU8Qx+43P4x5PhMN0h6qk+18OysI
         71SbjKvGbTNfY7Imnd2HXBmbGbs6EAjVfPXi4h5We6qxji5airZfAXgZVngGbGjtWd4h
         D5cJxWuSh1l3nSj4oPcDCSmHwrilgVebrntyVOgcy7k9vQ5c5aAofJl98syXsttmJC/U
         lx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ak9FelZOmzx3bVjtWn5Am/qpZB9vbJ15q2bStlzMsCU=;
        fh=nFFptroh2r2E1SURMq5zTyH9rUNWtS0ymAVMP6q0bYA=;
        b=n3iYpKeaVCQPuYD/fVkoGk1/COALpExLjJ5M1dSBboa8lMVzV5ihB/5YV1v+qgHcRf
         shAdKcKXxyJl4FSGp7OYksiUidV9r2hS127vVNfalPKtw5B5cNSZp4oUNYgbTwJVswmQ
         w133RQZlmE80HEUh1xX1J41gmlDtJ9BqlmFsM1YkJjOMTnYthD7sA2ThgSk/oXxFYeoX
         0cYB8Gvhjler1C7qqiRHF/qrurSDh//1O7xs4VCsVhMNrgctXJs4YhxfLbzb2NoJoLqj
         piPCPb3jVXv+Y9pThbSCTAfJn/9Auh/RdOsO3CzDg4QjfF4lC+xFjx1kl06uAlKGzX7E
         m0Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792487855; x=1793092655; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ak9FelZOmzx3bVjtWn5Am/qpZB9vbJ15q2bStlzMsCU=;
        b=eO1+wAKV/yTDM8ci29R7HeNY/i3uYYZ+VHx2c/pr3qScbHDJon0qI3s+M2MZSrtHlb
         TWXdOV02LJQzDsMxMfTE0rCjd8Ok9lUJNBpeCYx6tYI7M0gReaHo5JsRBdnZ48VzE4Ec
         ptIedtU0Y1242CuA6FFf7BVnJpwHZiG0QkwbvR3IyYRyAfU8kNCNEgZytjEs3Ov4OTFV
         +mRRJO+Hu1V/w3EDKqV3uxtkfJKbRD/ZuEiIViOyom+wmCxJBZNgJf7qDEnG4FZ6xEXJ
         Cmih7U6MDXbLXSxegIXwtKVc25zxV7XPpbhF2q2PRvS3yQsjNmJNn26er9BsfXt1y7P3
         5mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792487855; x=1793092655;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ak9FelZOmzx3bVjtWn5Am/qpZB9vbJ15q2bStlzMsCU=;
        b=W2MSQg67HMIscctL86MbL/imoijJ/q4AYdEOEciCPhKQXXrPMaO3R0jQakM+qD482w
         fslD/brZs+eVwIHsZoqjpmURFrxyFJUHNQmzBi5Nt8fwY8WXktCUAhMsa7pu0WljRhPK
         k9BJDWODE0E84b5943Mzr6sP6DczvGVEUXwOBi6jp5ydRFfQ11yelucdW1Fw0d8ydg6i
         AOPYduK0V4i+OPWpfGuYfEqR0zZKMcLnyDl5Wf0rjRCBS1EQa7xOUh/pzfw+y/7upRv0
         8c8Q8sysNIQxgJHho1pZ20LGLWKO6/F5MEvPcwfqaXK3jHMPdUimqZEcbbwcfo5pSF0v
         Cgqg==
X-Forwarded-Encrypted: i=1; AKwUvByy1pgIfEiMRdF9QblDnoDL/SJzceHCkJAr3ovcrLZSJRTqlETBmFDEbC9v3FXhwSV2OTk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwa6eDgRol0udDy4rFdMrHaknemNDT3yqOi8Vzzn3PjGypn92o
	XNhjAH9gQu++6N+kEo5/4kW0nrk34FO+ZXq9LpYnU722qDQt/TjSoSrfxGC2h+HxbVM7uTlCnvm
	XFkaS6kqELml6180gHZf4G6vGzqZ5GKw=
X-Gm-Gg: AYBFou0ef596S2KFLw471/vhv/uwC4Iv1crInAJKW7+S9Yldjtl1oKEGHfiOm4+l7rk
	MYiANOBMVTkbZFTmpG3eohNPGpbJqqHwCugDfJNxN/+A0Qp39HnD6Jr9JduzlXg3qHSybPJHDrE
	inqphb8+38rxe9OOecztddc5eyMYMKqYMKJchiyy+3OcXV44JM3jwjWXUTXqswO+UkDcYsLNQn9
	WRBUn2djBPzUqESQUhK2t8NUlbJqh2PRvpksfzatWLD8PiAxts6TZ168tYTryB3M33o6hesXmZU
	wblAwtFdcaK6RKaB4m710+EfQQuucvA1dZ7QDuF7Hp7uFFkPu01FsLY=
X-Received: by 2002:a05:6402:2710:b0:6b1:ced2:dfcd with SMTP id
 4fb4d7f45d1cf-6b3a8168a9dmr6794933a12.23.1792487855280; Tue, 20 Oct 2026
 02:17:35 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com> <xmqq33u11etp.fsf@gitster.g>
In-Reply-To: <xmqq33u11etp.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 20 Oct 2026 11:16:58 +0200
X-Gm-Features: AclHuK9GOFAdHdvt24S7VNpkr8HFO7bD3uUvgmei9QdTjFt1zk1wGUyBA8dw6DI
Message-ID: <CAHwyqnXab+JEG6i=31xEV9Xmm9fo=h0HsjunMsCBLZ0A4oOQzw@mail.gmail.com>
Subject: Re: [PATCH] status: compare against both upstream and push branch by default
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > In a triangular workflow, where a branch is pulled from one place and
> > pushed to another, "git status" only compares the branch to its
> > upstream. It says nothing about the branch it is pushed to unless
> > status.compareBranches is configured.
>
> I would have expected such an explanation to be on a commit that
> allowed this default change to be such a small code change (i.e.,
> the commit that added support for status.compareBranches).  In other
> words, shouldn't the first paragraph be more like this:
>
>     Commit XXXXX added status.compareBranches so that "git status"
>     can show comparison of the current branch with its upstream in
>     addition to where the branch is pushed to, which is great to
>     support the triangular workflow.  It however did not make it the
>     default to show both.
>
> It would highlight that the primary task this commit wants to
> achieve is to change the default, which is explained next.

Fair enough, thanks!

> > -test_expect_success 'status.compareBranches with only upstream shows only upstream' '
> > -     test_config -C test status.compareBranches "@{upstream}" &&
> > -     git -C test checkout main &&
> > -     git -C test status >actual &&
> > -     cat >expect <<-EOF &&
> > -     On branch main
> > -     Your branch is up to date with ${SQ}origin/main${SQ}.
> > -
> > -     nothing to commit, working tree clean
> > -     EOF
> > -     test_cmp expect actual
> > -'
>
> What's this deletion about?  Is this duplicated or something?

I adapted it into another test further down.

But I'll bring things back closer to the old coverage and add more instead.

> > @@ -361,9 +348,8 @@ test_expect_success 'status.compareBranches with only push shows only push' '
> >       test_cmp expect actual
> >  '
> >
> > -test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
> > +test_expect_success 'status shows ahead of both upstream and push branch by default' '
> >       test_config -C test push.default current &&
> > -     test_config -C test status.compareBranches "@{upstream} @{push}" &&
> >       git -C test checkout -b feature3 origin/main &&
> >       git -C test push origin HEAD &&
> >       (cd test && advance work) &&
>
> Even if the default changed, shouldn't we make sure that the
> configuration also work as expected?
>
> In other words, the changes to the tests I would expect from a
> change like this is (1) to update the tests that have been relying
> on the old default to gain test_config to explicitly set the old
> default, and (2) new test that demonstrates the new behaviour
> without configuration.  That assumes that the test coverage before
> the patch is adequate, which may not have been the case for this
> test and further changes may be warranted.  It is not quite clear
> to me, but the addition we see below is such a case our existing
> test failed to cover?
>
> One large argument the proposed commit log message hangs its
> decision to change the default on is that we won't see extra output
> when @{upstream} and @{push} happen to point at the same place, so
> naturally I'd expect to have two tests that show the two cases
> (i.e., one with triangular, the other just pulling from where you
> push to).  With this test update, do we have adequate test coverage
> for these cases?  If so, that is something we should explain in the
> proposed commit log message, too.

Make sense, yes.


Harald
