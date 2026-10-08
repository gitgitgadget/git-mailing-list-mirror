Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C3842050
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481921; cv=pass; b=CsDDchHR+YUaoswRucIP4nMdVtEN4IxjsRLjDq85+HZPvmyf8BpvBh1f/oNa7PuARR6X0RjP8K3pa42G2cSQOzfoVMEGmGQu/ed1rwLl3omodhXUVh2VNHFpyHeQhWaXdk2IoUjl54aWx+HE88JuzF5/Q9gyzsRd0+J5+TwFxnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481921; c=relaxed/simple;
	bh=hmudmU5HXXcBARJ/9T7gu4q9yA9zxGMymqRwwxAUsdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgWuq4DcDazoBB0tci/C90ETwlhonAnWxgNlMNwYv4oCHXiSwyqX+h50v7fvigEEc6XxbzQj+vgdA9EbGVxV9QzdGb9wqP1a3Yue/UeZbZxyBfchmy/du8ppzKgTj0Q4goRwrbFV/lY0g84rElS6XxQZZXjOV0c+kxZNfoAbFbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTDetOOG; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTDetOOG"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-677d35fd1d2so4743222d50.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 10:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791481919; cv=none;
        d=google.com; s=arc-20260327;
        b=qId6f2RDbIg23lKTtkmOrfL9FxvHI0aoneovGmWzNBvChbW9/q4hlXgT6ihVg5wEmy
         jBlUKqS/VSByqIH9ansPmgFV0ldH4IqEA3cgcKMpT0J0JaQKXQap4+d8K6eMosUggBtZ
         pflbn41yrzOKADEcL1INmFj5I2AtCpPj6CCc0Aui+4wGDTil1+ehA1sOD2tYmCO3vmPN
         NWEoRl9XFkbndJIqiPXvPKbN9nnsVFliOc0TCt4TSG0gy69Mhm/Lx6T88ZtjhT5RlCtJ
         iDWbL7LcIYfTBeWpkydCxxnqvtfIy3DGCO+uvoXy3Z4/QMcqrWnhKRRQYO/KcVm2PZdu
         eI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Rc4Rq4hvgNRoKzzn+sbVLyLjRkZFsbaqpmKKcFccgc=;
        fh=/opYg0j/WR5zb9/hW111lZ8jIa5Hncq/emCCHZTgIvM=;
        b=IDj4U88q92RVebweSK9xu63uiqQRpy6t5JbAav1JucBkFevkm10RITozgBI4E5FITk
         tm8ULpzUodind8KAVpy9cOtqgIOYnwkxsRO6wH/9W8+YhZovfcK2me8FarRKGkk0GFir
         WMhsLKEJKpzWwX4QRu8fqNeqGCUIaHEi7t3NR147J4zgcPCSqDyKIJyDxLjRuWuclNFL
         Nlbs2uRUQ0RJwJDpb8U0ETW3HuozpuaMiQWBhOJUGhfvEUBEdibSVJ8GRDS79bj2DeQR
         HYeNaYMOuAyDx9XMawwgN9GRibQJ92fpyPCvTt4xWPhAo/8aES5dxodXb9QzR3/AqM6j
         pYSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791481919; x=1792086719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Rc4Rq4hvgNRoKzzn+sbVLyLjRkZFsbaqpmKKcFccgc=;
        b=dTDetOOGqCB+k+XTuldDNCbeWCIr76Pl5oZZSdS7rOuj8YD8i+PGU09KtRr1FJDls+
         /ZzPB+qrZHnb5zcm/7BZ+N3u+/s/YC9ISqWXtkNQ55CrYDrF/Mg5D3LdgjHhGF6HOaZT
         iA1FrOlq3K10+1gRd8IyOaW/l4BUy+aykF6vEB/pllZorrHp0UotZb1opb4QtRFJXaHb
         c0T5Tb85udQZQMKqsvjuoNDVvgSlt93TvCsVENMkbKB15OoRUGNpKlbVcRLhmDXwayg4
         yT87NTOBbEneA6erXxfOF8Swx0ge/TVcZC2EW2HthbilDcFBcs6mt0W97zTB8UatZltv
         efyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791481919; x=1792086719;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Rc4Rq4hvgNRoKzzn+sbVLyLjRkZFsbaqpmKKcFccgc=;
        b=FIyoGraueMpFkwIhba/odiKSDcGu4Kd0BsR/f+CAtRzBWy8h8wpXgGacOY6Vs2I+4K
         TJ5ypv/h0o+/aLTK3o/l0TnPkk3tQlNEaNN/6fWBGlduYn5NGrhFGt9b1bPrpSivLhwY
         kHECiWUnDadOMUV5barcN573RRvi7axyWErtAUd42gzRK1PYElN9ofb2+iu/Dda6dwyR
         KxrxQvURsCdoOVN+Gte2ZDXIGJ3gZ/fxWmiISyDpdAlM9RevcMfz3JRHCSL1cBUVcUvz
         W3L5Y65DV2UYSXOcr/+YZJ+GpTgRDq+HQibwohKF21r29A990iXcNPMNoYToxzsJvxIX
         rcOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvxbXLPbw4HD9eCFk74Rwdapgt7JhGMmbU611/64F29Y9CYM94Pn9Zz/dankYVY6Md1GY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxBI5Er8e9hakdkky2Cn53qvCRKhwVsmq4h+RGHDFNGl0odrh2
	rBAg9FdBWX7ItijTMayV8qXSXDlJap8VbzFdSOOJfjzt1+SK9QdlN5XRBtePwQwpbQpafDzX1JC
	8fbgvpBL61JIaAlkq415A0K71piMg9Vo=
