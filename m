Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380E81F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 07:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeCUHoV (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 03:44:21 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:41312 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeCUHoT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 03:44:19 -0400
Received: by mail-oi0-f42.google.com with SMTP id 6-v6so82445oip.8
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 00:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lzNVM+hxJFYjxgmUSt4wdq8LEPzrGM0kCl3BWJCR2ro=;
        b=T/Oo9oe5gNSGDr/cfKIEK4zubhBKIySSQD6a9zPIdilAbgeKHiMzz+5n3jRv4RlrKu
         KuL2pSmFTC/Sze2H37S6jKn+1G7mo3iOPjBmKBqRxXepbFuMTTjDs/BTl4G3GFkuArKj
         dy62RERQesAcgGDtAQfVh3W8XfcLtChG1Do4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lzNVM+hxJFYjxgmUSt4wdq8LEPzrGM0kCl3BWJCR2ro=;
        b=mJ+0Yx0ylIO5PvD4oGfQOsV99K/2yMQWt0XQi3CjvpMF3Ap0A8YvGX2kXmdGpFPQqI
         p56kZ15Ys2SpnazxHJWRhWTIO8UN3FDhpzzHhQF6YBtY/yI7ecXQJutl5d4nCbarfgPh
         711bigcvHY9bizbIYNUoQwPikSudFW7O0d/Jtf6pjmBVCOammeAZ4265guws40LaDP2l
         yDB537rGs7Jvadl+NJx3d4cMF5Riy8wPtrA2qNK+T7L1PQ069JgZ9USvVY9nDagplFvf
         IWHlczVpURm0hqQ0VHgK+hvaEZht/nkUDimRAA9zibZgZbOaeOhzMZ2Qb9g7id1eqZoL
         gPwA==
X-Gm-Message-State: AElRT7EFHqCCuFaOG1vmMLWS6RNzD+pU4VFk/iYFREu6TnQJ8YdtRaa0
        MbsGsZml5Tob0VssqPZSTq2BkbGD3gWs+s96++OxWg==
X-Google-Smtp-Source: AG47ELvb1cwiftNF4jda9VGOkP3Tjvyj7hruWhhIN4PZ1MHjza2URmz/dY5CRob5wFNV51i5BV+KHJLrT1Obix6x4HQ=
X-Received: by 10.84.78.138 with SMTP id c10mr10706562oiy.236.1521618258494;
 Wed, 21 Mar 2018 00:44:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Wed, 21 Mar 2018 00:44:17
 -0700 (PDT)
In-Reply-To: <CAHnyXxTf16ukf8CFSfzjQjTEjf5yJXFqK5TnS9KiXZEeAD7dgg@mail.gmail.com>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net> <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net> <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
 <20180320044036.GD13302@sigill.intra.peff.net> <CACsJy8BP+ov0jeHp6QZoi=etPDQX5qEFqEfktyA-U-ffUE92vA@mail.gmail.com>
 <CAHnyXxRsqR3A0FpHJwnfOWo29WNx05qWSXfxvmwPv1TUdqm0aQ@mail.gmail.com>
 <20180321065212.GC16784@sigill.intra.peff.net> <CAHnyXxTf16ukf8CFSfzjQjTEjf5yJXFqK5TnS9KiXZEeAD7dgg@mail.gmail.com>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Wed, 21 Mar 2018 03:44:17 -0400
Message-ID: <CAHnyXxRpRjyuTg9v-m9c4ZCwRTM2_4335m-yzFYqALBLAy8=+g@mail.gmail.com>
Subject: Re: .gitattributes override behavior (possible bug, or documentation bug)
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One extra note:

I was burned by this just a few hours ago in a new repo (but because
of this discussion I realized what the problem was pretty quickly).

In the top-level .gitignore I had

    build/
    ...
    !alpine/build/

where `build/` was a stock ignore line among hundreds that I blindly
pasted in there, and the exclusion was an attempt to exclude some
things that shouldn't have been ignored.

Even in the same file, the exclusion doesn't work. I had to change it to:

    build/*
    ...
    !alpine/build/

Good times :)

- Dakota

On Wed, Mar 21, 2018 at 3:36 AM, Dakota Hawkins
<dakota@dakotahawkins.com> wrote:
>> I think that ignoring all of /ignore-most/ is much more efficient, since
>> we don't have to enumerate the paths inside it at all (which is why the
>> current behavior works as it does).
>
> That's definitely true, but I wonder what the impact would be for most
> cases (even for most cases with large repos and larges sets of ignore
> files).
>
> Most of my .gitignore patterns weren't hand-written
> (https://www.gitignore.io/ is pretty neat), but there are a ton of
> patterns like `dir/`...
>
> I think if I were designing it from scratch and knew what I know now
> I'd probably argue that behavior should be declarative (`dir/*
> recurse=false` or something), but we can't really get there from here.
>
> At any rate, would it at least be a good idea to make the "trailing
> slash halts recursion, won't consider nested .gitignore files"
> explicit in the `.gitignore` doc? Unless I'm missing it, I don't think
> that behavior is called out (or at least not called out concisely/in
> one place). It looks like this is all there is:
>
>     "If the pattern ends with a slash, it is removed for the purpose
> of the following description, but it would only find a match with a
> directory. In other words, foo/ will match a directory foo and paths
> underneath it, but will not match a regular file or a symbolic link
> foo (this is consistent with the way how pathspec works in general in
> Git)."
>
> Also, I'm not sure what the "following description" is in "it is
> removed for the purpose of the following description". Is that trying
> to imply "excluded from the rest of the doc"?
>
> - Dakota
