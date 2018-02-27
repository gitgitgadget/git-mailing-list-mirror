Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B201F404
	for <e@80x24.org>; Tue, 27 Feb 2018 20:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeB0UY1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 15:24:27 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:38640 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeB0UY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 15:24:26 -0500
Received: by mail-pg0-f49.google.com with SMTP id l24so45223pgc.5
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 12:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QAZIbJQdAWOROfGFbQQ5E4qwhfqu+KL5638ycU+xwSo=;
        b=LZzk1ogPeabtdFGB9iAK1v0HPdEM0XKMiLCvMhidpgWwAVvjIJGfRJcgzfryYONDIw
         p3C2zvGoRaaIuf3Sv/dU58c6eu23Wk6zvpZrLknSw5XwCEK/IDjUjCx+ZN/TMmhHSJXv
         sD30xcMC7UtvvLgNOh4urTnh9GxSDXRtmnWJTmKrPn615xHFWpqBBT3gA+eZrE91inwU
         Kj7VMkzr5DH+1cGdnfaQjj7QeRRSfpEMrKZWZni4MSgO9VD03NaSG6U3a3eGbfcT2Vli
         WmE+T9rrLeKgcfWGg9nvxZYVS8mMHPY7uk7BMb1hT1ZrffR5OCgOHl18CwHid8WiAnCC
         GeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QAZIbJQdAWOROfGFbQQ5E4qwhfqu+KL5638ycU+xwSo=;
        b=uReKKDeRilNMQpE8Wg6S6v1rsfw4vkAOJ42Sialy7cb29k1UEBc4c0BG4wu9XJm0JA
         RbBHMEYyJAZMDaeIUYZdzu3J710gYZgfhQL2cpRGoZ/VAvR2UfazdM16MAnjiOtPbiaI
         37pxW6lQWgl6wWoCR47Kda7UPXwKg7Dp/fAt0LByajnrnOzQbp7r30JAoBbhnpvUEJ+V
         b7sGir8Im4z07nqrU6zoxQFep2sfhfTDoJnTFcDEOaHU0P+W6+0Wn/sTFJWj6lhd9RLR
         eNhRARKeVAwKqDOkUrJpaYVIvy0yAc1ams6Q4hJL7rRYr58a2aDEWEcBky1r7cxIqmot
         1AWw==
X-Gm-Message-State: APf1xPC3//3VgN3fLffkOZMefPuLC8sEwVUaUIiwyEwsPpbk9DvFo1W8
        Px1gNAsXJEQy45BrZ0RO2VNpRbwX
X-Google-Smtp-Source: AH8x224irhghOoOggSf3KCpn15A7mxKjv46eq5cfcXlgRnwKwyaRLdU9WE2GJNGtI40Xd72piddLqw==
X-Received: by 10.101.67.198 with SMTP id n6mr12260869pgp.150.1519763065520;
        Tue, 27 Feb 2018 12:24:25 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b88sm24620336pfd.108.2018.02.27.12.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 12:24:24 -0800 (PST)
Date:   Tue, 27 Feb 2018 12:24:23 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?M=E5rten?= Kongstad <marten.kongstad@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] docs/pretty-formats: fix typo '% <(<N>)' -> '%<|(<N>)'
Message-ID: <20180227202423.GD174036@aiede.svl.corp.google.com>
References: <1519762664-16889-1-git-send-email-marten.kongstad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519762664-16889-1-git-send-email-marten.kongstad@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mårten Kongstad wrote:

> Remove erroneous space between % and < in '% <(<N>)'.
>
> Signed-off-by: Mårten Kongstad <marten.kongstad@gmail.com>
> ---
>  Documentation/pretty-formats.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks correct to me.  The space was introduced in v1.8.3-rc0~22^2
(pretty: support %>> that steals trailing spaces, 2013-04-19) and
appears to be a plain typo.  Thanks for fixing it.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -202,7 +202,7 @@ endif::git-rev-list[]
>  - '%>>(<N>)', '%>>|(<N>)': similar to '%>(<N>)', '%>|(<N>)'
>    respectively, except that if the next placeholder takes more spaces
>    than given and there are spaces on its left, use those spaces
> -- '%><(<N>)', '%><|(<N>)': similar to '% <(<N>)', '%<|(<N>)'
> +- '%><(<N>)', '%><|(<N>)': similar to '%<(<N>)', '%<|(<N>)'
>    respectively, but padding both sides (i.e. the text is centered)
>  - %(trailers[:options]): display the trailers of the body as interpreted
>    by linkgit:git-interpret-trailers[1]. The `trailers` string may be
