Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3001F404
	for <e@80x24.org>; Tue, 10 Apr 2018 19:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeDJTS3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 15:18:29 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:46679 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeDJTS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 15:18:29 -0400
Received: by mail-pf0-f175.google.com with SMTP id h69so9075570pfe.13
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0Pk80ox78/kkQ03qLtS4mbN1/AQ8KZGvLCLdi6hj2lY=;
        b=BsfthOqjcLnpwmBGmtjVIKXM3p77l7mC6jVVblO+rsgwR9zOAKCAbLjFHdNFgYbq3t
         xEqRfubMB8sv0f7gXhxjXpDiohDEudfzzd1H2PpVfQ4yIm0IYaEiEAcIssuQOcssIjaC
         I7h2nx4cokJDTiiyEVQAOs313Fy7U7h1zCQrtBIeiAtXL1WIkIrKB6abA4URnQQxDZZB
         7AoQhVayWk9lOVRORC+XscwFLMuzUsDJWVGAZ+J8Ey2b3qVVRrp0Q1tOhH8t6hMp6YuB
         PMdGN6h3Z5eTUXCGdkDMinFEALNhvc4PZTygXi7TGXl8Itl0SjcKQCD2HPAVhe/Sw0eU
         Eb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0Pk80ox78/kkQ03qLtS4mbN1/AQ8KZGvLCLdi6hj2lY=;
        b=rzIXByNdpBgeb1NTNTTlxSltWiaUKo3zfxe9lQrihTpGZ6Ak8zx5yDnOtRpCSVDnIf
         H2Q5+oKByjnIIA9CQJEjLc0Cu405QDBe8We4FgNUsrUf7WB2PeFjkog1rvvG/ZK56FuA
         Ptp2H7UWoIWpANojhIHz2Lh4a2S4GaavsTzMkvDDWg7iW32Lgt2wSaVkf4yNrKd8bWLg
         cnSP8KoTT20Zn7/RdyrBjYDcN20kckQil/yHS8Td7noV/tYUtE5poLbOfPcqug8vB7tg
         9gJV370Cq1MUj8A1+TaMMYfUwjgJAT4I1mmBmhPHLaOjN9ju2le5fzMq/hC12PrZJMZB
         wjcw==
X-Gm-Message-State: ALQs6tA1F643myLf0aeGy7ClG/nsejhKOGgPWXKA0jSLEzsW/eXzRWvF
        DJJbkjkT4Lm1wNL/dF+cisQETIXwXqA=
X-Google-Smtp-Source: AIpwx49blYAME44Bf3e2Q4fKpkTKdXvSD9Y25Gi4fgxaQtvTzHMY7LG9tz8Q1vfzYqgxv3mHu6VmDQ==
X-Received: by 10.98.107.138 with SMTP id g132mr1350937pfc.163.1523387908317;
        Tue, 10 Apr 2018 12:18:28 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id l64sm5756478pga.33.2018.04.10.12.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 12:18:27 -0700 (PDT)
Subject: Re: [PATCH v8 03/14] commit-graph: add format document
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com>
 <20180410125608.39443-4-dstolee@microsoft.com>
 <CAGZ79kYDXTGdS8sx-iW_JNdk7icpwdd3Opwbjw1cL8gMs_47dw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f08076ac-2c89-561e-b4ae-192dd9c50dc2@gmail.com>
Date:   Tue, 10 Apr 2018 15:18:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYDXTGdS8sx-iW_JNdk7icpwdd3Opwbjw1cL8gMs_47dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2018 3:10 PM, Stefan Beller wrote:
> Hi Derrick,
>
> On Tue, Apr 10, 2018 at 5:55 AM, Derrick Stolee <stolee@gmail.com> wrote:
>
>> +  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
>> +      The ith entry, F[i], stores the number of OIDs with first
>> +      byte at most i. Thus F[255] stores the total
>> +      number of commits (N).
> I was about to give this series one last read not expecting any questions
> to come up (this series has had a lot of feedback already!)
> Although I just did.
>
> What were your design considerations for the fanout table?
> Did you include it as the pack index has one or did you come up with
> them from first principles?
> Have you measured the performance impact of the fanout table
> (maybe even depending on the size of the fanout) ?
>
> context:
> https://public-inbox.org/git/CAJo=hJsto1ik=GTC8c3+2_jBuUqcAPL0UWp-1uoYYMpgbLB+qg@mail.gmail.com/
> (side note: searching the web for fanout makes it seem
> as if it is git-lingo, apparently the term is not widely used)
>
> I don't think we want to restart the design discussion,
> I am just curious.

I knew that I wanted some amount of a fanout table, and the 256-entry 
one was used for IDX files (and in my MIDX RFC). With the recent 
addition of "packfile: refactor hash search with fanout table" [1] it is 
probably best to keep the 256-entry table to reduce code clones.

As for speed, we have the notion of 'graph_pos' which gives random 
access into the commit-graph after a commit is loaded as a parent of a 
commit from the commit-graph file. Thus, we are spending time in the 
binary search only for commits that do not exist in the commit-graph 
file and those that are first found in the file. Thus, running profilers 
on long commit-graph walks do not show any measurable time spent in 
'bsearch_graph()'.

Thanks,
-Stolee

[1] 
https://github.com/gitster/git/commit/b4e00f7306a160639f047b3421985e8f3d0c6fb1
