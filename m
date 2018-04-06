Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9421F404
	for <e@80x24.org>; Fri,  6 Apr 2018 06:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbeDFGCU (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 02:02:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43409 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeDFGCT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 02:02:19 -0400
Received: by mail-pl0-f67.google.com with SMTP id a39-v6so27608pla.10
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 23:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WJoq9WwKhrb3PfEOi8jVeFhiv00KpgdiKb/M/unt9D4=;
        b=lWbhKodC7GbhDsRVtW1eJruhp+wS0Z77oGaqDFfwv1yMh943is+1Q9gBHLMyP6LKg+
         vviOIM8Lsjq9wIwHjzIIU1DLPjz2cctoPYKTg9FsboqEnAatnQNEgSLVdGw8FMJUBVN4
         iXSpKUp6EjRE2eMkofxzyR/b9SlUqIUp5+DnJhmEt3gooytePM1zLCQ9x5ntZElSgch2
         trVFtXSIYq3DslvWY+VgyoL1J7/dNjvJMeVRlTiRngT+qFOOGyjFsNCg0Z5KHAzEfy78
         cj7etaipmrgebUzur+tOJv8mB/07VS1qcPs08b+rrpyWrWdB2Al6zP/2UlYDtLRPoaFI
         +/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WJoq9WwKhrb3PfEOi8jVeFhiv00KpgdiKb/M/unt9D4=;
        b=QG/vTImFX8Zi+5nR/yXsBPNUlpRkT2uT+9Iw6G+4BI9IVzmGEhVRccmOCUv+ClUtBa
         Sy+xxdpxbC9IXBRds4m4zXTexxXrsa51uG/mPhn+av1eqbhK7u2jpzp9bYTjKzwjOP6G
         KKJ4OM1PQh/PlRBlx5bNzxZBkErOSHrKzPzpTr3vYev6Yg50pK8xz1YeDzl8lwT9pO7H
         urkRSApHqzwcSuUgUeuiBpRPSvbiYBobKnZBRfu99WdOgp5FwOJHs8L2k0O+ZuBxhYgM
         6WAv7/3hSKlXI/sKFoaUxV0ZxxtOjXcN8kt5KfbMD5mmVnAAHy9ytrBLiYN6UQrAMlOS
         S7Jg==
X-Gm-Message-State: AElRT7EdqHQ9jB6nJOglC6bxXRN2R8UUcxTABYriM4hEmr0yHHNTsT17
        Ds7aV3pZuXgLmJL/3sZE+3fCrCvFjOY=
X-Google-Smtp-Source: AIpwx48LRdQ3i2BfbZVaNGOywVjDcdQeeUMOIJP4tga7LyjErXdhoIPexO+jB8km1rgW+tXAtlLmdQ==
X-Received: by 2002:a17:902:8c93:: with SMTP id t19-v6mr25825482plo.301.1522994538913;
        Thu, 05 Apr 2018 23:02:18 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id v18sm16594624pgb.23.2018.04.05.23.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 23:02:17 -0700 (PDT)
Date:   Thu, 5 Apr 2018 23:02:16 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v4 3/3] builtin/config: introduce `color` type specifier
Message-ID: <20180406060216.GC62593@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522896713.git.me@ttaylorr.com>
 <20180405025917.GD49902@syl.local>
 <20180405223620.GD29117@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405223620.GD29117@sigill.intra.peff.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 06:36:20PM -0400, Jeff King wrote:
> On Wed, Apr 04, 2018 at 07:59:17PM -0700, Taylor Blau wrote:
>
> > As of this commit, the canonical way to retreive an ANSI-compatible
> > color escape sequence from a configuration file is with the
> > `--get-color` action.
> >
> > This is to allow Git to "fall back" on a default value for the color
> > should the given section not exist in the specified configuration(s).
> >
> > With the addition of `--default`, this is no longer needed since:
> >
> >   $ git config --default red --type=color core.section
> >
> > will be have exactly as:
> >
> >   $ git config --get-color core.section red
> >
> > For consistency, let's introduce `--color` and encourage `--type=color`,
> > `--default` together over `--get-color` alone.
>
> In this last sentence, did you mean "let's introduce --type=color and
> encourage its use with --default over --get-color alone"?

