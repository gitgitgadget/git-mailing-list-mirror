Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D2FC1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 02:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeI1JBx (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 05:01:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45989 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeI1JBx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 05:01:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id m16so4631673wrx.12
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 19:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RxKmpg0vU3Nq7Nx1qvCOSy8XmdGTPRPnp/3PBgdaf9M=;
        b=DGsDCG2tdvVCXdXtCV0pXW2PsbKQJNdekcgRFOi9UEE6mtZZIc/+0fbBD2MtN5U1Jm
         9oxKUHjTtasma6qYNOilqv92/qAbNztRkV8VCSp/BKNXR4Q8yf2vxZvPLRNzDbVS+cSb
         gIWKafja+x5gnci0xrQbB/nTrqy3KXTiSM8/6e9OjbeyS+PdUjn+Nor/++QhuKXGUFdi
         UOql90CGk37Rl26BWh4MubnJJ+He0yemYtrtUX8F9HgiUXn1VxVRf6uZdfKhEXJ9MSwY
         8iha5BLrl01bitEX3HWeU5Y2YuSr0QeTarqhZ8n2sxAa4mbGtsnMS/itL0M1BpeDgKLr
         qahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RxKmpg0vU3Nq7Nx1qvCOSy8XmdGTPRPnp/3PBgdaf9M=;
        b=hPoCh8BPtXe2TCxWh50uBtvmLZsBX1Hin9TV4OXKmGyOb0YlIOeKguHoY4db7GgNDw
         nFKW6JwaYP/bakDh/R3CzRdDBqZXEQb4YxMKOmMs3YgRWxW/KlQla3qpyPefkl0CnIq3
         4OeTQ/dB2qP2Kk5e6Kn7bKBVjMLJg5WZGp7wu2a0IRWGhNLA8R1ItSiGS5uZG2ZszpSF
         lYfqgsL68Z3cXZRzOKuHSF6hhwYKjz5njwDyGxI+E2tt2KNeMcYQ2Wj00jlwfPynVYRM
         SLKfzgjlLkvc9MLNltd0ZkIpmtnKxIIu1TfYRoofg/ViTHT6KIR92pxGl3yjLkswGLhu
         m7VQ==
X-Gm-Message-State: ABuFfogd/+B+w9/+YmwHNGRrr7ArHclUoQLVrzyaq5QUcWtVsQuE/45V
        +7nGNAV54bYA20XsOqvKHi8=
X-Google-Smtp-Source: ACcGV62bAPNaw90F33nEcMupNob5zr9b+5lIcXAEH4pWIQvCEL2HVGOZxNmbhLTQBrwDXhjfgdFLKg==
X-Received: by 2002:a5d:4b52:: with SMTP id w18-v6mr10370928wrs.87.1538102425722;
        Thu, 27 Sep 2018 19:40:25 -0700 (PDT)
Received: from localhost (x4dbd8656.dyn.telefonica.de. [77.189.134.86])
        by smtp.gmail.com with ESMTPSA id s24-v6sm572659wmc.7.2018.09.27.19.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 19:40:24 -0700 (PDT)
Date:   Fri, 28 Sep 2018 04:40:22 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH v2 1/5] split-index: add tests to demonstrate the racy
 split index problem
Message-ID: <20180928024022.GQ27036@localhost>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180927124434.30835-2-szeder.dev@gmail.com>
 <20180928004843.GP27036@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180928004843.GP27036@localhost>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 02:48:43AM +0200, SZEDER Gábor wrote:
> Junio,
> 
> On Thu, Sep 27, 2018 at 02:44:30PM +0200, SZEDER Gábor wrote:
> > diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
> > new file mode 100755
> > index 0000000000..ebde418d7e
> > --- /dev/null
> > +++ b/t/t1701-racy-split-index.sh
> > @@ -0,0 +1,218 @@
> > +#!/bin/sh
> > +
> > +# This test can give false success if your machine is sufficiently
> > +# slow or all trials happened to happen on second boundaries.
> > +
> > +test_description='racy split index'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup' '
> > +	# Only split the index when the test explicitly says so.
> > +	sane_unset GIT_TEST_SPLIT_INDEX GIT_FSMONITOR_TEST &&
> 
> Please note that this patch adds another use of the environment
> variable GIT_FSMONITOR_TEST, while the topic 'bp/rename-test-env-var'
> is about to rename that variable to GIT_TEST_FSMONITOR.

Hang on for a sec.  I unset GIT_FSMONITOR_TEST in this test, because I
saw that 't1700-split-index.sh' unsets it, and I just followed suit.
But come to think of it, t1700 has to unset it, because some of its
tests check the index's SHA-1 checksum, and the FSMN extension would
interfere with that, of course.  However, that's not an issue for
t1701, because none of its tests care about the index's checksum, so
unsetting GIT_FSMONITOR_TEST is actually unnecessary here...  unless
it could have other side effects that I'm not aware of.

