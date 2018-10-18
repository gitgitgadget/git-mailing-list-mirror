Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A855A1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 12:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJRUuB (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 16:50:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34351 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeJRUuB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 16:50:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id l6-v6so33145995wrt.1
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uvDqSqe/4R6itQI3OTVGVjfmywdZ1saYg4/5eUxcfnw=;
        b=EAJ3wZbfuaCYF1SJZ0o7V0nQKnZRfQ/XKEA8HqHekT9GNZw3UGiQowWUedOYa3QHF4
         i2zQIBqt5Hyo+FoclLUHiFQxj0iTNUDth9C2CJo8jhhbLImpXuDleC0rVKfEifbpsF4u
         ASDNBs7rEFBcssCNjg0Lrn8gSjTSjsG33XOWjRZtVdklpqoFbpqwtlDplBCM8xdP2EDZ
         DfWvFsdBLJwFMXGd3uylpzj6XC45ExtI+SHzWMQ61WekKuRHoTpIGzDcRVfYXYHBgOrc
         6PqirMI//yx8uZu3DMzgP07mANd8D8Ll/aZK+VxTDLe/u0uXz1ynGtkJBBy/AkUSI3i8
         f0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uvDqSqe/4R6itQI3OTVGVjfmywdZ1saYg4/5eUxcfnw=;
        b=CIBtn6Sb5D9ZwU4YVI71++ZWMCsV4+pHw4z559v/dPvw9d5SwUduhQVyeNOmCnVXwb
         SNtLZW1hno2dzv5p6Nk4cV7yizHkAY77FzynCK7U+XUXZnkHaOPX0NUsOclrT5k4zH7S
         58ptJJf0g62htX8a1Mkczffb4Um+501NW1BzDb0baL6XO2vsxyZgsTk/9aI1eYF/TsEO
         eqYksNbDXpeMcbwbAS1mJTKtwLgHZcRC00m4vcIEIckWlRVb4CqjlcHjs8n7oKcFCt8p
         mwwZtUMMGi6/b0cSHTuyp2fzjhSSW3JsT1Ks8IqtxXcbMcUEtTPFQXuJpN/XRFoKjXj2
         LFUA==
X-Gm-Message-State: ABuFfogjNntdRLpcAmP0XyFdOZpu4h1QHsoe+7oFln3UL+NBpSfwc47a
        QTQBgyZ+AZLygqPcAfQG0dE=
X-Google-Smtp-Source: ACcGV61hnad1QQRg5UMsnJM17HtKARQDvYzw15pmYOvfybmvG6uDTKOICsv4MCj+MMQh20FHNSxAjg==
X-Received: by 2002:a5d:4949:: with SMTP id r9-v6mr27577872wrs.114.1539866947575;
        Thu, 18 Oct 2018 05:49:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c64-v6sm39872wma.44.2018.10.18.05.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 05:49:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: On overriding make variables from the environment...
References: <20181016184537.GN19800@szeder.dev>
        <20181016215456.GB96853@aiede.svl.corp.google.com>
        <20181016223330.GP19800@szeder.dev>
        <20181016224001.GC96853@aiede.svl.corp.google.com>
        <20181017142923.GR19800@szeder.dev>
Date:   Thu, 18 Oct 2018 21:49:04 +0900
In-Reply-To: <20181017142923.GR19800@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Wed, 17 Oct 2018 16:29:23 +0200")
Message-ID: <xmqq1s8n5sjj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> So, then it's either 'config.mak', or passing a 'CC=$CC' argument to
> _all_ make commands, including those that are not supposed to build
> anything, but only run the tests.  I find the latter aesthetically not
> particularly pleasing.

The config.mak file is available for individual builder-testers to
customize their build, and in the context of this discussion, I
think the CI builder is just one particular individual who happens
to be non human.  If it is easy to throw suitable settings from within
the CI configuration .yaml files into config.mak, I'd think that is
exactly how the mechanism was invented to be used, so...
