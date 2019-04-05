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
	by dcvr.yhbt.net (Postfix) with ESMTP id B0365202BB
	for <e@80x24.org>; Fri,  5 Apr 2019 00:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfDEA43 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 20:56:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45265 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDEA43 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 20:56:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so5896208wra.12
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 17:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a1vUE75BUwVtbJQPFR1gyue+vCK0v0Yta1TZax4dmSo=;
        b=QoGm8vjMaF9CbPN6hjDIXzQVIaiJAEOopiMg0wBuhGwG3QZwguCVe9hQvXQaFWyj7T
         H8y8cYNCv4m8k1sHkmC1QXp5nJGzzmB0JzID8c6UxH9brg2ahtJZHmQwmQhKDsbIjLTC
         n5kti8CHDEKb1SGs/aReWoYZodK+Aypq2uSL6TWVraw2WN8pQS/V+VNHuUw/WcjahkjY
         Pd0b01V7w6B3HIMs3ILQCvhqo7fNiO/QydHKJgueo4zNE+LHnY0Cwp6P2hBVJaZFYA+u
         BcGvdw4LybWFvrtnA2fejKQjv3W/UGgobF9EVVOzy/xJ4wLVtkRs41O36GcdUF5OuHtR
         FMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a1vUE75BUwVtbJQPFR1gyue+vCK0v0Yta1TZax4dmSo=;
        b=oPpTqmBWy4qtpoPS1kbJ775CDe/yAt/IdoCcPbCOf4L7jlkqhojPHoqZa9leZvwc/A
         f0WmYpZlI0MRWZTKrRLcO+OYCzrcSLQSnzxFdhRGQmqSzWN8Za14IM4F71W5O1aK91gA
         hkC2j2dHDBRipreFxTAzTDI+i8nZJ/IIa4r0IcIi/GirRLWtTfeOVrPm+I0igkm4GkvR
         R/9GdM607aAr9N2otEuMM1fly7Vq2jUGG3apMolKmypioFqozmLXx1PBCoDKTHcS1xf2
         fyuyBYiN2xPY1IiG4o3PC0rw8L4FpugbjsDlRFbqh/hg1vO11OEgvvsFn3KLtLCqCccO
         plyA==
X-Gm-Message-State: APjAAAUMTUTjm00MiQf6v9JwVlF4yoBxbtj/z1n6yPn8inxReZ3dlGaB
        zBKipa6nzZLDLPQsRRWZjC4=
X-Google-Smtp-Source: APXvYqzpacEZx53oxOWzq9MlFoZXiHYIdChSvzQ0wb+XRfodteUyCze9Z3BSSzS1GxfZwcKDsv0P9A==
X-Received: by 2002:adf:b612:: with SMTP id f18mr6346889wre.236.1554425787653;
        Thu, 04 Apr 2019 17:56:27 -0700 (PDT)
Received: from szeder.dev (x4db96230.dyn.telefonica.de. [77.185.98.48])
        by smtp.gmail.com with ESMTPSA id a6sm15463240wrp.49.2019.04.04.17.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 17:56:26 -0700 (PDT)
Date:   Fri, 5 Apr 2019 02:56:24 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v4 09/11] t0410: test fetching from many promisor remotes
Message-ID: <20190405005624.GS32732@szeder.dev>
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
 <20190401164045.17328-10-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190401164045.17328-10-chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 01, 2019 at 06:40:43PM +0200, Christian Couder wrote:
> From: Christian Couder <christian.couder@gmail.com>
> 
> This shows that it is now possible to fetch objects from more
> than one promisor remote, and that fetching from a new
> promisor remote can configure it as one.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t0410-partial-clone.sh | 47 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 9266037714..146b0a1e03 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -182,8 +182,53 @@ test_expect_success 'fetching of missing objects works with ref-in-want enabled'
>  	grep "git< fetch=.*ref-in-want" trace
>  '
>  
> +test_expect_success 'fetching of missing objects from another promisor remote' '
> +	git clone "file://$(pwd)/server" server2 &&
> +	test_commit -C server2 bar &&
> +	git -C server2 repack -a -d --write-bitmap-index &&
> +	HASH2=$(git -C server2 rev-parse bar) &&
> +
> +	git -C repo remote add server2 "file://$(pwd)/server2" &&
> +	git -C repo config remote.server2.promisor true &&
> +	git -C repo cat-file -p "$HASH2" &&
> +
> +	git -C repo fetch server2 &&
> +	rm -rf repo/.git/objects/* &&
> +	git -C repo cat-file -p "$HASH2" &&
> +
> +	# Ensure that the .promisor file is written, and check that its
> +	# associated packfile contains the object
> +	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
> +	test_line_count = 1 promisorlist &&
> +	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&

You could drop the unnecessary 'cat', 'sed' is capable to open a file
on its own.

> +     git verify-pack --verbose "$IDX" | grep "$HASH2"

Please don't run a git command, especially one with "verify" in its
name, upstream of a pipe, because the pipe will hide the git command's
exit code.


> +'
> +
> +test_expect_success 'fetching of missing objects configures a promisor remote' '
> +	git clone "file://$(pwd)/server" server3 &&
> +	test_commit -C server3 baz &&
> +	git -C server3 repack -a -d --write-bitmap-index &&
> +	HASH3=$(git -C server3 rev-parse baz) &&
> +	git -C server3 config uploadpack.allowfilter 1 &&
> +
> +	rm repo/.git/objects/pack/pack-*.promisor &&
> +
> +	git -C repo remote add server3 "file://$(pwd)/server3" &&
> +	git -C repo fetch --filter="blob:none" server3 $HASH3 &&
> +
> +	test "$(git -C repo config remote.server3.promisor)" = "true" &&

Please use test_cmp_config.

> +	# Ensure that the .promisor file is written, and check that its
> +	# associated packfile contains the object
> +	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
> +	test_line_count = 1 promisorlist &&
> +	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
> +	git verify-pack --verbose "$IDX" | grep "$HASH3"

Likewise.

> +'
> +
>  test_expect_success 'fetching of missing blobs works' '
> -	rm -rf server repo &&
> +	rm -rf server server2 repo &&
> +	rm -rf server server3 repo &&
>  	test_create_repo server &&
>  	test_commit -C server foo &&
>  	git -C server repack -a -d --write-bitmap-index &&
> -- 
> 2.21.0.203.gd44fa53258
> 
