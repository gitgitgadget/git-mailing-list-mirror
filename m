Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793971569;
	b=JSt/fyHyW/x1iW1+wEIfKd+xTvkcZ93TckHhSiR5s5mAiEa8oAv9RS525xbjE6IvctLS
	 S5eDQOF+4TFDKHn+wcI/pkFRHyGq9/5/ADQWVUPDOMvYQCm/E0IboGxuMU/et68e4IvXm
	 tPFWFMs77bgEtW8OwfMQXniywmWfFLKEJtTpRObgNX71HghX0kN/R0Mbz0s29Fd1tAJst
	 mccGvrgOMNctCVb8/7++VDPUxkUDPySnVu3WS43BSvzj88GxfgOxa80x/n++ia/M+SczB
	 zhEiu3nKoabWN3dkqbdcjebhox7dqXl2eaCu4aS3iiz6oEgt2H4Xt5J5isQP333cP8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=pIwFJ+xpxscW2gT+ykIqeSVY1hcw7WST8PjEc1jichQ=;
	b=bjf5gzueYCghxJayd09uee6/I+A32/fzcDleD2N5oqN7twkBb1/fBSHOxWrouMSksOHy
	 Pe0NRc5NiF1iPEIafUJw5EzzsMSL74a3HIpFEwVVzYbDd/vbge30NaVWdBRWY2EkipQrL
	 OqfTQapS63c4uTxPFbQZ93OPP3PZzbzC5GD//pE9oNWU3tzliVmKfnMKn/o7+sgeZ2Val
	 ElHTGSG4Oe0G70Vtxb4PknTQKGpFxBvz97TZ1S7BJLdr0l186uVYKXCO+3ZgCmg5iWRsp
	 PvtEN/dMXWmqIABmGkc38Y/v2TBwxnTzDlKoMjXd4Ze3L1Sandn7qRAJsZM1eoTXmiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IRt9OHvd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A47606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 13:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50A47606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IRt9OHvd
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so225757a12.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 05:26:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793971569; cv=none;
        d=google.com; s=arc-20260327;
        b=aC2U8IBq+IxzKByi5AKDt5vzCBs+EwBn/tm5tmy1RB7a2JOdqQrUZDWm8cMul3lU9R
         1Xa0+29D5efiE9rihSJiZ35ehXItnvCmFaRrFFMNKXVL7Zhsq/7SwcTlBPbrpfxTY8UI
         fYmhSkXC+ZjlNlp3QF8p5MijBOIrRH3hpIztpjEOgxfZMHW0lWUI3z2Rwff+dXyOrvDk
         kWjI2Oo5jbFCE1bFRFuLKuM6Qmaedmm0EtGhSGN6rkat1CH80kkO8Imq3o6ueoEgTbQP
         xlQujSRfDrj4lJEKrVT5vjPUf0+Fw8o5DL+qcWSqIlz1Y9rXZP4dyMvl0SoWMUSwMLqs
         wQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pIwFJ+xpxscW2gT+ykIqeSVY1hcw7WST8PjEc1jichQ=;
        fh=sllK5gVqlb3vZKCTMXyKlfY1N4ZzdlhogcTBEijKCm8=;
        b=mG2dp7InnYDy16BnLWfc5i4E5g4ff/jH1RuIkRiidWVWY68zvu+mor1UvUyG3NFYXF
         pMaZjwkU58iGrh57jhUxmhHuhu91x1PGhB6GMlk+0r/rMnObWJSpHxTRWZXR66626iRi
         md2Nj7kbmJK8N9kYURFjEwgr4qBRcJUB+vT0UZV5Lwkw4ys+UWOKShBYzzAokLPBpSBu
         Zo3BuCjA91CQl37OWTbSrOa4yXX1NQ5NNJ9yR3/cVAGkQL1ZZOhROTqiTux8WKxoCIuD
         D5T3IPTAVYuXna9TsGlqP8iIG5+qCaYAH0B6Gsbf0sVm6rfo/z9o1mp/TLfT+2KQ5PuW
         q6Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793971568; x=1794576368; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pIwFJ+xpxscW2gT+ykIqeSVY1hcw7WST8PjEc1jichQ=;
        b=IRt9OHvdVTQ5IVzrN1fneZCAzi6Q85wSLMZQH5ub/l+JcQdv/+vDumbBMnM471mbxb
         NI2XuNhXti2sXEtuGViiNW1KIiS/TiBrUI6Vjg92CToFMizhqzDvbzgNTYkjgvEOkzaH
         w/TCWv73aZLJkd+PAJzurPKwYTnnNFwLHpVsyWE5Zoy5QwRMv+bgbz2ILvlc+oDKQQIh
         tWf6sn6Qk/aTeE3Ry9h6jVI7DtkVPq6L7KVRowQQGMNlZtGknQYgKDa7Iw3gO3z6hf2K
         TGvjQQdQim3Nz6rX0LvgFbYrlQpEzq7Msr3Yel+5DnMlEFlXPL+spAkTVCnv0w0xXiQY
         6E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793971568; x=1794576368;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pIwFJ+xpxscW2gT+ykIqeSVY1hcw7WST8PjEc1jichQ=;
        b=bQFzjEKBXsRDeICkqU4xWJ7gBZ7ftd8YNS+FHnGtHZG9nxoDUMRYki7vQZriyGotGM
         jrigltWeInVz3er9oi4V0emx4eqyJpEKSrHEdYSCybr83pqzAbdB5q0IXFJlu7l90kQZ
         sr37P8ITud6CJeJtsLkJBiqreQgQAbLuoVvSlaknoAgqOkZ258aVgBwJ5tc1XFnW+kV1
         7W2zcYjjixIAgfRWnDxhU0FCua5PB/PThXIFUEr1e4xIT9O1jX2ivPfZcejAruJxS0z+
         R0ITQDDWHoBMAsPaofTcuG+87U1tBnzLi3dtM2noCTaDNUaAU1OU72QvBCpdilFDFBha
         p3Hw==
