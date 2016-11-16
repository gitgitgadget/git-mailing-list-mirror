Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96DD72021E
	for <e@80x24.org>; Wed, 16 Nov 2016 00:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935293AbcKPAZX (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 19:25:23 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33800 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932783AbcKPAZW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 19:25:22 -0500
Received: by mail-pf0-f176.google.com with SMTP id c4so26971286pfb.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 16:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ve9TI4kTB5roLwx0XeUNIjnhtUsOGOyd9KvYJruqcRU=;
        b=KcjKsGL4vyB6gCmi0tImjKa8d/0NHOqgPxA0MIzijGd/poB9rHCaXpeIwNrEmJNG6B
         eDLDg/N6rVT60/Isyc/RWzk1oWYFO2OOJzbB63uQh50Z/klwOT1PyWDse3cQht7SXGMY
         ZE0kLCw3OvhF3APMLWmBZHcR29yzTjv8LpuZgZksXRyPr1y8WMzBAWVrANjYIOekiEUq
         StBlYViwLp4sguxE0FSBjvhwXsifSCKaUTSnXJaox33irvnTvQy48HTKY1unNRqfGQNK
         XUyRUHaa7L+/e/2sDoXiKi2y9U+b2xj/5tqTNs4BSXvtKnf+YFgV3x9IgCNI5sD/EtH4
         BAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ve9TI4kTB5roLwx0XeUNIjnhtUsOGOyd9KvYJruqcRU=;
        b=S6og/LIsbCQel3nOoywW5gCwSywkb9VCvTOo5fzdwvxEYuESNh4/7U9SMKJql7ETbY
         KRTdqeEq4Yu2Rlc6NkfTTJfvIDxliUdm54WQA8fb8ZAE6GVzTIxzbcZa5FyKhimI8rHb
         PmIq4C2kxFupNnAF8dN0MEOHHfbwq4UzRSDNw0WOOLKCk2MFazAkJbsSOFJ4wVJyx0Vw
         bluTwieo8BFaxTF3TyYBm6xulHPrFi5nXO4uEhdtf6b5V80LHgT03NWJV2ABHwnyjt04
         U99/Bn0aNGAzr9oUp2jLuJnqNG1Nw+FXAViPfIbXY7Cjn48+l55Jvl/+wuTg8fyyObsK
         xgAg==
X-Gm-Message-State: ABUngvelLBWNquhZ7PbbUHynEnluOTSg7ChpTMk0jUPcyLP/kDeuvZ1YpEc7WGxBntkuFVrf
X-Received: by 10.99.135.200 with SMTP id i191mr1796559pge.18.1479255922009;
        Tue, 15 Nov 2016 16:25:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f0a8:aad3:5a98:9829])
        by smtp.gmail.com with ESMTPSA id d1sm46595506pfb.76.2016.11.15.16.25.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 16:25:21 -0800 (PST)
Date:   Tue, 15 Nov 2016 16:25:20 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        mogulguy10@gmail.com, David.Turner@twosigma.com
Subject: Re: [PATCH 13/16] submodule: teach unpack_trees() to update
 submodules
Message-ID: <20161116002520.GI66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-14-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161115230651.23953-14-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15, Stefan Beller wrote:
> +		if (!S_ISGITLINK(ce->ce_mode)) {
> +			int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;

For readability you may want to have spaces between the two flags

> +	if (o->index_only
> +	    || (!((old->ce_flags & CE_VALID) || ce_skip_worktree(old))
> +		&& (o->reset || ce_uptodate(old))))
> +		return 0;

The coding guidelines say that git prefers to have the logical operators
on the right side like this:

if (o->index_only ||
    (!((old->ce_flags & CE_VALID) || ce_skip_worktree(old))	&&
     (o->reset || ce_uptodate(old))))
	return 0;

It also says the other way is ok too, just a thought :)

> +				if (submodule_is_interesting(old->name, null_sha1)
> +				    && is_submodule_checkout_safe(new->name, &new->oid))
> +					return 0;

here too.

> +			} else {
> +				/*
> +				 * new is not a submodule any more, so only
> +				 * care if we care:
> +				 */
> +				if (submodule_is_interesting(old->name, null_sha1)
> +				    && ok_to_remove_submodule(old->name))
> +					return 0;

and here

-- 
Brandon Williams
