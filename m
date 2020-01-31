Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E24C33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 11:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6D920707
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 11:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOCW4k8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgAaLQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 06:16:44 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:36346 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgAaLQo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 06:16:44 -0500
Received: by mail-ed1-f54.google.com with SMTP id j17so7406405edp.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 03:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eyNFDgoFah0LW0mA0GkaPzqv2gTbZ5y8Yzbb+ehH8h0=;
        b=BOCW4k8L7KRHkFP9UDHffQDoCzPqu+ID4z1WfNFiGptIXY0RoK+w1f+FkWBSII5ubL
         PbQ69SxLo/1N+xA0m+BaOo12kAFIf2yU0Z8IVlBAXtGnset8msI8ZTpsP295xsZjRR1a
         ZEjzXZ/Bt+9bSAS4cQjGxhujFA4607FW7f23ZWrukg/nAtucmDThSJL11MkPINxH2HEh
         P+SuqihALR76ulI8VXE+G5dOyahAoN70D3BAQcTvhNdFLt0V7s9EVV6wjCUsYR32SMLP
         qxjoWctkOHBLN4xx6XgLPEM8g8Ilwdr5WYquuMdDm0ymUYsPjBCOsBRinzVfvwbGorgW
         qvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eyNFDgoFah0LW0mA0GkaPzqv2gTbZ5y8Yzbb+ehH8h0=;
        b=h31+rFepnQHjXlQqRq2uieiFJc0lMBAi36KBGT76UoXOvA8TZvH8rHXuwu52qk2+1i
         SV/+IElYXMKYeRaUhJf+1ej7psBw/DfqqKqpo/c9wAXZNL8PFNxIryL+hXQxmYuwXH2k
         j+9RZEl5ycnhUg6n5VVPfi7fmHyZFctL1cvUyOgwtX6wgtj2q8TtkvapVQ3jL7xdjLbr
         EsZwhUyLSbBvlJGVWhLAAvAFoe19BPOmbOeSkysDmQwcGbXfovCRq9zXfLtRQDANVDeM
         UN5Nt+3XP/DnyQP4zPjseepM7LYjU8tf+MqP/UgYPNlUMMzUc1xe9v2ilf04URgS/HSd
         ohWQ==
X-Gm-Message-State: APjAAAXI84d9+KC4Gct7hFa9aUdptJpTEHNqBpamrSPAM8pkjXzZgGBD
        6wRJ0ji7gvQrF+2biQqzOvo6ZHU57fmJFYvBPhQ=
X-Google-Smtp-Source: APXvYqwY3Mx+C+a/rZXUrW2Jtp+tLjC9nN2vSQ2C4HzWEs3Cv0D27AJzcsS9yXZ4UR3Aj9T6Y96XSBphzEe74VvHUfw=
X-Received: by 2002:a05:6402:17f2:: with SMTP id t18mr8449327edy.9.1580469402198;
 Fri, 31 Jan 2020 03:16:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.508.v2.git.1578438752.gitgitgadget@gmail.com>
 <pull.508.v3.git.1580346702203.gitgitgadget@gmail.com> <xmqqimksbo73.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimksbo73.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Sat, 1 Feb 2020 00:16:31 +1300
Message-ID: <CACg5j27pTKuhZpZtgNUDNEkhG0+tGx5O=LJCr5E8+2q8v6Zu1w@mail.gmail.com>
Subject: Re: [PATCH v3] add: use advice API to display hints
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 10:59 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > In the "add" command, use the advice API to display hints to users,
> > as it provides a neat and a standard format for hint messages, and
> > the message visibility will be configurable.
> >
> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> > ---
> >     [Outreachy] add: use advise API to display hints
> >
> >     In the "add" command, use the advice API to display hints to users, as
> >     it provides a neat and a standard format for hint messages, and the
> >     message visibility will be configurable.
>
> The topic has been in 'next' for the past week or so already.  If we
> need to make further changes, please do so incrementally.
>

Will do, thanks.

> Thanks.
