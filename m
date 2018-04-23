Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB70D1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 17:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbeDWROu (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 13:14:50 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46897 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755473AbeDWROt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 13:14:49 -0400
Received: by mail-qk0-f193.google.com with SMTP id s70so16866984qks.13
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ChNbi71LnJoU4yy2SCUr6BC/ka9yCSxkNOeowwWdS+A=;
        b=MuYey2ULGsEF77M5yylyBaIj8hvNkhvL8YF/26rRRzmJXBr4YWtpqL5dSoJwjycnpw
         Fztrce6kCbRWeTvJ8j5Z2cdEVeL+3wGtGq3ExyVgKtsbBz217lTa85CYRE/atSo+kdQR
         Nsdy24L0k4PDEnpCro+Ot6pMkWin2P5Og1sCnwRrapQE8FAknqk8j3DljIM5iNf01qt/
         vk/PlQOjZqT2zOPURyKqpanAnspo82Ta4XeQaa1v+T04OJN79EaBixo3gvqZ4KoD3SoW
         WdJlygeDIQ+XnzBduX+1J8xAUZFfmKUzlpDpT8VwNIdpm8bQ+mJNRFKaG733Mywu7+ax
         gzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ChNbi71LnJoU4yy2SCUr6BC/ka9yCSxkNOeowwWdS+A=;
        b=sCRSJFDHYf8vVCUhoqqQ+Hj8QPhE1BsQQhLN1R15wasUFVw2mYfA4ieRt00ywL2XPe
         vYg/FfcH096QJgTBEODp3+FXK90/6hfEDiwb8W1R4nmLdYu+eCNWqE5/HepC5wEPC/4F
         7FxkDQPbslHKbqsXVGA+T7vc6dpV2uRJGtvocm97LTQP+XYOJWdmjSjOm2TIPPbem9b5
         VaLoSS6RjjZrELdn90BJuT7b2mXfGW9fWP7SCzoj2cDI/gAnt1YDqzjwkGbfgf6p7Xr9
         rL5nA77IV00FmG/RO+9D8J900zgX0enn/ek6LiaXn9CjgnwmhQiy6M9uV5g+INVlZ25y
         bnOw==
X-Gm-Message-State: ALQs6tAtbn8FFYKkIJljd9kRfrrUy9CQc8GRO3A3ZtqDVAdtkKa2+B/t
        iHtsS3+Xm5oEc1FApzC0jtAUT0IH
X-Google-Smtp-Source: AB8JxZpWwTJbIFMdz6RoP36cC9iwyNhNMcKCDthJAiVHUUNE/DtyKlN8L6KLs7TCAaMc/FPprI0MCQ==
X-Received: by 10.55.165.66 with SMTP id o63mr23335111qke.262.1524503688451;
        Mon, 23 Apr 2018 10:14:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:8010:1:1060:bd2c:4297:50e])
        by smtp.gmail.com with ESMTPSA id n64sm9974632qkc.56.2018.04.23.10.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 10:14:48 -0700 (PDT)
Subject: Re: [PATCH v1 0/5] Allocate cache entries from memory pool
To:     Jonathan Tan <jonathantanmy@google.com>,
        Jameson Miller <jamill@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180420163441.208644d772a25ddbbdbb1616@google.com>
From:   Jameson Miller <jameson.miller81@gmail.com>
Message-ID: <8866ddf7-399c-c596-5fb5-c78bc040f4ac@gmail.com>
Date:   Mon, 23 Apr 2018 13:14:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420163441.208644d772a25ddbbdbb1616@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/20/2018 07:34 PM, Jonathan Tan wrote:
> On Tue, 17 Apr 2018 16:34:39 +0000
> Jameson Miller <jamill@microsoft.com> wrote:
> 
>> Jameson Miller (5):
>>    read-cache: teach refresh_cache_entry to take istate
>>    Add an API creating / discarding cache_entry structs
>>    mem-pool: fill out functionality
>>    Allocate cache entries from memory pools
>>    Add optional memory validations around cache_entry lifecyle
> 
> In this patch set, there is no enforcement that the cache entry created
> by make_index_cache_entry() goes into the correct index when
> add_index_entry() is invoked. (Junio described similar things, I
> believe, in [1].) This might be an issue when we bring up and drop
> multiple indexes, and dropping one index causes a cache entry in another
> to become invalidated.

Correct - it is up to the caller here to coordinate this. The code 
should be set up so this is not a problem here. In the case of a 
split-index, the cache entries should be allocated from the memory pool 
associated with the "most common" / base index. If you found a place I 
missed or seems questionable, or have suggestions, I would be glad to 
look into it.

> 
> One solution is to store the index for which the cache entry was created
> in the cache entry itself, but that does increase its size. Another is

Yes, this is an option. For this initial patch series, I decided to not 
add extra fields to the cache_entry type, but I think incorporating this 
in cache_entry is a viable option, and has some positive properties.

> to change the API such that a cache entry is created and added in the
> same function, and then have some rollback if the cache entry turns out
> to be invalid (to support add-empty-entry -> fill -> verify), but I
> don't know if this is feasible. Anyway, all these alternatives should be
> at least discussed in the commit message, I think.

I can include a discussion of these in the commit message. Thanks.

> 
> The make_transient_cache_entry() function might be poorly named, since
> as far as I can tell, the entries produced by that function are actually
> the longest lasting, since they are never freed.

They should always be freed (and are usually freed close to where they 
are allocated, or by the calling function). If you see an instance where 
this is not the case, please point it out, because that is not the 
intention.

> 
> Along those lines, I was slightly surprised to find out in patch 4 that
> cache entry freeing is a no-op. That's fine, but in that case, it would
> be better to delete all the calls to the "discard" function, and
> document in the others that the entries they create will only be freed
> when the memory pool itself is discarded.

I can add a comment inside the function body. In the next commit, I do 
add logic to perform extra (optional) verification in the discard 
function. I did wrestle with this fact, but I feel there is value in 
having the locations where it is appropriate to free these entries in 
code, even if this particular implementation is not utilizing it right 
now. Hopefully the verification logic added in 5/5 is enough to justify 
keeping this function around.

> 
> [1] https://public-inbox.org/git/xmqqwox5i0f7.fsf@gitster-ct.c.googlers.com/
> 
