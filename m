Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96CAC1F42D
	for <e@80x24.org>; Sat, 26 May 2018 02:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030982AbeEZChq (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 22:37:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50549 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030648AbeEZChp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 22:37:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id t11-v6so18750389wmt.0
        for <git@vger.kernel.org>; Fri, 25 May 2018 19:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jmgIrfwXEikSRaisXHbgxMTrmCyxC0zALOS3WeeF24g=;
        b=eO5X97EV5Ml3xLSIOHMDzLQxba7H+Zrh5E3/WwG8x8AD/ScHYUvXUV/yiLBHFDjy+E
         Ni2hps402bCOeS4HtPhrul8oy+cam7ImTJ3U7AkdHKXLVCy9n0ltMf5S51W+A7vJUsXe
         /h3Awcc3swW/18HcvgGEOJQ2SfpF28j7jNPGc1jk7+BQezeAxDzSgd4DUpGOPWA4BH1T
         QaJqyxjmT8cUmqs4VZ5KLGvFDekiKpW9r0rG25+Rscl3JdBwoPzCjW3Rg6FQWhrh1mAu
         JJ1qYcE2jPo85OUVsrSnReBNjnP7nmCf2KkW0LcQ9ewShAnFu0nTR9EnkP2nmhtD+Pwc
         lqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=jmgIrfwXEikSRaisXHbgxMTrmCyxC0zALOS3WeeF24g=;
        b=jm3ngKLoqPCSAkmZa9tGIcwpB1+F2SrrMDnPLdP30+5UgQWojsvMPpZsJ8wU6nJ4ap
         wtPxLdj1YWHoCh+2I0S5Nz1OC0GbRM6n02faWvN+4CYulSGcaXV64sbd36Dapwzk/vT8
         WGhlf5YQ9BBwXBetlQZNFptm7k0F6+4tOdg62uE3wMic75zV4KvZHFxuVekCc5lJW5i9
         rXs9T5i4bQSSCqHM8dZonyU8rmlbGF7CO/ocz52jCDT5+3bMERQgEsFrG59CykdnKlMn
         lOFkjwdmO7PX89PGuZX0Ks9wb+OJ05odAoAsay1ThCr4CvvFJgAqJGR9HvV84v1x1lK+
         m8UA==
X-Gm-Message-State: ALKqPweoRRd2hBUvguQGADPFyJhRKkkZvAoQngVDKxaroU9433xcmGdd
        GiS7b7HLHuLRBhAh6t+hkxE=
X-Google-Smtp-Source: ADUXVKJA+74NlfmTtmGduvMqTOaacF0j/404kr4rIh6azXiuJqutv9okeRwlocBiznEPsDDjtkCtzA==
X-Received: by 2002:a1c:e906:: with SMTP id q6-v6mr3214193wmc.23.1527302264183;
        Fri, 25 May 2018 19:37:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y7-v6sm16018916wrh.86.2018.05.25.19.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 19:37:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
References: <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
        <87fu2qbojy.fsf@evledraar.gmail.com>
        <20180517133601.GC17548@sigill.intra.peff.net>
        <1527174618.10589.4.camel@gmail.com>
        <20180524192214.GA21535@sigill.intra.peff.net>
        <20180524193105.GB21535@sigill.intra.peff.net>
        <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
        <20180525024002.GA1998@sigill.intra.peff.net>
        <xmqqd0xknmf1.fsf@gitster-ct.c.googlers.com>
        <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
        <20180525171050.GC10461@sigill.intra.peff.net>
Date:   Sat, 26 May 2018 11:37:43 +0900
In-Reply-To: <20180525171050.GC10461@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 25 May 2018 13:10:51 -0400")
Message-ID: <xmqqsh6fm9ag.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> By the way, this is one of these times when I feel that we should
>> have a better multi-line message support in die/error/warning/info
>> functions.  Ideally, I should be able to write
>> 
>> 	warning(_("the '-l' option is an alias for '--create-reflog' and\n"
>> 		  "has no effect in list mode, This option will soon be\n"
>> 		  "removed and you should omit it (or use '--list' instead)."));
>> 
>> and warning() would:
>> 
>>  - do the sprintf formatting thing as necessary to prepare a long multi-line
>>    message;
>> 
>>  - chomp that into lines at '\n' boundary; and
>> 
>>  - give each of these lines with _("warning: ") prefixed.
>> 
>> That way, translators can choose to make the resulting message to
>> different number of lines from the original easily.
>
> Yep, I totally agree. In past discussions I was thinking mostly of
> the pain of writing these multi-line messages. But I imagine it is
> absolute hell for translators, and we should fix it for that reason.
>
> (Also, I guess this message probably ought to be marked for
> translation).

Needless to tell you, I worked backwards when noticing that these
three warning() lines are not marked for translation ;-).

But of course, fixing this in a naïve way will involve memory
allocation during execution of die(), which may well be due to OOM,
which is why we knew the need but haven't found a good solution to
it.
