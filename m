Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57A3E1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 16:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbeKMBy4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:54:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53102 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeKMBy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:54:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so9005539wmb.2
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 08:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rlu6WHqOnGlwGd8tdyZyj4E0NbwDKS/MmFPbwMmUzZ0=;
        b=HQemhxrXHPtKX6t8XOnXDDJEcDXq+szWHTkslgw04Z0VD/aAWaPszKg/bhuDc7Fi0x
         ah/+IavY5Z7iFF0rwkCEzElZvrrAkyX/seMnD3jaFKLGWff0HzHPpvdtG5D/NbDUXWLc
         n8yKadaS/9dn22AZd9eOMBAd58CxMGzkGEylNvwLccnW89B2V/6GKz1TKgR79AoTmvyr
         dSVyU9tUbW6IJ9imDNmeM6Fy/u9NQ8IUU1XhVEStYNmL4TqwtxRhxwm0Q4lzZyncNdmI
         OKlvmJab+77OjMiAF5KP2rUJuEH3wAOF1xnOUkfe3btzlsZaMBKqsLxOdaem0F6wYrQ2
         exsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rlu6WHqOnGlwGd8tdyZyj4E0NbwDKS/MmFPbwMmUzZ0=;
        b=j2YUfKYITIzZm0QUly1JQYmlysfve73dsJPaqZ2dFOeiT/mXt2HLL840G5igpZC4nr
         79E0K0CSVQvzxYoaPnXn9N4GfrrJNOYEdjENxc9BokkgDjRDyaMkO0IvNL+DMScfpxjn
         6jXrNCmOMIS3YBYvqNOFyFSCZCO3MZO12/AnqkfaZo5IBDsaxR3U41xwVnjbsyXt0+i/
         zUwrV+aa4iacOqBbHQnb5vdGYXSS9T0n7J5rTR6cT+i7yTVROwOI5mrFsrATc73wC54Y
         T1ekZVN6CAIcvNYDNxepiuZk9O+6amRv24lLWSQbV87bPBIOH7i2tF0ibwgKHI5hU41T
         B4oQ==
X-Gm-Message-State: AGRZ1gLs2S//dW6NKMq+52EDl8jIOfVpAYsknZG6BGUu+TcVD4aO3Ljg
        U7/2F79p828GkV03KMHXmHE=
X-Google-Smtp-Source: AJdET5djU+iENHRIUDmNbXdHgXyqLYlbB7fs/i1JYKKI3JEsE1vGFs4vqIuTztszzQryWPtCsScDhA==
X-Received: by 2002:a1c:cf0d:: with SMTP id f13mr197900wmg.70.1542038464119;
        Mon, 12 Nov 2018 08:01:04 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id x11-v6sm7886867wmg.14.2018.11.12.08.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 08:01:03 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick existence check
References: <20181112144627.GA2478@sigill.intra.peff.net> <20181112145442.GH7400@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181112145442.GH7400@sigill.intra.peff.net>
Date:   Mon, 12 Nov 2018 17:01:02 +0100
Message-ID: <87ftw62sld.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 12 2018, Jeff King wrote:

> In cases where we expect to ask has_sha1_file() about a lot of objects
> that we are not likely to have (e.g., during fetch negotiation), we
> already use OBJECT_INFO_QUICK to sacrifice accuracy (due to racing with
> a simultaneous write or repack) for speed (we avoid re-scanning the pack
> directory).
>
> However, even checking for loose objects can be expensive, as we will
> stat() each one. On many systems this cost isn't too noticeable, but
> stat() can be particularly slow on some operating systems, or due to
> network filesystems.
>
> Since the QUICK flag already tells us that we're OK with a slightly
> stale answer, we can use that as a cue to look in our in-memory cache of
> each object directory. That basically trades an in-memory binary search
> for a stat() call.
>
> Note that it is possible for this to actually be _slower_. We'll do a
> full readdir() to fill the cache, so if you have a very large number of
> loose objects and a very small number of lookups, that readdir() may end
> up more expensive.
>
> This shouldn't be a big deal in practice. If you have a large number of
> reachable loose objects, you'll already run into performance problems
> (which you should remedy by repacking). You may have unreachable objects
> which wouldn't otherwise impact performance. Usually these would go away
> with the prune step of "git gc", but they may be held for up to 2 weeks
> in the default configuration.
>
> So it comes down to how many such objects you might reasonably expect to
> have, how much slower is readdir() on N entries versus M stat() calls
> (and here we really care about the syscall backing readdir(), like
> getdents() on Linux, but I'll just call this readdir() below).
>
> If N is much smaller than M (a typical packed repo), we know this is a
> big win (few readdirs() followed by many uses of the resulting cache).
> When N and M are similar in size, it's also a win. We care about the
> latency of making a syscall, and readdir() should be giving us many
> values in a single call. How many?
>
> On Linux, running "strace -e getdents ls" shows a 32k buffer getting 512
> entries per call (which is 64 bytes per entry; the name itself is 38
> bytes, plus there are some other fields). So we can imagine that this is
> always a win as long as the number of loose objects in the repository is
> a factor of 500 less than the number of lookups you make. It's hard to
> auto-tune this because we don't generally know up front how many lookups
> we're going to do. But it's unlikely for this to perform significantly
> worse.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> There's some obvious hand-waving in the paragraphs above. I would love
> it if somebody with an NFS system could do some before/after timings
> with various numbers of loose objects, to get a sense of where the
> breakeven point is.
>
> My gut is that we do not need the complexity of a cache-size limit, nor
> of a config option to disable this. But it would be nice to have a real
> number where "reasonable" ends and "pathological" begins. :)

I'm happy to test this on some of the NFS we have locally, and started
out with a plan to write some for-loop using the low-level API (so it
would look up all 256), fake populate .git/objects/?? with N number of
objects etc, but ran out of time.

Do you have something ready that you think would be representative and I
could just run? If not I'll try to pick this up again...
