Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A2321F404
	for <e@80x24.org>; Wed, 28 Mar 2018 20:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeC1UJA (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 16:09:00 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:46209 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbeC1UI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 16:08:59 -0400
Received: by mail-yw0-f175.google.com with SMTP id v68so1215456ywg.13
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qrlfWN6LAiC9/InfBxnV2Aib3+pEQ5XRy0zRCu5/05Y=;
        b=JMcuP42z0XW1RtadDEYLcQFH804g2prQB/pEv4RuiKaPJuF2nTGGfpHTJRNLx36fGZ
         rOc7+qh9wd5btaNKg7kcNCM3kpGAjtYNCfWeRCLo8gF5DfxRHasTCprKVCBCCfryg6n0
         Q7SD3UEL7RHPTFZBzwqx9z8KRXDekp+eUMoJO4KSVFBmd6TK0biFOTpWlEYDZedVysq5
         C3Jyi234mTe484NFHT3IC/qAvUfeMvlCMqv/PcUjjXItM4kyxhc5uIpfHAE95jGZ/WLP
         EWaLgCGL7CRwT4/JjjOYAHZugd3HZmXvfihd9VPpqxeQwYDKkQ2pQI1ge6ZpYiB4GTjc
         Tuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qrlfWN6LAiC9/InfBxnV2Aib3+pEQ5XRy0zRCu5/05Y=;
        b=mVKm4D4wdVdQtXYi+boc49nd3RMgIM2foWdAjwOYVgc7IAq8ZRqJLyB3tPgbnHwG2n
         ueL+SHgkV4xnhu4rHwDZYItVXRKGJTlS/oYfklbUNOvlrNhVkmEWuhIopXSUqp3S13f1
         92d1hyfX038U0KSmdyOF6DN/WjMhQ48Hv55QK8zNWf50+2x6odLgfGU5+ZnCsNgNVegG
         UaIzp+3kBdiwLJ07mVC7KOdzKSOzBOSqxoIFZyGyLWNO7vW70kKFfVaCfWyPxzZExO8P
         iVLqRuBUfeVJ49Zc0ktqpzSMjuQwnSprIYAmbwQdQCG330dKWLHvFFVuq8X2vsy9jIc4
         NhDg==
X-Gm-Message-State: AElRT7G0sOCf0tcWofdpAGeudx25wMKxyUFrW8HlLX2U4AGJ7EjmKOMY
        qCWzjuwiELCW98fmTaNQy5CPI6kD1wB4FfJ0NSqbKA==
X-Google-Smtp-Source: AIpwx48TF1hxHqovugPo+LKHF0bu10qG3V2uzZucvk1Q1duGLMEvSe70Ba7/n4+Kw+yKRZPRt9KNrAg0JvFF7+uN3k8=
X-Received: by 10.13.208.199 with SMTP id s190mr3209212ywd.33.1522267738322;
 Wed, 28 Mar 2018 13:08:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 28 Mar 2018 13:08:57
 -0700 (PDT)
In-Reply-To: <CAPig+cT1Yp8J8E0VDKdxvPdVD-UBsyDfQS+a83zOAW11ayfhnA@mail.gmail.com>
References: <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de> <20180328183832.243036-1-sbeller@google.com>
 <CAPig+cT1Yp8J8E0VDKdxvPdVD-UBsyDfQS+a83zOAW11ayfhnA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Mar 2018 13:08:57 -0700
Message-ID: <CAGZ79kYD+RC_Z7AH_uH9tZSDHhkikML4HkxUNGxkW8voHJ1i3A@mail.gmail.com>
Subject: Re: [PATCH] submodule: check for NULL return of get_submodule_ref_store()
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, jeremy@feusi.co,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 11:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Mar 28, 2018 at 2:38 PM, Stefan Beller <sbeller@google.com> wrote:
>> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
>> @@ -821,6 +821,18 @@ test_expect_success 'moving the superproject does not break submodules' '
>> +test_expect_success 'moving the submodule does not break the superproject' '
>> +       (
>> +               cd addtest2 &&
>> +
>> +               mv repo repo.bak &&
>> +               git submodule status >actual &&
>> +               grep -e "^-" -e repo actual &&
>> +
>> +               mv repo.bak repo
>
> Should this "move back" be encapsulated in a test_when_finished?

I thought about that, but decided against it for some reason as I was debating
where to put the test_when_finished. I mostly saw those at the very beginning
of a test and wondered if it can be called from within a subshell.
(I'd not want to put it at the beginning but rather adjacent to the move.)
