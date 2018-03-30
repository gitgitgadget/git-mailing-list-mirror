Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57FD1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 13:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeC3NQH (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 09:16:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:36425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751862AbeC3NQF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 09:16:05 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7m0a-1eg5g442am-00vP2f; Fri, 30
 Mar 2018 15:15:49 +0200
Date:   Fri, 30 Mar 2018 15:15:47 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 9/9] git_config_set: reuse empty sections
In-Reply-To: <20180329215038.GI2939@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1803301515110.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <29868fec2606f5f6aa1c5de2928580f2ca24e6e2.1522336130.git.johannes.schindelin@gmx.de> <20180329215038.GI2939@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:e9GSkE8qY6bNMtHSvTaoYzRIPsoQcM+c/0ymBP4fcxVf5XKNeuv
 o31u4OnMgS5bfqlE1irRJFWqfZAkzh8KMza5S/xLC6RZrzh0ETKPAF49vu6Iitzm/NLJ3iV
 2N3+geiG0JBUDwW9i1CxBImy5jHgQyzz5tgMEmT3lUv2jQ2XFiuiGB7qgQDr5RgawbZFxPJ
 8iaBr3Di+a5vpPiIS4ckg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OVO54mbRgCY=:zot1KNk5l82EvhDQH6zfKV
 ueCr9d3E3cFzgQdBW5moAjFCfOA8mcgaFXxCqOoCM1MTUj7n7At77wX6jnDLG7AUUVnR4VM3/
 lCfjgSzTJQW3rmU/60ORfKnJ3pSL08Gri/KJCoGeNFT8HQZEoXHAazKWkTipvyaMwRcCXzWVT
 CQJHL46YjKLs46n6v73VpBl305yUMXpkaAwuR1D0WQr2eXI9SKIbrJEgdIAcda/tB9NSV66c7
 /wAx3pRQ+j0mCDx00Ow264pG/Gel2ljEQrE1nat9ym/2ZFicH9sSu+sw0OO1l8l+FaA5lchHB
 XGIjBsE/SDg5rhOBAkJttJj6T+nMY+dcI6iIpOVIuaKkYMaIaevm5Iiw9jFSAqLGpiIg8WubY
 FjUFrHyo8hFWToHvwK59G8FHPEbcqhYxZrp0z40qc0qQPRyj+kZBWKhE2f9XQ4t/4ZG/2nBkw
 dgxZdh4pnBuxvVsx7pGFVHlVEgFfygmzkFcRU5hvDPa1Jv41KMSDEeGN0mQwLoDfCAyfbUn+I
 noTRM+gmzm2hbaLQtJQWgQY3+S5ArFgKWhPjX9txpOwo2ECJcKqHTuIuqSOC7DeCkY5u7uq9I
 vZmRpHahY4Vpth3AB9m1QXvVWLSHVQlGWD6D5Ie6Ot7CUDpqmcTVdnXxM3QYx+VDfXJceb01P
 1eeD4GAY0ELfyrp7TmD77h73G3Vs7Kypmzq0zM8Pf/ibkiiG8wcXvhWU3xwVYO3IRNRKfaBa/
 sREo7GVnLOP/zzrPPB3SIGTptyAhkcdUxvBP8Bn8qS4mO+91h6QWgebtkPiDyx3wtV/P+O4Zp
 OaUFDFtBA+VfTtwQvDKHMgZokIr93apRRidVjm73qiLjRbWtnF5yTJzpEBl8i7JGW5ICBu3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 29 Mar 2018, Jeff King wrote:

> On Thu, Mar 29, 2018 at 05:19:09PM +0200, Johannes Schindelin wrote:
> 
> > It can happen quite easily that the last setting in a config section is
> > removed, and to avoid confusion when there are comments in the config
> > about that section, we keep a lone section header, i.e. an empty
> > section.
> > 
> > The code to add new entries in the config tries to be cute by reusing
> > the parsing code that is used to retrieve config settings, but that
> > poses the problem that the latter use case does *not* care about empty
> > sections, therefore even the former user case won't see them.
> > 
> > Fix this by introducing a mode where the parser reports also empty
> > sections (with a trailing '.' as tell-tale), and then using that when
> > adding new config entries.
> 
> Heh, so it seems we are partway to the "event-stream" suggestion I made
> earlier. I agree this is the right way to approach this problem.
> 
> I wondered if we allow keys to end in ".", but it seems that we don't.
> 
> > diff --git a/config.c b/config.c
> > index eb1e0d335fc..b04c40f76bc 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -653,13 +653,15 @@ static int get_base_var(struct strbuf *name)
> >  	}
> >  }
> >  
> > -static int git_parse_source(config_fn_t fn, void *data)
> > +static int git_parse_source(config_fn_t fn, void *data,
> > +			    int include_section_headers)
> 
> We already have a "struct config_options", but we do a terrible job of
> passing it around (since it only impacts the include stuff right now,
> and that all gets handled at a very outer level).
> 
> Rather than plumb this one int through everywhere, should we add it to
> that struct and plumb the struct through?

Yesss!

Again, thank you so much for this really valuable review. This is even
better than what I hoped for.

Ciao,
Dscho
