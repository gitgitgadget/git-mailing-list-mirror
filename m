Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7201F4B7
	for <e@80x24.org>; Sat,  7 Sep 2019 10:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfIGKQn (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 06:16:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46114 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfIGKQn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 06:16:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so8973003wrt.13
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 03:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e+3JPHLDJ1CcmDG8cP54OxecnsdPu6N2C/H5baL0M74=;
        b=dhJj74hj7mFKpR4w1X6svXnPkQPUmIlrPkn+KDlkdZO1WgDY0IMNNPjHG5ZhVp2wyG
         VYdXdeo2h4eeeQ3UVGVEY5/DQ1S/4TWGeJ0xLbrHD8tSUDSc/GoEdrE2PMTXHRqXXIZ+
         k2N4jQ42JTDj3BQjJxfEcTOX905cB2C8wMWO3OmLX3Y0XYE8p2Sfljv0VTnM8l3WhXFz
         7KcEYHWHUuUc8lw4eUHI5M60Hx22Om4JqYtDPGa17joYfTqiGnQmvMc8m9BJEP9Iq8jo
         2O345qtPSJV0W6DBDpY5RWDTnLQCiUnEMIco36tJweliy3jDXY9WEkcO4+r3V/OCt7gg
         EZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e+3JPHLDJ1CcmDG8cP54OxecnsdPu6N2C/H5baL0M74=;
        b=M/eCv9+bM1MZyIM9T7DNWA9W8GcYl1KeDZJxN6/E6BdG+7dKBQdVUayTtkB+XTVV0q
         ZZhNqRqVrEwVp5AFXsFpqVBOjzlHXNpwiY7yrMypk9QNaa0mn2nBbuWbiA6sUFWMXiBU
         sd7pJjBGgF/0tn06f64MQKqNNyaNvRe3Me158uNEkX8ekf3zRG1FmkbBSDNS7RCBxwY9
         JWA63vNFrrphc/NkWuI4Bx0lhOGZ6UaSwTDCUkauC81TGhcvOH2EfV5cLtXMnnqU63yd
         Js5AD1kH768+DEsXJE/a/VIol7LsnhS+AAwUYHhrewae2Q1nvk+4RWJHxZLkbj4CWGzK
         9v+A==
X-Gm-Message-State: APjAAAVHUPaN4FSUGeYm8j1TFxR+FV+plJ3BMIHXyyjJ9kcIKET5kuMZ
        EpCDCvf5BjZmqhoJeDUFhVo=
X-Google-Smtp-Source: APXvYqw/0NLYXBNttZNmlEiqO9I/F9/sJGtQZP5sfMdA6QRJwhNJJgQc5rmYi9BxporSrUggwFFMxg==
X-Received: by 2002:a05:6000:b:: with SMTP id h11mr11059215wrx.270.1567851401404;
        Sat, 07 Sep 2019 03:16:41 -0700 (PDT)
Received: from szeder.dev (x4db321b3.dyn.telefonica.de. [77.179.33.179])
        by smtp.gmail.com with ESMTPSA id j22sm16288089wre.45.2019.09.07.03.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Sep 2019 03:16:40 -0700 (PDT)
Date:   Sat, 7 Sep 2019 12:16:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH 2/2] ci: restore running httpd tests
Message-ID: <20190907101637.GE32087@szeder.dev>
References: <20190621101812.27300-8-avarab@gmail.com>
 <20190906121326.23056-1-szeder.dev@gmail.com>
 <20190906121326.23056-2-szeder.dev@gmail.com>
 <20190906191300.GA10769@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190906191300.GA10769@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 03:13:01PM -0400, Jeff King wrote:
> On Fri, Sep 06, 2019 at 02:13:26PM +0200, SZEDER Gábor wrote:
> 
> > Once upon a time GIT_TEST_HTTPD was a tristate variable and we
> > exported 'GIT_TEST_HTTPD=YesPlease' in our CI scripts to make sure
> > that we run the httpd tests in the Linux Clang and GCC build jobs, or
> > error out if they can't be run for any reason [1].
> 
> Yikes, good catch.
> 
> I wonder if it would be possible for the test suite to catch this. I
> think env--helper would have written a message to stderr, but because we
> use --exit-code, we can't tell the difference between that and "false".

No, '--exit-code' only suppresses the printing of 'true' and 'false',
but it doesn't have any effect on the command's exit code.  And if the
value of the environment variable is not a bool, then it does print an
error message to standard error, and, more importantly, exits with 128
(as opposed to 1 indicating false).  So we could tell the difference,
but as it happens the command is invoked as 'if ! git env-helper ...',
which then interprets that 128 the same as on ordinary false.

  $ VAR=false git env--helper --type=bool --default=false --exit-code VAR ; echo $?
  1
  $ VAR=true git env--helper --type=bool --default=false --exit-code VAR ; echo $?
  0
  $ VAR=YesPlease git env--helper --type=bool --default=false --exit-code VAR ; echo $?
  fatal: bad numeric config value 'YesPlease' for 'VAR': invalid unit
  128


> I think we'd have go back to something more like:
> 
>   test_tristate () {

The env var is supposed to be a bool, so there is no third state
anymore.

> 	bool=$(git env--helper --type=bool --default=true "$1") ||

Some callsites use '--default=false', so we need a second parameter to
specify the default.

> 		eval "error \"$1 is not a bool: \$$1\""
> 	test "$bool" = "true"
>   }
>   ...
>   if test_tristate GIT_TEST_HTTPD
>   then
> 	... use httpd ...
>   fi
> 
> Not sure if it's worth it.

Well...  On one hand, there are no other similar issues in our CI
scripts (there is still a GIT_TEST_CLONE_2GB=YesPlease, but it's only
ever checked with 'test -z' in 't5608-clone-2gb.sh', so it works as
expected, even though it's inconsistent, and
'GIT_TEST_CLONE_2GB=NoThanks' would do the wrong thing).

OTOH, some unsuspecting devs might still have a
'GIT_TEST_foo=YesPlease' in their 'config.mak' from the old days...

Furthermore, as for the "good catch", I just got lucky, and not only
once but several times in a row: that Perforce filehost outage the
other day errored one of my builds, so I came up with a fix [1], for
once took the extra effort and checked it on Azure Pipelines, and
since that was my first ever build over there, out of curiosity I
scrolled through the whole build output, by chance those "skipped:
Network testing disabled (unset GIT_TEST_HTTPD to enable)" lines
caught my eye, shrugged and thought that Dscho should better fix this,
but then an hour later got suspicious, so looked up a recent Travis CI
build, and...  here we are.

I have to wonder how much longer it could have been remained
unnoticed, if the Perforce filehost hadn't failed or if I hadn't made
the gitgitgadget PR for my fix, or...

Anyway, this is just a long-winded way to say that I think we should
validate those bools properly and error loudly on an invalid value
even if it doesn't seem to worth it.


[1] https://public-inbox.org/git/20190906102711.6401-1-szeder.dev@gmail.com/T/

