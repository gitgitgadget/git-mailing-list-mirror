Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C80E20954
	for <e@80x24.org>; Sat,  2 Dec 2017 03:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbdLBDqH (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 22:46:07 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39337 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdLBDqG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 22:46:06 -0500
Received: by mail-pg0-f66.google.com with SMTP id w7so5302159pgv.6
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 19:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+VkotjyvMtTffnBAs5tglWmJ4sanBrKw7Wh/orUsGI8=;
        b=sgXVJGiXKHj0MqW1pzbHY3ULsO2G1BU6ffzXGVGZcx7DSeJjFwcjmATy0mmRBb3mEt
         HDJSPoCinPAGDIRVBHwsLLv2RpST9sv5Phsr96/S5a/gAMDY7lIIYvUw37MkIbUwJRpm
         xadeoHNMFPB3FFn+QCtFcs1a/eHXdb203Q0nh5V7vF+KBtLa/awEz/Ai+G6KRx6BUuQx
         sP4oGA+xqdPEm5lDw/h8Mzc3yySpgHmNsFk6TxfjPueZdnL3dpIer2MvZN6EpMmghaOh
         BHjdCtOCmi5Yn9agPKAsyvPYSc87v3T718W7QVtoRYQ6aGzoT8FSu4PSr05xaAtPCUVo
         ut5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+VkotjyvMtTffnBAs5tglWmJ4sanBrKw7Wh/orUsGI8=;
        b=Ik/shefYG1eAOrw3X7EOyEogabks2Q/Z58C1jNVA+5NKwrJk41U0eI1l5o/RbhG67w
         SdVxuXGyapDe7O/0zs9iW4/67fMlTD86LpJrMXN9GHFNMjK5ZDuhOwD8DuwLzZGq3Yzb
         m+dJoabkl4WJlvNK1/ZEJmWDnkMHzLUOfah5lWz3HAWcmZL7+MyZy7E0TVjyoFfn2HrP
         ot1LGxkKG1at2okzkUSvUorO0IPW24mezyhzVo0RcA1mdYK+REmr6aaJUVt+/ifCmE5U
         3d6NzwHRvYfloSPrFCCAWIKawyE6ZLk8yHK1a4SjHcd5Qn6i2vFAL9SPUNnJZjzXnZ4k
         YrJw==
X-Gm-Message-State: AJaThX7gVhyhZlcZiMjyJVGR6P3I3CiCqn5av9zFSLxSkxi6QozPz5sZ
        gv7emWdy90ecuW7Y3C7xcaY=
X-Google-Smtp-Source: AGs4zMbkCh+zeYPZVZXRH/hzePk1MlgWzrTx0nOIkkR50j0zJbfyxKEhpvhFZBclW+5hhKPD4OQYxA==
X-Received: by 10.99.127.85 with SMTP id p21mr7950397pgn.425.1512186366233;
        Fri, 01 Dec 2017 19:46:06 -0800 (PST)
Received: from [192.168.206.100] ([117.246.221.187])
        by smtp.gmail.com with ESMTPSA id x4sm13730979pfb.13.2017.12.01.19.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2017 19:46:05 -0800 (PST)
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user
 input
To:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        sandals@crustytoothpaste.net
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129143752.60553-3-lars.schneider@autodesk.com>
 <20171130205137.GC3313@sigill.intra.peff.net>
 <BB878570-F214-4BAA-AB58-4A9C0F8F80AB@gmail.com>
 <20171201182924.GB27688@sigill.intra.peff.net>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <aacb7604-edc3-a920-da43-701b57045956@gmail.com>
Date:   Sat, 2 Dec 2017 09:15:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171201182924.GB27688@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 01 December 2017 11:59 PM, Jeff King wrote:
> On Fri, Dec 01, 2017 at 01:52:14PM +0100, Lars Schneider wrote:
>>
>> Thanks for the review :-)
> 
> Actually, I meant to bikeshed one part but forgot. ;)
> 
>> +                       fprintf(stderr, _("hint: Waiting for your editor input..."));
> 
> I found "waiting for editor input" to be a funny way of saying this. I
> input to the editor, the editor does not input to Git. :)
> 
> Maybe "waiting for your editor finish" or something would make more
> sense?

May be the good "Launched editor. Waiting ..." message, that was used in 
a previous version, itself makes sense?


> 
> Or given that the goal is really just making it clear that we've spawned
> an editor, something like "starting editor %s..." would work.

There was already discussion related to the "continuous tense" used in 
the phrase.

Extract from [1]:

-- 8< --
 >                 fprintf(stderr, "Launching your editor...");

"It takes quite some time to launch this special Git Editor"

As Lars pointed out, the editor may be launched in the background,
that the user would not know, but they might expect a thing to
pop up as a modal dialog as is always with UIs.

So despite it being technically wrong at this point in time,
I would phrase it in past tense or in a way that indicates that the
user needs to take action already.

The "Launching..." sounds as if I need to wait for an event to occur.
-- >8 --

[1]: 
https://public-inbox.org/git/CAGZ79kZbm8SGY4rXKZHV82E-HX9qbQ4iyCbMgJEBFQf4fj3u=Q@mail.gmail.com/


> I think
> the "waiting for..." pattern is perfectly fine, though.
>
