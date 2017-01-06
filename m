Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BBDC1FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 13:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033921AbdAFNTG (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 08:19:06 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33725 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdAFNTF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 08:19:05 -0500
Received: by mail-lf0-f66.google.com with SMTP id k62so3285372lfg.0
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 05:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=thj1BoXoGMeSHAdBPBMoK98neQzwJz/6ggZg50/Ws2w=;
        b=FeD8Tx0yd4+yINCOE1jhxQFo1QzIbN3c3fOiytDiEivNC/pUzeMaubHMYNSTeV4f00
         tYwFzIRFBQuZfodb4RcUqhemYqKT1PP7eM9ER07UXvytmeqYaTcdvzrnD64Zk546bmGD
         Aew+c0/xmqU2F/eu081wTCgsII0IbcrngVUos7VeUxMQZGJ4KokTq6wdAlpQpAcz/kiJ
         /2ZzEgD34GqSsZkq3UJZ8td+ZS6NqAq1WXnf5pxIzpA3caJrfkbiGwXmdkc3qgTYxt+b
         bdfHU6wHE0LGf4taEFYaorLALzUiCIVEILDLEA5JWks2fCIN6rRFNw+2m8K158Y5YF/8
         KKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=thj1BoXoGMeSHAdBPBMoK98neQzwJz/6ggZg50/Ws2w=;
        b=oTfCF3kYN0l/pqs6xq31usqzywFHuUTe4kwcW5nhKYM2iKFXHlpP0yrwBI9AhqMUBk
         ztEHlnxFTEaxCubE9LrVZXpstBP5fWGYf36OkMl4/QH6DL6fdlKtPCKBtbdBPe3qAlIR
         LokyGvIP3Cn4sNBzLh4O9WEKJQAbe3p+2Bk6eroNk47Mwc9RiWJ5ZMEJTkSF3olThCuz
         dkKmFRzW0Eib/+B/Ab0UUMNmCCEqRWpI1OCD9NHN36Qz/mvnvutlPCr7K+1QURfhRyDB
         k8dFpV/LHEuw0uCs4d9J1cWaKA9Hk8x/LlamPt1G5TwQC7vxigM9IxjJG0D9wMmGaE0U
         OSgQ==
X-Gm-Message-State: AIkVDXLMWvIdZ7XLA9dqlMAMh21ehUlFfZOSAE3Y8MhyRv04uzrMz3gtB6NeIyNdPJyeeA==
X-Received: by 10.25.38.1 with SMTP id m1mr28827570lfm.102.1483708743481;
        Fri, 06 Jan 2017 05:19:03 -0800 (PST)
Received: from aaberge.net (kramer.samfundet.no. [2001:67c:29f4::72])
        by smtp.gmail.com with ESMTPSA id y25sm19162209lja.13.2017.01.06.05.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jan 2017 05:19:02 -0800 (PST)
Date:   Fri, 6 Jan 2017 14:19:01 +0100
From:   Trygve Aaberge <trygveaa@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: Regression: Ctrl-c from the pager in an alias exits it
Message-ID: <20170106131901.GC15009@aaberge.net>
References: <20170105142529.GA15009@aaberge.net>
 <20170106064032.eqxxer5mx5hsh2md@sigill.intra.peff.net>
 <20170106064752.iccrk656c6k2wrfy@sigill.intra.peff.net>
 <20170106072602.wkbzho5z3osz5hee@sigill.intra.peff.net>
 <20170106073224.5hsrib77tx5tgx7d@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106073224.5hsrib77tx5tgx7d@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 02:32:25 -0500, Jeff King wrote:
> And here's a patch to do that. It seems to work.

Nice, thanks! This works very well for me too.

-- 
Trygve Aaberge
