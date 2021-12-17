Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EC0C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 11:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhLQLGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbhLQLGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 06:06:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFB8C061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:06:15 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j9so3397170wrc.0
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8npjxQgy4YeN+9EeBAA2WXUTvAe9A5PRZhwyaL6MjA0=;
        b=mW2iziWiN/gkugTmeL/5QIlT7YhcBV808USFraA1L9hkGxBtmGZGIxvRLM70Whfd9q
         6WFxIRDaovC2gVW4xaCYxWVSvL0cEWd5u7tPQED9KHpKxMpF688mwzlWxEWrs/rAcqWD
         0XwtLZXWv50tCuIcBeHF98h/kqm7AB+32eiKqBgb/grXjHO457Gb09B3DDRbq6S1um9G
         ZlF/kFVApS2+abjiu1kGYw7JUM7xvs5RshWx+DYcmmItAoUWs113BNnzMtxRVOmElvRA
         9L7JGrgjg5PZJj0plLwUuWyIBoxFKzB7yJNcJn6oDT6ZaQnUMFCzSP68seipBzNYtJ8x
         1qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8npjxQgy4YeN+9EeBAA2WXUTvAe9A5PRZhwyaL6MjA0=;
        b=uFAxRQKgRsbuMY1+oAfrziYhCI4C2kqidxjyABG8yrcHm7lEAGfjef3q+2bbVZ8xjw
         yezGrpeN3r4K0cei5AsocBsVOiQoC/0ftEs5ihfhiTe8MnuAfztMQipI6njeZCvKCkGw
         HrcZi/qxOJ/15Y23e1/cRaDmh1QKAlGduPQQpNacuOItsQH6nR0wkvlS+SXQsF3CJjry
         JZVuJIAvP+ws0Sck6oGzfOCJKsoHZ9ui9j8123xTDNCvjOnWV6/iUiGgecBTxaTu4BLI
         vz1/WC59634XuUv1+SOSP0BnUzyVhhCZWUD20sjAcPw6FO3mTYiuTkcpCu4cypii7tp3
         AhNA==
X-Gm-Message-State: AOAM530xUbcpWl0AaDE3QXI/Y0mWNA+cHQ7tim42VSW64gnHRd0FfUGi
        umzjSJBPNqSLGYshtjhXGRw=
X-Google-Smtp-Source: ABdhPJxjKczpjwk7z19hkAYYeWCssxPbm/D5Ql5SouNw/dBWT09CBZJ3pxVtnpVkCt5Y6GpdTfY+7g==
X-Received: by 2002:a05:6000:181b:: with SMTP id m27mr1988315wrh.43.1639739174189;
        Fri, 17 Dec 2021 03:06:14 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id g13sm9447381wrd.57.2021.12.17.03.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 03:06:13 -0800 (PST)
Message-ID: <5ad65463-4f2d-d6b1-c0db-087a0f85ad5a@gmail.com>
Date:   Fri, 17 Dec 2021 11:06:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: taking a break from Git
Content-Language: en-GB-large
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 15/12/2021 16:38, Jeff King wrote:
> Hey all,
> 
> I'm going to be offline and completely absent from the mailing list for
> five months starting at the end of December. After that, things are up
> in the air, but I may not be as involved in the project as I have been.
> 
> Sorry, there's no juicy gossip or drama to share. I still like everyone,
> and think it's a cool project. ;) After 15 years, it just feels like
> it's time for a break and to perhaps apply my brain to something else
> for a while.

As others have said you will be missed in many ways. Your clear, 
comprehensive commit messages and thoughtful comments on the list have 
been a particular inspiration to me. Enjoy your time off and good luck 
with whatever you decide to do after that.

Best Wishes

Phillip
