Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA5A20248
	for <e@80x24.org>; Sat,  9 Mar 2019 12:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfCIMhI (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 07:37:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40655 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfCIMhI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 07:37:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so146726pfo.7
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 04:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z/S4RTJY71afDEF6TS1MZzCaz1ifOD8HJkUMzuD5yGE=;
        b=Wm8teppOiPMUbXCx7VpsQVZ7pB3oGGYVjLcwCjChQIKDjFknjzvwYILI/69Ns2fB04
         NAb8P0QfYoHAxuPWnK2kSCMghNrCT5NcG02mWdJJlq2/UxvkUD31y7Nyx/vTIYLRWklS
         GsQuy8rrBsLBr5ftFhV2MUJDF8STG8IgeT53KPIc4GSLQledFapX349axqT2n2we4adQ
         Ucgp5y/MyxcTDjtzSs4iGyE+XDEuV5bEOnGCGzlkcjNe143KaCXz2ZtY0oiSY95xV6ji
         Hi6cxIvtOIdodEq8z9liCrX4gzO44G/ldQxPk1VcHf4gbRcHpr0eTYKEzn8nGRz4YNOu
         XhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z/S4RTJY71afDEF6TS1MZzCaz1ifOD8HJkUMzuD5yGE=;
        b=bUKu9PqJsHi96qgu7tXmmajU58AuE+os59gryD+SfoQmPbf9M7e/iSWiW5NiMzeyf/
         JIHv7gQDbIk1Bnm/z09DqLBUFQrmDh3pk5H/dK6drlUU64j8gJmKjAliSwH/R/lpK1jC
         OKLj8dXaeHOVfUOK/a2GwJ+SztGqsdUs/Ek3dbszFH1h4OFN+t/qj2qzE/UAzovrosrQ
         srNvm2MaTbxY33PRLav1gcXLtZkR6ttzJpzyqMI4lt3p+3qXSIiqGEic/yTtwa4+0FSx
         UyDLvXZgm9x9yeb1kPnJBE2aEJ0rGKT/1U9/CVxN6+ymi9iUy/r+9lw9NdEuyHoMdiz1
         //jA==
X-Gm-Message-State: APjAAAXcMBlwmMgn53bhT2IBVrBc59OuXP6pRkRka83hrfgJFnL6MTc6
        9jYQWsgYc/WMINcMHc56Rn2yPjaLFyHhWsSuSzQ=
X-Google-Smtp-Source: APXvYqyfmE2Q9B3Q5FeC3HY9vyxBXyldBPY8iqz9s2Yn5YvgOy7vdwPTbUN12Wn0cgeNWxpb6jzeBD+1mj1CXiiUOIA=
X-Received: by 2002:a63:4287:: with SMTP id p129mr4034284pga.84.1552135027437;
 Sat, 09 Mar 2019 04:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com>
In-Reply-To: <20190308095752.8574-11-pclouds@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 9 Mar 2019 13:36:55 +0100
Message-ID: <CAN0heSpc7a2Vjh9oM5s5CSJaHNPHBLBFEKuP2iPYXHJYyM+YCw@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 8 Mar 2019 at 11:00, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pcl=
ouds@gmail.com> wrote:
> ---

(Missing signed-off-by.)

> --- /dev/null
> +++ b/Documentation/git-switch.txt
> @@ -0,0 +1,259 @@

It looks like you base this on git-checkout.txt, which makes sense.

> +--recurse-submodules::
> +--no-recurse-submodules::
> +       Using --recurse-submodules will update the content of all initial=
ized

But it's based on an older copy. You add backticks here in patch 4.

Martin
