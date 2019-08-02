Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F131F731
	for <e@80x24.org>; Fri,  2 Aug 2019 23:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389568AbfHBX0E (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 19:26:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40459 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389345AbfHBX0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 19:26:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so36779859pgj.7
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 16:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9ooLMIw1lN0J2ltUP3ylwsKK4Cvyo16SX2G4NTiM0dI=;
        b=PfJFhpg75tz86SnGKte59t4cjHWkOjVIzgGRAnq6moQdS32qjvgiDeFI7U5zWRaElK
         ByloqtPeuXmRCewoUATTeSjh8XychIpqB5Ogs0Nah4at1sXJTOossgu17tpJ0u0D+9im
         dK1nPSsVoXLQ69mBdMFHRWlbMH1V3fA985zm5RofGu2KguM7MHnzAbnDgHhOMDuqbg4o
         c0Jytk0dYoV4tGWmO7ITjY0ZjGp5lqjxuEnqNaxJNqq3DBgEBo2oLYLOqqQJnL5JF7Na
         I9eF0/eDL1xYBx47RjKFgY/Js6SCS5INdkpwBU/iV26tWjwoUpT3+EUV9Eq3aYvaHMSn
         XsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9ooLMIw1lN0J2ltUP3ylwsKK4Cvyo16SX2G4NTiM0dI=;
        b=X1s3gf6rydQSx03N63De+vVy3qcOJoPz1Fy8aST8MkQphNrXFnGR3lFo48MhbSBtyr
         V9ZrtwPdhO6J59qLY2shZ+Rfy4DoenjiafXhhuUMwzfDGf6bQVKpWPrrbV/ZX0WIY2BP
         iR5MPEniprCxhtLtszCWPEQfdZkoY5cXjlvJCotvKHXbQVm1zfn3Fk0R11ijx6uWYyQA
         90ULE+0X4hDSqHWNM6qNaTBu6EQH+vTQVZ1DghyyZ/1uLsI5kLWyvuTwjajPHRC8ptvz
         pnxiSbl1Lp1guKelGyVZ3I7acpyo6SlD5m8/2JPkVWFB3Bx6eYCfi+2aMcV0A/hAk5Hn
         0TNA==
X-Gm-Message-State: APjAAAX3nA1I/Gaql6GMceIvEtaRiKwPGDzkw/0xlzkclz8hJ+ErpNaV
        mxU97MbcB3yelC74xcSI6iQ=
X-Google-Smtp-Source: APXvYqzclc1B0kVU+WWtBiTOW42qTQ2iQQ+h4MTtiHaKeH/rsBGZJlRRDrF2eFHeUjbrppltVzu12A==
X-Received: by 2002:a17:90a:8a84:: with SMTP id x4mr6469959pjn.105.1564788361811;
        Fri, 02 Aug 2019 16:26:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id t8sm7736150pji.24.2019.08.02.16.26.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 16:26:01 -0700 (PDT)
Date:   Fri, 2 Aug 2019 16:25:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, git@jeffhostetler.com, avarab@gmail.com,
        peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190802232559.GC109863@google.com>
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
 <20190725234229.GM20404@szeder.dev>
 <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet>
 <20190726220348.GF43313@google.com>
 <20190801180829.GP43313@google.com>
 <20190802015247.GA54514@google.com>
 <nycvar.QRO.7.76.6.1908021347580.46@tvgsbejvaqbjf.bet>
 <20190802165913.GA109863@google.com>
 <20190802193849.GX20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802193849.GX20404@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor wrote:
> On Fri, Aug 02, 2019 at 09:59:13AM -0700, Jonathan Nieder wrote:

>> In the short term, we can run tests internally to check that Git keeps
>> following the schema.  Let's not block patches 1 and 2 by this ---
>
> To my understanding patch 2 is only a proof of concept: it starts
> using a programming language that has not been used before in this
> project, to implement functionality that is readily available in
> several existing tools, without even arguing (let alone convincingly
> arguing) in the commit message why this approach is a good idea.

Well, Golang has been used in contrib/ before. ;-)

If I understand [1] and [2] correctly, we haven't found an existing
standalone tool that is able to efficiently validate a high volume of
traces.  But for the purpose of sanity-checking that running a few
typical commands generates a trace that fits the schema, it's not
important that the validator be super fast.  So we can use a tool like
jq, picking one using the criteria that it

- allows performing the validation without too much fuss
- is likely to already be present on some developers' machines

Thanks,
Jonathan

[1] https://public-inbox.org/git/20190726220348.GF43313@google.com/
[2] https://public-inbox.org/git/cover.1564009259.git.steadmon@google.com/
