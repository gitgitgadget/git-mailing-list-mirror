Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680619AD73;
	Thu, 31 Oct 2024 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730375075; cv=none; b=PVCZFekxHvOcgH2Ztrshe0mH/X7l1oNR8DDIwhSS+Z0CTHfgIFwdbfJdX9pcywiGtHDLj84FRjJjd4DYblpF+SW+AVqTgiEeIDbFRHO1Cp63Qmetx6G/7t6v4fvQDyeH3gv+If54Sg6UpL7j+i0ZuzuyBP+FAGIt+addleF1rUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730375075; c=relaxed/simple;
	bh=3jWPczCnr/XwgWMspmZUIhKWWto3Lx8+FuO+O0tiaVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4gK7nKULY3Nq5GYnizNx5IQPOovdnusKmu5DYKlbGiX6mpAyenhX3Jvt0Lb0ktZdJHfZzr6mLAE24DEU4S7AbcIZ8NlcCjVtcvIV5FdPmB7wEWgrcR2txvzZcvmYHTEiXG7bnIBXlw9CpT2Rt4JFHKAOWxmTgAjpJS6XIRdn5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj9DBpah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj9DBpah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DE1C4CED2;
	Thu, 31 Oct 2024 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730375074;
	bh=3jWPczCnr/XwgWMspmZUIhKWWto3Lx8+FuO+O0tiaVU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jj9DBpahB03xnIQC9ukVKPiqdcCtK5Dqtdqtsn4EJzZ2yl0fqxYigfpr4k5AxvcUD
	 0n9h4OvVZQ/L2kIaFD8Wrj2KEg8XVG61/LuuSD5vuvqBPhbvHQUSDC2BCRnTPZH+WQ
	 8FDVhSm103gRbFDLuRzEukhxF6vttx5N3Rn5EWshfU6gDHVTL+eNCq4UScaSv1fCqA
	 Lsf3zuQVlQdg1p1r+Ejs/PjP/tNE8lMW4KHwAKJvWGeMa9TBN9li3trc/qExdXkzw7
	 rHN3RPn/kQLhFkgs58KQCmxVZyotXQoC6NiIYUi6SZOZk1ipyGdqTPPG4rLkr2oOFo
	 3KJmEDtP8cVow==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso11454221fa.1;
        Thu, 31 Oct 2024 04:44:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJmnTk5xqevyjjnSv9/46BTisCrNYb0cBZ0iUTLwYfKpPviE9GE4SU965rVCe3/cdg6W0=@vger.kernel.org, AJvYcCVuPXJTO4XsiIMFsxiqrmxLpUP6654ROcKCZeAHEovZRHiNgPajCdFmm7BXTweQrpsLcoveGMb1hEaL1xgD@vger.kernel.org, AJvYcCWVsEZFvfHATp4E7JvlYTURvPlR2TbsoxtwlUltNyAmg5KejPen/tHsjMKY4PS5adHmQxj1VBBwrpkDzUqH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2AnT8sxFrl7gDM/ybRUn20ffhpKM8RXcdAAc0tRZglkJxRW7f
	jFSgPLM4X7CFi1sF3A+vrdy6YfH6HXL7L3Q+XSIoZzZLojCG63lQttkc7QcV/HiHMcajoP7WUfr
	dDhmsveTOpA1Tkpcpou54CZNNmWw=
X-Google-Smtp-Source: AGHT+IGc8qtIA4O0ZhO9wX9jbnAwAhxR8UvzINkNnQkY25+fTCTC9FBXjKXI/0WScwsi+fwPwSDs8JgMwO4KilgwO+k=
X-Received: by 2002:a05:651c:b0b:b0:2fa:d84a:bda5 with SMTP id
 38308e7fff4ca-2fcbdf616b6mr141228571fa.7.1730375073425; Thu, 31 Oct 2024
 04:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
 <87bjz0k17c.fsf@prevas.dk>
