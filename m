Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABD283FDD
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963003; cv=pass; b=TGILxEy6JbQNzO0ZWVJP3qp+DgzINjKZxK0hA0aC/QqI7ACBPQ89Gg0x3Y+Rk+FBmTIUv7nTi5fS4HXhFNSzdigk2B6Y+7F5oID3AX2cS1muadOsFbzCNebRbua01z+IoxyGyviKfhaKtJrjmqhSP6FMgLaF9GuISfQNXi6KwTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963003; c=relaxed/simple;
	bh=toPpYKJOOOblghSe8k+NhrLlnDLfW2DBHMr5lWLse9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=genhvsmsi7fmz2xbfrQcwcwrZkA0H5gDlcNQwutedJxCZPIJmmiQDb/tzIOzE6DK54heCUpk1LKA+BTfN0gtQHiX6tneJOsY8hEv5GJkCURyPzySS4SqUYzAPuP/pK6/t+c1RuzoP9XCuwJM/0jWs3fOeRcFU5mvYNvJDkiUtKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gen1xXvP; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gen1xXvP"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-396775c2720so45090541fa.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 16:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780963001; cv=none;
        d=google.com; s=arc-20240605;
        b=fGDv+1qE2hsjaEBS2QxClW43G/3jXwzR50ZEFyeRTAUU3CmEk781aT5tA40s2KaXNP
         clmn++NoPIBT55wZz9gKR4nPh4fSRGuDjyMswtwnMHTNDZG5FsAxNK1ARnoTvSlwFkGp
         vJrjRl6Er96tE5meMLacdpXhQdgpkf6NsmeRMqpVcF+hKjSzZEkuBhhbBGlesM6wbR8d
         sg4rQgwDDEb2XcchLt8iYLnCbOER4/NXrC728d+Q2Ap6scdkI6oSj99KsAdCd42FQy5R
         DZm/0wy9Y6duub0X6f985LbWAim98DgKzRXnyVPBBeEabWlqHkQL2OM9DFRfwLPBPCA6
         anMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bpfkN/8D+CY8wLy4hmQ5TtxIRH/WD5cVjXzeR1QQIdM=;
        fh=0sP8vNBMoPrJt4N+8lv1KhHoaXZSY+AKtnt49/tLkeE=;
        b=FQFd5IsW5nq1lBEkqKNG2d+RW22s9xQTByCwEDsxHaT+taQrWVqVk5ynbPgiX+8Skr
         p/w1oL1SbrkpY5aF9LEbXlQ1Q8snli+HNI4QQovdejTCKErB9e9RykDj413vMltXQsz7
         da5SN8+Y7znBq1AD9WdzZ0mQO7XrmGKIAZEdZKoqT6iTatMwlGS1FBZc8O3LMyi2kNhj
         fZpSYzM6uiYuxzuKAPImrNSlSo786yJbxq0tj5sdEooornVKnBzLMpelwv9GqDes62EL
         LBO0IrrWCUuH6WITktYVr23KIAAy01p+qSe0jaD1fT2yksw3oP6DPE/N0Bju1+keVwQZ
         bjcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780963001; x=1781567801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpfkN/8D+CY8wLy4hmQ5TtxIRH/WD5cVjXzeR1QQIdM=;
        b=gen1xXvPeEM575ZpYoKHGrx/nyIJ1sBDe6znDrLBY9dMFh2JCX0ONKi2Q/HZg47Iww
         bBNN71Ba1MX8+aXwTOVqklxRtxUIgMjt2DkuvKsfrjvouxjsPerHaGCv75UeOpTZrKiX
         r1PbfLAdvTlQMNsiVF67YAmuh4QGVdySxb2U9bb6p2QNYDUkqZEJXhXnp3oCME+QU9rK
         7ZPfGUB1EeT68ay8bPtaCA+rMwwY3PCnM1WwVyE73R1N0IntQq/VsmzsYtbK0XHhVqAB
         LaEA4TCzvhCwCl1HvOXp9xmjK3GWnst/5pdWE0LQfMXU6G1//kGeW98ySws0vDoUItTH
         wL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780963001; x=1781567801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bpfkN/8D+CY8wLy4hmQ5TtxIRH/WD5cVjXzeR1QQIdM=;
        b=l7w81L/qJ0X4tANUIi7tkc+6IbWj62y6XyIfsMX9RQZst/rkYSA23jUmLpPfwYJE0H
         ipHIfURtcXLRo+rw5ql9WJCxpYVaRmwh61eCOWK70diXgddUacSlvYypRY3UVQ5fqLrh
         yYhXTTk2Sxfo2ORpxk6ZtulDYQe3NRh0rEuFFYYnSOdiUKDrVfaEKhrGwcUiBMGaFlKs
         bmNPQSYfbBNLv1cGERG4tA1LRuhhVAyAGTe8doTNyZfj6Mg9L8MuASR+1wVYEq51+8Fi
         m9bsWjJIFIpeWQjVLPbYsVEgyVYV7aLfzfV1ab4G3Cdb1uGY+5UMDHtCKXFfvPiV+mVf
         IwIQ==
