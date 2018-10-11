Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CAAB1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 10:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJKSDa (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 14:03:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55308 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbeJKSDa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 14:03:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id 206-v6so8471716wmb.5
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 03:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tpOskRjSndnlGqKU+00RwwpDCSWT5TJ2vyiCoHYJ6cY=;
        b=Fj7ij4c4RMXS55QQF7sxeb/aRU361Hu/HFLDXrU3bCfW8byR5XwWIFq5dkAa60G2VF
         pZp4oQqhoFqs2m8LSApzm+alQtGa5nk0HAiYB2Ol5XMYSHFbv5CJhP7fb6tmzGG25/Cz
         4etFRAiFXMYrsofe64uGUkLulZ+BXl5Qtsk0ItQyHQwfV3xMw0jWw1//WA08v4NjrKSE
         2V84H/p12jXwXuH95zI7PltSo1Pi507u0EcnxdQyClKkiiiKXjq5e4BndLVGfcx5QRrP
         zIjMJWZonLaqZnnPEc7FRoJGr+G046kVWc0Be6eODl6XhWB/XkmU2TXN8M0grmXT1zXt
         fldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=tpOskRjSndnlGqKU+00RwwpDCSWT5TJ2vyiCoHYJ6cY=;
        b=jZhK2w2/9kmy0zzVmIS53ekwA0ugbuqqjl3F3CIGIxOtyac+ddWtoqV8eI1if60ZIG
         v7R2jFpvCcXHHc8SdDkcOS5kfus8+MELCxfOvBsU0574UNGIkT8YNfWntCHyZmrhpenC
         E+mJxgkWXFd25Z1QSUEgZNcdkJwZqDY/U4RmOhfZVpTGcg53k76NQUZbY8CaFpg35H3t
         qXPPJWZJe+133Txbc0K3EnIUPm3WnGROk3ZaNeK3mT2HydaaKqZSOemKGUlnuc5QA76Y
         22x2KcYd4Bg/Y7DbRSdC3eRrgwXP5+odLRvIOUr2b6ZFTA0J7ysP16k226yIkDOqhAhc
         UvnA==
X-Gm-Message-State: ABuFfoguAXeemg8yISccHwbEVGqw3krWAjMfBVMIuOOvME8jQXKY9rL7
        Nwnwdk8houz1eO/zCSJwIQw=
X-Google-Smtp-Source: ACcGV62B2Xk/XTVuLFArGWiBm5Ja93lpGDLrQRPSM3MruImHrfgLdnOBRtu69YiIDKjYpuFpr7UZDA==
X-Received: by 2002:a1c:cb05:: with SMTP id b5-v6mr1164180wmg.44.1539254209568;
        Thu, 11 Oct 2018 03:36:49 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id 16-v6sm29309776wrb.95.2018.10.11.03.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 03:36:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Fix the racy split index problem
References: <20180928162459.17138-1-szeder.dev@gmail.com> <20181011094309.18626-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181011094309.18626-1-szeder.dev@gmail.com>
Date:   Thu, 11 Oct 2018 12:36:47 +0200
Message-ID: <87d0sgepmo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 11 2018, SZEDER Gábor wrote:

> Fourth and hopefully final round of fixing occasional test failures when
> run with 'GIT_TEST_SPLIT_INDEX=yes'.  The only code change is the
> extraction of a helper function to compare two cache entries' content,
> and then a couple of minor log message clarifications.  The range-diff
> below is rather clear on that.

Looks good. I'm not going to run the stress test I did on v5 on this
since the changes are just moving existing code into a fuction, unless
you'd like me to or think there's a reason to that is.
