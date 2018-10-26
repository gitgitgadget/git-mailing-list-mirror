Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0921F453
	for <e@80x24.org>; Fri, 26 Oct 2018 19:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJ0D7Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 23:59:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37415 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeJ0D7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 23:59:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id c15-v6so2234887eds.4
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 12:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=/uaFfaBTeo75kDyQ/KdxdBAYidhNE9i7Cy2beIn9Y0w=;
        b=IlP5/L7G/Kb9bFYB5kLV4eBV9yxp2UF7ZRfpeIC2cbsIv98DweihlXa8gcRgmB1Pz3
         Esa2RsfNgQBy3te8aPpHm+j8BAqGPvq4OUBK7iPsIOY+wBc0TII+C28FCq+bXNtp6Scp
         zUg/qwVTuxW68JUj6xmrkBGpzyCiTI5+biILvlIp+GguznYpflBpkfMVZXaAfrrwy16R
         LhBjRgg2dB7lODObN9hZx4gKcMR5KxXV8SvuzrjgJGAuaqeXd8SH8t+jkeg6CV4ETl1I
         ztCBQzyedokEtpEP6qg7G/yArahaPxYJbqWpmdvfyGQKCI2C1NURJ5vU+bpqpYonY5t0
         UJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=/uaFfaBTeo75kDyQ/KdxdBAYidhNE9i7Cy2beIn9Y0w=;
        b=mY1w/HqYXDR5qsUuBPKPxpZ7OvhALNq/oyT7supGNmWUMER4yPMo1eQUKNzIQLlmju
         CabDsUnCcTcFxx/pzznLKsRBLazJdjB5LmRe47KfRkAKel/jsEI/PVC5c+oEYYTFMe1/
         8Pfr+mxcFRz59tKEBA7Zy7LIPFjtXGPQjnHsLofqjvsXDsoS6WSx5wSOPBQyiMgr2hWT
         Pbm/iKuljSZkpv+4qadZpgvMpKyZPM+bWjl+9sCAFYWLGmABUbNfYr1rOQBu4l4FIaey
         hRQNa/ybd/2Mk1MN1tCkMCxSIdEy2owYXdevJdGgvogb6ik5NbB6YpPJ8Zhhq3FRCKfK
         OKFg==
X-Gm-Message-State: AGRZ1gINL85Mi08jMAqWvc8a47wxjsTRPxBUnFeQ5f01FxsKXWceRSfE
        Sa5NIx8RocCYuRbJ1NSZm7k=
X-Google-Smtp-Source: AJdET5euUqQRFLm1UpuP+gt8iAY2zgkftoF1mBkN7JNbCtELbX2+qrcB4hVJbF5jaQ8P916bufDFwg==
X-Received: by 2002:aa7:d804:: with SMTP id v4-v6mr4130574edq.255.1540581659403;
        Fri, 26 Oct 2018 12:20:59 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id w1-v6sm2378995ejz.40.2018.10.26.12.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 12:20:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: make GETTEXT_POISON a runtime option
References: <xmqqsh0xtwgb.fsf@gitster-ct.c.googlers.com>
        <20181023210154.32507-1-avarab@gmail.com>
        <xmqqefcfoq2a.fsf@gitster-ct.c.googlers.com>
        <20181024074400.GA31239@sigill.intra.peff.net>
        <xmqqefcen8ls.fsf@gitster-ct.c.googlers.com>
        <20181025010905.GA4458@sigill.intra.peff.net>
        <a5535030-65c1-613c-e4ea-d4379b243b87@ramsayjones.plus.com>
        <20181025212358.GA23257@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181025212358.GA23257@sigill.intra.peff.net>
Date:   Fri, 26 Oct 2018 21:20:56 +0200
Message-ID: <87pnvwldk7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 25 2018, Jeff King wrote:

> On Thu, Oct 25, 2018 at 02:24:41AM +0100, Ramsay Jones wrote:
>
>> >> Yeah, my thinko.  The latter would be closer to what this patch
>> >> wants to have, but obviously the former would be more flexible and
>> >> useful in wider context.  Both have the "Huh?" factor---what they
>> >> are doing has little to do with "config", but I did not think of a
>> >> better kitchen-sink (and our default kitchen-sink "rev-parse" is
>> >> even further than "config", I would think, for this one).
>> >
>> > Heh, I thought through the exact sequence in your paragraph when writing
>> > my other message. That's probably a good sign that we should probably
>> > not pursue this further unless we see the use case come up again a few
>> > more times (and if we do, then consider "config" the least-bad place to
>> > do it).
>>
>> I was thinking:
>>
>>   $ git var -e GIT_WHATEVER_ENV
>>
>> [-e for environment].
>>
>> ... but that is really no different than git-config. ;-)
>
> Actually, "git var" already does pull bits from the environment. It
> doesn't know about all of the type-specific parsing that git-config
> does, but it might be a reasonable path forward to teach it that. (But I
> still think we should do nothing for now and see how often this comes
> up).

For myself / Junio picking this up: Does that mean you've read v2 and
think it's OK to pick up in its current form? I think it is, just
looking for some Acks on that since it's not in the latest "What's
Cooking".
