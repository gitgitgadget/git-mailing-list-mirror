Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F162920988
	for <e@80x24.org>; Mon, 17 Oct 2016 11:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934917AbcJQLDX (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 07:03:23 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:37930 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932761AbcJQLDV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 07:03:21 -0400
Received: by mail-it0-f52.google.com with SMTP id 66so4481051itl.1
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1qslefoU5Oszx86NCvuWsgIG3AV5Ecq/Ibeb6FU0WVE=;
        b=TopzItwP8PnsTu23HkAb5BSa6gvL2ZbkVj4aI5MtsSqIcuCNt3cYtUpcRdLzQSvVkC
         nFgvppRX0m8BYycV2m9JjuonlBG9T7sU5VveqvFOWuwOQA3ODmybgCSrqBS3MGT+aAtR
         fWmiF1dzcdbIv6i6f93C4UToM4NC7lTS3YJv3+91/yuoPd+AWblWRh5GoA/TZLyT5jEV
         bnVGc9voGHsx433HnbVYpNL+oqrsbic57yxJpsbZ7WyZqkvbYwzSDcr/fUsE9081hVZX
         3f1ykundRDXIdJYNmRCWCgK93HbMI3KEybNQk5Bmot7PloNmmcrKdbPUIUkMswHhgAQB
         rN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1qslefoU5Oszx86NCvuWsgIG3AV5Ecq/Ibeb6FU0WVE=;
        b=itk93+iI9NzB1TCt0O8BpUzov64yIdkiVxdo7FFtd6/3iZJAU5ArKGMmYBsNN7DCS7
         aD9uXZBFHprHTxHwFO0XEuDValXgKVEFLk0QJA+z4jXUEvUIFCQAVYgiau5BvNpuWE94
         Dt5FHt+00qwW0LreIqk3zywJsVLLEYF77vgxt9Fu8rz3iQ8NjiHGK7FChoBtPEx1TXhE
         qeDy08JOgGtNl3I57Xx2i4KEbIOf9BeUsdQfI26lyybrWVGSc5frkztZZWHeOPmgl/MH
         rSHLD8zsut6s3rssQF9JKZf0sph/+hpp3X8kaSJCIxiHBy0Mr8SIy5hklzGPnG8MD36f
         5MZQ==
X-Gm-Message-State: AA6/9RmsR8XLTS0DAIezHcCYETIs1PqxMWrfkyBSw+W1EZ5hrb/Ak0VNNGhFw2QKNv5Xqf3yXwy1MpegO0YaGQ==
X-Received: by 10.36.216.4 with SMTP id b4mr8649934itg.74.1476702200942; Mon,
 17 Oct 2016 04:03:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Mon, 17 Oct 2016 04:02:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610171241240.197091@virtualbox>
References: <C83BE22D-EAC8-49E2-AEE3-22D4A99AE205@gmail.com>
 <CAGZ79kZ6KaQ5gjGiEFQ-pRJCDAyS0oH=_4dK0nCU9hx8wZwdfw@mail.gmail.com>
 <alpine.DEB.2.20.1610171056170.197091@virtualbox> <CACsJy8BBLcZvB1FswcEKS1KgvjMjo_uaVqOTgjmMJkjnmoye+w@mail.gmail.com>
 <alpine.DEB.2.20.1610171241240.197091@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Oct 2016 18:02:50 +0700
Message-ID: <CACsJy8ASnvryrrWvr4ACWL_9oeKgE_4SUqcRHGf+Y6kcaeDUhg@mail.gmail.com>
Subject: Re: [RFC] Case insensitive Git attributes
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2016 at 5:46 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Mon, 17 Oct 2016, Duy Nguyen wrote:
>
>> On Mon, Oct 17, 2016 at 3:57 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Hi Stefan,
>> >
>> > On Sun, 16 Oct 2016, Stefan Beller wrote:
>> >
>> >> Conceptually I would prefer if we had a single switch that indicates a
>> >> case insensitive FS.
>> >
>> > AFAIU Lars' use case is where the FS is *case sensitive*, but he still
>> > needs the .gitattributes to be *case insensitive* because that file
>> > originates from a developer with such a file system.
>> >
>> > Otherwise he would simply tack onto the core.ignoreCase flag.
>>
>> That sounds to me like setting core.ignoreCase to true (on all devs'
>> repo) would "solve" this.
>
> It is good that you quoted this verb, because it does not solve things.
> Instead, it would try to use the flag for two slightly incompatible
> purposes at the same time.
>
> The first (and so far, only) purpose is to tell Git that the current file
> system is case insensitive.
>
> The new purpose you described would be to tell Git that the *user* does
> not care about the file names' case, even if the file system does.
>
> I do not think that this leads to a better situation than before. Instead,
> I am convinced that it will cause new and sometimes "entertaining"
> problems because you can no longer discern between those two purposes
> based on core.ignoreCase, you would have to teach Git to test every single
> time whether the file system is case-sensitive or not.

I agree. Which is why I wrote "we probably want something in the same
spirit but limited to .gitattributes and .gitignore only". In other
words we could have core.someName that makes .gitattributes and
.gitignore patterns case-insensitive (or core-sensitive). If it's
present, it overrides core.ignoreCase. If it's not present,
core.ignoreCase decides. I'm just not sure if the new config should
cover everything involving filename's case in git. That's too big to
fit in my head.

> Needless to say, I'd rather not see that happening. Many users, including
> my colleagues and myself, rely on Git being a rock solid piece of
> software, and that change would make it less so.
-- 
Duy
