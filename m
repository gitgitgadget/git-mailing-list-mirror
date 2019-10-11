Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33EF1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 00:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfJKAtw (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 20:49:52 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38513 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfJKAtv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 20:49:51 -0400
Received: by mail-yb1-f193.google.com with SMTP id r68so2572740ybf.5
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 17:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TgzKpNjc9rqrycOq8GloobxY7jkSoltAeBvE93pwRAo=;
        b=MpcZTz8/B/jTqkJaOUMA+yCEHaDOYDHw5IfOgdIPgeldmHXc9fpJwVtVi4hH5o8Yq/
         Bk5qFszZWwSJ4uo38yO4N7NUS8k1Wsce+Fe71hJmInnWfHTMN1E2ZHMtB1jBGgjlpwry
         q2T9PFrzD5EBIgFH9IELQLRUeD/cBdbUUIYzEhGz3rSGs3+/imtoZruSQTMgnvxZBEeV
         3MMMDdRwKj7Sdo5nkEgVw4COYHjwJJ7JaDx2K6ZYrAJST7a23L9OU9rfc1HX49NbWcod
         Yt4fQ7NVchUx05OhUEvyawUSgfhEAojoVjPruX+EH27WVfsJJTZi7AlEzN7Ny8F4c8PJ
         cUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TgzKpNjc9rqrycOq8GloobxY7jkSoltAeBvE93pwRAo=;
        b=E5B/IkJVH6WNLJXJ8ey9DgMytjF55a1I6HgPlvXliv7rPaJ4Mjbopv9pLHPgpvs/zp
         OrhcySD1ADKDxqI3lHkv+vXciEO5H51SzOqNlR/1Mrg1MuaBmMcsZVUBDuALjlGt0k+h
         R9putWGnl5fTLre7gfUCO8gcDmReCVphvRMi/cwZzovkSxbda3B4K+rAE0wz/7KvSmDG
         MU8x8sCfqTCWFDhjH2MQxvcPJ6J7BN8syLTJ8+qKupE0ca22fg+reDAwqsTKN3A4q4cY
         zqReJB+e9l/VwsMVSH0a28LPKbwezUDMWbZD9zVpySefZjYQlJfYPXCBjMr/vp+wzWT0
         rd4g==
X-Gm-Message-State: APjAAAU649Pe21v99thgq3Y7UOpAQ8rEm9CLODyjSQUHim3Sfmkrw+uC
        QzKiOyboampJoCmfkZWyi2Q=
X-Google-Smtp-Source: APXvYqyzpBAipn5q/fwtLATR3/RkA8IGujU4dS/28PssuL7Zdqhm/hz2pX+zQSQSfPxhYWky4TlEzQ==
X-Received: by 2002:a25:7443:: with SMTP id p64mr8558352ybc.150.1570754990754;
        Thu, 10 Oct 2019 17:49:50 -0700 (PDT)
Received: from [192.168.1.3] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id x16sm2240982ywx.103.2019.10.10.17.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 17:49:49 -0700 (PDT)
Subject: Re: [PATCH 01/11] graph: automatically track visible width of
 `strbuf`
To:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
 <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
 <20191010230550.GA42541@generichostname>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f30ba88a-e9c1-b53e-e2e9-2d87b7531cee@gmail.com>
Date:   Thu, 10 Oct 2019 20:49:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191010230550.GA42541@generichostname>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/10/2019 7:05 PM, Denton Liu wrote:
> Hi Dscho,
> 
> On Thu, Oct 10, 2019 at 11:07:35PM +0200, Johannes Schindelin wrote:
>> Hi James,
>>
>> On Thu, 10 Oct 2019, James Coglan via GitGitGadget wrote:
>>
>>> From: James Coglan <jcoglan@gmail.com>
>>>
>>> All the output functions in `graph.c` currently keep track of how many
>>> printable chars they've written to the buffer, before calling
>>> `graph_pad_horizontally()` to pad the line with spaces. Some functions
>>> do this by incrementing a counter whenever they write to the buffer, and
>>> others do it by encoding an assumption about how many chars are written,
>>> as in:
>>>
>>>     graph_pad_horizontally(graph, sb, graph->num_columns * 2);
>>>
>>> This adds a fair amount of noise to the functions' logic and is easily
>>> broken if one forgets to increment the right counter or update the
>>> calculations used for padding.
>>>
>>> To make this easier to use, I'm adding a `width` field to `strbuf` that
>>> tracks the number of printing characters added after the line prefix.
>>
>> This is a big heavy-handed: adding a `width` field to `struct strbuf`
>> and maintaining it _just_ for the purpose of `graph.c` puts an
>> unnecssary load on every other `strbuf` user (of which there are a
>> _lot_).

I was concerned about this, too.

>> So my obvious question is: what makes `width` different from `len`?
>> Since we exclusively use ASCII characters for the graph part, we should
>> be able to use the already-existing `len`, for free, no?
> 
> From what I can gleam from looking at the code, `width` is different
> from `len` because when we're printing with colours, there'll be a bunch
> of termcodes that don't actually count for the width.
> 
> I think that we should either leave the `chars_written` variable as is
> or maybe calculate it after the fact. Here's an untested and uncompiled
> implementation of something that might do that:
> 
> 	static int calculate_width(const struct strbuf *row)
> 	{
> 		int in_termcode = 0;
> 		int width = 0;
> 		int i;
> 
> 		for (i = 0; i < row.len; i++) {
> 			if (row.buf[i] == '\033')
> 				in_termcode = 1;
> 
> 			if (!in_termcode)
> 				width++;
> 			else if (row.buf[i] == 'm')
> 				in_termcode = 0;
> 		}
> 	}
> 
> If we include this, I'm not sure what kind of performance hit we might
> take if the graph we're generating is particularly big, though.

This is worth trying. In terms of CPU time, this should be a mere
blip compared to all of the commit walking that is going on. (Unless
we get to thousands of columns, but by then the output is useless.)

Of course, we should measure the impact, but it is worth a try.

-Stolee
