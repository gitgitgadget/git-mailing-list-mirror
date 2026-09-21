Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665304FC346
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027185; cv=pass; b=mBuXDmy9yVnW6Jx+YTlwG0Y91dbfXNDaDD7GD0VuAPKKMOif+WMW8kpezK+SbJxcjj22xj/o40AiDTDt4ia+XXZlW7JtDKSVwbEBEGHT+EBvbP/aLfiZqrxmM0eVXoiIyld8pn8c0/N8jH+vR5h691I5k1ZD6GQKA5q76Bq8pz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027185; c=relaxed/simple;
	bh=4f+kWoWFp/fIYcGnxNnazAKMKFKhfxRUIjLCeczxIMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB9bBnQnlOYi+aTTJJ0MDlvnKMs6ggxK7ys4eucZt0aQ+Sx2tcH6v8WCvCUtz+7HH3DvYX1uywU8sMIIauY6GSKQOE/qTiCl66IXNf7FSKfPUcckBi7ddQ2wgNqL5OTS7eBiYE5SXpIwBwgCjHSuvFr99HSrY8ZEDUnuGpoPi+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5Y8bGcE; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5Y8bGcE"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605844571so4194207a12.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 14:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790027183; cv=none;
        d=google.com; s=arc-20260327;
        b=azWPKpLUzBgnUi1wYq5P30DKNG4pbUh1E2ZbwRyrNFh4BbUe3nejWMTygl/jUu3PeU
         4XTdX3URZGX8jyf87oLD0+98eufsI4lIGFyn6WgdAF/uek9bKk7utk+ZFiPQBOaZQzyd
         A6hLj+MVuYdtXvN8ODdtU2Yfxc9jDxxAH3lhq97r1gKtL/Vyy4bi9na9VIHfVSKrejL9
         S8Ez5BtcyHI3YZ/OF+jrTXY94Q84148aAt5lQRBH+IlPEfpe0n5fRxchwfSO1U4Jje7Q
         3gphcndIp7LCCQWcCYJ/B1Jnm149NRre/b9lF5NCqXIfVQ68mFua/OjTiylfyiAJKJyO
         050Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4f+kWoWFp/fIYcGnxNnazAKMKFKhfxRUIjLCeczxIMU=;
        fh=aTGZ6jx5UyevNPha+iFlvG81us+fLqFwJH6RRvU7his=;
        b=JvIIzA/M4xIyX/UU9YZbsKJQWPxJtjkGRTORazUDEfqV6Hvbc//7fdNlshq0afYrVT
         UnSf/qX2r7hP8+W0Dn7QsRTKVZDhggAyNudSmRu009HT/m9LEdkMx+jlRS+1YdedYk/S
         FrUgkrN99uDTGLGWdRbksgyDE7Zku3GyIds+UI8TxuKolZZSb3aL+OukvtGPMffjXa4d
         wyvj3vC6IqcLAiGNNiubyX/36pMINS8j3qi54QLC1v5YQ0aYOSCV1OwnxDNPHjrWrw0O
         C7airH3axR5o0oBMC0nlV9kUiSHPIzdKzld8W1C98gfgl4hH/3fsmhwuG5QW+gppnYa8
         MHmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790027183; x=1790631983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4f+kWoWFp/fIYcGnxNnazAKMKFKhfxRUIjLCeczxIMU=;
        b=A5Y8bGcENB549hNhe7s5y5StrTEUjDRd+6IhiZxyrmWuJ3Ku/ojHLpZHoJ0FppIdFj
         9Ni6fQWQ6K3yu5vZ0Y7DAzTFpQRest/vONcV6admH2ieIQsNaRDypb29Yenf01J/8SCN
         NB8F98gOPLYb9SgKVkP1PYzjTFP/2157/ml572WbMLUQ+nk3+F9gTUOXIaIp85AHobwd
         x9CqRM3PTcheOPlwt4+XZU7x32dPuFOffzmXazuREf6Eck0EfrNjveri5G6nFQHlaNei
         K7hWkgooZUWp5k/eVL1nhwZ7VOQrMVsQlgOjMQjrD070JpVEaY93EJzKp5O2Op5ZhX79
         0ATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790027183; x=1790631983;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4f+kWoWFp/fIYcGnxNnazAKMKFKhfxRUIjLCeczxIMU=;
        b=qecolaT0LEg6KSBVb+Xg88hw5OElV3dRWNaYzjfePet2r1AL1H/4U1xLM+J5mI3RMz
         VxgRhNq2wo8XnjWKMn8DDQh15eOkFa/whhV4HtFv8kHG1ZijZ4E2PVgMXYt0XkGR2YcB
         e8PpJaw0Guo2MTLyA0YXZ4Y9CgUXwESWAixALsV40Gyh2rKsZtbsx4+7Q3BbO4k9MT/L
         ZSzSSfDcpZLFsuQGZ4i5xaq3bsu06kpjSKQ3oZfPQfhhSJYTvTRVsVogR089TDi2gPKg
         5YzaEKMMmgemw/J+W5od9QYkDy3jn8bNIQUcelST2PmLsOmBf3Gw3lW5IfNuWuL3OmO6
         RUkw==
