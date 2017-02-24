Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3C18201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 17:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbdBXRyq (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 12:54:46 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34641 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdBXRyp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 12:54:45 -0500
Received: by mail-pf0-f196.google.com with SMTP id o64so1267033pfb.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 09:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cvaTJI7oOGbLwE/YIRBxjxYsogAC0wrYjlt0ICEYr3M=;
        b=Mscn2/muR44B953c0P0cM+TG+9EIlZXNzNTIifmsyRaPftXNDwPUWauvhH0vPeg+vZ
         OyVkAnzjyqUfajNNPn7tFXb3KgPzFCablq3kPyAQS2RxHcS6WwYOJOyblQVtCU61cId5
         5d9XQOX8v0EY6nVGFpls5tnwapRBCzE+dsilVzc+/GD/wQA1CGklt8C+AXQZCAo4p3PB
         h9E6mVreNFalsdzgJ2RhsKKYjS9FBgedl6f2rbjtHNJajOV5MrdKTn1j3AuQ1TjhxtXq
         9A7J7gnr5s4CCgjvTiI5eXU0PWtZ3i2SWOOIj8bhOqV0GoZhqxMdfAMPwWGojyH35LfL
         WsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cvaTJI7oOGbLwE/YIRBxjxYsogAC0wrYjlt0ICEYr3M=;
        b=gDPj/wlVN7+VsLMQRb5OuI0FS9cRKzTjZ2UDUjOMAU9JjKYNSCBzQ3IiT6FEJ9DDLi
         5K3GenbYKyybT3BurjluDPLc0LFUrVwqBb3IesAMPv1Ld7aOMOIsmOzeFLESLHBLOJpo
         KskQF9Sc+7nMJdjhlOvnG9L3xtVH4s1cyCi6TveeGOj6u7XD6YKdfoPCAUyQoUtXIYr0
         xI8MS6zMTkv5zVG80MaJzxTnMw36tzrRaEXkRgwK83+4qyUtfy3vxSt2kffZAfgT+Uri
         D6eDiuv0BkjK+XrKvt8Iqf0CtdFa6iXIqSUWVtx6nWZDGodNYpOtZcEccCvUmJUfQYdJ
         hKVw==
X-Gm-Message-State: AMke39nIpnnGUlA1+T3Nmvbc8lNpQ53mxEgKvK3f/PfDgnmrtEcfLalwmOkQftsM0NBTfQ==
X-Received: by 10.84.215.15 with SMTP id k15mr5441380pli.58.1487958378531;
        Fri, 24 Feb 2017 09:46:18 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id 10sm16221164pfs.113.2017.02.24.09.46.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 09:46:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 1/1] config: add conditional include
References: <20170223122346.12222-1-pclouds@gmail.com>
        <20170223122346.12222-2-pclouds@gmail.com>
        <xmqqwpcg7k6r.fsf@gitster.mtv.corp.google.com>
        <CACsJy8CerU-=PF6wqzUAM02jkrVVGJ5MA0NgL6z9bHn5KM6jiw@mail.gmail.com>
Date:   Fri, 24 Feb 2017 09:46:17 -0800
In-Reply-To: <CACsJy8CerU-=PF6wqzUAM02jkrVVGJ5MA0NgL6z9bHn5KM6jiw@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 24 Feb 2017 16:37:48 +0700")
Message-ID: <xmqq1sun5vo6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>>> +     if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
>>> +             return include_by_gitdir(cond, cond_len, 0);
>>> +     else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
>>> +             return include_by_gitdir(cond, cond_len, 1);
>>
>> This may be OK for now, but it should be trivial to start from a
>> table with two entries, i.e.
>>
>>         struct include_cond {
>>                 const char *keyword;
>>                 int (*fn)(const char *, size_t);
>>         };
>>
>> and will show a better way to do things to those who follow your
>> footsteps.
>
> Yeah I don't see a third include coming soon and did not go with that.
> Let's way for it and refactor then.

I would have said exactly that in my message if you already had
include_by_gitdir() and include_by_gitdir_i() as separate functions.

But I didn't, because the above code gives an excuse to the person
who adds the third one to be lazy and add another "else if" for
expediency, because making it table-driven would require an extra
work to add two wrapper functions that do not have anything to do
with the third one being added.

