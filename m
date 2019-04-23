Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B664A1F453
	for <e@80x24.org>; Tue, 23 Apr 2019 23:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfDWXMr (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 19:12:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40375 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWXMr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 19:12:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so8236447pfc.7
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 16:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lbCfF0HJws/hwHKaO3OUek3eI0wosGbyBaSwxHNOOIU=;
        b=G8yoD8kuyLs0RnpWOc77k0awyJPOZJCOun2xqPgNoRqGCQbnZs3+QPOby+XRZH63ry
         32BVrwSZ241oJf+gFSPUW4IRxUHE0izUiBp8zTFjgtDXq3Ar4rlO2NCD/ZlVveYAbK67
         /oWAfbDhhrygrEIhoh7mz0drf7s4VAHEALUrJHrOHsVnS9QjmaHekzkbCuR1y+54QGIb
         HQbVugrH2iW8Xmtcemk+KntJb7wOMQ7Nbhhtg2RU/meD6XF6d4m96seIEVEZKdTFc96u
         7G5N/QvaEFRkICFCdxPz0zaMsPU3Zxx1QVhOH8oUCPuiRzqz3XSSLPMmjoahLdnmx86n
         lalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lbCfF0HJws/hwHKaO3OUek3eI0wosGbyBaSwxHNOOIU=;
        b=XZCcZ8CSn3F/KYAatCbG6jfEhDgcYoI+jOWQSNeuGb0qFuv1x8ewP3yQ/uwky21zpB
         PPpMpUnTzIfl+giXYuUN0Gx2g9c3kzos1HiLHJdNYsw2nkRXrqPE/y03Gs2JFj5T0Juj
         5wdCd1hE0evfO+ekZzsRpIb3zzQA8VZ7XX71Ot7DSTGPBXIm9P6ByxvZ9I5maO8jbDyB
         1Nb0QJO3Yj2pQ5Y6ZS4VsVHv2Y6wjoRbTKnH4y/gmB8S7d589m49C2AyXYbgUMXwo5pc
         BaMEiUUbw0QLWyn2wWedpdzQ7BQ1ep1yNzk74qklYq2KCA/eNSjCiLbiVkyswAzgX4Ae
         qg3w==
X-Gm-Message-State: APjAAAV73b3Hvs7ztqXlXPzNWTVleO2xpYA211zyLCknHZDHk0DtriZb
        DpGExW3+XNdZIpM07DxSd7xJms9U
X-Google-Smtp-Source: APXvYqzx0pd7jTwENaiDEbVZiOAXDdMpKeBWw9kB8c0AaxNrfgnD2j85oczO67zps31yM0388mMdbA==
X-Received: by 2002:a63:ff0f:: with SMTP id k15mr26681202pgi.407.1556061165878;
        Tue, 23 Apr 2019 16:12:45 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id q20sm387353pfi.166.2019.04.23.16.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 16:12:44 -0700 (PDT)
Date:   Tue, 23 Apr 2019 16:12:43 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v7 1/6] t3431: add rebase --fork-point tests
Message-ID: <20190423231243.GA14157@dev-l>
References: <cover.1555523176.git.liu.denton@gmail.com>
 <cover.1555832783.git.liu.denton@gmail.com>
 <eb64f6c91d27a6f9666c9829050995d9f9b52925.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb64f6c91d27a6f9666c9829050995d9f9b52925.1555832783.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, Apr 21, 2019 at 01:11:18AM -0700, Denton Liu wrote:
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t3431-rebase-fork-point.sh | 53 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100755 t/t3431-rebase-fork-point.sh
> 
> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> new file mode 100755
> index 0000000000..9b517d87a3
> --- /dev/null
> +++ b/t/t3431-rebase-fork-point.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2019 Denton Liu
> +#
> +
> +test_description='git rebase --fork-point test'
> +
> +. ./test-lib.sh
> +
> +# A---B---D---E    (master)
> +#      \
> +#       C*---F---G (side)
> +#
> +# C was formerly part of master but master was rewound to remove C
> +#
> +test_expect_success setup '
> +	test_commit A &&
> +	test_commit B &&
> +	test_commit C &&
> +	git branch -t side &&
> +	git reset --hard HEAD^ &&
> +	test_commit D &&
> +	test_commit E &&
> +	git checkout side &&
> +	test_commit F &&
> +	test_commit G
> +'
> +
> +test_rebase() {

I read in an email thread earlier that the preferred style for function
definitions is to include a space after the name. Sorry for not catching
this earlier.

Could you please change this to `test_rebase () {` for me?

Also, same comment applies to `test_rebase_same_head` in 2/6.

Thanks so much,

Denton

> +	expected="$1" &&
> +	shift &&
> +	test_expect_success "git rebase $*" "
> +		git checkout master &&
> +		git reset --hard E &&
> +		git checkout side &&
> +		git reset --hard G &&
> +		git rebase $* &&
> +		test_write_lines $expected >expect &&
> +		git log --pretty=%s >actual &&
> +		test_cmp expect actual
> +	"
> +}
> +
> +test_rebase 'G F E D B A'
> +test_rebase 'G F D B A' --onto D
> +test_rebase 'G F C E D B A' --no-fork-point
> +test_rebase 'G F C D B A' --no-fork-point --onto D
> +test_rebase 'G F E D B A' --fork-point refs/heads/master
> +test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
> +test_rebase 'G F C E D B A' refs/heads/master
> +test_rebase 'G F C D B A' --onto D refs/heads/master
> +
> +test_done
> -- 
> 2.21.0.967.gf85e14fd49
> 
