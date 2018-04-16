Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66B931F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeDPW0Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:26:25 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44763 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbeDPW0X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:26:23 -0400
Received: by mail-io0-f196.google.com with SMTP id g9so1276142iob.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wGk2Al6uwe8n7aLSXdmz5AwEv2dlpLrWtIswP32R8SY=;
        b=FDIBpT72TwE+Af3R+TtR4Nr86MdKR9xMf8/8K+G6DqDJ4qR519lo5/zFyKw9t6UxBl
         29s+jETKPw/mOX7Dkdftr2Xwqlx2cETXwcH0vRPTyP8KbBttmU+Kij83UvnpGP4Tufyd
         Bs8+LgBwOxSDUX0o1e7IfFgfVBlq8n2g1s09LYrao9wE2+Ry0qtG8oKDJdvdx2RNjr9f
         jnTXiYBEcRk8C1hOoeXbOSl3QvAVCVZGY92E0Ka0RmnSIaXqzqXkrXs822UbF8BNZx9o
         SACZdIYjVK0glDaFl+EW50BM/jKg/ln86KTeyT2WQQDA4ZImHmH84ReszYjvQnmH/Sri
         avPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wGk2Al6uwe8n7aLSXdmz5AwEv2dlpLrWtIswP32R8SY=;
        b=rmyO4JraXfwMmwHbwmRwhpE3Awy2YCnOT11YDKfW35RireQunCDI9QLmr8KgjEZtiv
         ca1uAB+qbHv5meTariSB02oZ9JxC84+mqUp+dgEMGqUo83c5FGI5rc5BPf9y/C0A9gc8
         vgoinWn2toej7VeljsD2whqcuw/L/XKwCEDdyagGcqSqSh0WeQV0hp+240bp7WaU6kl7
         e9oihWcfr0opc8yGxo1E5hasZtWN8zWaa91pupqO5963DVT9rkMvQynYBgoNvXo8s8AR
         d4jc9PwdBBbO4RM1oFz3mj2gOnRu9RV+HDpMi5kP64JJ40skPGgC1bpUxtfghp39ubhd
         60NQ==
X-Gm-Message-State: ALQs6tD/vsLOg1enDFbtyLXAzsuUpQx+eMKqWyGfGOGdLEpHyZUL9YXH
        JoaOIv350SP/EC+gT1gjFtQtZ0NqVUDiGDppIYs=
X-Google-Smtp-Source: AIpwx4/k80+BnxNcICYEAcqMHASKefpsQhWBtrpsbxzCb6bQfJL074wE8QocvSn48RVReYCmAZm75BNsXqN0gJ9QmBY=
X-Received: by 10.107.144.11 with SMTP id s11mr2776325iod.223.1523917582410;
 Mon, 16 Apr 2018 15:26:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.219 with HTTP; Mon, 16 Apr 2018 15:26:21 -0700 (PDT)
In-Reply-To: <72f42205-c9c6-03aa-e8df-12e7062e8e62@gmail.com>
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
 <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com>
 <87in8rz65t.fsf@javad.com> <CAP8UFD3JwHfyr=bByvjDrxboFL+yHVdZnbkXztsUuOU0aRD-9w@mail.gmail.com>
 <87sh7v6vn4.fsf@javad.com> <72f42205-c9c6-03aa-e8df-12e7062e8e62@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 17 Apr 2018 00:26:21 +0200
Message-ID: <CAP8UFD34Y0KRY7vqXU_jWGUc3tdDHB1h67ARZxi_vk1EyUV+zQ@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 38
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Apr 16, 2018 at 5:07 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> That said, I read the draft and found it good except for two minor issues=
,

Thanks for your comments!

> 1. I see the following sentence in the "Rebasing merges: a jorney to the
> ultimate solution (Road Clear) (written by Jacob Keller)" article
>
>         "A few examples were tried, but it was proven that the original
>         concept did not work, as dropped commits could end up being
>         replaid into the merge commits, turning them into "evil"
>         merges."
>
> I'm not sure if 'replaid' is proper English assuming the past tense of
> replay was intended there (which I think is 'replayed').

I agree and changed it to "replayed".

> 2. I see a minor Markdown syntax issue in the "branch -l: print useful
> info whilst rebasing a non-local branch" article.
>
>         ... reworked his original patch to improve `git branch
>         --list=CC=80
>
> Specifically, in the '--list=CC=80' part. I guess it should be "--list`".

Yeah, it's fixed too.

Thanks,
Christian.
