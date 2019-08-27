Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3CF1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 13:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfH0Nvy (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 09:51:54 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:36705 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0Nvy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 09:51:54 -0400
Received: by mail-ed1-f44.google.com with SMTP id g24so4181177edu.3
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hh48dPsomqENlAZoIKQf/5eblJf3NppV1t+iNNjgcuc=;
        b=NT7uXbQ3j3MQAfxEbJRXvrzjhdAMOr+Asjn7jM9ozdQwV4hR7v9+Ghy56rtmOS7/ks
         LbQNzCN5nvIwl9x7OUcdS9ZJ6H0mciNmkK23u+OYWYQCiMtIMk0kkGu5Z0CL7xF/vokt
         DF733hKq5g4XcHCW+1qee1mOnmmztnRG9PcwBy6VlyHNc3ka47mD9wqpDmr2RboOx2i0
         uX4qqwT+Leq81I43AX9CbsGGkry1wADQpsJtPUhlGIrOEEyTkG78xxAHALemLZKFTtgX
         GsweoBSlnARjITq1HAdmQ74n13GLCFeTRAJC3+hy3Ve0Y3qm5+LOZJaa488kJbPfYvl5
         umLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hh48dPsomqENlAZoIKQf/5eblJf3NppV1t+iNNjgcuc=;
        b=J9oIUgv8w4sc6GHtHRIWCEqLKDvD2u/if7vVVuGNh3+XKS0OxP6ju12hppRy7OonIL
         N7h+GewGR5Qt8kMdKp/LejxjPnAS6rc8zIsY3A35FuCcsFtCkcYnJtmryV75xqC2x7SX
         qI2k+C77qMNI1d8sTI/UuOOsen2qPVT5a0VYm7Q0IRded0WvXcyjPzqwPvqAUI1XD+Fn
         gAhnuyQ7EWFXofH85IgGvX1SGWyOE3p9iRXjWQcf32lFNuJ3+7EqN9Q7qQPUPpJclcQ1
         mK+liudIOpA+1NaTu7RDSGJvulLhCig+Mb/Uy2kB4XGrzOsJAqgArdjRS/tscfpo2Hgj
         QUZg==
X-Gm-Message-State: APjAAAU/aLA0SEHe5/RhPycv0Z3jLFfKCtSyAZw3Ckcp9tSrdYLAJ3nr
        L3hJ8mZ0HwpaapAE85rRbRu31wpUv/qNdIgA
X-Google-Smtp-Source: APXvYqzFOO9PNGEkmDIHkbRk33bVfNbLhyyiL35JuAdBjMOIOgcYDnGhcCBz1QodS06C5vTeqgqFnA==
X-Received: by 2002:a17:906:3518:: with SMTP id r24mr21440359eja.133.1566913912234;
        Tue, 27 Aug 2019 06:51:52 -0700 (PDT)
Received: from instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal (1.133.65.34.bc.googleusercontent.com. [34.65.133.1])
        by smtp.gmail.com with ESMTPSA id d29sm1994401edj.59.2019.08.27.06.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 06:51:51 -0700 (PDT)
From:   "Giuseppe Crino'" <giuscri@gmail.com>
X-Google-Original-From: Giuseppe Crino' <giuscri>
Date:   Tue, 27 Aug 2019 13:51:49 +0000
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Giuseppe =?iso-8859-1?Q?Crin=F2?= <giuscri@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190827135149.GA1715@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
 <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
 <20190822170817.GB35435@google.com>
 <20190822184312.xhrf2ij3bh3vovrq@localhost.localdomain>
 <20190823082900.GG20404@szeder.dev>
 <20190826191455.GA25695@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826191455.GA25695@sigill.intra.peff.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 03:14:55PM -0400, Jeff King wrote:
> So it might make sense to push these rules into "git mailinfo" instead
> of applying them everywhere. But we'd still need something at least for
> GECOS, where "Your Name,,,," is common.

What's the GECOS you mean?
