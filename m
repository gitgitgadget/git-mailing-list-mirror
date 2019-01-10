Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35DC51F803
	for <e@80x24.org>; Thu, 10 Jan 2019 18:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfAJSzZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 13:55:25 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:45554 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfAJSzY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 13:55:24 -0500
Received: by mail-wr1-f49.google.com with SMTP id t6so12548871wrr.12
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 10:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rTtF89k9K3aJ2xqxRlQ9lqpAR9jLEhXWK15sZbghqwk=;
        b=k9k5U1dIWsJZ/H3mUW9wtfErO590KxCB9wiLD7gfBHcwzSlTXWLjwWTcAIsm9p+eFW
         OtKyuzT5H6+WVp6F8kegQ4IgQ+iMqkdzssqX6NcUnvHz8hsPXCttzML1xaa3S3AJOA2e
         oRSABfYn1pddGUUvAJTW9U3c/XIdN6YlQFyB3gmw0BkQ5otd1Y9OnxcoJZ89rJ/Y9KaP
         SveY03/15YUsKzh3Bs8N9bC4iPVuQOOCLsqlR7zBfF6/p4zYAshmpf6EBrQENzLeVSdR
         lfDatEsqxD4j2JquKhiesi834/00rsVE83fqhc1dI462lN0m5UjB1HCMwo4Am+lyaFUE
         p75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rTtF89k9K3aJ2xqxRlQ9lqpAR9jLEhXWK15sZbghqwk=;
        b=LDthxhbV9xPOZMUFhPUyfYocmZTt2QyAB+LJyWc1cloK8mlBG7jEt8LYM84btG/M/H
         pnUmSNqHyO/TDCVQNjqShFozgutW2dwSfCwu4Nmw/J0KFf4FkZIrgJYEYWsesF3pFDRP
         3Oy6vkVTZzxrc8IS+teU2MAiEAAXCrxkCbAotO2K+j4l0ygpZtWDp1YE0TdN22FJHs/K
         GY/XUfjKW1t2SdGTFkV7/COBlOxHjnaKfkTEJn1oS321IAYkVMvKb6sFhJ/esP1NOxsc
         PDCXyOIWQXw0KZ3qfF2XHdsMZiWBlMV/PS8E5VPcNuRZ0pXkmT16VMgli3wpiKdBYxrO
         n/Bg==
X-Gm-Message-State: AJcUukcgVuRRPdweDfDdLor814lH2OBXG2zYc5069M+1DlkQk34w2HYC
        27r2egUIqtR4Dw+kYJcVDSU=
X-Google-Smtp-Source: ALg8bN6FIqr9yot9uoMWeIXOHKLN5oDLO/uXQhMqfzsLJExdK3kg1T9CiH5L4MSwNx7aOo/qyHVYsw==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr10527202wrx.85.1547146522661;
        Thu, 10 Jan 2019 10:55:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n9sm50659613wrx.80.2019.01.10.10.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 10:55:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2019, #01; Mon, 7)
References: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
        <CAN0heSoRYYS3-UAamE9nibhORPoD+_TRHu5-ZTeYxYMS4BAnrA@mail.gmail.com>
        <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
        <20190110010238.GK423984@genre.crustytoothpaste.net>
Date:   Thu, 10 Jan 2019 10:55:21 -0800
In-Reply-To: <20190110010238.GK423984@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 10 Jan 2019 01:02:38 +0000")
Message-ID: <xmqq1s5k2vhi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> I can think of three possible approaches:
>> 
>> * Allocate with a margin (GIT_MAX_RAWSZ - the_hash_algo->rawsz) where
>>   "necessary" (TM). Maybe not so maintainable.
>
> I think there are actually several places where we allocate for these
> buffers, so this is not likely to be a great solution. Even worse, in
> some cases, we intentionally use a too-short buffer knowing that we'll
> never dereference the data.
>
>> * Teach `oidset_insert()` (i.e., khash) to only copy
>>   `the_hash_algo->rawsz` bytes. Maybe not so good for performance.
>
> This is probably the best fix for the moment if you want an immediate
> fix.
>
> As for my series, I'll need to run the testsuite on it, but I'll try to
> get it out tonight or at the latest tomorrow if people want to use that
> instead.

Thanks.
