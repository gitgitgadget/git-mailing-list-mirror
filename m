Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B3C208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 14:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbeHFQ4z (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 12:56:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41774 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbeHFQ4z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 12:56:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id y10-v6so6981153pfn.8
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VxrlFI8nhV5lLFrdbpEb59NfDk1wTeHS9ZpSGXyZWxQ=;
        b=tXmlpCCAMCrnYAa+5HB8AZkx9MEPEECuJEJiM/45HCiemW2ekqBjF0csyWzsCejJg8
         XDOL3b8aVxg83V5WVRIuwI2F0/zGU5O3dHj1S1hfbbyhfIRQ9EkA4J/mNvx89hQ7sbtS
         RVcKZ0nBU3CuFE6+qXDbfFDi8xsXQYWoHr4y4EGnvkZMpqFQEw33BNTBzU6FXPHtYZQG
         1zOj9HYmcpY/CE+pF3jPHgeixcXAlJoHOUmNbMOj4Flw9k6RaRANs0yxR91Lhg1CBycS
         FQ/EHA/O/C95bNCD8UhU/17IjDNkDInNVgEH/Z/Bou2mLfboI/AD6na9XJ7E7ZBTC6ZA
         56AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VxrlFI8nhV5lLFrdbpEb59NfDk1wTeHS9ZpSGXyZWxQ=;
        b=XCP+TEJQw9+nqz97WFjC8w9Rr1oTw9QfmsKr4UJWLeFFd+Wbe8h2gTLrt7eZdf7oTX
         4a5cX16G1AL9gQ+URxXleAi14m5NLDMNHzmcE1fYwaRG/P2TnaAABGC6zUnJvsHQd4Cz
         WD0p7eZzVifCDdo3GUzNbhRcIo2QZm1rJpnMetXXPb9mcCElzhRXIvW08C5CdAlyGbDl
         EuDdfGcGcf9KH4mgu8pg9jFmYYOzC3HAW5Jmwxy8YHyNuccoCGfFrtXygYDTcf/Ihg8X
         H1lB85MDlPsDMDEWTp/1LsTUxBsSoHrhbxzE4yzpUJgxk0NLoGjyFrpuPx+n+qFDtcm/
         Ggrg==
X-Gm-Message-State: AOUpUlFc3vDqMdV6zxGAllFv2MufaW7oU26nakMTBOk5f0CF5GBPdRcj
        TE00qe+x6pR/nZ7jxekiV2NWvksa
X-Google-Smtp-Source: AAOMgpc9lh69RXJqCJ5egqbM/h2A5RxBsx/NP8m2brR2YqMq2eNZnla+JFQiX15uaH7y0PIwDLRfzA==
X-Received: by 2002:a62:1089:: with SMTP id 9-v6mr17077482pfq.30.1533566848812;
        Mon, 06 Aug 2018 07:47:28 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b62-v6sm22283486pfm.97.2018.08.06.07.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 07:47:28 -0700 (PDT)
Date:   Mon, 6 Aug 2018 07:47:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] line-log: demonstrate a bug with nearly-overlapping
 ranges
Message-ID: <20180806144726.GB97564@aiede.svl.corp.google.com>
References: <pull.15.git.gitgitgadget@gmail.com>
 <cab7bb36eb85dbe38ad95ee02b083f11f0820e24.1533421100.git.gitgitgadget@gmail.com>
 <20180805015908.GE258270@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1808061216060.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808061216060.71@tvgsbejvaqbjf.bet>
User-Agent: Mutt/+ (31e72e18) (2018-08-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Johannes Schindelin wrote:
> On Sat, 4 Aug 2018, Jonathan Nieder wrote:

>> Alternatively, could it be squashed in with the patch that fixes it?
>
> There is this really awful trend on this mailing list to suggest
> conflating the demonstration of a bug with the bug fix.
>
> It is really, really important to realize how valuable it is to have the
> regression test as an individual patch that can be used to verify that
> there is a bug, to pinpoint where it was introduced, to test alternative
> fixes, to keep records separate, and I could go on and on and on. Please
> do not ignore these very good reasons, and please refrain from
> recommending such conflation in the future.

If you want to propose changing the project's style to always separate
tests from the patch that fixes a bug, that's a discussion we can have,
in a separate thread.

Today, we do allow and encourage putting the test with the patch that
fixes it, and that has real advantages:

- the tests are easier to understand when found with "git log" because
  they are in context

- as the patch evolves, it is easier to remember to update the test at
  the same time

- newcomers imitating existing patches have a clear hint to write
  tests

- the beginning of a patch series can be applied and merged down while
  the end is still under review, without either leaving out the tests
  or applying a test that doesn't pass and accomplishes little

I've never found it difficult to use the test from a patch to verify
that there is a bug or pinpoint where it was introduced.  Tests are
separate from the application code since they're in the t/ directory;
this is a very easy thing to do.  That isn't to say that a patch that
only adds a (passing or expected-failure) test isn't valuable, even
without a fix.  It is valuable, precisely when it is self-explanatory.

More importantly, I am a bit surprised that instead of accepting the
feedback, you are basically calling a reviewer complicit, for pointing
out a pretty normal possible improvement that follows the project's
conventions.

I'm beyond words.

Jonathan
