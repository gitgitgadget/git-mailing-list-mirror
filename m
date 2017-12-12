Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8651A1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 20:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbdLLUOP (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 15:14:15 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:40996 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbdLLUOO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 15:14:14 -0500
Received: by mail-wr0-f182.google.com with SMTP id z18so79429wrb.8
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 12:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vg8BdfLR4u4gSYaT6Pdcxi0U/k8eTDx0FPpd6EACWms=;
        b=JFAPUsmHjEq6klkJBZr/J9r8axyV87RrdVi9i7fPGw7+M2+y6/HVmLJDpXaGxLtIuI
         3Msb7ZNCilfw8H//Kyq35SDy/jTERWJD79LtGlEugGxV+zS7qCZEY6BPt4cVqSZ3xINL
         igtfhVHF8qLhZ6sUBk6xWdFgUhTw/hfeUHAKn6tuJ3w0+iK/GQBoSCns3lBRmjbAUMnR
         tJMUiaqElxY34N7imc3c5KEYzho37HjD5Gb/6kdjG2HRz6x3u/GnLRscFFXEjqWzUKB7
         AWcLF8USXdmo9gsnUDjE63z7aAqjyImjqkqJsrsQQNnVuDRoURHC+UAamnJjZ/BqigVD
         nimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vg8BdfLR4u4gSYaT6Pdcxi0U/k8eTDx0FPpd6EACWms=;
        b=s4MCQL6XwNPzoJKQ2TFREgm0J9dDRXo6Br8m9PgraBvgMoJlUOduneij3tyabseFGl
         aRzqye3D10BL57K2yfmDdqtMYqqIn2cG3AysCMu/YS4xEBw6+v13ci03GjjXAlqG3JmI
         IKvKVNtxBX4iq57FKFktIud4lz9t8ZajOfY4s4GvSKUZ4JLIVCnDsqTLdeJRY56vZgbV
         XYYMYEfhBHdMfb0sfuTx+zZPoU8KYpo/GYBKlASOKbfybxo7RM6hv319FomwYGcWTH7S
         8q1AY1BDKmqIeEYyVU43aQniNkz6HBu0a16uJoau+GXrA+FR8Y6Fj6okjAxgjZnBWdvh
         0cfA==
X-Gm-Message-State: AKGB3mLxeeysMBQ9bL2c8VItkNlrQ2sNANBObyYJgxnnOlEqPR5abwMQ
        U86oi73Mr+8G9sWzFa6BiCQ=
X-Google-Smtp-Source: ACJfBoutZS9FtTc1f1mC0d8cFMzaYwgT2j+Sb1KAfmH/ZNaZTZxNcqAzfy+jsEvEwdnMnry+/BU3cg==
X-Received: by 10.223.163.216 with SMTP id m24mr54377wrb.107.1513109653306;
        Tue, 12 Dec 2017 12:14:13 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id v18sm20992495wrv.37.2017.12.12.12.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Dec 2017 12:14:12 -0800 (PST)
Date:   Tue, 12 Dec 2017 20:15:58 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
Message-ID: <20171212201558.GB24597@hank>
References: <20171210212202.28231-4-t.gummerer@gmail.com>
 <20171211210948.6867-1-szeder.dev@gmail.com>
 <20171211214255.GA24597@hank>
 <C5F93DFF-D3DF-4507-8546-941BFA768705@gmail.com>
 <xmqq609b3gi3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq609b3gi3.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/12, Junio C Hamano wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> >> You're right, it's my first time using travis CI and I got confused
> >> about how the .travis.yml works, thanks for catching that.  Will
> >> re-phrase the commit message.
> >
> > Szeder is spot on. If you fix up the message, then this patch looks
> > perfect! Pragmatic (= very good!) idea to combine GITTEXT_POISON with 
> > GIT_TEST_SPLIT_INDEX :-)
> 
> I am failing to guess the real intent of the smiley here.
> 
> If split-index code is so easy to break, I do not think it is a good
> idea to combine it into the poison build.  In fact, the poison test
> is useless on a codebase where other/real breakages are expected to
> exist, because it is about seeing messages meant for non-humans are
> not passed to the _() mechanism by sloppy coding, and the way it
> does so is to corrupt all the messages that come through the _()
> mechanism.  If we do not even produce a message when a correct code
> _should_ produce one, poison test would catch nothing useful.

The breakages wen the split-index code fails tend to break things in
much more obvious manners than a wrong message, usually git ends up
dying if it gets broken.  Both of the bugs that were fixed here would
have been caught with the change in my patch.

But yeah I can see the argument that it doesn't give us a guarantee
that it catches all things the test suite could catch.

> I wonder if it makes more sense to update ci/run-tests.sh so that
> its final step is run twice with different settings, like so?

I kind of wanted to avoid that, because it ends up running the test
suite twice on travis for every test, which seems a bit overkill.  But
I don't exactly how worried we are about cycles on travis (I don't
check it very often personally, so I don't really know).  If we aren't
worried about cycles what you have below would certainly make sense.

>  ci/run-tests.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ci/run-tests.sh b/ci/run-tests.sh
> index f0c743de94..15a5f5a6cc 100755
> --- a/ci/run-tests.sh
> +++ b/ci/run-tests.sh
> @@ -8,3 +8,4 @@
>  mkdir -p $HOME/travis-cache
>  ln -s $HOME/travis-cache/.prove t/.prove
>  make --quiet test
> +GIT_TEST_SPLIT_INDEX=LetsTryIt make --quiet test