X-Gm-Message-State: APuU4Z+hz1sVvAojEECRIYof8YC2hl1F/FiY3wSTeodojvUTN2C40G3F
	XvaJ0w7eyTBhVQJEbr7dzHCjrzk+cborV0S9m1Oiat2Xt3jXOnur+/ayO302cxgnPjgEllsE7mt
	Q68/xjr1T5HH/b/Rql5TeXc1oUpOiaqM=
X-Gm-Gg: AYBFou3O6lPwHPF0OEXPK/wrqf3DNWAoHOXIE3p00ioxCW+sUoYbqG6kterhADnriH2
	g/plaNUJjxi4NdHvBP9MR97JJwSALBIMSMtvFV5rbh8yrdV574xbY7DkX0fRk6uv1tERnTDcGY5
	NKUDDQyXoQIjaICuzshXJYy/PcnCcxRFpgmGdPgTA2J08VbQ460IQF7PgHLaeINv9eMVGLaNWze
	/Y8b9jOhCtmrqiUGRHvDElgHrmhmR/6QnHpww5Ye/rwjMIzrOxSdvQpl70D+kouLGycFHlh1458
	JG/a34O1axHmq2+EuuTpBA0Sds52Jewo0+yPa6eyoGn0BmK6wdg7cF27oHo3jPNT5IwvCSW/Gfs
	6OiyDDUM1EixpfBBzmJ8X+326SvbsXlgU09M3GXA+u0hYKXQqrXyA20vk6ygRBMwQAOE=
X-Received: by 2002:a05:6a21:880e:b0:3e0:b1b2:2af9 with SMTP id
 adf61e73a8af0-3ebb2aa0e0bmr2610383637.60.1793971568465; Fri, 06 Nov 2026
 05:26:08 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKrRMNrnd2+HxTxadKaha+K9ASWi_oN4h7gdjVYAGmyODwmi=w@mail.gmail.com>
 <20261105120937.10269-1-azuama69@gmail.com> <xmqqwlqqokxr.fsf@gitster.g>
