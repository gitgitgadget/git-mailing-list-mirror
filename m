Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0053A207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 22:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936993AbdD0Wy1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 18:54:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:52883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750772AbdD0Wy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 18:54:26 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lxgt9-1e9otx1lgR-017EOf; Fri, 28
 Apr 2017 00:54:14 +0200
Date:   Fri, 28 Apr 2017 00:54:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/26] setup_bare_git_dir(): fix memory leak
In-Reply-To: <CAGZ79kaJGLQjg09WMuK6v9yPpwmFnNkDq+4Tg0O7JUYEPaCjOw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704280052410.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <042b3e98e9e5b8850c35103cc56cf651b2fb3f6e.1493237937.git.johannes.schindelin@gmx.de> <CAGZ79kaJGLQjg09WMuK6v9yPpwmFnNkDq+4Tg0O7JUYEPaCjOw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fXWGakFR0qA0EeSlQRJUcuRdA3gJJQQR7lJJ/Qbat1Ro2nAlsyF
 TH9pEARlu3XV19yIqaSBn3Kh1AFBvdoa8czebKxbPA0ZtCCdGc/CYyJxOTZvHgvmBOgiDWt
 ESU8rYr8AyQHlwEEWGqu5gycmtfTc4VXXHOK+ad19/xgJxsInotNm7ruZssWYq/uG6lEJMU
 0sGyRaElQrCac4Y72nxdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:adO2L5ohpUw=:jM3r48qDBH+QWCVWLXTCKA
 V1IJgKgT++D0tOSB5Dt/9lU7UGn/tpevrDgM1e193wf2N2emS8cCiNyN+D+U8iHdxAb+zFRnJ
 y3FnnPTx+YswjN+lmakV8Hf8RL/D9RwLKtc8olPP+r2yIFWx4UVTosU7/ArreftP32A2MktBQ
 kgEnzXQSMJFrrQeHsEevSHYF8h20PR7GfSHD5SA12QOE+gWGT24+pE+e6/pYxy4XoAEBSuFJl
 8iNjez611H0iZAQp90xFzPcOHG5INe0OJdMa8CuhtRJ72/h3dZ+0YHPpS7d/C0D1G2x53X5Dg
 9Iv2glU4SMmssUDedfKuyHOqImHE8/WsZzfhwX6HwSGBR5AIT9+TQ5K27Z0rTQk8/CvKn973A
 op82kVHp7RvdWLGHHMFAkz9wUDdnAwYGgn5Kfi4mKwtizKOH1MSyM95mJ8XN0HXTgy5mkUruO
 q//IpaygfULnKXjpKqbDbfSCvmmPBR1mgPL+nIilXROkYpftP7U3lJ0IQcfbkNjtQedW4Pyx3
 XimiaEExZAd8/JLyfgAPP3xhn0XpGOafoQV6dM8GemmEd+OQ4kwqGs3P8BjeRZdoHAomMRweU
 jQ9R9g+Bj9dAqzbFZUIWuRRB4zROnZkUtk+BrKfvkX/axIZl7LQnDP1jDgaYYWpiEpcT24mqK
 WWy+c1uHhh60gq/FRdMN/aryB7tugLBk2fePB2+hv2xU+ErdwvXK1yVg/DWRv2+Lvr8AYoPUg
 1Bqtti9rttZS5e0GHOJWMS00U7N7PmqTbK6rIpDDsZlJcc4PzN4mOgvOTDu5yakzdzxemaCw/
 gGo/qfC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 26 Apr 2017, Stefan Beller wrote:

> On Wed, Apr 26, 2017 at 1:20 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > Reported by Coverity.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  setup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/setup.c b/setup.c
> > index 0309c278218..0320a9ad14c 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -748,7 +748,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
> >
> >         /* --work-tree is set without --git-dir; use discovered one */
> >         if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
> > -               const char *gitdir;
> > +               static const char *gitdir;
> 
> This alone doesn't fix the memleak if the code were called multiple times.
> As by having it static it will be init'd to NULL, we could introduce a
> 
>     static const char *gitdir; /* must live until the end of time because ... */
>     if (!gitdir)
>         die("BUG: called setup_bare_git_dir twice?");
> 
> I tried looking into setup_explicit_git_dir that is called with gitdir here
> and it looks like it duplicates the memory in most cases, so maybe we
> can even get away with no static variable here and instead either inline
> the gitdir computation in the arguments of setup_explicit_git_dir
> or have a variable here that holds the returns of setup_explicit_git_dir
> such that we can free after?

setup_bare_git_directory() is called by setup_git_directory(), and that
latter function is not reentrant. If you call setup_git_directory()
multiple times, it will wreak havoc, as e.g. the second time the prefix
cannot be determined correctly because we chdir()ed up into the top-level
directory.

So I am not worried about this new static, it is essentially a singleton.

Ciao,
Dscho
