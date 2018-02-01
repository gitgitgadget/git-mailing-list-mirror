Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D281F404
	for <e@80x24.org>; Thu,  1 Feb 2018 02:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeBACeF (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 21:34:05 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:45627 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeBACeF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 21:34:05 -0500
Received: by mail-yw0-f176.google.com with SMTP id b16so6449192ywh.12
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 18:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JJvRjx0oGR/f4IB1mUSqlWi5Ls+UAFzh1lOoeEjJ6BE=;
        b=Z68/hfBxBe4Mm518wRuNNz/j4bxhPZty+tc1/+Du6EW2yjDrin50fWYDdgGXGSn8Az
         D/GSMdDV5ch6CXTefF1iHENDmWbYBYUhJBMvvWz6wt1IBn3JY9WhC3olf+njTCVZtUmp
         7/DpqR/dNvAfU0hHspc74YK2mEDEK2/WBWuryCrz3O9qewZPdrxzv8BPq1PEH5l7FxRU
         NYONJ0vQ3BFThi4KrB5wGp5kSGDrLDg1FBT1XOJve/XKtr3XnXx4sutbASb37KOVxsee
         QqDULYW24NbNVzIjr7WOyUjeMhTjoWUiNoKaaTnt+4ajKlSXtDk2dstwZnTSE6SjpVFz
         jcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JJvRjx0oGR/f4IB1mUSqlWi5Ls+UAFzh1lOoeEjJ6BE=;
        b=kZRMR2UMVv9IGcYdbYX5LAYyDAmi59O43+fjvHhTqJpqL+Kw50sGKRZ4MJGOsOLW3z
         mhRc97dfXCcxQ17OOBgthBRzsLIN3GKRIIZ4RT5QDAIjRWCBEi248UWUiFdHDHd1QbXZ
         R0TW6U9cIzGoBniQLEtwzFonFeZts9FPahiyDmTMCtsy8j7sD1Doib0cPpBMQhhJ/t+Y
         uVCFIboSHkulvW+HTsJDede1KyxMmfkfIRtYAeZc/D0a5lME28tqQdOGJqulWr/d2ZVj
         7ngZeZOuH0//zXveLBWtjT7rS5lVETHvZnEb2rCI4v+yApHxH/rI1SGpQNOzAUGr1dTu
         DNFA==
X-Gm-Message-State: AKwxyteYZj2qJq4G6xNRejFJRBVoJ3rxaw6OFZoh5kzmLCVd1D5Kpdm4
        C/LChkYblvC6eQScUonSEZKADLrM3/Ig0BkRma0JDw==
X-Google-Smtp-Source: AH8x226spawJ11E+moUje4JNV1+4SVsp7vXbXpeO8tj+F0U97x7DlmBqs7fAqSf5TlCCVsIgWvm0+cLos5uzAAnL9DA=
X-Received: by 10.129.119.131 with SMTP id s125mr22943524ywc.166.1517452444087;
 Wed, 31 Jan 2018 18:34:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Wed, 31 Jan 2018 18:34:03 -0800 (PST)
In-Reply-To: <CAGZ79karMKMTAFZma8WiThacyWp7FqYPd6NNZ93s4xa48SnOyA@mail.gmail.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com> <CAGZ79karMKMTAFZma8WiThacyWp7FqYPd6NNZ93s4xa48SnOyA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 Jan 2018 18:34:03 -0800
Message-ID: <CAGZ79kY59aSBQCaC8XKeNPuOz6yJFYCMSvOn2webitWRGbR5KA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Serialized Git Commit Graph
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Finally, I tried to clean up my incorrect style as I was recreating
>> these commits. Feel free to be merciless in style feedback now that the
>> architecture is more stable.
>
> ok, will do.

I reviewed all patches and found no nits worth mentioning.
The whole series has been reviewed by me.

>
> Thanks,
> Stefan
