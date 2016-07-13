Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4570D2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 14:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbcGMOzb (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 10:55:31 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34012 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbcGMOz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 10:55:29 -0400
Received: by mail-io0-f169.google.com with SMTP id q83so48702656iod.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 07:55:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4v/dyNwDAIsGMYwlQlq486/RgIrFyvWiWDVOIMPibag=;
        b=wZsC3UU2vM9EyB+kCl+1bG71ob5eIdDb4+6g2ZsdqBaPiuirN3h9VHfoLtWtW3CngY
         Sm9Vl7OPuTWSUQwHxDHjE5vWc5u8DXvF1d5N4wyaGCUcHUaqOA+rL5QN5l2EtoqEjHjb
         Bt9Rh0nJrGORUQ8CBpIkLdgmGg/rtLbjN+7/zpbLStE3UjDzaECZlxIuXRcFKSVGdMS/
         c3B/LmL4AqqA0wCzRAhQTIJMaYwaubYK3ltJ/zBVA7sF2hFcJpmCeCt/vQuMqQHY0A1y
         LyQ7EBlBWZDyhCQMnPAMd6Og8S3PlfRa2E9O5Y7qL8tJTXxseBR/cfUx+rR92ct2CRpl
         b0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4v/dyNwDAIsGMYwlQlq486/RgIrFyvWiWDVOIMPibag=;
        b=JGAZ8X/0YVZcIKi+Uwrb9nIch3GmrMFMqV6QlmNEJVvGN6elXwv9R9++Np8FKUwI2l
         Pxc+js5Y/f9mBPCx3U0diROgP1zhXPJehZOBQVfgZpC9zUXJYIJ5simJxB9puck0L9Zs
         SIcxvpgwzhy7Ce10bM8x4ZE6epJnj5BzmLYccNxZfHAjexuDWV5xhP3cIvwvwoOXj326
         MpWEWjTPSzh/N2poC8/TcOml050fZzLlh6kVgyAkJFSfcYJC921R90uqIoxcmA3vnsih
         PgOOqZM4GRPQxGOkasQQ2ris+zl9Fkjt59iwaDmrU3LZiVPsLEoofyduYBT1aeEOkmxK
         XUJA==
X-Gm-Message-State: ALyK8tKlHDTt1On4sYzHITPtoxOuVdpbFxCj3LSCYSRTGZwi1QXikAwNGlKA3wsMsJ952AHWETafoHQ7V1Ibig==
X-Received: by 10.107.159.16 with SMTP id i16mr8963969ioe.29.1468421708500;
 Wed, 13 Jul 2016 07:55:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 13 Jul 2016 07:54:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607131004410.6426@virtualbox>
References: <alpine.DEB.2.20.1607090928500.6426@virtualbox>
 <20160709140931.GA3185@x> <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com>
 <alpine.DEB.2.20.1607101255300.6426@virtualbox> <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com>
 <alpine.DEB.2.20.1607101602320.6426@virtualbox> <xmqqinwc9fe2.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607121243470.6426@virtualbox> <20160712152646.GF613@sigill.intra.peff.net>
 <CACsJy8C+NEP1HJq8w1frOy=UOv5-SA+b7MkbX8DE_vU-zjX0XQ@mail.gmail.com>
 <20160712155141.GA5967@sigill.intra.peff.net> <CACsJy8BfXSvKM3=rRCDYzR=rpLRi+FBYs4r1WGXFisq0Esk00w@mail.gmail.com>
 <alpine.DEB.2.20.1607131004410.6426@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 13 Jul 2016 16:54:38 +0200
Message-ID: <CACsJy8BXOrGobyLGAKf=5Dv_4h_Keon9ktZ3B8Vr85qHOY0+mA@mail.gmail.com>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 10:20 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Tue, 12 Jul 2016, Duy Nguyen wrote:
>
>> On Tue, Jul 12, 2016 at 5:51 PM, Jeff King <peff@peff.net> wrote:
>> > On Tue, Jul 12, 2016 at 05:46:12PM +0200, Duy Nguyen wrote:
>> >
>> >> I'm not opposed to letting one worktree see everything, but this move
>> >> makes it harder to write new scripts (or new builtin commands, even)
>> >> that works with both single and multiple worktrees because you refer
>> >> to one ref (in current worktree perspective) differently. If we kill
>> >> of the main worktree (i.e. git init always creates a linked worktree)
>> >> then it's less of a problem, but still a nuisance to write
>> >> refs/worktree/$CURRENT/<something> everywhere.
>> >
>> > True. I gave a suggestion for the reading side, but the writing side
>> > would still remain tedious.
>> >
>> > I wonder if, in a worktree, we could simply convert requests to read or
>> > write names that do not begin with "refs/" as "refs/worktree/$CURRENT/"?
>> > That makes it a read/write-time alias conversion, but the actual storage
>> > is just vanilla (so the ref storage doesn't need to care, and
>> > reachability just works).
>>
>> A conversion like that is already happening, but it works at
>> git_path() level instead and maps anything outside refs/ to
>> worktrees/$CURRENT.
>
> Wouldn't you agree that the entire discussion goes into a direction that
> reveals that it might simply be a better idea to require commands that want
> to have per-worktree refs to do that explicitly?

No. To me that's equivalent to let people deal explicitly with
file-based and lmdb refs backends everywhere. Unless the main worktree
concept will die (I doubt it) it may remain the common use case that
people care about and extra worktrees become second citizen that's
rarely tested. I prefer we have a single interface for dealing with
_any_ worktree. If there are fallouts, we deal with them.

> The same holds true for the config, BTW. I really have no love for the
> idea to make the config per-worktree. It just holds too many nasty
> opportunities for violate the Law of Least Surprises.
>
> Just to name one: imagine you check out a different branch in worktree A,
> then switch worktree B to the branch that A had, and all of a sudden you
> may end up with a different upstream!

Everything in moderation. You wouldn't want to enable sparse checkout
on one worktree and it suddenly affects all worktrees because
core.sparsecheckout is shared. And submodules are known not to work
when core.worktree is still shared.

I will not enforce any rule (unless it's very obvious that the other
way is wrong, like core.worktree). I will give you a rifle and you can
either hunt for food or shoot your foot. In other words, you should be
able to share everything if you like it that way while someone else
can share just some config vars, or even nothing in config file.
-- 
Duy
