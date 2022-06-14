Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1586BC433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 15:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354232AbiFNPAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbiFNPAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 11:00:34 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B25832EE4
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 08:00:33 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l14so2782060ilq.1
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 08:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qGP7ajTpnhkauDrL+6S3/n2N1Tg3NAf3YtdHY51yFLM=;
        b=Fx5o0MKIElVPr9oL/pWoVN6TpI0vQU1+NFEEd9Z+K424xezs3WwjLA2e8M4UbOh0d+
         C5I2nE2nHZ2J+NLgKS8fYo5lWrGeSQu5AbucMzSIgR7lCs1Jjq0E4L41IXfLJOc/sR8l
         TXjCG/zgE0NP25kRBeHxrXid1lCMTHPV6rb7S2yaFXPfWJrqoNT1zFEPYrniN2i73fNl
         WXdJM+YlP05o77ATE7XbW/+6xUbup7P+EHG+8WPbKa1JvH3W98iJWgZLAyqXQhJ0UFS4
         tYBJXoAIxCkHePx0RAcbwg4V/B1NPK/DkNPxSl6ifXWUkANq/MUetVDNR/ygljHtGvKw
         ttmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qGP7ajTpnhkauDrL+6S3/n2N1Tg3NAf3YtdHY51yFLM=;
        b=I6yLymvHj43hDRhVbKVexyfrhwoBbM+IocXAl7Wog5JK+lN4tiHD74gs6hxzD8k5H+
         DilGRG34g1100Ogza9CEW7XtcfdUhP3R3RwywqBUL2Kxi6YRdpK6atuB1hKWberYHWCj
         pDTTnVxq5xBUWly/75uvB5NxevPqZVtc58WhZWwsCq8CBPw73adH5LRTvI+EvVot+6x2
         bvXcpq+V7fHCPiFVPsufs/iE97CGgLqsss3qGx/Ec09sCeptSxQA/PDBMzCj2TmdjyAC
         be+izEXE7M+2NBZqNJ19Aha5U/SurTUJNXat+KZTyof2wnyC6B7nvnDMuLj6yi9T20zZ
         ioug==
X-Gm-Message-State: AJIora+08ZVgm7U/NX36Fu7Gxy8NWTOm04kIjReq8MqxqeL7gvxblF2q
        qQdN8rGSegi/ZEq1U5HX2ywXAyffA1kR
X-Google-Smtp-Source: AGRyM1u2ATgkITkwEyBQJX/mPAX8yQ4y7C1CcYujMV8nifo3HHSBdrsT95NgTUE6mLGFns0CJfJYHA==
X-Received: by 2002:a05:6e02:1485:b0:2d1:c323:18fe with SMTP id n5-20020a056e02148500b002d1c32318femr3228783ilk.228.1655218832760;
        Tue, 14 Jun 2022 08:00:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:508:3b97:7c0b:efc0? ([2600:1700:e72:80a0:508:3b97:7c0b:efc0])
        by smtp.gmail.com with ESMTPSA id s4-20020a056e02020400b002d3da8e4af5sm5682310ilr.23.2022.06.14.08.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 08:00:32 -0700 (PDT)
Message-ID: <20999998-e369-8623-579c-a71527f9184e@github.com>
Date:   Tue, 14 Jun 2022 11:00:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [ANNOUNCE] Git v2.37.0-rc0
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>
References: <xmqqwndk10gg.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqwndk10gg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/13/2022 9:46 PM, Junio C Hamano wrote:

>  * A workflow change for translators are being proposed.  git.pot is
>    no longer version controlled and it is local responsibility of
>    translaters to generate it.

s/translaters/translators/

>  * More fsmonitor--daemon.

Would you like to expand more here? Perhaps...

  * The fsmonitor--daemon handles even more corner cases when
    watching filesystem events.

CC'ing Jeff to see if he has thoughts.

>  * The path taken by "git multi-pack-index" command from the end user
>    was compared with path internally prepared by the tool withut first
>    normalizing, which lead to duplicated paths not being noticed,
>    which has been corrected.

s/withut/without/

>  * Update a few end-user facing messages around eol conversion.
>    (merge c970d30c2c ah/convert-warning-message later to maint).

optional: s/eol/EOL/

>  * With a more targetted workaround in http.c in another topic, we may
>    be able to lift this blanket "GCC12 dangling-pointer warning is
>    broken and unsalvageable" workaround.

s/targetted/targeted/

Thanks for all your work to create this release!

-Stolee
