Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3F3D1F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750783AbeESFm1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:42:27 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45253 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeESFm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:42:26 -0400
Received: by mail-oi0-f68.google.com with SMTP id b130-v6so8934934oif.12
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4B+69M2w41FE5it1sI5poR+PEUFbBVkB6tLFMhF4OFk=;
        b=B/z7A5WKDeqmyFGnyoDn+bJkmLVdfwXxMzMq5zevc8NA4g+P9d/FNGYJLTdnJC2v0H
         B2In88uCJvGbO2gPVBVuXVHZSLr9OSlFN2IV0bfcGXoBNA7zwiWX/Sbux9Dx/AJDq01b
         MyLZio1EI2ug+xO2OcnO7qEjFjV6KJOBKMy53kZmPZYdewxDrGmMz/fTXlGrW6nElEUo
         fCYjYr3owwl/NGqK3KgC4O1O1qTveKSLjEzwFX5/zU//TG76AuaKGpU254vQobBdPe0s
         Fg5I07O0scmjc36sVYI5DlyTG/kXfsqu+xa5uXaqQXPFOQstdrP9wDbuMREKBtRjsumr
         WhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4B+69M2w41FE5it1sI5poR+PEUFbBVkB6tLFMhF4OFk=;
        b=msVxnjMn1Q7uYcmWeHaF5Nxgq95Pr+YgF1II7duMbBtHi4N0zpc/JpSff0AysF3cxt
         8Z4Se7hYZe0G7w1V/xnpN/QGmGia7i+1+9NR2X6tH0mDUSt9N+lOc8i7zJHgj4yZYe5i
         Qd1agyOqjNjdo/EIhaDQjXpHTJ9aJNXL9b0GDAGVAcdJNemXVaVmKoDYuKqmmEusndZy
         DdJCQb/vM1T8TkE2dCe0Le/SpdcTxEdzbQnEZsDliEhaI/GSDiH1tAgEgBuK5Fkwxs7w
         3bkKMHjf2ZN518Rydjmlfcp7rBMu0s5/Ntsj/hU4rNMmBNoE44sG3eoDiTiImgcUAPNZ
         M0hQ==
X-Gm-Message-State: ALKqPweNWJyx6oY6t3qpIxtX4V1YjaUTHo+SMSLh2M9iazaw73U8jSMZ
        0sl85xp/PBAG6Fp07/MjB62q5dXiRsCUShPbilE=
X-Google-Smtp-Source: AB8JxZpgAKdBgbkEcgoP9EHm6bYqNpxmXseU5/XyRL7s8TnVGHyjHs48LAonnPaTV/XcG58t4Z5ShddwYOSG2AjDe7g=
X-Received: by 2002:aca:aad3:: with SMTP id t202-v6mr7372209oie.30.1526708546279;
 Fri, 18 May 2018 22:42:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Fri, 18 May 2018 22:41:55 -0700 (PDT)
In-Reply-To: <5ee75fc6-562e-d424-0bc3-c9997dba92db@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com> <20180513055208.17952-1-pclouds@gmail.com>
 <20180513055208.17952-15-pclouds@gmail.com> <xmqqy3gmbrnm.fsf@gitster-ct.c.googlers.com>
 <20180514160738.GA19821@duynguyen.home> <CACsJy8DhUw6L7j3Pkqji_K0WMjFZxs315emmvdyNQJJN4VTwgw@mail.gmail.com>
 <5ee75fc6-562e-d424-0bc3-c9997dba92db@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 19 May 2018 07:41:55 +0200
Message-ID: <CACsJy8A=KUf7Y7w-TYurvjNJok_XgHaGA21OSqUZF1kfOmgGWg@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] commit.h: delete 'util' field in struct commit
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 8:14 PM, Derrick Stolee <stolee@gmail.com> wrote:
> I disagree with the removal of "generation". My intention is to make the
> commit-graph feature a standard feature that most repos (of reasonable size)
> want to have. In that case, 'graph_pos' and 'generation' will be set during
> every parse and used by every commit walk. This is just my gut reaction.

My 'often used' is a poor choice of words. The problem here is memory
consumption in full-repo walk like 'git clone' or 'git gc', where more
memory use may equal more swapping and that will slow things down.

commit-slab also has a few advantage over packing everything in struct
commit besides the performance argument. It makes it easier to see
what field is used for what. And if an operation only uses a field in
a short time, then it's possible to free data after it's done
(impossible to free these struct commits without a lot more thinking
and checking; whatever you add here will stay until the end of the
process, which could be a long time for things like pack-objects)

> As I investigate these changes, I'll try to see what performance hit is
> caused by converting the graph_pos and/or generation to commit slabs.
> (Again, I'm assuming the slabs will make this slower. I may be wrong here.)

The slab allocation code is very similar to memory-pool, which was
made common code also by Microsoft to make reading cache faster so I
don't think it will slow things down for you (again, guessing, no real
measurement from my side). This does make me think it may be a good
idea to try unify commit-slab and memory-pool, let commit-slab be a
thin layer on top of memory-pool or something like that (the fewer
custom mem allocators we have, the better)
-- 
Duy
