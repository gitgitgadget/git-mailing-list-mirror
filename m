Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416C220248
	for <e@80x24.org>; Fri, 22 Mar 2019 07:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfCVHaa (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 03:30:30 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38466 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCVHaa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 03:30:30 -0400
Received: by mail-it1-f194.google.com with SMTP id m18so2064402ita.3
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=76/bZ4f7dWGGAgsXpQ1lGjK2emg9+fY/eH+B3WjsQZs=;
        b=h7eCUl3Ycz6vQukSNTwOj2DbIywk/Vl8WIY2JA+tdNAwX1rqI2EFWyIkgF/ng3aO/l
         EexcoY58NezG71YLrc2tmjp8BW/lpxxZqBUNR/cZSoHy7x+LQiEUGiwiVVz5R8S2smPx
         qfy4nTEEsxs0DUJvVmYp4jBok3E6qOme1Bc0noAdqH8otiEKK+/9PDZt1UHFCnN1G7WW
         K+cd90Cvfq/Kp9eN/rpqZaPog8e91W1mue9oyLAFIA1w+Fm03m23VA+qRsqqE1+oiMHz
         j93xI6nHz/kyQ4DSVXo0uJHlz5fxaPY6vJB6e/PfrosvYAqPnsKhWl/GVeKueutUGzcB
         +mtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=76/bZ4f7dWGGAgsXpQ1lGjK2emg9+fY/eH+B3WjsQZs=;
        b=QZNwS2kluq1oKV16UXEiTgYtgBdrorpd1dKLygiJRF289nOirPv+DQYG+rGUBm9EWx
         6gtprhCDZHXPoQ+fsmVL6H2Su9IOT06mlrK/yBzzA5NrFisci5GvAGXaTwUyTVeQqlzf
         FBGCd/YCrPlzhDicDidtz+MYel66h2ABVm4pVv2vo011p4I2zF0CPf1Yrhzj23pnHd+h
         iTu3kjhDtTRVERHD6Q3RMtqTv4fDwY8CLsiX5BxEZ2xN7TBmBB1vCig22Gzgld1uy9Rk
         S0Jg212IP4PelKtFeSyvNlsZzdSPcFQ43p2rwcRAedK2Ad+vAa3mqhDx87/zVQsvyzan
         SoFQ==
X-Gm-Message-State: APjAAAXeuQBr0qPloG/I7YZex9EJrV+PHB/olN3bQY8hqr++Sh5+XkVS
        SvlY0h/7DjWoN3MnC0MM6ZC9SzSXWYHBFniL3ko=
X-Google-Smtp-Source: APXvYqzYFvRjykXkXXwOw6qUsIVd0wDHMo1slkW1m+RfIBSr5ZQ3XaCEY/ctcHVcH0L+oBgH7OOVRdKCdIPoBHmPlZQ=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr254403ita.10.1553239829312;
 Fri, 22 Mar 2019 00:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190317124926.17137-1-pclouds@gmail.com> <20190321131655.15249-1-pclouds@gmail.com>
 <xmqqh8bvr0v6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8bvr0v6.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 22 Mar 2019 14:30:02 +0700
Message-ID: <CACsJy8B2an6G0RgCF_KW2ktXrm9Vn3o_Uir+_o2SMUdmudt4iA@mail.gmail.com>
Subject: Re: [PATCH v5 00/26] Add new command 'switch'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 11:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > This adds a new command 'git-switch' as the half-replacement for
> > 'git-checkout'. Jump to 12/26 as the starting point. The other half is
> > git-restore, which is dealt with separately.
> >
> > The diff delta is shrinking nicely. The two main changes are
> >
> > - '--orphan <new-branch> <initial-tree>' is no longer accepted
> > - --force implies --ignore-in-progress
> >
> > The rest is the usual typo and bug fixes.
>
> And droppage of sign-off?

I think the amount of options I have to give to format-patch starts to
overwhelm me. Can you forge my sign-off? I'll resend otherwise.
--=20
Duy
