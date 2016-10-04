Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3D5207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 06:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbcJDGIE (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 02:08:04 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36514 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbcJDGID (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 02:08:03 -0400
Received: by mail-yb0-f194.google.com with SMTP id 184so1652183yby.3
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 23:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nYrxXGDd6nXGDWlhlquDpOdXniYzYYZ2PnJniR1dLnM=;
        b=njCbeCK5mzgQUuqomz0D/YkAIZqUQwkhBkvlT0ZYe6ez2kjucD9IvtqTyAR866k2vn
         XSy/DYbouGpbE4kTLJ18F4uOYq/9ksxmycnw7OEMHSG8U/t4qXmfdh8GAvSCVIa/qa9C
         d0qk4+e56yMhw5qBGlKqbKo9avAtUEdCUHnQxKxzd6FiklkRJFDR6ZO1zt4WbmWdJiHU
         /R+r4aTQuUgkHoSoE2yCC2njpfWwl/Sy6KHjXY3bMTnZPzIJs5G743wL1TBuFmd5Pwgq
         H+ish2+D48ZggzVUjRhl6mW+RbBM3trCXQteK6bLBWE4XVnJMtOna1sIr+K1G5S8Y9Xq
         rTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nYrxXGDd6nXGDWlhlquDpOdXniYzYYZ2PnJniR1dLnM=;
        b=bkSuGiagTbxorYgCrzSthDpDPKAHl1087/YbUVtvzTXHKomlGfkIRf3LuPunvqsjvE
         4AVFAtzHVZ/bflGicP3CxbL2AVxTgPoJuF0Pvr3vQ3T+6MbAo1b92dt+wVxBFbLWjDmz
         tsrS2B/vre/huu2vLr4u/uks8nfGeHWMH37JvoHjzR1jltYzthLl7k2y64PdSN4CJBiJ
         l0fxuwh9Ds04inr/VccC1FJ/SdFMFOxTDH4Y5zA3bGfb5Pd/tfj8/13qaBtPQuIlpL1f
         c6Fkb/lDXnKT5HGcm3imxLznBqA8a+vi7e7s35qdZgegI0VhdKXNBn6UCX3kAhRS8AOa
         +o9w==
X-Gm-Message-State: AA6/9Rl6DUzAyNw1TM4kMWhcr1WG+SZg4/lr7x2eEEINeQ9XlRs4msgYbayTWzlgW5wy+vr7ecQE0PvKXu1gFA==
X-Received: by 10.37.174.1 with SMTP id a1mr1419453ybj.6.1475561283187; Mon,
 03 Oct 2016 23:08:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 23:07:42 -0700 (PDT)
In-Reply-To: <20161003203503.omjwvg4ocz7pjyzt@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203503.omjwvg4ocz7pjyzt@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 23:07:42 -0700
Message-ID: <CA+P7+xq+NiCn53r+NCnPUysKW_V0semX4_1dGSN3OgMrJS2cJA@mail.gmail.com>
Subject: Re: [PATCH 09/18] alternates: provide helper for adding to alternates list
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:35 PM, Jeff King <peff@peff.net> wrote:
> The submodule code wants to temporarily add an alternate
> object store to our in-memory alt_odb list, but does it
> manually. Let's provide a helper so it can reuse the code in
> link_alt_odb_entry().
>
> While we're adding our new add_to_alternates_memory(), let's
> document add_to_alternates_file(), as the two are related.
>

Ya the code used in the submodule area always felt a bit wrong to me.
It took me a bit to realize why we can just replace this all with a
call to link_alt_odb_entry, but the resulting code reduction is
definitely nice.


> -       /* avoid adding it twice */
> -       prepare_alt_odb();
> -       for (alt_odb = alt_odb_list; alt_odb; alt_odb = alt_odb->next)
> -               if (alt_odb->name - alt_odb->base == objects_directory.len &&
> -                               !strncmp(alt_odb->base, objects_directory.buf,
> -                                       objects_directory.len))
> -                       goto done;
> -
> -       alloc = st_add(objects_directory.len, 42); /* for "12/345..." sha1 */
> -       alt_odb = xmalloc(st_add(sizeof(*alt_odb), alloc));
> -       alt_odb->next = alt_odb_list;
> -       xsnprintf(alt_odb->base, alloc, "%s", objects_directory.buf);
> -       alt_odb->name = alt_odb->base + objects_directory.len;
> -       alt_odb->name[2] = '/';
> -       alt_odb->name[40] = '\0';
> -       alt_odb->name[41] = '\0';
> -       alt_odb_list = alt_odb;
> -

Getting rid of multiple places for this funky extra allocation is a
nice improvement.

Thanks,
Jake

> -       /* add possible alternates from the submodule */
> -       read_info_alternates(objects_directory.buf, 0);
> +       add_to_alternates_memory(objects_directory.buf);
>  done:
>         strbuf_release(&objects_directory);
>         return ret;
> --
> 2.10.0.618.g82cc264
>