I did; thank you :-). I have updated this in the forthcoming re-roll.

> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  Documentation/git-config.txt | 10 ++++++----
> >  builtin/config.c             | 21 +++++++++++++++++++++
> >  t/t1300-repo-config.sh       | 30 ++++++++++++++++++++++++++++++
> >  3 files changed, 57 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> > index 620492d1e..bde702d2e 100644
> > --- a/Documentation/git-config.txt
> > +++ b/Documentation/git-config.txt
> > @@ -38,10 +38,8 @@ existing values that match the regexp are updated or unset.  If
> >  you want to handle the lines that do *not* match the regex, just
> >  prepend a single exclamation mark in front (see also <<EXAMPLES>>).
> >
> > -A type specifier may be given as an argument to `--type` to make 'git config'
> > -ensure that the variable(s) are of the given type and convert the value to the
> > -canonical form. If no type specifier is passed, no checks or transformations are
> > -performed on the value.
> > +`color`::
> > +    The value is taken as an ANSI color escape sequence.
>
> We'd want to keep that introductory paragraph, right? And there is no
> `--color`? So I think this hunk can go away (and is presumably a
> leftover mistake during rebasing).

Yes; this entire hunk should not have been staged. I think that it was a
leftover from rebasing. I have removed it in the forthcoming re-roll.

> >  When reading, the values are read from the system, global and
> >  repository local configuration files by default, and options
> > @@ -177,6 +175,7 @@ Valid `<type>`'s include:
> >    ~/` from the command line to let your shell do the expansion.)
> >  - 'expiry-date': canonicalize by converting from a fixed or relative date-string
> >    to a timestamp. This specifier has no effect when setting the value.
> > +- 'color': canonicalize by converting to an ANSI color escape sequence.
> >  +
>
> This one is part of the --type list, so that's what we expect.
>
> You may want to also cover the behavior when setting the value (we check
> that it's sane, but store the original).

Good idea; thank you.

> > diff --git a/builtin/config.c b/builtin/config.c
> > index 1328b568b..aa3fcabe9 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -61,6 +61,7 @@ static int show_origin;
> >  #define TYPE_BOOL_OR_INT	3
> >  #define TYPE_PATH		4
> >  #define TYPE_EXPIRY_DATE	5
> > +#define TYPE_COLOR		6
>
> Not strictly necessary for this series, but if this became an enum as
> part of the de-bitifying, you wouldn't have to write the numbers
> manually. :)

Certainly agree that this would be useful. I think that I'd prefer to
accomplish this in a future series, since this one is starting to become
long-lived :-).

> > @@ -203,6 +206,11 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
> >  			if (git_config_expiry_date(&t, key_, value_) < 0)
> >  				return -1;
> >  			strbuf_addf(buf, "%"PRItime, t);
> > +		} else if (type == TYPE_COLOR) {
> > +			char v[COLOR_MAXLEN];
> > +			if (git_config_color(v, key_, value_) < 0)
> > +				return -1;
> > +			strbuf_addstr(buf, v);
> >  		} else if (value_) {
> >  			strbuf_addstr(buf, value_);
> >  		} else {
>
> OK, formatting shows the converted value. Good.
>
> > @@ -348,6 +356,19 @@ static char *normalize_value(const char *key, const char *value)
> >  		else
> >  			return xstrdup(v ? "true" : "false");
> >  	}
> > +	if (type == TYPE_COLOR) {
> > +		char v[COLOR_MAXLEN];
> > +		if (!git_config_color(v, key, value))
> > +			/*
> > +			 * The contents of `v` now contain an ANSI escape
> > +			 * sequence, not suitable for including within a
> > +			 * configuration file. Treat the above as a
> > +			 * "sanity-check", and return the given value, which we
> > +			 * know is representable as valid color code.
> > +			 */
> > +			return xstrdup(value);
> > +		die("cannot parse color '%s'", value);
> > +	}
>
> And this returns the original. Good.
>
> > diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> > index b25ab7b9e..c630bdc77 100755
> > --- a/t/t1300-repo-config.sh
> > +++ b/t/t1300-repo-config.sh
>
> The tests look good.

Thank you.


Thanks,
Taylor
