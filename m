Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBDBC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895DF60FC1
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhHBNf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhHBNfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 09:35:25 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B39C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 06:35:16 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id f11so20240581ioj.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cJpsKNR7am884RzxlUjwU7VFSxAkrCLP3IZ2CP725/k=;
        b=Fg26aAZsB+bau01Lp8l/UcpVlnbK0enytlx2UOFfsO/imRhPPMEkigbQDPRvsgAWCv
         xAjD44t2yuchs3cFrUxmklSFfmBNWCUaxCbwQgjSBOYT7E/ed0/Ky1bK+3WB4fk1g9up
         TNzl5LW7HcFVluMtVZcCJe85XhzpVGmjrXxkUbhUjrJhLLkHaKG/cNBlmcwTcK2U+Aw5
         TSde4XL1I735nygH44Elez9VbqmrwEq6ci8NR6MPDc3mLoegv3btYZyEtFUu/hRWGMUh
         R9VyG6w5UCL1m/ygtQziO6pMiO7Qd/Kq/GEmog5S1lP7MtFZjSluNOU6S0E+yVy7Uknv
         P+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cJpsKNR7am884RzxlUjwU7VFSxAkrCLP3IZ2CP725/k=;
        b=FbOcVor3TDc8LrlUXzEglmaza6QxOhXYDLKwGepA/0hafxaWv/yuCpUJUVOdMdMoe1
         s7jI+mkNP7e8ZsaR2JpBV58+kPZ5FcH083orNg8VgV8Dd7jekqB9KY4SMGyIBpWtNubc
         bkAOkG6W8uuchu0SOF6tuFOOZLXsDN4Vi1AvYghW9y76QJGng33VdP0jYjbqPatshVl5
         ZSFoQ1V59DCFtonT1WoQjp73yVTVZorcKwoPre0AJWzlSZuM+4xA1tbXM6doHP+qPb6K
         5WvCEWAn7QVf6uK3DJAcIJwH1SnD6l/3oZWMze2lCM4rcjeyJxuhussFa8Y+wVW5HYeQ
         LmOw==
X-Gm-Message-State: AOAM5312XkrYPMQVtsPjOf2BOag+oT7Dv5uZPmNrcEPsdyFR7RTZn1Qp
        DYUaCm+F0seqf3f68NIFqJZrdRzX6HvshBcrkXI=
X-Google-Smtp-Source: ABdhPJz2nb3AP45reODc2q5tU9a6uhaX2E4Vh0y8135qVyXTh6oywmEyVR4vRVdyPfcRglf3TnO7/bbYYSLjgUfHbGs=
X-Received: by 2002:a05:6638:33a6:: with SMTP id h38mr15026893jav.130.1627911315707;
 Mon, 02 Aug 2021 06:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
 <7e1ed49728df8dab771d77f1a076f0fa30975718.1627714878.git.gitgitgadget@gmail.com>
 <0a2ab793-de4d-d8d1-4d1d-a018fa0f252c@gmail.com>
In-Reply-To: <0a2ab793-de4d-d8d1-4d1d-a018fa0f252c@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 2 Aug 2021 21:35:57 +0800
Message-ID: <CAOLTT8TberYK1DtwMaEjtZLeVr1JM0tbU1DXW=Us8D_Yrsg-mA@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] cherry-pick: use better advice message
To:     phillip.wood@dunelm.org.uk
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=881=
=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=886:14=E5=86=99=E9=81=93=EF=BC=
=9A
>

> > This is the improved advice:
> >
> > hint: Resolve all conflicts manually, mark them as resolved with
> > hint: "git add/rm <conflicted_files>", then run "git cherry-pick \
> > --continue".
> > hint: You can instead skip this commit: run "git cherry-pick --skip".
> > hint: To abort and get back to the state before "git cherry-pick",
> > hint: run "git cherry-pick --abort".
>
> This new wording matches what we have for rebase which is good, I am
> slightly worried that the lines end up being quite long though they are
> just under 80 characters. It might be worth splitting the line that
> mentions running "git cherry-pick --continue" so it is a bit shorter.
>

Agree.

> Best Wishes
>
> Phillip
>
Thanks.
--
ZheNing Hu
