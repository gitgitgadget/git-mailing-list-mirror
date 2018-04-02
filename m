Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8D21F404
	for <e@80x24.org>; Mon,  2 Apr 2018 17:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeDBRyR (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 13:54:17 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:38538 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeDBRyP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 13:54:15 -0400
Received: by mail-qt0-f174.google.com with SMTP id z23so15677598qti.5
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dzkGnLYZQINMPpVe3P/33UFeLaODojCwoGjMumn+Xp4=;
        b=QInqtm2ffi0DB+Q6b95bZUARAd+7gtHcjMA+ptBeeseJV2mVvNCuNVNPcBKC9nmy3i
         MO3NWKniAK1fjeuiI5Des07t9kH1CrpGrndSrh870znxXmy+5N0ykehw7yCg0WATmp9E
         kO0N0Bg29wUAoO55RB5JqO9/d+h6Nnvv0nz4BfHo+q87WlAKvTtFH3LfDYMz4vxYZmH9
         0fMWgHSZGJskZNBdPKMq3MUuEHewPxxIYDw1qv7GCCF4wJIGGMbB6iu/VaAUc1GDDcdc
         u9t8V8No2DpgGzFOQOuGb82jTNzVv5NZceiEEOChMpzqv5cQ0GNfyWp3lexkK76wD43u
         LD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dzkGnLYZQINMPpVe3P/33UFeLaODojCwoGjMumn+Xp4=;
        b=bNvoL2hNGHKffC3FIBklDVZboCZsyy6hfcju2RlVubqCLaQtz/NLcIPTQzSi93spzU
         UaEtqx2bniP33BhLCW7xSsCmxoop/E261AzQ8iuzT4lB9YdxLG5MZu5xp2pzNY6jMkkr
         MPS25ohE/JsBnrDFk5ZU0q98IebeGO+gThokPxGYAd9RpTehmR/4ocnNMG9vAMxMJjJl
         MPbNThVgn2H4OAUZpAjfW5WOiYba90st4V9bLMv6swVbE2YaNXFVpQsxHCzFtlrgOfIm
         4OjCirm9ICoxa+EUKCG82fIagmF7+HpzCdYD8TrIZPgB6rFf9RCn5+9YMdEnB61NZRzM
         y+zw==
X-Gm-Message-State: ALQs6tBp38aRtWE+DrTdZzrmwzdCVNuBDLI9Oe8s2ObXldzHBK53CGv3
        xXsUTL6omvPOVUUEUsbZleE=
X-Google-Smtp-Source: AIpwx48f9bZvcoQRF6VFOkc0hVqymwsS4Tbr2/wgeitEx3I5rNGiuJ65L2GvoBYBJeJsc8Qmk65MMA==
X-Received: by 10.200.34.57 with SMTP id o54mr15437719qto.117.1522691654021;
        Mon, 02 Apr 2018 10:54:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id y58sm739119qta.42.2018.04.02.10.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 10:54:13 -0700 (PDT)
Subject: Re: [PATCH v4 00/13] Serialized Git Commit Graph
To:     Stefan Beller <sbeller@google.com>
Cc:     Jakub Narebski <jnareb@gmail.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <867eptkeeq.fsf@gmail.com> <f5d8934e-afc2-39d4-b7d5-e5ba5e5021a1@gmail.com>
 <861sfxekeo.fsf@gmail.com> <d3060103-7fab-3b6c-e968-cb49f3f23acb@gmail.com>
 <CAGZ79kaoDNNcu8zqaTnoXWfJ0FnLwqvZfOHUniG-izndAjvDVw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <17430580-aae6-8693-c4c9-0935104bc535@gmail.com>
Date:   Mon, 2 Apr 2018 13:54:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaoDNNcu8zqaTnoXWfJ0FnLwqvZfOHUniG-izndAjvDVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/2/2018 1:35 PM, Stefan Beller wrote:
> On Mon, Apr 2, 2018 at 8:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
>>>> I would be happy to review any effort to extend the commit-graph
>>>> format to include such indexes, as long as the performance benefits
>>>> outweigh the complexity to create them.
>>>>
>>>> [2]
>>>> http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.719.8396&rep=rep1&type=pdf
>>> The complexity of calculating FELINE index is O(|V| log(|V|) + |E|), the
>>> storage complexity is 2*|V|.
>>>
>> This would be very easy to add as an optional chunk, since it can use one
>> row per commit.
> Given this discussion, I wonder if we want to include generation numbers
> as a first class citizen in the current format. They could also go as
> an optional
> chunk and we may want to discuss further if we want generation numbers or
> FELINE numbers or GRAIL or SCARAB, which are all graph related speedup
> mechanism AFAICT.
> In case we decide against generation numbers in the long run,
> the row of mandatory generation numbers would be dead weight
> that we'd need to carry.

Currently, the format includes 8 bytes to share between the generation 
number and commit date. Due to alignment concerns, we will want to keep 
this as 8 bytes or truncate it to 4-bytes. Either we would be wasting at 
least 3 bytes or truncating dates too much (presenting the 2038 problem 
[1] since dates are signed).

> I only glanced at the paper, but it looks like a "more advanced 2d
> generation number" that seems to be able to answer questions
> that gen numbers can answer, but that paper also refers
> to SCARAB as well as GRAIL as the state of the art, so maybe
> there are even more papers to explore?

The biggest reason I can say to advance this series (and the small 
follow-up series that computes and consumes generation numbers) is that 
generation numbers are _extremely simple_. You only need to know your 
parents and their generation numbers to compute your own. These other 
reachability indexes require examining the entire graph to create "good" 
index values.

The hard part about using generation numbers (or any other reachability 
index) in Git is refactoring the revision-walk machinery to take 
advantage of them; current code requires O(reachable commits) to 
topo-order instead of O(commits that will be output). I think we should 
table any discussion of these advanced indexes until that work is done 
and a valuable comparison can be done. "Premature optimization is the 
root of all evil" and all that.

Thanks,
-Stolee

[1] https://en.wikipedia.org/wiki/Year_2038_problem
