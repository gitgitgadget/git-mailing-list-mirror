Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52BE81F45A
	for <e@80x24.org>; Sat, 17 Aug 2019 09:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfHQJ3C (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 05:29:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39576 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfHQJ3B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 05:29:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so3783846wra.6
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vlkOYIDtaay6ulED0BmK1+TMlI9LbEbZDYrxw54xctM=;
        b=RL9MEIKXEZNqtcFhiaYZTxf1w9MPhT8B4xBZxmAkHSVRUJZLlfBls7nLluXSX8V6JF
         ER/+2xupPMN7il/O0qKl9hOWWa7P6A1dWg64qZ4D3yHhSSkz503fUAA/8SNWGAkWZLwB
         0BPnE8JOP8qzkoeI4tFPQ1uOzkUnL1Ops55aV1I+FZwo7yNkIPupVPMFc+eMeBSQUYLn
         0zzSxbFHbH6aZHngAE1sjHj8WyO5E0eiHFqlpuOqCA9UkxTwmmJSNDitiO0NRwgQ3lM4
         Z147n50kLASCGE+B6GzBeszL5IAfgU6VQS/+QR8LBW3h8maRLln9NFOj+/KOXvtf3PYE
         vghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vlkOYIDtaay6ulED0BmK1+TMlI9LbEbZDYrxw54xctM=;
        b=CGS3Ox5t+YzBEaF6lXxCjwYpycXIpItVd6s+MGEAP4FJaUJ2ybdL0eKRxGu+FYytFc
         KL4Z+fo2RF6nG3my2d4zNHeiXJbe/qh/u2j60grp4Rcqkc9/2gShigFeT2Da8D+/9GeG
         TsaL45IEuJNBKIWaXDqEURfQX4+lyU+bWT9kA6nxNMh++u8nmKRWzuqnI7aBjB+vF1jX
         laFXmCg8vZxH0GIRMho39nECw3OEudWZhYeLHlywDeJDoSlybXeAoOuglZY9PwYNqyQ0
         zlQ6fWoCmANAlPYXumFp0jg1DozsXxro0TBPZ7nPlh+snIBQGuuru7fC6M+ehwlBnRaX
         La5A==
X-Gm-Message-State: APjAAAWU4Yg2YQDKgqVwo5jEfysFMc32caKfhg60R/FVFX42NiGJI1bW
        L6LtMca5wuZ+srH4+1K4fBV7NAfP
X-Google-Smtp-Source: APXvYqxDWGl0t5wTddm91jqLhPv+mrI7C0lZge4uS1EXr5hhpLUF4JSz8cUJXSY8RK1EUwzsseA6pg==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr14968832wrm.12.1566034139557;
        Sat, 17 Aug 2019 02:28:59 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-12-34.as13285.net. [92.22.12.34])
        by smtp.gmail.com with ESMTPSA id g14sm14459109wrb.38.2019.08.17.02.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2019 02:28:57 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 5/6] rebase -i: support --ignore-date
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-6-rohit.ashiwal265@gmail.com>
 <xmqqblws7n8r.fsf@gitster-ct.c.googlers.com>
 <c03439bf-54bf-b53d-9400-bdc4dd2a1309@gmail.com>
 <xmqq8srv5ypo.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8104c7e7-e29c-5a41-4097-55912dbe9fc5@gmail.com>
Date:   Sat, 17 Aug 2019 10:28:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq8srv5ypo.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/08/2019 20:33, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> That's an important distinction, particularly if GIT_COMMITTER_DATE is
>> set in the environment - are we aiming to have the author and
>> committer dates match or are we just resetting the author date to now?
>> Rohit - do you know which --ignore-date does in the am based rebase?
> 
> The purpose "am --ignore-date" was to ignore "Date:" that came from
> the patch message, overriding it with the current date.  It might
> have become harder to read in the C version, but "git show v2.0.0:git-am.sh"
> would be an easier way to read how "--ignore-date" wanted to behave.

Thanks for the pointer, looking at the code I agree that 
--reset-author-date would be a better alias. If GIT_COMMITTER_DATE is 
not set then the author and committer dates match, otherwise the author 
date is reset to the current time. The code also shows how we should be 
combining --ignore-date and --committer-date-is-author-date.

Best Wishes

Phillip