In-Reply-To: <87bjz0k17c.fsf@prevas.dk>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 31 Oct 2024 12:43:56 +0100
X-Gmail-Original-Message-ID: <CAK7LNAT6VbaT=_v5_qMp3-jw5CWui=ZXyiAb2dP20p1tU0JpyA@mail.gmail.com>
Message-ID: <CAK7LNAT6VbaT=_v5_qMp3-jw5CWui=ZXyiAb2dP20p1tU0JpyA@mail.gmail.com>
Subject: Re: [PATCH] setlocalversion: Add workaround for "git describe"
 performance issue
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 11:37=E2=80=AFAM Rasmus Villemoes <ravi@prevas.dk> =
wrote:
>
> On Wed, Oct 30 2024, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> > If HEAD isn't associated with an annotated tag, a bug (or feature?) in
> > "git describe --match" causes it to search every commit in the entire
> > repository looking for additional match candidates.  Instead of it
> > taking a fraction of a second, it adds 10-15 seconds to the beginning o=
f
> > every kernel build.
> >
> > Fix it by adding an additional dummy match which is slightly further
> > away from the most recent one, along with setting the max candidate
> > count to 1 (not 2, apparently another bug).
> >
>
> cc +=3D git list
>
> Hm, I tried looking at the git describe source code, and while I can't
> claim I understand it very well, I think the main problem is around
> this part:
>
>                         if (!tags && !all && n->prio < 2) {
>                                 unannotated_cnt++;
>                         } else if (match_cnt < max_candidates) {
>                                 struct possible_tag *t =3D &all_matches[m=
atch_cnt++];
>                                 t->name =3D n;
>                                 t->depth =3D seen_commits - 1;
>                                 t->flag_within =3D 1u << match_cnt;
>                                 t->found_order =3D match_cnt;
>                                 c->object.flags |=3D t->flag_within;
>                                 if (n->prio =3D=3D 2)
>                                         annotated_cnt++;
>                         }
>                         else {
>                                 gave_up_on =3D c;
>                                 break;
>                         }
>
> So in the case where one doesn't pass any --match, we get something like
>
> git describe --debug 5f78aec0d7e9
> describe 5f78aec0d7e9
> No exact match on refs or tags, searching to describe
>  annotated        243 v4.19-rc5
>  annotated        485 v4.19-rc4
>  annotated        814 v4.19-rc3
>  annotated       1124 v4.19-rc2
>  annotated       1391 v4.19-rc1
>  annotated      10546 v4.18
>  annotated      10611 v4.18-rc8
>  annotated      10819 v4.18-rc7
>  annotated      11029 v4.18-rc6
>  annotated      11299 v4.18-rc5
> traversed 11400 commits
> more than 10 tags found; listed 10 most recent
> gave up search at 1e4b044d22517cae7047c99038abb444423243ca
> v4.19-rc5-243-g5f78aec0d7e9
>
> and that "gave up" commit is v4.18-rc4, the eleventh commit
> encountered. That also explains why you have to add a "dummy" second
> --match to make --candidates=3D1 have the expected behaviour.
>
> Perhaps the logic should instead be that as soon as match_cnt hits
> max_candidates (i.e. all the tags we're going to consider have actually
> been visited), we break out. That is, the last "else" above should
> instead be replaced by
>
>   if (match_cnt =3D=3D max_candidates) {
>     ... /* ? , gave_up_on is now a misnomer */
>     break;
>   }
>
> Then as a further DWIM aid, wherever the initialization logic is could
> be updated so that, after expanding all the --match=3D wildcards, if the
> number of tags is less than max_candidates, automatically lower
> max_candidates to that number (which in the setlocalversion case will
> always be 1 because we're not actually passing a wildcard).
>
> Or, we could explicitly on the kernel side pass that --candidates=3D1, bu=
t
> yes, I agree it looks like a bug that the loop requires encountering +1
> tag to hit that break;.
>
> Rasmus
>

I still do not understand the logic either.

git traverses all the way back to
d8470b7c13e11c18cf14a7e3180f0b00e715e4f0.



$ git describe --match=3Dv6.12-rc5 --debug c1e939a21eb1
describe c1e939a21eb1
No exact match on refs or tags, searching to describe
finished search at d8470b7c13e11c18cf14a7e3180f0b00e715e4f0
 annotated         44 v6.12-rc5
traversed 1310005 commits
v6.12-rc5-44-gc1e939a21eb1



Or, more simply,


$ git describe --match=3Dv6.12-rc5 --debug e42b1a9a2557
describe e42b1a9a2557
No exact match on refs or tags, searching to describe
finished search at d8470b7c13e11c18cf14a7e3180f0b00e715e4f0
 annotated          5 v6.12-rc5
traversed 1309966 commits
v6.12-rc5-5-ge42b1a9a2557




e42b1a9a2557 merges v6.12-rc5 and 25f00a13dccf.

The latter is obviously, v6.12-rc2 + 4 commits.
v6.12-rc2 is an ancestor of v6.12-rc5.

I do not understand why git traverses 1.3 million commits.



--
Best Regards

Masahiro Yamada
