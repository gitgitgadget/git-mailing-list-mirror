Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEED81F404
	for <e@80x24.org>; Fri, 30 Mar 2018 05:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbeC3F1X (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 01:27:23 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35392 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeC3F1W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 01:27:22 -0400
Received: by mail-it0-f47.google.com with SMTP id v194-v6so10375805itb.0
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 22:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0hk3qltoh1mPkTnViu2NJ/sSAlGyNnSivw72cb7FInU=;
        b=q7fbM/vGFFNxSs1evackgpScofQhYd6YBkBpHoSWCcLis7p6h41eJRvVznZcEVNUYy
         xxkls42b6tJPm1qKlqEljKFtGeoOEnTyU+ac72h/9UjABtEAn5iQ18jV2jNz+Nf6murZ
         PuBywJRnkPCohPaers1+d+11xIgmSUjFG+yxLTdwZ0OIzC+j1QDH1W2BFXMVdJ0OCo0W
         O2om9Jg/knc9ZbanxdED5iVD0kIdEcc+hQMzg0TTYC0gqYNDn9QNHbtat5CykOTQilbY
         EtaIizn8rzMtAWZ4O36ABYU+XgynKoXUUUjLF1gtUctDWjauWaiIqN+952sQRiE4nPcL
         ae/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0hk3qltoh1mPkTnViu2NJ/sSAlGyNnSivw72cb7FInU=;
        b=f3DXswfPCqcfwnqeg6MFo+OFsZIqCMVSjp3anqIcU5L9UTXPOUuZfW+YlFNJxT5tP1
         dvKsrKGNfAaq6iFZS1nHJEA4HHqj9B+4YHucWQRE6tvJbdEsV2fLotsk1ZfpD1HKdR98
         dTO+5bj688izkk5GqN+Vy57qh3RijaWZHE9jmlV9fGEVhUY+roJ0nZQFD9BTMw1G5YjJ
         884MzdshaWTPJvu18T4onXVFiNOeNYuqelk4dopNwZuDQcBShSXaomJO3p9pM7+LNvaT
         H1ap+Wnl8/oFK4gDwKIhTytx2NhsZowBysr2A+JBTmd66yuB/YeTPoPAZJVCgAz3vOTt
         43ow==
X-Gm-Message-State: ALQs6tCmqJMcVOmSeEQLOHk8x2nqE7sxzw/vzaOXFwnrdlhZZy3tdBtF
        Txva/OB1LUWPowIWXI+NVcoORqdBCTA=
X-Google-Smtp-Source: AIpwx48mra36BC2WHXqx2mfS3PAtDNEn67OUbiUIoUHw9NbcUhMfLFOmYBb6TBn9auzgsGGhM/azGA==
X-Received: by 2002:a24:c581:: with SMTP id f123-v6mr1630708itg.113.1522387641677;
        Thu, 29 Mar 2018 22:27:21 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:1cc3:31e8:a3ff:d05])
        by smtp.gmail.com with ESMTPSA id g200-v6sm1293448itb.35.2018.03.29.22.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Mar 2018 22:27:20 -0700 (PDT)
Date:   Fri, 30 Mar 2018 01:27:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] builtin/config.c: prefer `--type=bool` over `--bool`,
 etc.
Message-ID: <20180330052719.GA6628@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180329221122.GL2939@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329221122.GL2939@sigill.intra.peff.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 06:11:22PM -0400, Jeff King wrote:
> > +Valid `[type]`'s include:
> > ++
> > +- 'bool': canonicalize  values as either "true" or "false".
> > +- 'int': canonicalize  values as simple decimla numbers. An optional suffix of
> > +  'k', 'm', or 'g' will cause the value to be multiplied by 1024, 1048576, or
> > +  1073741824 prior to output.
> > +- 'bool-or-int': canonicalize according to either 'bool' or 'int', as described
> > +  above.
> > +- 'path': canonicalize by adding a leading `~` to the value of `$HOME` and
> > +  `~user` to the home directory for the specified user. This specifier has no
> > +  effect when setting the value (but you can use `git config section.variable
> > +  ~/` from the command line to let your shell do the expansion.)
> > +- 'expiry-date': canonicalize by converting from a fixed or relative ate-string
> > +  to a timestamp. This specifier has no effect when setting the value.
> > ++
>
> Yay. It's nice to have this in only one place now.

Thanks! Agreed :-).

> s/ate-string/d&/ :)

Ack.

My excuse for this is that I have started using iTerm2.app with Vim in
my terminal using the new graphics acceleration options, and have had
trouble getting Vim to render the underline for misspelled words
consistently.

> > +static int type_name_to_specifier(char *name)
> > +{
> > +	if (!(strcmp(name, "bool")))
> > +		return TYPE_BOOL;
>
> We'd usually drop the extra level of parentheses, and just write:
>
>   if (!strcmp(name, "bool"))

Sounds good; I have adjusted this in the appropriate location in v2.

> > @@ -601,6 +618,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> >  		usage_with_options(builtin_config_usage, builtin_config_options);
> >  	}
> >
> > +	if (type) {
> > +		if (types != 0) {
> > +			error("usage of --type is ambiguous");
> > +			usage_with_options(builtin_config_usage, builtin_config_options);
> > +		}
> > +		types = type_name_to_specifier(type);
> > +	}
>
> This error message left me scratching my head for a minute. Ambiguous
> how? I think this is covering the case of:
>
>   git config --int --type=bool
>
> So maybe "--type cannot be used with other type options" or something?
>
> Let's take a step back, though. As part of this, should we convert the
> parsing of type options to last-one-wins? The fact that they are all
> OPT_BIT() is quite silly, since you cannot have more than one bit set.
> So if you do:
>
>   git config --int --bool
>
> you get an error. Whereas normal behavior for most options would be for
> --bool to override --int. And that is what happens with:
>
>   git config --type=int --type=bool
>
> I don't think there are any backwards compatibility issues to deal with
> here; we'd be changing a case which is now always an error.

Agreed.

> And then after that, you truly can make (and document, if we want) that
> "--int" is a true synonym for "--type=int".

Great point; for me this is the primary motivating factor for making
this change. In addition to simplifying our work when we check:

  if (types != 0 && type_str) { ... }

it would be nice not to have to compare the two in order to ensure that
they are the same, continuing on if so, and causing an error if not.

> I think it would be pretty simple. One of:
>
>   - convert OPT_BIT("bool") into OPT_CALLBACK("bool") and just assign
>     "bool" to the "type" string, which will then later get parsed into
>     TYPE_BOOL.
>
> or
>
>   - convert OPT_BIT("bool") into OPT_SET_INT("bool") to set TYPE_BOOL
>
>     directly. Convert OPT_STRING("type") into OPT_CALLBACK(), and have
>     it assign the result of type_name_to_specifier() directly.
>
> I'd probably do the latter, but would be fine with either (and I'd make
> the OPT_SET_INT thing its own preparatory patch).

I adopted your advice and used the later, converting each `OPT_BIT` into
an `OPT_SET_INT`, and adding a callback for `--type`, which does _not_
complain if `type` is already non-zero.

> If you really want to go all-out, I think the ACTION flags could use the
> same cleanup. We treat them as bitflags, and then issue an error when
> you set more than one, which is just silly.

Agreed, and I think that this is a good candidate for a future patch.
Thoughts? :-).


Thanks,
Taylor
