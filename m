Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369EE1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 20:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932505AbeAXUdN (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 15:33:13 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46785 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXUdM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 15:33:12 -0500
Received: by mail-pf0-f193.google.com with SMTP id y5so4011661pff.13
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 12:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HTTO4DPn3K3tEixWZSECsUCvZt5qtOUQrDtSYvc7DK0=;
        b=vQDJhQ5DFo1ing9kpfQIpttoyBhasskIS+AdszsiwJm571goEd6T2DBgQbX6VhPBPi
         vyw0j8YymmHsOMusySe0CwU4pcFyFA8OUGHsK+VkCzDa5myXbydbG+zbmJRrqWhq085p
         JIJwSL/BTLsM80fWA1+GzTI2A0EGiWo2lrCy3i7Gdgu8shIpusHZcUWkm0moGck856kA
         5eb7cyEIJKBB2ZBlm9TA/gpN/ATQ1cFSs+5PnJtD9CDG7+Tb+N0DUqaDrBQlrvSsTJtV
         iWc7VNZpQpCQaQvB2ZkwzLQEg68ezllPcyM+/LMmxO5BCFPVGmuezrQfntNC2neIkhwh
         /xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HTTO4DPn3K3tEixWZSECsUCvZt5qtOUQrDtSYvc7DK0=;
        b=QEOlsajSsXXqBhSmULlzBqYBRPoN/nWDYvfYyrRkdIAsRTVgnAZ8pnGukzwSKjLJeO
         4Rdn71EUjWaOsezE00XzHLaTo8mXNDVkdDDUxJ7ccJDymgZLn3NyS+49nByWfdFOOBg/
         Xm7DqE19eUDshbMaUA1IL77pbCgzKF7Up9yWCndl/yrcaimzK4bJbJqIIMfx2pQTwN/y
         w2wT7b96XYjestiaG3kWrcATZY3TwCWo55K5uyPxh+MD98C1x8AflBxXTHtvHvHT/Ix/
         5lBAWg+c7/Plv8/iRZZ8RpaX3xVVpMzYFn8nnmUR2iTokHOMECHBXe67VcuJVgbUiGpK
         /yew==
X-Gm-Message-State: AKwxytcS78FL9qP2ONS3zONysN2hfAIhiX8y6qvn0i1oNkRg1ZPHSpip
        u6E4BCrDXs9pttQpKn28p30=
X-Google-Smtp-Source: AH8x227xcfGvHryiLvANTQvzJ2cXmz47WHZYeAubQ3XcrS/nlrCkiGUNwQsiWIDbz61xnTHo6RwEXw==
X-Received: by 10.101.64.67 with SMTP id h3mr11643387pgp.168.1516825991521;
        Wed, 24 Jan 2018 12:33:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id k3sm4737514pff.41.2018.01.24.12.33.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 12:33:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 1/4] Add tar extract install options override in installation processing.
References: <20180121234203.13764-1-randall.s.becker@rogers.com>
        <20180121234203.13764-2-randall.s.becker@rogers.com>
Date:   Wed, 24 Jan 2018 12:33:09 -0800
In-Reply-To: <20180121234203.13764-2-randall.s.becker@rogers.com> (randall
        s. becker's message of "Sun, 21 Jan 2018 18:42:00 -0500")
Message-ID: <xmqq607rdmka.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.s.becker@rogers.com writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> Subject: Re: [PATCH v4 1/4] Add tar extract install options override in installation processing.

We typically start the subject with some short token to help readers
of "git shortlog --no-merges" identify what area is being touched,
e.g. something like

Subject: [PATCH 1/4] Makefile: allow customizing tar extract options for installation

> Introduced TAR_EXTRACT_OPTIONS as a configuration option to change
> the options of tar processing during extract. The default value is "o"
> which synthesizes xof, by default.

And then we order the codebase "to be like so" (or, give an order to
a patch monkey "to make the resulting code like so").
i.e. something like:

    Introduce TAR_EXTRACT_OPTIONS to allow customizing the tar
    options used when installing.  The default value is "o", which ...

What is missing from the log message is the most important thing,
though.  Everything you wrote (i.e. what build-time knob is being
added, what is tweaked and what the default is) we can read from the
patch text itself, but readers will be left wondering why anybody
would want to change "o" and change it to what else under what
circumstances to achieve what.  I am guessing something like this
might be the reason behind this change

    This allows an implementations of "tar" that lacks the 'o'
    (--no-same-owner) extract option to be used (even though the
    resulting installed versions will keep ownership of whoever
    happened to have built them, instead of being owned by 'root')

but please do not make readers guess.

Having said all that, I wonder if this "go to po/build/locale, tar
everything up and then extract it elsewhere" is truly necessary.
IOW, why isn't it sufficient to do this instead, for example?

    umask 022 && cp -r po/build/locale/. '$(DESTDIR_SQ)$(localedir_SQ)'


>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  Makefile | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 1a9b23b67..78ee431b7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -429,6 +429,10 @@ all::
>  # running the test scripts (e.g., bash has better support for "set -x"
>  # tracing).
>  #
> +# Define TAR_EXTRACT_OPTIONS if you want to change the default behaviour
> +# from xvf to something else during installation. The option only includes
> +# "o" as xf are required.
> +#
>  # When cross-compiling, define HOST_CPU as the canonical name of the CPU on
>  # which the built Git will run (for instance "x86_64").
>  
> @@ -452,6 +456,7 @@ LDFLAGS =
>  ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
>  STRIP ?= strip
> +TAR_EXTRACT_OPTIONS = o
>  
>  # Create as necessary, replace existing, make ranlib unneeded.
>  ARFLAGS = rcs
> @@ -2569,7 +2574,7 @@ install: all
>  ifndef NO_GETTEXT
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
>  	(cd po/build/locale && $(TAR) cf - .) | \
> -	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xof -)
> +	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) x$(TAR_EXTRACT_OPTIONS)f -)
>  endif
>  ifndef NO_PERL
>  	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
