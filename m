Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAD7A1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 16:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbeHBSdA (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 14:33:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34538 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeHBSc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 14:32:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id h1-v6so1178543eds.1
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYXM6ZCIC2KJtnIf6Q7jwBotbY0mMUPfK8zmN+wWLL4=;
        b=YXESSu4swm4x5F4g6VkSGDKLVtIrnDhDGNiZ3ouvXEhwHodWAMjR/OOTpS8OTYcH24
         6fJyLh/j+vjIjhxXincXyWSmziulVHjO3Z10lz1XbwauJrMkN5ZSeDPFiXvndeI/l8zj
         aH2sfr8EOZllZ3MuWXfUUTTpEHkmZp4RqmndMx+oKpooAYYjbMeXv1JKIRDKxlkN+pG8
         gsI3RT4QfNfyvJHVW/54PFn+CMsINNWAUpFJhg5Gbrek+JY5U4YVqVQC6n/VrZ7dZbhG
         M6r7VvQnOVZIlnztUThhV0JKU4o+RkdtgiyqrYPwg30uK3wk8B0y1CqR+6avvlcFO4pr
         9tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYXM6ZCIC2KJtnIf6Q7jwBotbY0mMUPfK8zmN+wWLL4=;
        b=l1U6LlhrRSDs4dqlexG5ackmfn4b5dm0W/tpEgUujouqp1xQ1ABhCMyAqd57NZJgvh
         VkIHpNszreLzd/fS/bo0ymbot571dscWDrLRF5lHocg51Jdew7ERWTZ0YE17PIZBRNAv
         gpZtg5i1Avcmp97IX9IqTl90cCqt3Xa8CrD/UY1CQcM03CCR7qlUhP4KSAFQ5M1ADL1H
         rRZJdeCSeJ6xH6VGZdhR5z0XB9a9pyVMVDUPAs9odFVKPu9OSa0ypHYTJ9Y2OqQrZLYc
         v2ol2WPyiKy53PvMZEGY1UJBSRXp9FX4CVQorZjWhPVWJ9rzpOOS9THc1Mairv2N2/lz
         86Zw==
X-Gm-Message-State: AOUpUlFpuIPlBpsAAxoIt/TRukG53pLhTDYgQzmxfHdbKCQyRxNMezNr
        nYXaZgAOQgg2F8AsoiLmAfkzzabZ
X-Google-Smtp-Source: AAOMgpcdyfYPBFuWf4xeB2k6cw2U0SWtXo9M42qK7/8xIhYby/WFYbMJEHlesiBH2OZrKy+4rauUvg==
X-Received: by 2002:a50:aec9:: with SMTP id f9-v6mr4090107edd.72.1533228063803;
        Thu, 02 Aug 2018 09:41:03 -0700 (PDT)
Received: from localhost.localdomain (x4db11307.dyn.telefonica.de. [77.177.19.7])
        by smtp.gmail.com with ESMTPSA id p5-v6sm1370474edc.33.2018.08.02.09.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Aug 2018 09:41:02 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH v2 03/12] t7411: be nicer to future tests and really clean things up
Date:   Thu,  2 Aug 2018 18:40:42 +0200
Message-Id: <20180802164042.28026-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180802134634.10300-4-ao2@ao2.it>
References: <20180802134634.10300-1-ao2@ao2.it> <20180802134634.10300-4-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Tests 5 and 8 in t/t7411-submodule-config.sh add two commits with
> invalid lines in .gitmodules but then only the second commit is removed.
> 
> This may affect future subsequent tests if they assume that the
> .gitmodules file has no errors.
> 
> Since those commits are not needed anymore remove both of them.
> 
> The modified line is in the last test of the file, so this does not
> change the current behavior, it only affects future tests.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
> 
> Note that test_when_finished is not used here, both to keep the current style
> and also because it does not work in sub-shells.

That's true, but I think that this:

  test_when_finished git -C super reset --hard HEAD~2

at the very beginning of the test should work.

>  t/t7411-submodule-config.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
> index 0bde5850ac..248da0bc4f 100755
> --- a/t/t7411-submodule-config.sh
> +++ b/t/t7411-submodule-config.sh
> @@ -135,7 +135,9 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
>  			HEAD submodule \
>  				>actual &&
>  		test_cmp expect_error actual  &&
> -		git reset --hard HEAD^
> +		# Remove both the commits which add errors to .gitmodules,
> +		# the one from this test and the one from a previous test.
> +		git reset --hard HEAD~2
>  	)
>  '
>  
> -- 
> 2.18.0
> 
> 
