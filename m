Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 797551F731
	for <e@80x24.org>; Sat,  3 Aug 2019 07:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfHCHfz (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 03:35:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53998 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfHCHfy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 03:35:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so70056548wmj.3
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 00:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=unRsy8CB4UKp7S9EIFGBifdoTLSAhxWQX7efTfF6WNA=;
        b=bKy8Fi8ZEDq+OJ4PApLcu7hF33Nls+Jt8VBDLdroKnBx5IOWa5nIJlJ5pK/STDZcl9
         1YHBs/1gCNIhxSipj37nyjVKea358zzv50qlF8JJ215uVXWl1dJ+K1P+IR8lEqkUbq43
         OVhrsplyU4VnEjfqfZNn6qsj9MAnkKbyjLPjc1B7oHgfalmPDIiJLixm/2L0r8ftPzv3
         cAgwpMRYfCQfHFL1dCrg+bpYrCiz8DYGLoKdzCjdc9EGqN2khr0v49foCYZzoT9cvNsA
         Rns4a0+jiRdmM6GvKv6tXmUg/2DDLHBVYBr0QmtcZ8r3wbVbaZN1XdL88kkYAmP6i8S7
         BH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=unRsy8CB4UKp7S9EIFGBifdoTLSAhxWQX7efTfF6WNA=;
        b=GEoISZWi0ORMSiUYZlLmRyeBaryPEQxKc28mBJcQZNtgAJmdd1HA7URkpB79uwihZP
         OyuOoJuguZe+Pz2xuE8s6VSnAe0Kc2GZ592cEI1eG2K5rV8JE8Da8T+Hte/lb5nkvBI5
         Ski5qm83PL2uphP04g+B+HA9KKQmmGZHxAiQWtbq/wKZ2U+85hCcYJNZnCg4YqdhkqwX
         v8NDQYDV43eTWSOvhFS3hDH4CLjjfc4r40aREOumyJNPtsNPxiwKKv5aWq/ftNwySJbP
         P9g3gkSWP3fK0bLGzABCb0U5vyT67SGZuMd3/tNMT/n3UHYXlyDRI41Tzr6YnYy46ADC
         zzMA==
X-Gm-Message-State: APjAAAW2RAXpm50LcXXo54b+Rx2xBV/i+CXBKUI2wjjpecOOZRs/mZVJ
        WMejhuWpYJ2B3gFBJTkUivY=
X-Google-Smtp-Source: APXvYqxZoO88uo+HgyT7FHBBCeT1E/R7dhAk7RYw6DPN4L/MoqXRhh1okyCrrw5eMfdaNlais3AdAQ==
X-Received: by 2002:a05:600c:230c:: with SMTP id 12mr8087423wmo.151.1564817752935;
        Sat, 03 Aug 2019 00:35:52 -0700 (PDT)
Received: from szeder.dev (x4db55264.dyn.telefonica.de. [77.181.82.100])
        by smtp.gmail.com with ESMTPSA id v29sm13149318wrv.74.2019.08.03.00.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 00:35:52 -0700 (PDT)
Date:   Sat, 3 Aug 2019 09:35:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190803073549.GY20404@szeder.dev>
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
 <20190725234229.GM20404@szeder.dev>
 <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet>
 <20190726220348.GF43313@google.com>
 <20190801180829.GP43313@google.com>
 <20190802015247.GA54514@google.com>
 <20190802191607.GW20404@szeder.dev>
 <20190802230650.GB109863@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802230650.GB109863@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 02, 2019 at 04:06:50PM -0700, Jonathan Nieder wrote:
> SZEDER Gábor wrote:
> > On Thu, Aug 01, 2019 at 06:52:47PM -0700, Jonathan Nieder wrote:
> 
> >> Gábor, if we introduce such a parameter, do you think it would make
> >> sense for us to set up a worker that passes it?
> >
> > That would be even worse than the current approach of the third patch,
> > because the additional worker would have to install dependencies,
> > build Git and run the test suite, in addition to the enormous overhead
> > of redundantly validating the trace output of every git command
> > executed during 'make test'.  So instead of adding "only" 10 minutes
> > to every build, it would add over 20.
> 
> Thanks, that's helpful to know.
> 
> It sounds like if we want to run this kind of expensive test in CI, we
> would want to set it up differently: e.g. daily runs against "pu"
> instead of running on every push.

OK, I think that sounds acceptable, though I would suggest to:

  - Limit it to 'git/git's 'pu' branch, so others can have their own
    'pu' branch without suffering from the consequences.
    It seems easy to do so, on Travis CI these are available in the
    TRAVIS_BRANCH and TRAVIS_REPO_SLUG environment variables.
    I'm not sure what are the equivalent variables on Azure Pipelines,
    though.

  - Additionally, check an environment variable with a name like
    GIT_CI_RUN_EXPENSIVE_JSON_SCHEMA_VALIDATION or something, and if
    set, then, well, run the schema validation anyway, no matter what
    repo and what branch is being checked.  This way if a contributor
    cares about schema validation that deeply, then they can set this
    env var in Travis CI's repo settings panel for all or for specific
    branches, and thus enable validation on those branches of their
    git fork, without having to modify any files in the repository.

