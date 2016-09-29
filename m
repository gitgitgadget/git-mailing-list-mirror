Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C2E7207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 19:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755018AbcI2Tkq (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 15:40:46 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33711 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752589AbcI2Tko (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 15:40:44 -0400
Received: by mail-oi0-f65.google.com with SMTP id w11so5774401oia.0
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 12:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bT8ElMqENPGNecqQjtLwRYYOejowD9FoWgH+BmEsQ2s=;
        b=wTomnM7gJu/QGMCQ8bsfGDeAY8ZD4g36NuY7l+c9h9Q9iQum9hG66JKHJiKDwMby9g
         gZTDV3J+QYZxhdiIBx8obbLE8jmZfjI6j6uWH+WJX3Qlye/bTIVWnqNUcYTt0vvHF0WF
         kBr7jLxUg7roo1Cz/a7oHClmd5lno8tKfrK8djV+jUC+BkIwUbI2d4cyIe091NXKTLsR
         BFH5E4qWvXyw/HguHj1A3Zpn+NHshgGbJd+BCTpRGAmr8wf+d8mnBzQn6AxtBRfZiqcM
         qoahSVM3R9j/iRMyhbzJj6tXcOW85U1AWuLWYSicpkF9aTO30FUl2/honSQBw3IBA/+Z
         3p3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bT8ElMqENPGNecqQjtLwRYYOejowD9FoWgH+BmEsQ2s=;
        b=fI9wJHjcCPSBa8nlRyYWYqsttCfnw6INsEDNw/0QkFkGA3O2zBOiD8S/t1oScgXO9p
         B3L8/gY/4QkhSI2bVjLmvZqOT8yBp4cV9QoL3Lj4yuWgUmGt1n9xDLkQV6Pd+yPY7MJn
         /cFFstunUg9BDBnSX37Ll6BjvuAMievg/rnccan82+fdqs4G2Hug7OuRODDmOSE7F+jV
         PaxGD3kYB+fAgYTfzntGodqu8om21RLJ8zTJnBZ+rGD7sChiirYvbpf1XrTaPolC7hOh
         5tnm0uhNpieZyQGH1+9heD9Gf4LWTHBMiTOUjfqQ/u1pSYIsq2aHS9PSLwoGt5a3fE31
         iWVQ==
X-Gm-Message-State: AA6/9RnRm3iD52siqXDp/mv/ymSQZ4/4rae8fZPnCUJMXnlPJxhYBbJbx2P16744/kFaLTB17SbrNJmavjKYMg==
X-Received: by 10.157.12.247 with SMTP id o52mr2294296otd.222.1475178043945;
 Thu, 29 Sep 2016 12:40:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Thu, 29 Sep 2016 12:40:43 -0700 (PDT)
In-Reply-To: <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com> <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2016 12:40:43 -0700
X-Google-Sender-Auth: C-jpCrBb2Id5xANQmaEp9CmEbxw
Message-ID: <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 12:16 PM, Jeff King <peff@peff.net> wrote:
>
> Hmm. So at length 7, we expect collisions at 2^14, which is 16384. That
> seems really low. I mean, by the birthday paradox that's where expect
> a 50% chance of a collision. But that's a single collision. We
> definitely don't expect them to be common at that size.
>
> So I suspect this could be a bit looser.

So I have to admit that I was surprised by how quickly it actually
decided that 7 isn't enough. In fact, the reason I initially said that
git used 8 digits was that I didn't count very closely, and just
verified that it was more than the default 7.

But quite frankly, I think the math is correct, and part of that is
that the logic is all about not just the current state, but the
"reasonably near future".

So it is indeed fairly aggressive, and the moment you have more
objects than the "we'd expect to probably see  _one_ collision" it
grows the size. But looking at the kernel situation, that really is
what we'd want, because the whole problem with the existing code is
that it only takes the *current* situation into account. That's what
we want to get away from. We want git to pick a number that is sane
from a standpoint of "this project is still growing".

And git _already_ has commits that are ambiguous in 8 hex digits and
need 9. Yes, it's rare today, but the reason I'm telling kernel
developers to use 12 is because while a size-11 collision is very rare
today, it does actually happen, and we want o pick a value where it is
rare enough that even in the near future it's not going to be a big
deal.

Don't get me wrong: collisions aren't fatal. So it's not like we have
to absolutely avoid them, and I really like your patch series exactly
because it makes collisions even less of a deal (particularly since I
expect people will not upgrade immediately, so we'll continue to see
even new 7-hex-digit short forms even in the kernel). So it's a
balance of making the hex string long enough that it's simply not a
big worry.

So I'm sure it *could* be looser, but I actually also really suspect
that git truly *should* use a 9-digit abbreviation rather than 8 (and
7 is definitely starting to be borderline, I think).

> As far as the implementation, I was surprised to see it touch
> get_short_sha1() at all. That's, after all, for lookups, and we would
> never want to require more characters on the reading side.

Heh. The implementation is crap. It was literally a "how can I make
the smallest possible patch" implementation. I was finishing it off
while at a talk by Nicolas Pitre at Linaro Connect where I am right
now.

So I agree - it does extra work just because that's where it all
slotted in with minimal effort.

At a minimum, once it finds a good new default, it should just memoize
that. So a minimal fix to the "it's stupldly recalculating things over
rand over again" would be to just set "default_abbrev" to the value it
finds acceptable after the first time it finds something, so that it
doesn't end up looping _again_ in the future.

But you could easily also just instead have it do something like

      if (default_abbrev < 0)
            default_abbrev = initialize_abbrev();

at startup time if "abbrev_commit" is set, and just do it once and for
all rather rthan the odd loping behavior.

I really just wanted to see how well the concept worked, and I was
happy to see that it gave what I thought were the "correct" numbers.
And the loop was salready there ...

            Linus
