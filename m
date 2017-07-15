Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0142027C
	for <e@80x24.org>; Sat, 15 Jul 2017 10:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdGOKJr (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 06:09:47 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37515 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdGOKJp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 06:09:45 -0400
Received: by mail-wm0-f48.google.com with SMTP id b134so6901050wma.0;
        Sat, 15 Jul 2017 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sWnMcmAPrFJrdaGaJrwXF2zCh7bHuuvmFeHmh6By61k=;
        b=ren/FOJbk8N7NSrpfOU/F6jr/Kxej6sWKw4EIS/Bt/pVQ/nC9/+LTODUhttYkMRMHo
         mwyoIqYJ5ls+zYDqK1BM9gYa5PKxaypLp6dwUliqYE87sg/mmV5n5lKQcbnENYdbzVWj
         mg5XnnQNNt5JYGLZeusTvr0t6+WoP/BoJn70FoA+9gawZt66beQW43koUSvOFdReAnqJ
         mmRpwQxUzki+AJVxsQ03Qcco3KBq8sFTRXaFcFmD3njYqGbcvCnoG4HQ5hHlp14tNTGx
         JTylWs8bd4ztWw4u0XASlmaWwoB7kQWj9bkzpfVz/wMR3ixaa/FF49rjliJSBOdt4mZy
         n+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=sWnMcmAPrFJrdaGaJrwXF2zCh7bHuuvmFeHmh6By61k=;
        b=YFEDb+Cnyd94pstdj7Gh8BM3p3/fZeFGvv8Vr2HidFk4Gf7q7Yd9tZAagzcdadJVh8
         +Zaq7qAcmowxHw9w8R0aQsnFHXoHPGp8PA+CUG4DbAlIVs7xiQDbytTWHARQ/Oo3t8e6
         eQEoFTIvDjH6QYfLVZlFpGiitCcv6K9PBdwYU0LdxCuPy768nxgHvO/GuTjjnRo6gEj6
         wZd4BTDisigpxbvVf3TVMaZEJDv8gBLF3IHwKKzt28+Cm915zrFDk7lcfB2JxLJGFglv
         bmY+uW33vpzimgWqATMQ3DrBMvCpQuxHFPsrr4W5Z2K0jGusfLT1VywR8V3Wreo4Fb0+
         5KxA==
X-Gm-Message-State: AIVw112LsB86l9JVJE25pVFoHSys7zQWyv0I8okXgO/3K1QbPDXA+VUd
        O0UD2bwEgnPksw==
X-Received: by 10.80.136.129 with SMTP id d1mr9922666edd.130.1500113384513;
        Sat, 15 Jul 2017 03:09:44 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id g25sm5258468eda.59.2017.07.15.03.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jul 2017 03:09:41 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dWK16-0001V9-Vs; Sat, 15 Jul 2017 12:09:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.14.0-rc0
References: <xmqqzic7sy2g.fsf@gitster.mtv.corp.google.com> <87mv8638y5.fsf@gmail.com> <CAP8UFD3Xe=bxWhQdm_Jh0yfB=Cv3UUNxmO6ji5akaa4PH_KurQ@mail.gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAP8UFD3Xe=bxWhQdm_Jh0yfB=Cv3UUNxmO6ji5akaa4PH_KurQ@mail.gmail.com>
Date:   Sat, 15 Jul 2017 12:09:40 +0200
Message-ID: <87lgnq2eqj.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 15 2017, Christian Couder jotted:

> On Sat, Jul 15, 2017 at 1:17 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Thu, Jul 13 2017, Junio C. Hamano jotted:
>
>>>  * "git send-email" learned to overcome some SMTP server limitation
>>>    that does not allow many pieces of e-mails to be sent over a single
>>>    session.
>>
>> Makes it sound like it does that automatically, also "pieces of e-mails"
>> and "sent over" is odd, maybe:
>>
>> * "git send-email" now has --batch-size and --relogin-delay options
>>    which can be used to overcome limitations on SMTP servers that have
>>    limits on how many of e-mails can be sent in a single session.
>
> Maybe s/that have limits on how/that restrict how/

Yes that's better. Thanks.
