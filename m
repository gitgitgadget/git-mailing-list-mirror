Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAEC01F404
	for <e@80x24.org>; Fri,  6 Apr 2018 05:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeDFFkS (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 01:40:18 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:43221 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeDFFkR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 01:40:17 -0400
Received: by mail-pf0-f180.google.com with SMTP id j2so5767pff.10
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 22:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J132fT/m/NVmmQnAV4dgrZLVvyW+L8YGOcf+eriE1Dw=;
        b=gRvPqoyle/h4zfXruvWY6T+dBB8BawSVqSgp2VkFp+pi0clNjfEns2fs/Qakg2tYSy
         CqFtacCHFI5N4j0vJab/BEU/KwEG2zge9bmWHVbw5UatZvblTQim2iWYMcrAzZgqGpdQ
         nWMWrWWQAsTwfEuOeiXz32TfbaIq+pnPDHiikvl1hiu+GSVyHcEhBEDKortJ/57iKAvT
         wivy3zz5lAguz5L3kv3UNY3nY/NpKY/cXWyzrDs9E/VN/h3tLZwWTE+Vs/2dCNq+AsT/
         67PBepN2OVWjB+AqWo5AWe5M9/6IOLgOI7g9i2ziM1UgF9VymFNYnwbBZJJXMLPdSHdj
         27Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J132fT/m/NVmmQnAV4dgrZLVvyW+L8YGOcf+eriE1Dw=;
        b=U0n1jSN0E/cPxQwHDV0DCplW8WNvPsDE7PjTrrA0O+YN4zLJFUeRDao1gcPnYmpX/U
         f5AfHJ302YVrpWjm1ZW+JCbdbebDlSufnnbQp57mVrtTLrs0c4ZGKuCHMqX2OPcKDC0f
         cdBlQm8AQzQ/CwlKp0spXW8S7Z/157uGc57M3fKsu58t1jpHCHdEIh+UBy4gK3okrzAR
         UwMGGPvjz6GGn2UyuDUJ9mpnNPDYPybmXO0+1NXK81gFmq5H69ShMvxd9uiqyaw+vnvM
         GecKiOcU15MTa1Pi3LuMBRErfUqMyMTuQc7thIK6/QxG1FKsqWIeBi3AylFPOaQMX2ON
         Eugg==
X-Gm-Message-State: AElRT7GiXjl+sbmO5KEug1g5o2S1tNGzlVvJrlXf/lELVXn5jnT5M7Xb
        4HM61bjt2RbIGdP5/t1eRF4Z0wCeEb8=
X-Google-Smtp-Source: AIpwx49sk3zTJ4BW4m4eSCQ6EaZ55Kp4DlTmWGahX81BbIyV4c5EQUxzNUlO47NEk3M+xX2t2XlFVg==
X-Received: by 10.98.58.129 with SMTP id v1mr19356568pfj.231.1522993217151;
        Thu, 05 Apr 2018 22:40:17 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id p20sm16468657pff.41.2018.04.05.22.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 22:40:16 -0700 (PDT)
Date:   Thu, 5 Apr 2018 22:40:15 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v4 1/3] builtin/config: introduce `--default`
Message-ID: <20180406054015.GA62593@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522896713.git.me@ttaylorr.com>
 <20180405025912.GB49902@syl.local>
 <20180405222949.GC29117@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405222949.GC29117@sigill.intra.peff.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 06:29:49PM -0400, Jeff King wrote:
> On Wed, Apr 04, 2018 at 07:59:12PM -0700, Taylor Blau wrote:
>
> > @@ -286,6 +288,16 @@ static int get_value(const char *key_, const char *regex_)
> >  	config_with_options(collect_config, &values,
> >  			    &given_config_source, &config_options);
> >
> > +	if (!values.nr && default_value) {
> > +		struct strbuf *item;
> > +		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
> > +		item = &values.items[values.nr++];
> > +		strbuf_init(item, 0);
> > +		if (format_config(item, key_, default_value) < 0) {
> > +			exit(1);
> > +		}
> > +	}
>
> Calling exit() explicitly is unusual for our code. Usually we would
> either die() or propagate the error. Most of the types in
> format_config() would die on bogus input, but a few code paths will
> return an error.
>
> What happens if a non-default value has a bogus format? E.g.:
>
>   $ git config foo.bar '~NoSuchUser'
>   $ git config --path foo.bar
>   fatal: failed to expand user dir in: '~NoSuchUser'
>
> Oops. Despite us checking for an error return from
> git_config_pathname(), it will always either return 0 or die(). So
> that's not a good example. ;)
>
> Let's try expiry-date:
>
>   $ git config foo.bar 'the first of octember'
>   $ git config --expiry-date foo.bar
>   error: 'the first of octember' for 'foo.bar' is not a valid timestamp
>   fatal: bad config line 7 in file .git/config
>
> OK. So we call format_config() there from the actual collect_config()
> callback, and the error gets propagated back to the config parser, which
> then gives us an informative die(). What happens with your new code:
>
>   $ ./git config --default 'the first of octember' --type=expiry-date no.such.key
>   error: 'the first of octember' for 'no.such.key' is not a valid timestamp
>
> It's obvious in this toy example, but that config call may be buried
> deep in a script. It'd probably be nicer for that exit(1) to be
> something like:
>
>   die(_("failed to format default config value"));

Aha. Thanks for the explanation :-). I've removed the exit() and changed
it to the die() that you suggested above. The test in t1310 is updated
to grep for the new message, so we know that it is being reported
appropriately.

> > +test_expect_success 'does not allow --default without --get' '
> > +	test_must_fail git config --default quux --unset a >output 2>&1 &&
> > +	test_i18ngrep "\-\-default is only applicable to" output
> > +'
>
> I think "a" here needs to be "a.section". I get:
>
>   error: key does not contain a section: a

Aha, thanks again. I have updated this in the forthcoming re-roll.


Thanks,
Taylor
