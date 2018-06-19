Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C7A1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 15:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966225AbeFSPYX (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 11:24:23 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43333 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966087AbeFSPYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 11:24:22 -0400
Received: by mail-qt0-f193.google.com with SMTP id y89-v6so59606qtd.10
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ThmW5VKakGjP5m+mGwAuwL3At3p0CNDaOpu3exrt5v4=;
        b=KbjX7sj3jcc62slS6X3lYm8+4IPtCCzcENK8SnuC6hDmqyMSGTDBROWv/DjdNmN1xI
         BKtuoQwj08lqYlrmMTqBT3iHIDVaKuDSFwcUPSwb8i5uwjDWq4YHbB0bRau8celS2IWZ
         TsFbYpxoBb3TkanaqjTuqQJYynlaQsZ5EQYT7IedhJlzhLdtUy4Wl2JreNYQZBVLXeR/
         F/wa9fnEmBiYH/YdytMheCdxOvwdlYp0Su5Yw/guekIW78UfIRrd35dCHbf5xJcn15sc
         AM/Wv5VFt/41MgoHvjRGf/AHMvdsaKEd6+be54ipn+ladFh6Y2s5U4abc8Myb5T0Rzui
         b1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ThmW5VKakGjP5m+mGwAuwL3At3p0CNDaOpu3exrt5v4=;
        b=bol0T90Y0W5SvFMt90XNCww29YYUHbfgZU+BM3lnHnk2pZnrtUyS8LYb21Z3vuR+VV
         0/N0j4JyS/poPD+/YKElXBC1wRB27cvE35B5ee83B7Xf8CHBM9NZEcMBEBRgG7Fd4pjk
         NTRi4UiomRE9TJxUFZr3t5M/VMyz0/0x5E2EQ+tIEvS6B6etxK7/ZWyLU3yFG7qHqn/9
         t1gHTyVOMNPd1KQ26zUWGbW2KEHd2UC3jT+S19D0vc/UszfVXNojMhA9v0GeDlXZxFNu
         ncqrIGiPNbiBxXU9EvBUNQzvSWc8sm7OdQgkNK3pkMwPyamp3y1vwwNXox747nx+ZXHf
         jyxQ==
X-Gm-Message-State: APt69E3Mz53UCorvsPPl0A03oFO5SsxjcIFSyj6xQ33uLlUqvFVFMcHV
        yPpsnLCCX7ICZ1UKJE1TjSo=
X-Google-Smtp-Source: ADUXVKK6R2tK/WuSTNJyBR6tfZ1SNo5LRU297fYR8emU6AFqRz97VTG1j4nZgtqjN2+A7TJwngMzUw==
X-Received: by 2002:ac8:172a:: with SMTP id w39-v6mr15040538qtj.96.1529421861946;
        Tue, 19 Jun 2018 08:24:21 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d807:51c7:6f48:91e4? ([2001:4898:8010:0:c13d:51c7:6f48:91e4])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14061864qtc.17.2018.06.19.08.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 08:24:21 -0700 (PDT)
Subject: Re: [PATCH 05/23] midx: write header information to lockfile
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-6-dstolee@microsoft.com>
 <CACsJy8ALMjiyjcEdFPnR7GTzBVpqVB72VQNkpUWrj9p4nm-OGg@mail.gmail.com>
 <fa036efb-2164-ee0a-8cbb-4144487b6617@gmail.com>
 <CACsJy8B+9WnWJASkd19BSjRdpAECo7Kva8OTC_ZbjiMH4wXi-w@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a026d956-eb93-7034-dfd9-25d94e7dce84@gmail.com>
Date:   Tue, 19 Jun 2018 11:24:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8B+9WnWJASkd19BSjRdpAECo7Kva8OTC_ZbjiMH4wXi-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/19/2018 10:59 AM, Duy Nguyen wrote:
> On Tue, Jun 19, 2018 at 2:54 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 6/12/2018 11:00 AM, Duy Nguyen wrote:
>>> On Thu, Jun 7, 2018 at 7:01 PM Derrick Stolee <stolee@gmail.com> wrote:
>>>> diff --git a/midx.c b/midx.c
>>>> index 616af66b13..3e55422a21 100644
>>>> --- a/midx.c
>>>> +++ b/midx.c
>>>> @@ -1,9 +1,62 @@
>>>>    #include "git-compat-util.h"
>>>>    #include "cache.h"
>>>>    #include "dir.h"
>>>> +#include "csum-file.h"
>>>> +#include "lockfile.h"
>>>>    #include "midx.h"
>>>>
>>>> +#define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
>>>> +#define MIDX_VERSION 1
>>>> +#define MIDX_HASH_VERSION 1 /* SHA-1 */
>>> ...
>>>> +static size_t write_midx_header(struct hashfile *f,
>>>> +                               unsigned char num_chunks,
>>>> +                               uint32_t num_packs)
>>>> +{
>>>> +       char byte_values[4];
>>>> +       hashwrite_be32(f, MIDX_SIGNATURE);
>>>> +       byte_values[0] = MIDX_VERSION;
>>>> +       byte_values[1] = MIDX_HASH_VERSION;
>>> Quoting from "State of NewHash work, future directions, and discussion" [1]
>>>
>>> * If you need to serialize an algorithm identifier into your data
>>>     format, use the format_id field of struct git_hash_algo.  It's
>>>     designed specifically for that purpose.
>>>
>>> [1] https://public-inbox.org/git/20180612024252.GA141166@aiede.svl.corp.google.com/T/#m5fdd09dcaf31266c45343fb6c0beaaa3e928bc60
>> Thanks! I'll also use the_hash_algo->rawsz to infer the length of the
>> hash function.
> BTW, since you're the author of commit-graph.c and may notice it has
> the same problem. Don't touch that code. Brian already has some WIP
> changes [1]. We just make sure new code does not add extra work for
> him. I expect he'll send all those patches out soon.
>
> [1] https://github.com/bk2204/git/commit/3f9031e06cfb21534eb7dfff7b54e7598ac1149f

Thanks for the link. It seems he is creating an oid_version() method 
that returns a 1-byte version for the hash version instead of the 4-byte 
signature of the_hash_algo->format_id. I look forward to incorporating 
that into the MIDX format. I'll keep my macros for now, as we work out 
the other details, and while Brain's patch is cooking.

Thanks,
-Stolee
