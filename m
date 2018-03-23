Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 888A81F404
	for <e@80x24.org>; Fri, 23 Mar 2018 22:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeCWWjx (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 18:39:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54238 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeCWWjw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 18:39:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id e194so6119390wmd.3
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 15:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cxPmgJWOuTX41rH9blyy0TqheZ8GcD3bdG+R3kO1B8Q=;
        b=LsXPX+srt5Lv8ol48hBkUED/Ctk35nzYnH+oaXppdPEhlwV9iTk7z4uElYgrjymazD
         go/JLE87mtyufGw70MwnatlAJUY7d2qQSuFIEhiw8WNfJotImVGKcvoYDzd9x7SdNOAE
         HBEHDosr78O4GlGdGN/JlHNOlI71daDkr8b4bIkyJVHKyPbDEk92azsDwdefm5PFATKp
         OI5K4zlphqcF/4TRxBZFIeBSONgU7qM+b0rNi5wzzwICTpIm7Tkh/Bpou4QukSPWe9Dh
         KeaPNRV8zv0fzSvGnYfs3fdOwqTIGxV7LwoauiJ+xtwNEzD04ANNcjM2Lmrft202kkEv
         UWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cxPmgJWOuTX41rH9blyy0TqheZ8GcD3bdG+R3kO1B8Q=;
        b=T+CYv/VyxAMlkL/LjYqCUb2A5B8R2ptxd8Y7G/IzZS/Wd/1UmZpWKym4IZ7oFh/t0Z
         2JpHOrDcj/PoH3eIXaE+IOlp6D/s8edCDQDE9TjLLeYd9dMo8uFj5MdLFOnMgGTLQoQR
         Jh7bPjhqC+LU/suR7BtImMNDJ54ixvpOPXq0QVXdpWEhioq3otQb1dBDeL/7RG9LSTSy
         8/zlAaeqbkBtp9rdJ5UgVhrAPTLNYnYoQzx7NBH6eTZXgnhqMlFNYmUtxGMyxg988gen
         6lfXh8E2Su2oejLftGcAjznFslVv8QgSWVacwTzyJ0xecU0LW63X9cuJygYwlPGbvfHl
         SLbQ==
X-Gm-Message-State: AElRT7GO0KvLFOSvGXMNKgWiM/jAql6PKZ7d44U6IaSYMPYwKCpNKIr4
        JfFimrUxeeprYde0q74u44g=
X-Google-Smtp-Source: AG47ELvTEukmj0oXyHyYiZ4Y4txmkIEX+8I7DcuOUN1jMF+pI0WdMn9j/XSQ3NS92BWhtsVqu6VuaA==
X-Received: by 10.28.184.8 with SMTP id i8mr10715778wmf.52.1521844791001;
        Fri, 23 Mar 2018 15:39:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i66sm13387227wmd.0.2018.03.23.15.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 15:39:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
References: <cover.1521779249.git.wink@saville.com>
        <cover.1521839546.git.wink@saville.com>
        <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
Date:   Fri, 23 Mar 2018 15:39:49 -0700
In-Reply-To: <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
        (Wink Saville's message of "Fri, 23 Mar 2018 14:34:20 -0700")
Message-ID: <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> On Fri, Mar 23, 2018 at 2:25 PM, Wink Saville <wink@saville.com> wrote:
>> Reworked patch 1 so that all of the backend scriptlets
>> used by git-rebase use a normal function style invocation.
>>
>> Merged the previous patch 2 and 3 have been squashed which
>> provides reviewers a little easier time to detect any changes
>> during extraction of the functions.
>>
>> Wink Saville (8):
>>   rebase-interactive: simplify pick_on_preserving_merges
>>   rebase: update invocation of rebase dot-sourced scripts
>>   Indent function git_rebase__interactive
>>   Extract functions out of git_rebase__interactive
>>   Add and use git_rebase__interactive__preserve_merges
>>   Remove unused code paths from git_rebase__interactive
>>   Remove unused code paths from git_rebase__interactive__preserve_merges
>>   Remove merges_option and a blank line
>>
>>  git-rebase--am.sh          |  11 --
>>  git-rebase--interactive.sh | 407 ++++++++++++++++++++++++---------------------
>>  git-rebase--merge.sh       |  11 --
>>  git-rebase.sh              |   1 +
>>  4 files changed, 216 insertions(+), 214 deletions(-)
>>
>> --
>> 2.16.2
>>
>
> Argh, I misspelled Junio's email address, so when you reply-all try
> to remember to remove "gister@pobox.com" from the cc: list.

Heh, too late ;-)

I queued everything (with all patch 3-8/8 retitled to share a
common prefix, so that "git shortlog" output would stay sane)
and I think I resolved the conflicts with Dscho's recreate-merges
topic correctly.  Please double check what will appear on 'pu' later
today.

Thanks.

