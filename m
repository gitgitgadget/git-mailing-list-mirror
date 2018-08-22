Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5991F954
	for <e@80x24.org>; Wed, 22 Aug 2018 17:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeHVVT1 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 22 Aug 2018 17:19:27 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40571 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbeHVVT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 17:19:27 -0400
Received: by mail-qk0-f194.google.com with SMTP id c126-v6so1814976qkd.7
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 10:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m7iE+nMjQ0M33AKWSE3+Ff2udBlRRaQTGFR6m/kKtRY=;
        b=oPAByEp9y9+FRcuZ/+mZKHNK7U3NeiUa1m1eXh1evVyuAVuMvyhNLUnaXeW9JPqh1y
         AnlgaC9oyJNlMJOwlzpRhDuivTaAfBVsYJ50j3NxDc9jvrLbekTVivpU9bfy1835r+2e
         j21/YSpf7zLjtB++Yras9sjTzq6N7Erw8jaGCCMZ43nUie8FtiZZuWQvQha8u9JUnbye
         5kCl5JO8iWGMCAOetgIUCMr8sui3A7v0yJmq9xd44Kgrh5LnwbsgJsxJ4qHMResxiK7E
         0AO1KGr5Jis0/pHg49Dld95RAE4XkaCHSSiA5E7WRlN2oogPjHqvPonTCrOy/gMw6yUl
         y5IQ==
X-Gm-Message-State: AOUpUlHRBO1kn3aD3xJrGJsIzzHJLOj5hfofKOmvS1au4ZshOGuytNUf
        1bH9WUy1etqBXAxlWEi2RXUmJutv0F2YMXykiww=
X-Google-Smtp-Source: AA+uWPwuS91RWLQdzHdh6V61klIwlEUhAZL95WDkKuI+/F1XNtK+u5QInxRPT1sovDHzArFwrUoVfgAXvFlZgo39BBE=
X-Received: by 2002:a37:9306:: with SMTP id v6-v6mr51047715qkd.36.1534960414684;
 Wed, 22 Aug 2018 10:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180727174811.27360-1-avarab@gmail.com> <20180822174820.12909-1-szeder.dev@gmail.com>
In-Reply-To: <20180822174820.12909-1-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 22 Aug 2018 13:53:23 -0400
Message-ID: <CAPig+cTQrBmgXQdwQpH7DO2AbraD3B4LiRHDx4Sf9rXg0d_eDA@mail.gmail.com>
Subject: Re: [PATCH] t6018-rev-list-glob: fix 'empty stdin' test
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 1:48 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> Prior to d3c6751b18 (tests: make use of the test_must_be_empty
> function, 2018-07-27), in the test 'rev-list should succeed with empty
> output on empty stdin' in 't6018-rev-list-glob' the empty 'expect'
> file served dual purpose: besides specifying the expected output, as
> usual, it also served as empty input for 'git rev-list --stdin'.
>
> Then d3c6751b18 came along, and, as part of the conversion to
> 'test_must_be_empty', removed this empty 'expect' file, not realizing
> its secondary purpose.  Redirecting stdin from the now non-existing
> file failed the test, but since this test expects failure in the first
> place, this issue went unnoticed.

Can you say a word or two (here in the email thread) about how you're
finding these failures (across the various test fixes you've posted
recently)? Are you instrumenting the code in some fashion? Or, finding
them by visual inspection?

Thanks.
