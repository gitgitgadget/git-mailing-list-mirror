Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6D711F461
	for <e@80x24.org>; Wed,  3 Jul 2019 09:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfGCJIt (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 05:08:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51241 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfGCJIt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 05:08:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so1384114wma.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 02:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qLZhl67sKKipbrqxVaGRVsnynHyHchnFA2Xg8Jpo8WQ=;
        b=oBQUwLe0+fFvPjkSzTRNooOyg+Q5sK1qstCJ3m4vP6SrpJS4BYG8aDtOzoijpjUxaW
         DdRtZ5reHm9bfDTeIhCf7t99kIxm4VZBlZKksRdLe+qU6BBtdA8hLoZiDDhlIy/AKzOB
         y0zJRtDKfjeo5gislX4HCELVaTVQKSNpWk7dYKiW/ewBC7E3STl11oQXFA1Iwvjy1zq+
         2b3qS510Wi7o0n6GMVPvAbf8d5K2/hcGLQqvnxgSOYWHngJLY9fGDl+J5tcHjWcDzZKP
         EJCdoPxcyUHMwU3H7XtCpeSSQRmIiVUq8VLEUlGo/+NuFQRfh73KUIAQBqOq3xAqz7/m
         w4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qLZhl67sKKipbrqxVaGRVsnynHyHchnFA2Xg8Jpo8WQ=;
        b=IbqHqrOUvoat0k0R1PrXhnYbACErx1B5qmwNTBgdoYy8A1TQL1J5HIBJxhon1K93W0
         LxdbQz8Qjv5G0FrHNWbzeXA2xgV1KVupKzX0b4pz1Vtlwpdwj6USQtVSOj6Nc9fmo/55
         vCLlOF81uUSkGfp1G8CI4W0aDUlueHt6g6qDwYG91tINjLbTib64GT+Y1FjlAutHSwDb
         3B3Fw/rJVaeeUnUa5F1A8i1l3tdaSfxBOXLVPjcxHcl7Uc9ImRWoww3PB4h1S3vZouSw
         hchN6sh+DIxTIW3x8nkRhtA42zscpvqdkMjU+PpT7q6wuNCHdYOqZodWsI4jhLJQ+6pW
         rQnA==
X-Gm-Message-State: APjAAAXhM8DrzIUL0buUoAJ7xSQLe2/8pLDnfwDgRNTBtK8uOAWGrMJh
        rrGElEkOB+Ae+pMxR4jUDlk=
X-Google-Smtp-Source: APXvYqwdqBEbR55g9cLv1QeE/dus2mSBuPbui/7nT0IibL/lxmb5OoEL5kkMz2GAKDB5LI3Hxe1uJw==
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr6752469wml.59.1562144927018;
        Wed, 03 Jul 2019 02:08:47 -0700 (PDT)
Received: from szeder.dev (x4db51bef.dyn.telefonica.de. [77.181.27.239])
        by smtp.gmail.com with ESMTPSA id s10sm1948856wmf.8.2019.07.03.02.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 02:08:46 -0700 (PDT)
Date:   Wed, 3 Jul 2019 11:08:44 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 05/10] split-index.c: dump "link" extension as json
Message-ID: <20190703090844.GO21574@szeder.dev>
References: <20190624130226.17293-1-pclouds@gmail.com>
 <20190624130226.17293-6-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624130226.17293-6-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 08:02:21PM +0700, Nguyễn Thái Ngọc Duy wrote:
> diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
> index 082fe8e966..dbb572ce9d 100755
> --- a/t/t3011-ls-files-json.sh
> +++ b/t/t3011-ls-files-json.sh
> @@ -44,4 +44,18 @@ test_expect_success 'ls-files --json, main entries, UNTR and TREE' '
>  	compare_json basic
>  '
>  
> +test_expect_success 'ls-files --json, split index' '
> +	git init split &&
> +	(
> +		cd split &&
> +		echo one >one &&
> +		git add one &&
> +		git update-index --split-index &&
> +		echo updated >>one &&
> +		test_must_fail git -c splitIndex.maxPercentChange=100 update-index --refresh &&
> +		cp ../filter.sed . &&
> +		compare_json split-index
> +	)
> +'

I think this test should 'sane_unset GIT_TEST_SPLIT_INDEX'.  Maybe
it's not absolutely necessary, because the explicit '--split-index'
and '-c splitIndex.maxPercentChange=100' would already fully control
when index splitting is performed, eliminating any indeterminism
inherent to GIT_TEST_SPLIT_INDEX...  but unsetting it would reduce the
cognitive load on future readers.

The same might apply to GIT_TEST_FSMONITOR in the following patch, and
perhaps even to GIT_TEST_INDEX_THREADS.

