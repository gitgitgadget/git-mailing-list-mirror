Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFCDE20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbdASV0T (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:26:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:64951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbdASV0S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:26:18 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcSWg-1c5g0r2irm-00jsVE; Thu, 19
 Jan 2017 22:19:15 +0100
Date:   Thu, 19 Jan 2017 22:19:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH 2/2] Be more careful when determining whether a remote
 was configured
In-Reply-To: <20170119182721.7y2zzrbaalfqjjn6@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701192217090.3469@virtualbox>
References: <cover.1484687919.git.johannes.schindelin@gmx.de> <41c347f22c80e96c54db34baa739b6e37e268b61.1484687919.git.johannes.schindelin@gmx.de> <20170117214723.p5rni6wwggei366j@sigill.intra.peff.net> <alpine.DEB.2.20.1701181334040.3469@virtualbox>
 <20170118125422.gi3ppqiqhyykk7iy@sigill.intra.peff.net> <alpine.DEB.2.20.1701181700020.3469@virtualbox> <20170119182721.7y2zzrbaalfqjjn6@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:65IbcmmY/8vM+AEQL6TD/Pq9cBGLKRWF+0xwyJ/Xr86yN1gDxVt
 GdvFCpWMeZiEPgtfaZcLC4sImJpJuAE7Om7unRlSIu2q5fs9A2E3bQ27tEuXssrUkLtHvr1
 nCqCxI+AOqJppURZSZHGqZqfvpo4XGqSVPctu71lI3LegkoUklTUh1JB0DxY/b5kEk69Gmq
 32k1jUPWFNYnf0h59cx3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YkEZgoglzZ0=:i06wTwoB4SYbJIkAyIUnhT
 ZS2H4psilrpBZbwVPOorfmDGsY5m5WNMBJ/48yAwvX+5s6MPy2Ev88V43kM2n0njJMFW7eE4W
 CN6Z18sZOl/32XDlVqkAbPH+lB8GwksZ8YHNjGX7hGpqmVhsm1SQf8sslofAYT8tx2Kmh6pGO
 bGlf+mTABL8yQuE6RWDS6H6jk/2non35bD5m+p5KEBLinmuhrnO9hU+7bzoDmlHms4V9YxWRV
 0j6Qg2A9Fl6+w6SKRUq23eh85dcebI78nEzefzNFWJxdgOhKNeO633N7j2iWeL/Mtt4vOaRIV
 mGKKJtCF75t/kShIIkXYigDEuzBlZYPRDCLV3brRpXirtuDdt8HGpV2SaEJZloqPI9INM9nmG
 Kuhcfuc6Sve0gFKow7Ki9VvuUQ34BugblrinXBfruGYEzPb/nKCSUpzYs5ziHwunYzvhcc97R
 /5VhQ4JGXjaJCrfwWMsngLTn3w0PemoEZYJBuzIeJxSFoWpESloeMSN6O1qPcMEgKQQt0X2lQ
 UQW2KCInSNOB3MCoaERVTLM7JvD974zGoiF1gGN+N/qJtlmcMnf7gYmBzG1l3bxH9TtIBDtBk
 xG7uRhRMaRBlPKnjzgAnnpgu5gyDfs9g96rZxuAX1WEz175hT9Zd7EkanPozxx1F03BZ5WMTE
 GLocwzqCyAMgv467Lsbajdvp2BKsPuk+maR008LwWwX7+sVKvopLXs3BT9E9momo/8/ud4xGz
 WHjSRzoPJLsZcGDcgfATiW/dPqI3XzPBxCxJyySY5w6JtvXP++0hp+85KdOpbpcQi3gJt8ZfG
 4U8L59ITrjPxBw1Eyz+kIdWKPoq56Zfx6SIPE3OFIlgt/GMMbbSQ/6cmwGMnC+DkyCQQ4lsjc
 HeJLZvBfYAjTrPR2aZvplhonTLbNUrqsfXsAkEy3h5nrjjJ3A9XSNHIZpU0MIgeSHnpQgsJ+O
 /FdTecPNaiqauAM2cG3rndM8Xq6v1xM5AjT/xAwvg0/dj0pB/fKoD4DonVFoYonz5ietsYK1c
 nqsNqYri+y6vCo2W5zK/fGI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 19 Jan 2017, Jeff King wrote:

> diff --git a/remote.c b/remote.c
> index 298f2f93f..720d616be 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -373,6 +373,8 @@ static int handle_config(const char *key, const char *value, void *cb)
>  	}
>  	remote = make_remote(name, namelen);
>  	remote->origin = REMOTE_CONFIG;
> +	if (current_config_scope() == CONFIG_SCOPE_REPO)
> +		remote->configured = 1;
>  	if (!strcmp(subkey, "mirror"))
>  		remote->mirror = git_config_bool(key, value);
>  	else if (!strcmp(subkey, "skipdefaultupdate"))
> 
> That doesn't make your test pass, but I think that is only because your
> test is not covering the interesting case (it puts the new config in the
> repo config, not in ~/.gitconfig).
> 
> What do you think?

Heh. After skimming the first three paragraphs of your mail, I had a
similar idea and implemented it. It works great!

v2 coming right up,
Johannes
