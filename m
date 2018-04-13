Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A541F404
	for <e@80x24.org>; Fri, 13 Apr 2018 22:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeDMWHN (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 18:07:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45203 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeDMWHM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 18:07:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id u11so11562129wri.12
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KVNd146pkyDYFVAbKzr2WT80M14JMdJ6FsNh82usgy0=;
        b=LEOitm8saXcEgr+IfB2OwmLdgEbiTSSSG4mOmnkIH5GiU33aJt477YPzOHmzprvpgq
         faKWul3yv3jJh3Bg2Wm7KyTsv7XDYfhjI5fwOOsXS3d45xu6WlxupAWfs26m5Yq/55Xt
         J5TDeOZK10TFGtljF31b6zbcIMWsC/WM0L94LjCfOcY2CIxkG265mAvjNbYc+4voGbMv
         WlADpuoAY1jwWPRbyaDOPe4OZDHNOxZ8r5NEJCggvnZ58Dyuy6O6JkgKc5Ew3zq2dyY9
         Cvk+S6i1u+agf21oalByZMM32Yk0jxYOzSH6vOhb08cXZG7St1K7HfZtbnSNio+0ArqB
         0mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=KVNd146pkyDYFVAbKzr2WT80M14JMdJ6FsNh82usgy0=;
        b=JDK08RWRsC3w3DQdjgNJ2t9n/b4EVExH/QkL9/3sZ9hNyZ5zXk27Hz2bx5bNicvj4u
         UZ+/zUMEPjIPP96/Qp2zUEzw48/s/uyFHyixzHfYHY2Mm0t+kZyM91VIPCu9JbFTChtr
         V+2KPcXW9tT6ZRNU+GgpXc9XgCHcDXL+ud3E7cHRpeO17u9lsQvstBNxf5f7LD1G1kqW
         roZ6TT9+48GGqldsCfbtF4mqvLEYjXfpQLUxvv7HEoV3PcitQEuaGJStQoyKBXu1vhYR
         XLc7patNy++/ssdx9cZdP4bPgoZgg9GzOJBtdCn5QBzUF13nVG0butzu3Qxi0HspOyAT
         uaBg==
X-Gm-Message-State: ALQs6tAULjy5XXpLt57Ip/d/f7xi29jM5RVsORezb3+aE0M5ScYRDnyk
        +WrJqOcwb4hn7rQNCBeGw5k=
X-Google-Smtp-Source: AIpwx49535UO7le1gHB1c/yDnJrw3UCZnGM/D4f9WjehPPrH6zKivocS7gVRaTJVRdM3WPZslrdu+Q==
X-Received: by 10.28.132.211 with SMTP id g202mr4880804wmd.17.1523657231727;
        Fri, 13 Apr 2018 15:07:11 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abrf152.neoplus.adsl.tpnet.pl. [83.8.99.152])
        by smtp.gmail.com with ESMTPSA id r200sm1424579wmb.39.2018.04.13.15.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Apr 2018 15:07:10 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v8 03/14] commit-graph: add format document
References: <20180402203427.170177-1-dstolee@microsoft.com>
        <20180410125608.39443-1-dstolee@microsoft.com>
        <20180410125608.39443-4-dstolee@microsoft.com>
        <86zi294fzq.fsf@gmail.com>
        <c2f639ba-4832-191e-03ae-fa893796e2a6@gmail.com>
Date:   Sat, 14 Apr 2018 00:07:06 +0200
In-Reply-To: <c2f639ba-4832-191e-03ae-fa893796e2a6@gmail.com> (Derrick
        Stolee's message of "Thu, 12 Apr 2018 07:28:11 -0400")
Message-ID: <86woxalq0l.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 4/11/2018 4:58 PM, Jakub Narebski wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> +CHUNK DATA:
>>> +
>>> +  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
>>> +      The ith entry, F[i], stores the number of OIDs with first
>>> +      byte at most i. Thus F[255] stores the total
>>> +      number of commits (N).
>>> +
>>> +  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
>>> +      The OIDs for all commits in the graph, sorted in ascending order.
>>> +
>>> +  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
>> I think it is a typo, and it should be CDAT, not CGET
>> (CDAT seem to me to stand for Commit DATa):
>>
>>    +  Commit Data (ID: {'C', 'D', 'A', 'T' }) (N * (H + 16) bytes)
>>
>> This is what you use in actual implementation, in PATCH v8 06/14
>>
>> DS> +#define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
>> DS> +#define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
>> DS> +#define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
>> DS> +#define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
>> DS> +#define GRAPH_CHUNKID_LARGEEDGES 0x45444745 /* "EDGE" */
>>
>
> Documentation bugs are hard to diagnose. Thanks for finding this. I
> double checked that the hex int "0x43444154" matches "CDAT".

Another possible way of checking the correctness would be to run
`hexdump -C` or equivalent on generated commit-graph file.  File and
chunk headers should be visible in its output.

> Here is a diff to make it match.
>
> diff --git a/Documentation/technical/commit-graph-format.txt
> b/Documentation/technical/commit-graph-format.txt
> index ad6af8105c..af03501834 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -70,7 +70,7 @@ CHUNK DATA:
> =C2=A0=C2=A0 OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The OIDs for all commits in the grap=
h, sorted in ascending order.
>
> -=C2=A0 Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
> +=C2=A0 Commit Data (ID: {'C', 'D', 'A', 'T' }) (N * (H + 16) bytes)
> =C2=A0=C2=A0=C2=A0=C2=A0 * The first H bytes are for the OID of the root =
tree.
> =C2=A0=C2=A0=C2=A0=C2=A0 * The next 8 bytes are for the positions of the =
first two parents
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of the ith commit. Stores value 0xff=
ffffff if no parent in that
