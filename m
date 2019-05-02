Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D381F453
	for <e@80x24.org>; Thu,  2 May 2019 16:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfEBQjT (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 12:39:19 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37266 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfEBQjS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 12:39:18 -0400
Received: by mail-io1-f65.google.com with SMTP id j14so2237233ioj.4
        for <git@vger.kernel.org>; Thu, 02 May 2019 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGt06nsJUqzfaBKrtwAoVEwCCavKJ6o9jalmQ4aEmrw=;
        b=ABYeztGWP99tiCeY3urow1aDbGpB13bclM+ZWpMQ4qehkhJal+27Eh2oHTjys5L4rK
         FU13cWPFS0nCj7483n8VwAZp01U1SIzwNm4UnScC0v0Ms7IdPzs/w7rmQY6u48k38a8o
         L9HoCBGGcvKCQNpUv2dn3p7Zv6qzDLhd7USfs4RiqjWys2EgmOWPWDLjryTg+8eZu/3u
         q3FELqpqaJsRD11OZ+UVLTwbOg89WSqSpjWC5BGYUW31gTZzWq6yHJKaTO4TUI8RrLO8
         gvyLpiydSw56arWc7ZBHMJSiYTuSn7v/+Ib6mLh1/8bAtaEfrb9fbtChjMMYmPKXxF3/
         PFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGt06nsJUqzfaBKrtwAoVEwCCavKJ6o9jalmQ4aEmrw=;
        b=kXE0WqC4P9OOqDp+ZBhgIZz7Q1UbKxeBMUhcZfBK4jU4VEuRg0kKYON/3XXelc2PF3
         w1WOAA7N6aT+2EtIY9I8xEh9DMDYeqp6aEh2R6XJ3dc7dxInKjIbL4+nURAt1wdZRDx+
         8NmhsATnrNFcy0xmHJBFVqtCQxre2DH21ETz0nw/0FU5cQqyprSiKKh9GxE3Jt1We41y
         XSeNjXWF8Qx3OajHpfVmmvEbUKXwQTgTEP5suzKKJ0MFQ275a43XtjWifWt7wUHTMpAr
         7IwZqJ7jTgfjyqWcSSUQj5sD5BTrYYllkHm2WjUZv3PdhfT/v2usxDX7I6+9hG6ntbTj
         Pe1A==
X-Gm-Message-State: APjAAAWxxLJARHtBEOseIW2ma2YUbFK5ryMbJwlZf0c1RIznq8GNJTM/
        R3qMVNYGXZDqYtJGHAb8uBsGy57hl08RKvcmoE0=
X-Google-Smtp-Source: APXvYqzJOz0II93ffFg/oH0pZeQXP4ENDaBZyT0d3PNvfgRq2KbWH8sVc8HQCsIRSpPmW+tFOQMS92/RlATotVXdpKM=
X-Received: by 2002:a05:6602:2042:: with SMTP id z2mr2905848iod.282.1556815157692;
 Thu, 02 May 2019 09:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com>
 <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
 <CACsJy8DSW2f3v1KpU-QrAz-EeLwG4mVm9ToDdA2=kXSmtsEAYw@mail.gmail.com>
 <CAF8BazBShg9F2uCuVQ_PM6196kOUNWOA1T9APkCXCoey7as2mQ@mail.gmail.com>
 <20190430174110.GA16729@sigill.intra.peff.net> <CAF8BazBBP53uhh+oOroFuVCEL-FaqJheSYX5Q5_NQxGRt=g_xA@mail.gmail.com>
 <20190501183638.GF4109@sigill.intra.peff.net> <CAF8BazAK_s89XY8-AAsSSbgOFgP03CLRZ50bLGPsc89bfnN7kQ@mail.gmail.com>
 <20190502150701.GA14906@sigill.intra.peff.net>
In-Reply-To: <20190502150701.GA14906@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 May 2019 23:38:51 +0700
Message-ID: <CACsJy8Dimn9+ogDNEgy3xmLunyX_pStBq=g-1jrf74LsOW1xrA@mail.gmail.com>
Subject: Re: Bug: fatal: Unable to create '.../.git/index.lock': File exists.
To:     Jeff King <peff@peff.net>
Cc:     Aleksey Midenkov <midenok@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 2, 2019 at 10:07 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, May 02, 2019 at 04:45:36PM +0300, Aleksey Midenkov wrote:
>
> > > Assuming that kdevelop is just running "git status" in the background,
> > > though, there's an easier solution. If it uses "git --no-optional-locks
> > > status" instead, that will instruct it not to take the index lock at
> > > all.
> >
> > And can we disable optional locks at git configuration level? Because
> > changing source code of each application that is not aware of this
> > option is not an easier solution.
>
> Since the decision of whether to use the locks is dependent on the
> operation being performed, it's an environment variable and not a config
> option.

And there's also tradeoff for doing it. If git-status will not take
locks, it cannot update the index to save refresh information and
reuse the next time. git-status may become more and more expensive
over time (*). Setting a config variable for this does not sound like
a good idea at all. The same for setting GIT_OPTIONAL_LOCKS=0 in
~/.bashrc to "fix" the problem once and for all.

I might take a stab at the "wait and try to hold the lock again, doing
necessary verification after if needed" idea. It sounds like the right
way to go and we haven't had problems with refs doing the same thing
(have we?).

(*) not entirely true since other commands can also refresh and save.
But in the ideal world when optional locks are used for all optional
updates, it's true.

> You should be able to do:
>
>   GIT_OPTIONAL_LOCKS=0 kdevelop
>
> and any commands run by kdevelop will avoid taking locks when they can
> (but for now, the only command which does this is git-status anyway).
-- 
Duy
