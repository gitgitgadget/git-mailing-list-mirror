Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C327207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947889AbdDTV6f (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:58:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:62215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947880AbdDTV6f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:58:35 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mb31L-1chrGN1Rn9-00Kj2y; Thu, 20
 Apr 2017 23:58:16 +0200
Date:   Thu, 20 Apr 2017 23:58:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] Increase core.packedGitLimit
In-Reply-To: <20170420210254.f4ykyi46bso5uj3o@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1704202355230.3480@virtualbox>
References: <20170420204118.17856-1-dturner@twosigma.com> <20170420210254.f4ykyi46bso5uj3o@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7GLNsX2DSv1Mcgks0lqICUQm8Q395nkEqlJe7GhXZgnDqT6RRU9
 S74Oea+UHrsTUkKJpQByQWZ9REKp88MaP/+g2+DhvyaVaAU4oVB6ydo73EqDxcoee2h/FCL
 LIphXKCz7vmh34Ov6Dyh3JFcWhqX1yvmfLk9Pije4npaqD/+uO6+ERN79RQtAIehD4glGsM
 jRBSPxOAlBB3u3aWN1gKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a+sOcDjrNh0=:P1TcQhCttLzk3/5cSt4932
 pz1tm7p3C8XW7gel4RxictQBgrjnUm4pVWATVCRV14gLiTcBzhsqzMb2NkkJJL6YGFv8nEMwH
 Km+tN8TKg9NfPaJNlwGyLAkOSKuckBM6Goz/q6Rb/Vd4tS3iytERNgUftt1l/ssd40EXvcM9U
 qbumnsEI3i1IJG3+/7Sft2/L5rXuV1N/rkikVZ+y4WCIkI0ISVTaT6bhWQ8kKXiM31uYU0TA8
 VlK2sWbVBwTZl3fp4miynlSo0dK9Zc+a6nR5PrMRVD2nhCmxWAMFwwxSrEok0b8LF0fuLHE19
 fsa6umEhD/idpy3cUrg01jWkMJ8haD6vl7fkIViIdGj+f9e55jD4f/MdFNtdJQBevyTZnzQPj
 JrJp6gkDNVOUnfmA8Ll4zXYxZnCtBQvurtUOu6XqLB1Ox+7NIiUtbfFccYrgxd/jFdK/iUU5G
 O7RJxpCVPdHGeXkLWJ+yZU6lW0TcVwxf5fN1zsKBf3FVSljLivp1YrV8djfHRkuMxR4+W9O3/
 +3ILwf7Nrcz8aOuibfbgHc6wpy/8NYyQ6Q5WOYYTYQewOOI0gk+xAl5Mr8VTqrCvP0zIDCOLy
 DUHmU4oSoxp5/wgKCf7qx85+hQ1EFda1FWHiUCCyseUND/GeviEenWEwGUtyi1GR35LWr5vh1
 GIuzeTgGuHgTipBxKQzHsI89UXZdhffiYY/J1lD2G+ibY0MMoIKsxzJiOlGcQR3LGWvA++8Dy
 Ey27CaTBakrT/wBn19KohKbwEG9A8slf7pzYhApNk0EpHOhqSs75YWIQqILYTWsSZXF+9gK/r
 dw3vPz8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 20 Apr 2017, Jeff King wrote:

> On Thu, Apr 20, 2017 at 04:41:18PM -0400, David Turner wrote:
> 
> > When core.packedGitLimit is exceeded, git will close packs.  If there
> > is a repack operation going on in parallel with a fetch, the fetch
> > might open a pack, and then be forced to close it due to
> > packedGitLimit being hit.  The repack could then delete the pack
> > out from under the fetch, causing the fetch to fail.
> > 
> > Increase core.packedGitLimit's default value to prevent
> > this.
> > 
> > On current 64-bit x86_64 machines, 48 bits of address space are
> > available.  It appears that 64-bit ARM machines have no standard
> > amount of address space (that is, it varies by manufacturer), and IA64
> > and POWER machines have the full 64 bits.  So 48 bits is the only
> > limit that we can reasonably care about.  We reserve a few bits of the
> > 48-bit address space for the kernel's use (this is not strictly
> > necessary, but it's better to be safe), and use up to the remaining
> > 45.  No git repository will be anywhere near this large any time soon,
> > so this should prevent the failure.
> 
> Yep, I think this is a reasonable direction.
> 
> > ---
> >  git-compat-util.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This probably needs an update to the core.packedGitLimit section of
> Documentation/config.txt.
> 
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 8a4a3f85e7..1c5de153a5 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -616,7 +616,7 @@ extern int git_lstat(const char *, struct stat *);
> >  #endif
> >  
> >  #define DEFAULT_PACKED_GIT_LIMIT \
> > -	((1024L * 1024L) * (size_t)(sizeof(void*) >= 8 ? 8192 : 256))
> > +	((1024L * 1024L) * (size_t)(sizeof(void*) >= 8 ? (32 * 1024L * 1024L) : 256))
> 
> I wondered if we would run afoul of integer sizes on 64-bit systems where
> "long" is still only 32-bits (i.e., Windows). But I think it's OK,
> because the values before we cast to size_t are in megabytes. So your
> 32*1024*1024 needs only 25 bits to store it. And then after we cast to
> size_t, everything is in 64-bit.

Indeed, when I patch a local Git checkout accordingly, I see that
packed_git_limit is set to 35184372088832.

The bigger problem in this regard is that users are allowed to override
this via core.packedgitlimit but that value is parsed as an unsigned long.

Ciao,
Dscho
