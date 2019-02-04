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
	by dcvr.yhbt.net (Postfix) with ESMTP id 123C91F453
	for <e@80x24.org>; Mon,  4 Feb 2019 23:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfBDXu0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 18:50:26 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39280 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfBDXu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 18:50:26 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so1469287edt.6
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 15:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=unPBNEk0oG/feg13t8WOc4AMFY4moO8urZNP307S91Q=;
        b=Qbq8knWr9Miydphre5b2QLz/lr4YhKQU+M3OgJeP8XRVmdXxex8t5aTSda3Y8xF8pU
         Wh9mUCASjCwv5P5ZDduJJkiM4OMtE9RBaf0VMNJFTEZqSOFvg0KJWpIrbyjKwBraGIgL
         ob0w2MbZsYfuFJ4IR27DJo9rlhvAL9r2S5MwS/oqNXD1KuvJN5gWBfe+4+T4TUFC7d8R
         RNkMDe3s1CIDIdPf5r+SYFbfAeaLdUf6iXhCI/Ju3+MB4zGfjllckeCeBzB9H8WmduAm
         L6aaWRmuqnZBPq0BxxxZeKLXDWuKh5kpp50bwuOb/lrwly0rTU6t/x3UaJbW1tDvCejU
         eBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=unPBNEk0oG/feg13t8WOc4AMFY4moO8urZNP307S91Q=;
        b=p4Cy+6QnMQquUHnU7ava4G/ziacPK3OjcChO7ZocAQkJrndyRWuksfkpuaqbjjSLo6
         vrz7KEWF2EHpe9rBElQzgGrovEwEHlV4l7iTRBH/ihn6lv1C9NNJeJf/T3ZPaU93pDBQ
         o3giZgB0sOqoYIce7L/tHaRkmUfhLJn01oN0/fLIV0BipZ6RWs3MRbDeUa+iYCEIrPEJ
         mCMenNm9HyjfCrhCtrEF76ZuZDnwDISDkyZ+maMntbADikF38C6iEIq1mh/9HPnxNgII
         lgLKBuIFekMHQE3LOVM6h63X/gArYf7Wb/R1xXFyfguzd6XzbDvMR+5ZojTUCIWFBVwa
         6UxA==
X-Gm-Message-State: AHQUAuYF/WcUH7Cjfu+s8eoxSJaAqESxJuhwaEV7rmmWWrAf2b/kf1e6
        OwQagp7Q0DajntsMeqaIjHA=
X-Google-Smtp-Source: AHgI3IaGakwExNv1CwVbcHpW2pYy/FeizDSBslwMt4O2dc8vGUT1oJVBAdMA8OIQjjFichB+9Kx5Dw==
X-Received: by 2002:a17:906:c2cd:: with SMTP id ch13mr1332657ejb.198.1549324224562;
        Mon, 04 Feb 2019 15:50:24 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id f6sm4750775ede.53.2019.02.04.15.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 15:50:23 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] core.abbrev doc: document and test the abbreviation length
References: <20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net> <20190204161217.20047-1-avarab@gmail.com> <xmqq36p3uxq2.fsf@gitster-ct.c.googlers.com> <20190204233235.GB2366@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190204233235.GB2366@sigill.intra.peff.net>
Date:   Tue, 05 Feb 2019 00:50:23 +0100
Message-ID: <87r2cnkta8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 05 2019, Jeff King wrote:

> On Mon, Feb 04, 2019 at 12:04:21PM -0800, Junio C Hamano wrote:
>
>> Instead of exposing this pretty-much "test-only" feature as a new
>> option to t/helper/test-tool, I think it is OK, if not even better,
>> to have it in rev-parse proper like this patch does.
>>
>> I however have a mildly strong suspition that people would expect
>> "rev-parse --abbrev-len=<num>" to be a synonym of "--short=<num>"
>>
>> As this is pretty-much a test-only option, perhaps going longer but
>> more descriptive would make sense?
>>
>> 	git rev-parse --compute-abbrev-length-for <object-count>
>>
>> may be an overkill, but something along those lines.
>
> You could even default <object-count> to the number of objects in the
> repository. Which implies that perhaps the best spot is the command
> where we already count the number of objects, git-count-objects.

That's documented as reporting loose objects by default, although it has
a full report with -v.

Maybe rev-parse isn't the right place, I just picked it because it seems
to be the general utility belt for stuff that doesn't fit elsewhere.

But putting it in git-count-objects seems like a bit more of a stretch
given the above.
