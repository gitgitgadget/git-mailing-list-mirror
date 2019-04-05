Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6760520248
	for <e@80x24.org>; Fri,  5 Apr 2019 17:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbfDERZl (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 13:25:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35455 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731133AbfDERZk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 13:25:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so1319187pfh.2
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=daoNHX8t5ay3fJ823/SjM+xVbjkGh8coK3mnb7mkrPU=;
        b=HMi55A9iXv6RKPrDpespE8vmb+RJeMg6gvHOc80FZV3GgnclNMpsqJWvGLHrQi4hBs
         4+Hf27uZeSldU2JNnO3tii+bsxGKz+ZVgOxqmxw5dyN5IX5rTLYr0aGeFs97YC+bL7Ir
         CCY6Ci6kq2Mqb02Wl1YCVD477Ai1IkkR/rOajQYvWZ9nRThCjc4e2UvR+OGrkF88+H5b
         ZP2FKDeoTd1ghKnwEFzt0QFk1yWT+UfzMU2CRA0k5a8jrxj/msFFWx7iXOP916vsABgf
         AZMqC/tNUexjhfvixKkdq99tsW1QDxtPvGXdEE7MMotrA3EvjNyZkE8ZlaZ3YgzXz886
         IwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=daoNHX8t5ay3fJ823/SjM+xVbjkGh8coK3mnb7mkrPU=;
        b=BQW31KDginvaUxSFP2ov043gFU/Lshbbf4LaaimNThnTRpHtaS0Njv4p+Bky1xAkEi
         bAYkkc+Bm32MUZjy+xwKpPzcd6R6130Iw3Kgz45WAvXLQkoMpsDb+6MqZj3hB33l5XTY
         a0u7b+6BjIdIxb+x6QT+l/3Qdu5xu2G2D8zxsV4elJQio0gUQnoEYT1/tIS1i+ZZaUpd
         ASjl7+nP8bpZwYRu3nigU0uM2pPJtzp1D5/NXgb1V3bNlTIghNZELJiFEdGJmMSmKz2R
         wvlhyCklGe+rXoUFkQNu34d1tSRthHfrC/QOPFuNvxt2OPlSjFFZUV7mMRFLZ9Hm4taW
         VFnA==
X-Gm-Message-State: APjAAAVCNf+J63jqKI8cfrGXZ+TaDH7tcfnANAAVLbzn50G7EQL0UGhf
        ibo8VHb8UT6GhpXx2dYxssc=
X-Google-Smtp-Source: APXvYqy9TNLuhZPr0GDHVi1Z3aH51ieBoz2yOrg/ZRWjYu3amg2kLn2amDzL/lzhhkco6X6d0XtLgA==
X-Received: by 2002:a63:7154:: with SMTP id b20mr13374010pgn.359.1554485139821;
        Fri, 05 Apr 2019 10:25:39 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id p3sm34864858pfn.167.2019.04.05.10.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 10:25:38 -0700 (PDT)
Date:   Fri, 5 Apr 2019 10:25:36 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 1/4] t3431: add rebase --fork-point tests
Message-ID: <20190405172536.GA11212@dev-l>
References: <20190328221745.GA3941@dev-l>
 <cover.1554151449.git.liu.denton@gmail.com>
 <234ac9f024bf4e6b4944fd8f3912cf6367cf828b.1554151449.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.1904051653360.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904051653360.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 04:55:37PM +0200, Johannes Schindelin wrote:
> Hi Denton,
> 
> On Mon, 1 Apr 2019, Denton Liu wrote:
> 
> > diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> > new file mode 100755
> > index 0000000000..8e2483b73e
> > --- /dev/null
> > +++ b/t/t3431-rebase-fork-point.sh
> > @@ -0,0 +1,53 @@
> > +#!/bin/sh
> > +#
> > +# Copyright (c) 2019 Denton Liu
> > +#
> > +
> > +test_description='git rebase --fork-point test'
> > +
> > +. ./test-lib.sh
> > +
> > +# A---B---D---E       (master)
> > +#     \
> > +#      C*---F---G (side)
> > +#
> > +# C was formerly part of master but is side out
> > +#
> > +test_expect_success setup '
> > +	test_commit A &&
> > +	test_commit B &&
> > +	test_commit C &&
> > +	git branch -t side &&
> > +	git reset --hard HEAD^ &&
> > +	test_commit D &&
> > +	test_commit E &&
> > +	git checkout side &&
> > +	test_commit F &&
> > +	test_commit G
> > +'
> > +
> > +test_rebase() {
> > +	expected="$1" &&
> > +	shift &&
> > +	test_expect_success "git rebase $@" "
> > +		git checkout master &&
> > +		git reset --hard E &&
> > +		git checkout side &&
> > +		git reset --hard G &&
> > +		git rebase $@ &&
> 
> I think we need this patch, to make the macOS build happy:

Thanks for digging into this, both.

Out of curiosity, t3432 is written similarly:

	test_rebase_same_head() {
		status="$1" &&
		shift &&
		test_expect_$status "git rebase $@ with $changes is no-op" "
			oldhead=\$(git rev-parse HEAD) &&
			test_when_finished 'git reset --hard \$oldhead' &&
			git rebase $@ &&
			newhead=\$(git rev-parse HEAD) &&
			test_cmp_rev \$oldhead \$newhead
		"
	}

and is also invoked similarly

	test_rebase_same_head success ''

but it doesn't seem to fail. Any ideas on why?

Thanks,

Denton

> 
> -- snip --
> Subject: fixup??? t3431: add rebase --fork-point tests
> 
> Try to fix the Mac build, which currently fails thusly:
> 
>     ++ git reset --hard G
>     HEAD is now at d8775ba G
>     ++ git rebase $'\177'
>     fatal: invalid upstream '?'
>     error: last command exited with $?=128
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> index 4607e65de6..b41a0c0b68 100755
> --- a/t/t3431-rebase-fork-point.sh
> +++ b/t/t3431-rebase-fork-point.sh
> @@ -34,7 +34,7 @@ test_rebase() {
>  		git reset --hard E &&
>  		git checkout side &&
>  		git reset --hard G &&
> -		git rebase $@ &&
> +		eval git rebase \"$@\" &&
>  		test_write_lines $expected >expect &&
>  		git log --pretty=%s >actual &&
>  		test_cmp expect actual
> -- snap --
> 
> Ciao,
> Dscho
> 
> > +		test_write_lines $expected >expect &&
> > +		git log --pretty=%s >actual &&
> > +		test_cmp expect actual
> > +	"
> > +}
> > +
> > +test_rebase 'G F E D B A' ''
> > +test_rebase 'G F D B A' '--onto D'
> > +test_rebase 'G F C E D B A' '--no-fork-point'
> > +test_rebase 'G F C D B A' '--no-fork-point --onto D'
> > +test_rebase 'G F E D B A' '--fork-point refs/heads/master'
> > +test_rebase 'G F D B A' '--fork-point --onto D refs/heads/master'
> > +test_rebase 'G F C E D B A' 'refs/heads/master'
> > +test_rebase 'G F C D B A' '--onto D refs/heads/master'
> > +
> > +test_done
> > --
> > 2.21.0.695.gaf8658f249
> >
> >