In-Reply-To: <xmqqwlqqokxr.fsf@gitster.g>
From: Azuama Odinaka Maximus <azuama69@gmail.com>
Date: Fri, 6 Nov 2026 14:25:56 +0100
X-Gm-Features: AclHuK83wFLri5e_01u9IquohF7_gq4bIM1hRWLJVvuVGg88ZBfLB0Qfg71IFgM
Message-ID: <CAPki72HBWEP8t9mu1zuKBA33SU1Oj-4bL4SQTqrn0G-H0P+g=g@mail.gmail.com>
Subject: Re: [PATCH v4] rev-list: handle arguments in early option scan
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, tangajoris@gmail.com, pushkarkumarsingh1970@gmail.com, 
	christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

I've investigated the relevant parsing paths further:

1. Revision options are handled by handle_revision_opt() in
revision.c. It already determines argument consumption through helpers
such as parse_long_opt(), which returns whether an option uses an
attached or separate argument. However, the function also applies the
option's effects to struct rev_info, so calling it again purely to
determine argument consumption would be unsafe.

2. Revision pseudo-options are handled separately by
handle_revision_pseudo_opt().

3. Diff-merge options are handled by diff_merges_parse_opts() in diff-merges.c.

4. Diff options are defined through add_diff_options() in diff.c,
which provides an existing struct option table. This includes options
such as --src-prefix and --dst-prefix.

This suggests that the early scan needs to obtain argument-consumption
information from the same option definitions or recognition logic used
by normal parsing, rather than maintaining another list of option
names.

One direction I'm considering is separating option recognition and
argument consumption from option application, so that the early scan
and normal parser can share the recognition logic without executing
parsing side effects twice.

I have not settled on the implementation yet, particularly how best to
accommodate the hand-written revision and diff-merge parsers alongside
the diff option table.

Would you consider this a reasonable direction? Or do you see an
existing Git parser interface or abstraction that would be preferable
to extend for this purpose?

Thanks again for the guidance.

On Fri, 6 Nov 2026 at 01:36, Junio C Hamano <gitster@pobox.com> wrote:
>
> Azuama Odinaka Maximus <azuama69@gmail.com> writes:
>
> > The early option scan in cmd_rev_list() looks for options that
> > affect missing-object handling before setup_revisions() parses the
> > command line. It must not interpret an option's separate argument
> > as another option.
> >
> > Use parse_long_opt() to recognize revision options that take
> > separate arguments, and skip those arguments. Handle -n and
> > --default as well. Stop scanning at --, where subsequent arguments
> > are pathspecs.
> >
> > Add tests to ensure that --grep and --author arguments beginning
> > with -- are not mistaken for options during the early scan.
>
> The commit log message explains the motivation well, and the attempt
> to address the feedback from the previous round by handling all 19
> options from revision.c is appreciated.
>
> But the approach of hardcoding an array of option strings that take
> arguments is inherently fragile and scales poorly.  By duplicating
> parser knowledge into the early scan, this patch falls into the
> exact trap described by the NEEDSWORK comment just below it.
>
> > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> > index 071a0e3cb5..4dd646050a 100644
> > --- a/builtin/rev-list.c
> > +++ b/builtin/rev-list.c
> > @@ -744,6 +744,47 @@ static void prepare_maximal_independent(struct rev_info *revs)
> >       revs->no_walk = 1;
> >  }
> >
> > +static int rev_list_option_takes_argument(const char **argv)
> > +{
> > +     static const char * const options[] = {
> > +             "max-count",
> > +             "max-count-oldest",
> > +             "skip",
> > +             "max-age",
> > +             "since",
> > +             "since-as-filter",
> > +             "after",
> > +             "min-age",
> > +             "before",
> > +             "until",
> > +             "date",
> > +             "author",
> > +             "committer",
> > +             "grep-reflog",
> > +             "grep",
> > +             "encoding",
> > +             "glob",
> > +             "exclude",
> > +             "exclude-hidden",
> > +     };
>
> Is this hardcoded list complete?  It misses options parsed via
> diff_merges_parse_opts() in diff-merges.c (e.g., --diff-merges), as
> well as options handled in diff.c (e.g., --src-prefix and
> --dst-prefix), which also take separate arguments and are accepted
> by git rev-list.  Would
>
>     $ git rev-list --src-prefix --missing-only HEAD
>
> take --missing-only as an extra option or a prefix?
>
> Thanks.
