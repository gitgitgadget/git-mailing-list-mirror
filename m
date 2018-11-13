Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970E01F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 10:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbeKMUQH (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 15:16:07 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47027 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731963AbeKMUQH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 15:16:07 -0500
Received: by mail-ed1-f67.google.com with SMTP id b34-v6so9905825ede.13
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 02:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=lz++7d9NIu1F5D19AECL7hlD1vCVH0zjYZOgt21kyuI=;
        b=Xe4kqhiLLQsQdoKhM1Y2UsoePLCcH+Pc8PCtq6Bq8d+wrUTDnflU1/+Dc62g8LQQia
         wSgYlfDsTfzqLiGuzPUKCh8O6P0G3bqrXgNHCk6h5jjO3lJ8Np+VfVWmUcuqWxlIyaQK
         7WOR7r37ugMBrBMJVPm2Z4pw5AR2td32d1ZO6K9152/USsa+AfPgteGpSAP/URaFUO2m
         +r3mwMdkyoA5XvXlz6N29tTxj8ULHlx49vFrBSUdL0qDwgGclyvYVEV3OF9zbI0/Dhzx
         /9BWLnosGQFU+iF4yEX9Vk0J/ErL+6WPwauPd8R1MI7YQQroSt8aYJWG0LtiAnaf5sdA
         KhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=lz++7d9NIu1F5D19AECL7hlD1vCVH0zjYZOgt21kyuI=;
        b=O2Jo4xvRDMMCSnaiLeJvY25UxhueONYhQn8KO7tf6hG70vX0WT39CPa8qX4+Zyouwa
         FyGPP2vMEmvpkFgM2PANjPyGrTmGhzHfM+BReoCF09WAqcSdjCAExp7FMALbvFHQ2lVH
         Df6y0FUr0cEHlDWUqFiSQ05WCZqSWqAsOva5NhwqoVzw1xVlW5LM6Yed9C7NdNUxT9KD
         POXhmeG6vykh9r+9BJXu8hzT4FnhxxKiYJkQ1A7jOoASHtjABmkXMkXW3dAr0gu8ny3z
         MOVgarN2x+tkBKSicqlTQzDDdB/vBmd56WykXxeMU3+Oyi9w3E/Qt6UK3StwvOmLPzla
         Hiug==
X-Gm-Message-State: AGRZ1gLlmFFJkRSOCAN9vVZBbTjJNL1xiVM+T8PCg7J57J7Xwcne6+T/
        9p+mnEHk7LA99DWej0MCakI=
X-Google-Smtp-Source: AJdET5edKWOVI2yJqgPyrLKb3lpS4RlQbz2bq4bgJEDwnCtX9b/kUlUJSMb4phhYAAVJpxJkK7omrw==
X-Received: by 2002:aa7:d0c5:: with SMTP id u5mr10022610edo.158.1542104321053;
        Tue, 13 Nov 2018 02:18:41 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id b39-v6sm5716333ede.42.2018.11.13.02.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 02:18:40 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fredi Fowler <inredikawb@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Using no- for options instead of duplication
References: <01020167094ab871-ca8d8728-0102-4d93-a4ff-d554b4aec59f-000000@eu-west-1.amazonses.com> <xmqqmuqdwq2e.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqmuqdwq2e.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 13 Nov 2018 11:18:39 +0100
Message-ID: <877ehh2scg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 13 2018, Junio C Hamano wrote:

> 	A tangetn that somebody might want to tackle.  It would be
> 	nice if we had a tool that takes a grep expression (like
> 	'^--no' and '^\[no-' above) and shows histograms of the ages
> 	of lines that match.  It might tell us that all 44 combined
> 	ones are more recent (some of them may even have been
> 	updated from the separate form) than the 124 separate ones,
> 	in which case we can say "we started the process of
> 	migrating to list options singly, like '--[no-]option', in
> 	commit X; let's continue doing so" in the log message.  Or
> 	it may turn out that we have been going in the other
> 	direction and most of these 44 are stale ones yet to be
> 	split.  Without such a tool, the above numbers are the best
> 	measure to go by, which is not quite ideal.

This doesn't spew out a histogram, but you can use the various "git
grep/blame" one-liners (https://www.google.nl/search?q=git+grep+blame)
plus shell one-liner to get something useful:

    git grep -e '^--no-' -e '^--\[no-' -n | perl -F':' -anpe '$_=`git blame -L$F[1],+1 $F[0]`' | perl -pe 's/^.* (\d{4})-.*\) /$1 /' | sort -n
