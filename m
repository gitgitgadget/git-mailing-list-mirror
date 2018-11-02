Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 205B01F453
	for <e@80x24.org>; Fri,  2 Nov 2018 03:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeKBMRd (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 08:17:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37232 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeKBMRd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 08:17:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id z3-v6so512658wru.4
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 20:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=K70R3L82UE+mRLqDju8h2C9AnCgycwfTO8ibnvGgxAw=;
        b=D71TU+v1Exrc/4cxB1GpczGui2b1Yh3vNaH9bazQxv1qzCOZ6cBP53ehTyMdU3jZqC
         X72g6CAoPDN5WNDUAPQvVavK21PMjImaFDryU5CnCB24sPH8bCJ06GgPgYKO9B9D4R2W
         rc+saMC/E/lMmuyZgIw3mPo+MLXfdt7VUlnRYAytxnlykodunfRSjblvafyi+K2+qjE7
         7/bZTz3QwcMlb5EPTrQ8BrD4s11FZhTFPv+I8S2gsu71NWXkv2hJeJTONCxxe+ty21/x
         ZSWFQn/UfXeGN/WCZJlM4csGjI9WtJCyQQDbSn6GS8jsRHnKFXdgEx7O10omefzQxDOG
         zS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=K70R3L82UE+mRLqDju8h2C9AnCgycwfTO8ibnvGgxAw=;
        b=WaRc4FfbDrSwjUnMY5+NJG+gCB4P9rWwa7ioIVyQnC38bGB1FHCoWjY9iYbnNdkvIm
         /NudrAxXSq38nsAzQdcwXToEMc1Y0PMalHfZXF75eONVSgoSQMRG/J7LBewIxPnLObyd
         ZAL85q4KxNKLBiB5qutUzg6PYAtNB6hU/bqpxRRxHGMGLsCNGLPMfwdZ8mbDCCcqiP+y
         SzUpU7InJqBgwGoR2QmttTl7lkvfjerodIkC/dKZw3xVr2Guk94skHvDPhW/PFLe6WJd
         INpyogxsONp7Y51VOMOOqahRBnIJwWi2pfd/P5r/lpN68J6SgBuku8tGgC8mR/j7PrtS
         5kWQ==
X-Gm-Message-State: AGRZ1gIobeyupiFn4VgLYztOon8uWDHyO4nucn3BAzVq0PHbfd/WUHSM
        ZKzJaWKz/jqOmFGn0yKpb7k=
X-Google-Smtp-Source: AJdET5fLrOed5tFJYg58wpp4jRr3+i18JWMwN43xNXE46bjgWgnk+FiKNFQ9JAe0qGeMq2K13EqpBw==
X-Received: by 2002:adf:8425:: with SMTP id 34-v6mr7917164wrf.153.1541128318772;
        Thu, 01 Nov 2018 20:11:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q185-v6sm26272822wmg.45.2018.11.01.20.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 20:11:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH v3] i18n: make GETTEXT_POISON a runtime option
References: <20181024114725.3927-1-avarab@gmail.com>
        <20181101193115.32681-1-avarab@gmail.com>
Date:   Fri, 02 Nov 2018 12:11:56 +0900
In-Reply-To: <20181101193115.32681-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 1 Nov 2018 19:31:15 +0000")
Message-ID: <xmqqlg6cqikj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change the GETTEXT_POISON compile-time + runtime GIT_GETTEXT_POISON
> test parameter to only be a GIT_TEST_GETTEXT_POISON=<non-empty?>
> runtime parameter, to be consistent with other parameters documented
> in "Running tests with special setups" in t/README.
> ...
>  #ifndef NO_GETTEXT
>  extern void git_setup_gettext(void);
>  extern int gettext_width(const char *s);
>  #else
>  static inline void git_setup_gettext(void)
>  {
> +	use_gettext_poison();; /* getenv() reentrancy paranoia */
>  }

Too many "case/esac" statement in shell scripting?

