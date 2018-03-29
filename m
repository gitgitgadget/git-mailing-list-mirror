Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B8A1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 01:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeC2Bgu (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 21:36:50 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41841 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeC2Bgt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 21:36:49 -0400
Received: by mail-pg0-f67.google.com with SMTP id t10so2018528pgv.8
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 18:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CPQ/AxSgj5/QltvK45Rr0E0BerRtLwTuP62SuBUAw8Q=;
        b=eRsK8ao4wgYQMpv8QsW8DqZC7Q5hsryxJlIFBL//fSX96gwCzuVF+NYQ+c4PWgO5O6
         MzFRkMv7jNeFX12eNIc9XjBG803AEOUpoUL1WZZUAdJsgf6lRoRyyFjrybUGRT3RWP/U
         DZB5QgowG5/KCx26aEYq9Yvv/wbYIE8j3GfZseDCIqhkC3AcVZ/sHU2AHfEn8NBkEMxj
         7zQiME/jNI5Vm11Mw1ZrEapQLNI+2hx59ZR7KJD1+ocjNKPSbvxml5y7XN/cGU7kOGm5
         uGUwHp9VprwjpGGOub77Eg4PwtCeJHPV2hNbtsqfhulMZUWLki/srvDr3xiXCQoMZcHz
         cEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CPQ/AxSgj5/QltvK45Rr0E0BerRtLwTuP62SuBUAw8Q=;
        b=Kw955dxUUslA8HpsCXfWfuhVaW86k4BOiDNgOf+LkbZcYXtjeR0hpqII/1BbzuIENL
         huwVeFlMtt2zql4dlklJ263/H1KAeWT6hP0dT6BUV7PFPJTKah6KL2+niLOLpK2dvfpb
         +hEMEzTrfr0y25t+5aZEGaBbttWPL8imBOwsH/mQZe/cl12wiH5Hy6WeOCaRoHe9QI7d
         fN3B4CdtrZU+6e1vTq1/uRlDzi/GVXiJvECGi16/wu02EKJlfvLFvfhX+DCu+S5Gth1M
         hPoDx8KDPHQGYB9Tmk7GO+aBWhuBFWQ5gdHGpltubS1iD7qjVmPDlzksObf8TiqWwAsJ
         hWzg==
X-Gm-Message-State: AElRT7FF2htHShD9UXOOfbmCT3PavwI5N68+Lrj8kNJ3GTnLOBnu5aZ6
        VzV5NdegZ6ziIJyQjvIcfEYACA==
X-Google-Smtp-Source: AIpwx49HKr7ja4ehdeD8fgCsn+4Pzqp+IPwqu6Uh/Catpd4SoAd4XeqBc/oBrkTBZ4SuXQvVspwG8Q==
X-Received: by 10.98.211.211 with SMTP id z80mr4669494pfk.16.1522287408839;
        Wed, 28 Mar 2018 18:36:48 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec10:419d:d341:c920])
        by smtp.gmail.com with ESMTPSA id z9sm9300775pfg.183.2018.03.28.18.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 18:36:47 -0700 (PDT)
Date:   Wed, 28 Mar 2018 18:36:46 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 4/4] builtin/config: introduce `--color` type specifier
Message-ID: <20180329013646.GD71044@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180324005556.8145-1-me@ttaylorr.com>
 <20180324005556.8145-5-me@ttaylorr.com>
 <20180326091645.GD18714@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326091645.GD18714@sigill.intra.peff.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 05:16:45AM -0400, Jeff King wrote:
> On Fri, Mar 23, 2018 at 08:55:56PM -0400, Taylor Blau wrote:
>
> > As of this commit, the canonical way to retreive an ANSI-compatible
> > color escape sequence from a configuration file is with the
> > `--get-color` action.
>
> s/retreive/retrieve/

Ack. I forgot to correct this in v3. I will remember to fix this in
anticipation of v4 before this is queued.

> > This is to allow Git to "fall back" on a default value for the color
> > should the given section not exist in the specified configuration(s).
> >
> > With the addition of `--default`, this is no longer needed since:
> >
> >   $ git config --default red --color core.section
> >
> > will be have exactly as:
> >
> >   $ git config --get-color core.section red
> >
> > For consistency, let's introduce `--color` and encourage `--color`,
> > `--default` together over `--get-color` alone.
>
> I don't think we'll ever get rid of --get-color (at the very least, we'd
> need a deprecation period). But it's probably worth adding a note under
> the --get-color description to mention that it's a historical synonym,
> and that using "--default" should be preferred.

