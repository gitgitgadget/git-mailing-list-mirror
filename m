Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B6161F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 15:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeJLWkV (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 18:40:21 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:33053 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbeJLWkU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 18:40:20 -0400
Received: by mail-wr1-f41.google.com with SMTP id e4-v6so13821838wrs.0
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 08:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1Xf84J1Qow3vSOmAY+kK1ltCzOYzUhHPZWcUZ5nrsik=;
        b=Pjh5rFH7QPcjja/qqcjFyWJPe8Gk3WfLDfqKQQN4vaRuMyVOnqWK+deSCnSZ0UIIGe
         ssa0sDbLNNfmA6MFhZP3RZGSDXKgGB6h9Vr/zZjhyloDt5VyRi/Q9bJxT5Yh5r5sIdcr
         Aag7s5a9kTJ54ULGHaMBgIFjAEJz/o/99TyInwbESGFbpK+OQw07HI+7lrtJTMFzcTk0
         ZxVXsdu+kdtk1mDA+EgJriTF0Ac39cR2l+GkmJJ6GEesatXht301IwYGAamSkIoEAtux
         LxO9XtkhK1UPxk6Blz7Sc1ASQBariT7HEYYMC1LWyymdMM9MPzY1v2sjd83xig82Jvxl
         4sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=1Xf84J1Qow3vSOmAY+kK1ltCzOYzUhHPZWcUZ5nrsik=;
        b=oG+kxCg8zyT6kwuy5TIvqa27PDH8KieXOtyk3XLtMiqFJceVx8VT+iXMq8dnAP0IQb
         kdQrRag29pVjsNYLzJriRA/JCKCePrBD0Cv9nZ6Gf2jhbySLIeVCPoe1rtgB7DePyTIS
         xzWG9IEM1k5AzD/fqFXEzP9eHuAhcWdaiKFf7BSO5RgYGqJEDROf3oG4dD2gPhuXHmpd
         kUNwv8I45Uo5ojC3TxYdoQQKr2KOO4Mad9+85wVEKAnQx2DzhyTQOREsA8Iu2UVkS6fd
         Qr2htCQ01Yp5USiAZBPaqpqDJpW9sF9fHAub9Mr3suFfWp+t78ecNW7dv6R/hU4X4nOJ
         PfCQ==
X-Gm-Message-State: ABuFfogDqpKJ1TsZ9+TBRjnyk1avDPgxiY7I7z8Tl0a9QztY1vV6A6SR
        ztOZv5b5f7y9E6zeTfocgbr/BLvO
X-Google-Smtp-Source: ACcGV63Gin/5ioe+ZgPePSMU/DKvKLYnK6GGJ4QQRV6CjNKh37gc5S0bJL+ULpepElxf2jTp+o2hUQ==
X-Received: by 2002:adf:9426:: with SMTP id 35-v6mr5667270wrq.54.1539356845981;
        Fri, 12 Oct 2018 08:07:25 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id t143-v6sm1060378wmt.2.2018.10.12.08.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 08:07:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/2] commit-graph write: add progress output
References: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com> <20180917153336.2280-2-avarab@gmail.com> <20181010203738.GE23446@szeder.dev> <xmqqa7njd7bi.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqa7njd7bi.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 12 Oct 2018 17:07:24 +0200
Message-ID: <877eindx03.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 12 2018, Junio C Hamano wrote:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>>>  	for (i = 0; i < oids->nr; i++) {
>>> +		display_progress(progress, ++j);
>>>  		commit = lookup_commit(the_repository, &oids->list[i]);
>>>
>>>  		if (commit && !parse_commit(commit))
>>> @@ -611,19 +624,28 @@ static void close_reachable(struct packed_oid_list *oids)
>>>  	}
>>
>> The above loops have already counted all the commits, and, more
>> importantly, did all the hard work that takes time and makes the
>> progress indicator useful.
>>
>>>  	for (i = 0; i < oids->nr; i++) {
>>> +		display_progress(progress, ++j);
>>
>> This display_progress() call, however, doesn't seem to be necessary.
>> First, it counts all commits for a second time, resulting in the ~2x
>> difference compared to the actual number of commits, and then causing
>> my confusion.  Second, all what this loop is doing is setting a flag
>> in commits that were already looked up and parsed in the above loops.
>> IOW this loop is very fast, and the progress indicator jumps from
>> ~780k right to 1.5M, even on my tiny laptop, so it doesn't need a
>> progress indicator at all.
>
> Makes sense.  If this second iteration were also time consuming,
> then it probably is a good idea to split these into two separate
> phases?  "Counting 1...N" followed by "Inspecting 1...N" or
> something like that.  Of course, if the latter does not take much
> time, then doing without any progress indicator is also fine.

That's a good point. Derrick: If the three loops in close_reachable()
had to be split up into different progress stages and given different
names what do you think they should be? Now it's "Annotating commits in
commit graph" for all of them.
