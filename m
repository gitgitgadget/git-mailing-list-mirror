Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCCDC1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 08:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbfIQIS1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 04:18:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54897 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732088AbfIQIS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 04:18:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so2149321wmp.4
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=31OZSJ8MD5WMBP95ZyXR6LrhzjuJJFQJntmGjHsy8TI=;
        b=V6EtpkY5DV369540EA2tsQgbQV1FOaNZxvhq4pTdeZtBhFozJqXRBIyTtoX+8RNc82
         DAMhSlKXaKHv6c67dGczGKfdIRzr/9m/LhOL+WxkUnXRHSZRr9H/sUat0xchk3G1CxDq
         tbFCUYQf+CdOh2EscKI3go4fS1Eh6uWjEbEv/oewHSkUfxvUno4BLebCA1ITmaa037MG
         bMTpwXsc4ccWrlgDIB6JMtSek1pfPwulh3LFo3uCu9FzglLH301cu9PETQ1w1PjDZgt/
         l72dAhQBc/uoeaigd/k5rLMnjPV4xj9hzOqnDuDAKO3LKsDg/0j51O2DyFdqMcH3Pb0i
         Tl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=31OZSJ8MD5WMBP95ZyXR6LrhzjuJJFQJntmGjHsy8TI=;
        b=nVSkfdgL0GyZXabXY613FWNf+SE6nsCYiQL/LJB4FJThoEc271LhVIzDmKRwgVlBGL
         40DOH2BCkNRjkIOHy3hYdh1oa+vlk4MlLE2qzgmfUqQe3yudlk9jay5b1j1WWP3c3grB
         Y+qVfVnOy5HJgxZfhFZe20qsw27x5Ru5xyLzQh3EgFjeePRHVTkNTNN0xbsLS5ltmW55
         X7G0IW+M5nX2W1IEFa5BinLd3o64wpMr6P/BKYhB4YOZLH0c063BJLAPMcCsoP7Tk8LI
         PBIdqmyx0w2boeLXoHyv/Fet++tKym9ZLzhhFlbkZkgoE2VQ8akudZug+ksEO9VmEYAH
         hT6g==
X-Gm-Message-State: APjAAAX5qYR5cNke7QgNOkECLIZPan7WtHEUaI8Vmwy4HV73Oko7Xdf7
        TOt0f4Z1XTS3XuWuMVsDTsM=
X-Google-Smtp-Source: APXvYqy2+x/49CdXKLNRID0Qk6UWgmVn+yJ2k7dN2te3XCxpJjBIApxmKcMJcmq2fDsmVx9I1nr9lw==
X-Received: by 2002:a05:600c:2108:: with SMTP id u8mr2553035wml.13.1568708304868;
        Tue, 17 Sep 2019 01:18:24 -0700 (PDT)
Received: from szeder.dev (x4db91871.dyn.telefonica.de. [77.185.24.113])
        by smtp.gmail.com with ESMTPSA id a10sm2111292wrv.64.2019.09.17.01.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 01:18:24 -0700 (PDT)
Date:   Tue, 17 Sep 2019 10:18:21 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Makefile: run coccicheck on all non-upstream
 sources
Message-ID: <20190917081821.GF6190@szeder.dev>
References: <cover.1568309119.git.liu.denton@gmail.com>
 <cover.1568661443.git.liu.denton@gmail.com>
 <xmqqh85c9cyd.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh85c9cyd.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 16, 2019 at 01:57:14PM -0700, Junio C Hamano wrote:
> Queued; thanks.

Nit: it would be nicer to queue this series on top of
'dl/compat-cleanup', because 'make coccicheck' errors out suggesting
transformations in 'compat/mingw.c' that have only been applied in
that series.

