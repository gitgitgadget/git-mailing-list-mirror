Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EEF821841
	for <e@80x24.org>; Tue,  1 May 2018 11:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbeEALnV (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:43:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42789 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbeEALnU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:43:20 -0400
Received: by mail-wr0-f194.google.com with SMTP id v5-v6so10592619wrf.9
        for <git@vger.kernel.org>; Tue, 01 May 2018 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oAvvhokKnm04E3jeWp1SdAlDPP4TnBTiVX+32OvZYm8=;
        b=Ottcxu8wWWLU1vpV8PweN14LDBp1IXaL90ktaq+Q2zWL4ZHHVi1+8dSkexz8c/wIBW
         i9xMrW2PheyrHJ8J5C1SBtJCJkd5IX4Q7G3OiBfAt9t/xWmNdBgU9UdFSX1aZXYabHpo
         dIraP0ifSw8QXDfqWfyXxoYfhT1Q5pTHZLA62rCFVaxA5Xzd0qZQq8JsXc3mNDcNWFJq
         u24G1rc4RwGwHwOrQ6SK9vuUi75FH4fh5q2+gsK/hHFh09+GjNGKv/XMU7TRq90Zz0kd
         8AHD49OCGWJssmgG3Pj63+fSl+qXx00LbJmlIlY+Js+bMfFnVipOtvs5oziwCGk6fFj+
         kAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oAvvhokKnm04E3jeWp1SdAlDPP4TnBTiVX+32OvZYm8=;
        b=fq9YbCnVuwW8ML0jGIJEp9ZvreJDP81S6W0/L0V9ZWASAyUGsEebQlM1m1ZTePT4pE
         VDtp/vH4KdGPL88A1vtl7XVSnQLtQnRGvxwpkKBZYJRW0VBxxHU6DpGD4P4gPY4c9H2T
         osX1J6kquOlLGdW9bFmdeRiJp9kvlsyqJzXXQfoveRjvtthHecPO+8oVMx8w3dnFWAdH
         isQEPT9RfsGl9Xgc1DeeBTEUz81x6HC7RGRg/I4zvjZSqEVUTG8bHyCu4SBy6uLG2xgM
         tZF9vB6HHQmwjMlYuCdM2YXmnp6E6SVBiBdaoS4vPlVFf7iyxVrnH1XjhqodtohP6xFE
         2Rkw==
X-Gm-Message-State: ALQs6tCzgGafzFbQy2w6PjXnKBkgNUsZ2f1KpjdKcx+o+4JVAp394bD5
        gLzYmF0PFKR5fiRZg49+X7HPCnVx
X-Google-Smtp-Source: AB8JxZpJEvUNP3KNzJpJSAN+iCZ4H4Hpki3WdYMQZ3oAiVqMwuTZke5L/+umPLoiTcfucxoPe9FGqg==
X-Received: by 2002:adf:988c:: with SMTP id w12-v6mr11115232wrb.215.1525174999226;
        Tue, 01 May 2018 04:43:19 -0700 (PDT)
Received: from esm (ipbcc18eac.dynamic.kabel-deutschland.de. [188.193.142.172])
        by smtp.gmail.com with ESMTPSA id 109-v6sm9375172wra.32.2018.05.01.04.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 04:43:18 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Tue, 1 May 2018 13:43:16 +0200
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Eckhard =?iso-8859-1?Q?S=2E_Maa=DF?= 
        <eckhard.s.maass@googlemail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v2] wt-status: use rename settings from
 init_diff_ui_defaults
Message-ID: <20180501114316.GB13919@esm>
References: <c466854f-6087-e7f1-264a-1d2df9fd9b5a@gmail.com>
 <50c60ddfeb9a44a99f556be2c2ca9a34@BPMBX2013-01.univ-lyon1.fr>
 <907020160.11403426.1525172946040.JavaMail.zimbra@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <907020160.11403426.1525172946040.JavaMail.zimbra@inria.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 01, 2018 at 01:09:06PM +0200, Matthieu Moy wrote:
> That init_diff_ui_defaults() should indeed have been before
> git_config() from the beginning. My bad, I'm the one who
> misplaced it apparently :-(.

Should I have done this "bug fix" in a separate commit or mention it in
the commit message?

> This "break_opt = 0" deserves a mention in the commit message IMHO.
> I'm not 100% sure it's a good change actually.

Hm, what problems do you see here? The purpose of my patch is have the
same kind of output from git status and, after commit, git show. I
cannot find a good reason for git status to behave there differently,
but I am interested to see where I am wrong.

On the other hand, one could a configuration option to the diff.* family
for controlling that toggle also.

Greetings,
Eckhard
