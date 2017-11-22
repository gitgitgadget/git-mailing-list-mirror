Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8B420A40
	for <e@80x24.org>; Wed, 22 Nov 2017 16:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbdKVQ5U (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 11:57:20 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:37416 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbdKVQ5T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 11:57:19 -0500
Received: by mail-qk0-f170.google.com with SMTP id 136so17602401qkd.4
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zU8SJ+n55m3FjO1wAu/0JMkJhOyxMo0S9V/ApX83GDc=;
        b=u+ymB9tKKr5rEKqu3+4X/czhVItBI6LWx1/q3/i//plJITl+nfBBhn1H7Q/76NEJyK
         PjUccNH7mCSnt8liWqk3oB1wErtmnsfVLvWbkI+WNB818ePKq5ydUqWpvUskrwuBYLAi
         4kJdCUqaRGNZcYAbjzxt6fGuSDrV9G5AYfYpcSDis0FZw63/qRwz54dXNB3h/Ywu+30T
         R0H0R5mZLtBHM6fbk6L9Wv7Z9M2LqVZiay+/wB+v8aCmRDitAs6jT7hKaxmfAHofOP0T
         aR7Luu4M7KBkKdJ+Ixmq/DwiBhEyKM/ve1Cqi0qkmm3SeI785KAQiRzPxsTOL04AXIPz
         3MSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zU8SJ+n55m3FjO1wAu/0JMkJhOyxMo0S9V/ApX83GDc=;
        b=FpK0IWgKrGmnyB9uy9IYWQIdR3jDSbmuys5zliWKZAvvBSCqDyaqP9WHQsOpHHDEgM
         MOwsm1X3iA/UrKdU2jztGQxLq3v0x1eIE6oingGDWkzIuixs0VX5Hx13HNVsl2v6FENN
         /Drm1TJ5jRU0MeVYR7mPi7DH72MQEhmur3NsuNfTX8zzcbu9Z52+DORnX/2u7PAp/Z2/
         m+xfPJJ5JPJgdcHXQryIZUZzGf8Yl/wz46MNW2Gvebpy7uegC4scNSAQfFb6s9Byi8jh
         coBw1Z9A6cugrSfmGxZkA0wE2hdlpJcIdZIeVkZL/ofN9Jv5e0oSoXYhybhTRrhOc7PB
         z8nQ==
X-Gm-Message-State: AJaThX4AtInQl7TsLORpTR8gMB2DzcdSkwSfVHUnbeoxXfuBg7R8suiP
        rM7Mrz2xrDuOjrFzPedbmFUEZd+WkP3aYOs6CJttKw==
X-Google-Smtp-Source: AGs4zMbOGzzLqzKrskq4tasJnSRlN8DeGhzBo5EDmi9j/gapLGbAHgjoPepPZrvKq/rSHDB11+JGUmGtVJFW3J58Zfg=
X-Received: by 10.55.107.65 with SMTP id g62mr9336853qkc.295.1511369838398;
 Wed, 22 Nov 2017 08:57:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 22 Nov 2017 08:57:17 -0800 (PST)
In-Reply-To: <xmqqbmjuu4zt.fsf@gitster.mtv.corp.google.com>
References: <20171112212854.791179-1-sandals@crustytoothpaste.net>
 <xmqq4lpyajra.fsf@gitster.mtv.corp.google.com> <xmqqbmjuu4zt.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Nov 2017 08:57:17 -0800
Message-ID: <CAGZ79kaufHTT2dcfgMP-hve-Sj9G85SajDdGivKg1Ho3pu0Vgg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Hash abstraction
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 11:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>>> This is a series proposing a basic abstraction for hash functions.
>>>
>>> The full description of the series can be found here:
>>> https://public-inbox.org/git/20171028181239.59458-1-sandals@crustytoothpaste.net/
>>>
>>> At the bottom of this message is the output of git tbdiff between v2 and
>>> v3.
>>>
>>> Changes from v2:
>>> * Remove inline.
>>> * Add dummy functions that call die for unknown hash implementation.
>>> * Move structure definitions to hash.h and include git-compat-util.h in
>>>   hash.h.
>>> * Rename current_hash to the_hash_algo.
>>> * Use repo_set_hash_algo everywhere we set the hash algorithm for a
>>>   struct repository.
>>
>> Change for all of the above in this series looked sensible to me.
>> Thank, will queue.
>
> So... is everybody happy enough with this version that nobody minds
> more codebase to be adjusted on the infrastructure this series lays
> out?  I think this is ready for 'next', but just in case I missed
> some discussions...

yeah I was happy at the time of review; sorry for not saying so.
