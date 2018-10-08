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
	by dcvr.yhbt.net (Postfix) with ESMTP id 32BED1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 16:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeJHXyV (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 19:54:21 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40436 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJHXyU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 19:54:20 -0400
Received: by mail-wr1-f45.google.com with SMTP id d2-v6so17114754wro.7
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9IZjOquFIjh2bNecPCOctug2+JP3YlADFR36TwTfvxY=;
        b=PMkYOS6tIzzPFPB5+6hyVhImju8ZAa5unger22/VQOlkOOGV9ICvt2WsxE0TJA4/06
         ZVuyIGbXYRgvLFOT4CAFOmBqZM3EligwGWK7bpNLUXip3PkPp9xBqXKHBZNvP0T5a9WF
         b75oJ96GgsGSdOgrIzROHGemoM9nJYIf19Ca6WZj/Ug+2+ZHgMkywfUzLPW+ifbi/Ncl
         ZbGvdSZbh2XGrTlzdgND2JZ6A4VaZ5SnVChN9dXh64pZBISvFGxjZNIMjDbCAxHJK3i0
         4sOc27VeJhLtuHZg6kpZ2Ksx1yPxwBvSCZ4iHZ+q2TAXjYOLrGCRjzrB9Z/jvAOYpXMT
         YW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9IZjOquFIjh2bNecPCOctug2+JP3YlADFR36TwTfvxY=;
        b=EywANzN+pKituigzZ2U6NTNBUDunHqrbdA5XUSTDjHG8o90VeupQ3wEvsAn1k8CSDb
         b3kbIUTyy8PSaymXk1c9UFa/ayb/E4SMA7advlB58Kw1TUgiF8tkTyknVisCYaM4f7Oq
         ncmuXVI+sPY7i/LDgH8hYHCtTPrt/F0lNB52ojPLftt2RtuOSCNZOQTkqY/QjVxpAMXj
         YC6/yWChyOm8QQzkc1weIIjnque5xWk2r80VOsV5Cq2UJ0ZsZ4W9fuuQZaP63Kli5uSS
         ecF7p/mXaLnuZt45FJ4i3PLx/p3ck3P7mds9/UmITSyyuQiA+EqrUhfxfq2AzbEenLJW
         mPKw==
X-Gm-Message-State: ABuFfoixBFiTG9Y0i2wi97okfbAS70uHKxgXsLRXbEGBcrp8yS48XoaJ
        r/KjKjzHE60H6F6oLhC3poM=
X-Google-Smtp-Source: ACcGV62Ll3ok1S8bPJn4uPa+LFwMx/YBrf7Nu1zAFRATvYfIBdvDZjT2lwUqj+pR8dPa2MVAjDCf3A==
X-Received: by 2002:a5d:438e:: with SMTP id i14-v6mr18427970wrq.156.1539016904781;
        Mon, 08 Oct 2018 09:41:44 -0700 (PDT)
Received: from szeder.dev (x4dbd30b5.dyn.telefonica.de. [77.189.48.181])
        by smtp.gmail.com with ESMTPSA id q16-v6sm14137477wrn.41.2018.10.08.09.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 09:41:43 -0700 (PDT)
Date:   Mon, 8 Oct 2018 18:41:41 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
Message-ID: <20181008164141.GZ23446@szeder.dev>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <20181003133650.GN23446@localhost>
 <87r2h7gmd7.fsf@evledraar.gmail.com>
 <20181003141732.GO23446@localhost>
 <87o9cbglez.fsf@evledraar.gmail.com>
 <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
 <87lg7ehnps.fsf@evledraar.gmail.com>
 <20181003185156.GA20709@sigill.intra.peff.net>
 <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
 <20181003191805.GB16666@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181003191805.GB16666@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 03:18:05PM -0400, Jeff King wrote:
> I'm still excited about the prospect of a bloom filter for paths which
> each commit touches. I think that's the next big frontier in getting
> things like "git log -- path" to a reasonable run-time.

There is certainly potential there.  With a (very) rough PoC
experiment, a 8MB bloom filter, and a carefully choosen path I can
achieve a nice, almost 25x speedup:

  $ time git rev-list --count HEAD -- t/valgrind/valgrind.sh
  6

  real    0m1.563s
  user    0m1.519s
  sys     0m0.045s

  $ time GIT_USE_POC_BLOOM_FILTER=y ~/src/git/git rev-list --count HEAD -- t/valgrind/valgrind.sh
  6

  real    0m0.063s
  user    0m0.043s
  sys     0m0.020s

  bloom filter total queries: 16269 definitely not: 16195 maybe: 74 false positives: 64 fp ratio: 0.003934

But I'm afraid it will take a while until I get around to turn it into
something presentable...

