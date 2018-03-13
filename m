Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3F991F404
	for <e@80x24.org>; Tue, 13 Mar 2018 18:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeCMSxP (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 14:53:15 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:38134 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbeCMSxO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 14:53:14 -0400
Received: by mail-wr0-f172.google.com with SMTP id l8so1855998wrg.5
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=asDhSC1+Q/0Eq4TB3n8Sd0Zr00SdYFWEcY0X3acPFfg=;
        b=YpPETswF+bI8KcoHEF/Z+28I8bJbyFekrM1aolqLBbnsb47Z8/iKq2i4wE+bBU7GMx
         VTbu2bW98RU6qoEq4sMEcEM/uVXTA5Ct1otsEkRY7cAfkScS7Z9NFWyYE1LYHSq8i79n
         Q4SDMIOiQkrB0eo++y5bZJgJ3oI0cMtjtQu7UHqeFWw/9tEZAiA/up3opSWYlaGA6oGX
         5QkoYuhDYakfDK+KVPubm4nFxuI3IWJ0RUS7plRFXDovOLumq8AgqeFFCyuo1y3d0sBp
         Cm/Y/QTc1dpLUZckX8y0p9KvGSvg3NLewEiANnUXKpR9Rzh2rM1u0+zjRkFf3vuCuEiq
         Q2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=asDhSC1+Q/0Eq4TB3n8Sd0Zr00SdYFWEcY0X3acPFfg=;
        b=IECKkQOAVkVhn8Zda3NNBxpkc6Y+n8cR9qZXh6zkbuBHoNEL27tZzEr8pop+oSwYbd
         YeU0rOk1N+MwR2VvjbLvwiQ+UxeLhd+r0AxP+Al0PuTYsqIWk3qgNb0XGiDoc494nWDA
         jgj0os1yb3HCmRMDHvl3g/Lr6BBGIElkJEMaYe7cF1DV4KuAChr4cx4VRUWdD+K4OsPV
         ruQKlJSFzfTW6afOJw9TfFkpIR+Lq1kSyPI8IQqs3lOAa6YuaWc6Dntjq94fKwGwnT20
         EAx4Fa9cm5dTSBPq8t5B6U+VKYXXARv7c0TOn3/3MQin3mD94nZ7XgOfk0yVaX0u4rFE
         WIdA==
X-Gm-Message-State: AElRT7HxISVTiOdyt1V8VzFKq5LKwwG/khR9I/mNyJfma++kyqNnlRg0
        AmfmZM4IoA+aWaRnLonmiB8=
X-Google-Smtp-Source: AG47ELsuJLnCm5OXQsypQDlvevs7rIp9qxDDFEPDmu4XjWs7XXEaMprwR05kNsWOqTV3CVQ7NtpyVw==
X-Received: by 10.28.87.211 with SMTP id l202mr1587897wmb.32.1520967193541;
        Tue, 13 Mar 2018 11:53:13 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id q21sm1171998wmd.12.2018.03.13.11.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 11:53:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alexandre Julliard <julliard@winehq.org>,
        Dorab Patel <dorabpatel@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH v2] git{,-blame}.el: remove old bitrotting Emacs code
References: <xmqq7eqmxysm.fsf@gitster-ct.c.googlers.com>
        <20180310123058.31211-1-avarab@gmail.com>
        <CAN0heSp9UMd=t2ssCa7Ln2Gtm2b=EKzyQbDEJGG4Lm5YboF8xg@mail.gmail.com>
        <xmqqbmfr3jke.fsf@gitster-ct.c.googlers.com>
        <20180310184545.16950-1-avarab@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqqbmfr3jke.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 13 Mar 2018 19:53:10 +0100
Message-ID: <87woyfq02x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 13 2018, Junio C. Hamano jotted:

> Martin Ågren <martin.agren@gmail.com> writes:
>
>>> +Emacs's own support for Git got better than what was offered by these
>>> +modules, or was superseded by popular 3rd-party Git modes such as
>>> +Magit.
>>
>> This somehow reads like "Emacs's own support ... was superseded ...".
>> Maybe that's what you mean, but i'm not sure. Perhaps s/, was superseded
>> by/. There are also/.
>
> I think "There are also" is way better.  If we really want to sy
> superseded, perhaps "The features these modules offered were
> superseded by Emacs's own support in VC mode, and popular
> third-party Git modes e.g. Magit" is what we can say.

I sent a v3 a few days ago which addressed this, it's at
20180310184545.16950-1-avarab@gmail.com
(https://public-inbox.org/git/20180310184545.16950-1-avarab@gmail.com/)
but I see that I screwd up the In-Reply-To (I still don't have this
fully automated) so that wasn't part of this thread, sorry.

That changes this wording, among other fixes (noted in the tbdiff).
