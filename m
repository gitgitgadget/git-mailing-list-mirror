Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PI_DNOT,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E98132023D
	for <e@80x24.org>; Fri, 19 May 2017 21:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756444AbdESVvp (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 17:51:45 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35062 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755765AbdESVvo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 17:51:44 -0400
Received: by mail-oi0-f48.google.com with SMTP id l18so107735616oig.2
        for <git@vger.kernel.org>; Fri, 19 May 2017 14:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=8/jLLUflsrR5+L+BDCp3/McwEtB3OBGiCscmPTXss7E=;
        b=Bi7Ctqm9CT7vFr1sWIXKIVx7UMM8WDMQ0iNGni1fDiGQByjDoyDs2zgCfSSzU0mM1B
         e8pWwspwd9KzfA8qjqlgSiI4zKQcS691aqRV13IvPT6FjEH4Xv6kLO/A79yqeJHL+ja8
         OMl6DA+ye0uNUbYf3TFYxn43meb1eodjF5wdN3UEtyeOfAG+lePtVV576ot3iLf+2X42
         5dyG7GC/TZyK1KrRyelRFk24rK9cGjyKsQg7V2iLJXqnM4zpBJkXNUjRkwyHsw3uJL1Z
         gYqPztP0gAYg4WIWFAr/hr4O6sOF5k94+LoCY+RxC+TAHhM3laYuceb+KjsUermPGEqn
         qyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=8/jLLUflsrR5+L+BDCp3/McwEtB3OBGiCscmPTXss7E=;
        b=TEnaqbSiREYlt65iyQ5nY6/58JDKaaC1E4YvheBweBHn4wIw7G8cnBF8F2IKClrbwA
         Y6LiJ81Ol9NuMkIFg1swMR6BoCMDtPwsKqQ6Ni9pPr4k77/wF2HSs7tu2tMDK7K6aKDt
         R0F+kng/oRGQrCntbBxEqvL3uycFa+vJhy/aJhebuKBkI47XJS5yazKUv5/6/OsPo9jf
         DtgI8YsbgYR7VnKewoq8KWQW9EGQADUXvzmAsaMZXoyLwa1KLYU9CjQEf7Wo9YZi9lB7
         MqhBltEha/vf20kVII2C5UNjilU/BjW4tIyqHsTiNzoQk50OStaFh6pQZjI42wGmFiv0
         hu2w==
X-Gm-Message-State: AODbwcC6/7WOpcooJMwX9fAqhOj0uw2LXmbSPFydys0grBnturHQVfbp
        k4mbWwYtDhhJspCJNT2ouqQESP+wnw==
X-Received: by 10.157.43.24 with SMTP id o24mr7410608otb.64.1495230703572;
 Fri, 19 May 2017 14:51:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.38.143 with HTTP; Fri, 19 May 2017 14:51:43 -0700 (PDT)
In-Reply-To: <591f6844.82dcca0a.451e5.8f76.GMRIR@mx.google.com>
References: <CALKRkrxHNao6NY+-_UmznHdq29yVJJynu8Xx5M__YfK9UkdOAw@mail.gmail.com>
 <CA+izobutP-JY84RGG-JbPA5twbckL1uVwxknBRLVTuGG0MEJcg@mail.gmail.com>
 <CA+izobuSKtoQzNJuvuisjh7h3FF=nbt8u-hOHfdeFp8ZjgZF+Q@mail.gmail.com>
 <CA+izobuSKtoQzNJuvuisjh7h3FF=nbt8u-hOHfdeFp8ZjgZF+Q@mail.gmail.com> <591f6844.82dcca0a.451e5.8f76.GMRIR@mx.google.com>
From:   Atousa Duprat <atousa.p@gmail.com>
Date:   Fri, 19 May 2017 14:51:43 -0700
Message-ID: <CA+izobtauVjAnTKb9fROc4Q_NqvmRHk9U2Gbicq4bonP=_F+hA@mail.gmail.com>
Subject: Re: Delivery Status Notification (Failure)
To:     git@vger.kernel.org, Animi Vulpis <animi.vulpis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have tried to repro this issue but git goes out of its way to store
the commit messages using unix end-of-line format.
I think that git itself cannot create a repo exhibiting this problem.

Most helpful would be if you could create a mini repo using gitlab.
All it would need is one file, two branches, and a merge.
With that in hand, it should be pretty easy to track down the problem
and fix git.

You mentioned that the previous version you were using was working
fine, can you tell me which version that was?
It'll help to narrow down the changes that could have affected the issue.

Thanks,

Atousa
