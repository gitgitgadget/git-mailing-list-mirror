Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1B52201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 20:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934861AbdBQUth (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 15:49:37 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33933 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934090AbdBQUtg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 15:49:36 -0500
Received: by mail-pf0-f195.google.com with SMTP id o64so4771718pfb.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 12:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=HaQyCNGz0wlvb30bI2CXfH/ZqPr8UVujU3CkCFzEbNw=;
        b=F3OCb49yXVR8KDyDNXM39k7jw9JL4+VEGsaF4l1+cacv7POKK1DuGOMTw1+VqtCyKy
         tjGrdvqv6+BISz8Zp9I7MhNkD4qsY9X5Sdpq85IMnz1tY3gVEq0fQj+fNZq1KK04AmJn
         8R1sB4CasaazcTNTuvZKt0yDB+Yd2vmnO0e3keNTGyVbVXwJo5DaWsIia0l0wsIodJUc
         T1eGDOoMLxSZ7tMWWZy9R4y1E55FH8BkCX1Hvy37iN1T7Ph+pHHQiU0XJDftdvYL8sM4
         M5nUMHgJgPiXbI8iHK4Lw6XxXMPdPSV9DaXLFgBEpaOYVcxlDbxJexhMSsH2C7tpwps/
         xGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=HaQyCNGz0wlvb30bI2CXfH/ZqPr8UVujU3CkCFzEbNw=;
        b=XOw8MtuZBYXw8naT2lGNpJPE6MiraZdPI/QGAJ9L8eGKb828hNYkABYDcxwcM8FxG7
         AZP97LWQqRfjigjdBgbsnExJ27sSeda/x7dH7pf4E8ByR9o/gOHL789hFtjUgv0cax7P
         yTkHlvAUNbG9HAHrl2rlX1K0uM7C1pJ+gud6KwrzwpIgI1ktDqXcJw3qe4e7vUJMAD9Q
         xWJqUjeTaOHCh5H6KX3R62fF0HxgGZLYfCaDxb2D3gdnFdmwb8w4av5w1Pz0zYPsB25e
         NoGj+S+z5gYNsVnNT0B1BsuF8+mlFrfZHRfASKqeBzEQsj6uLEG+bj+wl+xyMvrGmhdE
         Lf6w==
X-Gm-Message-State: AMke39k90CYSSzMh+biqPUx/zzFSlNK1bWeQUWlPI8k9jwvXEP9BNZd5Oo5Mofilc9ZX9Q==
X-Received: by 10.98.210.3 with SMTP id c3mr11551842pfg.7.1487364544173;
        Fri, 17 Feb 2017 12:49:04 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id 64sm21200425pfz.48.2017.02.17.12.49.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 12:49:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
Subject: Re: [PATCH v2 00/16] Remove submodule from files-backend.c
References: <20170213152011.12050-1-pclouds@gmail.com>
        <20170216114818.6080-1-pclouds@gmail.com>
        <xmqqzihksm0i.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 17 Feb 2017 12:49:02 -0800
In-Reply-To: <xmqqzihksm0i.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 17 Feb 2017 10:35:57 -0800")
Message-ID: <xmqq8tp4sfup.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>> I'll be sending two more follow-up series, if you are interested, soon:
>>
>> 1) v2 of nd/worktree-gc-protection
>> ...
>> 2) the real worktree-gc-protection
>>
>> This series adds a bunch of new refs API, enough for revision.c to
>> traverses all sorts of refs with a ref store instead of "submodule".
>> Many _submodule API are removed as a result because they no longer
>> have any callers (yay!). One of them remains though.
>
> Yay indeed.

Having said all that, I have a bad news.

I won't be able to queue this as-is, as this heavily conflicts with
mh/ref-remove-empty-directory that has already been cooking in
'next' for some time.  I started trying conflict resolution myself
and it seemed doable, but stopped after finishing perhaps 40% of it,
as I cannot afford the same amount of time for conflict resolution
every time the series gets rerolled.

If the topic is rebased on the result of doing:

 - checking out master^0
 - merging mh/ref-remove-empty-directory on it
 - mergeing mh/submodule-hash on the result

I suspect that we might be able start cooking it in 'pu' sooner, but
I cannot spend any more time on this topic today so I'd stop analyzing
the situation for now.