X-Gm-Message-State: AOJu0Ywuo4uPFi7Y9dMB6jaMnQx9QBNQ9RysqvCKJ8IAoa+WKEW7bly+
	6d4NUKTPIai1TeqDzm5czs0NOboeaJU633XFf5YNquc3mFYFfkw0MqgNu6Iaw5oey5jXRyaKQQS
	RIc2d2iR6/yq+ebsHPCNM92NeWdQQqEA=
X-Gm-Gg: Acq92OEu9vnJrqvDPZDv6HvrM+RYGhJfgHTd33Ccmyspyzc6bcCOaKmsU68GTgp7Xb1
	ghfnQgGaNdEPxLw1Q4mXi9ABWQUiKCrNCC9Upx9JFJVwSiIiFWXtnc7sAvlS/yAUQ3iVHyx8qv/
	Ua9WmkIXuUHWcPFNg1MXgzLyOcVh7YO+8rFUb4E+qspOoVD8nYNkcTKgPEiSu+v94pFcvhOYq1B
	SI28jD88RhMdDlLBK4RDy3B8anXhqKnjSePtPMuenUWjYd2d6un1vlf+IxMdu5x4+r7a6Uou9Ii
	BjUWenatYixmrzwNejbJfqf8d5WYZT0zL6gUZ7bu4rft/uhBZE+HHE7OPTh0s5uhVHhuIYmtNyB
	vgZHGPXecT3r9Px+mQSHQWKZ2BScZ7V0G7iqfvGvbvQ==
X-Received: by 2002:a05:6512:2398:b0:5aa:6bd0:b1e3 with SMTP id
 2adb3069b0e04-5aa87b400b9mr5006035e87.8.1780963000487; Mon, 08 Jun 2026
 16:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ref-filter-memoized-contains-v1-1-a1972dde9c76@gmail.com>
 <20260608223430.GA340696@coredump.intra.peff.net> <CAJ-ks9ng3Obv8jydYiBD4kxmTSZCJX8xNb0YihNeSW8_8WL5Ew@mail.gmail.com>
 <20260608235214.GC358144@coredump.intra.peff.net>
In-Reply-To: <20260608235214.GC358144@coredump.intra.peff.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 8 Jun 2026 19:56:03 -0400
X-Gm-Features: AVVi8CdyXB0SnmR04kY6GxPF1R5zrdoVfJrz4r4nxtnEak955Ib20xXmPsDSeRo
Message-ID: <CAJ-ks9m1BKPswrc+f3JDf5x-APfgZ2ycggxi-tJgr12GONb0jg@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: reuse --contains traversal results
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 4:52=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 08, 2026 at 07:35:57PM -0400, Tamir Duberstein wrote:
>
> > > So I think a better rule here is to tweak the selection in
> > > commit_contains() to select the depth-first algorithm when we have
> > > generation numbers enabled. There's a patch in an old thread, which w=
as
> > > revived a week or two ago by Kristofer (cc'd):
> > >
> > >   https://lore.kernel.org/git/20260527070510.3510836-1-krka@spotify.c=
om/
> >
> > Very good catch, thank you. I reproduced the regression with a
> > 100,000-commit history and generation numbers disabled. The parent
> > took 13.0 ms, the unconditional depth-first version took 238.4 ms, and
> > the generation-aware version took 9.1 ms.
> >
> > I didn't find a patch in that thread, so I will reroll using the
> > memoized walk for tags or when generation numbers are enabled, while
> > retaining the breadth-first walk otherwise. If someone else would
> > prefer to send that patch, that is fine by me as well.
>
> It's just this:
>
> diff --git a/commit-reach.c b/commit-reach.c
> index 9b3ea46d6f..cdea0030b8 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -799,7 +799,8 @@ static enum contains_result contains_tag_algo(struct =
commit *candidate,
>  int commit_contains(struct ref_filter *filter, struct commit *commit,
>                     struct commit_list *list, struct contains_cache *cach=
e)
>  {
> -       if (filter->with_commit_tag_algo)
> +       if (filter->with_commit_tag_algo ||
> +           generation_numbers_enabled(the_repository))
>                 return contains_tag_algo(commit, list, cache) =3D=3D CONT=
AINS_YES;
>         return repo_is_descendant_of(the_repository, commit, list);
>  }
>
> from:
>
>   https://lore.kernel.org/git/20230324191009.GA536967@coredump.intra.peff=
.net/
>
> But I won't be surprised if you recreated the identical patch yourself. ;=
)

Yep, that's what happened!

>
> -Peff

Thanks again for all the reviews, v2 of all the patches coming shortly.
