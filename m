Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3EC1F406
	for <e@80x24.org>; Sat, 12 May 2018 01:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750903AbeELBAI (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 21:00:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55440 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeELBAH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 21:00:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id a8-v6so5029102wmg.5
        for <git@vger.kernel.org>; Fri, 11 May 2018 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mgJW/h2qnKuu4gaDlcEyn87J8LUpcGj6JOCEaUVjzww=;
        b=HnC1kabMIRBgI84/xlrVcR3XunGw6NKUa3wwQXQL2ic0XOXwTSs25IdweHlwPSvgpo
         qHFdNhmZjv6Rb7K9NCpTHIUdCKQfiwSMhV/slCBB4eK683osX0KnmcNHQkyOY47rK38H
         dwdx1bGuMChBrtWtom+bWku4cN8JSvWTCMOt/JZAhPDMqd5nVvOelkSBD361s5A3ju79
         onslNXO+KQGhUs6p2kucvRxOrVIj+RSRuUrkDx98qgDkMsS3SzW5onZW+HVNlfCUVwSD
         wF/EpYUsh/0ruVAj0pNImjAmLvjKda1Fze2eGszo7VzkquH6X+lcgVu6xCxIqQycP225
         PFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mgJW/h2qnKuu4gaDlcEyn87J8LUpcGj6JOCEaUVjzww=;
        b=WC/HLUnMtLSqlUkfd4RWVtFbYML9LYP6ZOaiqaNZt7OmG8xMhjzlONcwBlPw74svIY
         OuxFsXGClzYRHaA+dYZjdC1iDDYYXv2RDRk7g/vIqGSUcGlz1KDmWeiWVt1zK4NYSG/N
         VjGKl7gNhwkWrUL578rO1oBDA5UnVEWk4ORAHqFaI4JNg2vzuZUO2EOpFRUHLHbKXFW9
         mgsv2l0W7XiHyZ1WtBfciUYust6dKfO/BF79MX3oU5suumA2LksoBiFB1/4A6H9GSjX6
         GaLuXLCDsz5ozgt3CWIGRZpWrkcONIJCOpOn9Bw8UkbjSyNq365fD7qUz1M2greUF5uH
         OdaA==
X-Gm-Message-State: ALKqPwegZRHwNxHqsdgjHfYcDhL6kcPrwlDvfRv2UpiJ4TgiDCcZwAo/
        5a0F3SKhriXTuC9AVg4/A4o=
X-Google-Smtp-Source: AB8JxZqUTP8vCG6E01odhl8kHu8IuWwBYAl4oWJ+bjkfMpyTUAFrEi6BP8seD/m3XF5aNH/yNX7q3g==
X-Received: by 2002:a1c:37c2:: with SMTP id e185-v6mr255498wma.20.1526086805596;
        Fri, 11 May 2018 18:00:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l37-v6sm6251584wrl.83.2018.05.11.18.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 May 2018 18:00:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Antonio Ospite <ao2@ao2.it>, git@vger.kernel.org
Subject: Re: [PATCH] doc: fix config API documentation about config_with_options
References: <20180509131628.20099-1-ao2@ao2.it>
        <20180509171950.GB63423@google.com>
Date:   Sat, 12 May 2018 10:00:04 +0900
In-Reply-To: <20180509171950.GB63423@google.com> (Brandon Williams's message
        of "Wed, 9 May 2018 10:19:50 -0700")
Message-ID: <xmqqfu2xg02z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 05/09, Antonio Ospite wrote:
>> In commit dc8441fdb ("config: don't implicitly use gitdir or commondir",
>> 2017-06-14) the function git_config_with_options was renamed to
>> config_with_options to better reflect the fact that it does not access
>> the git global config or the repo config by default.
>> 
>> However Documentation/technical/api-config.txt still refers to the
>> previous name, fix that.
>> 
>> While at it also update the documentation about the extra parameters,
>> because they too changed since the initial definition.
>> 
>> Signed-off-by: Antonio Ospite <ao2@ao2.it>
>> ---
>> 
>> Patch based on the maint branch.
>
> Thanks for updating the docs.  Maybe one day we can migrate these docs
> to the source files themselves, making it easier to keep up to date.
> For now this is good :)

Thanks, both.
