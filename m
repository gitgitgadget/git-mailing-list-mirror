Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8F820133
	for <e@80x24.org>; Fri,  3 Mar 2017 14:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbdCCOLs (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 09:11:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:63475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751369AbdCCOLq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 09:11:46 -0500
Received: from virtualbox ([37.201.194.68]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4GND-1cSXtp1yvD-00rpTt; Fri, 03
 Mar 2017 14:54:50 +0100
Date:   Fri, 3 Mar 2017 14:54:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/9] setup_git_directory(): avoid changing global
 state during discovery
In-Reply-To: <20170303042422.s3dnbgbjszhygwqz@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703031220170.3767@virtualbox>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de> <49f66f2b723af38a58c17bc8ae413bcee69e2a2f.1488506615.git.johannes.schindelin@gmx.de> <20170303042422.s3dnbgbjszhygwqz@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:U3y7turcE5fqB1JVeyjZyqzgmca4uds0i8gXEgVtcPDcW8HukiY
 L7QMZwBkVG6ra4YCTi4I+db1cpRnZ9qiZaZHgCrEMKgcuWexZMbzZvCVu6J7uemVW5ir4Xg
 HXyEtKP0gkoFxAbcGCOrhXCZ+X6THz74N4KAj4y4OIEq3iqecDnW3hFfNKoVjJPWDz5+8z3
 6jD6XJ4I/2Fxnq3w4sYXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F+TQInL8WbY=:VxiSa2H2S1sXKj+n3YWvVJ
 w1kpV8LSdn9AvhXPd5/acP2EEDtUs6NabOloIuIkCObwPt1ZpyHuPHnHLymhoMP52a9FF8isL
 jlY4mSwdw7fHg5TBSygv1gRXbSFdigLl8pFniHkC0vat6ES3voODv/vomu7dvHg7W3K7zWb2n
 ZQjx3rP3/Ruh1hlm6ym1QpWuDg9bBN6PymozWI7zCBZzm+ONWrJGbGaHxTsgNRMZr4CejEVXy
 wR2+MEf3tgiRJxkwzUEnnkrvBH0plURGq56CtMYNM/APDvPyZKj/5XRqnPYWVABVn4B+R6rqI
 EI8Q+AdlrFAOg79jvmDNowO6BwTaVtCKqq8PIYVUXpCl/tZ7xkyJDVflNLJT+yxxq3XtgTDtA
 fL0mbsPk5OTn9UuPPOl+bNRJF2k6JSUf2R6MK8RCkzjiIOwqVmw1M1iZgqLsoXotPNPcaTHTu
 pb9AeTpDlqjzAmi3uB6IAHm2SFr/K2n2aRTZ047514qpoFyZyEI6HMsCS7RqxvFhctQIdtcCX
 Voh0xQzGawpxiM9CSGoHtMgvPgqLk6KJfJHUM17CCK6zVE4etvh9MJnJ9Fl06kV5AR0Brh0UV
 hCEXOvGedeCKPxUtwRLA4bVCwzb9zn4a1z2Hfv2GIAi/hCoaOQBpxV++Yvt12NP2sg1iXLp0V
 4g6TNxRgKDwf//sFKmQwoCc6TS5Vb2jkg0JOJZMLrdWwO1C44eaxAiFbNAxFu7deQnoNkD76T
 +ICMfokVJtCMzHy8HVktlRiQrGLZxK7C37pGaW8Cme9smk3VOOzyhAqrTZ/boEVfiD7KHo9rP
 8CYvv0e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 2 Mar 2017, Jeff King wrote:

> On Fri, Mar 03, 2017 at 03:04:11AM +0100, Johannes Schindelin wrote:
> 
> > For historical reasons, Git searches for the .git/ directory (or the
> > .git file) by changing the working directory successively to the
> > parent directory of the current directory, until either anything was
> > found or until a ceiling or a mount point is hit.
> 
> This is starting to get into the meat of changes we've been putting off
> writing for ages. I'll read with my fingers crossed. :)

Heh.

> > Further global state may be changed, depending on the actual type of
> > discovery, e.g. the global variable
> > `repository_format_precious_objects` is set in the
> > `check_repository_format_gently()` function (which is a bit
> > surprising, given the function name).
> 
> It's gentle in the sense that if it does not find a valid repo, it
> touches no state. I do suspect the functions you want are the ones it
> builds on: read_repository_format() and verify_repository_format(),
> which I added not too long ago for the exact purpose of checking repo
> config without touching anything global.

Okay. But I think that my interpretation of the word "gently" is as valid
as Git's source code's.

> > We do have a use case where we would like to find the .git/ directory
> > without having any global state touched, though: when we read the early
> > config e.g. for the pager or for alias expansion.
> > 
> > Let's just rename the function `setup_git_directory_gently_1()` to
> > `discover_git_directory()` and move all code that changes any global
> > state back into `setup_git_directory_gently()`.
> 
> Given the earlier paragraph, it sounds like you want to move the
> global-state-changing parts out of check_repository_format_gently(). But
> that wouldn't be right; it's triggered separate from the discovery
> process by things like enter_repo().

Oh, right. I really only meant to move the global-state-changing parts out
of the discover_git_directory().

> However, I don't see that happening in the patch, which is good. I just
> wonder if the earlier paragraph should really be complaining about how
> setup_git_directory() (and its callees) touches a lot of global state,
> not check_repository_format_gently(), whose use is but one of multiple
> global-state modifications.

Okay, I'll try my best to rephrase the commit message.

For good measure, I will also keep the name setup_git_directory_gently_1()
because it won't get exported directly (I made up my mind about wrapping
that function to allow for an easier interface that does *not* return the
"cdup").

