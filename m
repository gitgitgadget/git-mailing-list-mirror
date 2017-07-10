Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB90B20357
	for <e@80x24.org>; Mon, 10 Jul 2017 17:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932219AbdGJRf1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 13:35:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33722 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932202AbdGJRf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 13:35:26 -0400
Received: by mail-pf0-f194.google.com with SMTP id e199so15421757pfh.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 10:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1lMxSUFerwUm2HcPXtTe903DaI7a880SuSNg3IBEj3E=;
        b=fBArvtLosb3P/DpOpiJdqafKVRWe8zKxjgH0migoVtqwrZRW32uaYo7zRTJJ/IMPf1
         mdVILv5E93zKgts2dFKoIx+iAq1yx8Am0ZAU62J8c9ttfFHvfaluZ8sWz34A7t9555kG
         3DOfw6WRfqNzDsDFjldSsoXid1IuAPNpSlM0l9YYUvD3rEReuZ2mgjWa9Fq5yNAq9kiU
         McrqGYp3Ao0hZYLF2bLu8bP/AEw7S4oUTVSIRzY1/RQmIHEn71gB27JFM8XhgInrh2rq
         S7FwhFRlyK/5dgUuSm1xGvKbdKH8riyS+U3e3V6aQ/8Mx5kBFJeI6Lyn5YpZhynz8f4z
         L1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1lMxSUFerwUm2HcPXtTe903DaI7a880SuSNg3IBEj3E=;
        b=mQuRet3q8sBhrbY5b+IKj1aaWjTFY8U46ABqOcqmc6b/vKtvaF8nUvDoCK3A/q+SmH
         dBegjtV1divWgAAOPoSoiWjBVzPaaEHFATnFwPuc8722Wak3blZ4KrBFD6dO/9xIDT//
         YS9gLPnhvjbzcom7OhakJrck14c+6sLRSKY3E+xFiCQnjKYd4dHygyER4cJqELKzIUtR
         MRQkqECgEQt+od6pmjPU/H5UsFYh7jP1j/EMklCUGgaWRLnjSvI6SslmxMJACQidLRB9
         a9dsEAH8Uajb7/n0zZ3pIebY3/FD+bN74hEQm+QTBt5NAZ+HmoESoEKNdoS7I+7r2cJ9
         fU1Q==
X-Gm-Message-State: AIVw113zbDpFos7aThJJxPHChHbKKuci9g+YQDGIFNfgnbSdCM2yCCy1
        LKRKk0vItJZBhA==
X-Received: by 10.98.223.66 with SMTP id u63mr44935466pfg.98.1499708126092;
        Mon, 10 Jul 2017 10:35:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id g79sm25163019pfg.121.2017.07.10.10.35.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 10:35:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] Makefile: add helper for compiling with -fsanitize
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
        <20170710132442.epsox4rawxlyvrw3@sigill.intra.peff.net>
Date:   Mon, 10 Jul 2017 10:35:24 -0700
In-Reply-To: <20170710132442.epsox4rawxlyvrw3@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 10 Jul 2017 09:24:42 -0400")
Message-ID: <xmqqefto6vqb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> You can already build and test with ASan by doing:
>
>   make CFLAGS=-fsanitize=address test
>
> but there are a few slight annoyances:
>
>   1. It's a little long to type.
>
>   2. It override your CFLAGS completely. You'd probably
>      still want -O2, for instance.
>
>   3. It's a good idea to also turn off "recovery", which
>      lets the program keep running after a problem is
>      detected (with the intention of finding as many bugs as
>      possible in a given run). Since Git's test suite should
>      generally run without triggering any problems, it's
>      better to abort immediately and fail the test when we
>      do find an issue.

Unfortunately I do not think Comparing between versions in
https://gcc.gnu.org/onlinedocs, it appears that -fsanitize-recover
is not configurable for folks still with GCC 4.x series, and this
patch is not very useful unless you disable the recovery for the
purpose of running our tests as you said X-<.

> With this patch, all of that happens automatically when you
> run:
>
>   make SANITIZE=address test
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 9c9c42f8f..59f6bdcd7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1012,6 +1012,10 @@ ifdef DEVELOPER
>  CFLAGS += $(DEVELOPER_CFLAGS)
>  endif
>  
> +ifdef SANITIZE
> +BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
> +endif
> +
>  ifndef sysconfdir
>  ifeq ($(prefix),/usr)
>  sysconfdir = /etc
