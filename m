Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5E7C20248
	for <e@80x24.org>; Sat, 13 Apr 2019 12:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfDMMXB (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 08:23:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54328 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfDMMXA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 08:23:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so14384025wml.4
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 05:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vzC/9M5IGnvHVqZ1tribYfp3KgNMB2OzSKibFisDWQc=;
        b=UVJTap+B0fV+dUTNxLIAhyK03RmO9Y6LgkbTZfBHgGZGJwm/hqiMby8j2TWjFNP14y
         UpMv3ULHzB5VKw+JivNqXn7enXDeDsQRsN728mYaDGqE4HmId3sxfQBN+W4iqBv/t4fr
         sPzfA3yMh0fSvfAzS0DYL0Si097XhQf58ZIvX+2hdLQhr7/m7AW4PPLmHg+ZsMYpDGMM
         ysSW9lUaF3DRM4lAU6aqCGLvPl2rwK6o9Bn/IXKP+9qjx0m3UIAaHFVXr/0mttQSdH54
         hF6fXrl84YMy+8KRG0K2sJJvpQwBgSBKfxXpKToQsXz9OBWU9bSh6qC5whMOEs8U9tUG
         Y6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vzC/9M5IGnvHVqZ1tribYfp3KgNMB2OzSKibFisDWQc=;
        b=HLiDWpZgtH/TSFUcS0HH3UYRK0ujI5zYpxKQt2LH/ChHbH8sDjidHi1GBMxIZAA1S+
         xt5Vr5yPQ3x/qK//j7mqSrXTFxkQbhjss3Pf8pAutJDmsclpp7b61HxoLlFUpDkEHOSw
         XkcTWMW4/T/0cHHdvmE6Qzw0m6NPSDfia/g3t76m3muMtnOvCNudn/rWzVpAgbcO+ldb
         SpBqZXooS8OZxyF0mhtjOoHhAYRWmQUCvEdwth4DD2jYq7R5BuqdcEcTRcjX7q13efh7
         Lmx8BnILh1NeKwQ1u5rnID/62L2sUYeFIez38guJtMIDz9/Lx/wUWeKocShYtQICI+H0
         MHLw==
X-Gm-Message-State: APjAAAXWid91zp1B8ngYVTFZPA6ZqYTVZEVXdFTmfaSfgXGT6k4NOtIa
        3by6+02kii0EtaFP3oq67+A=
X-Google-Smtp-Source: APXvYqyKyniejBRv+A1D9znx5NDBpu0ikxc6MYoG2InZcBtZIy80tSD0bB2LrOItBN8ZNqujSlUl1Q==
X-Received: by 2002:a1c:a64d:: with SMTP id p74mr15612800wme.89.1555158179084;
        Sat, 13 Apr 2019 05:22:59 -0700 (PDT)
Received: from szeder.dev (x4dbd3ef2.dyn.telefonica.de. [77.189.62.242])
        by smtp.gmail.com with ESMTPSA id x84sm16949564wmg.13.2019.04.13.05.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 05:22:58 -0700 (PDT)
Date:   Sat, 13 Apr 2019 14:22:56 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     johannes.schindelin@gmx.de, dstolee@microsoft.com,
        git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com
Subject: Re: [PATCH v3* 11/33] commit.c: add repo_get_commit_tree()
Message-ID: <20190413122256.GC15936@szeder.dev>
References: <nycvar.QRO.7.76.6.1904121624160.41@tvgsbejvaqbjf.bet>
 <20190413101600.713-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190413101600.713-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 13, 2019 at 05:16:00PM +0700, Nguyễn Thái Ngọc Duy wrote:
>  OK how about this? set_commit_tree() is added to keeps that long line
>  in commit.cocci down. I also make commit.cocci generate invalid
>  repo_get_commit_tree() code this time.

> diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
> index c49aa558f0..ee1dc29234 100644
> --- a/contrib/coccinelle/commit.cocci
> +++ b/contrib/coccinelle/commit.cocci
> @@ -11,18 +11,14 @@ expression c;
>  + get_commit_tree_oid(c)->hash
>  
>  // These excluded functions must access c->maybe_tree direcly.
> +// Note that if c->maybe_tree is written somewhere outside of these
> +// functions, then the recommended transformation will be bogus with
> +// repo_get_commit_tree() on the LHS.

We could prevent transformations putting repo_get_commit_tree() on the
LHS by inserting the semantic patch:

  @@
  identifier f !~ "^set_commit_tree$";
  expression c;
  expression s;
  @@
    f(...) {<...
  - c->maybe_tree = s
  + set_commit_tree(c, s)
    ...>}

before this one.


>  @@
> -identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
> +identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit|set_commit_tree)$";
>  expression c;
>  @@
>    f(...) {<...
>  - c->maybe_tree
> -+ get_commit_tree(c)
> ++ repo_get_commit_tree(specify_the_right_repo_here, c)
>    ...>}
> -
> -@@
> -expression c;
> -expression s;
> -@@
> -- get_commit_tree(c) = s
> -+ c->maybe_tree = s