I added a note in v3 under the `--get-color` section that it is now
considered "historical", and it is instead preferred to use

  $ git config --default=<default> --type=color <section>

> > @@ -90,6 +91,7 @@ static struct option builtin_config_options[] = {
> >  	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
> >  	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
> >  	OPT_BIT(0, "expiry-date", &types, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
> > +	OPT_BIT(0, "color", &types, N_("value is a color"), TYPE_COLOR),
> >  	OPT_GROUP(N_("Other")),
> >  	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
> >  	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
>
> I just had a funny thought. Normally in Git the "--color" option means
> "colorize the output". And we are diverging from that here. I wonder if
> anybody would be confused by that, or if we would ever want to later add
> an option to colorize git-config output. Would we regret squatting on
> --color?
>
> I'm not sure what else to name it. Anything _except_ "--color" would
> diverge from the existing scheme of "--<type>".
>
> If we were designing from scratch, I'd consider:
>
>   git config --type=int ...
>   git config --type=color ...
>
> etc. I'm not sure if it's worth trying to switch now (on the other hand,
> it resolves the documentation issue I mentioned earlier, since that
> would naturally group all of the types ;) ).
>
> It would be pretty easy to declare "--type" as the Right Way, and list
> "--int" as a historical synonym for "--type=int".

Agreed. I have posted a topic to the list containing a patch to the
above effect.

> > @@ -320,6 +327,12 @@ static char *normalize_value(const char *key, const char *value)
> >  		else
> >  			return xstrdup(v ? "true" : "false");
> >  	}
> > +	if (types == TYPE_COLOR) {
> > +		char v[COLOR_MAXLEN];
> > +		if (!git_config_color(v, key, value))
> > +			return xstrdup(value);
> > +		die("cannot parse color '%s'", value);
> > +	}
>
> Interesting. This doesn't actually normalize anything, since we always
> pass back the original value (or die). I think that's the right thing to
> do, since otherwise you'd end up with ANSI codes in your config file.
>
> I wondered at first if this should go in the "noop" normalization that
> TYPE_PATH undergoes. But I like that it actually sanity-checks the
> value. We should probably have a comment here explaining that yes, we
> parse and then throw away the value (similar to the one near TYPE_PATH).

That was my original intent, but I agree that this is confusing without
a comment explaining so. I have added such a comment in v3.

> I suspect that TYPE_EXPIRY_DATE should do the same thing (parse and
> complain if you fed nonsense, but always keep the original value).

Where?

> > +test_expect_success 'get --color' '
> > +	rm .git/config &&
> > +	git config foo.color "red" &&
> > +	git config --get --color foo.color | test_decode_color >actual &&
> > +	echo "<RED>" >expect &&
> > +	test_cmp expect actual
> > +'
>
> We should probably write this as:
>
>   git config --get --color foo.color >actual.raw &&
>   test_decode_color <actual.raw >actual
>
> to catch failures from git-config itself (there's a lot of old tests
> which pipe, but we've been trying to convert them to be more careful).

Sounds good; I have added this in v3.

> > +test_expect_success 'set --color' '
> > +	rm .git/config &&
> > +	git config --color foo.color "red" &&
> > +	test_cmp expect .git/config
> > +'
> > +
> > +test_expect_success 'get --color barfs on non-color' '
> > +	echo "[foo]bar=not-a-color" >.git/config &&
> > +	test_must_fail git config --get --color foo.bar
> > +'
>
> After reading the normalize bits above, I think there's one more case to
> cover:
>
>   test_must_fail git config --color foo.color not-a-color

Good idea, I've added this in v3.

> > diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
> > index 0e464c206..0ebece7d2 100755
> > --- a/t/t1310-config-default.sh
> > +++ b/t/t1310-config-default.sh
> > @@ -62,6 +62,12 @@ test_expect_success 'marshal default value as expiry-date' '
> >  	test_cmp expect actual
> >  '
> >
> > +test_expect_success 'marshal default value as color' '
> > +	echo "\033[31m" >expect &&
> > +	git config --default red --color core.foo >actual &&
> > +	test_cmp expect actual
> > +'
>
> I don't offhand recall whether octal escapes with "echo" are portable.
> It _is_ in POSIX, but only for XSI. I think using "printf" would be
> portable.

I removed this test in accordance with your earlier suggestions, so this
change is no longer required.


Thanks,
Taylor
