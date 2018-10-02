Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63C21F453
	for <e@80x24.org>; Tue,  2 Oct 2018 21:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeJCET4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 00:19:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45005 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeJCET4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 00:19:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id c56-v6so3710436qtd.11
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 14:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VPGf/R492x6rSWeW2hlj8u8rdGekyc1oYWTxCLvAdAQ=;
        b=Jo/xqm+Gi4ReOrNWbrUUWlmKPFM+7V4NwhLACJ/0hQlw9Vg9YREcAmRiZQ73g9K4Eb
         r3xE1uqppg/VQMA6nc3Puh/LrzpBILz94qztlPcJ1VV/GYpKf12P1sHdIUR9dUEJU1nc
         zw97rp3WiK9IhCFHG1jT86XdcdTjFn5803TFJzwc2t+mWIcQZmlVgHs1QEMjGqozxvox
         GG/IVQQTsZdwvr/kI7/iKpCcisbY3oJMAPg9TKRvO1MLM9I+QBFUSzE96Ey9en7SUQ81
         zePfGaZGDtb0oVYGyikYLe9DnV1GtmyAAv1fXNWVQZtrOiVLO5ipQy3bnGUQzSVUHDpI
         8q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VPGf/R492x6rSWeW2hlj8u8rdGekyc1oYWTxCLvAdAQ=;
        b=I4MtZqqzEVUnxzdNxbjpdM5ytE0Op/ta2AvG/KFD5Kyi5xs2NuBMe+FAhfyNr1QgVt
         I6LjuQkgf44zxlm6wp+TWFvVtI9S8UR87eZjQqJPyS5X/euu9C9ZtgVf0rYIa9NMhMV8
         TvSq3WbQ1dQzCGoWI/NV9zs1SynC6UEEBlxXN7UOKmgvnbp09EJTtJQG4MMZ1Qs5KnvJ
         kxTP1beEx4k187nKHoYvYM7b3rygS4UYKwwaNMFtv254zaqHr6nGtQZ8cR+VPdwyHlTZ
         X03HZA2h0zPIwGxIIDqzfsQzao+GiLlOtT9hwjwmYmiDLQ6tP50KHQEc/Fwl27BB1lhk
         p0KA==
X-Gm-Message-State: ABuFfohoYo9NfQ7nrLA556tpoR0J0CVR2JbScd6wWpSbhESA0TYWKsfD
        eits4YhlFm0mBLGc7Dnpn/A=
X-Google-Smtp-Source: ACcGV63PpEnzvKWZRDLeOU4XuyC0fFv6epLoDEUN4xwimIxDaQ3ArprCKAptG5DJGA/B/FUOLehGJA==
X-Received: by 2002:ac8:7003:: with SMTP id x3-v6mr14420403qtm.325.1538516073006;
        Tue, 02 Oct 2018 14:34:33 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:81f3:8f89:2be9:a31b? ([2001:4898:8010:0:6b29:8f89:2be9:a31b])
        by smtp.gmail.com with ESMTPSA id q24-v6sm1548596qtb.26.2018.10.02.14.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 14:34:32 -0700 (PDT)
Subject: Re: [PATCH] more oideq/hasheq conversions
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
References: <20181002211921.GA3322@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5f28c9d1-1fed-5af4-c6fb-c05d90d125c2@gmail.com>
Date:   Tue, 2 Oct 2018 17:34:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181002211921.GA3322@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/2/2018 5:19 PM, Jeff King wrote:
> We added faster equality-comparison functions for hashes in
> 14438c4497 (introduce hasheq() and oideq(), 2018-08-28). A
> few topics were in-flight at the time, and can now be
> converted. This covers all spots found by "make coccicheck"
> in master (the coccicheck results were tweaked by hand for
> style).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Jake: I was surprised that this was not a "patch 2" on top of your
> earlier coccicheck patch. Apologies if you were planning to send it out.
>
> This doesn't conflict with anything in "pu", so it's a reasonable time
> to apply it. There are a few lingering cases in pu, so another option is
> to wait a week or two and see if they get merged.
These conversions look good to me!

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
