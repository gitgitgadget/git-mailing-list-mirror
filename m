Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 606051F453
	for <e@80x24.org>; Wed, 26 Sep 2018 14:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeIZUu1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 16:50:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34014 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeIZUu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 16:50:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so14047928pgv.1
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SN1wFcfOSjvFYvI9VEevRHywKdj3+2XS86nLyQNYK8c=;
        b=siW6xrAfTdj1zLWglvNKQ0o05L7KrmPuKwW+xumCvFLgtbQfc7UQvD4WQRdIILsB9k
         2NJUzC9/fwtziipEtghzyxDySJdu9j+qqriusT+D2mBC/cpeGjmhNUNQk4G+oIICelCS
         Bgch7AL4JKVGReRgp8wcycWvG/20kjupsD1MxBz4q0SHp597ZEnTnOn/mfl7KQIEbIEV
         70dkYKhcj5Dnv8ZKH1jYJssgFYFcPHcsn8G36GeT18HeFteWTFqsG4NTFjNkcO24lNSJ
         +GCHO+E4lMMwUHb1IbBDOxpiU5fHnFTeOv6tanj60BLHgwxd8CYuWUHa6bkCHznYDoXh
         qUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SN1wFcfOSjvFYvI9VEevRHywKdj3+2XS86nLyQNYK8c=;
        b=OIukHfHS29oh7oUVXFkGX7whZO/YPuSqNC7oZaCg+td6vycaWq5O3m7DFOzqj2cLFP
         IOTGxnyz2CN8gPWyZ9M1aDW8+df4xDnRDkSvhDXor4kTNzLxF9Skz7llDYDGe+YtaxOJ
         LvfoccJwoCyzbA1nKgmsMffe+78NCGHM1SdvU4cMbROBhfrNXAeAVlx2hLJbhVg/PXTR
         wXTudFUkHcJUzwn5RHUHmzRnQ90cB/DjJ6sHHC6MSgASFaLtQmx9KDsH0pB33akqWWbd
         5KGJtINOQzn3c5f8nuAJ4rSgs5bF64N2qA1HtSd9y9Swd/s6Dn1aOpDhWUfagSWsjC51
         m13w==
X-Gm-Message-State: ABuFfohK92hj30hZKEMV4bTR56iMcLzt8MdUqofYbx3RpnqN8A1oXYfW
        9KHdr21aR5M8QCC67SXgRMoZBXnhS0r9vw==
X-Google-Smtp-Source: ACcGV62b7cPGN5Fqy8BZSwRdPipag8X1p69fi6wbFhdhxf83EM/7S3rzN32q9yLqQC44dClkguSY9A==
X-Received: by 2002:a63:7e1c:: with SMTP id z28-v6mr5977189pgc.246.1537972631089;
        Wed, 26 Sep 2018 07:37:11 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d190:33d6:11d2:d23b])
        by smtp.gmail.com with ESMTPSA id u139-v6sm6862358pgb.65.2018.09.26.07.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 07:37:09 -0700 (PDT)
Date:   Wed, 26 Sep 2018 07:37:08 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
Message-ID: <20180926143708.GD25697@syl>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 12:26:36PM +0200, Rasmus Villemoes wrote:
> I often use 'git <cmd> --help' as a quick way to get the documentation
> for a command. However, I've also trained my muscle memory to use my
> aliases (cp=cherry-pick, co=checkout etc.), which means that I often end
> up doing
>
>   git cp --help
>
> to which git correctly informs me that cp is an alias for
> cherry-pick. However, I already knew that, and what I really wanted was
> the man page for the cherry-pick command.

Neat. I have many of those such aliases myself, and have always wanted
something like this. Thanks for taking the time to put such a patch
together :-).

> This introduces a help.followAlias config option that transparently
> redirects to (the first word of) the alias text (provided of course it
> is not a shell command), similar to the option for autocorrect of
> misspelled commands.

Good. I was curious if you were going to introduce a convention along
the lines of, "If the alias begins with a '!', then pass "--help" to it
and it must respond appropriately." I'm glad that you didn't take that
approach.

