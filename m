Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C85201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 17:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbdF3RyW (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 13:54:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33350 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752340AbdF3RyV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 13:54:21 -0400
Received: by mail-pf0-f194.google.com with SMTP id e199so17806055pfh.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DNs4K4wXrKSaGKS9/LjbtQFAAsOSuKS0ghFU8wAQSps=;
        b=okF7Q6R3x2zqj6IohPoMbRlDhCy8Qz1vxG+nx75ggDz8pxGxsPBRrqP6L94g20xeBb
         ckpW3DfM+Mhs1SnAxRAAO0uWx3UmenB56BpOA0deBfqJYvtxDKV+e6h4Z0WfZTfZ0xy+
         lcj8JVegM0dAYsn0xKUU+q9iZazF0VZCIb8BgLUTQEhwnOpb9fCOIhFoSYiUsKhTIKwB
         adHh+SkQQhLFoRBmqA+R80r1aNs0p8zg6AD1F2bVIhzR014CNnQbMsFUtJyh4vA0f1PP
         BcyjfODWqaIyMBlLh1L+8n6rG8wSAtmX+1gcg8ETQdOyPdJw97aVy4yrQcNqsfmwrAN/
         79sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DNs4K4wXrKSaGKS9/LjbtQFAAsOSuKS0ghFU8wAQSps=;
        b=YvTlKKoGSFDGJErw61WoUzEoroBbfyCDDGaz817PYgEns1pm3sZ6p9A9sNaIg8WFsk
         XULtIvqYlKg6buH4Kb75z4HDaUuZ3tIb1tKiiWXulW0ziQI1BUTpy3OMcQz03KhRjJGa
         gW4JfUjbX3Y48x5oq64JmjmwpPl/yul4UriiuK8RAyCWYfuRK+0G3xTWvYPxKXnUNuqP
         l+u6oJC4h8M3aIsPd8gFG+OQTB0ma9I9YXeadyEZQql3WzqW3M/j1wtgaRn3VPlr4YGj
         F8JEtu+cNW1lkwAkn4/sw7fR99SmzJiAhr6ICGbL3rz1Wohj7fdFyHh5ZhyVzY7I5Ais
         /Icw==
X-Gm-Message-State: AKS2vOxwrp9YtXriwxKYvrOokkCTRqOxLFOhtlYy5G0fNBc7cmyCPMoD
        GmLbzLiSWCALKjS5yic=
X-Received: by 10.99.104.136 with SMTP id d130mr22073136pgc.236.1498845260966;
        Fri, 30 Jun 2017 10:54:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id d89sm19882177pfl.7.2017.06.30.10.54.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 10:54:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 22/25] diff.c: color moved lines differently
References: <20170630000710.10601-1-sbeller@google.com>
        <20170630000710.10601-23-sbeller@google.com>
Date:   Fri, 30 Jun 2017 10:54:19 -0700
In-Reply-To: <20170630000710.10601-23-sbeller@google.com> (Stefan Beller's
        message of "Thu, 29 Jun 2017 17:07:07 -0700")
Message-ID: <xmqqd19ls6no.fsf@gitster.mtv.corp.google.com>
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
> +	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_AT_EOL)) {
> +		while (*endp > *cp && isspace(**endp))
> +			(*endp)--;
> +	}

This should be done by the callers (both moved_entry_cmp() and
get_string_hash()) before starting to iterate over the bytes from
the beginning, no?

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
> +	}
> +
> +	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE)) {
> +		while (*cp < *endp && isspace(**cp))
> +			(*cp)++;
> +		/* return the first non-ws character via the usual below */
> +	}
> +
> +	retval = **cp;

The char could be signed, and byte 0xff may become indistinguishable
from the EOF (i.e. -1) you returned earlier.

> +	(*cp)++; /* advance */
> +	return retval;
> +}
> +
> +static int moved_entry_cmp(const struct moved_entry *a,
> +			   const struct moved_entry *b,
> +			   const void *keydata,
> +			   const void *data)
> +{
> +	const struct diff_options *diffopt = data;
> +	const char *ap = a->es->line, *ae = a->es->line + a->es->len;
> +	const char *bp = b->es->line, *be = b->es->line + b->es->len;
> +
> +	if (!(diffopt->xdl_opts & XDF_WHITESPACE_FLAGS))
> +		return a->es->len != b->es->len  || memcmp(ap, bp, a->es->len);
> +
> +	while (1) {
> +		int ca, cb;
> +		ca = next_byte(&ap, &ae, diffopt);
> +		cb = next_byte(&bp, &be, diffopt);
> +		if (ca != cb)
> +			return 1; /* differs */
> +		if (!ca)

Shouldn't this check for "ca == -1", as we are not dealing with NUL
terminated string but a <ptr, len> thing?

> +			return 0;
> +	};
> +}
> +
> +static unsigned get_string_hash(struct emitted_diff_symbol *es, struct diff_options *o)
> +{
> +	if (o->xdl_opts & XDF_WHITESPACE_FLAGS) {
> +		static struct strbuf sb = STRBUF_INIT;
> +		const char *ap = es->line, *ae = es->line + es->len;
> +		int c;
> +
> +		strbuf_reset(&sb);
> +		while ((c = next_byte(&ap, &ae, o)) > 0)
> +			strbuf_addch(&sb, c);
> +
> +		return memhash(sb.buf, sb.len);
> +	} else {
> +		return memhash(es->line, es->len);
> +	}
> +}
