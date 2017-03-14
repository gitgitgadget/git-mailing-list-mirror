Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6B920951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbdCNW2i (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:28:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:61307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbdCNW2i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:28:38 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkOaJ-1cDTJS1kSJ-00cP5m; Tue, 14
 Mar 2017 23:28:25 +0100
Date:   Tue, 14 Mar 2017 23:28:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, pclouds@gmail.com
Subject: Re: [PATCH v2 2/4] setup: allow for prefix to be passed to git
 commands
In-Reply-To: <20170314221100.24856-3-bmwill@google.com>
Message-ID: <alpine.DEB.2.20.1703142326460.3767@virtualbox>
References: <20170224235100.52627-1-bmwill@google.com> <20170314221100.24856-1-bmwill@google.com> <20170314221100.24856-3-bmwill@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6rATI7U3bP6qq7fFT0jCWMR6ndMP3KlIhp4b3FSLBOyrJpBpfij
 fH2G9H4g0RM+zMU8rFrxzuAiCmxxt2EVklpFjPYUyuzS5u8omvCdOzDvY0ryrHFzhtiQY9d
 G3OHpxd4NRfiNnb/KI0nGkWKO7GXBYXQqG5zQXmxjvZsXuMawnnLI/lcislUcGDg4xKB2yI
 1Nv7WJIaq/JF1ExyJ6Cng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bK4hf9iDXAE=:0Va/47b0uwR7lTmtj3Ymx7
 63FwWovh0Ft03HMy6/pHTKaEwbsVDyZhZlUkD8VF1CZWrifpx/iCWCFTS45GoJ3FctJwdksMz
 hxOc9DKl4MzQIkeZWAiboXHZfz5HwzeZkDL/yq48qU/fMN15iuowwqFYHu94oOsf5M9+cwPAE
 grQR8f9WISJbYGPHeO25/FE4lHLvY06U4oVGAmGZB4EE+JtqI0KfmVViAd7uTvRz3BF9oBJN0
 YT9OBdYEuhNHvfcQg0yFlt35Ow4g9m3vblNfYVI2VNBNwKpF4L3C8Opp0rooJO2Up/Z26I75J
 oI9BqK6Vz7C5HsDIK9q9EhzazuNGHWU48U9395Etz3reSnlOF+q03M90gvGmzpLz/o+hZXVgH
 7D1qpeWqXwUrpQO90hbUhwaAM8mrNxrRNO2OBl6Sl++/NWuNd0qiSqNhjmnxSroLFkKWPdqGE
 Ko7bmZ+jNvc5jnUE/dpj1Y4m3U4KZ+JAdGA2QK2EDK9FKzfJULKVeCKkB/YYNp2t+QKi2riD6
 kjewYxLsYSO5qMnR5m92tc29XcuWglO2yzSYX9w1xHlGAW7hZrhHPXGyYv1x4o++7zPeYSMXP
 +VaoamFWOwxRoM2O86LwXEAjxKhQtWUpWNjYp/zufS28JZCceMzXWYp6grdPXD3mYxcPSaM+n
 Kvb4QFpHFtmkBGvhaJ6pEqe7pmY4XDCtwWkDPDytzx60fSJL4P4FcyqRNxy8qVBSXF03BOIcp
 U7FlBA21kJOIcQTtXQev4Wv05lMCIA1NXyA8CwAooBZJA9vo0xuCDHps6JALk51r3InB6v2+P
 TWjwJI1vcrXZixjUIVUtQY1IRcThw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Tue, 14 Mar 2017, Brandon Williams wrote:

> In a future patch child processes which act on submodules need a little
> more context about the original command that was invoked.  This patch
> teaches git to use the prefix stored in `GIT_INTERNAL_TOPLEVEL_PREFIX`
> if another prefix wasn't found during the git directory setup process.

Missing SOB ;-)

> diff --git a/setup.c b/setup.c
> index 8f64fbdfb..c8492ea8a 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -940,8 +940,14 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
>  const char *setup_git_directory_gently(int *nongit_ok)
>  {
>  	const char *prefix;
> +	const char *env_prefix;

I'd just append this to the previous line (`const char *prefix,
*env_prefix`).

>  	prefix = setup_git_directory_gently_1(nongit_ok);
> +	env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
> +
> +	if (env_prefix)
> +		prefix = env_prefix;

The commit message claims that env_prefix is used if no other prefix was
found, but this code ignores any prefix if the environment variable was
set.

Which version is correct?

Ciao,
Johannes
