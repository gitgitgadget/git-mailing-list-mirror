Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9718C33CB3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 21:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E0B2064C
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 21:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TKhE454J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgBAVZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 16:25:50 -0500
Received: from mout.gmx.net ([212.227.15.19]:40619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgBAVZu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 16:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580592337;
        bh=BPY+fjRhuoADpj0x7KKGenWZLkvfcZAPb49RpOU+NNA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TKhE454Jr+dmICy71Wr8ShR2Z5xGnU2id4bKN6Uk2DXLfZaHPChZ6ARg71c+9qveg
         7d/3itBrDmE0J5JScrXZCf8TR35xkQNP8Dt6pxkD2xdSvUJj9WtuFJViTOozES8B0M
         nNj0jFWf62stRhD+06FA+rfQxjlX8LmcoJYzxP1Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2E1M-1jhOlb1Rle-013fT1; Sat, 01
 Feb 2020 22:25:37 +0100
Date:   Sat, 1 Feb 2020 22:25:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
In-Reply-To: <20200131233434.GJ10482@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2002012223490.46@tvgsbejvaqbjf.bet>
References: <cover.1580430057.git.me@ttaylorr.com> <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com> <20200131233434.GJ10482@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1139355825-1580592337=:46"
X-Provags-ID: V03:K1:W06CqtfkMc/LyySUF+7rM4dbCViPWMXDXb5nwkZIvPOSRHyQK8J
 rjEqFsKYUzSZvXsKcNqa/VrgWZIJB94LyVK8ksaOVxisVHJSRwl6jx2dbSZnDaf08Ih6AmZ
 /p7+tzLg9PTQ2Pto5saw8Re+LWbKLFjlMdJujmSsFdCb6K5tG18YiHCOggzGODCEtES6W1n
 mHVL/QQgVuZ8PPMEfSzqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mqkbhnsFtis=:e0A3yGlHrLDTtW4m0BJTjJ
 9zCL2ndn5l7zyx2Vr4rx14n12EhFiPmx7g7hD7IlGX3/f3P+a54X0kNjd3Cv2C2t3S8ASgwNI
 fEGs1oUB56tYh8zhxjdrer97/KX3vvGsBeDQANoTXlV3AnlgDwj/FExuUL2b+h70uMbVqQNA8
 I3RkABR5+jArQA3b1boil836D/zOTo/lqgGp6cj8+7mIoi/rTHTFjzkUXk78hfAV4nVUwQhaH
 wV8wn9w4Ko+FSIGXFeBSR9aR9MakChKqtlNo5bWKsEiUlvJlCNN+6O6M5Vg+DZ9fNfSsgJ96D
 a1rtGfrQ2Id7d4yDRkC72UuvzmZcpDAUS3Fed3YtmWQbCKUq0/Xq+QjT1/F4TzB5WrX0hbHbm
 d15MTJ7+IVubA6cAksWI7KoUJW1SYARHRx1LsGFDqS5JwZ+ufYhkR+i+zeUmzTN4rndLZwNYf
 qVmYf/RbV11k4Ii+I536b0rZUG7pysNoumggzx008y4CZTHYDonWo7i12Rr/knJMrWfHMvqN7
 sijIXUyiM/WQoZ9WIzDeSOS1SxjKL8Gl1INFhvPqQcr4yXc+GtGWkH2O/p8O33wulJAO4zS+D
 uAungTPrFACSFD2O8nxOoe/fxuCbczFfCAdBFYczZLgAiZ56sUecaXJzX71yg/8lDqzqrxl4R
 MqSzNrKo/Q5iuqJbt/T8ALAG0bBrUAYQi/j2ZrPCKWjAIgUthk8MTaxxoHW67HsrzzVgmVstT
 jDmkobXoMxXK5o0r2rCGbXPCZ3+hUxUTgNeEyayo1v98W8HMQM6BkD9fhlJ4sRNAnKQDBe203
 4YBGrKV4EhbKnaNrY8kT+yRgUaOIQ6xCep3Tj1G1tcewio9D5ZT+fqGvl2HFgcVYY5i16snqy
 c6UFRLHKBGMLhoWokSTZ9NAGMZgz75EjrKzFY32u3w+RJgADVPV24cuFBsm4S+1ncOFqGKG9e
 diRS0Sunc6R85cDtwaL/8UCR5Bu2FtnzbPcQoylxTbAlQfNaJGf51kMZeC5Xk83AvgmVoAdVO
 3xC+BPz/VRWHnmbSPgylsBNdF0bjAKSyZtfHJNfddBMgbZGduhXV7x3sNf6hDuSFBWarYZney
 Xb6V2gP4X7uQugjPYnVI8hOAy5W5uQ+73W/fxTTV34e76sGjrsFy9uHzSVYavMIelRu3/PrRe
 rP27g1d0r3IjdiJdiLj1vwr6QrApO8KBa/q3W5PpRqNyih2AZB3fSAhMDjcNJa2nDY3wT6i5E
 sskc7TfdXYt80ZXAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1139355825-1580592337=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 1 Feb 2020, SZEDER G=C3=A1bor wrote:

> On Thu, Jan 30, 2020 at 04:28:17PM -0800, Taylor Blau wrote:
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 6d34829f57..02e6ad9d1f 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -1565,15 +1565,18 @@ static void split_graph_merge_strategy(struct =
write_commit_graph_context *ctx)
> >  	num_commits =3D ctx->commits.nr;
> >  	ctx->num_commit_graphs_after =3D ctx->num_commit_graphs_before + 1;
> >
> > -	while (g && (g->num_commits <=3D size_mult * num_commits ||
> > -		    (max_commits && num_commits > max_commits))) {
> > -		if (g->odb !=3D ctx->odb)
> > -			break;
> > +	if (ctx->split_opts->flags !=3D COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED)=
 {
>
> This line segfaults in the tests 'fetch.writeCommitGraph' and
> 'fetch.writeCommitGraph with submodules' in 't5510-fetch.sh', because
> 'git fetch' doesn't pass a 'split_opts' to the commit-graph functions.

I noticed the same. This patch seems to fix it for me:

=2D- snip --
diff --git a/commit-graph.c b/commit-graph.c
index a5d7624073f..af5c58833cf 100644
=2D-- a/commit-graph.c
+++ b/commit-graph.c
@@ -1566,7 +1566,8 @@ static void split_graph_merge_strategy(struct write_=
commit_graph_context *ctx)
 	num_commits =3D ctx->commits.nr;
 	ctx->num_commit_graphs_after =3D ctx->num_commit_graphs_before + 1;

-	if (ctx->split_opts->flags !=3D COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
+	if (ctx->split_opts &&
+	    ctx->split_opts->flags !=3D COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
 		while (g && (g->num_commits <=3D size_mult * num_commits ||
 			    (max_commits && num_commits > max_commits) ||
 			    (ctx->split_opts->flags =3D=3D COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))=
) {
=2D- snap --

For your convenience, I also pushed this up as
`tb/commit-graph-split-merge` to https://github.com/dscho/git

Thanks,
Dscho


>
> Thread 1 "git" received signal SIGSEGV, Segmentation fault.
> 0x00000000005113dd in split_graph_merge_strategy (ctx=3D0x9ca930)
>     at commit-graph.c:1568
> 1568            if (ctx->split_opts->flags !=3D COMMIT_GRAPH_SPLIT_MERGE=
_PROHIBITED) {
> (gdb) p *ctx
> $1 =3D {r =3D 0x9ae2a0 <the_repo>, odb =3D 0x9c0df0, graph_name =3D 0x0,=
 oids =3D {
>     list =3D 0xa02660, nr =3D 12, alloc =3D 1024}, commits =3D {list =3D=
 0x9caa00,
>     nr =3D 6, alloc =3D 6}, num_extra_edges =3D 0, approx_nr_objects =3D=
 0,
>   progress =3D 0x0, progress_done =3D 0, progress_cnt =3D 0, base_graph_=
name =3D 0x0,
>   num_commit_graphs_before =3D 0, num_commit_graphs_after =3D 1,
>   commit_graph_filenames_before =3D 0x0, commit_graph_filenames_after =
=3D 0x0,
>   commit_graph_hash_after =3D 0x0, new_num_commits_in_base =3D 0,
>   new_base_graph =3D 0x0, append =3D 0, report_progress =3D 1, split =3D=
 1,
>   check_oids =3D 0, split_opts =3D 0x0}
>                   ^^^^^^^^^^^^^^^^
> (gdb) bt
> #0  0x00000000005113dd in split_graph_merge_strategy (ctx=3D0x9ca930)
>     at commit-graph.c:1568
> #1  0x0000000000512446 in write_commit_graph (odb=3D0x9c0df0, pack_index=
es=3D0x0,
>     commit_hex=3D0x7fffffffd550,
>     flags=3D(COMMIT_GRAPH_WRITE_PROGRESS | COMMIT_GRAPH_WRITE_SPLIT),
>     split_opts=3D0x0) at commit-graph.c:1891
> #2  0x000000000050fd86 in write_commit_graph_reachable (odb=3D0x9c0df0,
>     flags=3D(COMMIT_GRAPH_WRITE_PROGRESS | COMMIT_GRAPH_WRITE_SPLIT),
>     split_opts=3D0x0) at commit-graph.c:1174
>     ^^^^^^^^^^^^^^
> #3  0x0000000000444ea4 in cmd_fetch (argc=3D0, argv=3D0x7fffffffd9b8, pr=
efix=3D0x0)
>     at builtin/fetch.c:1873
> #4  0x0000000000406154 in run_builtin (p=3D0x969a88 <commands+840>, argc=
=3D2,
>     argv=3D0x7fffffffd9b0) at git.c:444
> #5  0x00000000004064a4 in handle_builtin (argc=3D2, argv=3D0x7fffffffd9b=
0)
>     at git.c:674
> #6  0x000000000040674c in run_argv (argcp=3D0x7fffffffd84c, argv=3D0x7ff=
fffffd840)
>     at git.c:741
> #7  0x0000000000406bbd in cmd_main (argc=3D2, argv=3D0x7fffffffd9b0) at =
git.c:872
> #8  0x00000000004cfd4e in main (argc=3D5, argv=3D0x7fffffffd998)
>     at common-main.c:52
>
> Note that this function split_graph_merge_strategy() does look at
> various fields in 'ctx->split_opts' a bit earlier, but those accesses
> are protected by a 'if (ctx->split_opts)' condition.
> expire_commit_graphs() does the same.
>
>
> > +		while (g && (g->num_commits <=3D size_mult * num_commits ||
> > +			    (max_commits && num_commits > max_commits) ||
> > +			    (ctx->split_opts->flags =3D=3D COMMIT_GRAPH_SPLIT_MERGE_REQUIR=
ED))) {
> > +			if (g->odb !=3D ctx->odb)
> > +				break;
> >
> > -		num_commits +=3D g->num_commits;
> > -		g =3D g->base_graph;
> > +			num_commits +=3D g->num_commits;
> > +			g =3D g->base_graph;
> >
> > -		ctx->num_commit_graphs_after--;
> > +			ctx->num_commit_graphs_after--;
> > +		}
> >  	}
> >
>

--8323328-1139355825-1580592337=:46--
