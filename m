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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8D2211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 13:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbeLBNlx (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 08:41:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37672 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeLBNlw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 08:41:52 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so8501460edb.4
        for <git@vger.kernel.org>; Sun, 02 Dec 2018 05:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dv+DcEhvxjN4JUwG3b5NiQLkAWP0s8jGq1XxWR2gaqo=;
        b=svun1BzEQ27Ej0mE3VPD2S+SrRJJpLQlvkd27Eyxc6g28yFqd3lKxdC2yIX/F7wT8C
         Tf8/o9umfhoX2q+7W55qQGbF8/NwzaWUmBigfQTsCfoHYiAYAKnmQSURJBqz0GGDPR3o
         hiI+1ivOQmOfDpuUqJDekgtFSTatc1prWMyEUbMYFS2RWUgrv9Y75fu30veHwBf6cCtg
         HaSqXGWntm+PHHjr2rWDNDFP43WLqu1NNWz4D7kcQ2WEUPyWRbFfSekjv2n4OhBsudTn
         0BK5FMxTL0KU9l+vXlb/UcVSRfASuo75mCkkt7530if+AEWBrjI71gkVhtAwBqsPmDjP
         M4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dv+DcEhvxjN4JUwG3b5NiQLkAWP0s8jGq1XxWR2gaqo=;
        b=fkbeKMK4p8zrnXROchk8xvdhTh4v2YKpXzwA1vly/gEOCt5SkROwRKvcQDLj1JHjWd
         /MjIL5TbZujQVkxDPy7EQJsuBwEj8YhdIFPah/uplAiQR3esWrlzixaXTv9dsQLAgVjr
         yJi84uxk0gOQd4YffMHjuyZW+YFqXbE6kEiKtG3WC59us1dmoamH0dJxWsrdMC+1M1WM
         SK9MLCXAqK5lBBttQ3zdGh+JMRZFPkApjha+lgPVhEe8jprZM3yQ/ejw52MVSabzLyFK
         LxlWQEObpcKvZvCQJ0Erf9T8aL8yF9GfcowuHxoqfAwWqFh3GWwnfMtl71FEo1Q3z+Es
         2kVA==
X-Gm-Message-State: AA+aEWZr94bxA3RCDJvSDlqEoCqACGWjS5/HLHRmEhJau+C/z+AFFmVC
        cHB8qrK78UrpaSxACGrb9XHYoS+K
X-Google-Smtp-Source: AFSGD/WL2UY8uVAe2v8ZXOLsp52bOoarmDbUTH72sBsEw7AdWRf8C0KvYGD9Ww4H5nJhk8pRK2tO+A==
X-Received: by 2002:a50:b0a4:: with SMTP id j33mr10923051edd.267.1543758108564;
        Sun, 02 Dec 2018 05:41:48 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id b11-v6sm1756407ejd.16.2018.12.02.05.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 05:41:47 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 01/42] parse-options: support --git-completion-helper
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com> <20180209110221.27224-2-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180209110221.27224-2-pclouds@gmail.com>
Date:   Sun, 02 Dec 2018 14:41:46 +0100
Message-ID: <87va4cujtx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 09 2018, Nguyễn Thái Ngọc Duy wrote:

> +static int show_gitcomp(struct parse_opt_ctx_t *ctx,
> +			const struct option *opts)
> +{

Says it returns 'static int'...

> [...]
> +	exit(0);

Then just exits...

> +		/* lone --git-completion-helper is asked by git-completion.bash */
> +		if (ctx->total == 1 && !strcmp(arg + 1, "-git-completion-helper"))
> +			return show_gitcomp(ctx, options);

This return value is never used.

Whine from SunCC (not fatal, also this was in v2.17.0 so no need to fix
before 2.20, just saw this now):

    "parse-options.c", line 520: warning: Function has no return
    statement : show_gitcomp
