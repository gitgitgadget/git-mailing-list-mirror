Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2549A1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbeHNVqT (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:46:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36884 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeHNVqT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:46:19 -0400
Received: by mail-pl0-f66.google.com with SMTP id d5-v6so8690431pll.4
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 11:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X8qhbPtyGjPgTiPkgKxmYsUOQ6lHsL1Bh2AR3edkkiA=;
        b=MlzUFjGUPT6b/c2tp5mSexwScVADAX1n+h/joXpWm25bXBSNcREunP3Uwy5u9pyqCC
         IWZAqoQ6vvV1kECjQsbbHQXiZfROvzb8HM1wozvWpTPmhrgAXJZyCbW47cMEsk0ZZdkR
         nVgDeSHxVy7FPODDPIEhH3aw7rQ/ya0QbX5/fN2QSt3982DdtdtsjhE4JGdkCUrUGFBo
         hrROadz1BLMQtt4CUmj6/eb7ocOCjsOAoP0Dh2XxPeW3Ddc1+XA40osdn7VtnjtLtMka
         91oUX5hraFnZcDxH7pKPsFf7cCDrBOTucZvSBw8tk3BPcOcyDnNJRsO76tp6AzBBhG7r
         t7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X8qhbPtyGjPgTiPkgKxmYsUOQ6lHsL1Bh2AR3edkkiA=;
        b=rSoUPlAHFJw9Zo3ysgjH9SdLLWtWLaMa96lx0cgjosVcpUVaushrIr0roHSakj7j1A
         GI3KUncYST5Jp+2gIlsLqvs7KKwliOkjWnwMG41j5e9/cicdnpTSZf1yv3/xxueFmx7J
         ltshU4MgWWdjE15T3IJlCynxu9eYwVUWAkkYP8e6SFi+tqra7z25JXH73FvF8zYW5T8M
         6tMpX3LeupWKzogzNvIe8sNVs6JbN8PkXeh5vHbLdSQw3K1pl60C2eNM/JClvVww5unG
         BoFCeun7AHT+89b2mwfiQNMBxVDgRanQ/kKq+ov9gB3JYUD+0lTx1Xjy0Sj5SF2pXZcp
         pGGg==
X-Gm-Message-State: AOUpUlGxXFdsP/eO26Wpzy/vFxAeNqYxJo4WV1sQdhq33b6svcZ0+29V
        +2yTFiatR0eX/3DG9NOcK7Y=
X-Google-Smtp-Source: AA+uWPyjEC+y7J2lEWc/SdeKYKrrSe1WQPxK/pxRk+9XZuOC+6h50PvIx9Ab/jegjhgdDyZrlJXrQA==
X-Received: by 2002:a17:902:9883:: with SMTP id s3-v6mr21560556plp.194.1534273065767;
        Tue, 14 Aug 2018 11:57:45 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id q5-v6sm19558916pgv.61.2018.08.14.11.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 11:57:45 -0700 (PDT)
Date:   Tue, 14 Aug 2018 11:57:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180814185743.GE142615@aiede.svl.corp.google.com>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814180406.GA86804@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:
> On 08/09, Jeff King wrote:

>> One interesting thing about url-encoding is that it's not one-to-one.
>> This case could also be %2F, which is a different file (on a
>> case-sensitive filesystem). I think "%20" and "+" are similarly
>> interchangeable.
>>
>> If we were decoding the filenames, that's fine. The round-trip is
>> lossless.
>>
>> But that's not quite how the new code behaves. We encode the input and
>> then check to see if it matches an encoding we previously performed. So
>> if our urlencode routines ever change, this will subtly break.
>>
>> I don't know how much it's worth caring about. We're not that likely to
>> change the routines ourself (though certainly a third-party
>> implementation would need to know our exact url-encoding decisions).
>
> This is exactly the reason why I wanted to get some opinions on what the
> best thing to do here would be.  I _think_ the best thing would probably
> be to write a specific routine to do the conversion, and it wouldn't
> even have to be all that complex.  Basically I'm just interested in
> converting '/' characters so that things no longer behave like
> nested directories.

First of all, I think the behavior with this patch is already much
better than the previous status quo.  I'm using the patch now and am
very happy with it.

Second, what if we store the pathname in config?  We already store the
URL there:

	[submodule "plugins/hooks"]
		url = https://gerrit.googlesource.com/plugins/hooks

So we could (as a followup patch) do something like

	[submodule "plugins/hooks"]
		url = https://gerrit.googlesource.com/plugins/hooks
		gitdirname = plugins%2fhooks

and use that for lookups instead of regenerating the directory name.
What do you think?

Thanks,
Jonathan
