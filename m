Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D601C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 06:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F2764FB8
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 06:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCKGSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 01:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCKGSb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 01:18:31 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3A2C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 22:18:31 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id d20so21988526oiw.10
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 22:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H+XnRtNf4FgTNwpVQnJ/xl+MmG9MreTiqr2kK403WvA=;
        b=U/60zdgg2rGZbpO0jYmnyGbnuYOs6F8Y6X849GdbsrQDF17FLjbHNP2jVNWZGHMNmr
         yuNh7POupsp2YXwlI9+B2yWnlCmXfhXZ07QAn8uEVFsAo7TztJIbZKPSa014pCA7JBJD
         1H7z3h3KfVqbJ5h3nHPqwzUPq9F53qEJYQaOqkVBog2hq7UT3+NrCPQGU00UCwuSQiOD
         ijzf8OcwvUHS6dH2QcGLfiIZW+s6sw/MSBJoClfZ4jln3Ho1R85NpOwPW4sQ3qlHcgDn
         iJI71LFJhV8Pa3g5DOvkNz6y91pUTzXB08rYfc7G3qeorjka+0Ey3GmAoLuRpubUSCtj
         IFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H+XnRtNf4FgTNwpVQnJ/xl+MmG9MreTiqr2kK403WvA=;
        b=aqrZT49NoJX0dUVS8pfyDiiAIDZN6SwAnOTh84AbJ0Vdb8qhCA6giK/Qmi4PvC+sqt
         JugsU4dx9L5IMc7muqFL8VYteAbwbo/i3utneOIGrx7a1Mr767+hOgSOrWjFidaodWnQ
         JHa4aeivZMiW7fw+avUU+qoMFs7X9/Xs2IRVneeH7AjeKL4n8SftNez9vlrzn7E59XHl
         BabJVN/bXAe+zyFhtHH/lplmbRZ0xyOWT5NAsAEaiew+3Cy8xt4cHUk+xGrfNBaOCdBw
         znqDUUQp2eVX3xDNoSnBd+2y4dGiMJ3KEh8KicesfQ9Az6zenIDxOuOnmlDwG/v5ZKaF
         VqPA==
X-Gm-Message-State: AOAM532LavXlS/CpbzrwSf5MUNW4z1x3W7myAiQh2sVqhj21uaX1ewct
        N2k+/bzFyJCwgBWGTcvrf8r/8Ub615JM1aL83vE390RCK/hgXw==
X-Google-Smtp-Source: ABdhPJz2iKsT4UdeLDp3IYFWYFmJDt/AdO2CmwgN2W9nvshSvkU0VD3bf3YM7lL0ZLRr9Zl3Uc4VQtXVFVolVRY7GfQ=
X-Received: by 2002:aca:af10:: with SMTP id y16mr5269670oie.120.1615443510863;
 Wed, 10 Mar 2021 22:18:30 -0800 (PST)
MIME-Version: 1.0
References: <xmqqmtvafl62.fsf@gitster.g> <CAOLTT8SBv9QE22bMT2x6_DYNPZDaBjoEv8o6d2MenOnwKng8Xw@mail.gmail.com>
 <xmqqeegmfedp.fsf@gitster.g>
In-Reply-To: <xmqqeegmfedp.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 11 Mar 2021 14:18:19 +0800
Message-ID: <CAOLTT8SfAPH8=asCPeEJD36xww553bkPmDm3AaTbne23zNkkXg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2021, #03; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8811=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=881:28=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> [ many many lines that you did not have to quote omitted; please be
>   more considerate and save reader's time next time ]
>
> >> * zh/format-patch-fractional-reroll-count (2021-03-01) 1 commit
> >>  - format-patch: allow a non-integral version numbers
> >>
> > I noticed that you used the'previous-count' version of
> > "zh/format-patch-fractional-reroll-count" in seen.
> >  Do you want me to deal with this version instead of the
> >  previous version that Denton Liu and Eric Sunshine helped
> > me complete?What
> >
> >  If you want me to deal with the `previous-count` version,
> >  I will roll it back again and deal with some small details:
> > use "strtol_i".
>
> I do not have any preference.
>
> I didn't even read the newer iteration as we are in pre-release
> freeze and I've been busy dealing with issues necessary to resolve
> before the upcoming release.
>
Alright.
Thanks.
