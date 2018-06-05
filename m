Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D71DF1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 11:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbeFELZF (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 07:25:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37335 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbeFELZE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 07:25:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id r125-v6so4253779wmg.2
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 04:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ai3/I2pPh/T8Cis8ftQ9NaLadtc26sUwDWOEpmcoRQ=;
        b=Yg7JmSKSfHqJ0Zl2WzW8ZqP2DK/hhC7fNi/1cl+kVhb3xDR/Yi9PzUmIIDThjPgTOR
         Oz8v1O6cDr9YjAuAry+3pfVEy+ayjbt/LuvgTAGyWhpg5NqqGH0VlJ/eNkX1RpSX42U1
         9SYlNedbT7/NcXYQret2Ki3YfKHJB8OzhJZZD6K9vxDbzcVnGNwFJGZzFGGnzXHINpHf
         Ezxk6ZxyN93irnoqy9aG5fQdbSWD/sWnpHv1hUu/ptVMCv94X/dZgQSC3zXan0slwVcQ
         rXwAhnXQtCchfftQ5ToTaUpCe5l1u4tTsaOVYymbGljGdXZ6UDhXF9jmL+kyqUkUcwAO
         hy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ai3/I2pPh/T8Cis8ftQ9NaLadtc26sUwDWOEpmcoRQ=;
        b=lCpH9zEMTtwbS6PA+XxSxmGPzGRc1aqiQgiiaafwBE5d/Wed1bItV5OKbm15pSJoHU
         q/GwPa3ju9E9IFntu9giNV0bk3Ot9Sl5k1mVaiEV8RWLm2YLSM/vWAiW4s9c7jxL7kQC
         z1yfQCnsIaI+EAW5/oYWrYhHivduP44JrQlmDwcytb8b29fl9Kg2Nmx//ioL+Nm6sfJi
         1iIv6S7O3KONrsWP9EaGyl2FdpUMvS5K9qDC2QqrKsn2uvgSjcaWSqhZAERW4xQIZaz1
         yz2cEdTPpZ0fhp0WF0RDqdeMwQhxgjXExZxQIAMV6WzaWnTcfCCsCqaYxUqRWIij0z4K
         5JBA==
X-Gm-Message-State: ALKqPweF3pUnpFN6K7+Vr+qoMeCi8fBg6Lt9+SHzJzy2ZfhTiFwH5v4z
        Mj830LWHdY+wd3RzuwHc6+Q=
X-Google-Smtp-Source: ADUXVKJ2haw3PkwuVqo1mjZ9pxUAZg0pTe7JQMkWPt6RALq4915PLSJLWSZYBeh02fufGH+gZFmvMw==
X-Received: by 2002:a1c:e408:: with SMTP id b8-v6mr10751465wmh.132.1528197903096;
        Tue, 05 Jun 2018 04:25:03 -0700 (PDT)
Received: from localhost.localdomain (x590daf56.dyn.telefonica.de. [89.13.175.86])
        by smtp.gmail.com with ESMTPSA id b74-v6sm1898789wmi.13.2018.06.05.04.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jun 2018 04:25:02 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing list <git@vger.kernel.org>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: Re: [PATCH] t3200-branch.sh: use "--set-upstream-to" in test
Date:   Tue,  5 Jun 2018 13:24:46 +0200
Message-Id: <20180605112446.17016-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <alpine.LFD.2.21.1806050712270.10467@localhost.localdomain>
References: <alpine.LFD.2.21.1806050712270.10467@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Change deprecated "--set-upstream" branch option to
> preferred "--set-upstream-to".
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
>   i'm assuming this should use "--set-upstream-to" as do all the
> others.

I don't think so, see 52668846ea (builtin/branch: stop supporting the
"--set-upstream" option, 2017-08-17).

Though arguably the test name could be more descriptive and tell why
it should fail.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 69ea8202f4..ef887a0b32 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -885,8 +885,8 @@ test_expect_success 'test --unset-upstream on a particular branch' '
>  	test_must_fail git config branch.my14.merge
>  '
> 
> -test_expect_success '--set-upstream fails' '
> -    test_must_fail git branch --set-upstream origin/master
> +test_expect_success '--set-upstream-to fails' '
> +    test_must_fail git branch --set-upstream-to origin/master
>  '
> 
>  test_expect_success '--set-upstream-to notices an error to set branch as own upstream' '
> 
> -- 
> 
> ========================================================================
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                   http://crashcourse.ca/dokuwiki
> 
> Twitter:                                       http://twitter.com/rpjday
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ========================================================================
> 
