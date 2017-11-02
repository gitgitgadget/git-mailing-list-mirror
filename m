Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B71E20281
	for <e@80x24.org>; Thu,  2 Nov 2017 22:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934595AbdKBWYa (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 18:24:30 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:53002 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934407AbdKBWYa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 18:24:30 -0400
Received: by mail-io0-f174.google.com with SMTP id f20so2337813ioj.9
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wEzhTyhJZR0pRx6hJJArotrwrNSKqMy/B6iiWJbrHos=;
        b=ER1ZIFgPDbsZc+M37FrWvzOqfw2xsZIMKELO+wJRw5GjYG9A/toK82czo/qPO4F5fi
         RDKHYTYD4vjb/QQNKECK9/IG2vgm1PkBdU//+GbmqI88nXvVS+jYMKN2w0GEEm78X4OO
         ZdyPh9SVM0zhyur21Fm+0yTNpPD+8z2nu0DuT5IlK36k7QTkZFE5bWK6/w69IsqGg25C
         dS+VG3RQ87cn9CJEgkhpwc1cuZWGLKt4gt3NYS0VrJDIo6jwDlHF6j0Yv2VHioveT6NM
         uftETMOlPhSawn+liFmwzyKQiMvrhYcyYsMqKQi66ryLxFEkYRfKen7M66gWYskU9Fvk
         otvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEzhTyhJZR0pRx6hJJArotrwrNSKqMy/B6iiWJbrHos=;
        b=ZtjXBZZSoBZTSqCbeZ6JcWsu1y4XBDwJsYBN75YkHhKkyB5CQh1Q9PWTkeRu7Ynm+9
         4Jegqbl1ZOjw6xDZB8hRZgCrF4fS0LmJ2jgV2UnGyyIcGyCqZy8IIEe7iEg5Y89mOROA
         A1kocdUidpHi+a5soeZcuu+K2f6gA0Iemea/mgz7ZK0RsGEXxprLd5/B+po6ffjT9jMj
         sdF/cdwuaadMySrNqzO3SiVeA11y8XLr96GmdoVK6PaawxhaXWEDsMNXZ598pU4VI1k5
         GgNAZaUxsvdGn0zHo0yY1MBtfgCat+nKncLnKD3UHDr4U/I7pdSm9eNabwo/kSbjTLp+
         LF7A==
X-Gm-Message-State: AJaThX4YHBydFoxqDj7N92OweC9j23z8vYYK2x9/HBij3HBN1VV3UJSU
        vzT3gKmQVpzi/nyFVH1lHsAgSM5SaAc=
X-Google-Smtp-Source: ABhQp+QHhvIB8C+EgNdnaPGmjB4f2PGxtWvWmJvmzSMd/vf0v0g6kDvg2fnkRYA6J61oUM0hxq7+ww==
X-Received: by 10.36.215.3 with SMTP id y3mr1956429itg.22.1509661469109;
        Thu, 02 Nov 2017 15:24:29 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:2131:f64d:d486:a16f])
        by smtp.gmail.com with ESMTPSA id 137sm322600itb.42.2017.11.02.15.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2017 15:24:28 -0700 (PDT)
Date:   Thu, 2 Nov 2017 15:24:27 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/9] extension.partialclone: introduce partial clone
 extension
Message-Id: <20171102152427.32544b3d6149e7a7bfe840c8@google.com>
In-Reply-To: <20171102202052.58762-2-git@jeffhostetler.com>
References: <20171102202052.58762-1-git@jeffhostetler.com>
        <20171102202052.58762-2-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  2 Nov 2017 20:20:44 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Introduce the ability to have missing objects in a repo.  This
> functionality is guarded by new repository extension options:
>     `extensions.partialcloneremote` and
>     `extensions.partialclonefilter`.

With this, it is unclear what happens if extensions.partialcloneremote
is not set but extensions.partialclonefilter is set. For something as
significant as a repository extension (which Git uses to determine if it
will even attempt to interact with a repo), I think - I would prefer
just extensions.partialclone (or extensions.partialcloneremote, though I
prefer the former) which determines the remote (the important part,
which controls the dynamic object fetching), and have another option
"core.partialclonefilter" which is only useful if
"extensions.partialclone" is set.

I also don't think extensions.partialclonefilter (or
core.partialclonefilter, if we use my suggestion) needs to be introduced
so early in the patch set when it will only be used once we start
fetching/cloning.

> +void partial_clone_utils_register(
> +	const struct list_objects_filter_options *filter_options,
> +	const char *remote,
> +	const char *cmd_name)
> +{

This function is useful once we have fetch/clone, but probably not
before that. Since the fetch/clone patches are several patches ahead,
could this be moved there?

> @@ -420,6 +420,19 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
>  			;
>  		else if (!strcmp(ext, "preciousobjects"))
>  			data->precious_objects = git_config_bool(var, value);
> +
> +		else if (!strcmp(ext, KEY_PARTIALCLONEREMOTE))
> +			if (!value)
> +				return config_error_nonbool(var);
> +			else
> +				data->partial_clone_remote = xstrdup(value);
> +
> +		else if (!strcmp(ext, KEY_PARTIALCLONEFILTER))
> +			if (!value)
> +				return config_error_nonbool(var);
> +			else
> +				data->partial_clone_filter = xstrdup(value);
> +
>  		else
>  			string_list_append(&data->unknown_extensions, ext);
>  	} else if (strcmp(var, "core.bare") == 0) {

With a complicated block, probably better to use braces in these
clauses.
