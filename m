Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B7A1F406
	for <e@80x24.org>; Tue,  2 Jan 2018 10:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeABKlZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 05:41:25 -0500
Received: from mail-ua0-f180.google.com ([209.85.217.180]:40815 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeABKlY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 05:41:24 -0500
Received: by mail-ua0-f180.google.com with SMTP id d37so12715047uae.7
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 02:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lfVneZLrAgxs6ZqFYybOeBb1emzQpXgRtsZaX4f0dW4=;
        b=dCHzkNkIFp6uhlc/XMXeQQdlovQpzXpo6YaPvDxvx5s1pHW3/SQVvD/Cl0fmxeJsbz
         nRC5/uuG73Q2icPrc8ggNgnYA5KmaOmAM6WcSkIby6o/MPTvqnDaJtfh1WkusmMu/fge
         pes0ZQxCapbuJTIW7Y08tjLaxxWU07CGvzomZbmmFrUy6POm+vq+BdGh98XK5p3IMx84
         yi3fz+yTF73yVltZebFj57xaAMaq3Fyu/M/YNI656CBoKwhfmAo0yEi1CWG1C5peCFxv
         afIRPc8mJlVtI29rLug8sfLmyM1TvGREdbYIM9NZZx70i4VhEemljk4AgQ2T5UPR5sZH
         gZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lfVneZLrAgxs6ZqFYybOeBb1emzQpXgRtsZaX4f0dW4=;
        b=rfdr1spHvTj3Ar+KigE5A//1ap+R/uNckyczU9se1W6AeKy+gx0mnTm+sdDt/oYq21
         9fje7gQXgl/EN3PBnTd1pS39nFbwxTJ8sFJifJvP2nSwZb44vjX7d3H7+23hUvoLeBU2
         SF141B3SKXji2/syYM/Hvc+o13uSEBlbfu9GQmHgUpX48UXE1lHnpO6JGIh6YxOId5mX
         88wMQbyQCkXV7WbiCXVmVJabjRSRlN0IfR5AClR3b3y9IRfV8M2spbW6drwkmO97acsk
         YUAcmSPc1RNJZWUozUNDIhUbDBYogJvBuJ8Z2cH9tFjnGOzAwSQ3tbRfc+G9uE2IY83E
         oMrg==
X-Gm-Message-State: AKGB3mKALHdGFlyWrX/S+uxgUwPJkuTMGxyEB1j/AKm319ZrOzBiDkhT
        Tdf7dulc5ahClEAvkCmrcUcpDx75wm0gp2ap/Iw=
X-Google-Smtp-Source: ACJfBov7e2gcLou5e90CCrfnM4LiJWlgUJ4Ual0Ii4N85ljJmNuguGEbFDcwOsMOZYvLs+1VD7edNl9YBxj2ZDEKA60=
X-Received: by 10.176.13.129 with SMTP id i1mr5241571uak.139.1514889683473;
 Tue, 02 Jan 2018 02:41:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.83.15 with HTTP; Tue, 2 Jan 2018 02:41:23 -0800 (PST)
In-Reply-To: <c3937260-1ffd-797b-7f25-53a6a4bf3676@kdbg.org>
References: <20180101225448.2561-1-szeder.dev@gmail.com> <20180101225448.2561-5-szeder.dev@gmail.com>
 <c3937260-1ffd-797b-7f25-53a6a4bf3676@kdbg.org>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 2 Jan 2018 11:41:23 +0100
Message-ID: <CAM0VKj=HNvd_wvZMJSGB7hCrjnUj+J+Q17zpbV1ju=rvbDLPrQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] branch: add '--show-description' option
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 2, 2018 at 10:32 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 01.01.2018 um 23:54 schrieb SZEDER G=C3=A1bor:

>>    - errors out with a proper error message when the given branch
>>      doesn't exist (but exits quietly with an error code when the
>>      branch does exit but has no description, just like the 'git config'
>>      query does).
>
>
>> +test_expect_success '--show-description with no description errors
>> quietly' '
>> +       git config --unset branch.master.description &&
>> +       test_must_fail git branch --show-description >actual 2>actual.er=
r
>> &&
>> +       test_must_be_empty actual &&
>> +       test_must_be_empty actual.err
>> +'
>
>
> Checking the exact contents of stderr typically fails when tests are run
> under -x. Perhaps
>
>         test_i18ngrep ! "fatal: " actual.err &&"
>         test_i18ngrep ! "error: " actual.err &&
>         test_i18ngrep ! "warning: " actual.err
>
> Which makes me wonder: Why would --show-description have to error out
> silently? This is not 'git config' after all.

I figured it would be beneficial if it were a drop-in replacement for
the original 'git config' query.

I don't have a strong opinion about this, and certainly wouldn't mind
adding an error message instead.

G=C3=A1bor
