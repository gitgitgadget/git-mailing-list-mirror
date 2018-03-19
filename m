Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23BB41F404
	for <e@80x24.org>; Mon, 19 Mar 2018 21:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964840AbeCSVyw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 17:54:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39075 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933303AbeCSVys (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 17:54:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id f125so10175171wme.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HfvVoAJafbLzcslTgF/4TbJJ+t6YMceGf07UD/4GfYw=;
        b=NJjho2nGBRxgp/F/S6mIBhNdtIEYeWwrpRnFTLikcXIwEGsavJ1xYMPPAJI4gd69fT
         m3jkri+k76SJlq32gnX/Z3BaXH41lsuvOa7VUS0ksQzPmXXus1xzIimYk8blXYWvB+qj
         cmrscosKzBd5neRdmkIhwey5SCxcZw1i9k8M1Yx+J8EOYg+3VVSD4IxVxLX243fymhGy
         dUv/xRmKHuJjZq7duNVZ+ssU2auPmshnABAdOqeNtnQvEIEDcv+4/fZH/aLjiJtPzZLM
         B7kHfozSLEhvy1V1n4EL6PI4zpb2AssDNSXewoj57Gewg2v1lsn44lFk0ejsfm2SvxNy
         9rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HfvVoAJafbLzcslTgF/4TbJJ+t6YMceGf07UD/4GfYw=;
        b=WCyJn5eEJsZOc1tmAE5HJiMferjxy5BgO3dlvT/9WnyH0hCjAe5x9M+TuN2AXBOS/T
         yLzwp0m/vA6e7u6mVpvaWH1S8ce2rkXfkJJxzWfFmmO9mFWsb+jeckhcgUga3DLmwKfD
         mHQoWFWyIxceb3hN1Ff7v3pah7q0GLXNgCHQNbxHuooYSq9FDerv6sxSEOlGrRMtqe5V
         XphrzZv01L1DUkeFYOuMnG/ZN8lta92b326DLGJKUwTkcST5XffUFFnanRR85zSRHb7n
         6X9WqU88xytF16oPq/A7hFCJ5b4etx7TAErh32ig7ZteT0P4y+agk9jDSBV2A/pMz0h8
         LVLg==
X-Gm-Message-State: AElRT7ENAvea5SUYAmmIPRxS+qls6C/QThGjptdH3TEUoRNAHZjZpxJk
        dgn1T7eh5Fhq0s3Q2egECTA=
X-Google-Smtp-Source: AG47ELtC0S5xpT77OSi6Ctd/a+okZ6aAMby4WmRuuBemvRt0yl7VfZk1PrIgl4CZgoBTAS7LThZ4ZQ==
X-Received: by 10.28.218.14 with SMTP id r14mr226557wmg.133.1521496486317;
        Mon, 19 Mar 2018 14:54:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f3sm169206wre.72.2018.03.19.14.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 14:54:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v5] Make options that expect object ids less chatty if id is invalid
References: <20180319185436.14309-1-ungureanupaulsebastian@gmail.com>
Date:   Mon, 19 Mar 2018 14:54:45 -0700
In-Reply-To: <20180319185436.14309-1-ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Mon, 19 Mar 2018 20:54:36
        +0200")
Message-ID: <xmqqd0zzu3x6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> Subject: Re: [GSoC][PATCH v5] Make options that expect object ids less chatty if id is invalid

For the past few iterations, this is no longer about "options that
expect object IDs that get an invalid one" anymore, right?  The fix
has become a lot more generic and extended in scope.

> Usually, the usage should be shown only if the user does not know what
> options are available. If the user specifies an invalid value, the user
> is already aware of the available options. In this case, there is no
> point in displaying the usage anymore.

This presents the more general fix implemented in these later rounds
rather well.

	parse-options: do not show usage upon invalid option value

may be a title that match the more recent state of this topioc
better.

> diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
> new file mode 100755
> index 000000000..2fc08ae70
> --- /dev/null
> +++ b/t/t0041-usage.sh
> @@ -0,0 +1,89 @@
> +#!/bin/sh
> +
> +test_description='Test commands behavior when given invalid argument value'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup ' '
> +	git init . &&

