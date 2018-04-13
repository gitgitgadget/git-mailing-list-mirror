Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FACE1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 13:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeDMNEt (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 09:04:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:60331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751847AbeDMNEs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 09:04:48 -0400
Received: from [192.168.0.129] ([37.201.203.18]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeMOx-1epBAb2dzD-00QB5h; Fri, 13
 Apr 2018 15:04:26 +0200
Date:   Fri, 13 Apr 2018 15:03:21 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Kim Gybels <kgybels@infogroep.be>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] daemon: graceful shutdown of client connection
In-Reply-To: <20180412210757.7792-3-kgybels@infogroep.be>
Message-ID: <nycvar.QRO.7.76.6.1804131440100.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180412210757.7792-1-kgybels@infogroep.be> <20180412210757.7792-3-kgybels@infogroep.be>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iYhKw4z3A+3ZbwBTK369anutC0P0vPK6B4FLCwzknYeaqkN2NJR
 yUfVWn1ZzFkkFrGomFjauRjh2FW3X3Bb3aFFxSnC3k2jNyPPDZoTZaPatv/wiN0jDwOWth7
 CqbNIWntK+B26RyHYrdoCI+wyqhuHnednX0SURHvVkD+g2R/GaZMfYOHWY8D+c5ky8KSaLd
 aVlbDeaZzBYMHi7STM2fg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0eq4bwmtzXk=:PBuWEQ7upYcCbi9PRwfDJc
 38ffejljt2p+ondSdEdDvzln0H2aNnghph0S4QZZYR9nUz+jezVgkJR7iaul5qOlpJOk7kM8y
 bjvn/3udqty7oLota4HUssbFAO979wfXDpV/he9FgbuOfjE0HaHbBSX4WcIOQhmsasypi9ulL
 +lgOgd8fKv5vsxLINGiQ8SCxVsx0/a/sV/+3CLjEaCO8g75ppKN5rAUkoLizcuQWE6Ik/Vqpv
 inrilhxtDYoC0rgfEZUCPKSvvSylURW0jWw/8cSjnNPEacnGkZvFwq/lX0UwFK77mEHvpP+69
 wukAGH7LpvLxWX/BsjMcY2MewZkWnt3FGsuZYdILiAIs5R3WjDKoIhZ3MdpdjzDRABOVJHO4+
 35VU1f6gFpN3Dpt5TvEcCqVXkXwMyuB2aSRqWX6z/9zgS1kRHROZDKVkbBXlTaCndVb9Wp20m
 DpC1Zeb67n5al31wq6t1SW0j18qtrKtPa1Bibo2kH/qHXgLUEto6RI76/NwFPXVTMgCtV5mgT
 qOzolTLOGQArZEf44VXQPqcql5LD52N/4rKk3t3AuyViVk1a6jE+aJfJRLGiK52UcBkHUmSWl
 1ypTCtoSeanjBQA0o+aVoPx+f8bAYTvqew7mFfNAy7LiwIGOlxOMipxIHWxDwMEkZifyD6waS
 g9be1GujgYLiIpfgBdapmCjte2+5bZqw8NTea7mXWqD1R65n051Agg3bRTnxEBt+by+U73pyP
 vRiR9K+5Dbt1bxTr7KCA78UOBmnWl/0VpVigmlnG6THiFckR/ASD1JKE6JzN9oPLw0aONPw3J
 8oo0iKVcgVvT3KHFs9Zha7W5PguCL3HkibR44FwYW8yFgDSB1M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kim,

On Thu, 12 Apr 2018, Kim Gybels wrote:

> On Windows, a connection is shutdown when the last open handle to it is
> closed. When that last open handle is stdout of our child process, an
> abortive shutdown is triggered when said process exits. Ensure a
> graceful shutdown of the client connection by keeping an open handle
> until we detect our child process has finished. This allows all the data
> to be sent to the client, instead of being discarded.

Nice explanation!

> @@ -928,13 +931,13 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>  	}
>  
>  	cld.argv = cld_argv.argv;
> -	cld.in = incoming;
> +	cld.in = dup(incoming);

At first I was worried that somebody might want to remove this in the
future, but then I saw this line (which also calls dup()):

>  	cld.out = dup(incoming);
>  
>  	if (start_command(&cld))
>  		logerror("unable to fork");
>  	else
> -		add_child(&cld, addr, addrlen);
> +		add_child(&cld, addr, addrlen, incoming);
>  }
>  
>  static void child_handler(int signo)

Nice work!

I wonder whether you found a reliable way to trigger this? It would be
nice to have a regression test for this.

Ciao,
Dscho
