Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A3921F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 23:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbeKTKAN (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 05:00:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37488 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbeKTKAN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 05:00:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so46993wru.4
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 15:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rQaKzEqzUSOm8jgDd51aDYklnjcIL7buDYs4mr6KENg=;
        b=vFxphUpz9N/Ev8vCzL54dFLqgLfDPN+al3MIeCd/aD6Ei5UK2hnVQUnI5a0bBjrns6
         HsGFFNcUWMBvAIMjuPqCC7iCsm0g7NY0LOVtq15a8Vs4B89NleG2HAYkhcIujNvfGYR5
         oBacz9v6HGENsID8wjPkjvRby6J0Y0Sow8M5qTH60qQSX5yRHQb0Pgh5HQyPUcKwP3ax
         brKcUD1AWqL0CyyRtESAe1NyQbNMjjJ4e4YfYBwM2WDbX/170BpBiwSOt22yXAfoVbUb
         82LIV9eB7FPB2CtnPXpBMmyzkJ4KgUSQhkOZzlkaYEPH8VtMAMaGohVryQcl+mYxt0hb
         +b3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rQaKzEqzUSOm8jgDd51aDYklnjcIL7buDYs4mr6KENg=;
        b=WPwpkI1foRtoSRre5jYRtndiJybB1YUp7F3fqmvlVEx3j4mSAPqQTegLWNbi91eTRj
         1eLOUWSj1XXKGLy4qfJftrhk40ItUmK2bwZu8sZctudJorCqpLSeJb+y8yyg7DoIXNyZ
         lBvfH5ABxbnAqZdLA2wGGdp5nst+27paCphJSfLbnxbj54vociMgPujfRGwm7K121efC
         9BtrwdIiJPmLQLYwY//ZdBiG8GseS29QTlfAugVce4WYpNXAC9XshT0ruLqAjNR0RZ8v
         /5L0uP6dTT+XNKIsJ55Znt07klNnaKjQFKzZ0Cyd68K/NLOB4XPxnVrBdOeSO+G9SXkS
         IhxQ==
X-Gm-Message-State: AA+aEWb+jqFx2SDrQFVcwdFJLIVdskXgQ4eprZ4ELLPxM6tpFNdlHg7W
        DTDQqcSR8Vj7ZrirObCdYm4=
X-Google-Smtp-Source: AFSGD/U7RvDOcAo/cK16wvVuokoA8BeYDUGXSU2pIPdfoRLs+DpcJ4dKvmF3e38kPSyvdTFiIojk6A==
X-Received: by 2002:adf:fac1:: with SMTP id a1-v6mr199450wrs.301.1542670447249;
        Mon, 19 Nov 2018 15:34:07 -0800 (PST)
Received: from szeder.dev (x4db04f16.dyn.telefonica.de. [77.176.79.22])
        by smtp.gmail.com with ESMTPSA id j13sm24862547wrx.5.2018.11.19.15.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 15:34:06 -0800 (PST)
Date:   Tue, 20 Nov 2018 00:34:04 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tests: send "bug in the test script" errors to the
 script's stderr
Message-ID: <20181119233404.GW30222@szeder.dev>
References: <20181119131326.2435-1-szeder.dev@gmail.com>
 <20181119194432.GA7330@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119194432.GA7330@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 02:44:32PM -0500, Jeff King wrote:
> On Mon, Nov 19, 2018 at 02:13:26PM +0100, SZEDER Gábor wrote:
> 
> > Send these "bug in the test script" error messages directly to the
> > test scripts standard error and thus to the terminal, so those bugs
> > will be much harder to overlook.  Instead of updating all ~20 such
> > 'error' calls with a redirection, let's add a BUG() function to
> > 'test-lib.sh', wrapping an 'error' call with the proper redirection
> > and also including the common prefix of those error messages, and
> > convert all those call sites [4] to use this new BUG() function
> > instead.
> 
> Yes, I think this is an improvement.
> 
> > +BUG () {
> > +	error >&7 "bug in the test script: $*"
> > +}
> 
> I naively expected this to go to >&4, but of course that is the
> conditional "stderr or /dev/null, depending on --verbose" descriptor. 

The first version of this patch did send the error message to fd 4 ;)

> I do notice that many of the existing "FATAL:" errors use descriptor 5,
> which goes to stdout. I'm not sure if those should actually be going to
> stderr (or if there's some TAP significance to those lines).

I chose to send these messages to standard error, because they are,
well, errors.  TAP only cares about stdout, but by aborting the test
script in BUG(), error() or die() we are already violating TAP anyway,
so I don't think it matters whether we send "bug in test script" or
"FATAL" errors to stdout or stderr.

BTW, TAP understands "Bail out!" as bail out from the _entire_ test
suite, but that's not what we want here, I'd think.

https://testanything.org/tap-specification.html#bail-out

