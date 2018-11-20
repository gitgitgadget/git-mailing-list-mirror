Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7BDB1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 01:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeKTLfm (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 06:35:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36469 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeKTLfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 06:35:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so138814pfc.3
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 17:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=meJ0eow8MAwu1tUh4r5y+Cpt/jRAVoFgo3itElSkHJM=;
        b=Zk/GPNu6FSjEwGTBEQUvJu1YC0IPkEUoyn+32SPko1EIEoEFAkqmpRAcLu4Y79bGhC
         hFL7/ZgO+eyZU6jZkj2gdgNivnp8ZwmqldvlewWpFwvo9DW4HJ13ffvKTBnivhl1Kw69
         PXzM5skzT2zebmodoSkQRexnQ7wrunK+RJSngKGextNROTFqwQN9w0CHOCWfwBSAOV1c
         s1iUehqiUUS9kDqDEqYWmkJHQRnN1Ng1Bki1Etj5hUOFtdmdEoqFt13rjnx763dsWI/1
         /tqUjxsQ1XEhT7f6mfPCrpLSo5QPDvYNh6MR+gYTJ6EHUv41sni4uUkRwZislGXJvCY3
         cp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=meJ0eow8MAwu1tUh4r5y+Cpt/jRAVoFgo3itElSkHJM=;
        b=oMzvVaWJrH4E3DTB3ZQabRfsSXVL9lpUxy5v+kBFVhJaLL+KyNdjN3aMecwLtYs+BQ
         IfyO79wvyyeX+R2Q9Q25fjNRC9Qjbss37UsyPLC2scW4+5kKmxpxHHME5mGvCy8jPr2s
         C4y+fqktTTY2cFA9hCw/xa02vHECw9m09UY0TBoAVain9dCtnVXRdvB0NMW1oDu6/dnP
         u1VXnfIj87Bmg0ivbCiSKM78K9SVnibA5nJSzln3po6A80St8zylt2uAZlW5+WsmcSh0
         pZKRBmI8dwcOy9Z6IlDe5xalbBWcYI2xGHOtExsiADXSsPZbYqF8nncYC+ELAJfi0skD
         +6iw==
X-Gm-Message-State: AGRZ1gJ1AG0x2GQizl8wHrqsiRPddDVUdtNIQRdFLxrg3KL/eV6WOXnT
        pyIY9jRIyNdATsZx6nL31h0=
X-Google-Smtp-Source: AJdET5fPITBEMGM/6E6yhi465S5NshVkf7LquMzN4SanktfEHQhJzV3f6L1BoL6ALJXrc+XEv9pg4g==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr21897098pgh.394.1542676154309;
        Mon, 19 Nov 2018 17:09:14 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id p6sm19908341pfn.53.2018.11.19.17.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 17:09:13 -0800 (PST)
Date:   Mon, 19 Nov 2018 17:09:11 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
Message-ID: <20181120010911.GA62243@google.com>
References: <20181115005546.212538-1-sxenos@google.com>
 <nycvar.QRO.7.76.6.1811151344490.41@tvgsbejvaqbjf.bet>
 <CAPL8Zitk1UBxpVCRWc-SV+1MtaOCJUOYUqCh7eJQcdR_wqpNfQ@mail.gmail.com>
 <20181119155545.GT30222@szeder.dev>
 <CAPL8ZivQGGrxjerGxd_R42mJ2XCi_fFcOji3PL0=pWRAZ_OJQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPL8ZivQGGrxjerGxd_R42mJ2XCi_fFcOji3PL0=pWRAZ_OJQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Xenos wrote:

> But since several comments have focused on the commands, let's brainstorm!
>
> Here's some options that occur to me:
>
> 1. Three commands: evolve + change + obslog as top-level commands (the
> current proposal). Change gets a bunch of subcommands for manipulating
> the change graph and metas/ namespace.
>
> 2. All top-level: evolve + lschange + mkchange + rmchange +
> prunechange + obslog. None of the commands get subcommands.
>
> 3. Everything under change: "change evolve", "change obslog" become
> new change subcommands.
>
> 4. Evolve as a rebase argument, obslog as a log argument. Use "rebase
> --evolve" to initiate evolve and use "log --obslog" to initiate
> obslog. The change command stays as it is in the proposal.
>
> 5. Two commands: evolve + change. obslog becomes a "log" argument.
>
> Note that there will be more "evolve"-specific arguments in the
> future. For most transformations that evolve uses, there will be a
> matching argument to enable or disable that transformation and as we
> add transformations we'll also add arguments.
>
> If we go with option 3, it would make for a very cluttered help page.
> For example, if you're looking for information on how to use evolve,
> you'd have to scroll past a bunch of formatting information that are
> only relevant to obslog... and if you're looking for the formatting
> options, you'd have to scroll past a bunch of
> transformation-enablement options that are only relevant to evolve.
>
> Based on your log feedback above, I'm thinking #5 may make sense.

(5) sounds good to me, too.  Thanks, both, for your thoughtfulness.

Jonathan
