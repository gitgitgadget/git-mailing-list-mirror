Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB8A202AC
	for <e@80x24.org>; Tue,  4 Jul 2017 17:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbdGDRvw (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 13:51:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35797 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbdGDRvw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 13:51:52 -0400
Received: by mail-pf0-f194.google.com with SMTP id q85so2164272pfq.2
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6+3gtZXtJ+W8nOJdOmomnsWfNk/0j0S41b58H6oJakw=;
        b=Xg07P3wWqm3aGAqfRNfoQgB4COBQZb0HgObnQh0Qigo6HeCu/cnO7tdesVlso/Qm/q
         7ugmzQ/Yy2TtSwJtYcocZMfvCGgLZENxspQ6m1+5Gqq6a5HkWwS1RBqT5bxqp6DOHZ65
         RU3HWy4X/PiG0qsuHkdhvvZN4XLi6o4Uw5R214LAs3OnVlrFxxqzHVkCcVqxay+PPCCL
         raNxYFjoPIRUmOD8DdIJSQ8hfCuJAudQ8ujSJjSOuL2ZAVBlgZuNq/t0HbXoT8hiUrnx
         WTkvEfCpc2/l3/M2dVzRomNMTCFOsD+2qZAsmt99mIdjv0Jcqj+/SDevJunreBFJBduY
         1fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6+3gtZXtJ+W8nOJdOmomnsWfNk/0j0S41b58H6oJakw=;
        b=f4cMYjyrVBMQhLubq/gS4SKoLye9luA4Ou03f5qCv6SMpgwEl2xXwj+lmefuA0/2BR
         Bj4Ln6os4XvqMz42xgRAexqPP06qAd8j2fuGPW38z72ZHgP1wR1N8pU21l3ar91lid4J
         VjYuAcIeSPNbDShPQtoBW4sYYrrhj5zpKghH/yZuN48z9u38+fnDJfKq+d83e4Nmf0LB
         yzD0Iw2XPd4MXaRnK1qj9bDX9snxaaCZXu2V+gv12BdtMPsmzh7ey5Xzspurll53rx/z
         1W8mMgZHpYOY10Xzfs0xH1IktiTJl5Fxe4pLSvtkHACD1b5KqOaw1TyOiLGT0ZqDglYR
         WVUw==
X-Gm-Message-State: AIVw110y1Hbqb/+SoVVk1zgAQ43p8yF0qXhaYkRgrNPRjunBpLCy8R6G
        jPZKaCGmQ+KWXlAWoBY=
X-Received: by 10.98.217.145 with SMTP id b17mr15982143pfl.70.1499190711051;
        Tue, 04 Jul 2017 10:51:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:58ac:d78a:789c:c809])
        by smtp.gmail.com with ESMTPSA id u9sm45894212pfd.56.2017.07.04.10.51.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Jul 2017 10:51:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Francesco Mazzoli <f@mazzo.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
References: <1499116727-757-1-git-send-email-f@mazzo.li>
Date:   Tue, 04 Jul 2017 10:51:49 -0700
In-Reply-To: <1499116727-757-1-git-send-email-f@mazzo.li> (Francesco Mazzoli's
        message of "Mon, 3 Jul 2017 23:18:47 +0200")
Message-ID: <xmqqvan8jdje.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Francesco Mazzoli <f@mazzo.li> writes:

> The flag can be overridden with `--no-force-with-lease`, or by
> passing the config via the command line.
>
> Signed-off-by: Francesco Mazzoli <f@mazzo.li>
> ---
>  Documentation/config.txt | 5 +++++
>  builtin/push.c           | 3 +++
>  cache.h                  | 1 +
>  config.c                 | 4 ++++
>  environment.c            | 1 +
>  5 files changed, 14 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 06898a7..36fe882 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2537,6 +2537,11 @@ push.default::
>  	specific workflows; for instance, in a purely central workflow
>  	(i.e. the fetch source is equal to the push destination),
>  	`upstream` is probably what you want.  Possible values are:
> +
> +push.alwaysforcewithlease::
> +	When true, `--force-with-lease` is the default behavior when
> +	using `push --force`. Explicit invocations of `--force-with-lease`
> +	or `--no-force-with-lease` if present, take precedence.
>  +
>  --

I suspect this may be going in a wrong direction.  

People have been burned by the lazy "--force-with-lease" that does
not say what object to expect there and forces the command to DWIM
incorrectly what the remote's ref ought to be pointing at.  This
change encourages its use without the user being painfully aware of
that danger.  Whenever you say "push --force", you'd be using the
dangerous "--force-with-lease" that does not specify what the
expected current state of the remote is.  The end result gives an
illusion of being safer than a simple "--force", without being
not really safer.

I'd understand more if there were two new (and orthogonal) options,
though:

 - disable the use of "--force" option, telling the user to use
   "--force-with-lease=<object>" instead.

 - disable the DWIM based on the remote-tracking branches when
   "--force-with-lease[=<refname>]" is used, i.e. error out when the
   option is used without a specific object to expect.


