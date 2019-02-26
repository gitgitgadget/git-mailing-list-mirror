Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E12D20248
	for <e@80x24.org>; Tue, 26 Feb 2019 11:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfBZLf4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 06:35:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40761 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfBZLfz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 06:35:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id 10so10418311eds.7
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 03:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=bcornElKrBgsakJqtmSPpUZdvbv9cYKzkSTWWYbuu20=;
        b=aQrKZY9YkeF5btai6LCXLSou51KLjDaKmEQRJzUVXSCbuaTfQHbvKtaIvELPVMxNK4
         mKcXlIzgGiE3wMMm4cgEK58vMVID/aOfA7/3l6qJJR9aE9twLCakjchqYI8WD2MoiLAH
         2mLBLSWU3G7Y/tpxyhX9Pvl3HHVrzaqfIAgpjltTQoe3e6jGObgW6iJinkOu4FaQ6mHA
         +sp6QXyip7+ehqKBioL92u5PL1KbSBglLq+SHQNjWlhHPOJRAOG82ycJGYD6Sc4vJqxR
         c5SwN2qseRhmBdFPmbMRmCEER+uPYZnBeyU6v/He+dfLvMet0N3PHw1HFOrsAI3v+hz9
         1uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=bcornElKrBgsakJqtmSPpUZdvbv9cYKzkSTWWYbuu20=;
        b=YeIT9vdV4Lg9QhnPaUlfsNjZ6wP6ga/jsXE7KnbnTmaKVZ8xiq0gGR3266JEt0TaRD
         b873VtOqxXHqYv0GfScbLjzpedk8E4paQYydSfGWLuuH4/jUtzbAcSN0vJNAKEbjweJC
         2vv1EkzjM8ExTtBtdnk7D9Z1IFmuyuRF3UyILeHFoVZFLLYnhcnQy8D004MFLGDk8e/A
         9hye+fEze9g7aPf2i3U3kv3bUweuzU5bUzSBMolO2EKQ0oHWnQ+Gv6kew2c5ffWEuSME
         NAdSNmbXuqclxUi4OXRyG/RmZb20UXppGU7NUfTngJ00cmU0BEg/doCrSVNppMRCB/U0
         Z2RQ==
X-Gm-Message-State: AHQUAuYUloNOGCDWl3LmwCiEfXTXC1E9O3559t+fDQjOYCROynEXhcti
        3f8gmGdMJnpJ+p9+dUZPSA0=
X-Google-Smtp-Source: AHgI3IbXx8gjmlTovR4Ozl8lLeXo8mip8jJgSGx6XGaGidZsgx9g38NKxws9NyA1eCigEVOxPYOUVw==
X-Received: by 2002:a17:906:3050:: with SMTP id d16mr15466639ejd.200.1551180954070;
        Tue, 26 Feb 2019 03:35:54 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id f40sm2851852eda.25.2019.02.26.03.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 03:35:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP RFC PATCH v2 5/5] clone: use dir-iterator to avoid explicit dir traversal
References: <20190226051804.10631-1-matheus.bernardino@usp.br> <20190226051804.10631-6-matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190226051804.10631-6-matheus.bernardino@usp.br>
Date:   Tue, 26 Feb 2019 12:35:52 +0100
Message-ID: <87wolmvl2f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 26 2019, Matheus Tavares wrote:

> +	int iter_status;
> +	struct stat st;
> +	unsigned flags;

If you compile with DEVELOPER=1 you'll get compile-time errors when
variables aren't used. Like "st" here.
