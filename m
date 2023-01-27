Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B42C38142
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 19:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjA0TRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 14:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjA0TRE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 14:17:04 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BAE7BE5A
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 11:17:03 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s67so3843302pgs.3
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTjntc6UaCGLmgUV+lrYSnmz1Co3TI8qdKqYhQis8gE=;
        b=Q0Lgp7NIO5YwKsOwfWFGSb4GN4/pmbdbDYK8nBxYtFSzOp8dOVE6KLwvqKAqqI/wx3
         WgVwlzMSkjmuFYx096rgudM4MpDq0q4s+z4QlDiA818rjr+mrOzsdFZOufDDK29L7Vuo
         MwMiy5VbeoZy8/jtO0ZC7lztiNLdnlT9qarI4+2pm2EoO7XdjXky1EACQ/k7SInT4uMX
         6jei7Nyh8QCXhtYElL1QFfxAFDpwru2pUO8B88bUPcUXZw6Rr6Cdh5jG8AOxKupb34pZ
         vKZ811grSlfpZ+fSfnrAlXVk2eiQ9dN+BncJ6JlSlQ2HmykA/dJ3k89a2blPkmz4qmbT
         gqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTjntc6UaCGLmgUV+lrYSnmz1Co3TI8qdKqYhQis8gE=;
        b=YViOAiN1JNExDoeExrR787GldIfZxuo6fSkZbGoh6OiVpCH2vaLxx7GQtmQTE0/RT/
         UYFbxqu0LbEUgPS7K3zsuj9cvCc/CGD2dgD7R85576jevqOTftuhDJwW6zQd9WbcZDe8
         GRkr2qqga5UhdCXDC3DTnuFkCPWtNLdV3JIPQwCarjv5vD5QXxJzQPqjf3Xs0czwZez8
         nj4s72vf7rMBeMVhr7WJFFTtrCJWg5x93XQUe6/Y3VEwMZ6keHBoO2Cxz5GPVh7Z3hiz
         HN2RfMGk2zZd0MPozzxc1wEMRtCSCkxlZfdK4YIlLG1xgl3STCPYXbjVN3uUtH+tb1Sq
         Bz8Q==
X-Gm-Message-State: AO0yUKX+L77GWUUJiOwE9FMRxKGigJGn6UXDc3ECTlyU3M6DcuiG9Z5d
        QksrwjpocNLB1/eu7wGGHer2
X-Google-Smtp-Source: AK7set++G/hJC7Ax9//ywdDQTNzq71iYZysIwIp+XmmD/OERW+pXlZ7bwuqfW0ZR/Nqbk4ApVSVr/A==
X-Received: by 2002:a62:79ca:0:b0:592:42ad:14c5 with SMTP id u193-20020a6279ca000000b0059242ad14c5mr3176711pfc.33.1674847022488;
        Fri, 27 Jan 2023 11:17:02 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id x124-20020a626382000000b0057fec210d33sm2951579pfb.152.2023.01.27.11.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 11:17:02 -0800 (PST)
Message-ID: <a2896d5b-f395-68df-1f23-356d0128cb9c@github.com>
Date:   Fri, 27 Jan 2023 11:17:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 05/10] bundle-uri: download in creationToken order
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
 <7cfaa3c518cbedb65c585cc02015bb21ae24e9fa.1674487310.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <7cfaa3c518cbedb65c585cc02015bb21ae24e9fa.1674487310.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> +struct bundles_for_sorting {

...

> +static int append_bundle(struct remote_bundle_info *bundle, void *data)

...

> +/**
> + * For use in QSORT() to get a list sorted by creationToken
> + * in decreasing order.
> + */
> +static int compare_creation_token_decreasing(const void *va, const void *vb)

These new function/struct names are all unambiguous. Looks good!

> +	cur = 0;
> +	while (cur >= 0 && cur < bundles.nr) {
> +		struct remote_bundle_info *bundle = bundles.items[cur];
> +		if (!bundle->file) {
> +			/*
> +			 * Not downloaded yet. Try downloading.
> +			 *
> +			 * Note that bundle->file is non-NULL if a download
> +			 * was attempted, even if it failed to download.
> +			 */
> +			if (fetch_bundle_uri_internal(ctx.r, bundle, ctx.depth + 1, ctx.list)) {
> +				/* Mark as unbundled so we do not retry. */
> +				bundle->unbundled = 1;

This implicitly shows that, unlike a failed unbundling, a failed download is
always erroneous behavior, with the added benefit of avoiding (potentially
expensive) download re-attempts.

> +
> +				/* Try looking deeper in the list. */
> +				move_direction = 1;
> +				goto stack_operation;
> +			}
> +
> +			/* We expect bundles when using creationTokens. */
> +			if (!is_bundle(bundle->file, 1)) {
> +				warning(_("file downloaded from '%s' is not a bundle"),
> +					bundle->uri);
> +				break;
> +			}
> +		}
> +
> +		if (bundle->file && !bundle->unbundled) {
> +			/*
> +			 * This was downloaded, but not successfully
> +			 * unbundled. Try unbundling again.
> +			 */
> +			if (unbundle_from_file(ctx.r, bundle->file)) {
> +				/* Try looking deeper in the list. */
> +				move_direction = 1;
> +			} else {
> +				/*
> +				 * Succeeded in unbundle. Retry bundles
> +				 * that previously failed to unbundle.
> +				 */
> +				move_direction = -1;
> +				bundle->unbundled = 1;
> +			}
> +		}
> +
> +		/*
> +		 * Else case: downloaded and unbundled successfully.
> +		 * Skip this by moving in the same direction as the
> +		 * previous step.
> +		 */
> +
> +stack_operation:

Other than this label, it looks like you've replaced all of the
"stack-based" language. Should this be replaced as well? No problem if not,
I just wasn't sure whether it was left that way intentionally.

> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index 474432c8ace..6f9417a0afb 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -401,17 +401,43 @@ test_expect_success 'clone bundle list (http, creationToken)' '
>  	git -C clone-list-http-2 cat-file --batch-check <oids &&
>  
>  	cat >expect <<-EOF &&
> -	$HTTPD_URL/bundle-1.bundle
> -	$HTTPD_URL/bundle-2.bundle
> -	$HTTPD_URL/bundle-3.bundle
> +	$HTTPD_URL/bundle-list
>  	$HTTPD_URL/bundle-4.bundle
> +	$HTTPD_URL/bundle-3.bundle
> +	$HTTPD_URL/bundle-2.bundle
> +	$HTTPD_URL/bundle-1.bundle
> +	EOF

Ooh, interesting - using the new "test_remote_https_urls", these tests now
also verify that the bundles were downloaded in decreasing order when using
the 'creationToken' heuristic. That's a nice extra confirmation that the
heuristic is working as intended.

> +test_expect_success 'clone incomplete bundle list (http, creationToken)' '

...

> +test_expect_success 'auto-discover multiple bundles from HTTP clone: creationToken heuristic' '

These tests look good as well, especially 'clone incomplete bundle list's
now-more descriptive name.

