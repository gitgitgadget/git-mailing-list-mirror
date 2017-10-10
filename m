Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC18F2036B
	for <e@80x24.org>; Tue, 10 Oct 2017 18:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932499AbdJJSYT (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 14:24:19 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:46849 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932488AbdJJSYS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 14:24:18 -0400
Received: by mail-pf0-f176.google.com with SMTP id p87so9043728pfj.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 11:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5FuzXcRoyfRXU0frAMaC+C0I2lgh5HMWJSKvs1OlwIA=;
        b=QDL3fv8YuaWc2J5o75OrolhaeVVhn0VIcmzQ99A6qjIUQ4xrj+nPbPExZgigxY7cRB
         vCY17MzWBnYe2qbks2/ohEqMfoC0PfPlAdzNIrfKgvEQL0Qd8R9AMRwMNZMz/kgB9KHU
         hQasRi3lC+/fJhLM2B1lYN4RLt6VBCHxOanP173a5oI3dZUXsc6c/CtI52Z3dP/QNnNl
         6vI8qzA8eFgREtegK1yvAglLDni3Gm4T8fQyax9sleg4JgsSzWhav72DARB0u4hTUTlJ
         o/hPvqAEvRT4RKJCki6gVuMDftfJ/0qAOnidBhhfp++qTGbWtL2MdCQmkg8Vd8kOvqHi
         iKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5FuzXcRoyfRXU0frAMaC+C0I2lgh5HMWJSKvs1OlwIA=;
        b=E2dV0XDFjJwZyaDjXGc+nJnteirp2fcQgnqGRlg9u41O3z4wU1HPhIIlLglMafqJYb
         lQVBR3CI2rK9M9xvayZ75RubKMwyQsqfm3QdJIa1K+CS/opKd/Y1bPkPEPBLkxecA1lP
         rlN2VkYc+MIp4HBuzlLPXdh3WR6iyEQfCbwiXli5Kfyz2XKBMOPw+Mkhp1HS4yBGqy0S
         8kNMxDqjhf8rJAONcFEOEmMdd21+vycaoKuf+hH62+c9rg4ci53eint+YqJyN+pHbxFn
         G/SEDj43Jp+sFeD1zS25HiT3YMSSQSOxfr8JBJuZM9HouRhHH/pRkztn6Ja4CajX09N1
         EiOg==
X-Gm-Message-State: AMCzsaVgqTaGEpCj6T2yn1JjB5pzShpAYh4TOpp3asxhgau2QT0LICmQ
        jcqbLGYmrXxs2zeUpeBpJwUNLQ==
X-Google-Smtp-Source: AOwi7QD3A5Lz7X8NUagp2EhMm8STtaxaKTL2I4919SfH9KX9eebI3wTSndCKQyxwJXgoXnt8l36q4Q==
X-Received: by 10.99.108.132 with SMTP id h126mr12982107pgc.434.1507659857492;
        Tue, 10 Oct 2017 11:24:17 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:961:a8fe:b03f:d840])
        by smtp.gmail.com with ESMTPSA id f131sm22954545pfc.27.2017.10.10.11.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2017 11:24:16 -0700 (PDT)
Date:   Tue, 10 Oct 2017 11:24:16 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 04/10] daemon: recognize hidden request arguments
Message-Id: <20171010112416.107a7325cef61cd2425d6204@google.com>
In-Reply-To: <20171003201507.3589-5-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-5-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  3 Oct 2017 13:15:01 -0700
Brandon Williams <bmwill@google.com> wrote:

>  /*
>   * Read the host as supplied by the client connection.

The return value is probably worth documenting. Something like "Returns
a pointer to the character *after* the NUL byte terminating the host
argument, or extra_args if there is no host argument."

>   */
> -static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
> +static char *parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)

[snip]

> +static void parse_extra_args(struct hostinfo *hi, struct argv_array *env,
> +			     char *extra_args, int buflen)
> +{
> +	const char *end = extra_args + buflen;
> +	struct strbuf git_protocol = STRBUF_INIT;
> +
> +	/* First look for the host argument */
> +	extra_args = parse_host_arg(hi, extra_args, buflen);

This works, but is a bit loose in what it accepts. I think it's better
to be tighter - in particular, if there is no host argument, we
shouldn't be looking for extra args.

> +
> +	/* Look for additional arguments places after a second NUL byte */
> +	for (; extra_args < end; extra_args += strlen(extra_args) + 1) {

Assuming that the host argument exists, this for loop should start at
extra_args + 1 to skip the second NUL byte. This currently works
because this code is lenient towards empty strings.

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

But I think we shouldn't be lenient towards empty strings.

> +
> +	if (git_protocol.len > 0)
> +		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
> +				 git_protocol.buf);
> +	strbuf_release(&git_protocol);
>  }
