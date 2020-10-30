Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AEBC00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 17:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140EE2083B
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 17:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPmC+K1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgJ3R3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 13:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgJ3R3D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 13:29:03 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533C9C0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 10:29:03 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x203so7370712oia.10
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 10:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsdvBUPGrAEZPD61xvSLQz0WFr21IOLGwZO0y8KqUKY=;
        b=vPmC+K1Jmqiz3qIqIXbZTfBg4H7KB3C5jVAFJe3TCZ0NtIqJCHFj4gn2ySJPwQBlXY
         d5u3L4FvAl68v8NpOl4Tufm67GbVVNn1JnD5RWOXsGHVQp7oq7dNqEddAbTX3LoaZuFV
         G6wPCCfHtulr/l8Ks2+m6L/CIJWm5I2idpfnpR1mjvATN3uvYm3SEy0fFEnaQkbPvGFH
         LgwCDgaWdXc9YfKIJWuuU3MprM1s7O1+Qbn4MSrG/NlteenLU0MbrDuikfedlEzpoMfK
         CXvC3E7tr2A55y2HCrs0u91CumxfJh/a/INsaTPrqQo7tSnxXWxYLNrqAlKhF+QDPAn0
         S4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsdvBUPGrAEZPD61xvSLQz0WFr21IOLGwZO0y8KqUKY=;
        b=YGN4ZySjddYr2WuE+vE2+LFcPakREO5Vgj0T6o0J5zhWg21kNduA5+lFj4lQl3lLXT
         YD/w0HBbkp3XWDGj5gPKIv4Gq294naBpWJwE0LftFiW++OXhQw7O4B605g4UNIpMHf03
         SWGqCTX2w3Zt5tU7aXFtQUMBC1mA3PRE4TZoijtYdhVb/N1t78jkrSwXCBdBuo1ivecz
         9H/twD/agv57c4qUlvUTDdAJqg4zooje79XJIakX4vt/Xs4+roSm5Tx9oOIeE2kBZO8b
         bs9ug3+zZIW0tH0jEPcT9OB3kJEKHXQ5fBdq7MpU4jhV0m1PJ4hiPX4KhXnkKKhwtrAp
         9Xgg==
X-Gm-Message-State: AOAM533zlxZ/58q4aRT0cf0mGLFFB0gec7XXjbTjIif88sgW6XFEVjvp
        QjZgPHcs+N6jyehzad7vCug4he7wAuIhVh1RUfuavF00wRE=
X-Google-Smtp-Source: ABdhPJyeGZmIguluq5dxZvo1WULNAu2i5E10v0mNup8hSiLuRn/nB6fA7ro9EfyTX2XFwDazRKo6GMBU7cj462zPzGQ=
X-Received: by 2002:aca:b4d7:: with SMTP id d206mr2499994oif.39.1604078942652;
 Fri, 30 Oct 2020 10:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com> <cc8d702f98f94fd9202d227d19be43a912467e84.1602549650.git.gitgitgadget@gmail.com>
 <20201030143906.GH3277724@coredump.intra.peff.net>
In-Reply-To: <20201030143906.GH3277724@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Oct 2020 10:28:51 -0700
Message-ID: <CABPp-BFyqTthyBmp5yt+iUniwTi+=y2QcBcmNnnCy=zvyi3Rbw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] strmap: add functions facilitating use as a
 string->int map
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 7:39 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 13, 2020 at 12:40:48AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > Although strmap could be used as a string->int map, one either had to
> > allocate an int for every entry and then deallocate later, or one had to
> > do a bunch of casting between (void*) and (intptr_t).
> >
> > Add some special functions that do the casting.  Also, rename put->set
> > for such wrapper functions since 'put' implied there may be some
> > deallocation needed if the string was already found in the map, which
> > isn't the case when we're storing an int value directly in the void*
> > slot instead of using the void* slot as a pointer to data.
>
> I think this is worth doing. That kind of casting is an implementation
> detail, and it's nice for callers not to have to see it.
>
> You might want to mention that this _could_ be done as just accessors to
> strmap, but using a separate struct provides type safety against
> misusing pointers as integers or vice versa.

If I just did it as accessors, it makes it harder for myself and
others to remember what my huge piles of strmaps in merge-ort do; I
found that it became easier to follow the code and remember what
things were doing when some were marked as strmap, some as strintmap,
and some as strset.

> > A note on the name: if anyone has a better name suggestion than
> > strintmap, I'm happy to take it.  It seems slightly unwieldy, but I have
> > not been able to come up with a better name.
>
> I still don't have a better suggestion on the name. Another convention
> could be to name map types as "map_from_to". So "struct map_str_int".
> But it's pretty ugly, and strmap would become "map_str_ptr" or
> something. As ugly as "strintmap" is, I like it better.
>
> > +void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
> > +{
> > +     struct strmap_entry *entry = find_strmap_entry(&map->map, str);
> > +     if (entry) {
> > +             intptr_t *whence = (intptr_t*)&entry->value;
> > +             *whence += amt;
> > +     }
> > +     else
> > +             strintmap_set(map, str, amt);
> > +}
>
> Incrementing a missing entry auto-vivifies it at 0.  That makes perfect
> sense, but might be worth noting above the function in the header file.
>
> Though maybe it's a little weird since strintmap_get() takes a default
> value. Why don't we use that here? I'd have to see how its used, but
> would it make sense to set a default value when initializing the map,
> rather than providing it on each call?

That probably makes sense.  It turns out there is one strintmap for
which I call strintmap_get() in two different places with different
default values, but I think I can fix that up (one of them really
needed -1 as the default, while the other callsite just needed the
default to not accidentally match a specific enum value and 0 was
convenient).

>
> > +/*
> > + * strintmap:
> > + *    A map of string -> int, typecasting the void* of strmap to an int.
>
> Are the size and signedness of an int flexible enough for all uses?

If some users want signed values and others want unsigned, I'm not
sure how we can satisfy both.  Maybe make a struintmap?

Perhaps that could be added later if uses come up for it?  Some of my
uses need int, the rest of them wouldn't care about int vs unsigned.

> I doubt the standard makes any promises about the relationship between
> intptr_t and int, but I'd be surprised if any modern platform has an
> intptr_t that isn't at least as big as an int (on most 32-bit platforms
> they'll be the same, and on 64-bit ones intptr_t is strictly bigger).
>
> Would any callers care about using the full 32-bits, though? I.e., would
> they prefer casting through uintptr_t to an "unsigned int"?

I don't care about the full 32 bits (I'll probably use less than 16),
but I absolutely wanted it signed for my uses.  I think it makes sense
to be signed when using it for an index within an array (-1 for "not
found" makes sense; using arbitrary large numbers seems really ugly
(and perhaps buggy) to me).  It also makes sense to me to use -1 as an
invalid enum value, though I guess I could technically specify an
additional "INVALID_VALUE" within the enum and use it as the default.

If someone does care about the full range of bits up to 64 on relevant
platforms, I guess I should make it strintptr_t_map.  But besides the
egregiously ugly name, one advantage of int over intptr_t (or unsigned
over uintptr_t) is that you can use it in a printf easily:
   printf("Size: %d\n", strintmap_get(&foo, 0));
whereas if it strintmap_get() returns an intptr_t, then it's a royal
mess to attempt to portably use it without adding additional manual
casts.  Maybe I was just missing something obvious, but I couldn't
figure out the %d, %ld, %lld, PRIdMAX, etc. choices and get the
statement to compile on all platforms, so I'd always just cast to int
or unsigned at the time of calling printf.
