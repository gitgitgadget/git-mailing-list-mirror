Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F38B1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 04:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeIGJig (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 05:38:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56200 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeIGJig (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 05:38:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so13361105wmc.5
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 21:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=s6GJ6ynv4afBQGjmObe2MYwHJa+1hRUDCNhVO1SaskE=;
        b=qjKxRMeHhOBiQaai3QpB6R6cCaoPbLRbizXKrcsjY+e16EKqNizlywrHwrI6PNPzXI
         5YIpE2HYubzrm6r4IpNdU8wWeotPpt2gmDKxzAPbclu0K9DBSjjaPUAl6U7g8CJgDJgA
         9NujuQd+syp1zY4LCk86VEJc0CUvgZ+huVBeioCL/Jv/43cqXimM+4o1auN4RwiOFg2Z
         QHSnWrjW2PTtqEEfzR9uuY6vFwNNHWf5iKiCap7+IDUsO2R/XUH0G5fqsDnS9eaT7KWU
         3l8Ytp5aPKRy+coI1hXNVaEypghLsAtdhMvIYRTnDu2gJGkOqRZJlxHKQSdpoC/GKv3W
         ouQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=s6GJ6ynv4afBQGjmObe2MYwHJa+1hRUDCNhVO1SaskE=;
        b=pJ7dbjLI5bTDIxX8R4D/rRfuUbNQApoFUQhG/1MBhW05OxcG24NIx90LGCzxYKwVc0
         XrQ2SBWHgfFD6LgztIFjwaTJtLmW64w5OqDyIrAWQ3bJGyxuvrDzQ7i1ELkIgJhzwUGC
         Hi0hUExDk+odKjrGCiKf4nikQRepYy3nPrKV79yK5vUfsxBjix8wk+2A3sJ8t+FF7rEs
         iqE5WWgCaIMtLZ3rqdarlAcqB82v2n3qjkRfh1gEKsh/GSfhnlcLkEmPwQNoXUEjIX0H
         0i2WhCrLl1G8pMlKYwl4nGAJ783YQt6fIkn3Z8ZcUvQhjiwdyrZnBQoVBvwtmxhQG9B3
         rEGg==
X-Gm-Message-State: APzg51DoqQ64uLSdwTssZcq1fVU8X0kdmZ+oGJ7kkgyf1kgJuggVx+Bf
        /8v6QvOWbPphGMqLYOR6Dj6UfCsDaOdmtjhR2TF78vBQ
X-Google-Smtp-Source: ANB0VdbQJmpMYGeqK/q3E0x2bMGHBCdbYEqOU4ix5XLr2MVTK8qmkgzFPU35oPJaSYND7vVMdJf65uijIwXi6Ws44+4=
X-Received: by 2002:a1c:7711:: with SMTP id t17-v6mr4136063wmi.35.1536296367412;
 Thu, 06 Sep 2018 21:59:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:ab56:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 21:59:26 -0700 (PDT)
In-Reply-To: <20180907033831.GB1383@sigill.intra.peff.net>
References: <20180906193516.28909-1-max@max630.net> <xmqq1sa6z3zp.fsf@gitster-ct.c.googlers.com>
 <20180907032740.GA20545@jessie.local> <20180907033831.GB1383@sigill.intra.peff.net>
From:   Max Kirillov <max@max630.net>
Date:   Fri, 7 Sep 2018 07:59:26 +0300
X-Google-Sender-Auth: yKytIIpWaFJfXE3vHzUgn6iVF4A
Message-ID: <CAF7_NFRg8wOQ0JbjkJ2gpxKs+oh3s8qXVSPfsWSth2tiUK39hw@mail.gmail.com>
Subject: Re: [PATCH] http-backend: allow empty CONTENT_LENGTH
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Jelmer_Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Actually, another reason for the latest issue was that CONTENT_LENGTH
is parsed for GET requests at all. It should be parsed only for POST
requests, or, rather, only for upoad-pack and receive-pack requests.
