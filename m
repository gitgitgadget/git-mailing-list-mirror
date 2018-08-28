Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066601F404
	for <e@80x24.org>; Tue, 28 Aug 2018 17:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeH1VEk (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 17:04:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46462 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbeH1VEj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 17:04:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so980553pfn.13
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cehGPGtI2APi9Nr/AdIuxAb0/nBgEYnQc/itSnrdGTs=;
        b=me9GEv/Ljb6m/A44n9TPVbZj/Ghz7BiRmp+zFwZYdif9opza47Z/tI/1KJAbZJ34VW
         e7gzLESaIBXyuJKuP+ax7CMQreYv2k4lF/+7IF43zQyLDp8rDK60LTxdwL11dIcS5c/t
         vTMtXSOS/OEMzQUtVWVXpQN8EicyrtaB3VPvBUpKty+iMz6kZUadA2j3bjrIOcUybctX
         A2WhVO7EI5gSx8wtVwRk/cgrJbkXYhujkxROLRJ6XoGsaotJZYvyg13Vj/M20l5xzt9J
         LoyOZRsWuQXn3dIjaIlpFm/5LBsiIXCmsczY59/VC1X6O2xy4p/K1G0PAN0N9y2Vj9Bc
         QCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cehGPGtI2APi9Nr/AdIuxAb0/nBgEYnQc/itSnrdGTs=;
        b=uGVMiyX999PaoLisCOs2QsMozOo1zCRtmN3B97oxE6cp3bDvHCCsr1UuPY3fUuIXFd
         qeZW3iNr38UpjQc2J0HbUI2fxTKt6rA+AysSomPqLpJqeNCHpfzg2r3o4FSA43i/oFN9
         0YgolLd/iKaPMxXneCzZbWHkC49AUvbQOJuqQcMLByOc2OS2visLDudq7xx15ZTvKfMB
         xL+mzZssINy7YOY5mXYCWm4iJqpou+vvJiKIxqnEopulwZUAde4pgZms3A23bFgwBZWo
         f64TOuLd1DjDJBpUw4WcDMQPjACN7S+qwkEfsnfk3DfwcrI9QutN4dj4kobCtcJtfWZB
         f7Gw==
X-Gm-Message-State: APzg51B03Em4onDShHnC1bTALbUBXN2jv2KVWoMxmAHpv7nhLcTzoRGb
        olLBRdcrFyD/TVaun2/+7t4=
X-Google-Smtp-Source: ANB0VdbmEzLxo+8iCBnhBlTwpV87M4oa7pDBqWuVriEu+P/vq5Uq8a9R0sm8cjcBuQMowdyFzQRy+A==
X-Received: by 2002:a63:7f08:: with SMTP id a8-v6mr2407537pgd.296.1535476322472;
        Tue, 28 Aug 2018 10:12:02 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d9-v6sm4786092pfb.86.2018.08.28.10.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 10:12:01 -0700 (PDT)
Date:   Tue, 28 Aug 2018 10:12:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: Questions about the hash function transition
Message-ID: <20180828171200.GB23314@aiede.svl.corp.google.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
 <20180824014703.GE99542@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1808281402510.73@tvgsbejvaqbjf.bet>
 <c098b0c6-1062-6581-81a9-7ce15f3738de@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c098b0c6-1062-6581-81a9-7ce15f3738de@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:

> I'm not super-familiar with how the transition plan specifically needs this
> mapping, but it seems like a good place to put it.

Would you mind reading it through and letting me know your thoughts?
More eyes can't hurt.

Thanks,
Jonathan
