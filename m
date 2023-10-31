Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973BA10780
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQfb0un1"
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480DEBD
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:20:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a62d4788so8060252e87.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698733254; x=1699338054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSVuLNNvGZNaVLIxQRO3hm3J04vFoN9ceCyuyJlU8Lg=;
        b=WQfb0un1PTytS+wuo84qYNKo0DXUUZWswlHjgya/2sL8FQymU+PzQEfV86gJNQ69lp
         MDrknlUOkKfq7xZmPorpxru5uD7s0M2SG4bguSzxzGCYuW2V+ed8JEXwVbEeYUO9T99W
         2DVoknSMRNShM0S2q2cyRpA8cFgVMnIK9K68qawlKHPgkqpDE1pu9BYsbcdvvlM4VLVs
         0McP1ZTyodTCtTpsB47FJggPfooSqrPDp9VQsN1v8y3guS6YKVR/xypum/9X8r5mAT8S
         KvY40d37luy004chc1xQoaC1K44U5+m+6dSvt5PotIW9iBO76PQtKYZmN9tEEesAnIfY
         oMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698733254; x=1699338054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSVuLNNvGZNaVLIxQRO3hm3J04vFoN9ceCyuyJlU8Lg=;
        b=VfNMzXrLN9UDxpBD9Yd+mhun645joXuSfyCkK3g4Y6B1XpfvyZvZrIZLVxVs1QB7wB
         YyxuC9eVJ4l5AP8qm7xdFFYv3Fu4SDHpXxbbKkEijzNkorEhY7fQCFvTIJjpZHbSgjUw
         vP5fnXz441Kc/kGGIDp3asp4me4GDiwYmWkQk5CNuO8NiG4C+WL3WE7bVp+3MKGSEmbR
         KUlmWzK0EHo5Z3/sj4MaUhNUm27AvGspZtdsrz8xI2WIAirpN8yCNbDRHyX5xx9AzBRh
         A8bh+XrTTXxqu6vgLdNb2EeBdG1V3mSXTzA53lwx/E+8Rko9KbuX8Sk5jA8zkVPv4XwJ
         Jwwg==
X-Gm-Message-State: AOJu0YwnJz7PzYHsKUPLUaMNfdihET57/NtZEYBJXe0zb/cqvs/c2v+j
	vHxTXneK80xbO6MXclCwhlsqR62O8W+qQN+sQOg=
X-Google-Smtp-Source: AGHT+IFAsyGawUrrb1hsiczBTLnXVeYptvu1sriY9U+RgasroHeO0EFI+vNYral74RrsMsGs1P71o0WTvP6LmyQgvGE=
X-Received: by 2002:a05:6512:3b89:b0:503:36cb:5438 with SMTP id
 g9-20020a0565123b8900b0050336cb5438mr10329654lfv.21.1698733254130; Mon, 30
 Oct 2023 23:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
 <xmqq7cn4g3nx.fsf@gitster.g> <CABPp-BE6_nuMeiqOAMGwP8SH=d1+i57-STgTNKU8-Gnkv2jW=Q@mail.gmail.com>
 <xmqqa5rzadlh.fsf@gitster.g> <xmqqcywv4ar2.fsf@gitster.g>
In-Reply-To: <xmqqcywv4ar2.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 30 Oct 2023 23:20:37 -0700
Message-ID: <CABPp-BFY7m_g+sT131_Ubxqo5FsHGKOPMng7=90_0-+xCS9NEQ@mail.gmail.com>
Subject: Re: [PATCH] sequencer: remove use of comment character
To: Junio C Hamano <gitster@pobox.com>
Cc: Tony Tung via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Tony Tung <tonytung@merly.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 10:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Elijah Newren <newren@gmail.com> writes:
> >
> >> I thought the point of the comment_line_char was so that commit
> >> messages could have lines starting with '#'.  That rationale doesn't
> >> apply to the TODO list generation or parsing, and I'm not sure if we
> >> want to add the same complexity there.
>
> Earlier I said
>
> > Thanks for a healthy dose of sanity.  I noticed existing use of
> > comment_line_char everywhere in sequencer.c and assumed we would
> > want to be consistent, but you are right to point out that they are
> > all about the COMMIT_EDITMSG kind of thing, and not about what
> > appears in "sequencer/todo".
>
> but with something as simple as
>
>     $ git -c core.commentchar=3D'@' rebase -i master seen^2
>
> I can see that the references to comment_line_char in sequencer.c
> are about the commented lines after the list of insn in the
> generated sequencer/todo file, so even though the rationale does not
> apply, isn't this already "broken" in the current code anyway?

Yes, I believe it is.  However, I remember specifically looking at
cases with --rebase-merges about a year and a half ago, and noted that
there was a mixture of hardcoded '#' references along with
comment_line_char.  I noted at the time that changing
comment_line_char looked like it had a bug, and that the parsing in
particular would be fooled and do wrong things if it changed.
Unfortunately, I can't find any notes from the time with the details,
so I don't remember exactly what or how it was triggered.

However, I do suspect that the references to comment_line_char in the
`rebase -i` codepaths was not for any actual intended purpose, but
just noting that they were used elsewhere in the file (for
COMMIT_EDITMSG, where it made sense) and just mimicking that code
without realizing the lack of rationale.  That would have been mere
wasted effort had the comment_line_char been consistently supported in
the TODO file editing and parsing, but it wasn't, which left TODO
editing & parsing somewhat broken.

I think supporting comment_line_char for the TODO file provides no
value, and I think the easier fix would be undoing the uses of
comment_line_char relative to the TODO file (perhaps also leaving
in-code comments to the effect that comment_line_char just doesn't
apply to the TODO file).

However, if someone prefers to make the TODO file also respect
comment_line_char, despite its dubious value, then I expect any patch
should
  1) audit *every* reference found via git grep -e '".*#' -e "'#'" sequence=
r.c
  2) add a test case (or cases) involving --rebase-merges -i that
trigger the relevant code paths
If they don't do that, then I fear we might make the bug more likely
to be triggered rather than less.
