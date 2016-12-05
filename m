Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537F91FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 12:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbcLEMBA (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 07:01:00 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35661 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbcLEMAp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 07:00:45 -0500
Received: by mail-io0-f194.google.com with SMTP id h133so13847804ioe.2
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 04:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=37xy4l35aSbAiMbRQOiDRQMOskIwnvvTTpIVm6GOPAE=;
        b=rJ4N44+WFVclXwdrq0zcHiNWtlHwmRR1rCVw4sepc+XBgfD66srQxh1/dSroooIzae
         zQbbF5bD1io6XnQhJHwg3ak9B6mu7GVkevsE7R59/4/Ihl/pEFi7UmVCxoQ6K4OLvQhL
         VsVjYYkyHqBMyl68gWA9Db4QBUzsBQZ8DV1RD5kQ12W6keKH9qCq06AJqzR7CefQK20b
         rs2f6CqAESuqSwmqgnKMImYAXFEDBh/CXqQcsFd7Geuw6GzpQ+ckVJtHRa/cHcBNE+Zq
         Rb3ne+Ux/kY6bx29luVmPvTSCWTvT2eNS6pJKxMrZswPPndv//vz19xY2qTyIjGP1zBM
         qqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=37xy4l35aSbAiMbRQOiDRQMOskIwnvvTTpIVm6GOPAE=;
        b=BapJnJNT3cQfD/MTt48yWgSciI/Ebe4k+Ep/ru0imO169EMENB140Xr+iAY26aFh4W
         cxeusgKcDF0eOgoR7ZEZ3HrjCoSrsIKnlCmckG0rQuHbP4b92/FQNvBusKNnleST8tHe
         aFHB5XSfDiF6Fk3AHS+UeNqQ7m/3v6LvtCasA1tHTR3SHrjG7/GpGtqk+rMWGAjAeDvz
         mMkB7an+FMjUrOFTvw5UKab7YLd5r3FWZNW0yQ7+AXO+SqWnUgDXhN/ULlATP4iiuJZp
         Q2Zva4Kt+2KqXSWscsY0KUH855B4xCfPb/agLCcJJo6fooVdinlCnJNiPMSx9WtwgWDk
         6zrg==
X-Gm-Message-State: AKaTC02ECFXC/3ufVh7Fgrg3Eb9XW9yhJIweOjPKPTZhI1EclxHmLlCeUp1C9aEAhREYGmEO4odoW1uC145ApQ==
X-Received: by 10.36.34.196 with SMTP id o187mr8041958ito.3.1480939244927;
 Mon, 05 Dec 2016 04:00:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Mon, 5 Dec 2016 04:00:14 -0800 (PST)
In-Reply-To: <20161203052422.hhaj3idboo6r6dz5@sigill.intra.peff.net>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
 <1480710664-26290-4-git-send-email-rv@rasmusvillemoes.dk> <20161203052422.hhaj3idboo6r6dz5@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Dec 2016 19:00:14 +0700
Message-ID: <CACsJy8DSw_EXojKYXvkkqkbd3fsQJ=hhAb0GCfMYRzK2S3d-3Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] shallow.c: remove useless test
To:     Jeff King <peff@peff.net>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 3, 2016 at 12:24 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 02, 2016 at 09:31:04PM +0100, Rasmus Villemoes wrote:
>
>> It seems to be odd to do x=y if x==y. Maybe there's a bug somewhere near
>> this, but as is this is somewhat confusing.
>
> Yeah, this code is definitely wrong, but I'm not sure what it's trying
> to do. This is the first time I've looked at it.

I'm sorry I don't know why it's there either :( The first version that
has this was v3 [1] which still uses "util" pointdf instead of the
commit slab but the logic does not differ much.

This is the place when we "paint" the parent commit with the same
bitmap as the child I mentioned earlier (though I think I mentioned it
backward). You see similar code in the same loop just a bit earlier:
if the commit has not been painted, it gets a new bitmap, otherwise
new refs are OR'd to its bitmap. It's the OR part (when the bitmaps
pointed by *p_refs and *refs differ, it's not just about pointer
comparison) that's probably missing here.

But it looks like we can safely delete the " || *p_refs == *refs" part
because the commit in question is inserted back to the commit list
"head" and revisited in the next iteration. If its bitmap is different
from the child's, then in the next iteration it should hit the "if
(memcmp(tmp, *refs, bitmap_size))" line above, in the same loop, then
the new bit will be added. If it's marked UNINTERESTING though, that
won't happen. I'll need more time to stare at this code...

[1] http://public-inbox.org/git/1385351754-9954-9-git-send-email-pclouds@gmail.com/
-- 
Duy
