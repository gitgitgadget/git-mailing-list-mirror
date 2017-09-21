Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5147202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 00:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbdIUAYt (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 20:24:49 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:56792 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdIUAYs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 20:24:48 -0400
Received: by mail-pf0-f178.google.com with SMTP id g65so2346760pfe.13
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 17:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7PFDwhQkn5AAw0ULAj3tj33QyZgy4Sk9gTefZoj1rk=;
        b=mU7O/px8wlucnIemDDMKaLTguk1lL94go3WDpsmAw57sgideiVO3mCgV+ZojWMjx7W
         B6K0C4THDzgeivqawefDcA5h1o4NXBstWhzjEV2vmaFDxUkck7tI372VczPiYK+xz7Jm
         Hosfko8FIv29ACqKOY69VQIl+QqJvcL8KGNLqXI6jjvgG9QOEUPRLcGkzdj5hNXMqMn4
         5PLoyu3I1aOnBbRqyiDN6duRN5+CZVCodvkZ3IyllkCxDJCe2ffyPTSUneYoXQY/qTXu
         GqRan1JTTP/GQffOPTOzHUVnEUatqfNyUlJBifurSdUCSVq8rCTDVx9rpqwXKCmwHsn0
         TI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y7PFDwhQkn5AAw0ULAj3tj33QyZgy4Sk9gTefZoj1rk=;
        b=tRa86C4Sl22hAHlOIlnOeC0UBwZ6gBsAOknR9W3X2oa4GbmbQn6xGJrGIO3qFmHiIe
         tXnI1bywsqBAzyFHEcqTtXcnUxLo/0401C2Zzl+QgCvkxOwj3yuNnAt+nTOOgnbjHJ7D
         QjmnEywPjhWvDhyrrmxpvFBsjzPuISM71JvxoE3jQPDrkE3qk+JF23OgiRlqnZllvUM8
         YkfIsVf9/Tv7ZvU7ZsN5jr2f2rxSP5Q0nOFUXI2gJfF+JXUq1ZpjctHLjIKX6EwArXLk
         9stloxrUiLMxqSuav2yurXxUMnFYCqnfkW16VuRiLpWjcFcXeuCO20O8nshRabiwcV0T
         rjPQ==
X-Gm-Message-State: AHPjjUh5Ldext5tUJn8Q9//s9ikd/WpGvzMQdc0BZKxLmk2kt7XM5IYU
        YsZv7OiTMDQNv1ULG4UE86wV9A==
X-Google-Smtp-Source: AOwi7QAIxO2Asj0doqhMP2Om4oZnewg7J/NYMHxAH3M+sTu4HWy3HDy1y0+VXuyOqy+3lcoHB3VIZQ==
X-Received: by 10.159.204.140 with SMTP id t12mr3809394plo.192.1505953487673;
        Wed, 20 Sep 2017 17:24:47 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:9912:5681:f7d0:a00c])
        by smtp.gmail.com with ESMTPSA id z69sm141223pfl.86.2017.09.20.17.24.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 17:24:47 -0700 (PDT)
Date:   Wed, 20 Sep 2017 17:24:43 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        gitster@pobox.com, jrnieder@gmail.com, bturner@atlassian.com,
        git@jeffhostetler.com
Subject: Re: [PATCH 3/8] daemon: recognize hidden request arguments
Message-ID: <20170920172443.6b42c9ba@twelve2.svl.corp.google.com>
In-Reply-To: <20170913215448.84674-4-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
        <20170913215448.84674-4-bmwill@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 Sep 2017 14:54:43 -0700
Brandon Williams <bmwill@google.com> wrote:

> A normal request to git-daemon is structured as
> "command path/to/repo\0host=..\0" and due to a bug in an old version of
> git-daemon 73bb33a94 (daemon: Strictly parse the "extra arg" part of the
> command, 2009-06-04) we aren't able to place any extra args (separated
> by NULs) besides the host.
> 
> In order to get around this limitation teach git-daemon to recognize
> additional request arguments hidden behind a second NUL byte.  Requests
> can then be structured like:
> "command path/to/repo\0host=..\0\0version=1\0key=value\0".  git-daemon
> can then parse out the extra arguments and set 'GIT_PROTOCOL'
> accordingly.

A test in this patch (if possible) would be nice, but it is probably
clearer to test this when one of the commands (e.g. upload-pack) is
done. Could a test be added to the next patch to verify (using
GIT_TRACE_PACKET, maybe) that the expected strings are sent? Then
mention in this commit message that this will be tested in the next
patch too.

> @@ -574,7 +583,7 @@ static void canonicalize_client(struct strbuf *out, const char *in)
>  /*
>   * Read the host as supplied by the client connection.
>   */
> -static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
> +static char *parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
>  {
>  	char *val;
>  	int vallen;
> @@ -602,6 +611,39 @@ static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
>  		if (extra_args < end && *extra_args)
>  			die("Invalid request");
>  	}
> +
> +	return extra_args;
> +}
> +
> +static void parse_extra_args(struct argv_array *env, const char *extra_args,
> +			     int buflen)
> +{
> +	const char *end = extra_args + buflen;
> +	struct strbuf git_protocol = STRBUF_INIT;
> +
> +	for (; extra_args < end; extra_args += strlen(extra_args) + 1) {
> +		const char *arg = extra_args;
> +
> +		/*
> +		 * Parse the extra arguments, adding most to 'git_protocol'
> +		 * which will be used to set the 'GIT_PROTOCOL' envvar in the
> +		 * service that will be run.
> +		 *
> +		 * If there ends up being a particular arg in the future that
> +		 * git-daemon needs to parse specificly (like the 'host' arg)
> +		 * then it can be parsed here and not added to 'git_protocol'.
> +		 */
> +		if (*arg) {
> +			if (git_protocol.len > 0)
> +				strbuf_addch(&git_protocol, ':');
> +			strbuf_addstr(&git_protocol, arg);
> +		}
> +	}
> +
> +	if (git_protocol.len > 0)
> +		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
> +				 git_protocol.buf);
> +	strbuf_release(&git_protocol);
>  }

I would rewrite this with parse_extra_args() calling parse_host_arg()
instead (right now, you have 2 functions with 2 different meanings of
"extra_args"). If you want to keep this arrangement, though, add a
documentation comment about the meaning of the return value of
parse_host_arg().
