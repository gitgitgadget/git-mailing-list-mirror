Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2879E20248
	for <e@80x24.org>; Mon, 18 Mar 2019 22:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCRWpn (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 18:45:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37948 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfCRWpm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 18:45:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id e10so11052813edy.5
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Gy+8rDZjbeswU77D/p3glrVYJfvy/dQEZ6Xir0o3yWQ=;
        b=WGkSemspMdresC0UehyGBqRqSSWQ6CVtXAQMmyLAe+4ME/w5DI2+nql7oXMd81AQA7
         DPTHCUzQEQH+SHCMye+CvvXxOqhlULnjmMdR2lToiRVdN10MpXVmXbfYe50ENfAI5Ova
         /VSiI+68vcnJU+JZTn2z/LY4UsNFHN4yZMZ/ZyyVvW4n1grw/4WfWx5hS+pJg4Sj/9pr
         cxa9IXv+WZlOHKffW2SFmIXDiXkaTDWwlzYMJvezbReSQ5/7Ey93DqkdjqVtiq1OFIBi
         PFEfFKSppn3Td/Pjj3vDrX+/7sZLIqlz7PdQjwwqSCsZ04kCnDv9obHLuHbq3uA8gyJU
         +qQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Gy+8rDZjbeswU77D/p3glrVYJfvy/dQEZ6Xir0o3yWQ=;
        b=GXuDonX+rpRTEvVLEo7QaSuWzh3P/vA04e4nNLUaL9N1XiUxpGxl+WRD3GgB39Tsm2
         hteXK1+LaNtPxktlN+d2Vz/s4mXe6x3fo0ls8B9vGUYHgVySNqBgs+dIeBoBE2cWZgQV
         NVL7mkQQzs63U3jdvWZIFhy2IJ7EWzdqp81BFg+Cjtzv4c9ubQBtg7pzdUXoDQ4YKPiv
         V4imqJ2ORhtJ5+N78CnxDsdbgkb9C8Y59/boqjXcJJNs10ITOYDO6nWxTimhjiP9ChPw
         tloSHGtS0Usawx99zMbZaWEuxdzaiRyA+jd1fBEmWyP5QrvBvqK7LrpvSlDOapw63uce
         cAkg==
X-Gm-Message-State: APjAAAU7SyxUHCuud/TcT0svOFdfnFyzRLJaQwC/yDntf0g5BYGZ9o6r
        BvpsCIMAYbZur50oxX6FlEY=
X-Google-Smtp-Source: APXvYqya0krwckUTcnQdrbxyftf670uDEFv2rFAUuWE7g9thzLIcjUBupQ2AuRosteKfgY5E3/4fjQ==
X-Received: by 2002:a17:906:6d56:: with SMTP id a22mr12345946ejt.211.1552949140941;
        Mon, 18 Mar 2019 15:45:40 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id g3sm850969ejp.31.2019.03.18.15.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 15:45:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 0/4] gc docs: modernize and fix the documentation
References: <20190318161502.7979-1-avarab@gmail.com> <20190318215107.GH29661@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190318215107.GH29661@sigill.intra.peff.net>
Date:   Mon, 18 Mar 2019 23:45:39 +0100
Message-ID: <87ftrjer8s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 18 2019, Jeff King wrote:

> On Mon, Mar 18, 2019 at 05:14:58PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> This series is unrelated (and does not conflict with) my in-flight gc
>> contention series
>> (https://public-inbox.org/git/20190315155959.12390-1-avarab@gmail.com/),
>> but the "git-gc" docs should be updated to discuss the
>> core.filesRefLockTimeout option and how it impacts contention, see 8/8
>> in that series for context. I.e. "you may have contention, but
>> core.filesRefLockTimeout can mitigate blah blah".
>>
>> I was going to do that, but then thought that we should also mention
>> that on the server-side we mitigate most/all of the contention via the
>> quarantine, see "QUARANTINE ENVIRONMENT" in
>> git-receive-pack(1). I.e. we:
>>
>>  1. Get the temp pack
>>  2. OK it (fsck, hooks etc.)
>>  3. Move *complete* previously temp packs over
>>  4. Update the refs
>>
>> I.e. we are immune from the "concurrently with another process" race,
>> but of course something concurrently updating the "server" repo
>> without a quarantine environment may be subject to that race.
>>
>> The only problem is that the last couple of paragraphs may be
>> wrong. That's just my understanding from a brief reading of
>> 722ff7f876c ("receive-pack: quarantine objects until pre-receive
>> accepts", 2016-10-03) so I didn't want to include that in this
>> series. Peff (or others), any comments?
>
> I don't think the quarantine stuff should impact contention at all. It's
> only quarantining the objects, which are the least contentious part of
> Git (because object content is idempotent, so we don't do any locking
> there, and with two racing processes, one will just "win").

Without the quarantine, isn't there the race that the NOTES section
talks about (unless I've misread it).

I.e. we have some loose object "ABCD" not referrred to by anything for
the last 2 weeks, as we're gc-ing a ref update comes in that makes it
referenced again. We then delete "ABCD" (not used!) at the same time the
ref update happens, and get corruption.

Whereas the quarantine might work around since the client will have sent
ABCD with no reference pointing to it to the server in the temp pack,
which we then rename in-place and then update the ref, so we don't care
if "ABCD" goes away.

Unless that interacts racily with the receive.unpackLimit, but then I
have no idea that section is trying to say...

Also, surely the part where "NOTES" says something to the effect of "you
are subject to races unless gc.auto=3D0" is wrong. To the extent that
there's races it won't matter that you invoke "git gc" or "git gc
--auto", it's the concurrency that matters. So if there's still races we
should be saying the repo needs to be locked for writes for the duration
of the "gc".
