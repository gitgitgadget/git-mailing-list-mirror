Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B37C1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 01:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfHBBwv (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 21:52:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45363 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfHBBwv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 21:52:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so35105283pfq.12
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 18:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8GNpvMGKJ4yRaBEu96iEuq6qevKQzWy36Fx4aAc5EeM=;
        b=aiSby+piwUnkIwTdyoALCjDiIFLC0vPnQWO0R+EEDJ+rwh8V0DcL5femNbmN7HPQS5
         tAl+toqk/ogtz1ozU59tlHPRkqyZjS10QLi3/eB9i8uRTm5mtMnCcrAV0CtTYSVg8Beq
         vO7Ce04iGHWi6FHYydSFg+QNDZhAwqlFXeoc45u1PdccXKQV85/xLYdzflMQC2P+sHGF
         GwngItcp4EAqoFz6MoqupIFq7wY7HC2bdL396NvT8pSpYDalhCY7FFQ5lJFv/b3ffGW/
         2QQVXbInCMbH0fSpHi3tTGJ5yOl8WkM4xfjelua6e/NpMpYvwH6F8S3Hf2nCztGAIqBE
         QHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8GNpvMGKJ4yRaBEu96iEuq6qevKQzWy36Fx4aAc5EeM=;
        b=ISRHihFC59sd3XNw3Ds/GYI8k9HjwYxXha50scKhMP3auXx/YpeAmAONhHIGEUav4E
         40h5VAWsdFiRkA1++cJ1QHBVTN+YgqXPAOAhHxf14WsHC9MIC+W14kqOtNP3xxFmkoDv
         xCH+9Bp0042zMT6JmGlfU7zB76oSBxIoh85be6u8/NAZ63N8zSsUz0moSligLRhfUlRv
         EyxTbO544SeXyfpQRBbTsCORfz3RSRad15IJ/SOVyk0HnyaLZ5bV0aYkBGM/eaFHdLZu
         woCsL9t5AoE5yqU1PkDOz9v4VFXr83ZDkOUjCtTsPAtCBu5BEs9ohgnTawJpbQz4ivVM
         ypFg==
X-Gm-Message-State: APjAAAWkJi9QwU+0E9qZoYwTkh7gPg5zgTgKmsTRdA395oDPOvkRuDQL
        aB7U004YSehiJf/i40f0zCY=
X-Google-Smtp-Source: APXvYqwzt/qnUOUZjgKw0JTVbKQo8FxtNYP4Qv4U8kMVYO1P/c6DseZVbXdooUwGKLfeAT4zZG1zgw==
X-Received: by 2002:aa7:8007:: with SMTP id j7mr56293516pfi.154.1564710770447;
        Thu, 01 Aug 2019 18:52:50 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id l44sm5676819pje.29.2019.08.01.18.52.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:52:49 -0700 (PDT)
Date:   Thu, 1 Aug 2019 18:52:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190802015247.GA54514@google.com>
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
 <20190725234229.GM20404@szeder.dev>
 <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet>
 <20190726220348.GF43313@google.com>
 <20190801180829.GP43313@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190801180829.GP43313@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon wrote:
> On 2019.07.26 15:03, Josh Steadmon wrote:

>> [ajv-cli] can validate the full 1.7M line trace output in just over a
>> minute. Moreover, it has helpful output when validation fails. So I
>> would be happy to re-implement this using ajv-cli.
>
> Unfortunately, ajv on Travis is much slower than on my work machine. It
> still takes over 10 minutes to complete, and is killed by Travis since
> it doesn't provide any progress indicator while it's running.

Alas.

What do you think of making the validation disabled by default and
using a parameter (see "Running tests with special setups" in
t/README) to turn it on?  That way, it should be okay for it to take
10 minutes because this would only affect such specialized workers as
choose to set that parameter, instead of all of them.

Gábor, if we introduce such a parameter, do you think it would make
sense for us to set up a worker that passes it?

> How would people feel about validating a sample of the "make test"
> output? In the short term we could just use command-line tools to sample
> the trace file; for the long-term, we could add a sampling config option
> for trace2 (I've been considering adding this for other reasons anyway).

I kind of like the idea of a "make smoke" that runs some fast
probabilistic tests for interactive use, but for CI runs I prefer the
thoroughness of running the full testsuite.  So for the problem at
hand, I prefer making the test optional and reliable instead of fast
and nondeterministic.

> Ideally we would want the sample to be deterministic for any given
> commit, so that we don't end up with flaky tests if changes are made to
> trace2 while neglecting to update the schema.

That would make it hard to bisect to track down bugs, so I don't like
it as much.

> Since there have been some suggestions to build a standalone test and
> verify its trace output, let me reiterate why I feel it's useful to use
> "make test" instead: I do not feel that I can create a standalone test
> that exercises a wide enough selection of code paths to get sufficient
> coverage of all potential trace2 output. Trying to make a standalone
> test that also anticipates future development is practically impossible.
> Using "make test" means that I can rely on the whole community to
> identify important code paths, both now and in the future.

I agree.

> As always, I am open to other approaches to make sure the schema stays
> up-to-date.

It sounds like the codegen approach would be a nice way to do that,
but that doesn't need to block this step in the right direction.

Thanks for your thoughtfulness,
Jonathan