> The documentation in config.txt could probably be improved. Also, I
> mimicked the autocorrect case in that the "Continuing to ..." text goes
> to stderr, but because of that, I also print the "is aliased to" text to
> stderr, which is different from the current behaviour of using
> stdout. I'm not sure what the most correct thing is, but I assume --help
> is mostly used interactively with stdout and stderr pointing at the same
> place.
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> ---
>  Documentation/config.txt | 10 ++++++++++
>  builtin/help.c           | 36 +++++++++++++++++++++++++++++++++---
>  2 files changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ad0f4510c3..8a1fc8064e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2105,6 +2105,16 @@ help.autoCorrect::
>  	value is 0 - the command will be just shown but not executed.
>  	This is the default.
>
> +help.followAlias::
> +	When requesting help for an alias, git prints a line of the
> +	form "'<alias>' is aliased to '<string>'". If this option is
> +	set to a positive integer, git proceeds to show the help for

With regard to "set to a positive integer", I'm not sure why this is the
way that it is. I see below you used 'git_config_int()', but I think
that 'git_config_bool()' would be more appropriate.

The later understands strings like "yes", "on" or "true", which I think
is more of what I would expect from a configuration setting such as
this.

> +	the first word of <string> after the given number of
> +	deciseconds. If the value of this option is negative, the
> +	redirect happens immediately. If the value is 0 (which is the
> +	default), or <string> begins with an exclamation point, no
> +	redirect takes place.

It was unclear to my originlly why this was given as a configuration
knob, but my understanding after reading the patch is that this is to do
_additional_ things besides printing what is aliased to what.

Could you perhaps note this in the documentation?

>  help.htmlPath::
>  	Specify the path where the HTML documentation resides. File system paths
>  	and URLs are supported. HTML pages will be prefixed with this path when
> diff --git a/builtin/help.c b/builtin/help.c
> index 8d4f6dd301..ef1c3f0916 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -34,6 +34,7 @@ enum help_format {
>  };
>
>  static const char *html_path;
> +static int follow_alias;
>
>  static int show_all = 0;
>  static int show_guides = 0;
> @@ -273,6 +274,10 @@ static int git_help_config(const char *var, const char *value, void *cb)
>  		html_path = xstrdup(value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "help.followalias")) {
> +		follow_alias = git_config_int(var, value);
> +		return 0;
> +	}

Good. I think in modern Git, we'd prefer to write this as a series of
`else if`'s, but this matches the style of the surrounding code. I think
that you could optionally clean up this style as a preparatory commit,
but ultimately I don't think it's worth a reroll on its own.

>  	if (!strcmp(var, "man.viewer")) {
>  		if (!value)
>  			return config_error_nonbool(var);
> @@ -415,9 +420,34 @@ static const char *check_git_cmd(const char* cmd)
>
>  	alias = alias_lookup(cmd);
>  	if (alias) {
> -		printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
> -		free(alias);
> -		exit(0);
> +		const char **argv;
> +		int count;
> +
> +		if (!follow_alias || alias[0] == '!') {
> +			printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
> +			free(alias);
> +			exit(0);
> +		}
> +		fprintf_ln(stderr, _("'%s' is aliased to '%s'"), cmd, alias);

OK, I think that this is a sensible decision: print to STDERR when
that's not the main purpose of what're doing (e.g., we're going to
follow the alias momentarily), and STDOUT when it's the only thing we're
doing.

Potentially we could call 'fprintf_ln()' only once, and track an `int
fd` at the top of this block.

> +
> +		/*
> +		 * We use split_cmdline() to get the first word of the
> +		 * alias, to ensure that we use the same rules as when
> +		 * the alias is actually used. split_cmdline()
> +		 * modifies alias in-place.
> +		 */
> +		count = split_cmdline(alias, &argv);
> +		if (count < 0)
> +			die("Bad alias.%s string: %s", cmd,
> +			    split_cmdline_strerror(count));

Please wrap this in _() so that translators can translate it.

> +		if (follow_alias > 0) {
> +			fprintf_ln(stderr,
> +				   _("Continuing to help for %s in %0.1f seconds."),
> +				   alias, follow_alias/10.0);
> +			sleep_millisec(follow_alias * 100);
> +		}
> +		return alias;

I'm not sure that this notification is necessary, but I'll defer to the
judgement of others on this one.

Thanks,
Taylor
