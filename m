Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341C01F42D
	for <e@80x24.org>; Tue, 29 May 2018 19:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965659AbeE2TFK (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 15:05:10 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37407 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965311AbeE2TFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 15:05:09 -0400
Received: by mail-ot0-f196.google.com with SMTP id 77-v6so18242245otd.4
        for <git@vger.kernel.org>; Tue, 29 May 2018 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TiX0aV0iNzPVAGkfPf584i4d/tob8plEsgjoURiomUw=;
        b=h+qHXZya//2+vKob/E5FRTTDV2vHB6P6Nb9IErV7DPPcU6XN6Z2tUQbykyI3BQa4p7
         0/7aa7FTLzVTLzb7ot8073wnFaI6IsDtENyF3wfdxPe0hok4d6gp0W1YnHWkBPGScTG4
         wGq707c7ML6QVafSNO40MQrElKFcVeenVpO3GuWuXbLXbf3RtXGUKHKxIGlF6d8QZTTS
         Xpgc6YUBoriNvufqcuMXgvUJhjzsh+RBVjWQ/1RZZLl+eUWMeTGC4zlMNeLcBmD9SS9j
         lmyJjU1VdKUHTZfrk4JmxFvLI93i6e8W8wmF7R4HSYZGM3rcTJdtahRRuR0cgoj078DI
         ewZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TiX0aV0iNzPVAGkfPf584i4d/tob8plEsgjoURiomUw=;
        b=lulUOImPwt5U46ARBepHq2uTJqwwIxo0gqgPUmhD8OuaVoEPtmI2lsSXeUqqQjkSZZ
         RxF3f/bCdwytjAXAE3R46EIbBzxDO1JCa+vmnAK6V3n0wx2D+CLg8fdcR3rSFbGL5CEp
         pktkBudguF2itipCP3QwtH+mtwviWpmSoE/oo+q/g8gxx+ZnfBI0EQ9jNlUKFHyCsAiV
         6kLj1tEO7+AWPifG5xgyxFqzaT9asg92TfDIdiXOh3S9LgHPyQwF+7w7AdEGOki8d7IN
         qgfXC1N2Akht2phVm14fiHzn/xzlAcherGjBvOpyaoRCskcpx+j/Ghr/ooL3RGnq7Ki1
         c+Tg==
X-Gm-Message-State: ALKqPwc00O9sVy8iyV2I7xrmDpVhRZ7xclNZRPfJQx7IYkW3v2uEoOem
        Xbv9z/gPFgQukQvQ2SI3dpP5Bvj4xzk5FIZYmMY=
X-Google-Smtp-Source: ADUXVKJvc4eWeyX7EEmMFREXikBDZaSHfZqb5hQEflbhphF2eCC+lTAnw2UFz+7q9k2JbMaOo5me2XhujnGTarcK6J0=
X-Received: by 2002:a9d:49ad:: with SMTP id g45-v6mr12574169otf.65.1527620702903;
 Tue, 29 May 2018 12:05:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Tue, 29 May 2018 12:04:31
 -0700 (PDT)
In-Reply-To: <CAGZ79kZ+kDRHKJj917rZ-=mmusuTcB4_Su-BNupqdQqT6rWRaQ@mail.gmail.com>
References: <20180417181300.23683-1-pclouds@gmail.com> <20180527083828.6919-1-pclouds@gmail.com>
 <20180527083828.6919-4-pclouds@gmail.com> <CAGZ79kZ+kDRHKJj917rZ-=mmusuTcB4_Su-BNupqdQqT6rWRaQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 29 May 2018 21:04:31 +0200
Message-ID: <CACsJy8Cq8LaFf=fvU02e4aepOUXC8CUTFeiUVHVvzYk50AqmVA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] completion: collapse extra --no-.. options
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 29, 2018 at 8:48 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, May 27, 2018 at 1:38 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> The commands that make use of --git-completion-helper feature could
>> now produce a lot of --no-xxx options that a command can take. This in
>> many case could nearly double the amount of completable options, using
>> more screen estate and also harder to search for the wanted option.
>>
>> This patch attempts to mitigate that by collapsing extra --no-
>> options, the ones that are added by --git-completion-helper and not in
>> original struct option arrays. The "--no-..." option will be displayed
>> in this case to hint about more options, e.g.
>>
>>     > ~/w/git $ git clone --
>>     --bare                 --origin=3D
>>     --branch=3D              --progress
>>     --checkout             --quiet
>>     --config=3D              --recurse-submodules
>>     --depth=3D               --reference=3D
>>     --dissociate           --reference-if-able=3D
>>     --filter=3D              --separate-git-dir=3D
>>     --hardlinks            --shallow-exclude=3D
>>     --ipv4                 --shallow-since=3D
>>     --ipv6                 --shallow-submodules
>>     --jobs=3D                --shared
>>     --local                --single-branch
>>     --mirror               --tags
>>     --no-...               --template=3D
>>     --no-checkout          --upload-pack=3D
>>     --no-hardlinks         --verbose
>>     --no-tags
>
> https://public-inbox.org/git/20180527083828.6919-1-pclouds@gmail.com/
> " There's no magic numbers (previously we keep 3 --no- options)"
>
> Here I see 3 no- options, is the number how many no's to show configurabl=
e now?

In a sense, yes. If you write OPT_BOOL(0, "no-foo",...) then that
--no-foo _always_ shows. "git clone" just happens to have three of
them.
--=20
Duy
