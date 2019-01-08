Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD541F803
	for <e@80x24.org>; Tue,  8 Jan 2019 01:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfAHB4h (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 20:56:37 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:37492 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfAHB4g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 20:56:36 -0500
Received: by mail-qk1-f202.google.com with SMTP id s70so1960937qks.4
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 17:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7DoZmb9VXzXIyxWJGhrP+ucHUcGlI74SQUhMK34ZwcI=;
        b=ZwVzl9dIMCOdnitlJb8yF2A5vlH27+VJsFle+JZWXJTmgg8vo/rwTpPqke8BqSk+eo
         evVfVsCWGQXWE2lhZ/WQH6X0AL4uAf8E9LzPqDIHg4kpiHtCBbgHuGmg345VWVfRQc0f
         zmq0LKqUUfSEdppfZMQXYKlizcm9sNfzHOTJ5u5qS9iUMVoKijFWOBADbF8zQB4no+IH
         kGpdgZHAtcsxz0g/5NEsrdUpuU4bYgKvFhRTS+Vr3Tue1XMElWF/nNfTVrXFLyCQkj/1
         inMeSgwZluX6Cb8syktqnMQgBrewxY7/bGehKGJKGje4s0zJDQd0jo77+RJqeon/3ol3
         mg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7DoZmb9VXzXIyxWJGhrP+ucHUcGlI74SQUhMK34ZwcI=;
        b=eTW3zjpT1WIjsMlkvtPWk3iuvH4M6c0aB/STfDGH+uOvxndDYHB+q1Zv8uoNDw+bJT
         xlfI0MvnmZQVTjvflJtOp5wzlTNSBBmvdy/YmngTxC0Ogbkh104la/SJTQynbn0xS/O8
         h98whmBNLOP8JhJJvg+DN6XM0R5dN4XvCH/i2qADc95gYjOjysXILYgShwaKYzgZ7pep
         6uVwK9dvmYiFrnTCYJPy2fUCLi8pHyvooBg1j1Ey5QSlReHC4m1ROsdsSApiBQL+Q2UM
         LmWKMg8xgu82OUXZzrons1QrEXmCu/YtJJuJ3iC9X388LdkwmcI9gzzbrDuGEs/7eJv6
         yUmA==
X-Gm-Message-State: AJcUukfBLaBt9MxJbKHouVYl7e+rs7Tbpih8wg8A1UMrbgsHSvaK2HmP
        FzlwU5Pqa/xTxCHuD/mxJknoWabDB+aCDyl3KYtO
X-Google-Smtp-Source: ALg8bN58NdADCSbwBsSitl11bmMO8mTWvXaJcyhzucBmEvqWVYnyHPbVlIttdx+gRzs/CBmBuMUcyZIsVJTGSDGWb+K3
X-Received: by 2002:ac8:320a:: with SMTP id x10mr47884037qta.30.1546912595653;
 Mon, 07 Jan 2019 17:56:35 -0800 (PST)
Date:   Mon,  7 Jan 2019 17:56:31 -0800
In-Reply-To: <20181210234030.176178-2-matvore@google.com>
Message-Id: <20190108015631.22727-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181210234030.176178-2-matvore@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v2 1/2] list-objects-filter: teach tree:# how to handle >0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, sbeller@google.com, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks - as stated in your commit message, this adds quite a useful
piece of functionality.

> -	case LOFS_BEGIN_TREE:
> -	case LOFS_BLOB:
> -		if (filter_data->omits) {
> -			oidset_insert(filter_data->omits, &obj->oid);
> -			/* _MARK_SEEN but not _DO_SHOW (hard omit) */
> -			return LOFR_MARK_SEEN;
> -		} else {
> -			/*
> -			 * Not collecting omits so no need to to traverse tree.
> -			 */
> -			return LOFR_SKIP_TREE | LOFR_MARK_SEEN;
> -		}
> -
>  	case LOFS_END_TREE:
>  		assert(obj->type == OBJ_TREE);
> +		filter_data->current_depth--;
>  		return LOFR_ZERO;
>  
> +	case LOFS_BLOB:
> +		filter_trees_update_omits(obj, filter_data, include_it);
> +		return include_it ? LOFR_MARK_SEEN | LOFR_DO_SHOW : LOFR_ZERO;

Any reason for moving "case LOFS_BLOB" (and "case LOFS_BEGIN_TREE"
below) after LOFS_END_TREE?

This is drastically different from the previous case, but this makes
sense - previously, all blobs accessed through traversal were not shown,
but now they are sometimes shown. Here, filter_trees_update_omits() is
only ever used to remove a blob from the omits set, since once this blob
is encountered with include_it == true, it is marked as LOFR_MARK_SEEN
and will not be traversed again.

> +	case LOFS_BEGIN_TREE:
> +		seen_info = oidmap_get(
> +			&filter_data->seen_at_depth, &obj->oid);
> +		if (!seen_info) {
> +			seen_info = xcalloc(1, sizeof(struct seen_map_entry));

Use sizeof(*seen_info).

> +			seen_info->base.oid = obj->oid;

We have been using oidcpy, but come to think of it, I'm not sure why...

> +			seen_info->depth = filter_data->current_depth;
> +			oidmap_put(&filter_data->seen_at_depth, seen_info);
> +			already_seen = 0;
> +		} else
> +			already_seen =
> +				filter_data->current_depth >= seen_info->depth;

There has been recently some clarification that if one branch of an
if/else construct requires braces, braces should be put on all of them:
1797dc5176 ("CodingGuidelines: clarify multi-line brace style",
2017-01-17). Likewise below.

> +		if (already_seen)
> +			filter_res = LOFR_SKIP_TREE;
> +		else {
> +			seen_info->depth = filter_data->current_depth;
> +			filter_trees_update_omits(obj, filter_data, include_it);
> +
> +			if (include_it)
> +				filter_res = LOFR_DO_SHOW;
> +			else if (filter_data->omits)
> +				filter_res = LOFR_ZERO;
> +			else
> +				filter_res = LOFR_SKIP_TREE;

Looks straightforward. If we have already seen it at a shallower or
equal depth, we can skip it (since we have already done the appropriate
processing). Otherwise, we need to ensure that its "omit" is correctly
set, and:
 - show it if include_it
 - don't do anything special if not include_it and we need the omit set
 - skip the tree if not include_it and we don't need the omit set

> +static void filter_trees_free(void *filter_data) {
> +	struct filter_trees_depth_data* d = filter_data;
> +	oidmap_free(&d->seen_at_depth, 1);
> +	free(d);
> +}

Check for NULL-ness of filter_data too, to match the usual behavior of
free functions.

> diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
> index eb32505a6e..54e7096d40 100755
> --- a/t/t6112-rev-list-filters-objects.sh
> +++ b/t/t6112-rev-list-filters-objects.sh

[snip]

Thanks for the tests that cover quite a wide range of cases. Can you
also demonstrate the case where a blob would normally be omitted
(because it is too deep) but it is directly specified, so it is
included.

> +expect_has_with_different_name () {
> +	repo=$1 &&
> +	name=$2 &&
> +
> +	hash=$(git -C $repo rev-parse HEAD:$name) &&
> +	! grep "^$hash $name$" actual &&
> +	grep "^$hash " actual &&
> +	! grep "~$hash" actual
> +}

Should we also check that a "~" entry appears with $name?
