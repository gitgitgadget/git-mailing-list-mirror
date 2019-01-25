Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6FBF1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 22:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfAYWB3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 17:01:29 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43905 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYWB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 17:01:28 -0500
Received: by mail-pf1-f201.google.com with SMTP id b8so8640539pfe.10
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 14:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7+ENVlnF4br19E1M7JWt/YXVV5F+x4kuXtyNS8aJOmA=;
        b=Yx02wWDSMvZ0p1t8S7Sz7yPqtoAhBT+cTS3ce11/ZJHgkk9UMc0POLlpzTzWjJTU/C
         40tK7F1VJX+3vyioJe8hSjWF6nM/3w7NP7EZF904yY/BL8kVBT7JhCB/gMj0ABtMZbfK
         Xqx9GNKt/buUuVEQ6QJRUa865KcTXah6iZzhaSeiSTMjO2+zwTI567P7savfAIblTp4J
         k+z4ZbDz766775UWjjzVmkZ9Xk0fLfQr7U9mZnc/mIVREub2kR0nVAZEYHuGjmoZtYY7
         U3rLY8c1pepOdcb/jZX2t8RTFvnVGevUcu0BkCGbzSidZh8dKGf3rBZOE/f9rl/Nqc2C
         aPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7+ENVlnF4br19E1M7JWt/YXVV5F+x4kuXtyNS8aJOmA=;
        b=m+dfLIso0NJcHs+vpgkUHbNUsTkNQxvPmL26TXr8RiBR/Y3PhGm8NJi9SRmfAo6adK
         7rXMTYRztG0eBkW2ON/LjgV1l/W58cRlJZlvwnVdgY/u9IBIFDSJ8WEgJ3kBwtAg8oaq
         KbcpQEu3GPkuM0CoGCOwj4YDnjOPIpBxiFTJvCRXcjXWyfJn01iXuUm1Ok44lMS3Jg0M
         +YaCGUAd2KcGD4iigkchgByECckzlELfRQ0xSubsGsuPGbwPxv6/I+6gF2+U4/J4bqrM
         wrF5l1xAP01VesV5KlxAVT/ohzStsuFBhFXutj2xuBuohBtQT2ite4mC1Wc5XYAMBCYz
         gWLw==
X-Gm-Message-State: AJcUukc72P8xWR7EA9ekAsSrfBxT+S6ChsvfmdO6MHo2vTxSrsKuSSoK
        pqgHKPcUW7m/PYmzFGZH4ISeEMub1Wxx2IB7en5V
X-Google-Smtp-Source: ALg8bN56J1PJAVWdxEEOudFPKmKO3Zk5tiVESaEOVCwxioUpX5WuAJyPrXXhjgKNach4fyni0DiAmlD7uEbDUzwg52G7
X-Received: by 2002:a63:a742:: with SMTP id w2mr5889190pgo.130.1548453688081;
 Fri, 25 Jan 2019 14:01:28 -0800 (PST)
Date:   Fri, 25 Jan 2019 14:01:24 -0800
In-Reply-To: <CAGZ79kZRnuTU3ukP1UdBUZD1x+nubYSwLxYgJse1mcj8JUOa2g@mail.gmail.com>
Message-Id: <20190125220124.68769-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAGZ79kZRnuTU3ukP1UdBUZD1x+nubYSwLxYgJse1mcj8JUOa2g@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: Regression in: [PATCH on sb/more-repo-in-api] revision: use
 commit graph in get_reference()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Have fun! :)
> 
> $ git gc
> ...
> Computing commit graph generation numbers: 100% (164264/164264), done.
> $ ./git version
> git version 2.20.1.775.g2313a6b87fe.dirty
> # pu + one commit addressing
> # https://public-inbox.org/git/CAGZ79kaUg3NTRPRi5mLk6ag87iDB_Ltq_kEiLwZ2HGZ+-Vsd8w@mail.gmail.com/
> 
> $ ./git -c core.commitGraph=false describe --dirty --all
> remotes/gitgitgadget/pu-1-g03745a36e6
> $ ./git -c core.commitGraph=true describe --dirty --all
> remotes/gitgitgadget/pu-1-g03745a36e6
> $ ./git -c core.commitGraph=true describe --dirty
> v2.20.1-776-g03745a36e6
> $ ./git -c core.commitGraph=false describe --dirty
> v2.20.1-776-g03745a36e6
> 
> it looks like it is working correctly here?
> Or did I miss some hint as in how to setup the reproduction properly?

I could reproduce it with version ec0c5798ee (as stated in Szeder's
original email) - as stated by Szeder, it doesn't work, but its parent
does. I'm looking into this, but any help is appreciated.
