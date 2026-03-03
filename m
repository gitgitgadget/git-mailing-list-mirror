Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0639479B
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563284; cv=pass; b=M+wVHbUZ64GUXFDZp1KCDtRgPeT27VoLZ7zF/i1xZeQIrUWtDY5ZWaVWL2DonVge1Ctr8I5uZF3hTdsGLDH0SxSX43gLLdNaOrnJ8I9z6jtb4ACL8MoUBO51z6WhEOeQJs6UuDL3OkXvBXt+y7Q2Eqn/IBdll9So2C/ST0gvV3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563284; c=relaxed/simple;
	bh=sN0QYknk3aCV81Bhla3xN4p266StktBxg8x+iiwLi+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMXsxXoxKil3pyfGqnbicN0V4sqgT0r9Cgc9V3ksCWj43X/oRuUBGI6RMqsfcINqFQFwM+ga5zmWZDlDIx38G04+QxgDkB8vkGYfBIBBjTQTVLOrAgbPcvryNG9W6Bu8PVH6nD4ISlrDh7n/jZi0aWEpvKz8QPvSDL2Zfqx6tPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahn7nNxL; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahn7nNxL"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82748095963so2999510b3a.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 10:41:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772563282; cv=none;
        d=google.com; s=arc-20240605;
        b=Ea8IYfwDpxOBWZE+gVmc2/8B+laz3+KHvmsW+eX8IVlM6V6D+EWW+rNAmP9FLVPirC
         qB633zSmNtx+VU4KFI/btNTDNla/DEytHzNPUtO9UOc0KwcS3IYNUGQoKVKOacM/t2fd
         vXyxKRR5VKWpk3Ggs5u8UsxeA/2jcYG3I/+HmD32M2uIHRAQ/OHgRWFbF0yn8ONI0E1y
         3FmqfV14QQxASKh7WfwEghk9aOeWo8Wq0efrPpKrmSWLoI3iB3uDBWNjElfAhP1zfrbW
         AG7k/85ElgvFhzirJeVFCK61LNHOL4irBY59hWwJeW/NS/dM2/5BCaX49LZc2XDvjqzp
         FLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kLvLsZ4OPtrftUKQHAMOrR7p+SIWK0MeqCLcQJAD8e0=;
        fh=7C13Yara6diLW3o1hgquesR7ciM/ftgxAeePVQ59NFA=;
        b=c3GkxaKwQBXJ/QcFFj3IvN7tZVl1tlTThMk9BaO5CUuclw2mU2v/s1wJcUhzRWeaQv
         lXAkUeiiuM97kLfIFSJCjmtQTMbi+EDU/p+VXQwN+5GkBjgR/RJfnyWAdTWrA6VeeWPv
         yjDS6qeGCQSrkVeZS68Kmm0ETbNaUCbwHo5n8hoUy9oHisZTiSVpYqgkc61lCl2U2w5m
         6nHYGL6qbvJSStMwii4aUVOSQGEoLUfFFowHLp0S95FzsH1Rb8BsoI/Od3pveXAwvyGW
         Z0b02VPh6LSJlr9b11Bn36kyvkx/iSaQK6Y61kOXWwIyWWRJPPSyySYr7pIzW4cMBBzU
         wAjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772563282; x=1773168082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLvLsZ4OPtrftUKQHAMOrR7p+SIWK0MeqCLcQJAD8e0=;
        b=ahn7nNxLwSqvd+FG/ksbiMgkR00Ks/mJi3yInTFr7IqZkKlxwCUSX6tlrcNXo8YBr+
         ahkpzdYW6tpY0gyOGCr2qpmjYajMFi1vou124v0F+7v+S8etqXLaNRTzhJAuidvq+upa
         gObmkqN3K8z42WAiul8NUOe+bNn0F3Znyo4qs+Bl4uaMR7qjpG3bbJb1gvCng6jj0Dz+
         bBgLVYcRxVzeb4L3hVX3voz1v1clB8AqU3HP4rKWJcxFjdhAbfv2beiTMKwz9Sv51aK/
         UT6HgGncP9jPchz/ftKubSNuDonN41HWXLpqIZxZMEAn+eCS7AZe0jlQ4skhC+y6W6oz
         mYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563282; x=1773168082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLvLsZ4OPtrftUKQHAMOrR7p+SIWK0MeqCLcQJAD8e0=;
        b=r613+bnAGhjX91qGQovqv+kWwtxUO68hOMioz2RXPQRnF02Z//N5TGRb7tKEVvIShp
         4R/AHftnpBg1AvHrE+9hZfBeDrnan2Wfb/mWizqFDbycFNp/y3ABdhysf+M1wHV1bR5J
         GYvNVjOAvIgCfdTh++uz8ihytEJdHvnikLpG9ooPhpl3cWXyrvelXC2lUeXYAHg2JIrV
         aVliILY3Z6m13CmYLMzgdZ7GFlmQQ2sRgH9pKuAzGjUkMdz2okVt1WwtQ6HDkvQKY96C
         4BdNL+IuQUkKU8ayQo0A/O2M4q6THiNoZmr03ptcwKcoVhu9ZCAkd4Ib2lXNBLq+B1YL
         e53A==
