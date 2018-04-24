Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677FB1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 01:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbeDXBBE (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 21:01:04 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:43755 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932625AbeDXBBD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 21:01:03 -0400
Received: by mail-wr0-f179.google.com with SMTP id v15-v6so27869403wrm.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 18:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+xsXWklmZfYa8NrFrHaRGfWe8YCroaNY7DAuNSgryf8=;
        b=shEMHeF7JV6dqTIlDK+8rZp+aj9dAsWWzcORgoZ/29gT4WgYbU5pfZWCOHuC6KiRa/
         x5XusHqcaCdSaut7Q4Fsdz0K1AZddGVV95ufIkAWnhzVGbf2Uh/l0cnCoqOC0H2HAXRC
         YsPrCqQdG4a7dXajrNQCcL9iUK/UXAt09EWXPQ32+z0iYV+ohr6Y4CQQ88jC5BDiwn30
         15YEM8+KLUHiECkAoTLc0j2By8RaVDKKjk+8242oRHcw6Injj+J8Lt6u5f4dTlm+7eqH
         0IjnJ3YI0BPS8S/xggayFnYrtS9nVrHWtpTb++IIVc8AYQ/MAGskEzwF0BlUnNKAfL5Q
         aqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+xsXWklmZfYa8NrFrHaRGfWe8YCroaNY7DAuNSgryf8=;
        b=KmXJ6OXTPOcyDEsdfbmkRolr2UbdATS7BtJrCD6FbDnWlsWB9LOVvFMyriqoyTBrgb
         bLv9hv63zqHUelFnhN+6+v5NPxjtcPLSGBEzOIzuUf4i2Lab+2dFYXriqbtfkqFdBO6r
         nrQpsQFfGUBkihflyaNEU5DsQzw8h6+U5rfBenHNWDGbRf039sD07TTKVqCJlxQXcGxy
         x+fRmzFqLYEWko7+NWajnj520o6xbHky8+5QRDmLiJdGIvRWXs7qAOc/O0EI2BJieb/c
         IYmKGJE3fk/OB/MaqTOa6nL9by+VLJ3Oqyd191yd8dXoD1R/wXndvwRfIHt2lW+GpHCR
         mmrQ==
X-Gm-Message-State: ALQs6tD+vdRmuvgi4aw5SPZ5gMUuXAIJGLLAkbDREZJ62dCli42EdyCs
        jx436ZlSKw6l96YloK7kuUc=
X-Google-Smtp-Source: AIpwx48jVhn1UbQeef4ZBBROZcECextvo/3wMmN2aA2oma3FlHid2yzZWGIbDzC12fumLkmXbTgyFQ==
X-Received: by 2002:adf:b90a:: with SMTP id k10-v6mr19733811wrf.283.1524531662243;
        Mon, 23 Apr 2018 18:01:02 -0700 (PDT)
Received: from localhost.localdomain (x590d83b9.dyn.telefonica.de. [89.13.131.185])
        by smtp.gmail.com with ESMTPSA id x189sm2358733wmg.0.2018.04.23.18.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Apr 2018 18:01:01 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 41/41] merge-one-file: compute empty blob object ID
Date:   Tue, 24 Apr 2018 03:00:55 +0200
Message-Id: <20180424010055.13183-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.geecde6d7e8
In-Reply-To: <20180423233951.276447-42-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net> <20180423233951.276447-42-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This script hard-codes the object ID of the empty tree.  To avoid any

s/tree/blob/

> problems when changing hashes, compute this value by calling git
> hash-object.

Missing signoff.

> ---
>  git-merge-one-file.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> index 9879c59395..f6d9852d2f 100755
> --- a/git-merge-one-file.sh
> +++ b/git-merge-one-file.sh
> @@ -120,7 +120,7 @@ case "${1:-.}${2:-.}${3:-.}" in
>  	case "$1" in
>  	'')
>  		echo "Added $4 in both, but differently."
> -		orig=$(git unpack-file e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
> +		orig=$(git unpack-file $(git hash-object /dev/null))
>  		;;
>  	*)
>  		echo "Auto-merging $4"
> 
