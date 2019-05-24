Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0114D1F462
	for <e@80x24.org>; Fri, 24 May 2019 11:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391118AbfEXLlT (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 07:41:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46273 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391005AbfEXLlS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 07:41:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so9656170wrr.13
        for <git@vger.kernel.org>; Fri, 24 May 2019 04:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yV8of5JxQAwL+eL+AKA2st4HZP8CR/jlyldAftl6ao8=;
        b=PgbX8xAFu5AjQRXXaspawR9wIYfmWnk5O9hRgmG/MR9Dw2TiiD4OHSP2Tg9T/QpMWG
         Qmbhvg3vTqjH8GFAXqoPd6wtqBY9DO0FMrvkOtmR4T3zAG5hIymxuJujSTz6xm7E9GG9
         SZYotYqx3B2mxZyE/tSY7GYOA7y7JadLkJq4zMUHaF7oRs/AvmkHaJPZxIi3Yezx+RIQ
         jmkvDB4skLBWG6CpD57W3TVe6HPtJz0+oqCW2OsY17y2UuE3KT3MXwTJ6OsDnBhK9uEU
         RmxYSmiQS/YqltKmPW1QczKlc9lL6Ns7iemkFm6YuAH6Vq19YOFJnkBaTjfTQnUxewnV
         nHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yV8of5JxQAwL+eL+AKA2st4HZP8CR/jlyldAftl6ao8=;
        b=AQ3uNoL7uzCsOA70BmIz6goiQbcJjJUA3eM9AP+0Z8XUvYyTcPLiMjCTsbzoRiuCsK
         KrZUBbP28/NnOVmqmWPZ1SIP+U+OxDpqzS52MavHM2w05QttNau3enIeA/JYOXI7wQ3l
         UXlbv+nCDy2jEua4jmkO7ZqGKoGwfqOhrMshRuMlFirh9aoApsx2wnw9R4mkx+a7/d+o
         n20Rn/bU8B0GLqzo9SqBNlO5Adt/9GDjoxwvfJPyFhEoTl2+WWk4QzdqD3DtWWa6pcw/
         wfSfeN2PitYxxMeo3B/7Nvn+EbGc2jD13iZ5W+DQlUPXNqJq6uGHw7I6NFpWcUb905mL
         qrGw==
X-Gm-Message-State: APjAAAW5ygwpWuXwil+CPOvRiZByx/3QDYPfwBx3g1Vp/9SNPrcYbhP/
        UbSvdvj1rrK4tZO2GI+rm1E=
X-Google-Smtp-Source: APXvYqz2g+oP9ctZBjvNSqIVQzyJJG9WfFmnXGwNo1Hp+8N59iprY7h0vWRRx2IQLhQoaR1aUbvwtw==
X-Received: by 2002:adf:8385:: with SMTP id 5mr49006427wre.194.1558698076908;
        Fri, 24 May 2019 04:41:16 -0700 (PDT)
Received: from szeder.dev (x4db30b59.dyn.telefonica.de. [77.179.11.89])
        by smtp.gmail.com with ESMTPSA id f10sm3137294wrg.24.2019.05.24.04.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:41:16 -0700 (PDT)
Date:   Fri, 24 May 2019 13:41:14 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190524114114.GH951@szeder.dev>
References: <87zhoz8b9o.fsf@evledraar.gmail.com>
 <20190410225721.GA32262@sigill.intra.peff.net>
 <20190523113031.GA17448@sigill.intra.peff.net>
 <87tvdlt1jp.fsf@evledraar.gmail.com>
 <20190524072724.GH25694@sigill.intra.peff.net>
 <87r28offs6.fsf@evledraar.gmail.com>
 <20190524082605.GB9082@sigill.intra.peff.net>
 <87pno8fcp8.fsf@evledraar.gmail.com>
 <20190524092920.GD951@szeder.dev>
 <87imu0f6fh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87imu0f6fh.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 01:17:06PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, May 24 2019, SZEDER Gábor wrote:
> 
> > On Fri, May 24, 2019 at 11:01:39AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> I don't think it's a performance problem to have an old commit-graph
> >> lying around. But if you turn on the commit-graph, run gc a bunch, then
> >> turn it off in config we'll have it lying around forever, even if you do
> >> subsequent gc's.
> >>
> >> So I think we should delete such things on the general principle that
> >> the end-state of a gc's shouldn't be the accumulation of the values of
> >> past configuration options if we can help it.
> >>
> >> Maybe that screws over other users who did a "commit-graph write"
> >> without setting gc.writeCommitGraph, but I think the only sane thing to
> >> do is to make "gc" fully 'own' such things if its turned on at all.
> >
> > Note that there is 'core.commitGraph' as well; as long as it's
> > enabled, no commit-graph files should be deleted.
> 
> Why? If we won't update it or write it if it's not there, why keep it
> around?

To read it, if 'core.commitGraph' says that is should be read.

> It means the commit-graph code and anything else (like bitmaps) needs to
> deal with stale data for the common and default gc --auto case.
> 
> You also can't have e.g. a global core.commitGraph=true config along
> with a per-repo gc.writeCommitGraph=true config do what you expect.
> 
> Now just because you wanted to write it for some you'll end up keeping
> it around forever because you'd also want to optimistically always use
> it if it's there.

This is exactly what I expect it to do.


> Note that I'm talking about the *default* gc semantics, they don't have
> to cover all advanced use-cases, just be good enough for most, and it's
> also important that they're as simple as possible, and don't result in
> stuff like "my performance sucks because I turned this config option on
> once a year ago for 2 days".
