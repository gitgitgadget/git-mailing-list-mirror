Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F0C1FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 16:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754404AbdDRQim (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 12:38:42 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33743 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbdDRQik (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 12:38:40 -0400
Received: by mail-qt0-f193.google.com with SMTP id c45so23655857qtb.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=TkSqGch1PiVSxn/7orR+9AFo45Hhr90h3mCJBwitTzE=;
        b=auKR8P5fCJKRGhXIo8qM8rIA36/kcd+Q903vkfErQGwrwPhFtmuckEX1Cr35G7lbpQ
         U11cVqL8LEybYhYGQHz56xomhngP1PXF+IGJn7wNhTXviIls0gxGBY52EKZd7j5CsCQe
         XHANrxQgO5yLuEJBBVcdrPGecnucAJy2Yzuv+ID1tN1jMWmfTgguthh2U/wWNOfd/D4x
         9Wk+FdgWPX8eUp8/7yKgGcAdG4c3Hbkf8s+4scW0z1E7eq3jdHO8csXVgePybN3D+nxV
         rBaIQXRZRDF9hHPSsvXdV0EcV24/8gjvphWRoFuzoFPDRhlWU073Eqand0kC+dtBFSlR
         b8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=TkSqGch1PiVSxn/7orR+9AFo45Hhr90h3mCJBwitTzE=;
        b=lUYLrP8HoJi6vDma3LHNX+oGSI83Ph5A9fTykjc49aMy54+SujS0F2Yzuu9yR1n9EQ
         xcdh41DFo2LMYymyP9CLXEepwaMt6dsu9ER2jSz4fldGxMR2k5VqLP4dT14dh2kHS7b8
         OG6udo73clHY5gA0hGyWJqdvvcbvSe0E/dsmEA+mWsQAd/G18xe8rYudq4mc9k4Qoott
         LARpyutaj7YwjN9aGnRJzHhMJwulgHwkPFUWyZA39ekbrsCxeVPLvhvedwsu5qUSmpTQ
         Lp5L51IeDN+MV+SVLKLUXvDZlWVXOENPUT/nWnMrpfkS5KDANmLBHyS7rwZVKGg+vnfZ
         sZZA==
X-Gm-Message-State: AN3rC/5zeHaoUpU8eu9/1ItjuXHWxvFnC0QgbbS2+3JYAPpL6ZMXGYcd
        tCf+RDCgQVa3mg==
X-Received: by 10.200.35.250 with SMTP id r55mr14494609qtr.280.1492533519638;
        Tue, 18 Apr 2017 09:38:39 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id h1sm9960882qke.26.2017.04.18.09.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2017 09:38:38 -0700 (PDT)
Subject: Re: [PATCH v5 4/8] convert: Separate generic structures and variables
 from the filter specific ones
To:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20170407120354.17736-1-benpeart@microsoft.com>
 <20170407120354.17736-5-benpeart@microsoft.com>
 <48FA4601-0819-4DE2-943A-7A791BA7C583@gmail.com>
 <xmqqmvbfk8va.fsf@gitster.mtv.corp.google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, benpeart@microsoft.com,
        christian.couder@gmail.com
From:   Ben Peart <peartben@gmail.com>
Message-ID: <48448c2c-378d-0d87-2f99-32095326f323@gmail.com>
Date:   Tue, 18 Apr 2017 12:38:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvbfk8va.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/16/2017 11:31 PM, Junio C Hamano wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
>
>>> -static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
>>> +static struct subprocess_entry *find_multi_file_filter_entry(const char *cmd)
>> I am curious why you removed the hashmap parameter (here and in other pars of this patch).
>> I know the parameter is not strictly necessary as the hashmap is a global variable anyways.
>> However, I think it eases code maintainability in the long run if a function is "as pure as
>> possible" (IOW does rely on global state as less as possible).
> If the original relied on a global hashmap and this update kept the
> code like so, I wouldn't mind the end result of this series
> (i.e. rely on it being global).  But that is not the case.  It is
> making the code worse by stopping passing the hashmap through the
> callchain.
I debated this myself but there were a couple of things that pushed me 
to this simpler model.  First, it simplified the interface a little as 
you don't need an explicit init call with state to detect if it has 
already been initialized and you don't have to pass the hashmap into the 
various functions.  Since it was already a global, I didn't feel like 
this made it any worse.

Second, since the hashmap key is the exact command that was executed if 
you ever had two hashmaps with the same key, you'd end up with two 
copies of the same background process running.  I couldn't come up with 
any scenario where you would want two copies of the exact same command 
running at the same time so again went with the simpler model.

While I was typing this, I realized that since the background process is 
a versioned interface, if there were two different parts of the code 
using background processes and if they both wanted to run the same 
background process and if they wanted to use different versions of the 
interface, then you could want two different copies.

That said, I tend to build for things that are needed now rather than 
those that might be needed in the future.  If I've missed a scenario, 
I'm happy to change the interface.
