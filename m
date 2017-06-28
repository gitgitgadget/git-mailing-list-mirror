Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E7F20209
	for <e@80x24.org>; Wed, 28 Jun 2017 03:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753909AbdF1DPA (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 23:15:00 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33325 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753900AbdF1DOy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 23:14:54 -0400
Received: by mail-pf0-f196.google.com with SMTP id e199so7143124pfh.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 20:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lxhCNsAczAyBC5mG2xAn5EP/SfO8sN59anrrgQ2HkX4=;
        b=lioE8fgyQCKYfmuKVWh3JsFgqcmaZbAyy1t9qCRbyyUFT9e3uGk0mwSyVyqKushneF
         vZVuE4o/rWrelupNXJ6cL0FKRy1far58GQ9nbzbpDCZbWQBv3eg/maHNc7m317mCLdGh
         3snCTXmeqLWYC2CMH0xzPlxGJ3xpeO7+fq3YNByv/fiKBnyf+DYGE+WXQIY9qDiQXvCE
         09AOM2BbrSBxfOJ+42/NGCopjjMRZZhXKV79RJLkP19Hkfmot8ge/dVoXQgTqCRuKYan
         CT1DwEvkbeU79XgWr4z4e4eS9P/oniahQzwhIK5sYc6Obnt8okM4DkP5MfLZ/QIgIBcE
         CcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lxhCNsAczAyBC5mG2xAn5EP/SfO8sN59anrrgQ2HkX4=;
        b=HjN2Hm9EAZwcIfMyv8f22xEa19OkUQ3mtk7+8XA8Q2UbrYHX3pi20EECTepa3rafXq
         3lIXEu56rl8QgcYLo/TqgCfYuatRSvaphDG8RpJGEbs0V6rBTL5dvKagp0eqsR4Hytn3
         6xUYT2IfHq2H6hARNWaAxDOiGAsPkAc+qWhMS1gTEXjKhyPrCJY7m1Pb7nPgSf0SPFxE
         i0f48Rqkwj7+vZxc9mMWc2FNxfzQkaub6BumPjMBvzZJSUhaqnYzAYzc6HR2raWm8gDm
         f9N0+gDoHabrRxRtNnn1DLGJhLECHvMKZRLwt4KxuNR254N+al65bDqYOCKn4uwrMadq
         UFmg==
X-Gm-Message-State: AKS2vOwHMJsItHCcwZBqO2mem7jRwsLWW7bHmWgjwPiXxQbMZIkNQW7+
        pzYqSXMDzPlXVw==
X-Received: by 10.84.238.15 with SMTP id u15mr9402766plk.126.1498619693122;
        Tue, 27 Jun 2017 20:14:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id m68sm1219459pfi.12.2017.06.27.20.14.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 20:14:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/6] diff.c: change the default for move coloring to zebra
References: <20170628005651.8110-1-sbeller@google.com>
        <20170628005651.8110-3-sbeller@google.com>
Date:   Tue, 27 Jun 2017 20:14:50 -0700
In-Reply-To: <20170628005651.8110-3-sbeller@google.com> (Stefan Beller's
        message of "Tue, 27 Jun 2017 17:56:47 -0700")
Message-ID: <xmqq60fgztud.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Introduce a new mode COLOR_MOVED_DEFAULT, which is the same as
> COLOR_MOVED_ZEBRA. But having two different symbols allows us to
> differentiate them in the code.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/diff-options.txt |  3 +++
>  diff.c                         | 13 ++++++++++++-
>  diff.h                         |  1 +
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 058c8014ed..d2c6a60af2 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -243,6 +243,9 @@ endif::git-diff[]
>  --
>  no::
>  	Moved lines are not highlighted.
> +default::
> +	Is a synonym for `zebra`. This may change to more sensible modes
> +	in the future.

"to a more sensible mode"?

This is part of the choice for

	--color-moved[=<mode>]::

and the current text does not exactly say what happens when =<mode>
is omitted.  

I am guessing that the intent is to behave as if "=default" is given
when it happens; this new entry would be a good place to mention it.

	default::
		Uses a sensible default mode (currently `zebra`).
		Giving the `--color-moved` option without an
		explicit `=<mode>` also behaves like this.

or something like that, perhaps.

The "diff.colorMoved" configuration is now a bool-or-string; does it
need to be documented as such in Documentation/config.txt?

	diff.colorMoved::
		When set to `false`, moved lines are not treated any
		differently.  When set to any one of the valid
		`<mode>` for `--color-moved=<mode>` option for `git
		diff` familly of commands, they behave as if
		`--color-moved=<mode>` option was given from the
		command line.  Setting it to `true` has the same
		effect as setting it to `default`.

As the configuration can express everything without the optional
boolness, it may not be worth describing it.  I dunno.

> diff --git a/diff.c b/diff.c
> index 5311dcf133..31cdec05ac 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -256,12 +256,23 @@ int git_diff_heuristic_config(const char *var, const char *value, void *cb)
>  
>  static int parse_color_moved(const char *arg)
>  {
> +	int v = git_parse_maybe_bool(arg);
> +
> +	if (v != -1) {
> +		if (v == 0)
> +			return COLOR_MOVED_NO;
> +		else if (v == 1)
> +			return COLOR_MOVED_DEFAULT;
> +	}
> +

This is not wrong per se, but

	switch (git_parse_maybe_bool(arg)) {
	case 0:
		return COLOR_MOVED_NO;
	case 1:
		return COLOR_MOVED_DEFAULT;
	default:
		break;
	}

without an extra variable "v" may be easier to follow.

> @@ -4654,7 +4665,7 @@ int diff_opt_parse(struct diff_options *options,
>  		if (diff_color_moved_default)
>  			options->color_moved = diff_color_moved_default;
>  		if (options->color_moved == COLOR_MOVED_NO)
> -			options->color_moved = COLOR_MOVED_ZEBRA_DIM;
> +			options->color_moved = COLOR_MOVED_DEFAULT;

This part made me look at the hunk with wider context.  

This code is reacting to "--color-moved" (no arguments) and
diff_color_moved_default presumably comes from the configuration.
When the configuration says diff.colorMoved is 'false' by default,
the "--color-moved" option from the command line needs to trump it,
but we do not have any mode given (other than the configuration
saying "no, no, no, we do not want color-moved at all!"), so we
choose the default setting.  Which is correct but was a bit tricky
to reason about.

> diff --git a/diff.h b/diff.h
> index 98abd75521..9298d211d7 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -192,6 +192,7 @@ struct diff_options {
>  		COLOR_MOVED_NO = 0,
>  		COLOR_MOVED_PLAIN = 1,
>  		COLOR_MOVED_ZEBRA = 2,
> +		COLOR_MOVED_DEFAULT = 2,
>  		COLOR_MOVED_ZEBRA_DIM = 3,
>  	} color_moved;
>  };

Hmph.  I would have expected that COLOR_MOVED_DEFAULT would not be
part of the enum, but a 

    #define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA

I do not have a strong preference either way; it was just a bit
unexpected.

Thanks.


