Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54EAF1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 18:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeIRABd (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 20:01:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39484 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbeIRABd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 20:01:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so7959708pff.6
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bePtm4Gw1rZOvlUdSdRHgxxtB1dELpFtI8NS2NwJn3I=;
        b=F6SOKm+0xsWtmF6uZkQjgzkzPXipNusUI9KOSi/Ghg/8c5P/9NEnmqe4sEEOYbJVT2
         qWwH6xwTB8omZgX3zlI6kxr4JQ2VRhWQB67TxxZ9Cw1mOLo4B2iFBHuSZQww0t9xxauB
         DKlHOw6muBrTRpQBLb1y+08hyQKE/4+fjDJydEXazxkr+1dLXqQdVu32lRyw6BHltVSV
         K7PnBy1WyUqEJqOPgt0W6HaN5vJzA6o4Fs1KIzpqfHx6v1qIZF3OMup9oa7hLecQFF0W
         Ct1p0aqXyeuq9WN+9/nepjhZi5ytDZEFTuIZ9n7aLBiNmRvdxKaejB4P3UHMN6x21Ygm
         IKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bePtm4Gw1rZOvlUdSdRHgxxtB1dELpFtI8NS2NwJn3I=;
        b=Y9q8fpM2LAuV8pQP+yTaXee9uto1+/SqJQWO9wWTEVFBk0saksIKTKtzfy4P3Sp5ny
         Fe75xNOem34tTT2plrUuuzuSMDA3ycSGribpZ4JaD/F+n75TMMlK9vSiZhi86JEiVu0v
         YgAqeH7GhJq3Fx9rKTvDD02nP4HtSZ2MiviaTvMk8rmYtS83dd/s3YEMpcsn6BMngJ8s
         P8i7QL8qJiDKctMZrTMUCm2ioS4t8+EeS+XhRKRpiepFGNiSDPwrKPGPSOZD8LbeAWJQ
         8CJA+03KyofsU3/AzdI43XMAuGW4pp7HfT3ydsfop7KL//WAuryz+Vy1nVsp4b1vKNTA
         TtgQ==
X-Gm-Message-State: APzg51DtNLgUcWMvcQylLLnmS8enRE8XgJzporGo6N39noBX9Wtl6RCp
        1EYWR3/tISa0Uw90Tp7fMaB3zCs+
X-Google-Smtp-Source: ANB0VdZ24+uUQcU3ISdrRTUTca3T6crZmhDeLK01pRgMQaT+oN498DgP2XHBt4OCq2QBv1AFRsqY/g==
X-Received: by 2002:a63:e70e:: with SMTP id b14-v6mr24575203pgi.68.1537209180221;
        Mon, 17 Sep 2018 11:33:00 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 71-v6sm21445945pfx.182.2018.09.17.11.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 11:32:59 -0700 (PDT)
Date:   Mon, 17 Sep 2018 11:32:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] doc/Makefile: drop doc-diff worktree and temporary
 files on "make clean"
Message-ID: <20180917183258.GC140909@aiede.svl.corp.google.com>
References: <20180830195546.GA22407@sigill.intra.peff.net>
 <20180831063318.33373-1-sunshine@sunshineco.com>
 <20180831063318.33373-4-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831063318.33373-4-sunshine@sunshineco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Eric Sunshine wrote:

> doc-diff creates a temporary working tree (git-worktree) and generates a
> bunch of temporary files which it does not remove since they act as a
> cache to speed up subsequent runs. Although doc-diff's working tree and
> generated files are not strictly build products of the Makefile (which,
> itself, never runs doc-diff), as a convenience, update "make clean" to
> clean up doc-diff's working tree and generated files along with other
> development detritus normally removed by "make clean".
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index a42dcfc745..26e268ae8d 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -332,6 +332,7 @@ clean:
>  	$(RM) SubmittingPatches.txt
>  	$(RM) $(cmds_txt) $(mergetools_txt) *.made
>  	$(RM) manpage-base-url.xsl
> +	'$(SHELL_PATH_SQ)' ./doc-diff --clean

This means I need a copy of git in order to run "make clean".  That
was never required before.  It makes bootstrapping difficult --- do we
really need it?

Thanks,
Jonathan
