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
	by dcvr.yhbt.net (Postfix) with ESMTP id ABCC81F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 11:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfJaLAH (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 07:00:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36396 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJaLAH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 07:00:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id c22so5413051wmd.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 04:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+EZnSDQvvf8Fvdr1taiHcjMV7LggeJfErmZCnwhrO9k=;
        b=h2rkcaLz5RrCx2SGSSsgPUtIPw5bkQIPj2AenLIKYchmI4tcy3BL1MhrGGpXcFd55e
         N19kJa6u+DNEBNRCyWVJXlUSm47rClNRnnPZgWw3/maGgLmU9IJgcy4EXxnG/ujpUV4D
         9la0uscffYe0cXPvHclRo/P+LPq+D3jTCFQk/4MllckLmKqhX+cyRaQIQEGw1mHJpMUa
         chcbbtgBiibEea7zoRw62QqcXhMV8qNsvFhZc2mNqASeqWKQHW7eY5AhArTKWsplswWI
         Z7n5rYIZycxxkATFEvOgq4fFqRV4U2NymENhhQqdLTcx1xKnPkYBCvx3JTO2vyvxZGXQ
         qFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+EZnSDQvvf8Fvdr1taiHcjMV7LggeJfErmZCnwhrO9k=;
        b=O1U3OSQt1b6XevY1sv1ZQgFEmrDQao7MQGYDhBpnojBhn3PEyATYUd3Gzs99Muv4W8
         Ob2rU+a6+kWvsYvG87NL25lzAFO4bW3d70FI9lnT397iYOi8ddN2gTinr1KzSQhlANff
         KQGgMG0GZyJZcolJ5rdRqkoGV6kAzfImkE29lli170SqffOUrPSvbWOoLaoGlPe+8/4f
         bfnPbO/k5QYn8VFHRYF0WZGsxwbMPc5xkcHFmDOUgAf1F2IKKWZJKYVuegtZslTIB3CL
         cr2+hGqsBR379+hoH2p5OtxOtlDLtmYQ4xdxvIuoquAswYC8BCmah+gCxJzt6eoTBzYE
         2q3A==
X-Gm-Message-State: APjAAAWstsE676YvPHQYoKUyl+UdtLho9VzbKNgaw5vbPr9h1KnicRiP
        UyEUOInnyxt2zrRVp91k7cEuY7os
X-Google-Smtp-Source: APXvYqyRwBpetQ1UoVXB/GJmjXuuFlaqJJCUP5rfsnowjYueYPUplyR05IJ6CINnJHha+6NlMlqoyg==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr4470377wmc.30.1572519603723;
        Thu, 31 Oct 2019 04:00:03 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-20-250.as13285.net. [92.22.20.250])
        by smtp.gmail.com with ESMTPSA id t29sm5801857wrb.53.2019.10.31.04.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 04:00:03 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git branch --edit-description a custom file
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
 <20191030224328.GB44961@generichostname>
 <20191031061832.GA20830@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8b9021fa-f60c-a2e0-1174-a2fc1f11c476@gmail.com>
Date:   Thu, 31 Oct 2019 11:00:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On 31/10/2019 10:22, Johannes Schindelin wrote:
> Hi Peff,
> 
> On Thu, 31 Oct 2019, Jeff King wrote:
> 
>> On Wed, Oct 30, 2019 at 03:43:28PM -0700, Denton Liu wrote:
>>
>>> On Wed, Oct 30, 2019 at 04:28:35PM -0400, Jeff King wrote:
>>> Dscho brought up in the GGG thread[1] that perhaps we want to treat
>>> branch descriptions like notes and have them all under something like
>>> `refs/notes/branches`. This would certainly solve my problem of
>>> having versioned descriptions and it would probably do it in a much more
>>> general way than having a versioned included config.
>>>
>>> Anyone see any potential problems with this approach?
>>
>> I don't think it would be `refs/notes/`, as that is assumed to contain
>> mappings of object ids (and if I understand correctly, this would be a
>> mapping of branch names to data.
>>
>> You could just have "refs/meta/descriptions/foo" pointing to a blob
>> which contains the description of "refs/heads/foo". That makes it easy
>> to edit descriptions, even if you don't like using "git branch
>> --edit-description".
> 
> The only problem with this is that it's not really versioned, as it
> would be hard to go back to previous versions and/or share the history
> via pushing to a remote repository.
> 
> But I guess that a very simple pseudo branch would do it, where
> `refs/meta/<branch-name>` would point to a commit that has a tree
> with a single file in it: `description.txt`.

Having some way to share branch metadata would be nice. I like the idea 
of using commits so we can merge changes and revert to a previous 
version. There is some previous discussion here [1]. I'd really like to 
be able to share the upstream for a branch between two computers as 
well. I also use a commit containing a tree with a single file stored at 
refs/todo/<branch> (and fetched to refs/remote/<remote>/todo/<branch>) 
to share todo lists with notes and ideas for future commits on branches 
that I'm working on on more than one machine. Having them version 
controlled so they can be merged has been useful.

Best Wishes

Phillip

[1] 
https://public-inbox.org/git/1519324188.6391.156.camel@mad-scientist.net/


> I now like that idea a lot better than my original notes idea.
> 
> Ciao,
> Dscho
> 
>>
>> You could also have "refs/meta/descriptions" to point to a _single_ blob
>> with all of the descriptions. It could even be in the existing config
>> format. And then you could include it with "[include] blob = ...". That
>> doesn't exist yet, but it would be easy to add (it was something I had
>> always considered when writing the config-include code, but there was
>> never really a good use; and you do have to be careful about pointing to
>> untrusted blobs). That's a convoluted way to get where you want, but I
>> wonder if integrating to the existing config system would have any
>> benefits. I haven't really thought it through.
>>
>> (Of course that's also only one step away from having a versioned config
>> file in your .git directory, but it might possibly be a bit easier to
>> manage, since it would always be committed).
>>
>> That's mostly off-the-top-of-my-head rambling, so please disregard
>> anything that seems totally off-base. :)
>>
>> -Peff
>>
