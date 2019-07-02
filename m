Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5701F461
	for <e@80x24.org>; Tue,  2 Jul 2019 10:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfGBKxv (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 06:53:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39467 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfGBKxu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 06:53:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so26829457edv.6
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 03:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=eheZrq4RfV7m/smyhmaG1+aKu6R6UcM3hKnRsdWnhPU=;
        b=UbI9d+eYoh0vvvJ2OrmHg0na9iCGze2armv3BBfQAog/j57GSIWo9TZ6GNUi1eEFlZ
         jrwLHs2ykXPbeyJnhq/R+bfFhOfTIILfFnlZg48hMnIg0BGysikECL5+Q2j/W8Kw87NA
         WlKApAmL4k/JArtofQC0CjOJxbui4F0NS3+hoLfwyOgLjy7YDrS1U3f6ly6IR+Uvt3cE
         Dh0+JejKMjsOq8ctK5S7Xkd+IVI7SvFE0bzD3pPx4m8WAyVSVVxvk7zKJ+WWi9t3DHNG
         rCTqfyCOR1rVFuuKpGjjfWpWTrVtSuqSZZX3bCSbVFXemuWjJDPb4E/Oju1hu/pmZZWN
         kiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=eheZrq4RfV7m/smyhmaG1+aKu6R6UcM3hKnRsdWnhPU=;
        b=K02CaJ4VGxdDmpLjwPSd0u6Y/INI6p45vsmksS+6s0G46YZA/PlUegr/Zf+tkTw+z6
         QsBeJBjyKalg1HKIZCkQ40/oxiLEtW9mjA3ASc8GhezbRFHUAr4EQXCgCzMwfWqkQrAa
         tqU2Ak6Tg28nlim132CzwHdaSjKWmXQwNpNbIu2brA+Z0lwTiXIKUOjPy9xwNQuPS2Rq
         MJvjKFiPi9O3lunH/7OYygLIrlxDIPwXxgCCvjTfmAhNrTNNuU4lSV65Bk8J7YOlBxsL
         X8JAzIYGZtiUb1J7GfzBfrv00VS1VNAoHWsQqI2uH9ZgtnHevkx5d1sTadNH3D46IL3R
         ZTdw==
X-Gm-Message-State: APjAAAWF3j7EEbjDVEjLDeEsrE1tnnTLPN5xDosWZywxbQkyA7N2otlf
        yStEtPEOcmLv/b7JYDwdlaE=
X-Google-Smtp-Source: APXvYqzo1UZHCt0PoKt24ceFfFuVRw3hgUKdr6OR5tXQfoN5TMtjNgYW69/ItEBjrpTFZj1Yt36FSA==
X-Received: by 2002:a17:906:5399:: with SMTP id g25mr27449171ejo.247.1562064829083;
        Tue, 02 Jul 2019 03:53:49 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id x10sm4546899edd.73.2019.07.02.03.53.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 03:53:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/3] repo-settings: create core.featureAdoptionRate setting
References: <pull.254.v2.git.gitgitgadget@gmail.com> <pull.254.v3.git.gitgitgadget@gmail.com> <13b9e71b383485885c4823baa466c32511fd20bc.1561991348.git.gitgitgadget@gmail.com> <CACsJy8Cwxov9VWq_MpeWstGtMB-rTy6LYyFj_PF9oSP0kqcDXQ@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8Cwxov9VWq_MpeWstGtMB-rTy6LYyFj_PF9oSP0kqcDXQ@mail.gmail.com>
Date:   Tue, 02 Jul 2019 12:53:47 +0200
Message-ID: <87r2787lms.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 02 2019, Duy Nguyen wrote:

> On Mon, Jul 1, 2019 at 10:32 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> @@ -601,3 +602,22 @@ core.abbrev::
>>         in your repository, which hopefully is enough for
>>         abbreviated object names to stay unique for some time.
>>         The minimum length is 4.
>> +
>> +core.featureAdoptionRate::
>> +       Set an integer value on a scale from 0 to 10 describing your
>> +       desire to adopt new performance features. Defaults to 0. As
>> +       the value increases, features are enabled by changing the
>> +       default values of other config settings. If a config variable
>> +       is specified explicitly, the explicit value will override these
>> +       defaults:
>
> This is because I'd like to keep core.* from growing too big (it's
> already big), hard to read, search and maintain. Perhaps this should
> belong to a separate group? Something like tuning.something or
> defaults.something.

The main thing users look at is "man git-config" (or its web rendering)
which renders it all in one page anyway.

I think in general adding more things to core.* sucks less than
explaining the special-case that "tuning.*" isn't a config for
git-tuning(1) (although we have some of that already, e.g. with
trace2.*).

Documentation/config/core.txt is ~600 lines. Maybe it would be a good
idea to split it up, similar to your split of
Documentation/config/*.txt, but let's not conflate how we'd like to
maintain stuff in git.git with a config interface we expose externally.

It's going to be very confusing for users if some settings that
otherwise would be in core aren't there because a file in git.git was
"too big" at the time. Users (mostly) aren't going to know/care in what
chronological order we added config keys.
