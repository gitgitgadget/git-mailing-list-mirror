Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8FD720450
	for <e@80x24.org>; Fri,  3 Nov 2017 12:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933038AbdKCMc4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 08:32:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:62745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbdKCMcz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 08:32:55 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXZNq-1dfAcY0C9O-00WVCq; Fri, 03
 Nov 2017 13:32:48 +0100
Date:   Fri, 3 Nov 2017 13:32:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Andrew Baumann <Andrew.Baumann@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git tries to stat //HEAD when searching for a repo, leading to
 huge delays on Cygwin
In-Reply-To: <20171103010300.3jwme4d6nbxnj6od@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1711031324110.6482@virtualbox>
References: <MWHPR21MB0159089DB91A30E5E5CFCB479E5C0@MWHPR21MB0159.namprd21.prod.outlook.com> <20171103010300.3jwme4d6nbxnj6od@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WrJH35/zbhacaJJwQuJEbBjzcjVUZZ6qm8VZF74YjoneLbT45D3
 KO0bKQXsMzkblnExGJ5/e4ntQ27vhkeIudPe6AYdtxAaKwnHvggdOPnlfS+WKc9ab6UYt9b
 yWyaXbMrBhQqVMDxOOLPBG/ATphbGfqGRvpohW8i9uS8SB4Lpr0pZXDlggPORS5sCQZ3PVv
 VmuXd3oUuu+TTuMKMRdCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tpOsmDGpUoc=:VOkS2twPLEDg8tOQt8+77l
 RFxg0+jD+aKCshmJgDa2B3aDQNLifkoZrksYyaEZJdsaDHAe4hgs9T2z0PzVHVXtINpPlW82u
 ZcSARdX54Mb0C9i9Y19qBqye+3YcwLcLmqaHQmZYP/GaIVQRpxl2GwIQsVorQ17ILkqxt4dmF
 LVplAdGhgk0nOG5bRrMuRZlnQxuy/BoewpPDwcP+y5EFg0td6Qs4Xo/hg5caNan3lDS4xz5il
 iHZOsVbHHExwYoLzoQ7i0qCI5o0A6HuJ5+0STJWO8pOCEpT3JWRSESO6yhhfjcaTdxQYn8lV5
 m/u6v27BJXLbBi6amcwPD5lDM3q8dQ6/he5nNsqMpUeLvLvSFLAt2zCPG+f4A6fNAKo1QDLXs
 tN6/muB8GSBGAe5cCTFGwoeMPIgfks2w5pzudotBlUtZYSod8bzOf+CUI4PsPBGri0FyJ/coJ
 IZ/5dONKCdbD4L4lIH/cOGXVBcy/SUSx8AsPGaTh1op0Vrgt1O8mHRp7KKgBYBET8jZuDvbIJ
 sdQBNPJ71XlUD6McbRjv1cBg5e/4LBn8aFy5tw7Gl1DD3hyaNP5pi4rG7goHp0UoFBh9Ald2+
 JYtlG4Wvu/g8gzUoVcHvasVURo2ZnlGdnSgylMJbVEZfuirN6Iq0e3DolxhdEfdn2+H6Jo/Ho
 C2GuVqaKTEdT5EZpQ6yPoXgjzmQUMEx7CcrBYv/lcNLWEQ2VmOksjjnpWTKN62wPJrUSW2nPb
 5DtvxfxlGuJm4T0X0Hj4pdHHq92lECWOl3Pwa3UGxTUrlLWjBrGZx44fimQLiZ6GsmF1ZqREu
 +TSwFQc/0LS5byt7IOLd/NPH09oM6MKAShrUI3AkrQAMWgoouw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,


On Thu, 2 Nov 2017, Jeff King wrote:

