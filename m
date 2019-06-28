Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721401F4B6
	for <e@80x24.org>; Fri, 28 Jun 2019 18:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfF1Ste (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 14:49:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37508 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfF1Ste (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 14:49:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so12022025eds.4
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=1FDSW20vZ7PQkFZjdBjBWT3JGfpawjCYaUVeNduSVJ0=;
        b=CLAYsJzWaYsorNmBIXHT+93eZnkdXV9m1BvM68oryUaBJdJi0FABkNB/LgfbQ8DP2A
         oEvsScOEWXN8lYUmBWGlMZwRZdBWw52QYO3n9AFY08fr5MED2xaHAs5GiRO33RRXrUys
         N3EpycnK0g7dIVc7D7wTk2QcU0Xq1BGAFi3Xc77tmrb1runSQVhpnqr8PAGigz9hNQhz
         4mjsMAuM9aO1tC5rTsErpPdzPhkJAr0x07L1+a2MfwhTf3pwkguroW1/dPAQ9ivY6nya
         Fa9lBpEh8YAs12rrqAvhVibSX20xWzb1X+uxN7H+ndSLwN7tKhzhI6Uxd6x+3Rj3nk8R
         srBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=1FDSW20vZ7PQkFZjdBjBWT3JGfpawjCYaUVeNduSVJ0=;
        b=NTMVGEfU7Xt6Qm8Gspi4DmHBOCRLSdZlZuwW0Es7wAm+jMY65Pz7tp4E9EhyyXCO1l
         pyBWlwao2AbC+XEdkRm29839XYhnDzbhr6sqSZIWtxJLOxgyu8MZTmQGNJXzRqlvg9Tc
         LsZojueLnSlmTuj0PbXsTLjFHAbfZs7AtTVjO+79oCJLqODk05LTacxiKTmHLO7CIA4/
         KeomTVjBVnUvvjEgrZ/w8JAvMrjrTXwiy8uLRyT4FcjXK0xvcP9bApHtiq5C2iTUjikk
         df6ZEPdcndS9iRqU7bYTpuxQ9HTUTlTGsl5spp6C/L1pBZkm1j3bTcOg/uP67+whOi4b
         6egw==
X-Gm-Message-State: APjAAAXwtcUt9KsvTohuERQNL1z/zAotvfnnn8IpaFoApZzPAyc0lIC3
        074yS8xux5Zcewzs8rvhhCc=
X-Google-Smtp-Source: APXvYqzovaIk8y5Wq7hgpuJCe1N5/yMP84TroUbyqLw/GgpJvSpwRzjujpvIgrcSH7MoRQ7UZuqaMw==
X-Received: by 2002:aa7:cdc6:: with SMTP id h6mr13199088edw.5.1561747772376;
        Fri, 28 Jun 2019 11:49:32 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id k10sm935248eda.9.2019.06.28.11.49.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 11:49:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] easy bulk commit creation in tests
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com> <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com> <20190628064103.GA19777@sigill.intra.peff.net> <20190628093751.GA3569@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190628093751.GA3569@sigill.intra.peff.net>
Date:   Fri, 28 Jun 2019 20:49:30 +0200
Message-ID: <87v9wp7dfp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 28 2019, Jeff King wrote:

> On Fri, Jun 28, 2019 at 02:41:03AM -0400, Jeff King wrote:
>
>> I think this would exercise it, at the cost of making the test more
>> expensive:
>>
>> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
>> index 82d7f7f6a5..8ed6982dcb 100755
>> --- a/t/t5310-pack-bitmaps.sh
>> +++ b/t/t5310-pack-bitmaps.sh
>> @@ -21,7 +21,7 @@ has_any () {
>>  }
>>
>>  test_expect_success 'setup repo with moderate-sized history' '
>> -	for i in $(test_seq 1 10)
>> +	for i in $(test_seq 1 100)
>>  	do
>>  		test_commit $i
>>  	done &&
>>
>> It would be nice if we had a "test_commits_bulk" that used fast-import
>> to create larger numbers of commits.
>
> So here's a patch to do that. Writing the bulk commit function was a fun
> exercise, and I found a couple other places to apply it, too, shaving
> off ~7.5 seconds from my test runs. Not ground-breaking, but I think
> it's nice to have a solution where we don't have to be afraid to
> generate a bunch of commits.

Nice.

Just a side-note: I've wondered how much we could speed up the tests in
other places if rather than doing setup all over the place we simply
created a few "template" repository shapes, and the common case for
tests would be to simply cp(1) those over.

I.e. for things like fsck etc. we really do need some specific
repository layout, but a lot of our tests are simply re-doing setup
slightly differently just to get things like "I want a few commits on a
few branches" or "set up a repo like <that> but with some remotes" etc.
