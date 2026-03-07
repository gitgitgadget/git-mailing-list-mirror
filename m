Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B32DC798
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772847478; cv=pass; b=RDQMoFoB/0pEBlZSFJ89EHm/NB/x7NNT7+Vr9lCKZQlYbODVFTJ+1QLk4RJDM7ywh4jmwYgG7ziCM17wZ9LXbFzlxkUWX6bxpBvhSIi3Xy0wsPTdX2iIO9oDsiC7VB2/Z+LDetIkJY9yZzp6BD8FGGeHPlJCVSA1le/dwOHkCOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772847478; c=relaxed/simple;
	bh=yJ0+DSP/8BlqeY5P1/t7K/noQJpFDPEarDNE6hv4Bzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6QxgtU3xr6XTMVGoXFfTJdrryDXBaY/EwI4I69JOys5rA/n7wfCoarQQmxwPvIDqtfsiG/MRFntjpldAUNqCgBNkEwy6poukSxvHnUuiR2rZ9NpUp4nH5mLlw8z6cLDr44XbOejl0C4HFVUF1t/0GiZ94pf2vxIneq9ofbOFbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTTLgNlr; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTTLgNlr"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40ee9b945d5so3070900fac.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 17:37:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772847476; cv=none;
        d=google.com; s=arc-20240605;
        b=lIUMk2+JwqIvCDuGrgZaG72SPVTAdnjqtuYdN93durAODPLDXrPrJ2vz1J0IJVoW9B
         ecoHS+vuwbDXMPfOctwtZiILGn8AatXuQK7rxuP6bZiEOdPikVPWGP5tSW2Y78wBAwn7
         7ox2jC3gidYJqQiMemZKeDW6FX3xilUFuago6b77+MoiDjfXuLpmjaPGJOYSvDDwFLzk
         Sge9Ll/Q4Vu+Y9M8fpoX8+v4sESfFh4T4G3Yhj/faqb88Rad0yQ7fE+ryHSL9pyQtVJz
         EzOq69kCRdfYYEzW9cgSh+YLy20JH6a4DHPslefYkBPZTKHnBlukrcCRhbWgBxRdynNh
         S+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V5IBZybL3aISUZhOxcNXGFLiZr2fGJl/f6485UxJ7xo=;
        fh=w+lhZo3QqRnLgBc5HfoeM1zDz96L71alhEZx2Hctczg=;
        b=ULsEv9Y0q3BxHj+0L0NKjoNSSvq+Q0yegOWvZVqkrqx0hXIyDhg54cmvfTGFH1qtR4
         BJmeaBm+yzRj+QDzwOVloIByBoR+4ykez6kQ+xkRvUuozXGYb25MnQQGsPsUqVt7nqf6
         Th20yGg9uvzc36j+/HsYAg5kurUA6R1fFuZKjRh2WzVbpJLvFCwvWEfXsoCnMw8VLFqH
         y84fh96Qe7VHhlt+kKFBJqxWcAYfpNKvMIILi/VltwGywNhP2P6OuOtjMO+OMugZmz/n
         gLt3eMClLNjMd6d7D8H6OYFcbIxYFQDWfxEUE7GjZm4AMGkbhS8OM9NnzhQajmvpFhpc
         RjMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772847476; x=1773452276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5IBZybL3aISUZhOxcNXGFLiZr2fGJl/f6485UxJ7xo=;
        b=mTTLgNlrPi0btl7q5xxIJFC6FpdIx7bXu00SuFb8Oqzi8WWISzEObgyvltJ8FPdrMF
         zkCv/1MpSk6EyCwSLO8bIbBd/FGbs+0Zq3ckvpZZACg2cSaxpMWa5d/V1b8M5a+fHZT6
         NtoMiPuvKPD1ZLIxT9YhqttFLf94CaZ7Iaetqw9yODRZ3v7KS0IeY5/Bekf5bpkWmA0e
         iQt/1mm4eOfuPAILbb5gKK5ZKTf6x+lNvQpPGHxuo7eqWRpdz5nQhs6uWl7lFh3KRdhj
         /ONAYttx+jO1RA0ZC/CI3Z70RmFYO39RXVUX5T/L/DIPozO1Iqy1/wCTF63rWTgt6QwW
         BEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772847476; x=1773452276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V5IBZybL3aISUZhOxcNXGFLiZr2fGJl/f6485UxJ7xo=;
        b=l2O2qMbRYN2RXa5nuFyGdhvXWgZRYDuUMb8+zNVi+1kJM4QPAntXfM5zMSw0CwGsg5
         TjK6NWnGGaplZdtMb6yBISba+sNIvKta5Koy931kHU8n/6JR3e/uXf9slvViVaGUgINA
         8NwRWJmJdrCarns3wgKxb4sBpMKBuFyOIL4oBfKM1HrpyJt3cSzQYHnZB6DTEqByYaSc
         fwPrCvfI9/fFambQUQdJzEi3Z+T4Frq5Qd8TuNp9yu/g9M1xdvJYjCHfG/qzkdHzd+jw
         xK6Yjs5Wz3UY/Go7tZiEkTvuAOlDmXgXGxqLxf/fhLnsA9Wt1wLYjlKkvbUhWpsXfv22
         NBAg==
