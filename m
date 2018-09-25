Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5FA31F453
	for <e@80x24.org>; Tue, 25 Sep 2018 14:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbeIYUhj (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 16:37:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44733 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeIYUhj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 16:37:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id g184-v6so109471qkc.11
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IxeNtsQDKAprdagx8WnldekgvKjph4nFIvpEj/C1WNM=;
        b=oYPB8x7VauRgl1/jB2OtXHDK2AIOD/1nz0dMPOPhztdCI2Owg+U4dmyO4i7nOiEYz1
         KQMLsvBjudfk7OJ7C06bJKvSMJtEdo1/0rLoLVVsqSGCtwleOjKxW+qebXbkq3vlB/sq
         yIYjcQ9cZPNiE/Ux69eVGOxM0qfkWVQYu1tVzYC2OtKlFNQnkNgDJnkdoe0JJfbfJtfa
         BUHwhVXAPAb81FGYfpCvIeYreGYTNIw9/2D1brPUUhqgByxfRPzWXZU4kPFxpZDb9hNU
         sE2he6zAKa82BpG/EwOuwruSzMRj+s+fcs/TfR+VJYwq/1Ymya1ivdSyB7o4EkxeJy5x
         zTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IxeNtsQDKAprdagx8WnldekgvKjph4nFIvpEj/C1WNM=;
        b=e/nq36eAnWJO9pqlkVEbKZ0PEkZVizibIjQkZSxV6+JrqngpRCY/xIoCT7E1Lp27h3
         klKWRJrlI4T+0hUno0gIOhy7S9viVMzk2jH+ZdQh7JiHzYHnYZudYJUTmpOje34Umucq
         c+0cKZVQ41DeSIuqUmvJ0pzm4XdJODHUnt1MhRbeFf8nrouCoxPd0jmCoW6oTPvu8CiP
         mjjEvy5l89gTDecBHwVe8RFTIVhju0vBW6hbjrf8sTcKMYqEUcpn7cizPpTn0L2X/XbR
         tDjEVxMaeo0mb1XG2g8JkYKZ3GhQTqI6eWYaLkkSoX1O9+XlYd/1ptcsm4D92b+8Op54
         PXuw==
X-Gm-Message-State: ABuFfoh+JMtHD1F8X1OWYoCQX2ME22hVIDbnrG/vJ4LUv1YEm2pdoPzT
        GDQAloSbOHLXQCnPNnU9SPg=
X-Google-Smtp-Source: ACcGV62TJwQNBVybm+pB5OdrjMAH+YKsJqu4v+1sl01CfZaWwyvQ08K7EFUbvg7+Wwk8tmY13DDwLw==
X-Received: by 2002:a37:4653:: with SMTP id t80-v6mr903082qka.314.1537885792199;
        Tue, 25 Sep 2018 07:29:52 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:78b6:4100:eb3b:b0cf? ([2001:4898:8010:0:61ec:4100:eb3b:b0cf])
        by smtp.gmail.com with ESMTPSA id d127-v6sm1444934qkg.14.2018.09.25.07.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 07:29:47 -0700 (PDT)
Subject: Re: [PATCH 1/1] read-cache: update index format default to v4
To:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com, peartben@gmail.com,
        git@jeffhostetler.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <pull.41.git.gitgitgadget@gmail.com>
 <56374128136fe9377503d446daf98e67847194aa.1537823728.git.gitgitgadget@gmail.com>
 <20180924213223.GG27036@localhost> <20180925070618.GB1596@xps>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4d276a77-0ac9-c1d1-b5de-3ded394efb0b@gmail.com>
Date:   Tue, 25 Sep 2018 10:29:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925070618.GB1596@xps>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/25/2018 3:06 AM, Patrick Steinhardt wrote:
> On Mon, Sep 24, 2018 at 11:32:23PM +0200, SZEDER Gábor wrote:
>> On Mon, Sep 24, 2018 at 02:15:30PM -0700, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> The index v4 format has been available since 2012 with 9d22778
>>> "reach-cache.c: write prefix-compressed names in the index". Since
>>> the format has been stable for so long, almost all versions of Git
>>> in use today understand version 4, removing one barrier to upgrade
>>> -- that someone may want to downgrade and needs a working repo.
>> What about alternative implementations, like JGit, libgit2, etc.?
> Speaking of libgit2, we are able to read and write index v4 since
> commit c1b370e93

This is a good point, Szeder.

Patrick: I'm glad LibGit2 is up-to-date with index formats.

Unfortunately, taking a look (for the first time) at the JGit code 
reveals that they don't appear to have v4 support. In 
org.eclipse.jgit/src/org/eclipse/jgit/dircache/DirCache.java, the 
DirCache.readFrom() method: lines 488-494, I see the following snippet:

                 final int ver = NB.decodeInt32(hdr, 4);
                 boolean extended = false;
                 if (ver == 3)
                         extended = true;
                 else if (ver != 2)
                         throw new 
CorruptObjectException(MessageFormat.format(
JGitText.get().unknownDIRCVersion, Integer.valueOf(ver)));

It looks like this will immediately throw with versions other than 2 or 3.

I'm adding Jonathan Nieder to CC so he can check with JGit people about 
the impact of this change.

Thanks,

-Stolee


