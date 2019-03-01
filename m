Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82DBB20248
	for <e@80x24.org>; Fri,  1 Mar 2019 13:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbfCANUF (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 08:20:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:54025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfCANUE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 08:20:04 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaGJa-1hPg1f2j0A-00m2Zg; Fri, 01
 Mar 2019 14:19:53 +0100
Date:   Fri, 1 Mar 2019 14:19:37 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nazri Ramliy <ayiehere@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] built-in rebase: no need to check out `onto` twice
In-Reply-To: <7b1282bf-4b94-5725-00df-2dc63eaa93f0@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903011415220.41@tvgsbejvaqbjf.bet>
References: <pull.153.git.gitgitgadget@gmail.com> <2d99429387ba63526efe233bbefe851c5d556fdc.1551367664.git.gitgitgadget@gmail.com> <7b1282bf-4b94-5725-00df-2dc63eaa93f0@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qLG+GaQCfrIXaqy7MNKJDlxsGRn/DO6xeViphmMXfxZYecngdk8
 sovd9pywuYAQrBGdtcCh5Ujx69V5VjRktBnjn+4+h+f2pKhatfPxjf5M8Gd7Po3L0478Xh6
 7tj4dYsWAiFXphc3iqX4y4dgRDiGMsdzdagE8TdodUDyByRYE+/vqGA5KKvQZMRDmK/GNVE
 Lt+GcoHjWlngKtnvUyWJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WD8iaxnmeLU=:kT4RsYEEGH4UeJhAzl3DK7
 sxNbRpTqxlnLr0P/k8eLVxaWptquqyzUnsU6qUqSb2eQNgzOGwBRasPT5/m5/656nkGzd+l19
 HMcLPQogh+IVRvaalxKEXdHgDdVqQhoQCQFidf6hesnVSHXoNyJwUSAwKunq+CoUPZ07HePyt
 QtUc0KP74fYFoAI4hItxWBFOACF0/AnqM/riTCYUgwUXORTnOFREEufG9Z5bH8kA/MqmFRa9i
 nr5Y15rUakdfjIhwdnnUpRsX0co28+Wc48YPMTW5go/Mt0mIcimbtbigaujo4GXcnGvt+qr45
 a5GvWrBdSWAdNtLuvQvAkYWXGLvvmXUpy+68o3FclURJ5blpmNU7MGrBSX3X40If4mu6emgw3
 6ss3xsQa2gX66hikHc2ArWPelmmxC0mM+0jeEfoznCCOUoJlS6tZZvu/IL1JVYHEBgwy7+ovT
 RX3/tfWPhf05lQIlIDoaCZWlwI2caWc9HqsQEzKvASr6Diy57Nk0cI+GmEpldG1ZCHQsjDyw0
 m/YDbTvbtU1IVIYFV/ck1iYe5CukRuwRoeS7vZfENSTLNoEvS7N2DEtvns4kfuBb3NCSfIXO2
 f7Oyv8ZIQvA3Ei80jvrIPhGfleHn1+hbV0NEKV79bPAPRfhmWCr74Ps/wuZL5iZyuCVnSWnuu
 0JJQgvj8apBYfuv1IbhR+HCzyAXLU8p9dmsOnChs7DJGLmR+86o9oK48S/P+2p5qitEs0IPdl
 ZeRAgB5Zh/jLn+7fXuE+79+I/nPI2Eu529J4rHTYc+xQdkkcwf2EiwS/rnrBshZ8J3Kj82S3P
 sQ94LDUpDbKDtPAG1GNOsIRh/FFVSjFglA0WPpQ2a9i/0dXwp/mwcqeWeVcIA7f78qi3STM3J
 qqhejedHTUkc2wQrMJIGDpvopHqHDkf2XeiL+/8/v+4A3q/jLvrJd1uDmKx+5eZLSlMOiGdT+
 /WQeM53MPUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 28 Feb 2019, Phillip Wood wrote:

> On 28/02/2019 15:27, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > In the case that the rebase boils down to a fast-forward, the built-in
> > rebase reset the working tree twice: once to start the rebase at `onto`,
> > then realizing that the original HEAD was an ancestor, `reset_head()`
> > was called to update the original ref and to point HEAD back to it.
> > 
> > That second `reset_head()` call does not need to touch the working tree,
> > though, as it does not change the actual tip commit. So let's avoid that
> > unnecessary work.
> 
> I'm confused by this I think I must be missing something. If we've checked out
> onto then why does the working copy not need updating when we fast forward.
> (also why to we checkout onto before seeing if we can fast-forward but that's
> not related to this patch series)

Sorry, I really try to learn how to express things clearly. Still learning
a lot.

So what happens is this: we detect the situation where the pre-rebase
`HEAD` is an ancestor of `onto`. We do this *after* checking out `onto`.
So we now know that we essentially fast-forwarded to the post-rebase
state.

What we still need to do is to update the original ref (unless we were on
a detached HEAD when the rebase was started).

The original shell code updates the original ref to the current HEAD, and
the updates HEAD to point to that symbolic ref instead of being detached.

In the C code, we abused `reset_head()` to do the same. But `reset_head()`
does more: it does a two-way merge (in this instance, because
`RESET_HEAD_HARD` was not part of the flags). Which is unnecessary.

That's all this commit is about.

Ciao,
Dscho

> 
> Best Wishes
> 
> Phillip
> 
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   builtin/rebase.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 08ec4d52c7..813ec284ca 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -1740,8 +1740,8 @@ int cmd_rebase(int argc, const char **argv, const char
> > *prefix)
> >     strbuf_addf(&msg, "rebase finished: %s onto %s",
> >      options.head_name ? options.head_name : "detached HEAD",
> >      oid_to_hex(&options.onto->object.oid));
> > -		reset_head(NULL, "Fast-forwarded", options.head_name, 0,
> > -			   "HEAD", msg.buf);
> > +		reset_head(NULL, "Fast-forwarded", options.head_name,
> > +			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf);
> >     strbuf_release(&msg);
> >     ret = !!finish_rebase(&options);
> >     goto cleanup;
> > 
> 
