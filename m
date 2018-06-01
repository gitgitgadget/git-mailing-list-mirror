Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B2531F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 19:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeFAT7k (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 15:59:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51905 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbeFAT7j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 15:59:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so5006268wmc.1
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hxU0XZe39sSpukBAWpCJNlcIwDfVPkUX1/EVfTiH36s=;
        b=rhwDyptAD+xrbnTQYXw6Oq9OW9IkxgSH/2q7gKeGVe9utW1jdv6TpDy0ub3q+/ra6y
         KMryQCbdqGcVKaudWvRzYiGBrG6jx/SXXpKo+MxJAlgk8rL6srfc7XRoQ7MvdKP9eOaQ
         MxEh7TUMlbwUrqjwVTvJEkTtyjxzjIJDrxx9FIwOC1SXkpo1Ozfh/4ZaNCaozk8JSyLQ
         7EFLCqCPOd0vGopewa1dagtoqFYyAQalG4hjS4ktl2Oc6n+qoIQykgQvupw2jyvlyuyP
         YXJLTLMooT09q3gJmp9e7WKZzulayfueY6oJyrIY+pS0vHwH42L/os3e3V3gQkVA+OoZ
         PUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hxU0XZe39sSpukBAWpCJNlcIwDfVPkUX1/EVfTiH36s=;
        b=nw8eTOs1Bm7Od++eePQp2w8Y0W9xRlbARBTtyEO49GEh5W/qOO5FP8j/AasekPhvEI
         eIB+ImKpCfXAI994CkIF4fY+4iOIOEJ2M8mbIGy2fzCsX6WEZ+5Qv4cc/qGM1P91pSQ2
         LpRn6tgdh4rXKbWg3Z+yT1tV4ti2v33/ZYRCsZZDq2y60thSFj8Brrw1GrK4m+eEJwow
         v7SO88K1yonQ/dzuHIesZbZfIftW/1+6brVGduFgzHlYfRpzI3gpDEsoIl3emTOEd6u1
         KdwIeyLozLyDSLrNIN+C1frru8VgjwP+SfIKyFQo0oJkhQUlBMy4ptkACigFU7iFj6Sk
         Kc0g==
X-Gm-Message-State: ALKqPwcpgUJSMzINQdvicyoqAzvmb3rNpivgAVzkFr5Po+Q2o8EqTIZX
        4i6ESJN57o8Zjlvj3XvuvbU=
X-Google-Smtp-Source: ADUXVKIyhz+1M3TIdw8YyZXsx1jiapxL6Jye0MsxoG0WFupeJbEKjhpJN5cCLgqWji0dA8BGCtj6FA==
X-Received: by 2002:a50:f5d7:: with SMTP id x23-v6mr13458567edm.132.1527883178352;
        Fri, 01 Jun 2018 12:59:38 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id v23-v6sm22077600edr.48.2018.06.01.12.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Jun 2018 12:59:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v4 8/9] checkout: add advice for ambiguous "checkout <branch>"
References: <87a7sg9sjz.fsf@evledraar.gmail.com> <20180531195252.29173-1-avarab@gmail.com> <20180531195252.29173-9-avarab@gmail.com> <CAPig+cQfw8-qJSt=Xbyxy1SUUDQZ-e1cGrG4g0KnO4zd7m+2dw@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPig+cQfw8-qJSt=Xbyxy1SUUDQZ-e1cGrG4g0KnO4zd7m+2dw@mail.gmail.com>
Date:   Fri, 01 Jun 2018 21:59:36 +0200
Message-ID: <87wovi8ehj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 01 2018, Eric Sunshine wrote:

> On Thu, May 31, 2018 at 3:52 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> As the "checkout" documentation describes:
>>
>>     If <branch> is not found but there does exist a tracking branch in
>>     exactly one remote (call it <remote>) with a matching name, treat
>>     as equivalent to [...] <remote>/<branch.
>>
>> This is a really useful feature, the problem is that when you another
>
> s/, the/. The/
> s/you/& add/

Thanks!

>> remote (e.g. a fork) git won't find a unique branch name anymore, and
>> will instead print this nondescript message:
>>
>>     $ git checkout master
>>     error: pathspec 'master' did not match any file(s) known to git
>>
>> Now it will, on my git.git checkout, print:
>>
>>     $ ./git --exec-path=$PWD checkout master
>>     error: pathspec 'master' did not match any file(s) known to git.
>>     hint: The argument 'master' matched more than one remote tracking branch.
>>     hint: We found 26 remotes with a reference that matched. So we fell back
>>     hint: on trying to resolve the argument as a path, but failed there too!
>>     hint:
>>     hint: Perhaps you meant fully qualify the branch name? E.g. origin/<name>
>
> s/meant/& to/
>
>>     hint: instead of <name>?
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> @@ -1269,6 +1270,16 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>> +               if (ret && dwim_remotes_matched > 1 &&
>> +                   advice_checkout_ambiguous_remote_branch_name)
>> +                       advise(_("The argument '%s' matched more than one remote tracking branch.\n"
>> +                                "We found %d remotes with a reference that matched. So we fell back\n"
>> +                                "on trying to resolve the argument as a path, but failed there too!\n"
>> +                                "\n"
>> +                                "Perhaps you meant fully qualify the branch name? E.g. origin/<name>\n"
>
> s/meant/& to/
>
>> +                                "instead of <name>?"),

Will rephrase to make this less confusing.
