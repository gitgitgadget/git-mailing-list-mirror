Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1A51F461
	for <e@80x24.org>; Sun,  8 Sep 2019 14:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfIHONR (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 10:13:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36338 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfIHONR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 10:13:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id p13so11808123wmh.1
        for <git@vger.kernel.org>; Sun, 08 Sep 2019 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1phCB0JsfeGWixTLxhvburIhJ80mpXjlk3+GOcyl2h4=;
        b=BTypbxIMjADzVWMPvqiX0jSynztORfQ3FWC5yHEztlItlPGg35A8m6LcycLDeFCvZU
         JtsBe34lQjBPOG0qQd+gBOc6ouQQG3AFEvYKQIzQKCQARTt7ZADTKU8gO/bJmaDuGikg
         8o0r+9JvAZbDidVxkV9FizAfqh7y2TF8k2hNykMgNBnrryJ0HwQTXRpKmtwjl1Ff6hCB
         xP7tNpJSS/tVBhjEdc3G1DK0SnikyepiEQ3ZRz8VESb3c5r47aEKu9OJByo3xsttThyM
         Q0ibyjJ1pioIXQETlIbRr+mwkSJUFPbwlkcTcknZJLzwtNMtmKZu2iQNd+GfODGtpKXk
         tMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1phCB0JsfeGWixTLxhvburIhJ80mpXjlk3+GOcyl2h4=;
        b=KO8jDwLUmH6zmRUnJyziMxClqfKzWsKhDTriJ0o+If/5ymB0ArqcWsedHsw6XC0fuI
         t7iquX4wghKjQDPR5lAUxr7CNs2eSXL/F90RIAKwzkt4zxFg7X7KbSk3ffFTV/toW0WR
         nHOh8zz/51RZ0dtxqtBAA9/B5eRon58hKzxzm6IUKIYZ/Jv5FPQ9JBv1+PfTFK4AbWMS
         rBcNCRIfbnLTHP3I2/0x5SbrUMYeJ6hlR0xp5Zl7hqfMOiD1MKcqEcEZCvvJD5ktK6+w
         u80NIJ0/QPbCiPv/Pby2lUptH9Ey0SacE0QIRLQBFpPyTqdJ3Z2T/5FIeN9KZ3UMQ1Qb
         QRqw==
X-Gm-Message-State: APjAAAXnYmdt+gX744k4KQk7pLgerBOYP8/XL5kdP9pMxvc3ft2zxdH7
        QJq35FVkAUs9LUp92InjPBg=
X-Google-Smtp-Source: APXvYqyvEtwwvuqGQUyBwgkSu47h6WBtcLLrS3RqFd7pdHHaL2DmZ2bFr1/kryCATc3Pv8c0aYs8ug==
X-Received: by 2002:a1c:1a4b:: with SMTP id a72mr15068478wma.44.1567951994787;
        Sun, 08 Sep 2019 07:13:14 -0700 (PDT)
Received: from szeder.dev (x4dbd3a66.dyn.telefonica.de. [77.189.58.102])
        by smtp.gmail.com with ESMTPSA id z11sm8637114wrg.17.2019.09.08.07.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Sep 2019 07:13:14 -0700 (PDT)
Date:   Sun, 8 Sep 2019 16:13:08 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix build with Asciidoctor 2
Message-ID: <20190908141308.GA7255@szeder.dev>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190907170746.273984-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190907170746.273984-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 07, 2019 at 05:07:46PM +0000, brian m. carlson wrote:
> Our documentation toolchain has traditionally been built around DocBook
> 4.5.  This version of DocBook is the last DTD-based version of DocBook.
> In 2009, DocBook 5 was introduced using namespaces and its syntax is
> expressed in RELAX-NG, which is more expressive and allows a wider
> variety of syntax forms.
> 
> Asciidoctor, one of the alternatives for building our documentation,
> dropped support for DocBook 4.5 in its recent 2.0 release and now only
> supports DocBook 5.  This would not be a problem but for the fact that
> we use xmlto, which is still stuck in the DocBook 4.5 era.
> 
> xmlto performs DTD validation as part of the build process.  This is not
> problematic for DocBook 4.5, which has a valid DTD, but it clearly
> cannot work for DocBook 5, since no DTD can adequately express its full
> syntax.  In addition, even if xmlto did support RELAX-NG validation,
> that wouldn't be sufficient because it uses the libxml2-based xmllint to
> do so, which has known problems with validating interleaves in RELAX-NG.
> 
> Fortunately, there's an easy way forward: ask Asciidoctor to use its
> DocBook 5 backend and tell xmlto to skip validation.  Asciidoctor has
> supported DocBook 5 since v0.1.4 in 2013 and xmlto has supported
> skipping validation for probably longer than that.
> 
> xmlto will still use the non-namespaced DocBook XSL stylesheets (which
> are designed for DocBook 4.5) for building the documentation instead of
> the namespaced ones (which are designed for DocBook 5).  This isn't
> really a problem, since both forms are built from the same source and
> can handle both versions, but it does mean that an ugly message about
> the stylesheets stripping the namespace will be printed to standard
> error.

These messages from 'xmlto' look like these, and there are a lot of
them:

  Note: namesp. cut : stripped namespace before processing      Git User Manual
  Note: namesp. cut : stripped namespace before processing      git-sh-setup(1)
  Note: namesp. cut : stripped namespace before processing      git-get-tar-commit-id(1)

Unfortunately, these messages to standard error cause our CI builds to
fail [1].

In the Documentation build job we check that there was nothing printed
to standard error during 'make doc', in order to catch warnings that
are potential signs of a mis-rendered documentation, but do not cause
any asciidoc/asciidoctor/xmlto commands (and thus 'make doc') to fail.

Now, a few recent messages to standard error that indeed were signs of
mis-rendered docs [2] looked like this:

  asciidoctor: WARNING: api-config.txt: line 232: unterminated listing block

i.e. they came from Asciidoctor and were all-caps warnings.

OTOH, these "stripped namespace" messages come from 'xmlto', are not
warnings but have that "Note:" prefix, and, trusting that you did
check the results thoroughly, are apparently not a sign of any
rendering issues.  So I think it's safe to ignore them and this patch
should strip them from 'make doc's output in
'ci/test-documentation.sh'.

Related: after this patch we might want to update the CI builds to use
Asciidoctor 2 instead of sticking with 1.5.8.


[1] With Asciidoctor 1.5.8:

      https://travis-ci.org/szeder/git/jobs/582294090#L2085

    With an additional patch on top to use Asciidoctor 2:

      https://travis-ci.org/szeder/git/jobs/582294243#L2066

[2] See 'git log -3 b373e4d29b'