Do you need this "git init ."?  I somehow doubt it.

> +	test_commit "v1.0" &&
> +	git tag "v1.1"
> +'
> +
> +test_expect_success 'tag --contains <existent_tag>' '
> +	git tag --contains "v1.0" >actual &&
> +	grep "v1.0" actual &&
> +	grep "v1.1" actual
> +'
> +
> +test_expect_success 'tag --contains <inexistent_tag>' '
> +	test_must_fail git tag --contains "notag" 2>actual &&
> +	test_i18ngrep "error" actual
> +'
> +
> +test_expect_success 'tag --no-contains <existent_tag>' '
> +	git tag --no-contains "v1.1" >actual &&
> +	test_line_count = 0 actual
> +'

So...  at this point there are v1.0 and v1.1 that point at the same
commit and there is no other comit nor tag.  There is no tag that
does not contain v1.1 so the output is empty.

Which is correct, but is a rather boring thing to try ;-).

> +test_expect_success 'tag --no-contains <inexistent_tag>' '
> +	test_must_fail git tag --no-contains "notag" 2>actual &&
> +	test_i18ngrep "error" actual
> +'

Good.  Don't we need to check that this does not have "usage" in it?

> +test_expect_success 'tag usage error' '
> +	test_must_fail git tag --noopt 2>actual &&
> +	test_i18ngrep "usage" actual
> +'
> +
> +test_expect_success 'branch --contains <existent_commit>' '
> +	git branch --contains "master" >actual &&
> +	test_i18ngrep "master" actual
> +'
> +
> +test_expect_success 'branch --contains <inexistent_commit>' '
> +	test_must_fail git branch --no-contains "nocommit" 2>actual &&
> +	test_i18ngrep "error" actual
> +'

Likewise.

> +test_expect_success 'branch --no-contains <existent_commit>' '
> +	git branch --no-contains "master" >actual &&
> +	test_line_count = 0 actual
> +'
> +
> +test_expect_success 'branch --no-contains <inexistent_commit>' '
> +	test_must_fail git branch --no-contains "nocommit" 2>actual &&
> +	test_i18ngrep "error" actual
> +'

Likewise.

> +test_expect_success 'branch usage error' '
> +	test_must_fail git branch --noopt 2>actual &&
> +	test_i18ngrep "usage" actual
> +'
> +
> +test_expect_success 'for-each-ref --contains <existent_object>' '
> +	git for-each-ref --contains "master" >actual &&
> +	test_line_count = 3 actual
> +'
> +
> +test_expect_success 'for-each-ref --contains <inexistent_object>' '
> +	test_must_fail git for-each-ref --no-contains "noobject" 2>actual &&
> +	test_i18ngrep "error" actual
> +'

Likewise.

> +test_expect_success 'for-each-ref --no-contains <existent_object>' '
> +	git for-each-ref --no-contains "master" >actual &&
> +	test_line_count = 0 actual
> +'
> +
> +test_expect_success 'for-each-ref --no-contains <inexistent_object>' '
> +	test_must_fail git for-each-ref --no-contains "noobject" 2>actual &&
> +	test_i18ngrep "error" actual
> +'

Likewise.

> +test_expect_success 'for-each-ref usage error' '
> +	test_must_fail git for-each-ref --noopt 2>actual &&
> +	test_i18ngrep "usage" actual
> +'
> +
> +test_done
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ef2887bd8..cac8b2bd8 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -919,10 +919,8 @@ test_expect_success 'rebase --exec works without -i ' '
>  test_expect_success 'rebase -i --exec without <CMD>' '
>  	git reset --hard execute &&
>  	set_fake_editor &&
> -	test_must_fail git rebase -i --exec 2>tmp &&
> -	sed -e "1d" tmp >actual &&
> -	test_must_fail git rebase -h >expected &&
> -	test_cmp expected actual &&
> +	test_must_fail git rebase -i --exec 2>actual &&
> +	test_i18ngrep "requires a value" actual &&
>  	git checkout master
>  '
