Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80164200B9
	for <e@80x24.org>; Tue,  8 May 2018 14:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755228AbeEHOGK (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 10:06:10 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:43759 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754632AbeEHOGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 10:06:09 -0400
Received: by mail-wr0-f169.google.com with SMTP id v15-v6so32432130wrm.10
        for <git@vger.kernel.org>; Tue, 08 May 2018 07:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3KO4Z4eCyFv0yNW9MsKHUrWIJaQgjFUmOUnH1RRWASA=;
        b=emW147M/RYlgShP9P2AlvF0u38nUyHIBs9buSPKd/UD9leyvyqJQQih9FRNc5SZ3BA
         2+kG41hK86OSyHtMozrGHC14uNAGTq8AsbR+mJmNUQBwbAqi0Jl5oxMA+6hXUW2Se6eh
         H/gtddA0In3Bt+xOBh7zQor+HUIJluMXXsCw+Foou8vi2QNsEDHHM8wqt0I3/jpmQfIf
         W6lTu+jtk17wpO4DuzDTJKJTge8YlqSBWky0t90uNqZn8WzVaSHua8LcKLaRcviU9nbv
         nUJjwFwax8l+/CQQ+yQy/5N4xsaNq9sUkvTtpbu4cV09ZY13LZPajvCBBjDO8EB3/FQY
         D5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3KO4Z4eCyFv0yNW9MsKHUrWIJaQgjFUmOUnH1RRWASA=;
        b=lo3dBQ1VYOfe4aWRuuNdIP4fDT+nhxyfPRjITYbcH8is6RUwnOcvfFD+/NXu2Pu4Hc
         b8z7G+XtBivzN0nfQAwG8FMwAWUA2cqygQFMqPBiK0K2/Ebo4D6mo5qDMQKP8gUGcT36
         Dz/J3gvIyXxGJTqMaUiBduDQUT0yEUZ1rc6XO240GFJkfdwGeKKXqid3x8DywcMsNZq+
         2pyYgqG8gQ0klNX1agOikgvWQl+irBA9WP88wyla3ogV+qzEpgYUh0sy66Za1pHkvT+O
         6C81+EBo/fqUKzrEEKISos1yTaZHufu09LoiNGttK14DDhYQDkNG4vJ1Z3SLCBbHChGf
         x5+g==
X-Gm-Message-State: ALKqPweQtjeR2UGP+49GjJfysgOpKkvrxj0zu+dTPFso4f6Lc80BeHRY
        64JHSm0RSzPiPcSQz90t4BA=
X-Google-Smtp-Source: AB8JxZpm5pkYyZdQ5LfwVo95YVNBayK28kkvU+c7KfyzsB8Yf42ImpZrDPPMNqJccKN877HpVr7Bcw==
X-Received: by 2002:adf:b190:: with SMTP id q16-v6mr1585986wra.221.1525788368085;
        Tue, 08 May 2018 07:06:08 -0700 (PDT)
Received: from localhost.localdomain (x590dad85.dyn.telefonica.de. [89.13.173.133])
        by smtp.gmail.com with ESMTPSA id 12-v6sm15658486wmn.27.2018.05.08.07.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 May 2018 07:06:07 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] push tests: assert re-pushing annotated tags
Date:   Tue,  8 May 2018 16:05:53 +0200
Message-Id: <20180508140553.7869-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.756.gcf614c5aff
In-Reply-To: <20180429202100.32353-5-avarab@gmail.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index c9a2011915..71fc902062 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -965,35 +965,43 @@ test_expect_success 'push into aliased refs (inconsistent)' '
>  	)
>  '
>  
> -test_expect_success 'push requires --force to update lightweight tag' '
> -	mk_test testrepo heads/master &&
> -	mk_child testrepo child1 &&
> -	mk_child testrepo child2 &&
> -	(
> -		cd child1 &&
> -		git tag Tag &&
> -		git push ../child2 Tag &&
> -		>file1 &&
> -		git add file1 &&
> -		git commit -m "file1" &&
> -		git tag -f Tag &&
> -		test_must_fail git push ../child2 Tag &&
> -		git push --force ../child2 Tag &&
> -		git tag -f Tag HEAD~ &&
> -		test_must_fail git push ../child2 Tag &&
> -		git push --force ../child2 Tag &&
> -		git tag -f Tag &&
> -		test_must_fail git push ../child2 "refs/tags/*:refs/tags/*" &&
> -		git push --force ../child2 "refs/tags/*:refs/tags/*" &&
> -		git tag -f Tag HEAD~ &&
> -		git push ../child2 "+refs/tags/*:refs/tags/*" &&
> -		git tag -f Tag &&
> -		git push --no-force ../child2 "+refs/tags/*:refs/tags/*" &&
> -		git tag -f Tag HEAD~ &&
> -		test_must_fail git push ../child2 tag Tag &&
> -		git push --force ../child2 tag Tag
> -	)
> -'
> +test_force_push_tag () {
> +	tag_type_description=$1
> +	tag_args=$2
> +
> +	test_expect_success "push requires --force to update $tag_type_description" "
> +		mk_test testrepo heads/master &&
> +		mk_child testrepo child1 &&
> +		mk_child testrepo child2 &&
> +		(
> +			cd child1 &&
> +			git tag Tag &&
> +			git push ../child2 Tag &&
> +			>file1 &&
> +			git add file1 &&
> +			git commit -m 'file1' &&
> +			git tag $tag_args Tag &&
> +			test_must_fail git push ../child2 Tag &&
> +			git push --force ../child2 Tag &&
> +			git tag $tag_args Tag HEAD~ &&
> +			test_must_fail git push ../child2 Tag &&
> +			git push --force ../child2 Tag &&
> +			git tag $tag_args Tag &&
> +			test_must_fail git push ../child2 'refs/tags/*:refs/tags/*' &&
> +			git push --force ../child2 'refs/tags/*:refs/tags/*' &&
> +			git tag $tag_args Tag HEAD~ &&
> +			git push ../child2 '+refs/tags/*:refs/tags/*' &&
> +			git tag $tag_args Tag &&function

There is that unwanted "function" at the end of the line.

Interstingly, the test does pass when run with dash, but fails the
chain-lint tests when run with Bash, even though it's in a subshell.

> +			git push --no-force ../child2 '+refs/tags/*:refs/tags/*' &&
> +			git tag $tag_args Tag HEAD~ &&
> +			test_must_fail git push ../child2 tag Tag &&
> +			git push --force ../child2 tag Tag
> +		)
> +	"
> +}
> +
> +test_force_push_tag "lightweight tag" "-f"
> +test_force_push_tag "annotated tag" "-f -a -m'msg'"
>  
>  test_expect_success 'push --porcelain' '
>  	mk_empty testrepo &&
