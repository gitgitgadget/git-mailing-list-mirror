Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E1F1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeGIUYa (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:24:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:48045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932686AbeGIUY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:24:29 -0400
Received: from MININT-6BKU6QN ([89.204.155.168]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUkxk-1fbVgK3x2i-00YDrH; Mon, 09
 Jul 2018 22:24:25 +0200
Date:   Mon, 9 Jul 2018 22:24:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] sequencer: don't say BUG on bogus input
In-Reply-To: <20180709194912.GB7980@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1807092222300.75@tvgsbejvaqbjf.bet>
References: <20180709194636.GB9852@sigill.intra.peff.net> <20180709194912.GB7980@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DG/4r72102Q4b16yVIo8N7sBwmN9E5oRdzmW22k+0h9ntpdlHqT
 ckVCSFKoMpSSFlpkTgdlIX94XlXQNzF/neEmGou5NkCADi4N6M7ThyuGyNLA2A0Qmzwwc33
 7sOdD9pGTZKo+5YVn5C6mU2m5T31Ubtuc37IqCMZEbg9YZ8itu2tiiJv9aDRa9PHUhWEohQ
 2mTQLg/ZMCF8Pq8TNO6eA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5tW+afAwZRk=:0jAy4+xausTbnQ8U5igXEU
 ypgWtd2lcx+X9w+tEEBt2qvljP9UE5XnX/scpY8mN06yllNihxSuSCdFHW/UNmNu0kUlc0HSN
 evDcKZPHp79VB11+GAfzv6aXMm4G9h011GQwomtX17eYHy9XWAkMf00XBjHvx0Kvf2g3TIC2D
 JRejq+DzjiAo8gWYT9en+HTKW9v7BJLmmU40gqIrnvda4gpGneUUjPVm87XOGhMgRCUtXr3VS
 oFoYUHFT341IidLKJNOXPcVEAQosYBXLKD5YgsWpORZ0/MJQw+Er6cm4EFyEDFnQ78RV7PaW4
 631I2j9AHTArHUrx5atJGsi6TqEAkrROH91eGue1par+YOO7y9+X2rnP3dmE4GM71efZAIlZh
 bdDhzCPqWx67WGAqIoWrSS6gOszxLywYBpUJgF/APr7d+3X/FAJVFdCzqUYmVzjj8tJutCin9
 OZIDwNlOvGICqpIzeczVU4LxB4mUJ/qVVJO4EeV9RK3rpP49sATwy4iQ6KZohjUPv7PbQ4ue2
 jaQG59oVnoew6ne4f4JEsV3+8xFoLhO3x1fz+ucG/nSM0pL0bUIqha+gXSPMkq9a5KLQ2QMW7
 uatqrqKl2RsHuoo061RAD6zcgcS7FMiS3JFwsY7+RdjH6R4hYU4rXPPW0yNZLX2b8g8h6DaEH
 KELzQa8KR+qse3sQZB3sScwh3bhQku07/3e+9dzdBc5KsivccOul7lNnNjS4d3SGwhMBB6XyD
 M1KM/JaRZHwzTtOTbxMKj4unrkR4nymfAzScorOYn/AiwcL4IwKApwt0GrmbA3tVxGQcAi9iM
 zROLk4a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 9 Jul 2018, Jeff King wrote:

> diff --git a/sequencer.c b/sequencer.c
> index f692b2ef44..234666b980 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3637,7 +3637,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  			return error(_("revision walk setup failed"));
>  		cmit = get_revision(opts->revs);
>  		if (!cmit || get_revision(opts->revs))
> -			return error("BUG: expected exactly one commit from walk");
> +			return error(_("empty commit set passed"));

Should this not rather be

-		if (!cmit || get_revision(opts->revs))
-			return error("BUG: expected exactly one commit from walk");
+		if (!cmit)
+			return error(_("empty commit set passed"));
+		if (get_revision(opts->revs))
+			return error(_("unexpected extra commit from walk"));

Ciao,
Dscho
