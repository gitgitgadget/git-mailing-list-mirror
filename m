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
	by dcvr.yhbt.net (Postfix) with ESMTP id 163DD1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 11:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403987AbfGYLSJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 07:18:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50934 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403886AbfGYLSI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 07:18:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so44645142wml.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 04:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=38jGZ/LhxhtJkf4KscE+6H3Ungbii2aFJUvZUFyRYlU=;
        b=oxiHpWj7CiMzHNFV/0BEiDxFwsErsARWChKROuDlJG5benqxzjopYnLlPoFOJ8q7s7
         i8dYAxAgqvzcCmZQ9J+Vs6zJwj13/rbtrbpxFUtw0nqiYV7fJpEAQ4Unl08ZaTJZUK32
         8PyDtPqdI9DWF3TxAYdr/MrwOblQgXvTqTL3WL4vRdWPr1v0nmZEH6swqLr1c0HqXpwA
         ieo1LyUKN2qvYYf3bNC16hgR8nehtMT1lJjNjHkNV9DxhGF3jbpGP+Bc4UQ7F6l1ZXGq
         7+wvz5MFQYkbo59Sj6f6c5rzKve4KTlD3oDlmAnjY6IS2UUpzxiNQow9LRu0+HYh6K5s
         odeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=38jGZ/LhxhtJkf4KscE+6H3Ungbii2aFJUvZUFyRYlU=;
        b=hdPWSnORv5wNTgBwMs4XnKTCmJ3VpPPOPALvhQqnNTh+ZA/JbRhu8wNVrm6aMudTBg
         cUXHnxSGdTJuWYlBYL5B2TB8HMA3XcPX96mVD9OvgQLrU75RKi4cBIGrQFRkGoK7DkGx
         m0uHX5XC4fNF1uSg3KSSniZSuwfJtBb3dFsRbZvk9a28OinFwzxsYywIS1+WBTb1Q3EF
         DG4I6fXHQOzVR7hd3wiDUn06+HpovRcF8xNI3we3T4COgMmpKgBDTQBzxU//R0tWcqkS
         gBNjP8YnikISDMMRbNGuCTuQJA+OOENQEp/GxIqWl1szjOnzjzkOilkQhtHAOYLDH1M6
         v57Q==
X-Gm-Message-State: APjAAAU4d8iiL8bka42VCBjn/oxWklkkJXMFpSfZgRXmemznW+T6rMFn
        2kCH4ELEbDUxAL7Pi0KuTvo=
X-Google-Smtp-Source: APXvYqzu7MFBbmywolYbWXYcWZynOj0kz/6terS38GgklKViVyawjtNPmOt2G4S5W5MxXhjANWXTfg==
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr78988465wml.126.1564053487290;
        Thu, 25 Jul 2019 04:18:07 -0700 (PDT)
Received: from szeder.dev (x4db5738c.dyn.telefonica.de. [77.181.115.140])
        by smtp.gmail.com with ESMTPSA id k124sm79132529wmk.47.2019.07.25.04.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 04:18:06 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:18:03 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190725111803.GL20404@szeder.dev>
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1564009259.git.steadmon@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 24, 2019 at 04:06:50PM -0700, Josh Steadmon wrote:
> This is a proof of concept series that formalizes the structure of trace2 event
> output using JSON-Schema [1].
> 
> It provides a validator (written in Go) that verifies the events in a given
> trace2 event output file match the schema. I am happy to rewrite this validator
> in some other language, provided that the language has a JSON-Schema library
> supporting at least draft-04.
> 
> It runs the validator as part of the CI suite (it increase the runtime
> by about 15 minutes). It tests that the trace output of "make test"
> conforms to the schema.

I don't like this approach.  15 minutes is a lot, and spending that
much time on JSON schema validation in every CI build is overkill and
(IMO unacceptably) wasteful.  I mean, the test suite involves e.g.
thousands of 'git (add|commit|checkout|reset|...)' executions to set
up the test cases, but surely it's not necessary to validate the trace
output of every single one of them.

> I would appreciate any feedback on better ways to integrate the
> validator into the CI suite.

How about adding a test script dedicated to JSON schema validation,
which runs only as many git commands as needed to cover all trace2
events.

