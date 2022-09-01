Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44C0ECAAD8
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 15:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbiIAPCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIAPCp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 11:02:45 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1BB6DF86
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 08:02:44 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id f9so9973406qvw.11
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kL4HUrfaZbhQDBG4NtuHPf4XJzKm84bVgxcwkmMpBg4=;
        b=Y+2CMSIv7g8SyND0VBNe+Nsgqaj6wdmABLYtybTKKZTuUWGzMqF0Xrtzg0BfdCqE+5
         sliKhnnoAqMyVI4E7fBZPszTnW8pfMXyidl5W+ENIIDXGaTEl/KBQM5vrCX7lwm1yEi9
         Du5MckiR6IvIQm4kT0FLnhFKX2Q2519RkqkLFCpm/sHqX60BZ5B5SS5UdYsy4uRWIc33
         14X4I/gdOCQYbf6AnBFuRfZqOqj3XQhHvSpI4mKg5WiuHqma6HL9enhyHNDx6bo+Ng15
         RmXrQ9GWqZu54yliTC6e9HJprWlPaAR/o8m1Ry2629GmxZT3XT9CdoAF6Q71B6NfX+zP
         ijZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kL4HUrfaZbhQDBG4NtuHPf4XJzKm84bVgxcwkmMpBg4=;
        b=N8h1ZAf+9dRAM3SAezV1/5Y3lJHW+gySlD8XCklJRwTmSNKg0mUffYrxeOctFhpzAn
         QhwkoinOfHfxAflXbGH4+66w3g2YARICMj7oI11pC27CTAe28BvYpjSG+UA23TyIvuke
         EOOJWAreArG5Q/VuKNEDsM2V8qwXdLXet3v5JPhT0++mEy8t5FrNvsketrn9Ot2Sf/vp
         8ddsmdRficvhhmcXDLJve1pBl838iKWjZm3sarqXuEb9CKXsSVib4sNIRhA1QLDM2NUk
         XSMAcdBRLn7GOab5BHSXTHjvsulKocArp4WZEvzkpWbbtUgWf33YUz+3T+UqhYxydhcm
         iNew==
X-Gm-Message-State: ACgBeo1y9EBwNgk4wEqzammv9QQNKgfxjWT4XczMTySqNSY96MtnGQ5h
        Zjg7lDeaFhNRJglnnV0h6oXmomo92XLY
X-Google-Smtp-Source: AA6agR7djA4KZX3KZ0WNZnMHsyOt4UtuMqM7JRIUTCqHnzoVnfqS+T7c9fcnt4OND4MqjIG6aNbZLA==
X-Received: by 2002:a05:6214:5185:b0:472:f9b0:cbc6 with SMTP id kl5-20020a056214518500b00472f9b0cbc6mr24393552qvb.92.1662044563578;
        Thu, 01 Sep 2022 08:02:43 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bj4-20020a05620a190400b006b5c061844fsm12020398qkb.49.2022.09.01.08.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 08:02:43 -0700 (PDT)
Message-ID: <d6c46ce8-a4a5-f120-30d2-2388b6b63d7e@github.com>
Date:   Thu, 1 Sep 2022 11:02:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/5] Makefile: split up $(test_bindir_programs)
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
References: <sso99so6-n28s-rq86-8q20-4456r3pn869r@tzk.qr>
 <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2022 9:17 AM, Ævar Arnfjörð Bjarmason wrote:

> Ævar Arnfjörð Bjarmason (5):
>   Makefile: factor sed-powered '#!/bin/sh' munging into a variable
>   Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
>   Makefile: simplify $(test_bindir_programs) rule by splitting it up
>   Makefile: define bin-wrappers/% rules with a template
>   Makefile: fix "make clean && make bin-wrappers/$NAME" dependencies
> 
>  Makefile | 58 +++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 39 insertions(+), 19 deletions(-)
 
I find it very distracting when you send a full patch series in the
middle of someone else's patch series. Viewing the thread now involves
two distinct conversations, assuming that your series gets review and
requires multiple versions.

I would rather that you started a new thread with your proposed series
and then sent a reply in this thread pointing to that one.

Thanks,
-Stolee
