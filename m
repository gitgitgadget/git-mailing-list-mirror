Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4CB1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 20:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbeHMXV0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 19:21:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44285 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMXV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 19:21:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id f23-v6so8947156edr.11
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NeyD7TVLKFzfHao1FGoOMyqd9UG+F4oV1iUtXW1yP6Y=;
        b=FgvUicvPr8PZMpl4WilgMrJCvem2LEsc7owZEvhyhQ1UUPFrmJrg1dj6cyGMe6RV9I
         G/pYAiAQ+e14ydV1JelWIohwYlT1We/GWfeQQbzMfoTmf09TN3jiYytK8Os4GVw0uHFM
         h68z/3pLeprc4n2kFYnyPUO55lt3RaIT6FLjy78+JvlCNwUAvvGE++XFNVWWaRTnnnaw
         PhY/tWTM1v/5SZ/GLgOFpinhDHfi0gXftERWj5FR5aALVOTHbrBwoYRijvPakKdUoF/q
         Letiv0qF6yyeudD1YEitah4HBQ/SAKspWEbDSG3qLXPEsuve/bJa7qni2Ee6Z7acBwxK
         wY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=NeyD7TVLKFzfHao1FGoOMyqd9UG+F4oV1iUtXW1yP6Y=;
        b=NP4zKuPczwmNgpjFAPTpu1WkyPElYiY2ChL2OF7M/FpTJI4f8XuupsMwQu9CFfg+Su
         oafbfC7lPW9yvhOITGvuEb5lmlEH8AW4qVyUl8mzk864Np70Mvmyta28qKwbspgOZt3k
         uQ18oJOLRxK026SW5yYAEJMlyNqIvmt6D3z2qC/QGJPMwd/qJn3w+xyWUfGda87i7OmX
         1TyIY4mmktj1BCs1f4vxrvPV+jY/kUIi4CN4MZyQGXY8Aj39/UHlDSmpNqyeQwqwY+7U
         HS3i0e/o5gWyIk42HDVHtOwl5+lNl2EJWVWWH6GR5xiB6GG7MF8jBCh7MF9l5WYTNWIp
         HiBA==
X-Gm-Message-State: AOUpUlFQuHSDIiuKllUBmtMFL9wEhiKlD9H85FtCJKnRz3BLgGT6/q7e
        bNQCnOH6T858qJDTEVURYr8=
X-Google-Smtp-Source: AA+uWPyI55gDu9zhzy5Cv/Io4at7cA9TFRGHJOSczeFXiDe2cKP5xbNNmM1UGS7XS+iCp3F6mm4DMQ==
X-Received: by 2002:a50:b902:: with SMTP id m2-v6mr23778108ede.185.1534192655906;
        Mon, 13 Aug 2018 13:37:35 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id h23-v6sm6435541edr.86.2018.08.13.13.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 13:37:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v3 0/7] Prep for "git fetch" should not clobber existing tags without --force
References: <20180731130718.25222-1-avarab@gmail.com> <20180813192249.27585-1-avarab@gmail.com> <xmqqlg9a3t8b.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqlg9a3t8b.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 13 Aug 2018 22:37:34 +0200
Message-ID: <87ftziroj5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 13 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> This is unchanged from what's been cooking in pu for months now, so
>> hopefully it can be merged down faster than most, and then I can later
>> submit the actual meat of this series once I fix the (mostly doc)
>> issues with it.
>
> They have been held in 'pu' only because you said they were not
> ready, I think ;-)

You had some feedback to 6, 8 & 10 in the last round which I haven't
addressed yet.

I think the "not ready" comment you're remembering is this for v1:
https://public-inbox.org/git/CACBZZX4yG5h5kk4NFQz_NzAweMa+Nh3H-39OHtcH4XWsA6FGpg@mail.gmail.com/

> I can confirm that the first 5 do look the same, and you dropped the
> old 6, 8 and 10.  The remainder look the same.

Yup!

> I quickly re-scanned them and all of them looked obviously good.
> Will discard the remainder and requeue.

Thanks!
