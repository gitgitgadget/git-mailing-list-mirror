Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CBBC1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 21:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbdLLVZs (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 16:25:48 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:41992 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbdLLVZr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 16:25:47 -0500
Received: by mail-wm0-f46.google.com with SMTP id b199so1326709wme.1
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 13:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SZsLbxGlyNZ5Z5Gcu+tH+qyqQGuIpJM0x6UPaqokLC8=;
        b=AcV4FL3jbaIdM+iDG/b5JvJxuDTmloZZWBvZubfpprTcwnE8n93YGQUMNvLS5kLAR7
         5oNhC6IaxBeCd9lqGshFG2zmaMHyr2kbcKMTWVgmRFKU5S6TtjKPUZifq6IPzyeA40xf
         mANYpTHrEcki0lai2HjpqFWCSaV0Aw3LDYUW/uona5zB60lDVlbcrHmg7pcY+UdNG3sP
         OTNLzeVe5/Tr7aMinbLdwbWKf8dW4yc8XrACPp/C6cBmFpzDpJX6Nb/lIUpxNv+s9yZ+
         k6H5mJFuU3WedpznMidC3Py5k9sHRyF7aoSJd2gbAitnWS2HDbrPPdPDAWFQOr3aA8UH
         0CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SZsLbxGlyNZ5Z5Gcu+tH+qyqQGuIpJM0x6UPaqokLC8=;
        b=txMrxB1CKyKJX30NKP1MBRf/1H5mVbfQl1I1tffJnrIKQpXUW7nuiSGvPYeHvUtZPk
         LcZhRt3QBDKY/5gzgwvD33t7RUj8+trLB+GU6D4Xp3I8q3/hRID+IRaBA7PrCJrUqSmR
         3kazVt7EZHoAVaX67OCUFH3m3bFV9GvCxHBp8I7o8/EuDkSr7hUci9R9t5BU15yyuP/U
         gJ4R2zpkESx4Wpvv6ghaojCjdFtkgXpl9cql7mpRZquZus/0GLMsZvkrgGD65qTw2+GD
         GJpw6bL8FVuAHCewkzfDt/iJ+nui4CZCIrhvhEaSUAlLBxNTZaBT2uaGPelLrvYTlgek
         oeVg==
X-Gm-Message-State: AKGB3mJtr4OxKS6Hbo/HTxOCJOKqXGjPz96R08NzzP8YgfO9eu1cYrIe
        Le1IjKBwpStpq3UjUAKe0to=
X-Google-Smtp-Source: ACJfBouGt1RJKml9dTxqy1K7m3RBf98OBAeVYGtwrpkOCW5uKZ2AvJJ+K9kmGeUTuol4m/Lc4jtp+w==
X-Received: by 10.80.148.163 with SMTP id s32mr4639296eda.74.1513113945377;
        Tue, 12 Dec 2017 13:25:45 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id k42sm234709edb.94.2017.12.12.13.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Dec 2017 13:25:43 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eOs3a-0005Dp-Kg; Tue, 12 Dec 2017 22:25:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Thomas Adam <thomas@xteddy.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
References: <20171116154814.23785-1-alex.bennee@linaro.org> <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com> <87wp2jwe9o.fsf@linaro.org> <20171121205206.fvwjkkwhil4abmmk@laptop> <xmqq8tezyu3g.fsf@gitster.mtv.corp.google.com> <87mv2p89wu.fsf@linaro.org> <20171211172615.jfsjthkvs4itjpcn@laptop> <CACBZZX58KpQ7=V8GUFfxuMQq_Ar6cmmoXyPx_umUTbU19+0LCw@mail.gmail.com> <20171212103040.jbgkyet5rapqxi44@laptop> <87indb99xy.fsf@linaro.org> <87fu8fddam.fsf@evledraar.gmail.com> <xmqqwp1r20zx.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqwp1r20zx.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 12 Dec 2017 22:25:42 +0100
Message-ID: <87d13jd4fd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 12 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> My "Makefile: replace perl/Makefile.PL with simple make rules" currently
>> cooking in pu changes that so that:
>>
>>  * We always at runtime test for the system CPAN module.
>>
>>  * In the case of Error.pm we happen to ship a fallback, in the case of
>>    Mail::Address etc. we don't and have fallback code, but we could also
>>    just ship a copy and remove the fallback code.
>>
>> This makes more sense, we always "dynamically link" as it were, we'll
>> just change the target to (a presumably newer) system module in the case
>> of Error.pm if it's found on the system, otherwise use our fallback.
>
> "When to fallback" aside, I think the above makes sense for the
> send-email simply because we would be replacing "our own" fallback
> we may need to maintain forever with something with an upstream that
> we do not have to worry too much about.

I'll see about submitting something that replaces the fallback with just
using the CPAN modules + bundling them once the Makefile patch has
cooked to master.

> A tangent; I thought I heard that use of Error.pm is strongly
> discouraged several years ago---am I mistaken, or if I am not,
> perhaps we should start looking into updating the users?

I'm not a fan of it, 41c01693ac ("git-svn: handle merge-base failures",
2010-01-06) shows how you can do that rather simply with just perl's
built-in exceptions.

My TODO list of "perl stuff in git" is now:

 - Get my Makefile.PL thing through
 - Make sure Dan Jacques's relocatable stuff is OK wrt perl on top of that
 - Upgrade the required version from 5.8 to 5.10
 - Update Error.pm itself, our copy is ancient
 - Add more stuff to Git::FromCPAN + remove fallbacks

I could add "rip out Error.pm" to that, it looks rather easy, however
given previous discussion about me needing to build a manpage from
Git.pm I understand that Git.pm is used by code outside of Git itself.

Ripping out Error.pm for our few internal callers is one thing, trying
to maintain bugwards compatibility with how it throws exceptions for
users expecting Error.pm objects is another. I think at that point it's
easier to just stay with Error.pm.

Probably easier to stay with it either way, don't poke sleeping dragons
and all that, it's working code, even if we wouldn't write it like that
today the churn probably isn't worth it.
