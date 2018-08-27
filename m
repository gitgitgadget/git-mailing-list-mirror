Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367AB1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 16:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeH0UMr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 16:12:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:54897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbeH0UMr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 16:12:47 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTMzb-1gKTse17ot-00SLhK; Mon, 27
 Aug 2018 18:25:27 +0200
Date:   Mon, 27 Aug 2018 18:25:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Gregory Oschwald <oschwald@gmail.com>, git@vger.kernel.org
Subject: Re: $GIT_DIR is no longer set when pre-commit hooks are called
In-Reply-To: <20180826004150.GA31168@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1808271824270.73@tvgsbejvaqbjf.bet>
References: <CAFKzd1qaMU=K6uc62xL0DUyZOWxY79Qakaog2dzBjiNrmq0ydg@mail.gmail.com> <20180826004150.GA31168@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CEZH4A3VelXuZ/lGCgfR8zR8AgYh5ruDrInqjgDfpDysHUfDHWh
 DXu9rpMaETYM8SSY9HVjYOn850TVckzGZye3IqEi6jANEuAlDb81zQXYYSIVphhziVDW7OI
 OezX3CjFq377pKUwPj8Tl3bUAYbm5zjcPaZLMXLOq8rhFREvSA7Gd2M2yOftEtu4J45VyYv
 xlOPu6mR0St5il/JtEOpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4qP+0OPmkO4=:lEA0lv1qhQjkMoWeF9eSQd
 26LBodlczDK4/ctOG1WDurZKZlmXbQXvfHWvKs8bu3EcmmvZaDakl+faeSwU+7gp5nrDCytkv
 82mntmIAaa6/bq6mtBkacaJ7yyfThrIO38qdDRYbVyakTsCsBi8qPke0qUL4Mdm0LgHEFGj7v
 bePcPd9AtiIAVZFFKu32cjOsBaV0D+gTssp+X29ttVBxYiQzjMoY3BKCMvIIXST/3SL7AxTbo
 bykb0eYMP3hoUEmFD73feuMY1u2Z8DptEIHF6RHqIurXmEN9bPSmv4Qkt2nIzn87010SN0IPN
 qGiz/ddRv6KErBGQKsk6tNHU4m6KGd90DdVi8+SKayIaeDiZzJMuatw8lZ3ybbOLT0i50E9S3
 YuF/64NLygmQ8UBqpN7CkQkTNAVlZJC3o9aA1bjvQRl+paEazFamDuCA6qlpWz8f7nLn8MQzN
 6ut7myNrEo3c7gIHG4Eu4LjUj+F4nWBkndW/fHNnq25jFMZla60pMB0HSYAV8mt6P8DpTB1Q5
 ekooeYOQcgAb9yCQ+cZb5aYsgzgsHx9/Pq1wh8WGxgoEJcLmHlSAeKBkwnNDsTWt4CCG4sWN8
 BOw7XAy7+VAB7vnJfuGUhwn8B5tBLAB1go1yQtZZWKPEARxYPOQiaH66vqrjEpVZ2m4tPD8Ds
 zokhtdtwNhfLBFQcChQILTvwUX0epLmVswLPusmKW2MlKjXW9x0W1D7RowarBL9XufQ6d11Es
 wGbzKPsBN+viXj5eyA9mpT73ZTXoFLQKDCgyRGf2rG73aBii9DWCOWGmG/WB7yEoSArgJ7K4K
 DYR1luC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 25 Aug 2018, Jeff King wrote:

> On Wed, Aug 22, 2018 at 04:16:00PM -0700, Gregory Oschwald wrote:
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 3bfeabc463..3670024a25 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1440,6 +1440,7 @@ int run_commit_hook(int editor_is_used, const char *index_file, const char *name
>  	int ret;
>  
>  	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
> +	argv_array_pushf(&hook_env, "GIT_DIR=%s", get_git_dir());

We did something similar in sequencer.c, and it required setting
`GIT_WORK_TREE`, too, to avoid problems in worktrees. Do you need the same
here, too?

Ciao,
Dscho

>  	/*
>  	 * Let the hook know that no editor will be launched.
> 
> -Peff
> 