X-Gm-Gg: AYBFou2Z3FwATqGNnchY8PwkVAP30K1+lcP6GFeLuJL4SWgWh2hzDnNWXQNkesQTDOk
	5CcgQKnP0NXkWIqkmCHrTu1PyuHGlLLBzzVac01E7+Rkp5Ps7dIeeNJ8+xKItsBlYy2V7efRjvH
	Cxfe0GWfyNj1e0tn0BFQdWlvJYoQs1loZTqLqbBBTliYOnE/bwe5cgMboxNZPkhSLkhvBMT5iv8
	eIuEocbo5xMdj2yR6AhOBgnLwcYfu5qjfEjBub8jAafcQVTr29odJM59OLWzRLxcnkeNHsaf5CA
	bEAtGBt6iAXpq34d2GDiCMvpDRvysEn6FziBhuR2dyysrF0P2QEiPIZowG+nlFrRqxJGQNWZ4UY
	U1wkhC6ie1Wt2B6AzQApVyaeK9ZFvUXXHGXHt9/fN/zqzX5AVQuLG7uT+VBTHl7TcTmDi33Dsct
	PR5BwJsgs1bLWQc8GVtFSpMqnZ72S9N6Q=
X-Received: by 2002:a05:690e:4503:10b0:672:e7e1:f3de with SMTP id
 956f58d0204a3-679329e9632mr78048d50.73.1791481919088; Thu, 08 Oct 2026
 10:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com> <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com>
In-Reply-To: <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 8 Oct 2026 13:51:47 -0400
X-Gm-Features: AclHuK-tqRd9l2IVM-CxgPT5N0JUw0VqmYknkom6GNke8SgoDwn_LQ2Vs1sSqgc
Message-ID: <CALnO6CB2qPtv6Cr4LL1x=ZPmD_zLw1GzLUKgXE-NcTWObbiLkA@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 5:54=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> On 29/09/2026 12:26, D. Ben Knoble wrote:
> > On Tue, Sep 29, 2026 at 3:33=E2=80=AFAM Harald Nordgren via GitGitGadge=
t
> > <gitgitgadget@gmail.com> wrote:
> >
> > =E2=80=A6in the rebase case, I would expect something like git-log's
> > --cherry-mark option (or really the algorithm behind it, git-cherry,
> > and git-range-diff)
>
> That's what I was expecting as well. It would be worth carefully
> studying the implementation of git-cherry. "git cherry A...B"
> precalculates the patch-ids from the side of the merge base that has the
> fewest commits and then walks the other side to compare them. While it
> is walking the other side I think it also looks at which paths were
> changed to avoid calculating the patch-id for commits that cannot match.
> It also batches fetches the blobs it needs in partial clones.
>
> As far as I can see the implementation here makes a separate upstream
> revision walk for each branch, and recalculates the upstream diffs each
> time which seems less efficient than it could be.

Thanks for spelling that out!

> > to be useful for identifying rebased branches. But
> > of course even rebase-merged branches can end up with minor
> > differences (say, a commit was made upstream before that branch was
> > rebased with an identical change; no conflict occurs, but the new
> > commit differs from the old by not having that change).
>
> Yes if a branch has been rebased before it is merged it may be altered
> such that we cannot detect it.

Yep. I'm not sure what Harald (or we) would want to do here.
git-range-diff has trouble detecting these scenarios today, so maybe
matching that and later finding a way to improve is ok.

> > In the squash case, I suppose the best we can do is check that all our
> > changes were applied at some point between the merge-base and the tip.
> > There probably won't be any tree-same commits, though maybe a
> > (premature?) optimization can return early if the trees match exactly.
>
> If we have
>
> (topic)  D - C - B - A
>                        \
>   (main)    M - Q - P - O -
>              \          /
>                - - S - -
>
> where M is a squashed merge of topic I think we have
>
>      M^2^{tree} =3D=3D topic^{tree}
>      Merge-base(M^1, M^2) =3D=3D Merge-base(topic, topic@{upstream})
>      $(git rev-list --count --right-only M^1...M^2) =3D=3D 1

Perhaps we are thinking of 2 different things? In practice when I see
a merge created using GitHub's squash and merge option (and, I think,
also when using `merge --squash`), there is no second parent. You
could instead just get

    (main) S - Q - P - O

where S is A+B+C+D applied to Q (i.e., closer to a cherry-pick with
--no-commit).

And we know that S is not necessarily tree-same to topic's D, so=E2=80=A6?

--=20
D. Ben Knoble
