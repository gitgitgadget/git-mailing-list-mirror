Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2322F202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 15:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936225AbdIYPpQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 11:45:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:56719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934482AbdIYPpO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 11:45:14 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNZgw-1dzHmN2IKA-0079hh; Mon, 25
 Sep 2017 17:44:57 +0200
Date:   Mon, 25 Sep 2017 17:44:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael Haggerty <mhagger@alum.mit.edu>
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 14/21] read_packed_refs(): ensure that references are
 ordered when read
In-Reply-To: <d16e3003-e10e-6767-4d00-65e264a4a548@alum.mit.edu>
Message-ID: <alpine.DEB.2.21.1.1709251743230.40514@virtualbox>
References: <cover.1505799700.git.mhagger@alum.mit.edu> <5bb362d9cb74c7386cd072e3ecd49b22cea1d8d2.1505799700.git.mhagger@alum.mit.edu> <20170920185047.6fzuspaseofb7r5x@sigill.intra.peff.net> <d16e3003-e10e-6767-4d00-65e264a4a548@alum.mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7kSwC7ZUjJHVnHXAloCdCGnVaiSTYQvPvtNaCgUBaPAx8uIh1js
 N4mQZ5Xfeb01PNmmTq1zujLlXFNHzF2jI4UXAG1vEUZCUOryDUs55lS7vMuZrR3ChfbFY+m
 lrMu/xOgtYcAPXcIhau5Fc1cLAUlqNDRxNtpL8DWAvbr8vUi9hsgh4nan6u76Aq+e8AZ/pQ
 VH316NHvq1d9qXBZRK0vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:orJLhAJ16/Y=:OlTGBDNLT5mNb5yyntLP4b
 +i5cpfeSH15g5vbMeSGnWX2e3y6rB0iUDldCg3d6vP5P6pxRkiQqKZUQpPaQyy0JkU14e4u+z
 BjSiPIYv2iQ8/jGOx8PR2fPwKQlteNumKA/mreLWsSmlTMJkWgU8DkB3egMYrz/eXJ/tfbEsR
 jpqBprClAgjCxgtA4RiUifbXzkE7fjHeRV8iWtBBGxPh/WC9uw6qLbV7Me3c86RGdpw81nK0w
 c60dupwnQKhkRd9XITgfcFkoNB8I/8r+JNUL4mEzMnwCi2ckySI8reXUm8Wmn88wgr/aOy19I
 5Qmh+H2HYUXhND4MSZP9zYRA+zpXaKAwnw2bgvmzMG7ei6tJxcbFHfO28TMuh42mK8Slndb00
 R2vZIl64kOOYYpfBCrzmZEu2V8TSueHFY4h6rZLp7wAp1Y9Fsg4odhRjKiO+o60+8htFcfZqc
 nYF/0K1nwPX4iq+F+i1yk2Wk54EgTUspey/7qE2x00k43FHEBAtVtU7r5zsS8vDeaNxQubhSg
 PdMX4I6GdiCBhVAcmLC5lCX8FLUddFA5Yr+oKnyiYUdPWZTMG3GDZ0Cu7yhE+J6TafKG7iKXe
 S0ZW+5gjcuksb89JZBHWEg9n5iCk3HZrjYxfc39Ed2GY1wlsOP/YC/ZEFQEt2z+VETdi8R9mz
 JMWmjI+AUTVzunO+j8CG/zm7o77uXKYivvgwWr30EDqEYjxuU/4gbYYJlnx9jLVD5pNUoH+zB
 XRDyrjBcciOUw8eT8iSeCZGdAVWFGaNPnNPMnrRVg5WWQOcZrp73XHgOvTbV5RTRVLtba3P60
 ekOK2IVojs2FPEs+X/YMDWdqXwNkDhfhbX17uJgA3h8SPW9qQc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Thu, 21 Sep 2017, Michael Haggerty wrote:

> On 09/20/2017 08:50 PM, Jeff King wrote:
> > On Tue, Sep 19, 2017 at 08:22:22AM +0200, Michael Haggerty wrote:
> >> If `packed-refs` was already sorted, then (if the system allows it)
> >> we can use the mmapped file contents directly. But if the system
> >> doesn't allow a file that is currently mmapped to be replaced using
> >> `rename()`, then it would be bad for us to keep the file mmapped for
> >> any longer than necessary. So, on such systems, always make a copy of
> >> the file contents, either as part of the sorting process, or
> >> afterwards.
> > 
> > So this sort-of answers my question from the previous commit (why we
> > care about the distinction between NONE and TEMPORARY), since we now
> > start treating them differently.
> > 
> > But I'm a bit confused why there's any advantage in the TEMPORARY case
> > to doing the mmap-and-copy versus just treating it like NONE and reading
> > it directly.
> > 
> > Hmm, I guess it comes down to the double-allocation thing again? Let me
> > see if I have this right:
> > 
> >   1. For NO_MMAP, we'd read the buffer once. If it's sorted, good. If
> >      not, then we temporarily hold it in memory twice while we copy it
> >      into the new sorted buffer.
> > 
> >   2. For TEMPORARY, we mmap once. If it's sorted, then we make a single
> >      copy. If it's not sorted, then we do the copy+sort as a single
> >      step.
> > 
> >   3. For MMAP_OK, if it's sorted, we're done. Otherwise, we do the
> >      single copy.
> > 
> > So this is really there to help the TEMPORARY case reading an old
> > unsorted file avoid needing to use double-the-ram during the copy?
> > 
> > That seems like a good reason (and it does not seem to add too much
> > complexity).
> 
> Yes, that's correct. A deeper question is whether it's worth this extra
> effort to optimize the conversion from "unsorted" to "known-sorted",
> which it seems should only happen once per repository. But
> 
> * Many more Git commands read the `packed-refs` file than write it.
>   So an "unsorted" file might have to be read multiple times before
>   the first time it is rewritten with the "sorted" trait.
> 
> * Users might have multiple Git clients writing their `packed-refs`
>   file (e.g., the git CLI plus JGit in Eclipse), and they might not
>   upgrade both clients at the same time to versions that write the
>   "sorted" trait. So a single repository might go back and forth
>   between "unsorted" and "known-sorted" multiple times in its
>   life.
> 
> * Theoretically, somebody might have a `packed-refs` file that is so
>   big that it takes up more than half of memory. I think there are
>   scenarios where such a file could be converted to "sorted" form
>   in `MMAP_TEMPORARY` mode but would fail in `MMAP_NONE` mode.
> 
> On the downside, in my benchmarking on Linux, there were hints that the
> `MMAP_TEMPORARY` branch might be a *tiny* bit slower than the `MMAP_OK`
> branch when operating on a known-sorted `packed-refs` file. But the
> speed difference was barely detectable (and might be illusory). And
> anyway, the speed difference on Linux is moot, since on Linux `MMAP_OK`
> mode will usually be used. It *would* be interesting to know if there is
> a significant speed difference on Windows. Dscho?

Sadly, I lack the time to test this thoroughly, but my experience is that
those things are dominated by I/O on Windows, i.e. that the malloc() and
copy won't matter all that much.

In any case, the same argument you make for Linux holds, in reverse, for
Windows: we cannot use MMAP_OK on Windows, so the point is moot ;-)

Ciao,
Dscho
