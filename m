Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC411F404
	for <e@80x24.org>; Fri, 26 Jan 2018 13:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbeAZNNS (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 08:13:18 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:38454 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeAZNNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 08:13:16 -0500
Received: by mail-qt0-f170.google.com with SMTP id z10so1095820qti.5
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 05:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GswvuQUPYzjb9uppiBSXGu08puDK6ov15/Sjf0UtKkU=;
        b=fWl/rxBSlke7whod/Cit95pvGmyG7B+oxPtToAYXcdM6lOwIhmVnweb79y+Hkcu+KM
         rHvhRF79llEMECTKYvz8sS3kfoZ0u/LFn1FoQlg8jT4yFUh4ZEOg8KaJYymCa0+V6etk
         qch0ET0mbNdGC4WR+9/gmzJegD2B6oMcvkYhkr8wfksTm2lblZ5ZIehZlzPn3ypgjHZy
         iGs7aQ9mdIDvxM3XqIwP24c6G79aIwQwhRgYb7svsLMqQo9bKbFgjVnqA4A4b9Cj9/JS
         PkwnhnDO8j2Hnyx7fVdAxUQw8W95h2AgFLtlY3YpvmsNelXbMLaaBIY38tGcDfwRaiYd
         sxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GswvuQUPYzjb9uppiBSXGu08puDK6ov15/Sjf0UtKkU=;
        b=Uc7IYyvcee6ScBjDTOTxDuOpYrf5I/yOXHR0sHK3GguKqDVrPCjsoV3U9pb+SsbnU/
         IodjhmzQww3Dc7z69pORFr/6s/GSHUWWU2rhhheMEKkrP/UpKa9buDn3lPVNKiR8OSpA
         VZn4OaLgMVwsoaSHgQFGv/osY2pCcPv2mw0UOtwmA0P8S0Vtn6VhmvR/A6kL9dGof1cM
         J2g6KVvZXoIJrdSV21JU0xz8peo6gqAwBf/wz8F9jfGt1hPoTuggFIrfZks4IFyvv9is
         2lf3WCcGggWHiAon4qd+x/dulPS8QCgG2iLSGFcAv4TtB2hNHAcODnr0nfPrx+jnlHHP
         6zow==
X-Gm-Message-State: AKwxyte35qzzcNlBECiSFdycC1BrEUd0tQVpg/hnAL4J7fctSiY0EcSM
        hKXKQ4wdNFZBkRoWkKQAjNr3lU1kU90=
X-Google-Smtp-Source: AH8x2260pUNLBwfjjvbq1BEkak7QLtz+5MdP+vNvPyyV4oEzyjokxTAiwgcU4Om0plqYlcQ98xZ6ZA==
X-Received: by 10.237.37.154 with SMTP id x26mr22992777qtc.78.1516972396242;
        Fri, 26 Jan 2018 05:13:16 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id d76sm3342613qkb.84.2018.01.26.05.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 05:13:15 -0800 (PST)
Subject: Re: [PATCH 03/14] packed-graph: create git-graph builtin
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
 <20180125140231.65604-4-dstolee@microsoft.com>
 <CAGZ79ka61UCXWAP4X8CTdCSiPUBnsO1_-wNSkGmV0VjZyAqcpw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a29fc66e-8063-d134-b6d2-4be38de161f4@gmail.com>
Date:   Fri, 26 Jan 2018 08:13:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka61UCXWAP4X8CTdCSiPUBnsO1_-wNSkGmV0VjZyAqcpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 4:45 PM, Stefan Beller wrote:
> On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
>> Teach Git the 'graph' builtin that will be used for writing and
>> reading packed graph files. The current implementation is mostly
>> empty, except for a check that the core.graph setting is enabled
>> and a '--pack-dir' option.
> I wonder if this builtin should not respect the boolean core graph,
> as this new builtin commands' whole existence
> is to deal with these new files?
>
> As you assume this builtin as a plumbing command, I would
> expect it to pay less attention to config rather than more.

My thought was to alert the caller "This graph isn't going to be good 
for anything!" and fail quickly before doing work. You do have a good 
point, and I think we can remove that condition here. When we integrate 
with other commands ('repack', 'fetch', 'clone') we will want a 
different setting that signals automatically writing the graph and we 
don't want those to fail because they are not aware of a second config 
setting.

>
>> @@ -408,6 +408,7 @@ static struct cmd_struct commands[] = {
>>          { "fsck-objects", cmd_fsck, RUN_SETUP },
>>          { "gc", cmd_gc, RUN_SETUP },
>>          { "get-tar-commit-id", cmd_get_tar_commit_id },
>> +       { "graph", cmd_graph, RUN_SETUP_GENTLY },
> Why gently, though?
>
>  From reading the docs (and assumptions on further patches)
> we'd want to abort if there is no .git dir to be found?
>
> Or is a future patch having manual logic? (e.g. if pack-dir is
> given, the command may be invoked from outside a git dir)

You are right. I inherited this from my MIDX patch which can operate on 
a list of IDX files without a .git folder. The commit graph operations 
need an ODB.

Thanks,
-Stolee

