Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349411F731
	for <e@80x24.org>; Fri,  9 Aug 2019 12:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406840AbfHIMnY (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 08:43:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43902 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406516AbfHIMnX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 08:43:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so23535425wru.10
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kJvTlPr0LR15TdinyndSAXKuCr7wKsFbYlxaFmZiRho=;
        b=mBwsq9wln//ncU5Vm4QBcbTlA+ZQOqyWL/GrNRQ6WKyX/xZ9W1BLVuPjiqCWO+yE6s
         nP6HhsHxVKaNdIK7s133q1RC2+GaZP9bAa+MFye2iwp2qqSysqNL3QkhwaDThIEeJqqh
         5tHd2hGiSUETgqTfaXT3FU29gN64QHMYii8eeECtfk65m2m/6JlvYCFgLkqQ4NPEiMpQ
         MHZUEAI1FN52mpcjoTCxtMfk8/oRiRcY3wHwMRHwM9Ll4zTHNt51auxfwNYJyyG/aDpL
         Z4Vnbc95wVNbjXgpCo2muuyVHRRbmCFz78EHA5bOIpjosNycSf5nS1V5P2/yqDPpjOql
         OhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kJvTlPr0LR15TdinyndSAXKuCr7wKsFbYlxaFmZiRho=;
        b=sib8MlWVJmNFJSOEAGioi3MztPBCjLgEWFrRdixSy1fTssGSPFXACorLecVDaPv+7s
         OhsEC/9C7gnCK6hGo9CsEg6DmJeR3gTb+mWQpNZRNdMtiaXXcxqSvR3AS7c4B9nJMMbm
         jtKf66GWiiAU3i4xJm52HjfcUwx+lGzzAFLfeOnvDWijctgA0Oj+zyl8o20fbGFjorUJ
         xmk6SlATTdhN+G+WF8/0suXs3kLel6u3BGR9cvoX5T6JieivCViPNVQrUMkY6MwPtzl7
         jLw93ACBOJDZnSOwFLrA3tgvPsoUggdjQ/rX97ScS0m9ic4t6xBOWREmNPm1Mr2oN7Ax
         wczA==
X-Gm-Message-State: APjAAAUsmpu9QuRlY+oCgK6HOxaTQHoyXZynhb4o7eG3PrPFIxtx0ePa
        boCmd6rbj1oj2kUFw256psc=
X-Google-Smtp-Source: APXvYqzh0usG2hUD0bAzbRVhGicgRRFkPACDfjUM9iJKF0MONlml4/7mrmYrQu/Pjmoj/0bFJDM6Jw==
X-Received: by 2002:adf:dd8e:: with SMTP id x14mr23450727wrl.344.1565354601551;
        Fri, 09 Aug 2019 05:43:21 -0700 (PDT)
Received: from szeder.dev (x4db31839.dyn.telefonica.de. [77.179.24.57])
        by smtp.gmail.com with ESMTPSA id w13sm18846518wre.44.2019.08.09.05.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 05:43:20 -0700 (PDT)
Date:   Fri, 9 Aug 2019 14:43:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Stefan Beller <stefanbeller@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: reload .gitattributes after patching it
Message-ID: <20190809124318.GJ20404@szeder.dev>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190809111452.GA93559@syl.local>
 <20190809112552.GM118825@genre.crustytoothpaste.net>
 <20190809113613.GA3957@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190809113613.GA3957@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 09, 2019 at 07:36:14AM -0400, Jeff King wrote:
> On Fri, Aug 09, 2019 at 11:25:52AM +0000, brian m. carlson wrote:
> 
> > > > +			if (!flush_attributes && patch->new_name) {
> > > > +				char *dummy = strip_path_suffix(patch->new_name, GITATTRIBUTES_FILE);
> > > 
> > > It's a shame that 'strip_path_suffix' doesn't take a 'char *out', and
> > > accept NULL for that (which would save us the assignment and subsequent
> > > 'free'). In either case, this is certainly the appropriate function.
> > 
> > Yeah, I felt the same way. We could refactor this out into two separate
> > functions, one which returns an ssize_t and one which actually
> > allocates, but I'm not sure it makes a huge amount of sense with just
> > one caller. The allocation is relatively small, and I've tried to make
> > sure it's called exactly once per patch so as not to be wasteful and
> > inefficient.
> 
> I think you could do this with:
> 
>   size_t len;
>   if (strip_suffix(patch->new_name, GITATTRIBUTES_FILE, &len) &&
>       len > 0 && is_dir_sep(patch->new_name[len-1]))
>           flush_attributes = 1;
> 
> Not sure if that is better or worse. It avoids the extra memory
> boilerplate, but the logic is a slightly more subtle.

Subtle indeed :) because you have to allow len == 0 to catch the
toplevel .gitattributes file.

But there is an other subtlety here: when I read the commit message
saying "patch that touches a path ending in ".gitattributes"." and saw
the new call to strip_path_suffix(), I immediately thought what would
happen with a file called 'foo.gitattributes'.  Only when I looked
into strip_path_suffix() became it clear that it only removes full
path components, so such a filename won't cause any trouble (though
perhaps the worst thing that could happen is that we unnecessarily
flush the attributes cache).

