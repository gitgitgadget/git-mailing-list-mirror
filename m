Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C532A1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 07:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbeHAJPb (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 05:15:31 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:44173 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733265AbeHAJPb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 05:15:31 -0400
Received: by mail-ed1-f46.google.com with SMTP id f23-v6so6221584edr.11
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=reRaybVfjy3Oi/s54+ZLgXLO+72nzXPR+wIlGoBGdqE=;
        b=uwT/nYn1fNzvCBEbc4n7YSd7LXyobbtfbaxpogaeOttcG2Qj5i9ZeDv8QcbYctoFiz
         AI5WBLcSZt1+AIajxDPYAgldILl7JxhsHrfz9wl5bDwo/nOEWQy07RjdFjIL6/R/7ZQv
         pUxAFKItqKiw5K+Ceu8NWjcEu+2RQ7+rZuOnW5zFu/yffkbLzXLOkhDJQYVZSTCg5P7e
         DnvoHBzJzvxMOZpf9hi+YucQqjSPA5yTtLW5zc3+rK5EQN8dcjeIF7xbcTJczcL3HxgV
         9j6e/mX9m91wItls5UL14ijB/SL/752d7lxh7AlYB1+c4lYzyAsRVrKJ/3ItdsX4wiVV
         yI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=reRaybVfjy3Oi/s54+ZLgXLO+72nzXPR+wIlGoBGdqE=;
        b=r19Vg38cCPQjNeN9WlTIm9LYbdl8maUKkxcn8KFsUrm1ZrAK/4CuRRqoJKX+gMpGkj
         DYsxkHvDlrJvmdybRyzwuv+1z+jr8MpXf0NAIIL5AdMThAdMtFQya830d1izgqTMtoM0
         ABKtWuDp/d84y8mHaVeyJonI4VuUJoq+sn//nzluFNAclH6l4foT4DMlsZqmeFz2oEs+
         Up0y6Pd0PRwp276iRG7ezybN4OW0y9E8Le7cexHnVyMtY/+bOdFK11miR825CVK5D44h
         BGugzdhVdJH9ZjCcKOyuY/kkkpcdbSyZ2jyZAl1anyVyx4rvAYeHBkVtuE4+E4vRmMNo
         zJgg==
X-Gm-Message-State: AOUpUlGIiHBDpYbpRPDSHEWLsGllE7hW2HDG+15VgpeDzmWG66QlZHT2
        uSEPjspYD9H2SRIuSCfSM/A=
X-Google-Smtp-Source: AAOMgpe7y7aUtkS0CIhscM4H2p2yUqilHxl5oWMbsCrc5Ng31AXnEwU3NYDjzRz1LVd5GrTXzbRs5w==
X-Received: by 2002:a50:c101:: with SMTP id l1-v6mr2761411edf.126.1533108671294;
        Wed, 01 Aug 2018 00:31:11 -0700 (PDT)
Received: from evledraar ([5.57.20.50])
        by smtp.gmail.com with ESMTPSA id z19-v6sm4194679edr.88.2018.08.01.00.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 00:31:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Felt <aixtools@felt.demon.nl>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Dan Shumow <shumow@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: Is detecting endianness at compile-time unworkable?
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
        <20180729181006.GC945730@genre.crustytoothpaste.net>
        <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
        <20180729192753.GD945730@genre.crustytoothpaste.net>
        <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
        <20180729200623.GF945730@genre.crustytoothpaste.net>
        <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
        <87wotdt649.fsf@evledraar.gmail.com>
        <93056823-2740-d072-1ebd-46b440b33d7e@felt.demon.nl>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <93056823-2740-d072-1ebd-46b440b33d7e@felt.demon.nl>
Date:   Wed, 01 Aug 2018 09:31:09 +0200
Message-ID: <87o9emtuf6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 31 2018, Michael Felt wrote:

> For AIX: again - the determination is simple. If _AIX is set to 1 then
> use BigEndian, or, use:
> michael@x071:[/home/michael]uname
> AIX
> i.e., something like:
> $(uname) == "AIX" && BigEndian=1

In lieu of some "let's test this with a compile-test" solution, that
seems like a viable way forward for now. Can you please test the merge
request I have at
https://github.com/cr-marcstevens/sha1collisiondetection/pull/45 by
manually applying that change to the relevant file in sha1dc/ and
building/testing git on AIX?

It should work, but as noted in the MR please test it so we can make
sure, and then (if you have a GitHub account) comment on the MR saying
it works for you.
