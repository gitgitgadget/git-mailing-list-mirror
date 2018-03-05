Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C94DC1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 19:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeCETfK (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 14:35:10 -0500
Received: from mail-pl0-f47.google.com ([209.85.160.47]:34050 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeCETfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 14:35:09 -0500
Received: by mail-pl0-f47.google.com with SMTP id u13-v6so10277968plq.1
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 11:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mqrNUXiD3DPZTDqfM3Yw5AC3jtmNGt+8OCOXg/6+Syc=;
        b=chXkpaTKnenpBkZVNCMuNlMPJ8/qQJYxj53dqFsfP99y7SAWKetOzZstJJnDlk4y/X
         X3ABBxWnpm3FpmVA1qwV3HKfxERNkKGvKIDrUSHC6fyFLxb8t7a/BIw2PI2A1/DdG7sx
         uIMjLn1+AGYadgq0DlqLDnzTEWlA3QOVPKNVPJFHCLJlsmoibg7fU0695HbPb9qDHwAm
         hHHKa0RRBOhG0J+AVz8jQ64ZQGQctDDmp1UHz4SrCK3Js7/jkQAcyTvfJfyu+FwYpTDT
         /gC603w8imPWwWTb4irP8aFT8NloiyU6Zx/WeynUAN3YcA7VNCF3yDzwPsYOcl8AmsHP
         CUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mqrNUXiD3DPZTDqfM3Yw5AC3jtmNGt+8OCOXg/6+Syc=;
        b=coJS5wkhFisY8C808wCj0HXehmduldsXhT9ffDUq5jXSFMvGiTAL+r+Zn52hGQCww1
         sT9E+IprOKTa9x/8bwMXf5poCLorKFJb+8Z1XvNr4wMolHfjyzqRO8xK0X6BNaDXt3/k
         AfgJjSK7kT5RouDs0wmA7K2nec31JR9IQHTOntyVVJAsfT4DrohHbO9jdnQWgKMSDiig
         o3g3azj7DOah+h6gF1QBxcXQMUdK6PkzbcKTM8R9mfQWx60sjzIPUx0u8vsMmH+n4/Bp
         OioIdics+qOUq5A+pdSrUjYCUO3X6gK2nuT7O+Femxm7bhssxixoXz9Ire59CertLPd0
         /GTQ==
X-Gm-Message-State: APf1xPCCXZ+EAIgNVHiZ+wx1LPk3YUT/Uc01riSjuI2QGWxeaFQpxYQh
        NZR1ltrnAOtTrOdj4r7HBa8AUTPMAAU=
X-Google-Smtp-Source: AG47ELtShxAB79YfroCY5mzuZLct0B/v65DY3XkLgcd97MD+InI7uZIdvaRw2kb5m14oZLp92JMgIQ==
X-Received: by 2002:a17:902:9883:: with SMTP id s3-v6mr13830539plp.96.1520278508811;
        Mon, 05 Mar 2018 11:35:08 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id v186sm25622459pfb.5.2018.03.05.11.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 11:35:07 -0800 (PST)
Date:   Mon, 5 Mar 2018 11:35:06 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 34/35] remote-curl: implement stateless-connect command
Message-ID: <20180305193506.GB162172@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-35-bmwill@google.com>
 <nycvar.QRO.7.76.6.1803022106030.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1803022106030.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Wed, 28 Feb 2018, Brandon Williams wrote:
> 
> > diff --git a/remote-curl.c b/remote-curl.c
> > index 66a53f74b..3f882d766 100644
> > --- a/remote-curl.c
> > +++ b/remote-curl.c
> > @@ -188,7 +188,12 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
> > [...]
> > +static size_t proxy_in(char *buffer, size_t eltsize,
> > +		       size_t nmemb, void *userdata)
> > +{
> > +	size_t max;
> > +	struct proxy_state *p = userdata;
> > +	size_t avail = p->request_buffer.len - p->pos;
> > +
> > +
> > +	if (eltsize != 1)
> > +		BUG("curl read callback called with size = %zu != 1", eltsize);
> 
> The format specified %z is not actually portable. Please use PRIuMAX and
> cast to (uintmax_t) instead.
> 
> This breaks the Windows build of `pu` (before that, there was still a test
> failure that I did not have the time to chase down).

Oh sorry, Looks like Junio put a patch ontop in pu to fix this.  I'll
squash that fix into this patch.

Thanks for catching this.

> 
> Ciao,
> Dscho

-- 
Brandon Williams