X-Forwarded-Encrypted: i=1; AJvYcCWcFU1jY+9vwdguu6XwQi6V3GCm4fl4VkdMNeLrTGhalpLKl20+hwtxRzvFRMfe4cQbQPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbOFqxlXjGUNm4BuUpBA/TqLShOrDaIdw+hgtH4wBjCMnBb2ix
	Xa0EjS3KgjaJhLjO2dVdVry9C28vZG8E2tw6yJbgC8N6sXJFHiVVQbb78Ry4t2D8DyjOSeZXu8r
	Xmb11xUJD6SxLoexx9IlD3eZxWGCaV5I=
X-Gm-Gg: ATEYQzw3cTbjE3GgxtBgADXGmAPEtAN+rrGcsHAUS2R0XltOZg0EwhnIwJ59tZ+ziAi
	O8MkV6Ar1JIRY+8zgAoWhvrbNpbjf1ii4qp+VMEPArDMNVpfCBVQhaU2WWLptF/jQLcJdec9MLo
	C8CamkqPe7d0pnEGcb2gfnSM69Mp/ITIkvbWElBzMHOtziqqekraE7EWq/Nnbu+0KNYo75qKIE9
	z8+JlmcVOkbRnjgBqY4OWmcaO3tiBfmXWrJkueaQxOj8nOPX8/u7/iwUcavmxMVfncN5cjw7fzv
	EV85gPexHqlBBKvvySq6X3TGBk0moylABsyWwxRStEpUUhWLdiqL
X-Received: by 2002:a05:6871:e785:b0:40e:e9ab:f6ea with SMTP id
 586e51a60fabf-416e4427a85mr3023953fac.43.1772847476151; Fri, 06 Mar 2026
 17:37:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com> <xmqqcy1gv351.fsf@gitster.g>
In-Reply-To: <xmqqcy1gv351.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Fri, 6 Mar 2026 17:37:45 -0800
X-Gm-Features: AaiRm53uDHJTsKYdpGnFjSZPV549RuSmr9oki_3PhtM9hm1xwOHO4RCka8BDtfQ
Message-ID: <CAC2QwmLnLqMcWc8az6pVzz0oEdY282Nq-Lun5OrHaqHUiVE_9w@mail.gmail.com>
Subject: Re: [PATCH 0/4] line-log: route -L output through the standard diff pipeline
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 5:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > git log -L has bypassed the standard diff pipeline since its introducti=
on,
> > using dump_diff_hacky() to hand-roll diff output. A NEEDSWORK comment h=
as
> > acknowledged this from the start. This series removes dump_diff_hacky()=
 and
> > routes -L output through builtin_diff() / fn_out_consume(), so that dif=
f
> > formatting options like --word-diff, --color-moved, -w, and pickaxe opt=
ions
> > (-S, -G) work with -L.
>
> Exciting.

:)

> > User-visible output change: -L output now includes index lines, new fil=
e
> > mode headers, and funcname context in @@ headers that were previously
> > missing. Tools parsing -L output may need to handle these additional li=
nes.
> >
> > Known limitations not addressed in this series:
> >
> >  * line_log_print() still calls show_log() and diff_flush() directly,
> >    bypassing log_tree_diff_flush(). The early return in log_tree_commit=
()
> >    (and its associated NEEDSWORK about no_free not being restored) is
> >    pre-existing. Restructuring -L to flow through log_tree_diff_flush()=
 is a
> >    larger change that would affect separator and header logic; it is le=
ft
> >    for a follow-up.
>
> OK.  Previously all the output routines were hand-rolled, but this
> reduces the extent of deviation---as long as we are moving in the
> right direction, it is a good idea to find a good place to stop and
> leave the rest for later.
>
> >  * Non-patch diff formats (--raw, --numstat, --stat, etc.) remain
> >    unimplemented for -L.
>
> It would not hurt if these are omitted.
>

Makes sense. I can omit in a follow-up.

> > Michael Montalbo (4): line-log: fix crash when combined with pickaxe op=
tions
> > line-log: route -L output through the standard diff pipeline t4211: add
> > tests for -L with standard diff options doc: note that -L supports patc=
h
> > formatting and pickaxe options
>
> I am not sure what this bloc is, but it looks like a reflowed
> version of the list of commits below?
>

Yes, this was a mistake I made when crafting the cover letter.

> > Michael Montalbo (4):
> >   line-log: fix crash when combined with pickaxe options
> >   line-log: route -L output through the standard diff pipeline
> >   t4211: add tests for -L with standard diff options
> >   doc: note that -L supports patch formatting and pickaxe options
>
> Let me throw in a handful of names found in the output of "git
> shortlog --no-merges -s -n line-log.[ch]" on the Cc: line to solicit
> help.
> .
>

Great! Thank you for your help on the review!
