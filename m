Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2E41F404
	for <e@80x24.org>; Thu, 23 Aug 2018 21:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeHXAns (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:43:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39415 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHXAnr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:43:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so3443831pff.6
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 14:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MZpqNB9vH8Udj+/PXXPspkw7rr1QUb/3xxjuFTIJ+Lk=;
        b=X5RdEDX7NWD8Bmf39th9Jpv5GxR4p7rhakWueM6SuMzsKceCE49QQpM5Sbzl3Y68IX
         PY/BCercafZ50qO0oSw4x3kGQlP328G6dyhxG7pOGWJJbKsQ/6CEGX8Lhcg1+OIPUNzY
         kYMo03Sn4JV2n/+8Nk2u0bt3fCZnvFHrid5xJKbyillamMfGeAYJwu9UGcOC+sJX8Q4g
         4ch1x8BIViwS7iQE1u8aXPwg/D9HUjcKDWPj0ZOhwgHenukJ6XYHfqmCodz1GRcNW73A
         oyXaB8X3BaLe6HeXVcSdpGZiSO7VlRiBtFHOM2S2sObxclVk0YW27f1k9ypyDNjiA3iw
         /sCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MZpqNB9vH8Udj+/PXXPspkw7rr1QUb/3xxjuFTIJ+Lk=;
        b=EC2+0uImb+2AO7RMLxzNrPGeZ5+mVuf3TElgF/CZsPaVoVaW4nmjvlBuyVvDpin43v
         U9pXjiFK5egBUUxWrklDf1OpqfPszVxoNWVK8fb7RlPuMlvyEWelGv5GU8qYaRuC2sot
         G0WdStI2Rtj8SUM1DuSNQsI6LvexHB9DICnC72qF1Dikwh9q9/DPUpC41Af91/qkRZmg
         6o8vpL5GAD988QcpdUhozpK3qKB0UqgGCKbCt8fGohEIHLMQapteoNPtbRot49FkOCTI
         K1l2dZbykQ+mt/JcZkGkoZvtE8LO6pmrbuxKIcR6FyzTUmxMtBI3nM+GC168eO2Tsv/I
         dK7g==
X-Gm-Message-State: AOUpUlFeaa2ioyP9348VFBZH9dnPrdihYByd2tRdHsRQQPCxYlmW7xQQ
        f2MbFcU0N0WFmO1mGrEvjqs=
X-Google-Smtp-Source: AA+uWPyboNQO8xzzj4tEXpQPM48YJeFPZYKvxonFWjkNXGZbNxeviSfTw2MqtKt9gPONDP1ohuG9TQ==
X-Received: by 2002:a63:6b03:: with SMTP id g3-v6mr27762358pgc.57.1535058736392;
        Thu, 23 Aug 2018 14:12:16 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n80-v6sm8237640pfb.95.2018.08.23.14.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 14:12:15 -0700 (PDT)
Date:   Thu, 23 Aug 2018 14:12:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH] range-diff: update stale summary of --no-dual-color
Message-ID: <20180823211214.GB99542@aiede.svl.corp.google.com>
References: <20180823023955.12980-1-kyle@kyleam.com>
 <20180823024719.GG92374@aiede.svl.corp.google.com>
 <87wosh7pjj.fsf@kyleam.com>
 <20180823032238.GI92374@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1808231629540.73@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808231629540.73@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:
> On Wed, 22 Aug 2018, Jonathan Nieder wrote:

>>  		OPT_INTEGER(0, "creation-factor", &creation_factor,
>>  			    N_("Percentage by which creation is weighted")),
>> -		OPT_BOOL(0, "no-dual-color", &simple_color,
>> -			    N_("color both diff and diff-between-diffs")),
>> +		OPT_BOOL(0, "dual-color", &dual_color,
>> +			    N_("color both diff and diff-between-diffs (default)")),
>
> There is one very good reason *not* to do that. And that reason is the
> output of `git range-diff -h`. If anybody read that the option
> `--dual-color` exists, they are prone to believe that the default is *not*
> dual color. In contrast, when reading `--no-dual-color`, it is clear that
> dual color mode is the default.

The whole patch is about "git range-diff -h" output, and of course I
tested it.  Did you see the "(default)" part of the string in the
patch?

That said, the conversation continued and I agree with the conclusion
it led to (which is better than the patch you're replying to).

Thanks,
Jonathan
