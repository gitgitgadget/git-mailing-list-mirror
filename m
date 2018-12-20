Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CE561F405
	for <e@80x24.org>; Thu, 20 Dec 2018 17:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbeLTRhe (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 12:37:34 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51636 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387591AbeLTRhe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 12:37:34 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so3199719ite.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMiZqhwCSFi+OIQTIAlEB1RwNkIhilwzZlGpbAiUJHY=;
        b=tTYLAleXD1/5kp9mZb+LaEjuBkzNLyHLVAByQYHQF69tfgxCCB+wtvN7dwkQvdcSGe
         5cnWNkqbqh+ub+kxl7aoLMLzGFt53Yuk4W9jjI/hqZcegJ+2lyzHkstLA4Id0ekCh0Yi
         kgJLp/mGvYeQuflgMQoaUXjjyhAp78n6LSgl8zCTb+bl33UVCWrDb480QmE9rIki/2+3
         WdTt4Q56rNPSQMbTZUOZmuv734uRJ1rcuduILxz4b7aLdYaU2F90x1KKq5WQkrm2kpcK
         xuzvlecSxg3RSk5bmeuQSV34U3AXw8f38fhd7mHikDK4MA6jjvP42tWD6uUbWiJAXR+T
         4diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMiZqhwCSFi+OIQTIAlEB1RwNkIhilwzZlGpbAiUJHY=;
        b=WwGC2W88qqtqdbU7NW7UOrSjOI30NSIFhI6WQcM/EVTJi5kwhUSeM9vVK6ghp92JZc
         UtiY/gnOZdo5DdyJ5sW4t9upR1+H0t/OtZlgFJooIYMn2NHzKnJXO3NgVL7rKBe121ZB
         PnzfzGKx8+8CbRoLyiaDKumYY5T+CXgeKvjyipfUZpXek3LYropJaRaAlnhhdHeTfDhO
         sCJpGxi1gSSXr0ANmEOd+u/lMUuCol5Bqg8A5F+NGwJRHVe6xa8fG9rRUcpwJ0EZGG1X
         Dz+epWD5Ofne7tcggxaCfJUOkC/JEi8GKhPQseBh8nLC5RZUKXYyetaM8xcu2OuOfLq3
         tvgg==
X-Gm-Message-State: AA+aEWZVfh47BHJFXGyl87Whgtus+/Z790ir218TDk9BzBFDWVqd+uVF
        kZkGrrK3vibk1FiwAv9dEVmxTRMv4wnAx3tLcev5SA==
X-Google-Smtp-Source: AFSGD/UkfTV/oINdFHmzj7+PslyXO2GT2zTrVp7/9KT96Q9B93BmuduUdIowCYPWikeXlufFWjrmNk0FDtIV/2GDO1s=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr22264225jak.30.1545327453280;
 Thu, 20 Dec 2018 09:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
 <CACsJy8CScTBbYJt_LLp-rBdmJubEQOZqkPQeszzax9YpbCPUkg@mail.gmail.com>
 <20181220171725.GB6684@sigill.intra.peff.net> <CACsJy8AFwSgL-YAc2YU2XfqKFkXf-W+2V7tMy3ZOYvm_zhv5Bg@mail.gmail.com>
 <20181220173204.GC6684@sigill.intra.peff.net>
In-Reply-To: <20181220173204.GC6684@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 20 Dec 2018 18:37:07 +0100
Message-ID: <CACsJy8C6JZR=6bh0M2=9P_LD42tW1qz78+xL3aqTw5A0fJCrqg@mail.gmail.com>
Subject: Re: [PATCH] diff: add support for reading files literally with --no-index
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 6:32 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Dec 20, 2018 at 06:23:42PM +0100, Duy Nguyen wrote:
>
> > On Thu, Dec 20, 2018 at 6:18 PM Jeff King <peff@peff.net> wrote:
> > > > I wonder if --follow-symlinks would be a good alternative for this
> > > > (then if the final destination is unmmapable then we just read the
> > > > file whole in memory without the user asking, so it will work with
> > > > pipes). --follow-symlinks then could be made work with non-"no-index"
> > > > case too. But --literally is also ok.
> > >
> > > It's more than symlinks, though. Reading from a named pipe, we'd want to
> > > see the actual contents with --literally (and not "oops, I don't know
> > > how to represent a named pipe").
> >
> > Yes, but I think at least --no-index it makes sense to just fall back
> > to read() if we can't mmap(). mmap is more of an optimization than a
> > requirement. There's no loss going from "oops I don't know how to
> > represent it" to "here's the content from whatever what that device
> > is". Symlinks are different because we have two possible
> > representations and the user should choose.
>
> Oh, I see. I misread your paragraph. Yeah, I think that is the behavior
> I would want by default, too, though the previous thread makes me thing
> some people would literally rather have the "I can't represent this"
> behavior (because they really do want a diff that can reconstruct the
> filesystem state, and an error if not).

I can't see a good use case for that. But yeah it would not harm to be
a bit more conservative, then make --literally default later and leave
--no-literally as an escape hatch.
-- 
Duy
