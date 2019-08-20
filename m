Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92FD61F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfHTSsO (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:48:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43488 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730623AbfHTSsO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:48:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id c19so4912361lfm.10
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJM0CYT7W74bVws5M4udroCaa1N7H5HJM69mCzqb07k=;
        b=Mo545A1w7V2WsS7cxxFPtya1pDXEB2t8uIiiQkfmDN956bErTCTEgPnQndbpkolrZ5
         35NBFpX6rNWFKwi/rS5kJ/tys4LQA0cZVxLTWKNXmvNb6s8EOKlpkw/N32iH78XWlrrH
         NMp1DYJBa8pxxYZVvFf0Unf2avnm8j91CRZXCMcDWlKieXa27CSP2vUIvMRpzuHAMUI7
         dgos1p3Q6SWJtClaZMQ5Obl+0vukSeEGrfKtN20gytE6tIPrIQU7U1uywaAQKwoNHC9/
         cAV7teBaKccHcdU6RjndfJiWrw6LGJVSpDQ5dJyfan8yxJZ24isGIBnzc/taW3GKKHVL
         +Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJM0CYT7W74bVws5M4udroCaa1N7H5HJM69mCzqb07k=;
        b=M9rH3NO5IYtSsPvVGd6ex0iY4rdpXUgoGEMqqjc1ZebMILXqX8wWtpIW5zwBCIhkJF
         MSrk2UT3uwvUYr7LCawr4UmTiHJpiQHz2PRnZFhc7N7hW03MXN25+JraTMsxGttF0Iqm
         2kE3A5hxgxRAqKEcIVwpOqK8dj1gf+nOtL+ClnEzo46qVSRfR1xJoz6PrNeuACHnI7d5
         VGN0hd3rL4QCiQMBbLDUduIlhjP9HzKKnwX5AOqMrugM8KKwyV3Ru8woPGKZwoLoiSlf
         VxOzSt3GUzEjZedL1xQyvCB82oxMuF5OpNQmm/bMOrcFFKIv8+IYKOSWb+OK7L79XA+c
         6xVQ==
X-Gm-Message-State: APjAAAV2h3vem7JEPqzK8YFTCFqaJ4An4bp6liMZZ70vXCLqfs4fnpll
        MgvGpd2X1A0WY55vs313sWE4HJJQHd0KLMasHnjl1bxyArs=
X-Google-Smtp-Source: APXvYqx22EVfVPh4Rq3z1of1+XwPKHAt6OXPKNhica7fHNIrHhh0mDfAiamjsBmSVrr5YlF+eZWCc8PkpqXWOQJB11g=
X-Received: by 2002:a19:6f09:: with SMTP id k9mr16491540lfc.102.1566326892324;
 Tue, 20 Aug 2019 11:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190820034536.13071-1-rohit.ashiwal265@gmail.com> <20190820034536.13071-2-rohit.ashiwal265@gmail.com>
 <98aeebc5-fceb-1ce8-9c27-d425c3f6e674@gmail.com>
In-Reply-To: <98aeebc5-fceb-1ce8-9c27-d425c3f6e674@gmail.com>
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Wed, 21 Aug 2019 00:17:35 +0530
Message-ID: <CAL7ArXrNaCh9vbvNUuDVCsogT9c+j8J+TMts+nW+S7R2EKhiwA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] rebase -i: add --ignore-whitespace flag
To:     Phillip <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On Wed, Aug 21, 2019 at 12:10 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Thanks for spelling out exactly what this does. I had not appreciated
> the difference before. Does this mean that if I have a branch with some
> whitespace cleanups I'll get different results if I rebase it with the
> sequencer compared to am? (I suspect from the description that the
> sequencer will simply ignore all my whitespace changes)

I'm afraid that this is the case.

> I think this is ready if we can live with the difference - I'm not
> entirely convinced that adding an option with the same name and a
> different behavior is going to improve things though.

This is the first step to improving consistency. We can
further improve upon the implementation. I have already
mentioned that in the cover letter of previous patches[1].

Thanks
Rohit

[1]: https://public-inbox.org/git/20190712185015.20585-1-rohit.ashiwal265@gmail.com/
