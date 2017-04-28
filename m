Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5831FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 10:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422936AbdD1KpH (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 06:45:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:50799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422839AbdD1KpF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 06:45:05 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFPyK-1dIMjK15HA-00ELqn; Fri, 28
 Apr 2017 12:44:54 +0200
Date:   Fri, 28 Apr 2017 12:44:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/26] Check for EOF while parsing mails
In-Reply-To: <20170427062114.p367j6rojnw4aj5r@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1704281241260.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de> <20170427062114.p367j6rojnw4aj5r@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uCeo427mjJk9HK5X3A+zgUYaAH8Ce82xnQez8a1LhRuHDdOqJaU
 YZbblVQGauDj3dQ3sKBwzjpC1hRkDjantMELXgVpAyflmJ9olZLLozNvtkBQQTkhd9F7Jn0
 kskDZVT70rGuJ2/0pGgQG8kqATJlJJl+7tDDcL/UO97110+LikLrZ7CoIh1WMkHPH6PNad8
 GuAYsvPG+FkfVejs3f61w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cyo1u21kDGY=:Ufk9Ua1rkXLJxlwDAejctv
 +BJKncltwCHcgUiAOvutPr12V68gtPYw/VyOX4aFYhQca50QexW/3PQXU7VnaoOL9ka8cTwla
 ih9jEzFXQkoxNf9k8Av/OAYXz5l5E0VA9dj9AQ9iv6KoulkIJKco2cdtWwHSm4RF+92zsB910
 0qsakJSImP4EKkgVQWZFJI+8YjyPCfkMKxsT2cEdUJM3gojwqBwf28diew3ohmJHoRboxI7ez
 dGLXfhqxedIG3IwRsxDmhRlnP3Hagz+RdBdEzImko3PEX0K02CWdm3e27Eil2ZZ5WTn2l8LA0
 aGXRfgNvAVlKv4XHC/lU1rOYe1RwTJJIBRsiINnQBgZP7Xx9Nv3RO2zItyKAubyTLd8UEWsRo
 0TTaDnJd/JuISHy4tqqhT1qsEncj68vuxvLQeo8grntcasJgNc+U9xaj9DJh+0Q/1K9GD1MbW
 ZQElJZjCIYO7hc5TOAd9dRELUknT09OEnUIQ7XieqpZQQccqyJ6atdoCgEKZhgG0wBTerCW3t
 6vyp4EAknLql6oD5b2P7Fxyw8HppXMMx+wUWmax50omrZmdml+//RyJJBkIj60q2ArDnI1fuA
 8bYJvclMSgMMLcX8pheSUf3e5NHHnvVses/2QpnYJaN4ie4ANONesARNVOJOj5HlT4QsMNgeJ
 ueFrSdGx583IsyLiNc3UCfVjQr0blFmI6QlhLK01KyywOYGQ8LfmEjQ24urO51IenUR2Thr5Y
 tfal9tzvpgwFfvXOqyf3ENSfPnac/Vqrw/Ghxyzyxgri2fJKTkQExLxfmr2ec6BBKr/iLeWwS
 /yRtFfj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 27 Apr 2017, Jeff King wrote:

> On Wed, Apr 26, 2017 at 10:20:16PM +0200, Johannes Schindelin wrote:
> 
> > diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> > index 30681681c13..c0d88f97512 100644
> > --- a/builtin/mailsplit.c
> > +++ b/builtin/mailsplit.c
> > @@ -232,7 +232,7 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
> >  
> >  	do {
> >  		peek = fgetc(f);
> > -	} while (isspace(peek));
> > +	} while (peek >= 0 && isspace(peek));
> >  	ungetc(peek, f);
> 
> Are we guaranteed that EOF is a negative number?

No, you're right.

> Also, what is the behavior of ungetc when we pass it EOF?

According to the documentation, it would cast EOF to an unsigned char and
push that back. Definitely incorrect.

> It looks like POSIX does what we want (pushing EOF is a noop, and the
> stream retains its feof() status), but I don't know if there are other
> implementations to worry about.

That's not what my man page here says:

	ungetc()  pushes  c  back to stream, cast to unsigned char, where
	it is available for subsequent read operations.  Pushed-back
	characters will be returned in reverse order; only one pushback is
	guaranteed.

> Perhaps:
> 
>   /* soak up whitespace */
>   while ((peek = fgetc(f)) != EOF) {
> 	if (!isspace(peek)) {
> 		ungetc(peek, f);
> 		break;
> 	}
>   }
> 
> would be more portable.

True. I changed it slightly differently, please see my reply to Hannes.

Thanks,
Dscho
