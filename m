Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D786AC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 13:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C69613AD
	for <git@archiver.kernel.org>; Mon, 24 May 2021 13:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhEXNKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 09:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhEXNKy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 09:10:54 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF98C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 06:09:25 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h15so22067771ilr.2
        for <git@vger.kernel.org>; Mon, 24 May 2021 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7yWevsM75MBF3cpNsp0n4FT2aOPeQQdRDHR2LszXAmg=;
        b=F/HJWwvfFqtWXlF09SK6P+FLGYPTmYsBop6JN40vaBmtgofrIWzMzFc5MCnJ119n1o
         ApdG+kZSoCMwDkROZStVVh/G2TmjXGtz/SPCjPWq1LDpmzlfcc2QH1wEL1UB7GKCyBJC
         4RT3ssOcGRFEnVx9v9n8waUcII91GhTqbq1ObvKx5J0pNLb/APUMS8tLrPtirRfysxmC
         IdMf3x5nqIPHWz2T5A5HmsaaD8sB53lqzCd+Yzylap1JhkQlYrqnvFVrB3BCVbBKO8k3
         HhV8XY7uJ+HWGChhZY7+ptfiK3LAscxYtJMVQlEl+Kt2O8tT8qjIW+Dwm+th4234iiTp
         8J8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7yWevsM75MBF3cpNsp0n4FT2aOPeQQdRDHR2LszXAmg=;
        b=A1H3O0fgaEIPgc1iJlG1pznT1tv4+J+jL29imL2lntYMXMPEWouvjwIHuvQfHY98Rw
         PBHV561zpRf1lAGrsOn8rrl3CmnOLnWqY015lI8THWJWEwyI8VhYx10wZxFbHBGpa4Ck
         pvLgQZ8/1qHBf2wL1quMZqD1e9XKgnKCZNav56fXqCMPRRN7vbcfDFTFzgCTP8IJdxhs
         +oxuddLPqq8yk5HAighEUdDFibTv2eJUum+nTykT/fVQ72W5Y0cIN/TZlWaq17c9MCoD
         F3plN6JUbNg8tb7REsYNUsr2iwgKVeqkh8cAS0PBq7/RIn7aS6Cp0hXg4H0CnMaGU9sF
         mXAQ==
X-Gm-Message-State: AOAM533WtJLYj6npS5zzQG/SPbrQZIgEL8WxFx4bzCaZ6FkUdJ3V9QbE
        wh5YRK9nh/NOtaM9phmbGHyMg+ttRhoFPbEDjwY=
X-Google-Smtp-Source: ABdhPJzsSrP131VVRyKjtKVCHGwGNbi0Ea3KBIpF56/EM3NGuOtEmUNFQgJHy67SQGmPG+COYrGcm2pj8s6TY4vI5zA=
X-Received: by 2002:a05:6e02:1302:: with SMTP id g2mr15444397ilr.259.1621861764435;
 Mon, 24 May 2021 06:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.959.git.1621763612.gitgitgadget@gmail.com> <xmqq1r9xndjf.fsf@gitster.g>
In-Reply-To: <xmqq1r9xndjf.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 24 May 2021 21:09:09 +0800
Message-ID: <CAOLTT8RgVO44Lf9jtz=8Jj5CxiGqbeAcFQOwQTazZzBwtKTr6A@mail.gmail.com>
Subject: Re: [PATCH 0/3] [GSOC][RFC] ref-filter: add contents:raw atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=889:09=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > In (a2f3241: [GSOC] ref-filter: add contents:raw atom) I did not notice=
 the
> > ...
>
> Before going into any of these details, remember that the cover
> letter is where you first sell the series to the readers.  Why is it
> worth their time to read it?  What problem does it solve in the
> bigger picture?  Mention that we want to let "cat-file --batch" use
> the ref-filter --format logic, if that is the primary reason why we
> have these three patches, for example.
>

Thanks for reminding, Indeed, as you said, this cover-letter needs to
explain the patches' main purpose: let "cat-file --batch" use the ref-filte=
r
--format logic.

> I actually do not know if a modified form of %(contents) is a good
> match for this feature.  It was invented as a way to extract the
> unstructured "free text" part of structured textual objects (namely,
> commits and tags) so it is natural that it would not apply to trees
> (they are structured and there is no unstractured "free text" part)
> nor blobs (they are totally unstructured and does not even have to
> be text).
>

This is exactly what I worry about: Does %(contents) have good
semantics to explain things like blob, tree objects which have no
unstractured "free text" part or totally unstructured?

> Is there another word to refer to the entire payload unadulterated?
>

If you specifically mean "raw" in %(contents:raw), I agree with Felipe
Contreras or Bagas Sanjaya, "raw" seems to be enough. But if you
mean we need another atom name, then "%(binary)", "%(text)" may
be possible choices.

There is a good word in `ref-filter.c`: C_BARE, but this enum vale
corresponds to %(contents). Therefore, I cannot use the name
"%(contents:bare)".

> > git for-each-ref --format=3D"%(contents)" --python refs/mytrees/first
> >
> > will output a string processed by python_quote_buf_with_size(), which
> > contains'\0'. But the binary files seem to be useless after quoting. Sh=
ould
> > we allow these binary files to be output in the default way with
> > strbuf_add()? If so, we can remove the first patch.
>
> The --language option is designed to be used to write a small script
> in the language and used like this:
>
>     git for-each-ref --format=3D'
>                 name=3D%(refname)
>                 var=3D%(placeholder)
>                 mkdir -p "$(dirname "$name")"
>                 printf "%%s" "$var" >"$name"
>     ' --shell | /bin/sh
>
> Note that %(refname) and %(placeholder) in the --format string is
> not quoted at all; the "--shell" option knows how values are quoted
> in the host language (shell) and writes single-quotes around
> %(refname).  If %(placeholder) produces something with a single-quote
> in it, that will (eh, at least "should") be quoted appropriately.
>

Well, now I have also noticed that --language can make these atoms be
surrounded by single quotes, special characters in the output will be
escaped e.g. "a'b" will turn to "'a\'b'", In this way, shell, python... can
directly quote the content.

> So It does not make any sense not to quote a value that comes from
> %(placeholder), whether it is binary or not, to match the syntax of
> the host language you are making the "for-each-ref --format=3D" to
> write such a script in.
>
> So, "binary files seem to be useless after quoting" is a
> misunderstanding.  They are useless if you do not quote them.
>

Now I agree that It seems that the content of the blob or tree is
meaningful after being quoted.

> Thanks.
>
> P.S. I am mostly offline today, and response will be slow.
>

Thanks!
--
ZheNing Hu
