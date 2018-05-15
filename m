Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED811F406
	for <e@80x24.org>; Tue, 15 May 2018 01:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeEOBoY (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 21:44:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36935 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeEOBoX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 21:44:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id l1-v6so18476493wmb.2
        for <git@vger.kernel.org>; Mon, 14 May 2018 18:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8XBWLxOLD87TZPBguV3+qgSS5267c0+4Cjw6sUlpf4s=;
        b=T/UW6N1/vQVlgjKkr6NpgKl78xHd71HaoE79lGOsq4+nA8/cwj0SjtvEeaXLQQogCk
         VIl+7+Dim8NYOySHv9AjxF/NK3JFbtDDAyM45yHche7BXpW5fQObhaCguOhLOzMlg6Dl
         AUwj2FvKUtMt3PCPxc7OlKW6E4zRq2M8qZqMU5GSh7x8MYGHnZdKjLXcG81KxB8DOd5u
         +wnxHV2HXjj2GImnm9kaUwxI7eIiuv2gpA5WLwpLZjD9I83kKlgG8s0I75s/OfEy8LRk
         VuWAtm3GLxx/Qpb44fDiR4kGXvtEieuiy/Gi4wf/Ltzy10T3wZFERDf1JmegFlyvcMnY
         6rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8XBWLxOLD87TZPBguV3+qgSS5267c0+4Cjw6sUlpf4s=;
        b=oINEXE66DCoBOp+B2Sb9ylDitJQcF/JSUAxPMsSeB2BEz5cUTyNfxtu991cNFQef8j
         zKisby0VVSNKdQoRBrcUmviUAIZqBh+nMJDOeXfK4fTDEttqbjFW0cYhtMUMHPsIvlLE
         iVAZmFOPsGMfgd1+5CLOR54XfFrK+JhG1qg7JAgw/eVxYfpDIFbUMSMyRhvBf2J9ykk8
         0wz3+XbmSwFwwnkj6l6WqInKIGqxN/Juaf+3KGocT3mOXtARSJSAyow7uAwxLC8545qe
         LUjEK+lDhdB9QibfSh3KUl4rK1/sJXE2cQissR7qj6EySD2bJZSaOx6ZOcGegUnmNIOa
         XTVA==
X-Gm-Message-State: ALKqPwdaJlrfR1YFdD5CYHnSGKf8/sPIe7jIj38N8lQnbawT7Gg//kIm
        mMQ9n7HsZML1s3UkdoMMWNE=
X-Google-Smtp-Source: AB8JxZoqK/piVCX1tpRdJq7hO+MEjSGTeUhzoAkVAAwcAgSi5eI85yYXqcfcXHaAs3gcL9NO6I8s2Q==
X-Received: by 2002:a1c:c1c9:: with SMTP id r192-v6mr6269700wmf.120.1526348661432;
        Mon, 14 May 2018 18:44:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k30-v6sm16683753wrf.17.2018.05.14.18.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 18:44:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 2/8] Add initial odb remote support
References: <20180513103232.17514-1-chriscool@tuxfamily.org>
        <20180513103232.17514-3-chriscool@tuxfamily.org>
Date:   Tue, 15 May 2018 10:44:20 +0900
In-Reply-To: <20180513103232.17514-3-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 13 May 2018 12:32:26 +0200")
Message-ID: <xmqqh8n9ae17.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/odb-helper.h b/odb-helper.h
> new file mode 100644
> index 0000000000..61d2ad082b
> --- /dev/null
> +++ b/odb-helper.h
> @@ -0,0 +1,13 @@
> +#ifndef ODB_HELPER_H
> +#define ODB_HELPER_H
> +

Here is a good space to write a comment on what this structure and
its fields are about.  Who are the dealers of helpers anyway?

> +struct odb_helper {
> +	const char *name;
> +	const char *dealer;
> +
> +	struct odb_helper *next;
> +};
> +
> +extern struct odb_helper *odb_helper_new(const char *name, int namelen);
> +
> +#endif /* ODB_HELPER_H */
> diff --git a/odb-remote.c b/odb-remote.c
> new file mode 100644
> index 0000000000..e03b953ec6
> --- /dev/null
> +++ b/odb-remote.c
> @@ -0,0 +1,72 @@
> +#include "cache.h"
> +#include "odb-remote.h"
> +#include "odb-helper.h"
> +#include "config.h"
> +
> +static struct odb_helper *helpers;
> +static struct odb_helper **helpers_tail = &helpers;
> +
> +static struct odb_helper *find_or_create_helper(const char *name, int len)
> +{
> +	struct odb_helper *o;
> +
> +	for (o = helpers; o; o = o->next)
> +		if (!strncmp(o->name, name, len) && !o->name[len])
> +			return o;
> +
> +	o = odb_helper_new(name, len);
> +	*helpers_tail = o;
> +	helpers_tail = &o->next;
> +
> +	return o;
> +}

This is a tangent, but I wonder if we can do better than
hand-rolling these singly-linked list of custom structure types
every time we add new code.  I am just guessing (because it is not
described in the log message) that the expectation is to have only
just a handful of helpers so looking for a helper by name is OK at
O(n), as long as we very infrequently look up a helper by name.

> +static int odb_remote_config(const char *var, const char *value, void *data)
> +{
> +	struct odb_helper *o;
> +	const char *name;
> +	int namelen;
> +	const char *subkey;
> +
> +	if (parse_config_key(var, "odb", &name, &namelen, &subkey) < 0)
> +		return 0;
> +
> +	o = find_or_create_helper(name, namelen);
> +
> +	if (!strcmp(subkey, "promisorremote"))
> +		return git_config_string(&o->dealer, var, value);

If the field is meant to record the name of the promisor remote,
then it is better to name it as such, no?

> +struct odb_helper *find_odb_helper(const char *dealer)

Ditto.

> +{
> +	struct odb_helper *o;
> +
> +	odb_remote_init();
> +
> +	if (!dealer)
> +		return helpers;
> +
> +	for (o = helpers; o; o = o->next)
> +		if (!strcmp(o->dealer, dealer))
> +			return o;

The code to create a new helper tried to avoid creating a helper
with duplicated name, but nobody tries to create more than one
helpers that point at the same promisor remote.  Yet here we try to
grab the first one that happens to point at the given promisor.

That somehow smells wrong.

