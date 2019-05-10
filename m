Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF571F45F
	for <e@80x24.org>; Fri, 10 May 2019 16:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfEJQi4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 12:38:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42813 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfEJQi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 12:38:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id d4so4039733qkc.9
        for <git@vger.kernel.org>; Fri, 10 May 2019 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PCfojCPgvoeNUMHmN2y1KddwPFNgDcud1oTwCEsxe9A=;
        b=mEEiUzg+Ld7aq8lT2lDjBUAMBGi2veEuFeg5uNibY3EurWZYMLK3HgeUyz5bIzkzYN
         NwMY1m6fTD36LV+CMlpUgRAHmdBnMzCOsLKVVxq9wRsBdaSkOh3Imcm3r8NpdoQHhuG6
         pMDuSdRlpB+8dxjmo8V1Q6QGxTci32+d6oph0NzpQn+a8C3vm1XYTC+Y8BJkaKh8kEoX
         rDZetpuL1sciYDNcGkBRNR4HhTbO7VhhxpfsqcI7mhNBRSA/4OpGF6XwkSCJ9bZaRijz
         Ip2SonA0NaZBs6pjrYBdLLgN4fFmBMuXSqxtps1AmhxW8qQMBCcdNpWrJVye3MUR/HsS
         JSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PCfojCPgvoeNUMHmN2y1KddwPFNgDcud1oTwCEsxe9A=;
        b=rI/DuqNsJg0LBASI4alFd2y7ucra1vTnNr/mioXsSn2ppGTGah/osgt7Hnqe75Kakd
         hTXR622yeZZHnNKlN+itIbzivj51iXYsK+b9Z3g8SzI4LFTN+KE8qmgCWQ7PdA9esO11
         m9hzYW/72SSNNfUfw3mdbNysdTn/H4sJVCBGJjS2f+uovnlpwKx6A5NwezAVA8CpvLE8
         +0nxX+TFS/GBIskN3Q2t3n+ybK/uZO8+knxU4GAxJYZ8U+NQ87vDwmOlLojCOAahF6Po
         KvuWZf8JbTZ36eH9vSmjgj8vzYj5zIpzRDxUf2uF3XVsIa/vYFL0C7OXzosejvu6deRh
         zjDQ==
X-Gm-Message-State: APjAAAVH+DZ68yDZiIUOEgUnjcz/HFC/1+UsKsZ1j5ZsNb7/DGhxEmcA
        84nm7jggfwNGpU5VEhETPlA=
X-Google-Smtp-Source: APXvYqz3T0vd0jvZr+E0PDG1uSbLezeXEk5LW9hNA8MlJFyEqG+nDlsOg7N1T4YVwUXZWMb3WZ3Caw==
X-Received: by 2002:a37:8885:: with SMTP id k127mr9687435qkd.59.1557506335070;
        Fri, 10 May 2019 09:38:55 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id 20sm3460808qtu.51.2019.05.10.09.38.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 09:38:54 -0700 (PDT)
Subject: Re: I made a flame graph renderer for git's trace2 output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <87zhnuwdkp.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8794fd2e-6256-3238-6d87-2e726d4a91fa@gmail.com>
Date:   Fri, 10 May 2019 12:38:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <87zhnuwdkp.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/2019 11:09 AM, Ævar Arnfjörð Bjarmason wrote:
> Here's a flamegraph of where git's test suite spends its time on my box:
> https://vm.nix.is/~avar/noindex/git-tests.svg
> 
> I hacked up a script for this today to plot trace2 production data, as
> noted there it's at:
> https://github.com/avar/FlameGraph/tree/stackcollapse-git-tr2-event
> 
> What are flamegraphs? See http://www.brendangregg.com/flamegraphs.html
> 
> As noted in TODOs in the script there's various stuff I'd like to do
> better, and this also shows how we need a lot more trace regions to get
> granular data.
> 
> But it's already quite cool, and I'll keep improving it. I'll submit a
> PR to Brendan's parent repo once I'm happy enough with it, I figure it
> makes more sense there than in git.git, but maybe we'd eventually want
> to teach the test suite to optionally use something like this.

This is a neat idea. Thanks!

For anyone else giving this a try, here are the steps I took to create
my own [1], much smaller test:

# run some tests
export GIT_TR2_EVENT=~/git-tr2-event.txt
git fetch --all
git gc
git push

# get the FlameGraph repo
git clone https://github.com/avar/FlameGraph.git
cd FlameGraph

(
    # Get the proper perl packages, if you don't have them
    sudo apt install cpanminus
    sudo cpanm install JSON::XS
)

./stackcollapse-git-tr2-event.pl ~/git-tr2-event.txt | ./flamegraph.pl >git-test.svg


[1] https://github.com/derrickstolee/FlameGraph/blob/git-test/git-test.svg
