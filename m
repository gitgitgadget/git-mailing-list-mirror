Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3432B1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 05:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeJINIs (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 09:08:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53922 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJINIr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 09:08:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id y11-v6so496706wma.3
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 22:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=arpwoIhfyXAzLoqPX31eGyAlqILOFNWSJmNt3BaSioE=;
        b=n6x+45Ai/iH9Dtd7gdGnpz0JcPhI2pssJIQdCe4x70i9LayeDqMHHEFvBm5JJYyx8N
         Eoluk7048EPA5/vl1hm+UEvZXbs4gDhLvDv26XzBXIWUyQQ28bKJRxHh3COpZDH+XKLc
         DaLRZgrfPDduofUNCBaYQCckj6RAOZGpT1hoYnoD1JNYn7DSte5/kLwJxZ05fargs2Fv
         hnAvCnIWqVQZivMjqq4V7S5ScAAOHNBVA4qpbQFqq56xofUUl5ohwbE3zJqQyujvH8Cj
         OSyCeKmmWS8ssPgOp7c8tBFyaV2ZxiSkeTSvBIAM40rL/m1ptS3VwMs7Jo5qVmfzdg87
         7GHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=arpwoIhfyXAzLoqPX31eGyAlqILOFNWSJmNt3BaSioE=;
        b=Yl7Rlo3z0Fj6unxQ0XzROZNX+xOIex5UQO5Ir/0lPxlUvV4tFmm+h7veMP8Phe9gHX
         tJTC+xl6ad7jtdIZPLaO8usA6hPr9bH7bRTogGqP6tV27S+WT3IuxLghDKPaaSg8myhj
         YaOnqOsa0z2SzKR6CxoM3iwOmtgoN6+PcG3gD7y8rdgHACh34KZ36wcPygPXKjy2xtYH
         LzYTeiWF84p+YX2Xnkd84YSR3zOf3V2PQfzlutfDB2UVPW/S6ic3x8dFASVJzIZMU6Dc
         NKgJESyPK98I5xGixa6vLnauiYPPh4ZlRDewkzl9258ZhBWxLev+cgN2bysTd9EXknRb
         F2dQ==
X-Gm-Message-State: ABuFfohT3xRmM1v2kqPGMAX8xzdrZnmhnmlKQ4MyX2+2p+pcidCtZN+8
        WUWi3tGzVMvPACn6kQw5zUcwUjJih/A=
X-Google-Smtp-Source: ACcGV61efCcDLmQ73bITt3cXh9lm+ihehSxc7QLAy1DYRBPzSfRDRu+ZYn/trCo/9/uQbeH7AKYRrQ==
X-Received: by 2002:a1c:e15:: with SMTP id 21-v6mr681537wmo.35.1539064412867;
        Mon, 08 Oct 2018 22:53:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b1-v6sm11828917wrt.43.2018.10.08.22.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 22:53:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] commit-graph: define GIT_TEST_COMMIT_GRAPH
References: <pull.26.git.gitgitgadget@gmail.com>
        <85d02ac8d8c9a8950ce1a9760a541ff506945de0.1535488400.git.gitgitgadget@gmail.com>
        <87bm84a70p.fsf@evledraar.gmail.com>
        <a2299be9-0840-da69-ebeb-f64ebe66db5a@gmail.com>
Date:   Tue, 09 Oct 2018 14:53:31 +0900
In-Reply-To: <a2299be9-0840-da69-ebeb-f64ebe66db5a@gmail.com> (Derrick
        Stolee's message of "Mon, 8 Oct 2018 10:45:21 -0400")
Message-ID: <xmqqd0sjr7hg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I see these failures, too, but I believe they are due to
> ds/commit-graph-with-grafts not being merged to 'next' yet. The
> purpose of that branch is to fix these test breaks. The environment
> variable got merged a lot faster.

A separate "ping" would have helped me.  Will merge it down to
'next'.
