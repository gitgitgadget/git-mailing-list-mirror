Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2731F404
	for <e@80x24.org>; Thu, 13 Sep 2018 17:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeIMWK6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 18:10:58 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39289 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeIMWK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 18:10:57 -0400
Received: by mail-qt0-f193.google.com with SMTP id o15-v6so6035785qtk.6
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jyNVB/IKFDAnmvbxFjWgXEgAWJ6BEDd9ggc0Ff0Nb/c=;
        b=mFpLxJ+0QugCYGSFzop/Iofm/fbzF357UW9pPyi07qrcHkurWqmAOlSt5FzPFtJKMb
         0VIn6NFJP1JuIr0hVxhmF3QTaRLwlGOjxTY4o7yx5MFFr8wlWDeOYPLMyLCKjKGWVN3o
         v/D7Q9CUBKEVdE5b5L5PGFMi8UgJVBjmq0dceu+U81xTaw/g0UCUaHUwS00i0fsH9N9R
         SzLQaoOIu9aE0MVDhdq1TY5VnbcXaDHfHWz98WzfpmkdiK3KQcWMBMKGNu2x53cwyWz5
         Il7it9Qvvxzy2ZMr766haM68wNU9kxThxN3Z50Mof7ndLXjG2ZcPKRVAqyUDEasetO2J
         74ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jyNVB/IKFDAnmvbxFjWgXEgAWJ6BEDd9ggc0Ff0Nb/c=;
        b=SDquC5Lk08Wny0sPuxG5CPPxIaNUPm8bkUgcipZFdmPc3tf6fDAonGf79PNN7hl4Wr
         W+F1lBeUgWfGA90nnLdDGYt05QCNplAEc3EIzM0GcESfJnpxCy5DePaAX7igR+bRTZzr
         kZsRRS5OFq4+WvSHt7zHMw5O5wVyrDg+fTcG0e5yAT/L5FZivHDyAdxOu596rsXu7a1V
         63dxlUcRgch7vZ81Su/GB54v6IJtTtD7K+zhjGemBa4r8kL/amJEbi4xPI/fRZMiV4jV
         W+LT8RBLSCayzzRMaR1zP0QIEIiUREd7QEMRDgI9u3goJ/5B++9tMx0yBarZ2SFry5XD
         Nkjw==
X-Gm-Message-State: APzg51AQFoQZGBToQV+aZxzJxv/IqjbWmfoiJZK/T7fiIBHgKFyzoL1w
        nQISiCdeP40xWp8pIG4dFjw=
X-Google-Smtp-Source: ANB0Vdb03VX/IX5JHv2dPDdRvwljiHh+PmIypr9gHwyERIRvvc17OhqaGJg9yFMC2WtNgA7D9cjkJg==
X-Received: by 2002:ac8:4457:: with SMTP id m23-v6mr5837560qtn.289.1536858036152;
        Thu, 13 Sep 2018 10:00:36 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d087:f807:1318:50bb? ([2001:4898:8010:0:b9bd:f807:1318:50bb])
        by smtp.gmail.com with ESMTPSA id x26-v6sm2814397qth.15.2018.09.13.10.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 10:00:35 -0700 (PDT)
Subject: Re: [PATCH v5 00/12] Hash-independent tests (part 3)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20180913051742.252276-1-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <abd21e68-ac72-3111-5813-7d47af3d6aa6@gmail.com>
Date:   Thu, 13 Sep 2018 13:00:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180913051742.252276-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/2018 1:17 AM, brian m. carlson wrote:
> This is the next in the series of improvements to make tests
> hash-independent.
>
> A range-diff is below.
>
> Changes from v4:
> * Add local statements to the &&-chain.
> * Fix a typo in the local statement.
> * Add a helpful comment about why test_detect_hash is hard-coded to
>    SHA-1.

The range-diff and these changes since v4 are reasonable. I'm happy with 
the current version.

I'm looking forward to this change getting merged down, as I also want 
to use 'test_oid rawsz' for the 'git multi-pack-index verify' tests that 
are currently under review (v2 imminent).

Thanks,

-Stolee

