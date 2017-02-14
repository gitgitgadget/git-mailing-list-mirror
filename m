Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31182013A
	for <e@80x24.org>; Tue, 14 Feb 2017 08:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbdBNIHv (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 03:07:51 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34326 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdBNIHu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 03:07:50 -0500
Received: by mail-wr0-f180.google.com with SMTP id o16so164440715wra.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 00:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rKYD2FoCwEqXnLOE/EM8dJe6Q+WToaAh/YoYvuliyoA=;
        b=uiHU5F7sVEeR5yqPQ94XUNB0HUkvSlQxGdZ8YvbLnprbzPLzB5GuFyyu0eBbVRBNvd
         UzQfsFeYSpHmYJmU5vxdYFWMVyge9pwLvSVgoSv8NosrrmAwy5el/1JeouUHk/kbBtHw
         Zu7ejXca5hfMyruTiStiBxSd4t2z5rQ0pYNzDPBI/+8fzOPq2T9KQU11dOnwfpksEMQh
         65aNvLBvjrMScdesL4BZBguTjGCgr3T1g4v253J+PGthQrUqQOSdSuIxiB46jJPDsZkB
         MpdoHZvi9B5wVvo9oQo1mZUssjp3P7/jiooDHcvkDBQKBmmUJPg77ShRWyGhdzilVmuG
         9+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rKYD2FoCwEqXnLOE/EM8dJe6Q+WToaAh/YoYvuliyoA=;
        b=gclAzhU8Dj768XP4A7e707zAY0MSora4D+X2DdRT2dtrf3qmv6+xH0yzfFmFi34a6p
         sTZ9Vn1UdfItREdFtqu00Iu9d9GtLC4pBX453p+1PSX2jSiRB6FOLHD4VG41otaSCTIQ
         Lfge28CfWPXB0QdRoPQ8/CsSTzecShXxavgZY4tbjOE2Wd/QsF+S4K4+o47ZqpfHdfam
         4otSs4bTjK6zQQZgZ7URcNzBY1cw/7Wz+6eNzBLI4Mc9eCY2v3QcHUoZqzcwsc8/fX1I
         YdICWi2JZohYv2QiLfKh7iD6BIUSTRiuqGOMIoFGCKUuTUcxULBhEenOYnY/leXOLDus
         Xmqw==
X-Gm-Message-State: AMke39nLLAA8GEFwI1raSwnTxvp8ol3dLQ8kCQECZhHkMeLaglFYQwhLDZMCKnQmAJV0jAinOkdnamhqCwa+2A==
X-Received: by 10.223.141.229 with SMTP id o92mr25526417wrb.22.1487059669073;
 Tue, 14 Feb 2017 00:07:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.159.227 with HTTP; Tue, 14 Feb 2017 00:07:48 -0800 (PST)
In-Reply-To: <xmqqo9y5de1k.fsf@gitster.mtv.corp.google.com>
References: <CAOcUJQwnCJOhUUU2RqJP2H5YxUr4qCEpyDj_XiiQSe4V6rcBmg@mail.gmail.com>
 <20170213154407.GA31568@alpha.ikke.info> <xmqqo9y5de1k.fsf@gitster.mtv.corp.google.com>
From:   Istvan Pato <istvan.pato@gmail.com>
Date:   Tue, 14 Feb 2017 09:07:48 +0100
Message-ID: <CAOcUJQzEKoCf3T2AVzck1Y4NWb8N9FMqQ=+6z6-9C4YF8-jQzA@mail.gmail.com>
Subject: Re: Bug in 'git describe' if I have two tags on the same commit.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is my fault: this is a lightweight tag.
Thank you!

2017-02-13 21:35 GMT+01:00 Junio C Hamano <gitster@pobox.com>:
> Kevin Daudt <me@ikke.info> writes:
>
>> On Sun, Feb 12, 2017 at 01:15:22PM +0100, Istvan Pato wrote:
>>
>>> (master) [1] % git show-ref --tag
>>> 76c634390... refs/tags/1.0.0
>>> b77c7cd17... refs/tags/1.1.0
>>> b77c7cd17... refs/tags/1.2.0
>>>
>>> (master) % git describe --tags --always
>>> 1.1.0-1-ge9e9ced
>>>
>>> ### Expected: 1.2.0
>>> ...
>>
>> Are these lightweight tags? Only annotated tags have a date associated
>> to them, which is where the rel-notes refers to.
>
> Good eyes.  The fact that the two points at the same object means
> that even if they were both annotated tags, they have the same
> tagger dates.
>
> If the code that compares the candidates and picks better tag to
> describe the object with knows the refnames of these "tags", I'd
> imagine that we could use the versioncmp() logic as the final tie
> breaker, but I do not offhand remember if the original refname we
> took the tag (or commit) from is propagated that deep down the
> callchain.  It probably does not, so some code refactoring may be
> needed if somebody wants to go in that direction.
>
>
>
>
>
