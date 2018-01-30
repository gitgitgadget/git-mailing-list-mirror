Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA0F1F576
	for <e@80x24.org>; Tue, 30 Jan 2018 16:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeA3QaK (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 11:30:10 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43902 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeA3QaI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 11:30:08 -0500
Received: by mail-lf0-f65.google.com with SMTP id o89so16222030lfg.10
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 08:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q5NRRqPKPf+8rZrl+L5uXAuWsM5saYTl9TcVAd/Yu7A=;
        b=fj/K/8n50jd5FdN1Tacb/nF0ns8ZS+XiucxnHOoKJl/+p6H+6S3PN50suT+y99KarG
         fbOLvNm9yn9bE5yqy9zJMVtqeFst7Vd5kOndkBZ4ZNsRSEeCSDA9ezQhTB7OUoTZ0eC3
         rJLb+Su7VLb89edXQJYEbcAqWXKiVWtucxaunpFGnkgvK5OyToxdOLzRBCO6gFdFOKN6
         n9uAk3+OXLa316nyNCF1rEVMoUiWFqbYwRekHHy+qBYLJn/B4zDl2EssRLZLXX9sjpRU
         uCkruIXa2LNpcbP/6i5DAz2K50p4qH7aYYGPY98fA4Vx0HQrO6hv6jag1fxJTm3adMig
         mWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q5NRRqPKPf+8rZrl+L5uXAuWsM5saYTl9TcVAd/Yu7A=;
        b=CVnzNMrNHZVSFmx0JGsyNgGUr4DreEgtWeSaJ20nKgwq11O66nDOusKr+fxCX0e4Un
         u9Yxd2eFbRnxdgR9z4DHbDdYT2qB8LBq/EXfON9pwNT48HUITw0fB/hVfNHcyYyJpoz3
         tbnF5iqGqs3FvxBE04CLBRVKxYEd+r+nBpDE7U9ZyBXIwZiqH4JmyyOAEml1q7y2dCFL
         nd+Jn+OM1PcTHbi1P9uzvZGJhDC8aKrQi1QbTwd9P94EwIpZJo+zogstX4AH6Puii7la
         wj3veA5U166ZWvqvb7dcH8+rAOiyhsMJU4wvaAQ4E3lBhhJx9sBTIdIkKqPbSXXuhRXC
         K1+g==
X-Gm-Message-State: AKwxytfJ2TRjP6C8SXnitU9dkebO8VutiYFJdic9m/2WKsAoIUfpmNHz
        SEUHuP2Yg4kP5J6H1vpGbCE=
X-Google-Smtp-Source: AH8x226s2QuP464Lbn/cVroMRrGC8xgkrooeuMSqzH7iEldSe8sPgWZaQbS2z1JALzZCgV8ezIUfjQ==
X-Received: by 10.25.23.27 with SMTP id n27mr10252332lfi.89.1517329806468;
        Tue, 30 Jan 2018 08:30:06 -0800 (PST)
Received: from [192.168.1.138] ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id v11sm32073ljv.11.2018.01.30.08.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 08:30:05 -0800 (PST)
Subject: Re: [PATCH v2 1/1] setup: recognise extensions.objectFormat
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Johannes.Schindelin@gmx.de,
        sbeller@google.com,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
References: <cover.1517098675.git.patryk.obara@gmail.com>
 <e430ad029facdd6209927d352f0e7545cdd0e435.1517098675.git.patryk.obara@gmail.com>
 <20180130013759.GA27694@sigill.intra.peff.net>
From:   Patryk Obara <patryk.obara@gmail.com>
Message-ID: <e3c203f8-7971-40ce-8d9e-2dfe35f51a8a@gmail.com>
Date:   Tue, 30 Jan 2018 17:30:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <20180130013759.GA27694@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/01/2018 02:38, Jeff King wrote:
> On Sun, Jan 28, 2018 at 01:36:17AM +0100, Patryk Obara wrote:
> 
>> This extension selects which hashing algorithm from vtable should be
>> used for reading and writing objects in the object store.  At the moment
>> supports only single value (sha-1).
>>
>> In case value of objectFormat is an unknown hashing algorithm, Git
>> command will fail with following message:
>>
>>    fatal: unknown repository extensions found:
>> 	  objectformat = <value>
>>
>> To indicate, that this specific objectFormat value is not recognised.
> 
> I don't have a strong opinion on this, but it does feel a little funny
> to add this extension now, before we quite know what the code that uses
> it is going to look like (or maybe we're farther along there than I
> realize).

Code using this is already in master - in the result of overwriting
data->hash_algo, every piece of code, that was modernised starts using
the selected hash algorithm (through the_hash_algo) instead of hardcoded
sha-1.

As far as I can tell status is following:

Once following topics will land:
- po/object-id (in pu)
- brian's object-id-part-11 (in review now)
- upcoming brian's object-id-part-12 (not sent to mailing list yet)
- few more object-id conversions and uses of the_hash_algo

we'll be in state, where just dropping new entry in hash_algos table
will enable experimental switching of object format.

With changes listed above "git hash-object -w -t blob" and
"git cat-file" work with NewHash (whatever it may be - brian is using 
blake2 in his experiments, I am using openssl sha3-256).

Right now I am looking at updating index structures and functions - 
after which git commit should work. In the transition plan it's 
described as "introducing index v3" (are there any new requirements, 
that constitute "v3" besides longer hash?).

> What do we gain by doing this now as opposed to later? By the design of
> the extension code, we should complain on older versions anyway. And by
> doing it now we carry a small risk that it might not give us the
> interface we want, and it will be slightly harder to paper over this
> failed direction.

Mostly convenience for developers, who want to work on transition. 
There's no need to re-compile only for changing default hashing 
algorithm (which is useful for testing and debugging). I could carry 
this patch around to every NewHash-related branch, that I work on but 
it's annoying me already ;)

As long as hash_algos table contains only sha-1, users effectively see
this extension as noop.

> It wasn't intended that anyone would specify preciousObjects with repo
> version 0. It's a dangerous misconfiguration (because versions which
> predate the extensions mechanism won't actually respect it at all!).
> 
> So we probably ought to complain loudly on having anything in
> extensions.* when the repositoryformat is less than 1.
 >
> I originally wrote it the other way out of an abundance of
> backward-compatibility. After all "extension.*" doesn't mean anything in
> format 0, and somebody _could_ have added such a config key for their
> own purposes. But that's a pretty weak argument, and if we are going to
> start marking some extensions as forbidden there, we might as well do
> them all.

What about users, who are using new version of Git, but have it 
misconfigured with preciousObjects and repo format 0? That's why I 
decided to make repo format check specific to objectFormat extension 
(initially I made it generic to all extensions).

At the same time... there's extension.partialclone in pu and it does not 
have check on repo format.

-- 
| ← Ceci n'est pas une pipe
Patryk Obara
