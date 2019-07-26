Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19F01F462
	for <e@80x24.org>; Fri, 26 Jul 2019 21:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfGZVQS (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 17:16:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38824 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfGZVQS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 17:16:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so16511385pgu.5
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ws6ajykxJbgM355RllNbVNVeYBLXmpkWfcTdHk7SsFI=;
        b=oQpmD1uKWELfNx66c+PbDwSFgYISO6b4EhXE/6fBcXxRM58eEjUWFeXomKhf3oKRFr
         Ky7xP0L0IBqwp2ZQtszt2FkZMYnm7mgDUkZJS7vjp9XWE9BXuDq29TMZVNO1+UC8dyzk
         XKKmiDA64F4QtGBzR4wxHuz8zKDpcONj1i4c0SnzwQP/ieHO6JsN24A5wZJjq5cT43Kh
         fRERI06Llz1ZOfMHwLCiCLrnNuxtt0DRo/xSAHaH+FX3harLE5N7HN/7wWq5CEeQMOpD
         oW/iFNKydj+Y5rFMzBLPmUzdAcywCZVQFrysWHJGgyhsIobhgnavGPSLLIT7BkWWoDE7
         4qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ws6ajykxJbgM355RllNbVNVeYBLXmpkWfcTdHk7SsFI=;
        b=bQgx2u2hAhdP2kisuEhC+5bTxIiSmz+NLTlpCh2kG72V08PWzTe01RdyMUKfWSGpJY
         BKXnK4EQfdRI+sozLe31yqT02y2ZRh7ck50U4+eyTO+LufEyjp9wYk8LTkVt4IJTzzTF
         GAbAD+sfu/Gm29j3M5J1hShs3terdbFh4z8HJbi9v7Dw1wAx/8154JfEvndaft2RGsEt
         zOUg3Wr6FG5IC+OqDr6V9WSPx8WKngtiWI5fGcqbyP+KXme74ToyP8fZAONWajZOc2Og
         jDlA4lDJvuvbKPRYVAdvbJKYLiS20ag11Jca36V+2K8LHEEG+peAVR8+wru88Gu1a4iB
         frSQ==
X-Gm-Message-State: APjAAAWyNS2fhRdPfFrDhKoblAdnU1b7tWQZXYoDH1nHX62lMHAgE6Ie
        mNFA8UceVyua7WfegMqmfmzNnQ==
X-Google-Smtp-Source: APXvYqzYxJc3enJYnLS38JNSXRZDRCFMBSwvL/DcVqxWDOkWP6yXZomUkay8Z4llXBk3RGU/app/fA==
X-Received: by 2002:a63:c70d:: with SMTP id n13mr92147565pgg.171.1564175777218;
        Fri, 26 Jul 2019 14:16:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id y12sm62666486pfn.187.2019.07.26.14.16.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 14:16:16 -0700 (PDT)
Date:   Fri, 26 Jul 2019 14:16:11 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com, avarab@gmail.com,
        peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190726211611.GE43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com, avarab@gmail.com,
        peff@peff.net, jnareb@gmail.com
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
 <20190725111803.GL20404@szeder.dev>
 <xmqqd0hyqegh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd0hyqegh.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.25 09:14, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >> I would appreciate any feedback on better ways to integrate the
> >> validator into the CI suite.
> >
> > How about adding a test script dedicated to JSON schema validation,
> > which runs only as many git commands as needed to cover all trace2
> > events.
> 
> Sensible, but might be hard to arrange, as the trace2 annotations on
> codepaths are not frozen.
> 
> I wonder if these schema definitions can somehow be read in reverse
> by machine to automatically generate helper functions that would by
> definition produce schema-valid json objects, and the current
> callers of trace2_*() that logs stuff can be updated to call them?
> That way, we'll automatically and always be producing valid output,
> or am I dreaming?

In that case, how would you feel about having a protobuf writer, perhaps
using Nano-PB[1]? It would handle code generation, and we could add a
new GIT_TRACE2_PB trace target to use the generated code.


[1]: https://jpa.kapsi.fi/nanopb/
