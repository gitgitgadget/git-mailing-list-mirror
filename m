Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D761FC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABF061166
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhIUPgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 11:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhIUPgp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 11:36:45 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2843AC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:35:17 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bk29so55507616qkb.8
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LnPZCFwcctLZEMntBljOJRTKQsSkUdcd2MX4CMbm2N0=;
        b=UQ0Nz9JT87VbVfWqq9Vq3/C/3SNmqWcBEcGSnlVyScpLgsEuXxKnK72EsCIX8GhNUU
         iomwfaijN0VFiitmLvmzinzQi7b+0F0+hs5S4MYjdIFaCedRHkFU2vyN+MS8zBQVORb+
         jCrtCFCBWPeKLw1zji7nT+TRLQ5tKdCY9uCe/RDNxI7v6UHmMxMErrSvvTcEqBpwyeQG
         03Xu914+fniIdTGUkV5ZkfY+wencmenePYAs1T4xDOJeKYERsWyPEgtfpGhVu5qvgDKb
         z+zK79MjW8jayl8YYjFPTpZynQOWKfbXobHEFBoZsclFLEUKVMSZqY3AZFeX84fdkoxv
         Gedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LnPZCFwcctLZEMntBljOJRTKQsSkUdcd2MX4CMbm2N0=;
        b=cHns2tv3inmfpEkREd1yrR4IAnHSEd8WgkKf/Ch3NgtZ/QqIbKpdmkDoZCSkRJSQ4T
         eq3sNbqW7CI6QdG2pLpEuN2LpaMBKPU0SCF0oM+2cvyMN8FfZ3p+wGTK375ZHi7M44RP
         BgLNICi46Ch3q9Ujcr7H7wUY+5WQnQ8t3hXgD3+mrWCGcTDAq0NnwcA2M7pdYupXx3Sp
         iMvXIPwQ7Uqbt17wLyDK+SAkfI7ogIVhhrnoNI6xL/qnPytlgexaaCTARBH+l03wglf0
         MT1seBtuLcOHEDrnnYDy6EtojjX0DkbT+MFrStfoGpkQvrZDiG/LuiwfnfjHOPwhXDYM
         wJtw==
X-Gm-Message-State: AOAM532r5qYTehHSi8SA1wRCuxLlqYjm6wadRu1bu1fWknCg/AJws70g
        tX7oz9Bf7dlQ11O4OE+f4pFR+sdW1fv7Tnr/ATSecn19408=
X-Google-Smtp-Source: ABdhPJzdgXomzdKQdTESqqNssyFTddf2kwfFvze73KS4xfDJksH/iu5sMWjyWFuMuR+nMCCQcyP1D4wiH9mLWLiNLJQ=
X-Received: by 2002:a25:6589:: with SMTP id z131mr32031922ybb.203.1632238515181;
 Tue, 21 Sep 2021 08:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <YUYPgF6tRQ5ERYWL@nand.local>
 <CAOLTT8SbS9-grLnn2TOL6XdR3yMkd=YrUnq=FLCo6r03Fqbg9A@mail.gmail.com>
 <CAP8UFD37tQdbcgsMJPYE7KaO1ajwznFRUrG=9=S1WNNM-YZsqw@mail.gmail.com> <CAOLTT8S8TxuTmddGp2WGoPtTc3gwGXzizBfVzKd87otRw7Dpiw@mail.gmail.com>
In-Reply-To: <CAOLTT8S8TxuTmddGp2WGoPtTc3gwGXzizBfVzKd87otRw7Dpiw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Sep 2021 17:35:04 +0200
Message-ID: <CAP8UFD0xjUWK7B82xEerX4e_pkZ-BATKwjNcEjg4AxB4mipL1g@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <ttaylorr@github.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Hariom verma <hariom18599@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 7:39 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=
=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:52=E5=86=99=E9=81=
=93=EF=BC=9A
> >
> > On Mon, Sep 20, 2021 at 9:45 AM ZheNing Hu <adlternative@gmail.com> wro=
te:

> > > I haven't thought of any good projects for the time being,
> > > Christian, any ideas?
> >
> > I already suggested the following project upthread:
> >
> > > > About project ideas, maybe continuing Hariom Verma's GSoC 2020 "Uni=
fy
> > > > ref-filter formats with other \-\-pretty formats" project could be =
and
> > > > idea, though maybe it could interact too much with ZheNing Hu
> > > > continuing his GSoC 2021 "Use ref-filter formats in `git cat-file`"
> > > > project.
> >
> > and you replied:
> >
> > > If the project idea is related to Hariom or my GSoC project, I think =
I can
> > > provide a lot of help. :)  I can help them as a mentor.
> >
> > so I am ok to co-mentor this project with you.
> >
> > If you are still ok, I will submit it.
>
> Yeah, I am ok. grateful.

I submitted it. You should see it and be able to register as a co-mentor th=
ere:

https://www.outreachy.org/communities/cfp/git/

> I am still looking at the code in ref-filter.c these two days, I deeply
> doubt whether we can add a --no-sort option to git for-each-ref,
>
> Inspired by Peff's experimental patches [1], I think the --no-sort option
> may improve the performance of ref-filter by avoiding the execution
> of ref_array_sort().
>
> I don't know if this can be regarded as a micro-project.

If you think that such a patch is likely to be accepted and that would
take you less than a few hours to prepare and submit, then it can
probably be regarded as a micro-project, and you are welcome to send a
pull request to add it to the micro-project page.

> This may require the help of this patch of mine: [2]
> which use list api for ref_sorting. This may can help eliminate unnecessa=
ry
> sorting.
>
> [1] https://lore.kernel.org/git/YTTC2IUO1ZmTOEoR@coredump.intra.peff.net/
> [2] https://lore.kernel.org/git/pull.1025.git.1629882532.gitgitgadget@gma=
il.com/

Then please add this information to the description of the micro-project.

Thanks!
