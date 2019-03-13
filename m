Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC442202BB
	for <e@80x24.org>; Wed, 13 Mar 2019 04:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfCMEJa (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 00:09:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34785 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfCMEJa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 00:09:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id f14so364744wrg.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 21:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NcDPqfZtbq73kMu+Fgn83K/YJVSFG0NqW0Tc1/jI3hg=;
        b=MsG0IS3xnLrQ4FnltGPjtkiq3lbba2I8iaeJTNFSjpm9aCxIPr3tO4wHysZdUV+4Vl
         yGB+OEInMUdZF82cuOMQPnrXKVz6tLK3czzXn0nkkWy/r6Z9oSfgVzouNc0clDHSPRRz
         BFBfW53JuKolkzW0ygw2w0U8MwdELp4UWR0eluMAn28YbAcD+amGgqUg3KcRQXkTG0HS
         HMCU90kdpUVj+GUdN3CLAqIC/bhgn90O8AaqObNVeK5uaI2J60pKz8Xetx7EmB7vqEAN
         qT4nhhRbmWh3T0shEClxAQPAKGvukC68TIIQtGKKsiXIy3zPGgb8WKR1q/Zq/dSuSb4A
         H2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NcDPqfZtbq73kMu+Fgn83K/YJVSFG0NqW0Tc1/jI3hg=;
        b=G3srAJhwhoALdMXgfpMQ+WmP7k3JWpIjTa6QmCfE7Ey2lv5mwDsRPFeCjYsam9ZDN5
         ZrmheKgVB0sx/zu/DOvmWz3EyCYzdIPAlq23LUDXUKoDieewcXOLfYH1GtNw72dm6qmM
         gOJspRntpZ6Zhg0lmW7bHUXDOxWbLh5hECywyFNveSvOu0wYtnKutjmooRHpKA1/jFeY
         HNvkejxWevWLD2uV3b/MUbPbAiEyTigwa8Zk8LIC8FGIF3rxoX+GsKPpRV2AsbPMUegr
         BTx7TBe74QJxX00mLovJvwJdKK+iqOR65236Vn+bZuPQnzTDk/eP8IeaMl6ZpVYWPX37
         lPOA==
X-Gm-Message-State: APjAAAWCglGIZrs0Rnh+VV/sxPT5c+31HcMpAWfNsffgB9n9AgB/1tCU
        qP7ojTxJc9bTYFZGVB43PlIK7EZhUZs=
X-Google-Smtp-Source: APXvYqwWWuBeHhPFruLKybO5wp3acSTP0/EPOiZDNxeNt+K+AeSS/cJOMLicvtpJx9j9xTAAfY/brg==
X-Received: by 2002:adf:e38b:: with SMTP id e11mr10273333wrm.113.1552450167661;
        Tue, 12 Mar 2019 21:09:27 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o12sm32875532wre.0.2019.03.12.21.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 21:09:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v3 02/11] Add initial support for many promisor remotes
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
        <20190312132959.11764-3-chriscool@tuxfamily.org>
Date:   Wed, 13 Mar 2019 13:09:24 +0900
In-Reply-To: <20190312132959.11764-3-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 12 Mar 2019 14:29:50 +0100")
Message-ID: <xmqqtvg7e7pn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +struct promisor_remote *promisor_remote_new(const char *remote_name)
> +{

Shouldn't this be static?  The config callback that calls this
function is inside this file.

> +	struct promisor_remote *o;
> +
> +	o = xcalloc(1, sizeof(*o));
> +	o->remote_name = xstrdup(remote_name);

A comment on this later...

> +static struct promisor_remote *promisor_remote_look_up(const char *remote_name,
> +						       struct promisor_remote **previous)

In our codebase, this operation is far more often called "lookup",
one word, according to "git grep -e look_up \*.h".

> +{
> +	struct promisor_remote *o, *p;
> +
> +	for (p = NULL, o = promisors; o; p = o, o = o->next)
> +		if (o->remote_name && !strcmp(o->remote_name, remote_name)) {
> +			if (previous)
> +				*previous = p;

I think the "previous" thing is for the callers to learn what
pointer points at the found entry, allowing e.g. an element to be
inserted just before the found element.  If so, would it make more
sense to use the more familiar pattern to use

	*previous = &promisors;

here?  That would remove the need to switch on NULL-ness of previous
in the caller.

> diff --git a/promisor-remote.h b/promisor-remote.h
> new file mode 100644
> index 0000000000..bfbf7c0f21
> --- /dev/null
> +++ b/promisor-remote.h
> @@ -0,0 +1,17 @@
> +#ifndef PROMISOR_REMOTE_H
> +#define PROMISOR_REMOTE_H
> +
> +/*
> + * Promisor remote linked list
> + * Its information come from remote.XXX config entries.
> + */
> +struct promisor_remote {
> +	const char *remote_name;
> +	struct promisor_remote *next;
> +};

Would it make the management of storage easier to make it

	struct promisor_remote {
		struct promisor_remote *next;
		const char name[FLEX_ARRAY];
	};

that will allow allocation with

	struct promisor_remote *r;
	FLEX_ALLOC_STR(r, name, remote_name);

Or if the remote_name field must be a pointer, perhaps use
FLEXPTR_ALLOC_STR().

What is the rule for these promisor names?  If these entries were on
the configuration file, then:

	[remote "origin"]
		url = ...
		promisor = frotz
		promisor = nitfol

	[remote "mirror"}
		url = ...
		promisor = frotz
		promisor = Frotz
		promisor = nit fol

would the two "frotz" for the two remotes refer to the same thing,
or are "promisor" values scoped to each remote?

Can the name of promisor be any string?  If they end up getting used
as part of a path on the filesystem, we'd need to worry about case
sensitivity and UTF-8 normalization issues as well.

In a large enough project where multi-promisor makes sense, what is
the expected number of promisors a repository would define?  10s?
1000s?  Would a linked list still make sense when deployed in the
real world, or would we be forced to move to something like hashmap
later?

You do not have to have the answers to all these questions, and even
the ones with concrete answers, you do not necessarily have to act
on them right now (e.g. you may anticipate the eventual need to move
to hashmap, but prototyping with linked list is perfectly fine;
being aware of the possibility alone would force us to be careful to
make sure that the implementation detail does not leak through too
much and confined within _lookup(), _find(), etc. functions, and
that awareness is good enough at this point).

Thanks.
