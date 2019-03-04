Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C49E20248
	for <e@80x24.org>; Mon,  4 Mar 2019 22:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCDW0C (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 17:26:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46324 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfCDW0C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 17:26:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id c17so1384687plz.13
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 14:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zUFnqan7nTZtXo+w8gwHkafwMXgpTYk0vbX2GfFQk5E=;
        b=DMNM1/ycozAsCovr5mgSy7ACzj0ezTMHzgWBCV11nQd2XLTQDkoJeTs3oUTu2yGbet
         hquw7jYm6gRtbqygFR3Ol51AkWPeQ0qLE2YleQKf1YEBElX9P/npqkd59d7t55LGkIL5
         i2ME/CuiAitG8ZZ/fMxN9DRi7Jwt9N+kly4DZXMEJHQMEcj3e2xjHhcfuSatNlY2Ma5j
         hPGfGaEnTbktYcMXBWwl5WtseY6NM6CjUe3p79i6JhmDx5QVJ0qmgcXcAQX7GYJv33J5
         KxbXDswR2bGaGnOwVanhfik2RnfvLFklVT/O5psvSr+sP9dt4wuZ3GST9OZGXKNqcTYv
         vTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zUFnqan7nTZtXo+w8gwHkafwMXgpTYk0vbX2GfFQk5E=;
        b=hSa+BeoiGtuhN9zkhHOUZnR/xu1QVJhB/KiWPjaimUoslyzc1qLD+iC2elJk4raDwf
         ouZQ1Jxtc0fwEcOnOZeXDmfIvlFi/R2nXyX30PgBFhbb0KM4AIlorSHj9awfwFODYguD
         wnZvNQWHebPECdG7H1jqIv5heX6CLB1g9QUouPP6aOn1oJDxff5XRAU1Q20jgh9wv/IN
         T4m4aDXINfChskYRHs4FFeeN4+fPEIdKFrE1CIOxWhFMKjL2ZpHjNB3LuHF1dNM+WgnP
         z1GEnKh9X72cIX38qZ53A6DM32gOU+qN/zV9ovXJBmhzfpYhmW2tCil1NJhgAqbwRHeK
         TH/A==
X-Gm-Message-State: APjAAAU50TR3hkQbarxNs0qOh9VqCBkoOy9GZG3R2/8q0+CKJSacnjZd
        K+sCusMAhlzBzo0k+LKJbMbmHygi
X-Google-Smtp-Source: APXvYqzsS50wO//xW7q9hzjG0ehZKG18PQh+1NwtIZMzyI8f2xZ0tmysGCFv4mKL6TFeuLeSLKFKEA==
X-Received: by 2002:a17:902:12e:: with SMTP id 43mr22789849plb.31.1551738361402;
        Mon, 04 Mar 2019 14:26:01 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id c2sm9167349pfd.159.2019.03.04.14.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 14:26:00 -0800 (PST)
Date:   Mon, 4 Mar 2019 14:25:59 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        asymptosis <asymptosis@posteo.net>, Jeff King <peff@peff.net>
Subject: Re: Can't build first git commit
Message-ID: <20190304222559.GA112305@google.com>
References: <1551729517.4092.1.camel@libero.it>
 <20190304201011.j7dopqp6ug66ccum@LykOS.localdomain>
 <1551730792.4573.1.camel@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551730792.4573.1.camel@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Fabio Aiuto wrote:

> What a pity, It would have been very useful for me, to debug around
> that simple version, to understand how everithing works.

Jeff King suggested how you can update the build command to get it
working.  In general, I think people sometimes overthink what is
involved in a build: something like

	cc *.c

plus appropriate warning, optimization, debug, -D, and library flags
should work just fine.

If you haven't already read it, I also recommend reading
https://www.kernel.org/pub/software/scm/git/docs/user-manual.html#hacking-git.
If you have ideas for improving the text there (perhaps with suggested
build instructions?), patches to Documentation/user-manual.txt are
very welcome.

Thanks and happy hacking,
Jonathan
