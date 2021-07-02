Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C82C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFC06142B
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhGBNr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhGBNr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 09:47:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB236C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 06:45:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id n25so13295733edw.9
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/1O5DCZbjrn2u8Hwig/UHhc9oCdU/3D5raNKgV01iCE=;
        b=pXinra6rtYWylSTzgFuLVFK/eQns61/ZpfgtJlgOSPKSaWQQJm2oAetiDh+mIYFAqF
         geBex+CuTEgJWs15HeX8jeWUZ28wIhzkm3AjjEQdtRw3O0blSE268d78CFcdPNW17OxX
         uFJsCFDmzASAPgb/xgZZNvbYfgpZGIEOcTtAr+oyEv4j7X1Ayv8dVJphrPfQNEYSCAL+
         LdlGhhVn5xjsD+RIUTLgCy+iNYYoVSNCE/MIN9AgpTfKfUW3O5ZtozMM3cmPkK8AQ5DV
         vVGp0P/4SH6Ob1HpeuCgRHaGpB0euwjKr6JpFSZau+2qyZgcCzvacR1eBivU4/zYansT
         RQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/1O5DCZbjrn2u8Hwig/UHhc9oCdU/3D5raNKgV01iCE=;
        b=Jeoi92PORNAEvY0Q6VYRJexZvgQlVKzZVfkpsSSLWxz8hq9esNFkjsicmp7P4kjP9G
         3WAzFxmbsCVHRs3Jj8776g3pwBBVYdS57k4VSe08nqIwYkMkez77/6fkmVWoaPk9rxM9
         s1yX0pfRfgIcwuViOee/dog5hHgq6s80r/l3cxZpiSJqejMsd3VihRVZqJasDlU7qdrT
         SoM/XwKixyJikKJulestkr2bY5JdVH4PhjxGO2v5YB/gv0JxRq1/2V7FIlhYlGCQiWuz
         Xu7g/Qm7U1AZuywgYu+DuIycOrM236Nl8c0vBAO67BNaNS2YhEbEexmqSLRbFapNdQX0
         Hg1g==
X-Gm-Message-State: AOAM532T8ExETUEidFywcF0p2sWLuGDO+AMoctPNu/dX88x1P1PZX2MI
        PqOY7OQhSXKblESYBr3sHRoG9PLq6y5JtG+w/i4=
X-Google-Smtp-Source: ABdhPJySe7YCZXHmUDD+YxzmThzx8lvbmKqMzlkTS7Vac7Mxlem0IrfXdhqywHMoVU7TtVoLOe8+VlkkOjXzUH2cRxQ=
X-Received: by 2002:aa7:dc58:: with SMTP id g24mr6926915edu.127.1625233524342;
 Fri, 02 Jul 2021 06:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <e04b970ccb0cad8c0b651ab11f5f52063bd84606.1625155693.git.gitgitgadget@gmail.com>
 <877di8al8n.fsf@evledraar.gmail.com>
In-Reply-To: <877di8al8n.fsf@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 2 Jul 2021 15:45:13 +0200
Message-ID: <CAP8UFD0P5eiwxKvot_5+izEjscyGw+F4QFN72BmgHNhi9V5S1w@mail.gmail.com>
Subject: Re: [PATCH 12/15] [GSOC] cat-file: reuse ref-filter logic
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 2, 2021 at 3:39 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Thu, Jul 01 2021, ZheNing Hu via GitGitGadget wrote:

> > The performance for `git cat-file --batch-all-objects
> > --batch-check` on the Git repository itself with performance
> > testing tool `hyperfine` changes from 669.4 ms =C2=B1  31.1 ms to
> > 1.134 s =C2=B1  0.063 s.
> >
> > The performance for `git cat-file --batch-all-objects --batch
> >>/dev/null` on the Git repository itself with performance testing
> > tool `time` change from "27.37s user 0.29s system 98% cpu 28.089
> > total" to "33.69s user 1.54s system 87% cpu 40.258 total".
>
> This new feature is really nice, but that's a really bad performance
> regression. A lot of software in the wild relies on "cat-file --batch"
> to be *the* performant interface to git for mass-extrction of object
> data.
>
> That's in increase of ~70% and ~20%, respectively. Have you dug into
> (e.g. with a profiler) where we're now spending all this time?

Yeah, I think it's better to discuss this performance issue as part of
the discussion of this series, instead of as part of the discussion of
the blog posts.
