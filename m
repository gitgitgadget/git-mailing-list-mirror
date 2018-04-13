Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFD31F404
	for <e@80x24.org>; Fri, 13 Apr 2018 12:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754176AbeDMMhl (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 08:37:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:39217 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751024AbeDMMhk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 08:37:40 -0400
Received: from [192.168.0.129] ([37.201.203.18]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Leux5-1eg96R3Mtj-00qm58; Fri, 13
 Apr 2018 14:37:16 +0200
Date:   Fri, 13 Apr 2018 14:36:16 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Kim Gybels <kgybels@infogroep.be>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: use timeout for uninterruptible poll
In-Reply-To: <20180412210757.7792-2-kgybels@infogroep.be>
Message-ID: <nycvar.QRO.7.76.6.1804131433250.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180412210757.7792-1-kgybels@infogroep.be> <20180412210757.7792-2-kgybels@infogroep.be>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mhVQ/AQMghW8+IIy3GlBT5gx2NGy4DN4kKbsvMUtBXAMZbuyJpn
 XESl30usHRIMkgd7ZkwY/pLiJil4vQ8AU97XNq/pq9j7e+Lm2/XELr+juiYb4h2mikWZbeF
 jUCDqOz6gjZzb0Ne/ueVTE5YbzYNoa3wNKPvgPD5qXntJWPOumB9fA9H3LiKAUwwd38ixxj
 Qm5arf+fcNJUjkeFS56Bw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HIbLFnSkQKg=:YFOOQHKhE1g470cJqZWnOK
 ZvpmJp10mY2b5UxtLGchZhnjaf0ZySUyy5NQHaVIFpcRzhLcI0S238NgwVz66nxz1cTUFVmaa
 mOELQM4hvPy3ppPqr295k3xT/avBWy3eYngI5YrDPXD/YY2K+XOOWwolrQSsvmxTprquLKfdt
 b8Ntg9DX2Kg3YRg9/Uvpl4tPZSRii56iAy3S4NZIsYg9mL71IFXa8rbsDTEhjde7RtUAc7rF+
 XSMQ56Uy3H1bnvKT5a4pzlqWBhrzOTDVyFCEEkfvuYbA++GHHHSDY6XDSFUXVPaA8Vaas1sve
 pM8FN/Z1buwz1S3lfvYaLOtkxra4+iCe/J81rPcMqqE0ZA1mc352jEWQ3HXUWepX9kaiMSSu0
 dQk+AvqT2uCqYjhqQwfvPFTaRlrUE8kuD6hL+bAwQJDaPz5v9RmjjObQghSNW2O/gTba7spE7
 5e498ao3vs+nLSZbz6HSrMK57SISvwN4Hbe8lu+oqhP3seWfu9ZlXPuKNCmDOf4ijDUvwSW2V
 +Bqbj0ZJ2zS6hehqcpMQNmtt/rXCAFvX69ds5feMA8uNmKbEr5bhLhKHarFTO9mr52V+aPKl6
 RBSdC2clJYUEl0WFyrLM/JC7Qncrlnrr7JXVZv++QcErvHUBfojwUcUo7nBbUkOAhymx377u7
 jcHVV24d05yZfnVFfq4Fw48/jMgb1hRw42uQjgIlN8nXQ5BZZn77yPFqmLrXHhgWLy3LN+Arw
 aCAzyRHlaLFu+8LJDv7byd2EzZEOarRZitOpLXDQglynFabm1C9so6vWsMOwDb7vmgSGTD/Oc
 F8d1SDrB67qEIXfnCrUmMp9Ut92ctK/nrKN8Pv5ZLYdz2lE1mA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kim,

On Thu, 12 Apr 2018, Kim Gybels wrote:

> The poll provided in compat/poll.c is not interrupted by receiving
> SIGCHLD. Use a timeout for cleaning up dead children in a timely manner.

Maybe say "When using this poll emulation, use a timeout ..."?

> diff --git a/daemon.c b/daemon.c
> index fe833ea7de..6dc95c1b2f 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1147,6 +1147,7 @@ static int service_loop(struct socketlist *socklist)
>  {
>  	struct pollfd *pfd;
>  	int i;
> +	int poll_timeout = -1;

Just reuse the line above:

	int poll_timeout = -1, i;

> @@ -1161,8 +1162,13 @@ static int service_loop(struct socketlist *socklist)
>  		int i;
>  
>  		check_dead_children();
> -
> -		if (poll(pfd, socklist->nr, -1) < 0) {
> +#ifdef NO_POLL
> +		poll_timeout = live_children ? 100 : -1;
> +#endif
> +		int ret = poll(pfd, socklist->nr, poll_timeout);
> +		if  (ret == 0) {
> +			continue;
> +		} else if (ret < 0) {

I would find it a bit easier on the eyes if this did not use curlies, and
dropped the unnecessary `else` (`continue` will take care of that):

		if (!ret)
			continue;
		if (ret < 0)
			[...]

Thank you for working on this!

Ciao,
Dscho