> On Thu, Nov 02, 2017 at 11:45:55PM +0000, Andrew Baumann wrote:
> 
> > I have a workaround for this, but someone on stack overflow [1]
> > suggested reporting it upstream, so here you go:
> > 
> > I have a fancy shell prompt that executes "git rev-parse
> > --is-inside-work-tree" to determine whether we're currently inside a
> > working directory. This causes git to walk up the directory hierarchy
> > looking for a containing git repo. For example, when invoked from my
> > home directory, it stats the following paths, in order:
> > 
> > /home/me/.git
> > /home/me/.git/HEAD
> > /home/me/HEAD
> > /home
> > /home/.git
> > /home/.git/HEAD
> > /home/HEAD
> > /
> > /.git
> > /.git/HEAD
> > //HEAD
> > 
> > The last name (//HEAD) interacts badly with Cygwin, which interprets
> > it as a UNC file share, and so demand-loads a bunch of extra DLLs and
> > attempts to resolve/contact the server named HEAD. This obviously
> > doesn't work too well, especially over a slow network link.
> > 
> > I've tested with the latest Cygwin git (2.15.0); this was also present
> > in a prior version.
> 
> Interesting. I can reproduce on Linux (but of course "//HEAD" is cheap
> to look at there). It bisects to ce9b8aab5d (setup_git_directory_1():
> avoid changing global state, 2017-03-13). Before that, the end of the
> strace for "git rev-parse --git-dir" looks like:
> 
>   chdir("..")                             = 0
>   stat(".git", 0x7fffba398e00)            = -1 ENOENT (No such file or directory)
>   lstat(".git/HEAD", 0x7fffba398dd0)      = -1 ENOENT (No such file or directory)
>   lstat("./HEAD", 0x7fffba398dd0)         = -1 ENOENT (No such file or directory)
>   write(2, "fatal: Not a git repository (or "..., 69) = 69
> 
> and after:
> 
>   stat("/.git", 0x7ffdb28b7eb0)           = -1 ENOENT (No such file or directory)
>   lstat("/.git/HEAD", 0x7ffdb28b7e80)     = -1 ENOENT (No such file or directory)
>   lstat("//HEAD", 0x7ffdb28b7e80)         = -1 ENOENT (No such file or directory)
>   write(2, "fatal: Not a git repository (or "..., 69) = 69
> 
> Switching to using absolute paths rather than chdir-ing around is
> intentional for that commit, but it looks like we just need to
> special-case the construction of the root path.
> 
> Like this, perhaps:
> 
> diff --git a/setup.c b/setup.c
> index 27a31de33f..5d0b6a88e3 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -283,7 +283,9 @@ int is_git_directory(const char *suspect)
>  	size_t len;
>  
>  	/* Check worktree-related signatures */
> -	strbuf_addf(&path, "%s/HEAD", suspect);
> +	strbuf_addstr(&path, suspect);
> +	strbuf_complete(&path, '/');
> +	strbuf_addstr(&path, "HEAD");
>  	if (validate_headref(path.buf))
>  		goto done;

Yes, that would work around the issue. TBH I expected `/` to not be a
valid bare repository path (and therefore I thought that `suspect` could
never be just a single slash), but people do all kinds of crazy stuff, right?

I note also that there are tons of `strbuf_addstr(...);
strbuf_complete(..., '/');` patterns in our code, as well as
`strbuf("%s/blub", dir)`, which probably should all be condensed into
single function calls both for semantic clarity as well as to avoid double
slashes in the middle of paths.

In the short run, though, let's take your patch. Maybe with a commit
message like this?

-- snipsnap --
setup: avoid double slashes when looking for HEAD

Andrew Baumann reported that when called outside of any Git worktree, `git
rev-parse --is-inside-work-tree` eventually tries to access `//HEAD`, i.e.
any `HEAD` file in the root directory, but with a double slash.

This double slash is not only unintentional, but is allowed by the POSIX
standard to have a special meaning. And most notably on Windows, it does,
where it refers to a UNC path of the form `//server/share/`.

As a consequence, afore-mentioned `rev-parse` call not only looks for the
wrong thing, but it also causes serious delays, as Windows will try to
access a server called `HEAD`.

Let's simply avoid the unintended double slash.

Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
