Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EA701F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeHJAHy (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:07:54 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39792 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHJAHy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:07:54 -0400
Received: by mail-yw1-f65.google.com with SMTP id r184-v6so6765153ywg.6
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gmLTPVbADS0EUPOef7wdR20jfBvhceOv6LC0BSIwWQ=;
        b=BBU9kaaV2VFQRM7tlKcIPtfJBeblg0m9vvtNdRf1WrTYJK+8HXQmdVUXJp+SGOgW85
         pX00pmb6CrSS2xAudhNqK2mDQabcxvsYpSyYAU+O2x0iGC9B5vhAkMqxvYwhk2o29qSF
         9EKK5RtvC/LG1MmhCuH8+t3zeKtwsjxSh30q2sVOchp7DLimjoWUopi0YK7zStTMg+OK
         6YINwonmarSergzdZ7iDAbszAgNpnH2DH/XM8Q1X5+D0yGswIaRAXpS5F4CyjE7RDjWs
         3cTKhqzhiK12yeN4Z6/4iG1ZZyfzy+VX2PSWhGopSRVttkxMEplIVrwbWC6fJqJS1LzZ
         lvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gmLTPVbADS0EUPOef7wdR20jfBvhceOv6LC0BSIwWQ=;
        b=s3MU7LGTpqKF+51qoWp00lyhD0HcxHrrPYSZdxxFBMNcoLGqcpVQdu6i7AfWm3FfxH
         azz/HT1N6CV3n0YsHGVgHWAM/CpItSKtzOyMyS9Wc+H2XbS2nceX4RaaIllV7gr8N1IX
         lyL6Jmqoj7y8TJwpRS2zm3TZEk995h7GwaFot82BZSTzxsikB1zeyMERgTZwawONrgmm
         1ZnV0lWZRRJnJAlg+t3K8IY7FA5lXKlRb9oXNs7rtOEqS+vQgiwSMt3nECH0XM8SwHFe
         HmLjiv2a+gCvCQnxd7/IiK7LHEY35VL6Ks7ah5DSVKPayq0PTm/Gw4nQPu6OP09oJ0ob
         36Cg==
X-Gm-Message-State: AOUpUlHJFl0JKt0lnoadncsL1r0rvNjibTCGBk5+bR7v0BKoXjAgwd2D
        TM4LC2ilkGsSdhj3Nw1abT6uo2rvTbptyiuOdCk=
X-Google-Smtp-Source: AA+uWPwhC08pwz6Mtb47Kbx0PmSoGNWZGbL1XO3CtTq8xyRmHFR0wIMA6O5102wCNPjUyIyCw6AbqjYSoe8GLOEsBsg=
X-Received: by 2002:a1f:8c2:: with SMTP id 185-v6mr2512638vki.51.1533850869790;
 Thu, 09 Aug 2018 14:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180730152756.15012-1-pclouds@gmail.com> <20180807190110.16216-1-pclouds@gmail.com>
 <xmqq7el2km82.fsf@gitster-ct.c.googlers.com> <fc56d572-e333-2e05-2130-71b53e251a13@jeffhostetler.com>
 <20180808223139.GA3902@sigill.intra.peff.net> <xmqqbmace5i1.fsf@gitster-ct.c.googlers.com>
 <20180809142333.GB1439@sigill.intra.peff.net> <34b22185-a0bc-f712-b5e5-fc5e2697dcc2@jeffhostetler.com>
In-Reply-To: <34b22185-a0bc-f712-b5e5-fc5e2697dcc2@jeffhostetler.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Aug 2018 14:40:58 -0700
Message-ID: <CABPp-BHiB_gR-dQbpJtSBYPJ5Om4Mv0ymnZFNocyTfbUotyBgw@mail.gmail.com>
Subject: Re: [PATCH v2] clone: report duplicate entries on case-insensitive filesystems
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        pawelparuzel95@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 2:14 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
> On 8/9/2018 10:23 AM, Jeff King wrote:
> > On Wed, Aug 08, 2018 at 05:41:10PM -0700, Junio C Hamano wrote:
> >> If we found that there is something when we tried to write out
> >> "Foo.txt", if we open "Foo.txt" on the working tree and hash-object
> >> it, we should find the matching blob somewhere in the index _before_
> >> "Foo.txt".  On a case-insensitive filesytem, it may well be
> >> "foo.txt", but we do not even have to know "foo.txt" and "Foo.txt"
> >> only differ in case.
> >
> > Clever. You might still run into false positives when there is
> > duplicated content in the repository (especially, say, zero-length
> > files).  But the fact that you only do the hashing on known duplicates
> > helps with that.
>
> I worry that the false positives make this a non-starter.  I mean, if
> clone creates files 'A' and 'B' (both equal) and then tries to create
> 'b', would the collision code reports that 'b' collided with 'A' because
> that was the first OID match?  Ideally with this scheme we'd have to
> search the entire index prior to 'b' and then report that 'b' collided
> with either 'A' or 'B'.  Neither message instills confidence.  And
> there's no way to prefer answer 'B' over 'A' without using knowledge
> of the FS name mangling/aliasing rules -- unless we want to just assume
> ignore-case for this iteration.

A possibly crazy idea: Don't bother reporting the other filename; just
report the OID instead.

"Error: Foo.txt cannot be checked out because another file with hash
<whatever> is in the way."  Maybe even add a hint for the user: "Run
`git ls-files -s` to see see all files and their hash".

Whatever the exact wording for the error message, just create a nice
post on stackoverflow.com explaining the various weird filesystems out
there (VFAT, NTFS, HFS, APFS, etc) and how they cause differing
filenames to be written to the same location.  Have a bunch of folks
vote it up so it has some nice search-engine juice.


The error message isn't quite as good, but does the user really need
all the names of the file?  If so, we gave them enough information to
figure it out, and this is a really unusual case anyway, right?
Besides, now we're back to linear performance....
