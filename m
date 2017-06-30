Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41E6201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 21:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752957AbdF3VLi (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 17:11:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34777 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752830AbdF3VLi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 17:11:38 -0400
Received: by mail-pf0-f193.google.com with SMTP id c24so3676545pfe.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 14:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HWq0NVPaWIyTC7SVon5/dQsGOdYo5uBd266JFVrRyME=;
        b=X4wHfIE2O4M6OwmK1SGSqwZobGFeY0rV4K+ssylWhsT+J0FfKMGPu8Thk6LmSHfD+U
         AXrhT5vWGKA55szODzKPE7yup9E7eKJmD/4YCb77+gOGP2sbPsg4LFGd+J+LyYowd4g2
         HV7e2q/MXxqWfh+Bn7ebxWqIFGxses6lYjOheHtiUdVOkYbhV4s9Jx9msBKfwHXoYcGb
         vCLlbVGCUGm74kssKTORIzNSPN9sqgB8mY1JBC6a6o/j/hEBDnmyzosbcfowk6zv+gjw
         1O1o1hPcIm7rm+5h+yzhlDnllti7bK4rjvb2UVMRoMYt+sopxD+vPzPkuykX0PRiL3NJ
         XIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HWq0NVPaWIyTC7SVon5/dQsGOdYo5uBd266JFVrRyME=;
        b=KWKhiIYtInkgwqqQvsFe5XEtMUYmxpRFvcT0tMxSgiKb7JmCjZkw9NS3kvLkXLPwL+
         Ko/wxbmOf9lJALoRU2Dk+9aOpehCDSLh1SImhrcBGTktFEyLw4tLLOmda3RyAfifgHo3
         p3LY4ptEyGZpU+dnfP0QzWgXi6M0ceHGPmZaYLRwLYTSdmXOIRbul2SsP7n/KauhjFgC
         p0V/jVtOnXSp1OPAfuxnESk0U3zWIp6qmVqNuhdfd7R+ulCRIHnrgG005zhcNNsNskG0
         A4Pmr+xVBSsDraLkd7mXA/QGwfKZ5sMBZkqF4rnmUsEB6tbnDnIBUD4xUmspaIUPGx7J
         PCGA==
X-Gm-Message-State: AKS2vOys9Qbn9hrfcVpUC+7Kbi3APfsBpuNeEiLXFIDqlxV/Xr0udYFq
        +gzni2hTPrr7+A==
X-Received: by 10.98.23.3 with SMTP id 3mr24572903pfx.55.1498857097362;
        Fri, 30 Jun 2017 14:11:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id o8sm15044592pgn.52.2017.06.30.14.11.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 14:11:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, simon@ruderich.org
Subject: Re: [PATCHv2 22/25] diff.c: color moved lines differently
References: <20170630000710.10601-1-sbeller@google.com>
        <20170630205310.7380-1-sbeller@google.com>
        <20170630205310.7380-23-sbeller@google.com>
Date:   Fri, 30 Jun 2017 14:11:35 -0700
In-Reply-To: <20170630205310.7380-23-sbeller@google.com> (Stefan Beller's
        message of "Fri, 30 Jun 2017 13:53:07 -0700")
Message-ID: <xmqq1sq1qiyg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +static int next_byte(const char **cp, const char **endp,
> +		     const struct diff_options *diffopt)
> +{
> +	int retval;
> +
> +	if (*cp > *endp)
> +		return -1;
> +
> +	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_CHANGE)) {
> +		while (*cp < *endp && isspace(**cp))
> +			(*cp)++;
> +		/*
> +		 * After skipping a couple of whitespaces, we still have to
> +		 * account for one space.
> +		 */
> +		return (int)' ';

Do we need a cast here?

> +static unsigned get_string_hash(struct emitted_diff_symbol *es, struct diff_options *o)
> +{
> +	if (o->xdl_opts & XDF_WHITESPACE_FLAGS) {
> +		static struct strbuf sb = STRBUF_INIT;
> +		const char *ap = es->line, *ae = es->line + es->len;
> +		int c;
> +
> +		strbuf_reset(&sb);
> +		while (ae > ap && isspace(*ae))
> +			ae--;

Not testing for the AT_EOL option here?  

It does not make a difference in correctness; two lines that differ
only by their trailing whitespaces will be hashed into the same bin
even when we are not using ignore-whitespace-at-eol, making the 
hashmap a bit less efficient than necessary.

By the way, this is an unrelated tangent because I think you
inherited this pattern by copying and pasting from elsewhere, but I
think it would be better if we avoid casting the function pointer
type like this:

> +		if (o->color_moved) {
> +			struct hashmap add_lines, del_lines;
> +
> +			hashmap_init(&del_lines,
> +				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);
> +			hashmap_init(&add_lines,
> +				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);

When hashmap_cmp_fn's definition changes, these two calling sites
won't be caught as passing a incorrectly typed callback function by
the compiler.

Instead, we can match the actual implementation of the callback
function, e.g.

> +static int moved_entry_cmp(const struct diff_options *diffopt,
> +			   const struct moved_entry *a,
> +			   const struct moved_entry *b,
> +			   const void *keydata)
> +{

to the expected function type, i.e.

static int moved_entry_cmp(const void *fndata,
			   const void *entry, const void *entry_or_key,
			   const void *keydata)
{
	const struct diff_options *diffopt = fndata;
	const struct moved_entry *a = entry;
	const struct moved_entry *b = entry_or_key;
	...

by casting the parameters.
