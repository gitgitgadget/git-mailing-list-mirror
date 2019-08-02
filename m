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
	by dcvr.yhbt.net (Postfix) with ESMTP id 576561F731
	for <e@80x24.org>; Fri,  2 Aug 2019 19:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405999AbfHBTiz (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 15:38:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41444 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403792AbfHBTiz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 15:38:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so75072318wrm.8
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H4E3t8GmgqLvuS7GGBNt272CUX05od3SC77c3vpMdp8=;
        b=SNT4KDJhNy4IAxnzIfDrK3Tiduq/W87abhJINn28jNubYJhBal/1blW5jYzEacbdrO
         5+VBE9kLnx58H882iW/w/njw2vcNTjVX9kewfYnYibjwGZThww8FcOdbXjKSqjQvB4eo
         ei64b3sn3FJoZK6tFKupRT4K+ziD+hCw4E0RYECaqodHsFZyAJyxJIxV29DhQuZ7DuDQ
         OEAQXENEvY++gHcXXaSnFRTOh9pPgAUFjkyXfVlwGZKOSO/MOVnBzp2Odnb2yF+u6inR
         DkKoSgm/Evq+KShA/keWmXFZRfGxXcr1SJIM9Qof+j3tWw7tY9aA/iRlNHW4pUhepYGf
         6PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H4E3t8GmgqLvuS7GGBNt272CUX05od3SC77c3vpMdp8=;
        b=JkrmN2d2yrBKPPEHy+4jP6Jjpgwr+VqQddi45kMYUGAzb+tmD58M/IMb2ySTF8+MMI
         7RXagt45VffSCcUQ7VdaggvNp+3CNjcYdDdWoZ//UisZtM2eRlie6muGK3oGJJxekLZt
         uxAQFr5Htrqo8ESyIlAyH0FXUhFam2pDnvdnAD9hcgg+Y+gWhoehcDW498geXJq9OgHD
         zslgajyavu17wY2kaBZIhzKZ8JmsuQdHb0XSWgMP8vMK7O3wTNu8BLAIM9DuOwLNxqsV
         A10gzyrcC503fIABWkqX16i1rapI9wHsvycr0l/ATCXVuDZ1zR/aabz2lpGhh8LMjNJv
         DoSg==
X-Gm-Message-State: APjAAAVCOLM7tUOrauzd42e7NDbsQ3c4xv4hyO3iv0fIAtPZX8z+qKgt
        3UsEmYBcPg2Mmsi4j3uY310=
X-Google-Smtp-Source: APXvYqzb0B7pozSWsEiUrCyZaIsIOEj1bs0xOG8HnH4CScIijr9kBSYFvXe/5Mbv0I5ad4IwX7AWPw==
X-Received: by 2002:adf:de10:: with SMTP id b16mr112579271wrm.296.1564774733149;
        Fri, 02 Aug 2019 12:38:53 -0700 (PDT)
Received: from szeder.dev (x4d0c4277.dyn.telefonica.de. [77.12.66.119])
        by smtp.gmail.com with ESMTPSA id p63sm26916662wmp.45.2019.08.02.12.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 12:38:52 -0700 (PDT)
Date:   Fri, 2 Aug 2019 21:38:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, git@jeffhostetler.com, avarab@gmail.com,
        peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190802193849.GX20404@szeder.dev>
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
 <20190725234229.GM20404@szeder.dev>
 <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet>
 <20190726220348.GF43313@google.com>
 <20190801180829.GP43313@google.com>
 <20190802015247.GA54514@google.com>
 <nycvar.QRO.7.76.6.1908021347580.46@tvgsbejvaqbjf.bet>
 <20190802165913.GA109863@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190802165913.GA109863@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 02, 2019 at 09:59:13AM -0700, Jonathan Nieder wrote:
> The exhaustive approach really helps.  Arguing against it kind of
> feels like saying "leak checkers are great, but why run one on the
> full test suite instead of a dedicated tool that exercises the code
> paths where you expect to find leaks?"

Not at all.  We don't run any leak checker on the full test suite as
part of each and every CI build, do we?  And just like no one is
arguing against you running a leak checker on the full test suite, no
one is arguing against you running a JSON schema validation on the
full test suite, either.

> In the short term, we can run tests internally to check that Git keeps
> following the schema.  Let's not block patches 1 and 2 by this ---

To my understanding patch 2 is only a proof of concept: it starts
using a programming language that has not been used before in this
project, to implement functionality that is readily available in
several existing tools, without even arguing (let alone convincingly
arguing) in the commit message why this approach is a good idea.

