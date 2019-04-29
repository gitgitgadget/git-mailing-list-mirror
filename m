Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6961F453
	for <e@80x24.org>; Mon, 29 Apr 2019 15:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfD2PO4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 11:14:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44743 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfD2POz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 11:14:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id c5so16577210wrs.11
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PZs/C+5Svpfe8LX1ZzEh9exqPE90zWBZj4AC/OiqIHE=;
        b=j+8XYXhechFb1Yk4AZWaCAX9W+pGjnxjSoWYXsezTcmcyAOE1mo2u+bjwqCNEHQ2/h
         ez6jBedB+puah9U63OFDN+YeF1+eBXXcJduClbmZNdKNjXq8uc+Sz82xkCsOK/M07luK
         lJuSsCHg6fxzdGxECSTfx8XeYMz6oUTGZAO7+BIhOkN3U7XC5kMI0HvtU8rrVaSKc0+I
         8z7AVV7+CsKNRrrIsxjyOxpxi/zWAM02VQd+1TksLO/vE+wsRZCEK/Y3sUqbSl8vvT5J
         YvE+C5V+qbfj2f2mJ0relJGQXPDyoCPW7jsb4KBHFb48vYCWWwl/pneYTgUhCX9fNhtW
         43+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PZs/C+5Svpfe8LX1ZzEh9exqPE90zWBZj4AC/OiqIHE=;
        b=YmYbKH9Anp5+TMbkWxYUAB6KjUlPHaAJRFgH8HMwk2lGJV+k79LFVIFJWXuBvMmB6z
         DHZnOwPoBhawoq7XyBuzjVqxbpA8G6uf3rLD6JuFUsqC8UI196FMmKFF50qKCZYFsVO1
         uJWmjfHzsENSgOQ1HxNTNWz3kTbJb4TF2kmGjf97+1UI5y6tzj3ybTNGNew0u2myiEX5
         1Bp7PrlA95bNrw1xWUm6ICAicWkDp3pm4Xun6iSQ4iBefuHJgCeEdG4uAV3vGR/N8VRr
         sBj0Mr9ha715vSualfl9qUcGviAwvL1kdOgE3In+/MJdrlgFaCfrW/DvtTIpknenu/sT
         BFrA==
X-Gm-Message-State: APjAAAXCqoHldBwZpxHYCkAHKNLYOw2rhV8PH3nv3udkxK0x0ivOFlCw
        AUZqiuuWc9cMaVzNaeNrPrMH1fgvuOY=
X-Google-Smtp-Source: APXvYqyJrhvgd+p8yLKB5UZXtTLi7Fja8IJFHh9tOSXYM51TZwGWFItyQaseMZxCxsbkTJLRic+PVA==
X-Received: by 2002:a5d:4989:: with SMTP id r9mr17861963wrq.173.1556550894130;
        Mon, 29 Apr 2019 08:14:54 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id s3sm31096494wre.97.2019.04.29.08.14.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 08:14:53 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 15/27] switch: add --discard-changes
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?Q?Eckhard_Maa=c3=9f?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
 <20190329103919.15642-16-pclouds@gmail.com>
 <17402ee1-68c1-e51f-dc32-0795e0b63bc8@gmail.com>
 <CACsJy8BF5DwykEmmPGDR7+AzhOAFreJnML073K0xNBdTDjqMJg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9848d618-04f6-2472-f267-5926a030f5f2@gmail.com>
Date:   Mon, 29 Apr 2019 16:14:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8BF5DwykEmmPGDR7+AzhOAFreJnML073K0xNBdTDjqMJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/04/2019 11:12, Duy Nguyen wrote:
> On Thu, Apr 25, 2019 at 5:02 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 29/03/2019 10:39, Nguyễn Thái Ngọc Duy wrote:
>>> --discard-changes is a better name than --force for this option since
>>> it's what really happens.
>>
>> I didn't realize when I suggested the name that --force overwrites
>> untracked files as well as discarding changes from tracked files. I
>> think we should document that. It would be nice if read-tree --reset -u
>> took an optional argument so read-tree --reset=tracked -u would not
>> overwrite untracked files. Then we could have --discard-changes just
>> discard the changes and not overwrite untracked files. I had a quick
>> look at unpack trees and it looks like a fairly straight forward change
>> (famous last words) - perhaps I'll have a go at it next week.
> 
> So, --discard-changes is all about tracked changes, and we may have
> --overwrite-untracked to cover the other part, and --force enables
> both? 

I was thinking of --discard-changes dealing with tracked changes and 
having --force for untracked changes as well. I'm not sure we need 
--overwrite-untracked for switch, just for read-tree.

That does not sound so bad (and maybe a good cure for those
> "overwriting untracked" reports we've seen quite often lately).
> 
> Good luck with unpack-trees.c. But if it turns out you're too busy,
> just let me know if want to hand that back to me.

Thanks, I've got something working, I'll clean it up and send it later 
in the week.

Best Wishes

Phillip

