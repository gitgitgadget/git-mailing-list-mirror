Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE391F453
	for <e@80x24.org>; Tue,  5 Feb 2019 15:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfBEPXM (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 10:23:12 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:45725 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbfBEPXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 10:23:11 -0500
Received: by mail-ed1-f46.google.com with SMTP id t6so1889630edw.12
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 07:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QWn/+0u0yYE7FFve/yg8dDJo4dbNWo74clJJeo0SjjY=;
        b=XsuE/F/MyAAdPQXEaENa9K+IHdYpUMibe2JnicWBBXxzs02RwENfj1EIr0N2ZAOIHL
         9UIxFxl94QmSwgkoO33wDtPo3hXqlT2+p0HyAZYywRzGkJIQFOEBBu7mPH6yRofXYwpT
         xAYEwCHTOzNaR23qj6ONcEFbVXQEoj1SOXhnVRJiqUY+dB9Bt7a6l1qvqlI/wm+RAxQe
         IK2RNaNutmbR7t3dC9Q5iqm58pjqj0TMh2I5uMlPslANs8TcdCmRIb9PANE4VoPleW2g
         U97LpYBxagJo86U1bIwSF6d/d/XOuQ0AlyF6HTDg1HfpS6jRnPF4yjm6psLp+SV/VPSZ
         P0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=QWn/+0u0yYE7FFve/yg8dDJo4dbNWo74clJJeo0SjjY=;
        b=Gv297jJp/tpQ3TCq/N2pumj0jDXsWZfuVxpb5bdqRMBgMaDILyYkxZ9w3gdH4AMFAO
         3aYEJPEsGmPLjX6/TjETAxEvHMXZa2LbzeoF5qCP5/dEXD9Yhy5XWTnfA+3vmO1mw/u2
         AyNpPSX6JNQ0FJWschoRlyMMW9K9MGjKdaef8CDPa803IukTcBjhkIoQV++AKYsUyHDe
         8n6amjpMV9hNC3Ftxr+ebG7of+Lo0ow4kuQPtTVSvInBr1/RILJi26e7W/K0QZ012YGt
         xIjVcNTJgsnBWRVS4LRs4/UVej1qsYBNFWnHHLpUwxhUTTqU3hmi3nFn586VwFC6WfcP
         uumg==
X-Gm-Message-State: AHQUAuY87v2WJ7q324iLx1oGXnTgeotFMxrwu6m0HKgjjjkqHMZEtGRx
        7k9RsPRqhs/3cHOe9ouL7I/gySNXXY4=
X-Google-Smtp-Source: AHgI3Iba0mWswbUBTD/ihoUXJ04YW/IIvkKXDT9lRSCStS7QInvbYxrcP9ojLtbUUcYM7cFizgfszA==
X-Received: by 2002:a50:87a7:: with SMTP id a36mr4457049eda.96.1549380190080;
        Tue, 05 Feb 2019 07:23:10 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id k31sm5160182ede.5.2019.02.05.07.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 07:23:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dani Koretsky <Dani@cybereason.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG]: git checkout on a new tag with current HEAD shows "head detached" at previous tag
References: <CANcfovV3Pq3pubtNq4HCSZOJ5OC9dVSm+19VkOiQimAH+fttYw@mail.gmail.com> <87munal0zb.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <87munal0zb.fsf@evledraar.gmail.com>
Date:   Tue, 05 Feb 2019 16:23:08 +0100
Message-ID: <87lg2ul0o3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 05 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Feb 05 2019, Dani Koretsky wrote:
>
>> I have 2 tags such as release-17.6.230 and release-17.6.220:
>> If I'm changing commits, all works as expected.
>>
>> If however both are pointing to the same commit, the output is as follow=
s:
>>
>> git checkout release-17.6.220
>> git status
>> HEAD detached at release-17.6.220
>>
>> now if I run:
>> git checkout release-17.6.230
>> git status
>> HEAD detached at release-17.6.220
>>
>> Which is theoretically correct, but I'd expect after checking out a
>> certain tag I'd be see that specific tag...
>>
>> Sorry if this is intended behavior, I couldn't find clear mention of
>> this behavior on the git checkout documentation online..
>>
>> Let me know if I can help in anyway.
>
> You're right about this issue. I haven't dug deep into this, but just
> enough to see why this is. When we "git checkout" something we write to
> the reflog that we moved to such-and-such a ref, we then consult the
> reflog when you run "git status" to see what we detached the HEAD from.
>
> As you can see if you run "git reflog" after you check out the first and
> second tag, that entry doesn't change, and we still note just the first
> tag you checked out.
>
> This is going to be because of a short-circuit behavior where we see "oh
> we already checked this out".
>
> Maybe that needs to be fixed as a bug, but would have more implications,
> i.e. are there cases where you can flip-flop and end up spamming the
> reflog, should the post-checkout hook run or not in those cases, etc.

To add to this: I think there's a good case to be made that this is
definitely *not* a bug, and changing it would be introducing a bug.

It's 100% true that the "HEAD was detached at" the first first tag to be
checked out, the subsequent "git checkout [other tag]" was a noop.
