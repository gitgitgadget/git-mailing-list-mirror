Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D320E1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 23:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeB0XRy (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 18:17:54 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34826 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeB0XRx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 18:17:53 -0500
Received: by mail-pl0-f67.google.com with SMTP id bb3-v6so338991plb.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 15:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EF6HzYfrZgNWmAE5d83tB9QEdno8AgmxzZexwSwurXI=;
        b=W0a3czoQ7kACVFk1oyOnTJdn+xHQ2ntJv2IIfTyTrzFqTV/OQYR0a8SVBX/2JkdNVd
         JOvlRNCHxDRSnNaTDJfVCoPYdy5l1kQeuWbayeJzL1O17LT7aRq3PslstB9dR32D6vXs
         Dv8s1neFzWjeR310y0iXJj3W6uDlZxkpCbBGw/Oo1wF0Q+NvNtJRhRLbGGH2haasV+Xt
         PPNP9Bm10xmkJ77eqzc47WGsp/9nmpVoOqGxvRhFqme/A49XYS66+0EzTauVahDUjf6k
         2cdpEihTZE1pwPmEBCdA0RjqTbbin3s5afi6I6FiGlNdfHwgjp/O60+qRYfYdQ1TIzla
         0oyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EF6HzYfrZgNWmAE5d83tB9QEdno8AgmxzZexwSwurXI=;
        b=MJA0qirzgStoLG3QH4WrB0nI8JwF0SlxgbGuehMY4vRdK4qSVpFXEU5sIIgqMq7UKJ
         3hv9tXwDDpj0S6vS1uqqGLHa2/yEMtxDNO5/0GIpipsCSwTzJy7mhLw9NQNKF1Kfc6u5
         R4ijlQy+orAAOard4yLgLRq5+Ya2go5BWQKm+u1jrOXahT1bi8Wwq/6n6tIipvwG0d2n
         VWZ+/B+zWsv6OGjQ9ZqBkJxrBB/URwdnxhEHdGQURd1uxxEncFBfhnfLMQGOqeob8Xkm
         mxiyo1ksCwP9Z1apWDWPZ/FmfZq2ucvkENv03xWM+GkyvBlBso/vMvkGWP1gbnT9xDjz
         bunQ==
X-Gm-Message-State: APf1xPA72grSUioyc9ZPeHd5G46tqcpN+hU8RuI/UlCrBUkY8SMHUoRx
        lb7ORp9JOsxVot+gw5yUFtg=
X-Google-Smtp-Source: AG47ELsIUfv5md0hnOssZ3LZi5j3OlQxDsmTVtji7PFcxzv769D9IkbWUnFRwNtIj0fsIKgzFz2TJg==
X-Received: by 2002:a17:902:76cb:: with SMTP id j11-v6mr11140677plt.431.1519773472390;
        Tue, 27 Feb 2018 15:17:52 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s90sm29753pfd.153.2018.02.27.15.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 15:17:51 -0800 (PST)
Date:   Tue, 27 Feb 2018 15:17:49 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 31/35] remote-curl: store the protocol version the
 server responded with
Message-ID: <20180227231749.GG174036@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-32-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-32-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Store the protocol version the server responded with when performing
> discovery.  This will be used in a future patch to either change the
> 'Git-Protocol' header sent in subsequent requests or to determine if a
> client needs to fallback to using a different protocol version.

nit: s/fallback/fall back/ (fallback is the noun/adjective, fall back
the verb)

> Signed-off-by: Brandon Williams <bmwill@google.com>

With or without that tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
