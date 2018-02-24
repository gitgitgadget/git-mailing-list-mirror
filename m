Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57791F404
	for <e@80x24.org>; Sat, 24 Feb 2018 03:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeBXDSY (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 22:18:24 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:39696 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeBXDSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 22:18:23 -0500
Received: by mail-ot0-f179.google.com with SMTP id f18so9001907otf.6
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 19:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7/4ysMRSUIM6NjGPHHfnwYpUFABcrRJEbJ7O+tC1zGo=;
        b=QFwMLzvqR1ma5DDLPlBuGbkPOcO5A6GUJQqslOaM7ggeoK0t7yR5u1Zq4pfTTAO42o
         liv2/IcWEnt7lGOspYH0mTjmCfhVohPevUwuIm0WFanf+Lh+a8IaPkLmyaKuuz1GopzT
         GuO78w9rHLo7KJsuhqHvq1kiSTokLgFmqJNCD/GBxcOp4tkjnqM0L3znNByv/3WaXu2D
         nHHYqgb98X3CwJdUTDxgpi+Q1b0m9ytIhetClzpNtEW6+VEQZCE7YTjleuNdt3pUSc9L
         sdmWR27tzsDDe+Hd9VeoMNn4IoV1ImhwoFd9DRkr5bHM5bs3vtUGk6QLy8iGzl6OpKQT
         /K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=7/4ysMRSUIM6NjGPHHfnwYpUFABcrRJEbJ7O+tC1zGo=;
        b=pOrQvZfEt98DznNTwqtNuULfOKQDcGnmrX980oQXrmVOjJ0OU2iggZlkH6UmhnPJQt
         1XlSWAmI8mImhTKqls/TrmKDrLDqvfylQ6npsjIfkNQt87XBjNouuQAtWSvR29XpDsDH
         FO5Nsj0C+V81UYT1Qwh5bE6KAvzJJu4v9/QI+UOwwUAn2S+JMm6dx17CMHG50rbY7LQg
         H3rJcKPVU6hOv136Mico1PT5C/8l7Gdb8f/uqK2Qj53z4wmyqAJpqdyPzUb1fEVhkbpA
         MrGL01TDxHskSEeZtlLEnVy9TnaDAaQ/B4P9sEEfZjJcQSkzIzvbr79Y+8xmvetwOpTj
         yFBA==
X-Gm-Message-State: APf1xPAdiWWADVmVzfczMluGUXLf0Of8r8kzIgxlW6LonxFXtjqAnZx7
        NFcJ3m+GPlcMjEB2Z7M3xXMgRS9PrPTXFu98TTM=
X-Google-Smtp-Source: AG47ELtZ0TxhUcFq5/mdoJ7WNwHgs069P1hLmAMDZ1TMBrkrqlHvpL4Emsu3ShPLo8sLY3lhq0DqWeVmmcHVqHwA0Qg=
X-Received: by 10.157.24.42 with SMTP id b39mr2709065ote.356.1519442303223;
 Fri, 23 Feb 2018 19:18:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 23 Feb 2018 19:17:52 -0800 (PST)
In-Reply-To: <20180223221746.GJ6619@genre.crustytoothpaste.net>
References: <20180214180814.GA139458@google.com> <20180223095640.25876-1-pclouds@gmail.com>
 <20180223095640.25876-2-pclouds@gmail.com> <20180223221746.GJ6619@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 24 Feb 2018 10:17:52 +0700
Message-ID: <CACsJy8CHaFEpmaFW0bSQrkWd5V4nPRxQqN+6MRD_86xoibDxtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] setup.c: initialize the_repository correctly in all cases
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 24, 2018 at 5:17 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Fri, Feb 23, 2018 at 04:56:39PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>> [3] the reason server side is still running ok with no hash algo
>>     before [2] is because the programs that use enter_repo() do very
>>     little then spawn a new program (like pack-objects or
>>     upload-archive) to do the heavy lifting. These programs already
>>     use setup_git_dir..()
>
> You have "..()" here.  Did you want to say "()." instead?

It's because we have two functions, setup_git_directory() and
setup_git_directory_gently() and I tend to just put '*' instead of
listing both. But since it causes confusion, I'm listing both in v2.
--=20
Duy
