Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C65E1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 18:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeB0SlO (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 13:41:14 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:39425 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeB0SlN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 13:41:13 -0500
Received: by mail-pf0-f174.google.com with SMTP id u5so1563328pfh.6
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 10:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DKqkUACpey8dfTJV7K+k+qY062q7x2VbmPgpKVEZ59Y=;
        b=essUTuPuEOWpJpp2erq41vsZjQ/n8JGaGQZ9wlBNTmT9d71HCllypTSK2RiO1ziuz+
         fe0dNUoMzVlWMyBosT20+Xk4gq0/IfJkzDgR8of3aUKwdt3ln/omPSlCqdmjCowQ+lMm
         3MQ1eVapOK3FpFVMXqOCI5vhtSmPX2cmjRemSLyx4fRxmOsjaFiwFbFLyLdPwiTcskuq
         76ud6j27rZ+hq3RoUDtP6jlJLd6owtFNZSyndu/ctlTM/fqevLMzxdyBQEszrIHPNLj9
         VgGjS+KNizBGL9Envc7zmQqD7xveXGjWCXYNZxxH4NTmjIuqNrHMufQGgybBtvw53mz+
         GHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DKqkUACpey8dfTJV7K+k+qY062q7x2VbmPgpKVEZ59Y=;
        b=UCj3Ql+LxLjUS7zBPhKjSD2x5gcZQ/8P9QMXEFQ95ec86K5+rE9t7Z9R/SXVKic9Nx
         O659ffaewp3vdxE9pBlhFTJPHDoUAQnBpD2fEWpITNNHVVjJSf3eAzjSdP4kx1PAUMJ5
         SvcbftHqVhY7fh7kzGfLaIlnMg5dk44cs6MAjPI9YFCJpnvC4gFYP4QaOmrzjn+2g889
         GI7pjHm/qLbRL3e2bUW/2gUMW4SPpM04krEIj0Ateyk+Gb6vV5KiAZcF0UR5BrzEKNCY
         Abz7mG9aHRfGacCfM10PlYMUaLQNrS1b+0SyQOFGShgI2CydjOrm1BB0CCQKxFaKa30l
         lb4g==
X-Gm-Message-State: APf1xPChWlTDZGjtkTxLCKAxueMkCpN1RRL8WHyv5grPbamLOzCDT+OU
        DHce7Rwl9O2S5W0IEi8yWNNMYL2My7o=
X-Google-Smtp-Source: AH8x227g6t8GizaSuqN13z53/9oGpGB5nu5OntnqX3MgbWphI4eP/6y6gyCljf+pLoBCejgKH6024w==
X-Received: by 10.98.89.156 with SMTP id k28mr14803623pfj.130.1519756872797;
        Tue, 27 Feb 2018 10:41:12 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id j14sm21477422pfn.113.2018.02.27.10.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 10:41:11 -0800 (PST)
Date:   Tue, 27 Feb 2018 10:41:10 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 10/35] protocol: introduce enum protocol_version value
 protocol_v2
Message-ID: <20180227184110.GE209668@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-11-bmwill@google.com>
 <20180227061813.GF65699@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227061813.GF65699@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/26, Jonathan Nieder wrote:
> Hi,
> 
> Brandon Williams wrote:
> 
> > Introduce protocol_v2, a new value for 'enum protocol_version'.
> > Subsequent patches will fill in the implementation of protocol_v2.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> 
> Yay!
> 
> [...]
> > +++ b/builtin/fetch-pack.c
> > @@ -201,6 +201,9 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
> >  			   PACKET_READ_GENTLE_ON_EOF);
> >  
> >  	switch (discover_version(&reader)) {
> > +	case protocol_v2:
> > +		die("support for protocol v2 not implemented yet");
> > +		break;
> 
> This code goes away in a later patch, so no need to do anything about
> this, but the 'break' is redundant after the 'die'.

I'll fix that.

> 
> [...]
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -1963,6 +1963,12 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
> >  		unpack_limit = receive_unpack_limit;
> >  
> >  	switch (determine_protocol_version_server()) {
> > +	case protocol_v2:
> > +		/*
> > +		 * push support for protocol v2 has not been implemented yet,
> > +		 * so ignore the request to use v2 and fallback to using v0.
> > +		 */
> > +		break;
> 
> As you mentioned in the cover letter, it's probably worth doing the
> same fallback on the client side (send-pack), too.
> 
> Otherwise when this client talks to a new-enough server, it would
> request protocol v2 and then get confused when the server responds
> with the protocol v2 it requested.

Some patches later on ensure this.

> 
> Thanks,
> Jonathan

-- 
Brandon Williams
