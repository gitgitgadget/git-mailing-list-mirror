Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E97602070F
	for <e@80x24.org>; Mon, 19 Sep 2016 23:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbcISX5b (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 19:57:31 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:32827 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbcISX5b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 19:57:31 -0400
Received: by mail-yw0-f174.google.com with SMTP id i129so816893ywb.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EmB4M9FRVTxQ41cSKfKEtEIIx8qDDrBwEZDDKBin0uI=;
        b=Kw03sDAYEUtoJfa93ctdhkjOPLKJoKMV6Pw7YWp81nEV7JF6dhkNGDDKihlS8rjtdo
         OCJKWGHlt/ugZ1sLZmaQ6uIqfz95LxCYYHd38BCSqArVxs1EDeXiaBhU95JgMpLzWatr
         iLv1ZFXc9PNWSwHeql3FLAy91ERreoA2MCvg9aTYZV1C2pHrqtlC+gYKyRG0FsbDel2R
         trtq4E06byLqvQHQ4ZlPkWGcdp6RCCgpV41O0frDj7LIC7nsqbINm/nkzbJGgAhonOHT
         /vPDV0zrnK/42LKONpJZ0jkCngw0V3OsQF8GZnDqU0Cx+nv4QTTMya+oE0Q20m2AXvNy
         xE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EmB4M9FRVTxQ41cSKfKEtEIIx8qDDrBwEZDDKBin0uI=;
        b=TadaaneM4QPOTplHH05Qr+6kZEwY4CHL35iUEx40gqmC8U4v48Bu47BbpIwnFCkDJt
         kfXY1gt36XX7IOTq4C2JcGOsprs5LeP6rqGhdI3qgu/+VSs5duX35bHJQxIztz2PKXoC
         CS5o1CCpGkltJSxWKd5vD99N+gOalAQI/0PsotOoPDfvOHFlnVTviTFTpPg/TyGwCXDZ
         wwQUyk9zrtsO+RdV97GEYUcZs5enYgLv3mALM+DBs5fghlcC2hMjTVbaLkIYzpG/Dbo5
         DoD5xTn1OUsR7PP55i+GVKgoUvmolizGaI1IzsvHZCBi6D+WchB4iCggcT2ENEEb5noN
         lUQQ==
X-Gm-Message-State: AE9vXwPQAl22rfZmiPhvaFoeNQComJKZUeGXjTlqATQq/wmDbWGOXrcsWvUEv9nRVZP9J1XB0wx5yFpPN5yRKA==
X-Received: by 10.129.177.3 with SMTP id p3mr28147384ywh.318.1474329450206;
 Mon, 19 Sep 2016 16:57:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 19 Sep 2016 16:57:09 -0700 (PDT)
In-Reply-To: <20160919235550.GC29421@cloud>
References: <b5bf39015fdd20dd0aa4f38eb365bbbd0d07a4ca.1474096535.git-series.josh@joshtriplett.org>
 <3df15bbb-7eac-86ec-2ccb-74a973482e8c@au1.ibm.com> <xmqqa8f3g4pu.fsf@gitster.mtv.corp.google.com>
 <20160919204408.GA28962@cloud> <20160919233434.fhkikksi4cxzrzb5@sigill.intra.peff.net>
 <20160919234022.GA29421@cloud> <CA+P7+xp-CupfFwQv+U-KNh4bxG9Mxkbfip5RJebKX9gjffoOsw@mail.gmail.com>
 <20160919235550.GC29421@cloud>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 19 Sep 2016 16:57:09 -0700
Message-ID: <CA+P7+xoKV+ffVxTK6vobuxJy1pZndr7KBLo=BLPc9xiNQgYrqg@mail.gmail.com>
Subject: Re: [PATCH v2] format-patch: Add --rfc for the common case of [RFC PATCH]
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 4:55 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> On Mon, Sep 19, 2016 at 04:46:06PM -0700, Jacob Keller wrote:
>> On Mon, Sep 19, 2016 at 4:40 PM, Josh Triplett <josh@joshtriplett.org> wrote:
>> > On Mon, Sep 19, 2016 at 04:34:35PM -0700, Jeff King wrote:
>> >> As far as your patch goes, I'd be OK with defining:
>> >>
>> >>   --rfc::
>> >>       Pretend as if `--subject-prefix='RFC PATCH'` was given.
>> >>
>>
>> Would:
>>
>> Shorthand for `--subject-prefix='RFC PATCH'`
>>
>> be a better reading? I feel like using "pretend" is a bit weird here.
>
> My patch used "Alias for"; if you prefer "Shorthand for" I'm
> indifferent. :)

Alias seems fine to me.

Thanks,
Jake
