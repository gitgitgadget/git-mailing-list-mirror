Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC7481F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfGAUsm (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:48:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45485 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfGAUsl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:48:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so7118673pfq.12
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiU63XJWv2kFJ/E3r7YavLqz08u0hP7dqQxw2EqAA6c=;
        b=YoyN3uqzk276JgXBxSoaFwL8WehKnSbD79ONM/bso+t9Zf7fbZ70cbgXSz4Hhw35Zv
         BFsJZTXW8/3uf8T57mKaB8m8w9lqYbmIRO875dOKlCJNBuxFF1t5fHHTkkmL2t2GIGFt
         t9QVXnHFgj1NAOLB2pB2x+yzUBYAfBglPSo8EC2DCQPm6oGYhq6cKbnwx+y+1YMNabh6
         fUIvzXXYrelQjjnHRfNb3msCQerdda+Hkmoai9pNNWv6ImZ4If0PIPyUcNnnjmze3EXu
         qwyl6xft7VuspwYoUk8HlY1YTB5Qht334y0ZjX44jx09QTMsDrDfQwyDeiQvXw7+xLWE
         bNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiU63XJWv2kFJ/E3r7YavLqz08u0hP7dqQxw2EqAA6c=;
        b=HFH13/UTkE25ZJUXVbbqctJ2rEXRab25hX8aIPgrKwD+x1PO4Xahftm5PBsJtp7+Dx
         LOmCgX0xXyCVjQoI6EImvnC5ITfwjGthg8XY5DXM4XA08pN+XMkI+FYr8B4cz75S0zjN
         moyfhOo8lNpO9+d8aUZFoTsp2QkSS4Li5/bazX1yY6tDqvr5Ren92tQASPFdVZYSeYn5
         Mqlti/WA+ubSLHRPLZkhMnr+hr0yeKCnJaPi+Vr5ZVFsO4Qqjd/VuI45e0fp2TEHBk7g
         4jyuy1Wrlloj00pzCh7/mmB2sjYMgIW+1LD5l8jRLLhGNpntRIuphHWxvzt2xEJe+yOy
         KRCw==
X-Gm-Message-State: APjAAAUncvJQPds8gqqpucjjwoxqAmbHO8Fd68nHu8gnYvlkP8jCWF3x
        j/91roGwI2SsJCrNZZEAOfxbeHO6/0RWIqM/6qk=
X-Google-Smtp-Source: APXvYqxqdzV0hthsERkSQIUEhHGlFWiEVQvBJ2W1oZ93eVU9MfPW4169VAuDPdKAkbxVCYK5mNaQB10wYa9256h4a64=
X-Received: by 2002:a63:c4:: with SMTP id 187mr13618482pga.272.1562014121142;
 Mon, 01 Jul 2019 13:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190630051816.8814-1-eantoranz@gmail.com> <20190630065358.GB31264@sigill.intra.peff.net>
 <CAOc6etYMzOpEDs1GpLChAEhp2SbZcKjO82S=qm4P-t6SkUEWcw@mail.gmail.com>
 <20190630223951.GB21696@sigill.intra.peff.net> <CAOc6etZxHWQ24TNsYDf74zgn-VJzbwDsxWxO4-tMkvv92KRKkw@mail.gmail.com>
 <xmqqy31h612o.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy31h612o.fsf@gitster-ct.c.googlers.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Mon, 1 Jul 2019 14:48:30 -0600
Message-ID: <CAOc6etZWKOGDX749i=8R2V44HGtemL3-n0=01WH6amcRro-uPw@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/2] rebuash - squash/rebase in a single step
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 1, 2019 at 12:51 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>
> That part is understandable, but is "rebase-and-squash" a tool
> intended to be used by the contributor to respond to that request?
>
> Wouldn't the developer just do
>
>         git checkout topic
>         git fetch
>         git rebase [-i] [@{upstream}]
>         git push [publish +topic]
>
> to update the topic and ask to be pulled again?  The two steps in
> the middle may be "pull --rebase", but my point is I do not quite
> see where the new squash/rebase-in-a-single-step thing comes into
> this picture.  There may be a different picture that it fits, but
> I do not think it is this one.
>
>

I think rebasing -i makes sense* _if_ there are no conflicts on the
way to reach the current state of the branch if the developer was
pulling while developing the feature branch. If there are conflicts
that I took care of when i was pulling, i don't want to run rebase -i
to have to deal with them yet again. So rebuash would help developers
with or without merges with upstream on their feature branch, with or
without conflicts on those merges (if there are merges), get their
development into a single revision without having to write 4 or 5 git
commands, as Jeff was saying, if it makes workflows simpler....

* rebase -i is the way I see people solve their "squash and rebase"
needs (pick the first revision, then squash all the others... but what
happens if the very first revision is conflicting with the current
state of upstream?), but I (for one) do it the way rebuash is doing:
merge with upstream, reset --soft to upstream, commit, voila! That's
why i wrote rebuash in the first place, just so you can see where I'm
coming from.
