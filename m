Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4611F453
	for <e@80x24.org>; Thu,  8 Nov 2018 20:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeKIG22 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 01:28:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40251 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeKIG22 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 01:28:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so22710526wre.7
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 12:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PukgiaOBICcaIwzSn/3zswQF3+WG7vPypHf3Jiv+hKE=;
        b=XwVGHyCevG+e9NAn3DoDau/7qa4BsIwkSXtudlk/rM408ofF53Z4ddesVnIjjHd3yB
         RuKcESe+c3Qosj96CigvGSo2/nBq9WK59fzp2tWERA/cCpDV1X8AzxZoRQO0Xmx724Dd
         ORM5Szs08WaY4GzZARBOwvEO++D4A8HN1Qwr0AJ+lAjUGsHq9o8BqzRva16/0n83A/af
         ZqSkZo2t1hoGtgt/z97GnRSkuSdRVf5HUlTCyoYmg26CKqUScp6WnMvwwDfF1l9ut3Tc
         Cas+rEGdLW9PdPJGL4Il54COlhK27tMoW3RHNR65HDjyieh8j3ih7zzcRcbdfiycSVnG
         SeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PukgiaOBICcaIwzSn/3zswQF3+WG7vPypHf3Jiv+hKE=;
        b=J8Zb1gBmhJZQW6mTPl0wzAOVUCA2ZKmynuX4n0sLJZXpMtsom2w3lwcxxm6TfU3iMW
         HjO0tKmSmSOK8PdyWIEeMHmTT+PIg3Q3JWpW5eM/4Jmobfu1HmqN6/wDUv0D2ktyN1Wg
         hIbw/uPmcyakbah1hRuJCiA2fDP7AMhVy7aPnPI0YWe0nCUpyTuWoRQY5FI+NnJVjuvz
         DymsjPCLwWdustkVvhG1eg3Ox40aU7+MFOLHmGuqbFOAbADW9KFs+lBHAeGezEJURUGE
         pwHuj1Wsh/KJet75WASyYYF3GCufEQu4OHf2LkSepubEczIC7QIhHVAfwk2Y5jfn0oIm
         I9jg==
X-Gm-Message-State: AGRZ1gKNhzTDvStyc9n1qb72D5xYi3YlQY76Q/2CMMLGkO2s/gDKB9qJ
        cugfuiJ9NsUJ85vzUWgzrus=
X-Google-Smtp-Source: AJdET5exRzV5DvYk5cAh53FpBNCV+gkfkFJ+IEgkX5gFpSv2LIZj0wAuIcBHnTTlxXH0kK8YNL2pLA==
X-Received: by 2002:adf:c7d1:: with SMTP id y17-v6mr5503934wrg.230.1541710273764;
        Thu, 08 Nov 2018 12:51:13 -0800 (PST)
Received: from szeder.dev (x4db97fb9.dyn.telefonica.de. [77.185.127.185])
        by smtp.gmail.com with ESMTPSA id o4-v6sm3019687wrj.45.2018.11.08.12.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 12:51:13 -0800 (PST)
Date:   Thu, 8 Nov 2018 21:51:10 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3] i18n: make GETTEXT_POISON a runtime option
Message-ID: <20181108205110.GB30222@szeder.dev>
References: <20181024114725.3927-1-avarab@gmail.com>
 <20181101193115.32681-1-avarab@gmail.com>
 <20181102163725.GY30222@szeder.dev>
 <87muqj5n9w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87muqj5n9w.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 08, 2018 at 09:26:19PM +0100, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Nov 02 2018, SZEDER Gábor wrote:

> >>  * We error out in the Makefile if you're still saying
> >>    GETTEXT_POISON=YesPlease.
> >>
> >>    This makes more sense than just making it a synonym since now this
> >>    also needs to be defined at runtime.
> >
> > OK, I think erroring out is better than silently ignoring
> > GETTEXT_POISON=YesPlease.  However, the commit message only mentions
> > that GETTEXT_POISON is gone, but perhaps this should be mentioned
> > there as well.
> 
> Will mention.

With the benefit of hindsight gained from looking into a failing
GETTEXT_POISON build [1], I have to agree with Junio that flat-out
erroring out when GETTEXT_POISON=YesPlease is set is really a hassle
[2].

[1] https://public-inbox.org/git/20181107130950.GA30222@szeder.dev/
    (the failure is not related to this patch)
[2] https://public-inbox.org/git/xmqqpnvg8d5z.fsf@gitster-ct.c.googlers.com/

> >> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> >> index 78d8c3783b..2f42b3653c 100644
> >> --- a/t/test-lib-functions.sh
> >> +++ b/t/test-lib-functions.sh
> >> @@ -755,16 +755,16 @@ test_cmp_bin() {
> >>
> >>  # Use this instead of test_cmp to compare files that contain expected and
> >>  # actual output from git commands that can be translated.  When running
> >> -# under GETTEXT_POISON this pretends that the command produced expected
> >> +# under GIT_TEST_GETTEXT_POISON this pretends that the command produced expected
> >>  # results.
> >>  test_i18ncmp () {
> >> -	test -n "$GETTEXT_POISON" || test_cmp "$@"
> >> +	! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"
> >>  }
> >
> >>  test_i18ngrep () {
> >>  	eval "last_arg=\${$#}"
> >> @@ -779,7 +779,7 @@ test_i18ngrep () {
> >>  		error "bug in the test script: too few parameters to test_i18ngrep"
> >>  	fi
> >>
> >> -	if test -n "$GETTEXT_POISON"
> >> +	if test_have_prereq !C_LOCALE_OUTPUT
> >
> > Why do these two helper functions call test_have_prereq (a function
> > that doesn't even fit on my screen) instead of a simple
> >
> >   test -n "$GIT_TEST_GETTEXT_POISON"
> 
> I'm going to keep the call to test_have_prereq, it's consistent with
> other use of the helper in the test lib, and doesn't confuse the reader
> by giving the impression that we're in some really early setup where we
> haven't set the prereq at this point (we have).

Using the prereq in the first place is what confused (and is still
confusing...) the reader.

