Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7009F1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 19:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdL0TqU (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 14:46:20 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:37051 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdL0TqT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 14:46:19 -0500
Received: by mail-io0-f193.google.com with SMTP id n14so13035180iob.4
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 11:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bkNc5ofteKOe3F044GF1dS4fiGfehGf7DH6drd2fi1Y=;
        b=rbrw7n4jn/MoDFe2dk8RFOzImJE0gP8LWF8xdq2bNM84v7UWGK9RpugcGkBpIPvpfG
         GeYiQS+13Su2xUSk2E8c4UsOf2fAi574Ep4sOQ6uhqkNnRNAMO8tpvZkIa+ul3vs9POp
         vklSAHBPiUid3jwcxKjcTsvyFDMSIMbbCEUg8oFDr7fyAiOlozgcQvQvJs3lInQT3gy1
         eVWcqTJAfmSxvuBWqtSUmWVNSw4bnqTKE9aHzwz53JomArJpzlOBwqlVc5106eyKzFm4
         b4PAiGfaVJjF9Zi+rHCQyk8Qr6fB7t+sp5sxPpn8TXOstLGKd0ebBPipWrDvQ6N9/5E2
         K0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bkNc5ofteKOe3F044GF1dS4fiGfehGf7DH6drd2fi1Y=;
        b=cCM6+CeWa4YhKYCAGm3zyD1Qxg3JwMTzbW0A6vMFFp79/Cz2rWsY/t/BnTJ9Y9jklo
         8earCCuNrQkGFtKSKEGmv7A+sZqaCnC/mwdqHrKmAnpj8+UWz96c4PiEnY3l5FqHi0va
         VE8xemarf2cGrZm/mlT0HO5f5gBw8MXfnmOrL/zgMmOjHKpnb0tPZQxBGB71JFqirwSU
         qxJDiz81HmZEDaejm+RFYA1sdJRujbaIIIw/Ji6pO9Da6mlSkhlYTxYo8eSN81i/JXxS
         u/1NshdqBMUX6FJ/y1yQg4iMhYP3aKLiIv8GUSsglII88tN35JNrHq7LCQPaT+mg6QxW
         23VQ==
X-Gm-Message-State: AKGB3mLnvzr/B4QLg5sHeFQDBBJ2t5gWm3NgN/Vyszbk+kTi7ocH4ubl
        TpQEmTeitxNj+javgtmYooI=
X-Google-Smtp-Source: ACJfBosnZJGdrpNyMMOVYZoQRvq9LfG+U6PBNwxPSRrocjbjQWjz9OnrMZQXxRkcFrqQqPyVKCPzRg==
X-Received: by 10.107.129.200 with SMTP id l69mr37541070ioi.158.1514403978733;
        Wed, 27 Dec 2017 11:46:18 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z27sm11069845ita.13.2017.12.27.11.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 11:46:18 -0800 (PST)
Date:   Wed, 27 Dec 2017 11:46:01 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] travis-ci: don't try to create the cache directory
 unnecessarily
Message-ID: <20171227194601.GA181628@aiede.mtv.corp.google.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com>
 <20171227164905.13872-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171227164905.13872-2-szeder.dev@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor wrote:

> Travis CI creates that directory for us anyway, even when a previous
> cache doesn't exist for the current build job.
>
> In itself it doesn't hurt to try, of course, but the following patch
> will access the Travis CI cache much earlier in the build process, and
> then creating the cache directory this late might cause confusion.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  ci/run-tests.sh | 1 -
>  1 file changed, 1 deletion(-)

Is this behavior documented anywhere?
https://docs.travis-ci.com/user/caching#Arbitrary-directories doesn't
say anything about it.

Thanks,
Jonathan
