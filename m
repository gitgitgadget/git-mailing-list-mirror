Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A25020282
	for <e@80x24.org>; Tue, 13 Jun 2017 11:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbdFMLV5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 07:21:57 -0400
Received: from mout.gmx.net ([212.227.15.18]:64785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752211AbdFMLV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 07:21:56 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MI4yc-1dGsnk0AWc-003vmt; Tue, 13
 Jun 2017 13:21:30 +0200
Date:   Tue, 13 Jun 2017 13:21:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] alias_lookup(): optionally return top-level
 directory
In-Reply-To: <20170610101813.n26wmxcueicecptz@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1706131319130.171564@virtualbox>
References: <cover.1496951503.git.johannes.schindelin@gmx.de> <aa6601bbfa50c728b7820e0a2991da76288509a5.1496951503.git.johannes.schindelin@gmx.de> <20170610101813.n26wmxcueicecptz@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/ZPYlLiJMofWuC6UJG2K92Pciz6vStmKi4+aMTXQP3dpDEtoOHg
 r1LSXuptfpX40/Mt6+Q1mUXQuS0jbu/X/ngYTDxuIB3I23SsZloiFA5UwWgLzrjPCXRsuqZ
 UKOTigWzMxBzt4zQqQHtgix9auNU/HeTn6v1YKjIVKOfPrz8+SdeIIBJDyHYvhOO54atCPy
 HkNuSoeXQ2XX7+mNWfGbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F4PzzTKOK/U=:IeL3rxFZ76bET3cZi5NOzB
 1nGWam9eqCGbSd1UtbSpI77yjnsGipwqR9+UxN5X+9UZIVbeqIRWSRNCYSUXVzZUsDxsZzBUQ
 Lxi0Fp3gxzFEDAUgjn9okt7OefoXPA4xT0fowNfYK8D1JSzrp5x5E/p5rBhBWkWe9sF4GRrHP
 oGS+qAoJt9ZVNCETDGHzypv/h9tBDPoaliK2aqTUYwBrhA8tvLEAWgEvP9DZIt3Oi3D7pijHp
 0h6SPfkFkotUWHQdZMMzmStbNgo8dGnvPnD0dvVqBJyJ9M8qlwydtyV95p8RMabZjOJlMcR3H
 zrNt5W5DE1O+5f0BBb4ItP+svVpl+23wK3uMWl7zOStFI70gv3+1MMG52JxtIVIEM0DRjFchH
 ldAFVMe0eVF8MFLcEQWtut0MNkJDHecdoJiV681Z2nlGxX3OdBskBED2nXGaGBMREKU94s0lX
 7Iir5nhhL4ThR9G5sJevSxa2yNSGoy6u8sMgAvt2um2CC/yRzpAUgAWn4lVFp0Xq2sQe7tguA
 3GZXrEgDwUbx129W1jHkauFS17CkmFzKSzvUT1ghyLfynSr9uuhsO/goo0tmVRv7x9BLdB/XQ
 m1GMgaHlvKLHto9yQDQJbsGPZ+On+l0Wk+ZAEVUOwhyty09TrNCjCqTYXxYWKVppfwOgH5QQJ
 00S5+OXH+L9HX3xUZslh+9EWznNNZbWnLl3Xbwpi+Y0PvZlKvelH2bTAtO536xBGhZSyxPd74
 imhBXYjOarnOtCDGloH/ULUzO86CK3Gj6ijRBE2kAwyJVxAWCi4z6w3x/mDqit/kEQ/JmcuxY
 EsJvIVF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 10 Jun 2017, Jeff King wrote:

> On Thu, Jun 08, 2017 at 09:53:50PM +0200, Johannes Schindelin wrote:
> 
> > -char *alias_lookup(const char *alias)
> > [...]
> >  {
> > -	char *v = NULL;
> > -	struct strbuf key = STRBUF_INIT;
> > -	strbuf_addf(&key, "alias.%s", alias);
> > -	if (git_config_key_is_valid(key.buf))
> > -		git_config_get_string(key.buf, &v);
> > -	strbuf_release(&key);
> > -	return v;
> > +	struct strbuf key;
> > +	char *v;
> > +};
> > [...]
> > +char *alias_lookup(const char *alias, struct strbuf *cdup_dir)
> > +{
> > +	struct config_alias_data data = { STRBUF_INIT, NULL };
> > +
> > +	strbuf_addf(&data.key, "alias.%s", alias);
> > +	if (git_config_key_is_valid(data.key.buf))
> > +		read_early_config(config_alias_cb, &data, cdup_dir);
> > +	strbuf_release(&data.key);
> > +
> > +	return data.v;
> >  }
> 
> Two optional cleanups here:
> 
>   1. We don't need to call config_key_is_valid when using a callback. We
>      only needed that to prevent the configset machinery from issuing a
>      warning. It does save us reading the config entirely when the
>      program name is syntactically invalid as an alias, but that's a
>      pretty rare case.

It may be a pretty rare case, or it may not be. I do not want to think
hard about this, so I just wanted to keep that test.

But since you suggested it, I will simply blame all the fallout (if any)
on you.

;-)

>   2. Now that we're not using the configset machinery, we don't need to
>      have the alias name as a full string. Instead of using the strbuf,
>      we could just pass the "alias" string itself and do:
> 
>        if (skip_prefix(var, "alias.", &key) && !strcmp(key, data->key))
> 
>      in the callback.

As you probably guessed, I had tried that first and then figured that if
I needed to keep the config_key_is_valid() test anyway, I could just as
well keep the strbuf around for later use.

Will change the code,
Dscho
