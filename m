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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BECC1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 08:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfH0ILK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 04:11:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42434 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbfH0ILJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 04:11:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so17784458wrq.9
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 01:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UNk4yum4ufPGr0Rzsgv7QNCKxCZZHDAYDXhPpwU2kzo=;
        b=VG+NviNzcZOpNfoOcy5b6CYnMkHakvLLNLTM8elZzCtlTmJspTo3ohFXA+WwzLOlWt
         e2XFdxGtLV8TjRreBvz2lHYwu0wa19bSC0uHPJ6z9nB5Nf6Xv9WMrd0ZlBw1dxIJaUhR
         USa+lGBZZDdwTxuZ0vaiOXO/sfnwNL5hSqES0+5kjk1No5PPZbQdp9EECVuAD+46dhhF
         Bd2YanDVqz7YtP7CmHPlcC5QDgjZ6HgcirN7sWK1LsKDACCmBe5HsftZKRdLumQ9GFi2
         OJrPZ0OuhLe+qCkyUxeCcCtoaygyopwOhaGpCvr586MfiMABygdnyJjy8r0AQ5PXsc8j
         KM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UNk4yum4ufPGr0Rzsgv7QNCKxCZZHDAYDXhPpwU2kzo=;
        b=Dtit5M1X6Nr0Oqh1NEv4gZZX3pTHmQLj73tdnmbGojT9KgQDwJ1qgfPh82NlTmwSbj
         GsJe500RjKjALPlpNMFKBpnUTY/xPYaS9ELYl7lKLIiJEaUzjgBI720TN5H9mOmAkU+H
         KqemUauwgQ9kmVFk4XMAOpBQCAMSR8xF+6ogfAjMSUlci9L8OiNCUkTXQWqnV3lfz/4G
         7fjv9k9eV3WAAck3yh5rTWQknRIOrldClEl8NfZUI2heO0PzxQ5R1W8ih9n377lrgWU3
         KW0B7XeBsxIaMfDk2cfL/egmzEtLBxcUOdMMK4J3MuUbuhbFFVxUnvlBbWfnDkpdheod
         aV/g==
X-Gm-Message-State: APjAAAW/SIt2CWBukqLOVGnzv3U79kcvf0iThEscbPtsfT70/d9ezlAs
        QVcnMFNsfZd1JsiQ7DsChOg=
X-Google-Smtp-Source: APXvYqwNuEeXV+2Z6bTBF6yFnlODhDi4hyhPkTChiC3nqT2GB6jbocOKP0Ify4YiZSrs1E6ZxbZmxQ==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr871514wrj.52.1566893467946;
        Tue, 27 Aug 2019 01:11:07 -0700 (PDT)
Received: from szeder.dev (x4db46f61.dyn.telefonica.de. [77.180.111.97])
        by smtp.gmail.com with ESMTPSA id e10sm14573184wrn.33.2019.08.27.01.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 01:11:07 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:11:04 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: Re: [PATCH v10 4/9] t3432: test for --no-ff's interaction with
 fast-forward
Message-ID: <20190827081104.GT20404@szeder.dev>
References: <cover.1566724236.git.liu.denton@gmail.com>
 <cover.1566884063.git.liu.denton@gmail.com>
 <48b4e41a17d98b2f3a4254ed37c76361c3abc9ba.1566884063.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48b4e41a17d98b2f3a4254ed37c76361c3abc9ba.1566884063.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 01:37:53AM -0400, Denton Liu wrote:
> From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

> +	test_expect_$status "git rebase$flag $* with $changes is $what with $cmp HEAD" "
>  		oldhead=\$(git rev-parse HEAD) &&
>  		test_when_finished 'git reset --hard \$oldhead' &&
> -		git rebase $* >stdout &&
> +		git rebase$flag $* >stdout &&
>  		if test $what = work
>  		then
> +			# Must check this case first, for 'is up to
> +			# date, rebase forced[...]rewinding head' cases
>  			test_i18ngrep 'rewinding head' stdout
>  		elif test $what = noop
>  		then
> -			test_i18ngrep 'is up to date' stdout
> +			test_i18ngrep 'is up to date' stdout &&
> +			! test_i18ngrep 'rebase forced' stdout

This must be written as 'test_i18ngrep ! ....'.  When running the test
with GIT_TEST_GETTEXT_POISON=true, then 'test_i18ngrep' is basically a
noop and always returns with success, the leading ! turns that into a
failure, which then fails the test.