X-Gm-Message-State: AOJu0YxXQ2Ntj95qcVPFD1vQoN3t3AzUbwQfuhstk2YIuyZK/Winn/gF
	WDj1gaOa05o12AzQ7hIzYeokwIW2vxTcdLClU3/5RMlgM5uA3+WI/m1uIY9/gXouW4KKItmc13W
	+A0pYFC2YVkIVnHdVcRKd0s/wb6DBgRk=
X-Gm-Gg: ATEYQzw7jzHyr2/VcuzJ6wcW1Ct/FAF1zngHqUwtY29ho1Ilg7a1alq52rcKKGRS96y
	+uyxcH867H928e4+28EYxzY2i2usd5J6FpDEAMqb166/qZ9WDNYX6epCsoRpW26UAGAVCF3dUpx
	fbMnKus/ucOM7OrG+TIZHpHD7A8Hiq1DnKknwx5BBiWPhPpKkj1B8r/oozntCHU5XEGijhEohwW
	ZFx7rM1o5hGmhc8rgcqqnzmbkD4EU5MHVCYWyYQM8CSK8M9ZjWGTt3x69XHa2AkPfOW2BV2SIPU
	SRU/UakwoE/evL6YgZyjTUCN2JWPkRvmRmNCp2nemSEvaQri0GEVgP4Ne44wAlxTaEToJfh0pUi
	Q/JQVU7FtKCdA87/pN5hGL/aXXn4jBhKn4neFrg==
X-Received: by 2002:a17:90b:3f88:b0:359:855f:ff96 with SMTP id
 98e67ed59e1d1-35985600096mr11388687a91.17.1772563282391; Tue, 03 Mar 2026
 10:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
In-Reply-To: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 3 Mar 2026 13:41:09 -0500
X-Gm-Features: AaiRm532WW3v-G1DGm__2c9Trn2L2v0d8ExPqBLDJKIfkHSM26wsTd07Y9Q4W9o
Message-ID: <CALnO6CDMF1G2AFMDXu=xhCv5XcgKm_-JXY2RvLc4TsD9Kh-K6Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] history: introduce "split" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 7:15=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Hi,
>
> this patch series introduces `git history split` as an easy way to split
> up one commit into multiple commits.

Exciting news, thanks!

> This subcommand has already been
> introduced in earlier versions of my git-history(1) patch series, but I
> eventually decided to evict them from this series so that we can rather
> focus more on basic decisions.
>
> In any case, the current version of this patch series matches (to the
> best of my knowledge) the latest agreements on the mailing list around
> its behaviour. Most importantly:
>
>   - It will ask for commit messages for both commits, not only the first
>     commit, which has been a bit of a discussion point.
>
>   - It is not possible to edit hunks. This results in a mode where
>     conflicts are not possible as the tree of the second commit will
>     always match the tree of the original commit. Conflict handling for
>     subsequent subcommands will be a bigger topic, as it probably
>     depends on support for first-class conflicts.
>
>   - We also update dependent branches, same as with the latest iteration
>     of `git history reword`.

Matches my memory. I think the dependent branches bit should probably
depend on the same --update-refs option, so I'll expect to see that
(not sure why we'd make any other choice ;).

--=20
D. Ben Knoble
