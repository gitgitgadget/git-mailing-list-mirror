Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501991F803
	for <e@80x24.org>; Tue,  8 Jan 2019 13:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfAHNMj (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 08:12:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34945 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfAHNMj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 08:12:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so4368871wmt.0
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 05:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=KeBv6Smdfnob/E1nSNAszzO7iIOhOYTIOOQYqpDVx3Y=;
        b=OdqysNnLd9jj8H2AcZwxG0oTgaxz+rvflyg/2pmVn14Z2/oGKoCRhj8OdAsXTNfijI
         2Z+AMDe7K2NGD0i4bhkqyV6Oy+dUjbC6AZz3by9anyiO/FDdbCChAEIoCMNgb5cC3UD0
         KZFV+4J2HDzqZc3jmWmCRZRm2un2W9xZMp2zQnUz+AWa6KaJ7zz/F0RB5h3yxUa4kHLu
         y7VqH4o9FdyHAy6lP0dK8hF71AiIVA/WJD/LN8yByW2/ga1veJhgyM1tqMk0xf9gdycL
         uD4lA+LJ/YvhJwfxluLeI9Pqm1AxiRGHW8uTShMES5cs5ZWxxKgB7QmiWNLDOGJyVVi0
         ABDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=KeBv6Smdfnob/E1nSNAszzO7iIOhOYTIOOQYqpDVx3Y=;
        b=qpJDBqR7V6MD47VE+Yv2fPmubVPwLUmarKBvEDi6V9XOfygd/+io4mBbJVCQR+Fw76
         r4wYJ0bk+Et0kCfPCIx3EMfM11w0YrTi7ME2ntEKmN+h2r9wbPIaJs6K69HYf3Da4kxI
         Kr/LzFGMfEfU5Up2wAu+OLXeakJ41X70cQU+Mt6JE2lXixUh4dSBbHHplBQcsYJGqelP
         Er4xKpvwBKDnPEPbt0RSyFskUsaMbYXnaBHvPf+z9I6vsmtg+laTwSdRlTpeVAc7dQAU
         syXzFDIkUWVK4whQBRax3GLefFZFnU0MFPI6F4GUk6Y/ZdTr7uHeyleCN5yLY40m/Qzi
         05XQ==
X-Gm-Message-State: AJcUukfPlJyUReo5G50K72wAcxQapn9R7vUjQMXQ3KK1WeyH/Tcw/YLc
        NSoQIA4gAobiOqTtaCzMskM=
X-Google-Smtp-Source: ALg8bN4zfvMi3vEhPPIVpFZH35kuSELCG8dO0sl7ESL6NUuLDEp0vTQPNiKLnceaKWNAhnCkvReA3A==
X-Received: by 2002:a1c:bbd6:: with SMTP id l205mr1650869wmf.97.1546953157055;
        Tue, 08 Jan 2019 05:12:37 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id k19sm66560599wre.5.2019.01.08.05.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 05:12:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: add the ability to ignore commits
References: <20190107213013.231514-1-brho@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190107213013.231514-1-brho@google.com>
Date:   Tue, 08 Jan 2019 14:12:35 +0100
Message-ID: <8736q3qon0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 07 2019, Barret Rhoden wrote:

> +static int handle_ignore_file(const char *path, struct string_list *ignores)
> +{
> +	FILE *fp = fopen(path, "r");
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	if (!fp)
> +		return -1;
> +	while (!strbuf_getline(&sb, fp)) {
> +		const char *hash;
> +
> +		hash = strchr(sb.buf, '#');
> +		if (hash)
> +			strbuf_setlen(&sb, hash - sb.buf);
> +		strbuf_trim(&sb);
> +		if (!sb.len)
> +			continue;
> +		string_list_append(ignores, sb.buf);
> +	}
> +	fclose(fp);
> +	strbuf_release(&sb);
> +	return 0;
> +}

Aside from other comments on this patch that Junio had either you mostly
copy-pasted this from init_skiplist() or you've come up with almost the
same code on your own.

In any case, if we're going to integrate something like this patch let's
split this "parse file with SHA-1s or comments/whitespace" into a
utility function that both this and init_skiplist() can call.

Then we could split up the description for the fsck.skipList config
variable to reference that format, and say that both it and this new
thing should consult those docs for how it's parsed.
