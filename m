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
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF401F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 09:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfJBJch (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 05:32:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53907 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfJBJch (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 05:32:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so6388518wmd.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DdMYBPvPFJwD6ghrT7nzPqfdkAvUHurnvCATMQMjUTI=;
        b=Apr3rPRGSk0gH5ZGDcMFOIJCil4MhLRjtB51dzHZnhEb6LVluN54HXxBG2v7sk2g9o
         wAW4Ge60BVtijzChvNsqjsczb0FPIKlGfW9aP0XQ6DBY+XqtHcKeBc2vPNtVizAzROvX
         +gH2cgs7Xdd2cNnMv7P0jF6l/EZVVQwYKORbn3a2y733WFgqJ+lCBihLmJpquvAt6aUU
         W9qxxGW8bmXdKSV+XIGzSlVNwnEzmoRIFFvveTnxQ9oJ0hMI9zFyFJAsi6IsD8WlM2CO
         aZ8bnC1WExDoGdu3x55okkmM9E0oyauiweOzDMGxAkHJKFNAroD0bP7/oONsCYJaSo91
         vnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DdMYBPvPFJwD6ghrT7nzPqfdkAvUHurnvCATMQMjUTI=;
        b=izSudw9rbKG5FI81WoxPOQrVOtJxTG/pgIVJRCI+mFkRwZXFWneSAWbtVJsFPnJYbY
         NbRgwYW/xd9J4Aty0FRKNxnxsAtEg8LPh0v/5TkZ4ObEBma4NJ18qZVFcqk1ERUaIzaa
         9SNCTN3H2+hzjOnIZa7ErUnVSUydGat8k0zk2hv98g0VMGO4jQ1JwHxdSUI5fuEBAIXs
         51PyeIbOmfrDwrD4FedHanJzPSIvVlQpFCqItKRHAEcJFfmIXSlkMMj3GcQc1hZdZnYK
         3LlU0lal++BB5kvJSV+IDMNSyYoccGKDXssfMo8nxx4sR2z+eHYr0gHbK7NjLj/TyTRx
         3QnQ==
X-Gm-Message-State: APjAAAVdjFXFQ/vqfCXBZKqaU1xt93OFsJvQFB/37hFWgEz0OZOerc12
        oMPAfvhQzrgYRfMUEEMXe/U=
X-Google-Smtp-Source: APXvYqzob+Hq5tzIQ0NexsCqoOGlzodZe4WqDoaeCI1u5vihYiKWlsU9SPCESgM97vZ85q0viaJGRA==
X-Received: by 2002:a1c:7f4f:: with SMTP id a76mr2070287wmd.117.1570008755365;
        Wed, 02 Oct 2019 02:32:35 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-10-31.as13285.net. [92.22.10.31])
        by smtp.gmail.com with ESMTPSA id f186sm6067772wmg.21.2019.10.02.02.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 02:32:34 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 4/5] rebase: fill `squash_onto' in get_replay_opts()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20190925201315.19722-5-alban.gruin@gmail.com>
 <66fcd66b-fad2-e5a1-cdd8-fd7b37c4abbf@gmail.com>
 <nycvar.QRO.7.76.6.1910021011010.46@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <94dbb49e-2c11-ce30-5d50-05be19ebb3bb@gmail.com>
Date:   Wed, 2 Oct 2019 10:32:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910021011010.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 02/10/2019 09:16, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 27 Sep 2019, Phillip Wood wrote:
> 
>> Hi Alban
>>
>> On 25/09/2019 21:13, Alban Gruin wrote:
 >>> [...]
>>>    builtin/rebase.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>>> index e8319d5946..2097d41edc 100644
>>> --- a/builtin/rebase.c
>>> +++ b/builtin/rebase.c
>>> @@ -117,6 +117,11 @@ static struct replay_opts get_replay_opts(const struct
>>> rebase_options *opts)
>>>     if (opts->strategy_opts)
>>>      parse_strategy_opts(&replay, opts->strategy_opts);
>>>    +	if (opts->squash_onto) {
> 
> I guess it does not matter much, but shouldn't this be guarded against
> the case where `replay.squash_onto` was already initialized? Like, `if
> (opts->squash_onto && !replay.have_squash_onto)`?

replay is uninitialized as this function takes a `struct rebase_opitons` 
and returns a new `struct replay_options` based on that.

Best Wishes

Phillip

> 
> Other than that, this patch makes sense to me.
> 
> Ciao,
> Dscho
> 
>>> +		oidcpy(&replay.squash_onto, opts->squash_onto);
>>> +		replay.have_squash_onto = 1;
>>> +	}
>>> +
>>>    	return replay;
>>>    }
>>>
>>>
>>
>>
