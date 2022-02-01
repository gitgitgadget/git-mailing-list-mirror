Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBBBC433FE
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 06:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiBAGBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 01:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiBAGBd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 01:01:33 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D2BC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 22:01:33 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q186so31343658oih.8
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 22:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdDOmEpi2lHAbBSmw8gL45WSCj5Su9LQQfYXvYLB3TU=;
        b=Dzy5UZ9y2/qovLS8pfwS2fdxzSvbcaNQA6zoZNTPs3QR7YhfYXOr74G6E3f/nQAs8p
         HkgHi1dzHz5/pIU3XRYbV4GjgCvAFWRv7ovUG8kVoxT+VIHnJE2lppBmaTnMVF9gvhiJ
         pDZAAzSj3winT54GJ7Dv1hqZUdDHjfCYR0Mqf7txs9jQKmlgsAVXSSfZagnvzrxti9nF
         RV4zGPP9rxVcG5+G48TXW7kWc8yZ+/SW+T7szaA8/wJVLJ9n7mvizyD/BrddwSUePZ1r
         gkV4h10GCpH0h+AvyvHYMYB6zo7rWhuskGF4at6z/Fw7827BNVIocr0WssYefwyrc955
         CnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdDOmEpi2lHAbBSmw8gL45WSCj5Su9LQQfYXvYLB3TU=;
        b=vSFykPGQe6MaNDeU2zK3dy8A4GIQzyZr2aOj29t5kNgszvVEXvmogyoZln0b7ceTyB
         zUrTvj7O75N6Glha4rR+ug+2AP+Mc8gnG3wJafibvXcsmAGfJbHZtJBy7mpIwKF432qS
         YQAc70ms1DwYS6ZxttWsUStXc242Sv+l9FWJun1C9Keh0Q0TkXlXPvXFkKVyVoUh07O9
         L86FgweWVPY5aImHbPVAattAxfaEX2HG1T6qkElWptrj3o3ebic9HeaqviUFZYiNz9bU
         0VPFGhbXIMraa38Ly86eP09mmfoHD74Uyz0etJ7eUN3nkz1NbZUkHUR3NomPASZhnjd3
         QTnQ==
X-Gm-Message-State: AOAM531YHD7EWiGWp1NbON+ueOFFsPOykD4om3wRtyN7OPzVMEBgMj+I
        gB72W7EZKAoyvBewvdPiMVcNPr+uDp9Q9c1g76k=
X-Google-Smtp-Source: ABdhPJyHQH1i3j8vYOOEVt+06ICCl6iUBCMjP/83qZN2JUAj7IRo5AW4uhpUEfuI05Jwai4eMzV2u0jBfzbiozTXRbI=
X-Received: by 2002:a05:6808:159c:: with SMTP id t28mr275808oiw.230.1643695292902;
 Mon, 31 Jan 2022 22:01:32 -0800 (PST)
MIME-Version: 1.0
References: <CAJyCBOQDBMcowKZgMp2iCbWpaMJGxNH9EtbQ8e0zB67k1g9uYg@mail.gmail.com>
 <CAJyCBOTpmKCHaYEvNc1-r_Rs2OWMsyCO7P6iSeM78QcjjcPuHQ@mail.gmail.com> <xmqqzgnbf8w6.fsf@gitster.g>
In-Reply-To: <xmqqzgnbf8w6.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Tue, 1 Feb 2022 14:01:21 +0800
Message-ID: <CAJyCBOQKyoGgo1aPfZbZ04svk0CM=aLGj=ZOBbks5-DH1RyiYQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtHU29DXSBBZGQg4oCTbm8tc29ydCBvcHRpb24gZm9yIGdpdC1mb3ItZWFjaC1yZQ==?=
        =?UTF-8?B?Zg==?=
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 1, 2022 at 1:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:
>
> > On Tue, Jan 25, 2022 at 5:59 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
> >>
> >> Hi git community,
> >>
> >> I'm considering if this microproject
> >> [https://git.github.io/Outreachy-23-Microprojects/#add-no-sort-option-for-git-for-each-ref]
> >>  is a good option for now. I want to spend some time on it and see if
> >> I can come up with something.
>
> I am fairly negative on that entry in the micro-project list (no, it
> is not your fault), because
>
>  (1) the one that is described there is fairly useless and I do not
>      think we want to take in my tree at all.
>
>  (2) a variant that is any useful would be a bit too large for a
>      micro-project
>
> As the explanatory text there says, the code should be able to
> figure out when it does not need to make an extra ref_array_sort()
> call, without being told by the user.
>
> A smaller and more appropriate "add --no-sort and when it is given,
> skip the call to ref_array_sort()" is much easier to do, but it is
> very much useless.
>
> If we were to spend any project resources (both developer's time and
> reviewers' time), I'd rather not to see such an option added---once
> we add a feature, we'd have to maintain it.  Rather, it would be
> much better use of our time to do "automatically figure out when we
> do not have to sort", and with that feature, nobody needs to use the
> "--no-sort" option at all.
>
> Such an "automatically skip the call to ref_array_sort()" would be
> doable by a developer who may be relatively unfamiliar with our
> codebase, but is still a bit too large for a micro-project, which I
> expect anybody to be able to code during a lunch break and spend
> more time on review exchanges on the list.

Hi Junio,

Thanks for the reply. Understood.

Sincerely,
Shaoxuan
