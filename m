Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D1551F403
	for <e@80x24.org>; Mon, 18 Jun 2018 19:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935997AbeFRTB7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 15:01:59 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35230 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935893AbeFRTBz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 15:01:55 -0400
Received: by mail-qt0-f196.google.com with SMTP id s9-v6so16146926qtg.2
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=niRawHrlhcriGvYAiEkR19EVXHYA07jsrIj5Fk470cU=;
        b=tUDARLC24MTWlo/1NDPkYSja2ZbunLZ2f/1l+hm/6cqkrHfEYUyh0wrqx1+5wSUVbu
         24gULex3ASvlOkHCxLK/t3Zk5oXnIrtDPrCMofc2F7K7Wi42NZfzRl8Q4woZQbjYpGKm
         67feS/p/qBzlhEwgKVI1SLRN60V6Mb8JjyE8I5zk+XaEz36vgEKOLwbcV+Pu2HreRfRv
         NAmNXXRt82bk8hQi1+ijmxTBFGrgwOAf2gfim+3uVFNEYa5/A4CaoYMGdDfLo8X8V+Ed
         QWb6Cbvy3V1Q9N2/u1j6CGca5eBseCeqfx8aR3Z1jvE85nNv2QUFlsX6ZKRndyK7tSKQ
         c0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=niRawHrlhcriGvYAiEkR19EVXHYA07jsrIj5Fk470cU=;
        b=ddlNETWFTUwfM3120k0qbtpk3km+mdaqgB3EBlYSzVsWXRwGPEIv1oI2R2QeaBfsSk
         6lioAVZYL46NJRmDGOilv/rJc5Zxdv6rgZBR89kTClVCZlK8nVFfveXswL/dNsQRaiv4
         zk8MKnisPAAj8DARVT2AoR7sljaK2GZxJuv5l8GFabXsAtaOzy+jUHcJscJPPEw5st4A
         cd45A0Bkr9m4yiVMtYcBOcr/9LCA+rpxV7A2MHfyOrckSIV41VSaZPxgiJnSK7kbPFdz
         9FDqxQF4VZ/YwpJO+T/hnkTkQC9hOWRERTHQicLcvyW1E13DdQi1W36xAnuEvfevsvDt
         aOpQ==
X-Gm-Message-State: APt69E1UyHhxepLlMTmhoG9kTEBUsYs7HQoImV8KtuQ3GZ7WoosBw9RI
        KixQxKqbOhUP6KXDDxdom/g=
X-Google-Smtp-Source: ADUXVKLzS7IGkHV2VDZCYtSkTZ1xgAdbmW+ztIaU/SaLREf0Z1geYYN9BkORgHnCdhxNzS8RNVsbGw==
X-Received: by 2002:ac8:2a46:: with SMTP id l6-v6mr12654665qtl.118.1529348514895;
        Mon, 18 Jun 2018 12:01:54 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:486:96a1:3ab7:988c? ([2001:4898:8010:0:edbb:96a1:3ab7:988c])
        by smtp.gmail.com with ESMTPSA id s39-v6sm12655478qts.42.2018.06.18.12.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 12:01:54 -0700 (PDT)
Subject: Re: [PATCH 02/23] midx: add midx format details to pack-format.txt
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-3-dstolee@microsoft.com>
 <CAGZ79kaDiXnAuRym3HHQPEZh9z0-sPL5V4Yur5-_RojsyLJsYA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a0dbd78c-507b-3005-c2eb-2fa82e7d29ec@gmail.com>
Date:   Mon, 18 Jun 2018 15:01:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaDiXnAuRym3HHQPEZh9z0-sPL5V4Yur5-_RojsyLJsYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/11/2018 3:19 PM, Stefan Beller wrote:
> Hi Derrick,
> On Thu, Jun 7, 2018 at 7:03 AM Derrick Stolee <stolee@gmail.com> wrote:
>> The multi-pack-index (MIDX) feature generalizes the existing pack-
>> index (IDX) feature by indexing objects across multiple pack-files.
>>
>> Describe the basic file format, using a 12-byte header followed by
>> a lookup table for a list of "chunks" which will be described later.
>> The file ends with a footer containing a checksum using the hash
>> algorithm.
>>
>> The header allows later versions to create breaking changes by
>> advancing the version number. We can also change the hash algorithm
>> using a different version value.
>>
>> We will add the individual chunk format information as we introduce
>> the code that writes that information.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/technical/pack-format.txt | 49 +++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
>> index 70a99fd142..17666b4bfc 100644
>> --- a/Documentation/technical/pack-format.txt
>> +++ b/Documentation/technical/pack-format.txt
>> @@ -252,3 +252,52 @@ Pack file entry: <+
>>       corresponding packfile.
>>
>>       20-byte SHA-1-checksum of all of the above.
>> +
>> +== midx-*.midx files have the following format:
>> +
>> +The meta-index files refer to multiple pack-files and loose objects.
> So is it meta or multi?

Good catch. We were calling this the meta-index internally before 
changing to "multi-pack-index" (helps to not change the acronym).

>
>> +In order to allow extensions that add extra data to the MIDX, we organize
>> +the body into "chunks" and provide a lookup table at the beginning of the
>> +body. The header includes certain length values, such as the number of packs,
>> +the number of base MIDX files, hash lengths and types.
>> +
>> +All 4-byte numbers are in network order.
>> +
>> +HEADER:
>> +
>> +       4-byte signature:
>> +           The signature is: {'M', 'I', 'D', 'X'}
>> +
>> +       1-byte version number:
>> +           Git only writes or recognizes version 1
>> +
>> +       1-byte Object Id Version
>> +           Git only writes or recognizes verion 1 (SHA-1)
> s/verion/version/
>
>> +       1-byte number (C) of "chunks"
>> +
>> +       1-byte number (I) of base multi-pack-index files:
>> +           This value is currently always zero.
> Oh? Are meta-index and multi-index files different things?

Not intended to be different things, but this number is related to 
making the feature incremental.

>
>> +       4-byte number (P) of pack files
>> +
>> +CHUNK LOOKUP:
>> +
>> +       (C + 1) * 12 bytes providing the chunk offsets:
>> +           First 4 bytes describe chunk id. Value 0 is a terminating label.
>> +           Other 8 bytes provide offset in current file for chunk to start.
>> +           (Chunks are provided in file-order, so you can infer the length
>> +           using the next chunk position if necessary.)
> It is so nice to have the header also have 12 bytes, so it fits right into the
> lookup table. So an alternative point of view:
>
>    If a chunk needs to store more than 8 bytes, we'll have an offset after
>    the first 4 bytes that describe the chunk, otherwise you can store the 8 bytes
>    of information directly after the 4 bytes.
>     "MIDX" is a special chunk and must come first (does it?) and only once
>    as it contains the version number.

This sounds feasible, but unnecessarily complicated. I don't think any 
other chunk will be this small.

>> +       The remaining data in the body is described one chunk at a time, and
>> +       these chunks may be given in any order. Chunks are required unless
>> +       otherwise specified.
>> +
>> +CHUNK DATA:
>> +
>> +       (This section intentionally left incomplete.)
>> +
>> +TRAILER:
>> +
>> +       H-byte HASH-checksum of all of the above.
> This means we have to rehash the whole file for updating its contents.
> okay.