X-Forwarded-Encrypted: i=1; AKwUvBz15pBeBTNy3WDPX6WmhjdY3qhP8vPeILEhn5aCgdO/RP2RCAlB5SVnQ0F2USFi0QfSQa4=@vger.kernel.org
X-Gm-Message-State: AFuF++miVEofirC4cFwdU/QMweMkurR8LLt28kmKKqOksaSWs6QKMrGZ
	es84gTKROT41XKsgCZ2BDGjyg8oWGFr2pmtNJQPokOxhbl+3NqpP/epbueMUZQc1uymFU2IPWbZ
	4k+CT9qgYKJeUI+u/JTBfR3m+7RglBSRtQKf9
X-Gm-Gg: AYBFou2yTgF0Dycl6AqCNJBn5WPbc/TnDA1CVSwdQLhIchtDFa9ug1KZnttHvyUJTHZ
	gc4lqJehRtz4lvIsxokNBZEO5xmlBCd6mLYE95ZWqpar/RpHQGjSu5QdtSj1fWwqJzOLhjtMltg
	Vn6eosAe1qIgPLtj95RCUYEFetLhKiLxOT1vkxfFtuze16KYQiPUbH9WnNcpVhd9ERUbceEZnKY
	pq7UO4zvUdsBqWo8IqQJQSQFc1+smzO5hAshkK8mmj3nRKoH83l/aO7xqRoXkrg+m3C+zTh9CPM
	4sxQd65pp3K1wVhqg/ds1romSbakeZ+1E5SjKEN3kgCchaV3D4J8AD4=
X-Received: by 2002:a05:6402:28cc:b0:6a7:ea54:38c with SMTP id
 4fb4d7f45d1cf-6aa54891f0cmr8105497a12.29.1790027182399; Mon, 21 Sep 2026
 14:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com> <7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com>
In-Reply-To: <7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 21 Sep 2026 23:45:45 +0200
X-Gm-Features: AcwNN1V6KOKVBJ6chT9Qr-ENeqqR6DQWTwwguMS38alcG1AhKBKeM5IhW_l_Yk0
Message-ID: <CAHwyqnWbbCK40qAU1vhCFmN86J-dCY3tv_N_nBYgK2Bxf3o1fg@mail.gmail.com>
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 3:28=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Harald
>
> On 19/09/2026 15:47, Harald Nordgren via GitGitGadget wrote:
> > From: Harald Nordgren <haraldnordgren@gmail.com>
> >
> > In a shallow, sparsely checked out clone of a repository with many
> > branches, plain git pull can take minutes or hang outright, even
> > though only one branch is actually being worked on.
>
> I think the sparse checkout is irrelevant? It is unclear to me if this
> is talking about a case where there are many branches in the remote
> repository and only one of them was cloned, then adding a second remote
> created a wildcard fetch refspec

Yeah likely. I cloned my fork of homebrew-core with `--depth=3D1` and
then added real upstream as a remote. Then I made my work on a feature
branch.

Then tried to set my branch to track upstream, but it didn't work.

Then 'git pull' and it hung.

> If it is the former then we should think
> how we can improve the behavior of "git remote add" in a sparse
> repository to prevent it adding a wildcard fetch refspec and instead
> setup the new remote to fetch only the branch(es) we're interested in.

I didn't even consider that, that sounds like an interesting idea!


Harald
