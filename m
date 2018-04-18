Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3556C1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 05:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeDRFBm (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 01:01:42 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:43851 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeDRFBl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 01:01:41 -0400
Received: by mail-qk0-f170.google.com with SMTP id v2so498273qkh.10
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 22:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Nqork2UfFvO9PFGUzPr0r5jXI2ljKz3ay8wpfJxB6Q0=;
        b=XRvf/isnxQcdsb0KORDEmLYnjH0saGcS7fwyY6XwbTfH5HQs2YBlbRVyl8h3rSIXNw
         dknMlhXwDvNnXkT7N9y9bQWGsljEgqCI8lwpcHB5D5rh8CjMjH5LJM+XvSrWhpCcIHKc
         VI5C9RCmtQNmoFAEB/DcOKLpJZOX7YwDYgDeWy67S6YbyvTOMQJLv5e96mrDwDt1sujL
         Mw2fjOn34GHho/N91m+DyyMpmGkhnfPKwRvBoQNrVEpETErHWJeZOirHsbeapSretIgt
         bCG9izK0An1DtYQiqlTb+S13SP7vG7ej3kCFktPE2KYKtOMYgOx+zrANUAvJhEo7tBjf
         86EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Nqork2UfFvO9PFGUzPr0r5jXI2ljKz3ay8wpfJxB6Q0=;
        b=QZeGH/IjDBGpgtBQyP+FXV7gFOvV2Dcb7gsukPijHALBEUAMmqJm2WOOT6nZ4dRwh0
         3hOZkwqRMKH/vrzBXdoLqfYP826VA8hT9cNTbZKwbGZfG+MyNDurWAWJqGyygj52SQWJ
         K23f9YMnz0mG16nWv+8rprLmKS++zONDe2kJSN/X1Ps4N8bRxc2ISeh1tlDXc+RSgDu/
         4q1zirdMzJW3Di93F46k9DJhlagks2HPccY6SKFhGpL2oQpYSfqF2x1vh6Dg3/6a/YqO
         Rts0XfnVpTHp52wnVFEkLyPO2tTSa9joHI6PDOGjn8dlW5uS75dawbpCMaSM2MeNMHw+
         aK7w==
X-Gm-Message-State: ALQs6tCEWn2TixENj0QTSkgsAdrCzox28YThz98shk1DQf3259gXe0ae
        kRx2JlJbS8uEoADZs1QizLZtlROleDA5/vNxz2w=
X-Google-Smtp-Source: AB8JxZpbHoEQxFI+3Mt814K4ZflOt4En7/sGZB7MC7tGIrur5ord8AKd3XaUC3vg5dY68f8V2SKzU7kUegkZh5anlKs=
X-Received: by 10.55.99.199 with SMTP id x190mr574031qkb.91.1524027700364;
 Tue, 17 Apr 2018 22:01:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 17 Apr 2018 22:01:39 -0700 (PDT)
In-Reply-To: <xmqq4lk9l64o.fsf@gitster-ct.c.googlers.com>
References: <CAPig+cSHmxtsz2NNAFvbqXRFKE87ZVyUYpRigjgXE5p8LcR09A@mail.gmail.com>
 <20180417181939.247898-1-sbeller@google.com> <CAPig+cTgoD-GvpoBQ6tcGX4T2XhuKccJAZ40P76vxVD_PfEc9A@mail.gmail.com>
 <xmqq4lk9l64o.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 18 Apr 2018 01:01:39 -0400
X-Google-Sender-Auth: HMo-vkv0pSyGEWtxyF7I9Z-jnc4
Message-ID: <CAPig+cRHW3TwrqwrY9R0-v50Z5U8uz99Hn+ERtP_1Ey2K_Vk=Q@mail.gmail.com>
Subject: Re: [PATCH] worktree: accept -f as short for --force for removal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 8:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> Makes sense. A possible rewrite (of the entire commit message):
>>
>>     worktree: remove: recognize -f as short for --force
>>
>>     Many commands support a --force option, frequently abbreviated as
>>     -f, however, "git worktree remove"'s hand-rolled OPT_BOOL forgets
>>     to recognize the short form, despite git-worktree.txt documenting
>>     -f as supported. Replace OPT_BOOL with OPT__FORCE, which provides
>>     -f for free, and makes 'remove' consistent with 'add' option
>>     parsing (which also specifies the PARSE_OPT_NOCOMPLETE flag).
>>
> Looks better.  I am not sure if s/--force/-f/ in the synopsis
> section is warranted, but '-f' is commonly understood as '--force'
> (and that is the point of this patch after all), so it is probably
> an improvement to be briefer.

I meant to mention the synopsis change in the rewritten commit
message. The s/--force/-f/ for 'remove' makes it consistent with the
how it's shown for 'add' in the synopsis. (Changing it the other way,
so 'add' shows --force would also work.)
