Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 234C71FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 23:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdBMXzv (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 18:55:51 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:38811 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdBMXzu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 18:55:50 -0500
Received: by mail-it0-f41.google.com with SMTP id c7so9403829itd.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 15:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=url+cOgATPCnHRCWK85QY7d3Y9V/eHDHL9nx2zVwGGc=;
        b=ZjqccUFmWBS6vhPgR3+ZaKRaA11b4t2llKK6SpVOfB837fQyCc0kRzASRTxClA3vpC
         +wgEy5uzOcnpvBOahvaQsZ/vsdKPXeDyjUK/oYn4hJ7SUpMObGbOr6gKzneryGYQktGu
         e1DnVZfdBaI6TzRgNvpj74lvsZKt6nBT18b8UHDSPCgEeOien2cqdBP/0oSh+A0Bpl6M
         KESeYlIJ/Bpnl1gTcPctc/YqhsRqHgiHPsIctFGrtNcoPrhuCP52N0phDxgIldOcP3QC
         JSdkDp3CFq0lhNl0jQzvf7fKZJQi2zNoGn7p9CLEbgtIer25sTgoci3AZUUf5EIDg8iJ
         1IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=url+cOgATPCnHRCWK85QY7d3Y9V/eHDHL9nx2zVwGGc=;
        b=XrSJOpc9Y75jQsEDIkl5AEHPRPynnDZThbIpIXX4jlrr0bITs4ZSQ1Z3Lh6xvUYmG9
         XIkZqHQSyhZiEeyYuIT6R2DVgYa10UfSsDZJSFM9jGFdxiSfgQyRkR/8uyukKVsGsyAo
         OJjNZ/W74HyA3b0wY4vko0xmUwMOocwxXcfd4cWa+2CGU70y1mD/eZY6QKDlhbEtfb2J
         jtTAY+EwcLZKRTQMQQaJBLADR5V20BpYGq2fdVS/aYI0rwLP60HUvfEmrmuMq7XCDVlA
         /pPgx64N25W9ebm8J7Cf9ejCQ1AP2vBFtpy5ZyxFgAebR28S9gTZ4C2hRjJJBdGX9c+a
         D7XA==
X-Gm-Message-State: AMke39k23MwOHOX8FVXSCSjxJsJu3WnG9OTOffQnEJl193Q3tVmWFvPAcrFFDeIENlZRoI8EcAdP5m4EfoN4Ac/e
X-Received: by 10.36.65.4 with SMTP id x4mr1067105ita.69.1487030149373; Mon,
 13 Feb 2017 15:55:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Mon, 13 Feb 2017 15:55:48 -0800 (PST)
In-Reply-To: <20170213152011.12050-12-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-12-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Feb 2017 15:55:48 -0800
Message-ID: <CAGZ79kZC6TntQrW7MF6-h5z5En-u6rwNX=zuaHRNDpbO80ALHA@mail.gmail.com>
Subject: Re: [PATCH 11/11] refs: split and make get_*_ref_store() public API
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> +/*
> + * Return the ref_store instance for the specified submodule. For the
> + * main repository, use submodule==NULL; such a call cannot fail.

So now we have both a get_main as well as a get_submodule function,
but the submodule function can return the main as well?

I'd rather see this as a BUG; or asking another way:
What is the difference between get_submodule_ref_store(NULL)
and get_main_ref_store() ?

As you went through all call sites (by renaming the function), we'd
be able to tell that there is no caller with NULL, or is it?

Stefan

> For
> + * a submodule, the submodule must exist and be a nonbare repository,
> + * otherwise return NULL. If the requested reference store has not yet
> + * been initialized, initialize it first.
> + *
> + * For backwards compatibility, submodule=="" is treated the same as
> + * submodule==NULL.
> + */
> +struct ref_store *get_submodule_ref_store(const char *submodule);
> +struct ref_store *get_main_ref_store(void);
