Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F9621F454
	for <e@80x24.org>; Mon, 11 Nov 2019 14:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKKOSK (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 09:18:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41795 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKKOSK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 09:18:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so14807384wrm.8
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 06:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jc1KwkZ+9x9az1LH7Y6T4ttLM+uriOS1xRcBQvT0Hf0=;
        b=qjfLBbIPrUuhLORJbd2+tLbCsRHw8u8cJ1ezA02PlTenmiyWuNgJ5txj4tXwJ3MUU4
         yBRCR8jo3sBj1zH7Dqw08NC8gx59WjyCFUEt59EOcJ60SwnO4J1sj415NHtMeXd6JEwO
         4RFBprT83+np005J08HvPh1ekYcxbFJVzJzb6Ym0XewlY1CYj5K3XsvOxjjh18FOgtly
         lhn8eoaf4Rv0PzvkoEu7NwrhLtz+V0rPyYUy8z0cgBwL6ovoCrGzIMoymQPABZC47NgN
         qkNb4jGoYmnNxYmIu9lgXGoS3ef5O6WkDha0zfE+5S/ZIF35DzsuAu/c/6w1yUIZPh90
         tFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jc1KwkZ+9x9az1LH7Y6T4ttLM+uriOS1xRcBQvT0Hf0=;
        b=pnNZ9bN7l/c/VF6xbzK8D2oieADYgYd/w2ZwLQKRE67Ys1PpsnmcX9M0DEuOlwcksz
         K/biRSQ6dTdrokgK35C7SVGlyQw/HKptegQoDdyPCih3H3kmpE5UwghElWp+q1EuSie5
         gILTv1+z3aqUI9pzc4V87Bk/wc7VDTW9y/Gz6Lyo4bY3RGM4Ilq6LpzP/6LdH7C/QB65
         BT+haV+d0yYFs9DSy2znwjQUjHfDn+TPobUI3JAaDBO7SotOZcIe3qILhGsBAiRy4E4r
         Y3nF26fJALWJ+Mhbq5aJ54xAVASLSREsLP85mJMI6AZFi3fcdd7F7s3s1AxMWo6oXgq8
         Cahg==
X-Gm-Message-State: APjAAAUi1yFFsY1gam5efS879MaJJ9HqIiJszYXMjd3E8HRbJj7Bs1iD
        VMVV3ixBZk5Ap48JvQukzIY=
X-Google-Smtp-Source: APXvYqxQjYc2xf/k5KDqnC8oPPwxhPv77sDwXsiqK/NESJv+WOeYTE2nuXr2MCPR/wiB+0X2PVGsyQ==
X-Received: by 2002:adf:fe89:: with SMTP id l9mr6141225wrr.368.1573481887817;
        Mon, 11 Nov 2019 06:18:07 -0800 (PST)
Received: from szeder.dev (x4db606e5.dyn.telefonica.de. [77.182.6.229])
        by smtp.gmail.com with ESMTPSA id 200sm27792715wme.32.2019.11.11.06.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 06:18:06 -0800 (PST)
Date:   Mon, 11 Nov 2019 15:18:05 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] hex: drop sha1_to_hex()
Message-ID: <20191111141805.GK4348@szeder.dev>
References: <20191111090332.GA2275@sigill.intra.peff.net>
 <20191111090418.GB12545@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191111090418.GB12545@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 11, 2019 at 04:04:18AM -0500, Jeff King wrote:
> There's only a single caller left of sha1_to_hex(), since everybody now
> uses oid_to_hex() instead. This case is in the sha1dc wrapper, where we
> print a hex sha1 when we find a collision. This one will always be sha1,
> regardless of the current hash algorithm, so we can't use oid_to_hex()

Nit: s/oid_to_hex/hash_to_hex/

We can't use oid_to_hex() because we don't have a 'struct object_id'
in the first place, as sha1dc only ever deals with 20 unsigned chars.

> here. In practice we'd probably not be running sha1 at all if it isn't
> the current algorithm, but it's possible we might still occasionally
> need to compute a sha1 in a post-sha256 world.
> 
> Since sha1_to_hex() is just a wrapper for hash_to_hex_algop(), let's
> call that ourselves. There's value in getting rid of the sha1-specific
> wrapper to de-clutter the global namespace, and to make sure nobody uses
> it (and as with sha1_to_hex_r() in the previous patch, we'll drop the
> coccinelle transformations, too).


> diff --git a/sha1dc_git.c b/sha1dc_git.c
> index e0cc9d988c..5c300e812e 100644
> --- a/sha1dc_git.c
> +++ b/sha1dc_git.c
> @@ -19,7 +19,7 @@ void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
>  	if (!SHA1DCFinal(hash, ctx))
>  		return;
>  	die("SHA-1 appears to be part of a collision attack: %s",
> -	    sha1_to_hex(hash));
> +	    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
>  }
>  
>  /*
> -- 
> 2.24.0.739.gb5632e4929
