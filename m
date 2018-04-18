Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37771F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeDRVVq (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:21:46 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:35525 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeDRVVp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:21:45 -0400
Received: by mail-wr0-f173.google.com with SMTP id w3-v6so8508715wrg.2
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 14:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lFRitmBk63UC481oB7e2xxGCzWLhDNJCcA0CiLePhFY=;
        b=PXeo8rxGwmXbmojT/dsMqNUgfOB6YDu8Y3BcqzR/BoMaFLbESaUiGH7U5B72WdAiAA
         JShtyM5emIATbt8ohjMpbhS9mG/Uolt9Xr+5WGyEg1pUenrUJ49qoGZ9/BTiVNyvh7pr
         YAxBfO7uFNZirrvs5KOoICj98/zn8HmOYxMjyBMLaWROzxTb03z6QvPnbChJGgN2h+DF
         TywZzzQpmIWorbi2uiI7BBdLcB75ruoKxBygRY78U8w8mJX/emQD4udA26tvjqI8mwbE
         qT3T3EjHf8u+7yGLmjhQKByZoPir/4ZdGSn72MHzc5ilQY+Fqj3Kr5UieHYpAIohAOHy
         tdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lFRitmBk63UC481oB7e2xxGCzWLhDNJCcA0CiLePhFY=;
        b=Fm1xZR8osqLSLc0wB9TPgR6+M+dl3AlOQCIPQUktNNbT/Ne8bvKaEHEldtwamqhcYf
         JQ/fjcbnOW9ZNMlixOGGCbDs2KZGDFufjh9AIpcIhPnJxKNQA2u7f3TJ28YM+lygBn2U
         rawgQBu+dNlXT3j+gUtatdcXj2lCZipwaigWMtxlbm8D27xyY0X/uWvpzxNbqALUBl3G
         SK56sUmHDf1HQp1wNmIVV40oNtv6sc2NCnbEeNN66YsDbelX6LvaAGUVRs6v6eFAbiuz
         vpkPSqWl86som2YyXvBqALxcovx2GJoqAiR71Hlnr8K/QHXtwe/mKCHZtqinj6E+enEI
         0Iug==
X-Gm-Message-State: ALQs6tDkBzeyYNa0SQfCe8kTYvinwRCI3dhGgbnBJZfCny+kFV80FSZX
        ff1bkAkxyzcfJPyTUGUEpPU=
X-Google-Smtp-Source: AIpwx48gH2aDKbjxxfeeoAKUd7s+oImICPC0G0tAUvSJ/IHq1JHVQtRSqKdQOWSMSeePn038hwL+Lg==
X-Received: by 10.28.236.76 with SMTP id k73mr2616677wmh.122.1524086504401;
        Wed, 18 Apr 2018 14:21:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n20sm2042774wmc.24.2018.04.18.14.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 14:21:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, git@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] git-send-email: Cc more people
References: <20180418140503.GD27475@bombadil.infradead.org>
        <87tvs8e174.fsf@evledraar.gmail.com>
Date:   Thu, 19 Apr 2018 06:21:42 +0900
In-Reply-To: <87tvs8e174.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 18 Apr 2018 21:58:39 +0200")
Message-ID: <xmqqr2ncgqhl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> But IMO this patch is really lacking a few things before being ready:
>
> 1. You have no tests for this. See t/t9001-send-email.sh for examples,
> ...
> 2. Just a few lines down from your quoted hunk we have this:
> ... code about $supress_cc{<token>} ...
>    Your change should at least describe why those aren't being updated,
>    but probably we should add some other command-line option for
>    ignoring these wildcards, e.g. --[no-]wildcard-by-cc=reviewed
>    --[no-]wildcard-by-cc=seen etc, and we can make --[no-]signed-off-by
>    a historical alias for --[no-]wildcard-by-cc=signed-off.
> 3. Ditto all the documentation in "man git-send-email" about
> ...

Thanks, I agree that 2. (the lack of suppression) is a showstopper.
I'd further say that these new CC-sources should be disabled by
default and made opt-in to avoid surprising existing users.

One thing we also need to be very careful about is that some of the
fields may not even have an e-mail address.  We can expect that
S-o-b and Cc would be of form "human readable name <email@addre.ss>"
by their nature, but it is perfectly fine to write only human
readable name without address on random lines like "suggeted-by" and
"helped-by".  There needs a way for the end-user to avoid using data
found on such lines as if they are valid e-mail addresses.


