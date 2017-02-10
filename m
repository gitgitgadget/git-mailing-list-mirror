Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8BC1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 20:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753513AbdBJUZX (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 15:25:23 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35876 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdBJUZV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 15:25:21 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so3837852pgf.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 12:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=i8QAyTyonKn5ozRBQccD1GhxbntewgYQK4FHR7f8yj4=;
        b=sXVu0RHe0Cq/Z6Ls+1pErhoq9mmcYVGuuaNb0JZhH7siQ253ePmDJ1gcBLpk9/kZnc
         tE4b8vjh8Ns2NZi5q33Z3wmDRRdp7qRmR5N0QQD2156X78GnG89Xbb7asdj7ty9Fh8+h
         HCX/gxbX+VPQow1PKqpKoZ7BqZXCURCKMTFEkPCjEKbKlk7TcKLESWWS8f/aLjWT2tz5
         pnZX7Ap0cBhKpPkTZLSyf20IUFNQZZbVV3OF7kgMSbm/TNNvBntRtgrcg8kMmVoS6g/L
         Go49Vk6f3s7AqqkaIsuLo674BwcH5T9Hwgbr+Osg9i6YN9iCH6SYN/EMZbvqUAm5DTGw
         OhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=i8QAyTyonKn5ozRBQccD1GhxbntewgYQK4FHR7f8yj4=;
        b=HY/PEoFK2drcHALknhH8v7u2CpNRNczNsGpcjW1od66aW94ZCkPZJ0LHd9GWrxEFCt
         P2o+aoiE9EQR4GLMSZVhCD+1osIOZtiCl2Ls+YUzFleJeLNU2D8QJJcdHpSuRCbdcZ6N
         J+nwqrc+BKVfEig0/SDB/ZtsiBwptnpn5L1Z3rK//B2CeoJ5UIiN9zlwApPIdOS8AH00
         NZ1/WqgZ2PCoY1nBSgL4O6S+LHitjohjKhxBrxjvSu1xLx+QQPze6lSkNddR8+gCOrID
         PIrhXcI33j261BMOBqz9b+gypGAa8XDZuLsZ44aSugSzZO1/LPEpgnScJke+CWf1vjv6
         kqLg==
X-Gm-Message-State: AMke39m0oYb9yrU690AV/wzpleYxVwPaLbA7Yss2JLd4E+5hqR46FG4PuiMphwORS+bsYA==
X-Received: by 10.84.225.20 with SMTP id t20mr13879073plj.154.1486758320758;
        Fri, 10 Feb 2017 12:25:20 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id b7sm7256899pfg.53.2017.02.10.12.25.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 12:25:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] rev-parse tests: add tests executed from a subdirectory
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
        <cover.1486740772.git.johannes.schindelin@gmx.de>
        <cc23463af8096c5f8429f939ce881cf0eb5c2dcd.1486740772.git.johannes.schindelin@gmx.de>
Date:   Fri, 10 Feb 2017 12:25:18 -0800
In-Reply-To: <cc23463af8096c5f8429f939ce881cf0eb5c2dcd.1486740772.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 10 Feb 2017 16:33:41 +0100
        (CET)")
Message-ID: <xmqqpoipkd3l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 292a0720fcc..1d6e27a09d8 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -200,4 +200,21 @@ EOF
>  	test_cmp expect actual
>  '
>  
> +test_expect_failure 'rev-parse --shared-index-path' '
> +	rm -rf .git &&
> +	test_create_repo . &&

Another thing that I notice only after merging this and other topics
to 'pu' was that this piece needs to always come at the end of the
script because of this removal.  It would make the test more robust
to create a test repository for this test and work inside it.

> +	git update-index --split-index &&
> +	ls -t .git/sharedindex* | tail -n 1 >expect &&
> +	git rev-parse --shared-index-path >actual &&
> +	test_cmp expect actual &&
> +	mkdir work &&
> +	test_when_finished "rm -rf work" &&
> +	(
> +		cd work &&
> +		ls -t ../.git/sharedindex* | tail -n 1 >expect &&
> +		git rev-parse --shared-index-path >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_done
