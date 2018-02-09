Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4821F404
	for <e@80x24.org>; Fri,  9 Feb 2018 21:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeBIVGj (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 16:06:39 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:56303 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752720AbeBIVGi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 16:06:38 -0500
Received: by mail-wm0-f44.google.com with SMTP id 143so17606415wma.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 13:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tFkeCvDuB6wpLamaSFXctNpOmE7CuAbEZo6u75/2Ipo=;
        b=KlVR3X0Jma/WxIPS+hF2lGjR9mxcfcloCEmw00rFiz8gXpWT4aXDKGVgJhlYfwDqMq
         loASPthuRIhtz3Vk0G4655mYdkv4lo1MjjDCrz510LYW5urqjw6mVCUS6ogB2cRZL96M
         agBWEy9JhQGd2faXgSX/ckr/EOjH9gWyX+4Wp5qYYe9YWNYH+0K8aPtiPWbtv5nY22LM
         ewtbx2oBTNK+Yf0yLoyzbZszgCQTcgJV8XlCaBqLne6luQLvJMYrwg4iENJNW61Orqfx
         NjLrNNVxx9FGI4jhjdMH7Ep5HEO94e6h9qOh48g6X4QLnlzHX0Jj+CpWpMFe7sSEczfR
         boSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=tFkeCvDuB6wpLamaSFXctNpOmE7CuAbEZo6u75/2Ipo=;
        b=sFJZp0u9Q2dMz+aTBlhBb45vMP6ukNTUp7esqGd77Si8encoDWa9VEKXpWqfypVCLz
         24vUeS+F/wE9XfRiWESig7NMDjEw9dL+8wcq4NU260nLCbHBohWi1K8lOYhzmaKBh5u3
         qvOlMvKIO8IREy3lK8vBtcYPKFXUF8MNxwWPhzDzAAkJBZVSeotGtOhMZ88Z5C+jLnAg
         mjou8NutlCZbwtmNa4X9HKXc/HhRRRqDfy4FL+h0Edrgu56NboOTBAGxF/k0jUQqNj9I
         o2Ake20vOXgrfturEQQe5jLeh3f9EujtuuJwJJZffOTNlw27AsAZ7xEG9fje7nub1J5+
         E7VA==
X-Gm-Message-State: APf1xPAVPcADmQQ22EJaXGBtAqbmA0hEesqsd2vo9dJ2j+oHqaSax4Jh
        C3B3Y+LyMrhtXq3FnXtg0h0=
X-Google-Smtp-Source: AH8x227SBn/2ESefnCy3deM7Gbip8hr3qxfAh/R1MV11g5/RSmDFC74ENRLTIr9bOLea+oCowYLQvQ==
X-Received: by 10.28.148.150 with SMTP id w144mr3039339wmd.0.1518210397718;
        Fri, 09 Feb 2018 13:06:37 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id 7sm3550358wmq.42.2018.02.09.13.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 13:06:36 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 00/17] document & test fetch pruning & add fetch.pruneTags
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com> <87d11fmjer.fsf@evledraar.gmail.com> <xmqqlgg3qn3l.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqqlgg3qn3l.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 09 Feb 2018 22:06:33 +0100
Message-ID: <87y3k1lvom.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 08 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Feb 08 2018, Ævar Arnfjörð Bjarmason jotted:
>>
>>> As noted in my 87h8quytmq.fsf@evledraar.gmail.com there was a bug I
>>> noticed in v3 where it would segfault on some git-fetch invocations,
>>> but there were not tests anywhere that caught that.
>>
>> ...and of course this whole submission this time around should be v4,
>> not v2, but I didn't notice that I didn't adjust the subject prefix
>> before sending. Junio: Hopefully you can pick it up anyway without too
>> much trouble, sorry.
>>
>> FWIW I've deployed this to production @ work to some tens of k of
>> machines (low "k" of which have users using git) without any issues.
>
> Will replace.  I found that the resolution of conflicts necessary
> with the jh/partial-clone topic is a bit different from the previous
> version due to addition of an extra parameter to fetch_one(), and I
> think I didn't botch it, but please double check when I push the
> results out in a few hours.

Thanks. FWIW I've looked over that resolution in pu and it LGTM.
