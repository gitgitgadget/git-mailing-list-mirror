Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FFF21F453
	for <e@80x24.org>; Tue, 25 Sep 2018 21:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbeIZDcb (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 23:32:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33884 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeIZDcb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 23:32:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id x23-v6so15089322qtr.1
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 14:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=adK+lPkMxWdwnivFAgZ+4DgHBs3jWzwXM+rJBhJDo6I=;
        b=pFAM69vtcxpW6ljlTieUG/48KMXA7pgMte+yBS+QwS7ae2i1iHxX0hNlslShnRCpOb
         cMIRw0wjEU7fTQOfd3385U1BJabhjS2LxUHgJ7CIbIL5NdIxYApGA+fZIhnT01KoexsZ
         tS3YhbxaCQohoA8Gf0eaRza8DDUK89DXnFkkqb8+Tz0S5YQd7bZ99+T7XbnqM1x03MF0
         wyDasnKB75Zwz+uWQbDWBPFwFbs3nz3jNEay76bsCBODwWgQh0Q8kF2ypKmdYT2ieylY
         6yPU2JQsrovU8o/umiSi2a2m+NhU0UR9EdftQDkm+yuvdXDdA72y8LmNbjqGgMQ5+yoE
         F6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=adK+lPkMxWdwnivFAgZ+4DgHBs3jWzwXM+rJBhJDo6I=;
        b=DeF3CqJTdhECWJNqnhEwZUsLZ65KgqTSDPHTjsGYV6mj1E3GItx9MhWBMozP+CkSZv
         kDPQZ19CyWKYwsHnpkMbyVH2PNHpZDi1qr0yOHfTsojvBl75zhMm256YTvWnX6vj7v1w
         jgwHfTQ36i6e4WFVgFlq6zaDnD6paMR5BhU9ELy+qgIuWPXKc9w7OdtAPoX2bUrl8Fll
         QwE8ColYsATT06A8fyorrb5hNMa27bv50BbFO/5wY55NRID0LfWde2xj1KkQvYdlI1dv
         nlb9T3KSnNY2NU3du9d0RUZx9TE3Qv83w9qjslegpKtieW2WvkAARLRMlN5hYHATCC9O
         xUeA==
X-Gm-Message-State: ABuFfoiddc97ErdVAQubu86HXyhCEoAMQ4ndUdzD/uYHVMugMSIEmXBz
        utnNImsF15t3vjycMkCb7UI=
X-Google-Smtp-Source: ACcGV60i0vLAL8+QdYNDvsx8x4imV1VVFuWUUVwi72WF15P9oG430VBq1MsdsCqfTX1iPNy6R934yg==
X-Received: by 2002:a0c:f208:: with SMTP id h8-v6mr2210516qvk.55.1537910579136;
        Tue, 25 Sep 2018 14:22:59 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d127-v6sm2130032qkg.14.2018.09.25.14.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 14:22:58 -0700 (PDT)
Subject: Re: [PATCH 1/1] read-cache: update index format default to v4
To:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matthias Sohn <matthias.sohn@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <pull.41.git.gitgitgadget@gmail.com>
 <56374128136fe9377503d446daf98e67847194aa.1537823728.git.gitgitgadget@gmail.com>
 <20180924213223.GG27036@localhost> <20180925070618.GB1596@xps>
 <4d276a77-0ac9-c1d1-b5de-3ded394efb0b@gmail.com>
 <CAGZ79kZEN9pSBAdVajfRrrb_D3twD+C7hnzZti+TqO0-sVp9PA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c05896d5-0b0a-9349-3c6d-9e658cd495ca@gmail.com>
Date:   Tue, 25 Sep 2018 17:22:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZEN9pSBAdVajfRrrb_D3twD+C7hnzZti+TqO0-sVp9PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/25/2018 2:01 PM, Stefan Beller wrote:
> On Tue, Sep 25, 2018 at 7:30 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 9/25/2018 3:06 AM, Patrick Steinhardt wrote:
>>> On Mon, Sep 24, 2018 at 11:32:23PM +0200, SZEDER Gábor wrote:
>>>> On Mon, Sep 24, 2018 at 02:15:30PM -0700, Derrick Stolee via GitGitGadget wrote:
>>>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>>>
>>>>> The index v4 format has been available since 2012 with 9d22778
>>>>> "reach-cache.c: write prefix-compressed names in the index". Since
>>>>> the format has been stable for so long, almost all versions of Git
>>>>> in use today understand version 4, removing one barrier to upgrade
>>>>> -- that someone may want to downgrade and needs a working repo.
>>>> What about alternative implementations, like JGit, libgit2, etc.?
>>> Speaking of libgit2, we are able to read and write index v4 since
>>> commit c1b370e93
>>
>> This is a good point, Szeder.
>>
>> Patrick: I'm glad LibGit2 is up-to-date with index formats.
>>
>> Unfortunately, taking a look (for the first time) at the JGit code
>> reveals that they don't appear to have v4 support. In
>> org.eclipse.jgit/src/org/eclipse/jgit/dircache/DirCache.java, the
>> DirCache.readFrom() method: lines 488-494, I see the following snippet:
>>
>>                   final int ver = NB.decodeInt32(hdr, 4);
>>                   boolean extended = false;
>>                   if (ver == 3)
>>                           extended = true;
>>                   else if (ver != 2)
>>                           throw new
>> CorruptObjectException(MessageFormat.format(
>> JGitText.get().unknownDIRCVersion, Integer.valueOf(ver)));
>>
>> It looks like this will immediately throw with versions other than 2 or 3.
>>
>> I'm adding Jonathan Nieder to CC so he can check with JGit people about
>> the impact of this change.
> 
> JGit is used both on the server (which doesn't use index/staging area)
> as well as client side as e.g. an Eclipse integration, which would
> very much like to use the index.
> 
> Adding Matthias Sohn as well, who is active in JGit and cares
> more about the client side than Googlers who only make use
> of the server side part of JGit.
> 
> Stefan
> 

In addition to the compatibility with other implementations of git 
question, I think we should include Duy's patch [1] to "optimize reading 
index format v4" before flipping the default to V4.

In my testing, this reduced the index load time of V4 by 10%-15% making 
the CPU cost only ~2% more expensive than V2 or V3 indexes.  This 
increase in CPU cost is more than offset by the significant reduction in 
file IO due to the reduced index file size.

[1] https://public-inbox.org/git/20180825064458.28484-1-pclouds@gmail.com/