> > Note: the new loop is a *little* tricky, as we have to handle the root
> > directory specially: we cannot simply strip away the last component
> > including the slash, as the root directory only has that slash. To
> > remedy that, we introduce the `min_offset` variable that holds the
> > minimal length of an absolute path, and using that to special-case the
> > root directory, including an early exit before trying to find the
> > parent of the root directory.
> 
> I wondered how t1509 fared with this, as it is the only test of
> repositories at the root directory (and it is not run by default because
> it involves a bunch of flaky and expensive chroot setup).

Oh, thanks. I allowed myself to forget about that test script (and did a
lot of testing by hand, but of course *during* the development of v2, not
when I had finished...).

> Unfortunately it seems to fail with your patch:
> 
>   expecting success: 
>   		test_cmp_val "foo/" "$(git rev-parse --show-prefix)"
>   	
>   --- expected
>   +++ result
>   @@ -1 +1 @@
>   -foo/
>   +oo/
>   not ok 66 - auto gitdir, foo: prefix

I can reproduce this failure here.

Side note: it took a while until I realized that the prepare-chroot.sh
script has to be run *every time* I change *anything* in either Git's
source code or in the test script.

> Could the problem be this:
> 
> > +	int ceil_offset = -1, min_offset = has_dos_drive_prefix(dir->buf) ? 3 : 1;
> > [...]
> > -	if (ceil_offset < 0 && has_dos_drive_prefix(cwd.buf))
> > -		ceil_offset = 1;
> > +	if (ceil_offset < 0)
> > +		ceil_offset = min_offset - 2;

Yes. The previous code did not need cwd.buf[0..offset] to be a valid path,
but it needed the offset to point to the trailing slash, if any.

> Interestingly, I don't think this is the bug, though. We still correctly
> find /.git as a repository. The problem seems to happen later, in
> setup_discovered_git_dir(), which does this:
> 
>   /* Make "offset" point to past the '/', and add a '/' at the end */
>   offset++;
>   strbuf_addch(cwd, '/');
>   return cwd->buf + offset;

I fixed this by ensuring that we only increment the offset if it is not
already pointing at the end of the first offset (which handles Windows
paths correctly, too).

> Other than this bug, I very much like the direction that this patch is
> taking us.

Awesome. I was anxious to hear something like that.

Ciao,
Dscho
