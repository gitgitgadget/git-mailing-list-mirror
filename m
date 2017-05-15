Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1630A201A4
	for <e@80x24.org>; Mon, 15 May 2017 02:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755482AbdEOCnM (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 22:43:12 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33819 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755419AbdEOCnK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 22:43:10 -0400
Received: by mail-pg0-f53.google.com with SMTP id u28so52934844pgn.1
        for <git@vger.kernel.org>; Sun, 14 May 2017 19:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2eEIThXuV0socNy1e8v5HjNVyBmmcZCviiapFu6R1rM=;
        b=Y5ssYXkqxlZqAEpRChTxFWjWfJfSAkUCZXAM2ul6aQIo7T19O3MrO74EAk6xRklfFb
         d6lrzZqnaP6FMPj2yjAM1YDORRfLTUx6tTP5lrS1JT9rqI5TG/HiY1QUY7LR9YeeK65h
         MubcPqGVmSmczktrzfKqiNZvS0LLOt6K62NlMRfFFhJtr+NZIjoUp3Qz5jiX2XJlD0/E
         w6GLpnuuhuv/lZW1vXFjvEZr2ZW2kzQYEkzQZKQAfySylzZSRB8ymBF/tTwwYSe8TbvU
         s0yAo2ywJMHHR1Ssc4UsB9Qg1jmSpoH43s664Cf1ml8+EBm1nFY8BFo/QFEJnMkXe5sM
         dP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2eEIThXuV0socNy1e8v5HjNVyBmmcZCviiapFu6R1rM=;
        b=GnN3E+YGqEATTq8xZItey5AeVoYOuADpz8k4ObHzRE3FCBw8waRsWh8Kee5BNHpg/Q
         aq88GeN492dqnXACirISJaBSreyFIJO9YDHI3RbG8g5nkc57NsQigyqphyLbSpSwxi/L
         f9I89tbUoETxz6BLizaPqEXZZ+iZtnU57tijJ+PPaDZCeXIy7x2WFwP+JN/tWg1qB2ab
         AT4xbuHKNryhxbfNZW2YaxEO4svJzPEU+YOpaGHG9QMQpkMEEZH2557Nd3O9guJLd1gZ
         qtZvDrC0kRRD821ZeVvTq3tq9GrcaA/yBIfAJmDIyvc+itKydD7SVwqjYQ6WVqt7FjX6
         QdVw==
X-Gm-Message-State: AODbwcAsamduVZF8vpbf1r6GBYlMeLbjegU+bquMh7fdjfFOaAfCMZVX
        rj5tg4o5/nY3X6GX0rI=
X-Received: by 10.84.233.205 with SMTP id m13mr5361998pln.72.1494816189422;
        Sun, 14 May 2017 19:43:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id z3sm16427824pfk.99.2017.05.14.19.43.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 19:43:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 4/7] grep: add support for the PCRE v1 JIT API
References: <20170513234535.12749-1-avarab@gmail.com>
        <20170513234535.12749-5-avarab@gmail.com>
        <20170514144315.w46t7iggp7yeqn4n@ruderich.org>
        <CACBZZX5tL2YJyMgO9dnLzwe0SBPJhdOY4jpnJQBtfVRasS2Xow@mail.gmail.com>
        <CACBZZX4OFermQ3jEQOgozP-H+uZauJj6GEdwKZjqs8CF8xHEDQ@mail.gmail.com>
Date:   Mon, 15 May 2017 11:43:08 +0900
In-Reply-To: <CACBZZX4OFermQ3jEQOgozP-H+uZauJj6GEdwKZjqs8CF8xHEDQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 14 May
 2017 17:23:17
        +0200")
Message-ID: <xmqqtw4mx2kj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> Yes I could do that, no reason not to, and as you point out it would
>> reduce duplication.
>>
>> I wrote it like this trying to preserve the indentation with/without
>> the macro being true, thinking someone would have an issue with it
>> otherwise.
>>
>> I also thought just now that perhaps if it were changed the code like
>> that it would warn under -Wmisleading-indentation, but at least on gcc
>> that's not the case, it knows not to warn in the presence of macros.
>>
>> Unless someone feel strongly otherwise / can think of a good reason
>> for why not, I'll change it as you suggest in the next version.
>>
>> Thanks for the review!
>
> ...and if I do change it do others think this is something that
> warrants a comment & some whitespace padding? I.e.:
>
> @@ -378,8 +392,17 @@ static int pcre1match(struct grep_pat *p, const
> char *line, const char *eol,
>         if (eflags & REG_NOTBOL)
>                 flags |= PCRE_NOTBOL;
>
> +#ifdef PCRE_CONFIG_JIT
> +       if (p->pcre1_jit_on)
> +               ret = pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
> +                                   eol - line, 0, flags, ovector,
> +                                   ARRAY_SIZE(ovector), p->pcre1_jit_stack);
> +       else
> +#endif
> +       /* PCRE_CONFIG_JIT !p->pcre1_jit_on else branch */
>         ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol - line,
>                         0, flags, ovector, ARRAY_SIZE(ovector));
> +
>         if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
>                 die("pcre_exec failed with error code %d", ret);
>         if (ret > 0) {

If we MUST have this #ifdef/#endif in-line in this function, then
tolerating funny indentation in the else clause I think is an
accepted common practice that may not need an extra comment.

But I wonder if the resulting code of this function may become
simpler to follow if we remove #ifdef/#endif from it, and instead
have this function call a helper (which may itself have #ifdef, or
maybe #ifdef/#else/#endif may have two implementations)?
