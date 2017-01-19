Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEFDF20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbdASVo2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:44:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:57252 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752446AbdASVo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:44:26 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRWzQ-1cwyG71qEy-00Sj46; Thu, 19
 Jan 2017 22:44:15 +0100
Date:   Thu, 19 Jan 2017 22:44:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH v2 2/2] Be more careful when determining whether a remote
 was configured
In-Reply-To: <20170119213100.g72ml7r2khu7bvey@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701192241430.3469@virtualbox>
References: <cover.1484687919.git.johannes.schindelin@gmx.de> <cover.1484860744.git.johannes.schindelin@gmx.de> <1605031b76025f4bd0e485705c34a25557bb75a1.1484860744.git.johannes.schindelin@gmx.de> <20170119213100.g72ml7r2khu7bvey@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4NkC4F2eNcguUTLxdY4oot4BHzw0a3mii7svTg3Qa4pcDg9M8c2
 mfBDv0pB3i43q9EDH4wcrSshLMbrDWr4owdDun/0st1QVjgavV6Vq3Gc0GgDdxCFrlE00TC
 20kEXh3XdX9tBog1r4WDBmbRpS7Oywe4LiRNfKr8l/WfaPwtWP3z+IRAIOPxTwfpJoQKwjF
 a6lIlbtZ9DIdHftgSwsVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xyCc+e+Gfpw=:7PiL/CZZyxBU9VdjjZlZ5W
 vWh8RPQHcdI9QTsaIXFCWpy34okpVrotwl+sn5L4pZKLa5GRm15j5PGKYd2nITk81w8EPAGDq
 IwofvzUxX6DLDDwM6qiYyKyQ0lR8xHJL1UkXt5jwQBTZqf2O93ZvxiHBwwPevTlZSXyHLoESx
 FOBF+Pk8VA/Z53GW8Pf0mdZPY+8YJZgORo4Yj7w1d/M1KUWjd1Ax2pegPRM3WgLTXPPjzEcld
 FPoKGP9JfuEDOAkrrkeFF5XmP2qXTB6LkNBkHGbeagRLtZt1aeMqoHDZqEA610+FPIOdFm7Eq
 Rb3yyOcuUhD5n2hAl7JtRGvLnABe2X3x92z6VqpySUrN03+afshD85iY/hlYt+GbuMDfpjYFf
 pn4+zHjiqYo2rKbSktGJuSCcEy2qjrl4PE05F+D/3+CxwXeRbVCWPmjCTbV1aVqnDhzE4znis
 OeVZnU5mblCeDKBpHwXTBE/mrOohgqc39e/Ua6m/tauH6CVygLDxd4yfPcZtMWYWeoD3pzaNX
 9jInExSMVZ4MRzke6PKwLJO/bwKN8f464XWRsYXVaGUwcGTFznUqzdPmF/KnriNJMutMHMkjH
 /NCOu4QXyp/fjHW2o4uXATIWA7UwT5/aUlX0+VFzy+W+VUXMSnL00HkjXj33It+oR9L+aU7Gx
 7tefdVjdFaAcyAoIPq3FdRXLYP4HG/itSLjnaVk6taUWTG6frysHYqvl+XbBoHPNWz5lNb5eq
 TOyr/Bt7VcvjvlmH41vT1ea16StALqzXMkeQSHhSvPEhRFDst3EqrwRSObZv6GkglS+Co26tc
 OF+RH/+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 19 Jan 2017, Jeff King wrote:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index c85f3471d..9024cfffa 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1014,9 +1014,9 @@ static int add_remote_or_group(const char *name, struct string_list *list)
>  	git_config(get_remote_group, &g);
>  	if (list->nr == prev_nr) {
>  		struct remote *remote;
> -		if (!remote_is_configured(name))
> -			return 0;
>  		remote = remote_get(name);
> +		if (!remote->fetch_refspec_nr)
> +			return 0;

Please note that it is legitimate to fetch from foreign vcs, in which case
the fetch refspecs may not be required (or even make sense).

> It's outside the scope of your patches, so I think we are OK to just
> ignore it. But if you want to pursue it, it avoids having to add the
> extra parameter to remote_is_configured().

Sure, it would avoid that. But that parameter makes semantic sense: some
callers may want to have all remotes, even those configured via the
command-line, and others really are only interested in knowing whether the
current repository config already has settings for a remote of the given
name.

> > Many thanks to Jeff King whose tireless review helped with settling for
> > nothing less than the current strategy.
> 
> Just how I wanted to be immortalized in git's commit history. ;)

You are welcome ;-)

Ciao,
Johannes
