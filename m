Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 446FB1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 15:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932262AbcJEPyf (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 11:54:35 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35879 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932227AbcJEPye (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 11:54:34 -0400
Received: by mail-qt0-f179.google.com with SMTP id m5so52697182qtb.3
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JdqkHiv4ZWrajuTcWtplT6I+zvlMNVI77fsWjzxxn9o=;
        b=AK2a/pmINnnM6OYLGW6mY36K59XQ2KA1pp1LBvBY5lHY4oA4IlC6a3IkGZjIWuSYdv
         CTAOrp6zuqlo7pEPNI8tTjylTuHlk2fdKXdfu5iwGJuyVAcvmbmlZce4739uclN8Wvek
         jA3ArPafKQtU/pyxDogWv5g2lCD9TKmeEW0nGNu2YRR2u1ycG3JmMo6QGLWwHOkAh4G/
         0oxltz46uxo1XsYv5C+mUB0MTQPfNmzCSxRRUvcphshC5kiZqAPLd9mr3e6x+UC/SbdG
         wAr65JPo/URs1Y4w7VE+dy3MLFkYXLC+UuXckUPahaZul42zynSOJDT16tv/VW08BJCX
         F1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JdqkHiv4ZWrajuTcWtplT6I+zvlMNVI77fsWjzxxn9o=;
        b=eqqYtjwAK7YggEP8az6vB301pZd7ROWjJO6guVRnfuwdPAQD4j2jvN01utC1plkg34
         mq8jprFG7SD+/xHDoGgBaF0qkIiK5mrw3/Npez2j8GVZJqa+EIPT5xcwl1xoK6ZEUdgq
         13O64TYBRohgqgulkqADfT8XyHQ9xRAdOLatnPY2qUOy2J4fK2NvJt/16SK9xNQNUlQY
         b4+Oscu5CoUp4nIq7IYSDRFWRHtNJe04ZDGXGbeCkdB38jrQVGx48DfpUH68xI8VEeKH
         s9M5arY5jbAPAHhxGHzY/ACDIow9+3t3wD+w3bm8Mvdu69oVI6v2CD3QvAAvAaBcYyjZ
         vI/g==
X-Gm-Message-State: AA6/9RkBpgZVyStnayb9ys2J2eBpCJq6KL4g9Ptws8r5sep/hMe2J4A851/bv+qILZUqljTES8rrpGnJeimCRrJo
X-Received: by 10.200.44.162 with SMTP id 31mr2840789qtw.1.1475682860145; Wed,
 05 Oct 2016 08:54:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 5 Oct 2016 08:54:19 -0700 (PDT)
In-Reply-To: <20161005154715.qmmcwpkt2yudbc2d@sigill.intra.peff.net>
References: <CAGZ79kbt+SZoogKTV_-rVfOOFzf6xrhWytrBo2H3r6NQw34WTw@mail.gmail.com>
 <20161004210359.15266-1-sbeller@google.com> <20161005154715.qmmcwpkt2yudbc2d@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 5 Oct 2016 08:54:19 -0700
Message-ID: <CAGZ79kaWsS489YRHY3Djjb2pPoVJa5F0MaFhwhne5izg4oG55g@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] push: change submodule default to check when
 submodules exist
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 5, 2016 at 8:47 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 04, 2016 at 02:03:58PM -0700, Stefan Beller wrote:
>
>> thanks for the suggestions, both git_path(..) as well as checking the config,
>> this seems quite readable to me:
>>
>>  builtin/push.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> Yeah, this seems like a good compromise to me.
>
> I did have one other thought, but I don't think it's worth pursuing now.
> We care about finding gitlinks in objects we're pushing; is there any
> process which is already looking at those objects? Genreally, the
> "pack-objects" doing the push has to. Not to actually push the objects,
> which often are sent blindly off disk, but to determine the set of
> reachable objects in the first place. So in theory we could prepare the
> list of objects to pack, and as a side effect it could say "and here are
> gitlinks referenced by those objects". But that doesn't work if bitmaps
> are in effect, because then we don't access the objects directly at all.
> I think you could solve that by extending the bitmap format to include a
> bit for gitlinks that are reachable (but not necessarily included in the
> pack).
>
> So I don't think that's worth thinking too much about now, but it might
> be an interesting optimization down the road.
>
> -Peff

That sounds like what we'd want down the road. In my imagination the
submodules of the future may live completely inside the superproject,
i.e. they do not necessarily have their own URL. They can be obtained
via fetching the superproject, that automagically also transmits the objects
of the submodules.

Thanks for the hint w.r.t. the bimaps!
Stefan
