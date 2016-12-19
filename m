Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C681FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 17:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933540AbcLSROb (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 12:14:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:51513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755042AbcLSRO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 12:14:29 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWkZL-1c4XpW1G9L-00XwNd; Mon, 19
 Dec 2016 18:14:13 +0100
Date:   Mon, 19 Dec 2016 18:14:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 07/34] sequencer (rebase -i): add support for the
 'fixup' and 'squash' commands
In-Reply-To: <20161215190351.as76panrcz5rgibj@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1612191812520.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <ae521f75a105c6b9e54595d68bda3c5b62f313b6.1481642927.git.johannes.schindelin@gmx.de> <20161215190351.as76panrcz5rgibj@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8wJZb2P+C+1QzifMP92/WypEwOf0p72MDMBlg1H65t8WvNzp9LD
 c4plP7ShbmzG0YvoTRCfCq+sK1l/lNjWIghwGXwVluSXyGyETDT9B7GfKYuhF3XI4BxYt57
 QvgKaNr/4+5ZUR3d5ex0Q96ZQCrvMPUjdhQ8WUrQwRTk8GO2C/eNRXhLA85hcwQNeOF9MS3
 wFlj10J8PkNG557nTIzdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cGObcSU8G1g=:mdsZKP7sxEECuerljttYTJ
 F1i4aUtP2UWzG5nM0EIkpdNHi5Xgn4SuNiGKEgnHuQ7k8yJ22seukXaX+h8DTBUHMu9Z86yhj
 fWArvjIuILN2CoUtyy8aEAPK5g+RL+oar0wN+WT+aHhCTpGvqyEKE/17op9Rm9p2CkPB+yrIk
 JAYUiph/f0ztiUMNF/qZTk8Gp9XJxcx2v2u3Mf6dzCCXzeA+ycbm+g4BO08vZPzFVmU0O7T3q
 W582nOj/3mz1kW+h5eco1yHu1RzPQ/xvoVdgyBdX2ETBiDYQbnZJnMTsnoan5NyB7OWOlwJAj
 B5H5sKRd4ElES5c72PJijGb6LK2zMdmBqM1tM2f4WvjpYtbZtAbLvs/EfG7kA6T4aEBnZkMFP
 YVzsmIOSuwa+o/SFz4TH6jSaz6hiDj7viXDpdJZ8Ehj6fr8FERecoSn3qnLfMxVm5nOEKH4KV
 3t3CTyFPaePdF2FOxoLY6+aJIYzW/gIwfRxoX5YKn3Hxvd4biNaKIv3q5W0d7FjusSq27AeFW
 0rFKLWyrS9+DwZbpQf/02UzLV1n4aR+qWlZHVd5a5jWLgfPPjFCbG7m6Zs+DaMvyVBIjvfjNA
 h0sm/Pion7tcNRWqB7l6gC0+sKWp3z+M7FHrvF4pEOo6wKEUGKi3qQLH6DI9PQsR/4Ih69/SO
 B72WzDVc/ei4GaK0T9y95SSmBdzSvB+v69Jb/gJa+ncP352B0H8vd2M5SXjHiul0nck2DFA3J
 oOIZtX97OhJVKhQUrUHQJH92mTzmtNg8aQOxxGAGQQqgYQIb8Q+Zzy2crOnXFusrxQzr79FtX
 jfVQ/PF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 15 Dec 2016, Jeff King wrote:

> On Tue, Dec 13, 2016 at 04:30:01PM +0100, Johannes Schindelin wrote:
> 
> > +	else {
> > +		unsigned char head[20];
> > +		struct commit *head_commit;
> > +		const char *head_message, *body;
> > +
> > +		if (get_sha1("HEAD", head))
> > +			return error(_("need a HEAD to fixup"));
> > +		if (!(head_commit = lookup_commit_reference(head)))
> > +			return error(_("could not read HEAD"));
> > +		if (!(head_message = get_commit_buffer(head_commit, NULL)))
> > +			return error(_("could not read HEAD's commit message"));
> 
> This get_commit_buffer() may allocate a fresh buffer...
> 
> > +		body = strstr(head_message, "\n\n");
> > +		if (!body)
> > +			body = "";
> > +		else
> > +			body = skip_blank_lines(body + 2);
> > +		if (write_message(body, strlen(body),
> > +				  rebase_path_fixup_msg(), 0))
> > +			return error(_("cannot write '%s'"),
> > +				     rebase_path_fixup_msg());
> 
> ...and then this return leaks the result (the other code path hits
> unuse_commit_buffer(), and is fine).

Good point.

I found another leaked commit buffer in make_patch() and fixed it, too.

> This leak was noticed by Coverity. It has a _ton_ of false positives
> across the whole project, but it sends out a mail with new ones every
> few days, which is usually short enough that I can process it in 30
> seconds or so.

Yeah, I get these mails now, thanks to Stephan adding me in response to
some issues I introduced with the builtin difftool (and hence I did not
get the warnings when I introduced the problems with sequencer-i).

Ciao,
Dscho
