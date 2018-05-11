Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC071F406
	for <e@80x24.org>; Fri, 11 May 2018 17:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeEKRX0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 13:23:26 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:43360 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeEKRXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 13:23:25 -0400
Received: by mail-qt0-f169.google.com with SMTP id f13-v6so7992905qtp.10
        for <git@vger.kernel.org>; Fri, 11 May 2018 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xd39a35V3CaeCo2IkVjvr9f8+XOCEZJBypr+Yl+8oi8=;
        b=axKMW9CHCUkdnkp/qg+d/HMn0w2P0jXzZ6uRLdWu3e1ewZUm4Na7RMLBZSIHz63plY
         /XNu1pPz4vziqTd1Xh6h6joiDAjp1wOx4cZXCbfAoInJtkUvjIEfemh3gDPIpCnxAIOv
         PleID91Vgm1TqA0c3qmB3bhc2voIHnpERJWdyDmGlooPw/Ze9bVZ0XV3737o4F5jP3Rr
         2ZYERVrbbOHCgrSlmUqdbc1b0yolDuUqG0NjpiR0rd3dhjEXHHRvPqnbRmK0QomTuUxl
         7fw5V2J/9gBLk5Z9RfVYQy5yDU/Id56xxn5y1Zdn1AVson39J81ACP0fbFp47WIw3mn5
         /z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xd39a35V3CaeCo2IkVjvr9f8+XOCEZJBypr+Yl+8oi8=;
        b=FrQSsKLqaOeb5pzz9YzFK1ZWbHJa1kdMyttdYkbn3dITVDoJy/ZciErQRnZgXNGmux
         XurWjY3EKtINWtEI9O4ON8CBj1CoT1DLdeWFpAgZqlN5+O6e25znfw51ZpOlYCPFXTZf
         62WTvcLhnGjyyg3nmVIC70lAgFOCp8XRcV779uSQk2gpco+nZtpYx3/v0PYmVJeDxWPc
         bnQrlliEddnSAK9LZ8NL0+1egV5XZmSG7pTpDur5zRLsBXXDB8MvS+j+VWohAM5+G8bm
         0fcsPLF0jFYe0hLxlNZ9Wrix4WQCZqK4/liPiP0xcIqfPW/fmB9FDY2QW+hj6cECsZY4
         9yvA==
X-Gm-Message-State: ALKqPwfOikOsXPJWq0LibdiqCtz+4cN/6DuocsDV4qtce5FZwNagxlyA
        9L0vMjT0qc7OSB2lsInXa8w=
X-Google-Smtp-Source: AB8JxZoXWRlmAxDK3H0DgRMu5xFgV0Mvz8A6brEzD4inwzjlST6zA2okYkO0Zc0v3vE480xUlMjRMQ==
X-Received: by 2002:ac8:2c56:: with SMTP id e22-v6mr6356490qta.74.1526059403922;
        Fri, 11 May 2018 10:23:23 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id p203-v6sm2869895qke.48.2018.05.11.10.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 10:23:22 -0700 (PDT)
Subject: Re: [PATCH 00/12] Integrate commit-graph into fsck, gc, and fetch
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com>
 <87mux72uds.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bfaa96f8-2b9d-5ec6-0d30-7c1018146335@gmail.com>
Date:   Fri, 11 May 2018 13:23:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87mux72uds.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/2018 3:17 PM, Ævar Arnfjörð Bjarmason wrote:
> On Thu, May 10 2018, Derrick Stolee wrote:
>
>> The behavior in this patch series does the following:
>>
>> 1. Near the end of 'git gc', run 'git commit-graph write'. The location
>>     of this code assumes that a 'git gc --auto' has not terminated early
>>     due to not meeting the auto threshold.
>>
>> 2. At the end of 'git fetch', run 'git commit-graph write'. This means
>>     that every reachable commit will be in the commit-graph after a
>>     a successful fetch, which seems a reasonable frequency. Then, the
>>     only times we would be missing a reachable commit is after creating
>>     one locally. There is a problem with the current patch, though: every
>>     'git fetch' call runs 'git commit-graph write', even if there were no
>>     ref updates or objects downloaded. Is there a simple way to detect if
>>     the fetch was non-trivial?
>>
>> One obvious problem with this approach: if we compute this during 'gc'
>> AND 'fetch', there will be times where a 'fetch' calls 'gc' and triggers
>> two commit-graph writes. If I were to abandon one of these patches, it
>> would be the 'fetch' integration. A 'git gc' really wants to delete all
>> references to unreachable commits, and without updating the commit-graph
>> we may still have commit data in the commit-graph file that is not in
>> the object database. In fact, deleting commits from the object database
>> but not from the commit-graph will cause 'git commit-graph verify' to
>> fail!
>>
>> I welcome discussion on these ideas, as we are venturing out of the
>> "pure data structure" world and into the "user experience" world. I am
>> less confident in my skills in this world, but the feature is worthless
>> if it does not improve the user experience.
> I really like #1 here, but I wonder why #2 is necessary.
>
> I.e. is it critical for the performance of the commit graph feature that
> it be kept really up-to-date, moreso than other things that rely on gc
> --auto (e.g. the optional bitmap index)?

It is not critical. The feature has been designed to have recent commits 
not in the file. For simplicity, it is probably best to limit ourselves 
to writing after a non-trivial 'gc'.

> Even if that's the case, I think something that does this via gc --auto
> is a much better option. I.e. now we have gc.auto & gc.autoPackLimit, if
> the answer to my question above is "yes" this could also be accomplished
> by introducing a new graph-specific gc.* setting, and --auto would just
> update the graph more often, but leave the rest.

This is an excellent idea for a follow-up series, if we find we want the 
commit-graph written more frequently. For now, I'm satisfied with one 
place where it is automatically computed.

I'll drop the fetch integration in my v2 series.

Thanks,
-Stolee
