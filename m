Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825A4C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 11:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbiEXLoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 07:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiEXLoF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 07:44:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21DC5AA74
        for <git@vger.kernel.org>; Tue, 24 May 2022 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653392567;
        bh=ssaJsYfwrn6981Uq97GoLn21LbMCdDNcKp3K6xPSuxk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VxsnspTvpDTdcMpDYQIv0X9Pa9YODrufox7sOJ04zvHzBJq11gkqF/lXc1DTrQ3bk
         9kP5FkBFKrpmEy1i21BqTCa1A5Phyh6HImzw5yM30WgqH9W5QsICkwlOXvmzvIQ5AV
         HBvIqWZ3ES2h/WqfF/tdb8xigkW1IypkLhMYkB2Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lcJ-1nuIHU00jT-000wO1; Tue, 24
 May 2022 13:42:47 +0200
Date:   Tue, 24 May 2022 13:42:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, avarab@gmail.com, christian.couder@gmail.com,
        jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] urlmatch: create fetch.credentialsInUrl config
In-Reply-To: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205241339440.352@tvgsbejvaqbjf.bet>
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BhGsHN170tEQ8jG5Wcr86uaItJKOXIYRnSkAOp+8mklCUj0ROgw
 CriZK72KqUBMTIqVwc8vhjI2KScg+ikEaLFzj4IAL0RpOEh8Lgr5JYmovkH0fsjhhJTvO5I
 G04+EkYjDivkz5Pq6eCygX/8SkTOmLi5jiwdhc+YETZ9EEbzwB1XNy83teEmU1QKBLE6FDi
 KcK4NVt3CGPMvpaWM5OJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u438kl9+uss=:DTkPOLEXbP13e9tCC29lPG
 xgjhHIs6X3l5XYpM6g3bKEPosW01UhDCStOK9PUVa6N7gqx2V+an/vFH3McQ9fXxzAJvQMKGH
 K8KiCHgBDfwye37AvJJx6I+jMc4R8sMFHevRxcJRnGL46MWcxYK3jNdqtNne46Ys4Y70oZhEg
 gkQmavg0Kn6IbUX2FuisClcyF2HoNPntkMZlw2ytAOlP8h4KESmFo2yuOj3piwpKTfUV28WQf
 wLZzYQjrxHgUEeGLVlfOL67BUdm/rIzXwmoIX1cZQp7VAWgCT5TKo+xvfrtsnuMvSD5r1V0hy
 EksGpt4veAtD7RfxuBSaNKkAhWXtmvODBSVmBkAGBB1l/msLA7btRk041X3HP5X8zauzGZRtZ
 7CYl0Hq3/PAt6rU5JE7c1a1ZBJh9hRyiISbWCz78B3xIda/IQC7+h6W3hx6OIU6zYIQHwFOIT
 ft2W01l72rdwujpTWF3262pZzb20NwOiuLK6MUxGvXMhWB6od6+aPSRGcmDYVK+yYRtHID27k
 przgrVV0SSDANjEU+ptOxEVlBJjhds/wjQCaV9ylimi3E1fRr1YzyJHvkiRlHsYxQIKwIoqJO
 d08MRYkjR9Dk5r7WBhGU4/mQnImMyIXGms+quaFJtY7ltOcmOz4G6SskC+QTanc8WQ9YBE0Yx
 1OGTrhBycbSDSFQpVq9W0rTLmqzAVfvQb/rTs2zFkHlG3PVsmcwgTPOGvOXSdsPnfiseo4sXH
 6aZ+H66u4qkIPy53WLr/hKFhRV8/1z/vTcLN9HGp6JFVwtD6uIwCwQFDPThQtp73/wXQf1ulb
 ig7icB3pwqCyRe3sqG+rije6ziOy3WiMFvIrGoBPTBNa0diBWMkQpfL4ZyF0Yk7ieXle2idWW
 8UCcDQo/MQjndbhtbnRQxNGoq8qX3XjDTx84v1eheCcvdyTUdPSqxmVNuzn8EXDjSJnnig2aK
 8yI1lEqCTI/x8ag8FYrGCzAfeaZJ3d2loCx0Hk8GzweZqYOy8x7a4vff/FSs4Vp3i1wb2l8QP
 Bf/7/VaNG27vJVUs5Wjs/9AC0CJPIrTHP1oO4nEQV7XcI1Lr72TUv7pvk4WY4g7wmovBoctiG
 4eHk45mxEP5S/JlbzhEo3fI+egy40vwMN9NsQ06qch9L1l6US3PjK6SxA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Mon, 23 May 2022, Derrick Stolee via GitGitGadget wrote:

> diff --git a/urlmatch.c b/urlmatch.c
> index b615adc923a..6b91fb648a7 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> +static void detected_credentials_in_url(const char *url, size_t scheme_len)
> +{
> +	char *value = NULL;
> +	const char *at_ptr;
> +	const char *colon_ptr;
> +	struct strbuf anonymized = STRBUF_INIT;
> +
> +	/* "ignore" is the default behavior. */
> +	if (git_config_get_string("fetch.credentialsinurl", &value) ||
> +	    !strcasecmp("ignore", value))
> +		goto cleanup;
> +
> +	at_ptr = strchr(url, '@');
> +	colon_ptr = strchr(url + scheme_len + 3, ':');

How certain are we that `url + scheme_len + 3` is still inside the
NUL-separated `url`?

> +
> +	if (!colon_ptr)
> +		BUG("failed to find colon in url '%s' with scheme_len %"PRIuMAX,
> +		    url, (uintmax_t) scheme_len);

Wouldn't this mean that `https://github.com/git/git` with a `scheme_len`
of 5 would hit that `BUG()` code path?

Thanks,
Dscho

> +
> +	/* Include everything including the colon. */
> +	colon_ptr++;
> +	strbuf_add(&anonymized, url, colon_ptr - url);
> +
> +	while (colon_ptr < at_ptr) {
> +		strbuf_addch(&anonymized, '*');
> +		colon_ptr++;
> +	}
> +
> +	strbuf_addstr(&anonymized, at_ptr);
> +
> +	if (!strcasecmp("warn", value))
> +		warning(_("URL '%s' uses plaintext credentials"), anonymized.buf);
> +	if (!strcasecmp("die", value))
> +		die(_("URL '%s' uses plaintext credentials"), anonymized.buf);
> +
> +cleanup:
> +	free(value);
> +	strbuf_release(&anonymized);
> +}
> +
>  static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
>  {
>  	/*
