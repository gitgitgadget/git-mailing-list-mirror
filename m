Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82FE202AB
	for <e@80x24.org>; Sat,  1 Jul 2017 17:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbdGARVm (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 13:21:42 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36471 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbdGARVl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 13:21:41 -0400
Received: by mail-pf0-f170.google.com with SMTP id q86so81280165pfl.3
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=99iEzXLpmrsQ/TwsYanPeWpHfmWOJwAvOMuxZsrGvHg=;
        b=qatQsjPDc+QZYXnDOhIMN60+X9hDbBz/UvB91ZJDF71Y5/fgfbBiGvFLqc1/Ll/mVz
         BrRiBcE/7HG66U6mkpMNwaLDFHjYVqsq8baPHa9/3wQ+M3l+hQICpQExLHKj3athuhmg
         WAEkgPsVhcHP3jr0uwliWpzYxGPAlTOQ1R7rTiHB8CBeb5BJIqWZP5vs2NF84oTkAhQL
         ksPRICYxb9Cmv+k668vBQtjTV0a9a0cstZBpSoeLvrHyHbCQt16JmSXP92w0dCh0nLUS
         byNf6PIZiUmOsX5tyo78arOtJa6UpRwxSkIL9R38+Lj0JMHHBZRV57w3Ru6dOTlIgW8A
         ncWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=99iEzXLpmrsQ/TwsYanPeWpHfmWOJwAvOMuxZsrGvHg=;
        b=Ua0U6iZ1eikzHIe/m73lyFOA1vWMYJ6bDG3W6zr1zELjQvsQR1yf7iaYKolqcewI8z
         og6PHKeB0Mhm4zoV5TPzXuti7alhlziLXGWO1PP+k+KuSb1Zvyd3uDRsGs3SlmBn0Wwj
         lGIA0bCzj7qFZdaRfCf52bZIBOKd3++8UdjDESYlhQKk1pUB019Y2Arlna4s6afk6a09
         TFWS2yGwR07Y02ncEfEMEs8Dkh0ib87Jz8rsJ/kGRRLPf4uAq9pu+o5+b0CU6CmRH6M3
         CVkmaYyfOyI/ghZzAalbdNl4pivcMjoyIAIAVxrmF8XdSNb6CPyXtkz5FtYQ5R869dKA
         rN9w==
X-Gm-Message-State: AIVw112HRBSr8g2tzNUoEKfAFFoClsdVkzTwxvOznM9jE8kKaMdriMy5
        sDtW5VCfZ8m+eogKS88=
X-Received: by 10.84.131.74 with SMTP id 68mr1635765pld.8.1498929700466;
        Sat, 01 Jul 2017 10:21:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fd45:ceab:278e:5d13])
        by smtp.gmail.com with ESMTPSA id r84sm11304031pfa.57.2017.07.01.10.21.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jul 2017 10:21:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] commit-template: distinguish status information unconditionally
References: <1498792731.2063.5.camel@gmail.com>
        <20170630121221.3327-1-kaarticsivaraam91196@gmail.com>
        <20170630121221.3327-2-kaarticsivaraam91196@gmail.com>
        <xmqqa84pttmh.fsf@gitster.mtv.corp.google.com>
        <1498874344.2245.0.camel@gmail.com> <87mv8oe5zc.fsf@gmail.com>
Date:   Sat, 01 Jul 2017 10:21:38 -0700
In-Reply-To: <87mv8oe5zc.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Sat, 01 Jul 2017 13:44:55 +0200")
Message-ID: <xmqqvancnkd9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Just as someone reading this from the sidelines, very nice to have
> someone working this part of the UI, but it would be much easier to
> review if you included before/after examples of changes, e.g. (for this
> hypothetical change):
> 
>     
>     Before we'd say:
>     
>         # Please enter the commit message for your changes. Lines starting
>         # with '#' will be ignored, and an empty message aborts the commit.
>         #
>         # Date:      <date>
>         #
>         # On branch master
>         # Your branch is up-to-date with 'origin/master'.
>     
>     Now:
>     
>         # Please enter the commit message for your changes. Lines starting
>         # with '#' will be ignored, and an empty message aborts the commit.
>         #
>         # Date:      <date>
>         #
>         # On branch master
>         # Your current branch is up-to-date with 'origin/master'.
>     
>     And as a word-diff:
>     
>         [...]
>         # Your {+current+} branch is up-to-date with 'origin/master'.
>
> Or something like that, much easier to read something like that than
> read the code and mentally glue together what it's going to change.

I think you gave an example that is different from what was done on
purpose, so that Kaartic can respond with "I see what you mean; what
I did is different from your example but this.", but it seems that
the attempt failed X-<.

I do not think the patch changes the output in a situation where the
above "Before" would be shown.  Instead, when the extra "Date: <date>"
(or "Author: <author>") is not shown, the Before picture would look
like:

         # Please enter the commit message for your changes. Lines starting
         # with '#' will be ignored, and an empty message aborts the commit.
         # On branch master

and the update makes it look like:

         # Please enter the commit message for your changes. Lines starting
         # with '#' will be ignored, and an empty message aborts the commit.
         #
         # On branch master

Hope that helps.
