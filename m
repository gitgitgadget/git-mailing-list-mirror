Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5921F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 04:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeJLMFB (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 08:05:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40732 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeJLMFB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 08:05:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id z204-v6so11572838wmc.5
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 21:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Lk7dIebT6CFlulMSTUnnCpdqDMDrExQxqNyGb2hQ43E=;
        b=gK9miQwnRzS3xxm/68etIxnFPOHR2Km+nN+paBaoOQOVD6nJ74DQhNZgl8tClgCeGH
         lbnJvSjvzusaf0tnTpXlwS6QhbYTNNr1h+nSORcMUfhEU7b802aj3Bwbcb5/Sz4hq9Ss
         y5VM3KITJcUsGys5NaI86m26RSR9Nul/FeYQ7QwTBaSpli2fuA6hsSZ7icu8f4NFDY8b
         KvvE92YW7gTm2K5cM8lteWVGZDDPHnAovnpo82nhngEfDwIKpkkD+xACd04JXYoQ5bEb
         d3NZR8snZ9vE9/9Nn+TLSB/04vQFHV5EwTUHPKsyrdwghW3MlINt7+9W0RQNZj7zjN7n
         GChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Lk7dIebT6CFlulMSTUnnCpdqDMDrExQxqNyGb2hQ43E=;
        b=CwjZd28VEmPMfETWlSn8DtqO92+lZ0YzDBA8ZkzpqeDVURZyJ5+apPWIeRmgFB7mds
         92FS6sLCYAO+GVuWXZNF5ONMJQtvsVxyqNmWF8lQA/nPQTh2zY1usMTXEc2CqhTcZWk1
         9vXKYIizz5KIkiAvVRz4FdJVPYe8DWHDjab+eNEpSsBKwBbjbnq70nHQnQ3TlxBv/swR
         K+IEe6DuuBq2qqhzX0ek66D95l1QCuFJu3YZPu5FbaodRWR7bTu9yk7/MR7f0AzY2N3T
         fqqtxQWZXEIL7mzsvlOfC+4G58j2UniseXw4ooUT+Xc39IdH6+YERBq18ztRC1vCDQt/
         iMdQ==
X-Gm-Message-State: ABuFfoiJTCCDVfObd08hBpD3LrTboIzQDlYWLEX1BaE9cGFZCS9/E7Hr
        J6fWXVAHvpFPgUNWMTRxz+0=
X-Google-Smtp-Source: ACcGV61gN1xw6DAVindvd66qI9PkiydHuxy6ZXM4rcGXLj29fYQ/heH9v33WzknPoghVYbbmqagD8A==
X-Received: by 2002:a1c:118c:: with SMTP id 134-v6mr3720398wmr.75.1539318868287;
        Thu, 11 Oct 2018 21:34:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 63-v6sm268229wmj.39.2018.10.11.21.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 21:34:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 3/7] test-reach: add rev-list tests
References: <pull.25.v2.git.gitgitgadget@gmail.com>
        <pull.25.v3.git.gitgitgadget@gmail.com>
        <b0ceb960761329179d14e613343019e7ac207e4d.1537551564.git.gitgitgadget@gmail.com>
        <20181011135850.GC27312@sigill.intra.peff.net>
Date:   Fri, 12 Oct 2018 13:34:25 +0900
In-Reply-To: <20181011135850.GC27312@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 11 Oct 2018 09:58:51 -0400")
Message-ID: <xmqqefcvdbqm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Sep 21, 2018 at 10:39:30AM -0700, Derrick Stolee via GitGitGadget wrote:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>> 
>> The rev-list command is critical to Git's functionality. Ensure it
>> works in the three commit-graph environments constructed in
>> t6600-test-reach.sh. Here are a few important types of rev-list
>> operations:
>> 
>> * Basic: git rev-list --topo-order HEAD
>> * Range: git rev-list --topo-order compare..HEAD
>> * Ancestry: git rev-list --topo-order --ancestry-path compare..HEAD
>> * Symmetric Difference: git rev-list --topo-order compare...HEAD
>
> Makes sense. I'll assume you filled out all those "expect" blocks
> correctly.  ;)

Well, otherwise three-modes test would barf at least when it is
running in its "no graph" mode, so I'd assume we are covered.
