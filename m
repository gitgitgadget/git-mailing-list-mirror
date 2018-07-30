Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8631F597
	for <e@80x24.org>; Mon, 30 Jul 2018 21:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbeG3Wl3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 18:41:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38193 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbeG3Wl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 18:41:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so5070127pfh.5
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=owJSX6KfqyJCi846kKqVzpWZRy+QvsjioiVYYLPEnqk=;
        b=rNT5EBx7c50SXSgblXnbGhiJ/djmlgW5ae+Veuh+6+M1Ey7S8fbjfGop1lxDbSvCQa
         sbe1zhW8SOOrfdsjtzaBAxGQnlrohQgY3tiQsR6ARZNottv+M/s7f9D6b8kDM/Dyw2QN
         Rcustf6O/RgCf+ryea6gg+fAF7Rq1jar9ro3VkWMNrypdiy2zAGVZhHlpvMFHro2fhmR
         wFjtYOnEmwN0fu3ckgHbUv7X4I8OJ70K7N+LFIGLk/KnQ7qlRqPjlnc/EBUhayLzCyKK
         fOkCTWWDAFnM1T7eVPtd64MSczZafeF9Fab7aU91HE1NYjMiapRqwW1a5YMi/j2jCo35
         G4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=owJSX6KfqyJCi846kKqVzpWZRy+QvsjioiVYYLPEnqk=;
        b=osEHt5WlrruO8najyixWX8fePaSjs127gPntEPIFQQXzg9E68pDvj9BRUIOlltWwqx
         5hJnyOv8+Oj/Q2X1ly2PSBloJJj64P7KWeqJkyI9cGlH9xz72zRIGZ0wEKUSsFRaGaGa
         b+QwSUbWTLG3bWtmTBHCUAJ3lMUU8TKOJGJoAbgVcDLBSpXusU2dEhIoSda9UrYbwjwW
         NJT3UP5+3AYm0vTd9MQr9Hrg6Zq/ygTX+aiulRhxADR37vLRX9mr04VD9sEIud2y9/ys
         wblXWom0j0l9h4jezqNb+mqDZe+AX2gdtvujTMvD4VuaZ/haG2sr9/gG638vwN0XTEqY
         2T7g==
X-Gm-Message-State: AOUpUlGmWsYILMc+YlogwTiplMuz2iVa3hq+obCprQH5pOoEmHWMJhIU
        AtY6J2bzMEqJIMJ64yFiJmI=
X-Google-Smtp-Source: AAOMgpe7m2eu4w7mBO8Y0xyppwzBlT0j5PlsSh+dwS3VAeX26NNimVitBUrXvRhWfYKzSVdRBLNUjQ==
X-Received: by 2002:a65:4d05:: with SMTP id i5-v6mr17447435pgt.58.1532984680290;
        Mon, 30 Jul 2018 14:04:40 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h69-v6sm35139384pfh.13.2018.07.30.14.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 14:04:40 -0700 (PDT)
Date:   Mon, 30 Jul 2018 14:04:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Antoine =?iso-8859-1?Q?Beaupr=E9?= <anarcat@debian.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] mw-to-git/t9360: fix broken &&-chain
Message-ID: <20180730210438.GF156463@aiede.svl.corp.google.com>
References: <https://public-inbox.org/git/20180730190612.GB156463@aiede.svl.corp.google.com/>
 <20180730204646.32312-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730204646.32312-1-sunshine@sunshineco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: some folks interested in git-remote-mediawiki)
Hi,

Eric Sunshine wrote:

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> Jonathan's discovery[1] of a broken &&-chain in a contrib/subtree test
> prompted me to check other tests bundled in contrib/. This was the
> only other problem found. Unlike the subtree &&-chain case, this
> breakage is at the top-level, thus was caught by the normal
> --chain-lint mechanism, not the subshell linter.
>
> [1]: https://public-inbox.org/git/20180730190612.GB156463@aiede.svl.corp.google.
> com/

A small detail from there would be useful to have in the commit
message: namely that this was detected using --chain-lint (and what
command I can run to reproduce it myself).

With or without such a tweak to the commit message,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

>  contrib/mw-to-git/t/t9360-mw-to-git-clone.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
> index 22f069db48..cfbfe7ddf6 100755
> --- a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
> +++ b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
> @@ -247,7 +247,7 @@ test_expect_success 'Test of resistance to modification of category on wiki for
>  	wiki_editpage Notconsidered "this page will not appear on local" false &&
>  	wiki_editpage Othercategory "this page will not appear on local" false -c=Cattwo &&
>  	wiki_editpage Tobeedited "this page have been modified" true -c=Catone &&
> -	wiki_delete_page Tobedeleted
> +	wiki_delete_page Tobedeleted &&
>  	git clone -c remote.origin.categories="Catone" \
>  		mediawiki::'"$WIKI_URL"' mw_dir_14 &&
>  	wiki_getallpage ref_page_14 Catone &&
> -- 
> 2.18.0.597.ga71716f1ad
> 
