Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E5681F454
	for <e@80x24.org>; Mon, 11 Nov 2019 17:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKKRbI (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 12:31:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34862 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfKKRbA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 12:31:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id s10so8076882plp.2
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 09:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UWMEZZj7TwuKls2PYBUr4A5BfhTT7NQAPmW6maX7mG4=;
        b=pR38cWMkvJ4OYT7m9WUn6lE9umbxqiSap6A24KcvBRoVWgdRXbazsHygncoCv9sJgA
         HCgx4yukrI1Kau9Z31Na7KtrASvqaueLWDfD/uunZxp4DFUcdXhXA9zg72AedfiT87Fv
         d2lTFIp3SECVzhjiILQAhYO4bDjyeSAIs7YKeB4crWvFUGyV24vicqx79ikjpQLTnPPI
         w0XEl0pxlJrZmXYoHDcMbBwYkSkDqAKDWnsLY5ZcFg4txuBYk8vrkfN0Rf8tIqoq4UV1
         LJLqnawKue6l31ML2g3ATkDU1Y7knNpbEZkGUwAi6e4xszenpeX20I6x1qU2/bj1WTlt
         KbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UWMEZZj7TwuKls2PYBUr4A5BfhTT7NQAPmW6maX7mG4=;
        b=t7z8ZBtUmSmPbIwCAYHT4ZIcnIvdHqI/SF8HYKventPczyhEFDp3E0boshstKUvNw1
         a4tLrZ+R8fltpfO2YBV0TG08AQPazPxr2Ag/HGNpvUTTvXD3eCtG/sz3J0B1e68H47bH
         VMtPj86oTEYeQVGlh4lm7eJiB9irWCu1oefhLfnET2S03wN/Zcu1PDi5ZOTnxfTjcBDs
         ySEumC+Aiy8mCAiBKUR/eGayp0Dh4WNW5X7bp+URLaqbtr6oDN5BCO75FtdAfQl0tC+5
         hwWziovLU2WfdNVIvIEIlo1jZehexebWgmGi0prb2YNDiNcxJ95t9zm+gikg5FiSR1LE
         hKPg==
X-Gm-Message-State: APjAAAXxoF0m+ek5W0c9o8/AT7s0JwrNfA33G7ffqvRMZN9SP2Km8ICH
        ShQjyemMzA03tKpBAkcVIBJ9IRUU
X-Google-Smtp-Source: APXvYqyzQ5wIM5TvdKMXSBs69d8cS3hJLbHiW4AFzBLuzh7HOxfJtliYGYmuzBeV8PsExgyIfPfVrw==
X-Received: by 2002:a17:902:9689:: with SMTP id n9mr27458218plp.222.1573493458660;
        Mon, 11 Nov 2019 09:30:58 -0800 (PST)
Received: from Junyan-Surface.redmond.corp.microsoft.com (50-47-110-187.evrt.wa.frontiernet.net. [50.47.110.187])
        by smtp.gmail.com with ESMTPSA id k14sm809718pgt.54.2019.11.11.09.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 09:30:58 -0800 (PST)
Subject: Re: [PATCH 0/1] fsmonitor: skip sanity check if the index is split
To:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        William Baker <William.Baker@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>
References: <pull.458.git.1573196960.gitgitgadget@gmail.com>
 <xmqqh83bjig6.fsf@gitster-ct.c.googlers.com>
 <xmqqa793jhne.fsf@gitster-ct.c.googlers.com>
 <BN6PR21MB07869E8D1DCAF189C4E472A891740@BN6PR21MB0786.namprd21.prod.outlook.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <ba3736b8-9f44-5438-36c3-213d8a3d621e@gmail.com>
Date:   Mon, 11 Nov 2019 09:30:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <BN6PR21MB07869E8D1DCAF189C4E472A891740@BN6PR21MB0786.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11/11/19 8:55 AM, Kevin Willford wrote:
>>
>> The istate->cache[] is a dynamic array whose size is managed via the usual
>> ALLOC_GROW() using istate->cache_nr and istate->cache_alloc, whether the
>> split-index feature is in use.  When your patch makes a difference, then,
>> doesn't the access to istate->cache[] pick up a random garbage and then flip
>> the bit?
>>
>> Puzzled...  In any case, "check is worse than over-eager, it simply is wrong" I
>> wrote in the message I am responding to is totally incorrect, it seems.  It
>> smells like lifting the check would just hide the underlying problem under the
>> rug?
> 
> I agree.  The only 2 places that excluding the split-index make sense are in
> read_fsmonitor_extension and write_fsmonitor_extension because the
> index_state that is being passing into those methods could be the delta index
> in which case the number of entries for the fsmonitor bitmap would almost
> always be more and cause the BUG to be hit which it should not be.
> 
> The reason it is not needed and should not be in the other 2 places is they
> are ran from tweak_fsmonitor which is ran at post_read_index_from which
> is after the base and delta indexes have been loaded into the indes_state and
> the index_state will have all the entries and if the fsmonitor bitmap is bigger
> than the number of entries then the BUG should be hit. 
> 

I agree.  While working on the 3444ec2e patch I missed that read_fsmonitor_extension
and write_fsmonitor_extension could be called with the delta index rather than the
full index.

I think it makes sense to leave the check in the other two places.

Thanks,
William


