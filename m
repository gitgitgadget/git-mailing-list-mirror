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
	by dcvr.yhbt.net (Postfix) with ESMTP id CC98C1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 18:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfHESBs (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 14:01:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32945 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730312AbfHESBj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 14:01:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so85423318wru.0
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3mDgvv19Pjii0hkVqGjAHj9m2dmOLS10IHxekCbp94Q=;
        b=qOLLWr7DZfJurNorVS/sBaMnOJ0nMvxa+HHRBmgR1/K0zMoywWEnFZiPILqDIlOJXa
         ug0ha5TYzW9hyMwnIM3RRYNTePkaT9GE9yO8R1/mBZq8ZoozrNO1ILcmYo8w8lCu14kB
         NitZZkox3FaFHIMHnrQtn9geDRX9kam8l/bH6OSwO8+bJvo4pmqazVRtx/m6WEN4LUBf
         HaXyONTP3lf4+HmXRb3lXo+MTgPZcic/eHwqsMIkskgH2aEakYZXBq2v8h60uIjpVp1B
         3EMilAww2b/+1ULmOQPNboWhiyW3XB1mr1kqiGUO0Zau+B2jxo4qMoz4BI5HBfTi0XST
         Qv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mDgvv19Pjii0hkVqGjAHj9m2dmOLS10IHxekCbp94Q=;
        b=ELDqmuE7v143vhNTXwB/7BPQao4fp5/ulKrTotGBb3xXTH+7HPA/y7p9sva9jj8u5d
         2rSMm+T9jJtolzhCTx0DEqrggkl4VeeRBlWwEDVthZSBWVc/Ec7hwjFHynq1U/5JmbFQ
         gR1lTz8mrIOOw+Cqqt2KwQtQ5aYNiW9NMFxWECuIJX+EeWV1W/izyUbX4cD9aOg9Ryp4
         21DXUc2qYOEUhGFxEnTQ+WA+wQCTrcA/lfr+CZQU1mNxwFD8wsjFBizGP0YGoMOSNAD9
         spgVSnTLDg1R/LAjR+aZ2/D+6nosN2yAMI+IRCWKeUSW2Af1QQnHmNa7QsuUvnaztzpk
         TkDw==
X-Gm-Message-State: APjAAAVo3BvwFircWiBTstFV4jOF7sm6/0uX/MDbSE43DKMJ6CPAXeOC
        t8pjfZHl2RCsWoS7s4Cmog4=
X-Google-Smtp-Source: APXvYqzttov8jvo2c2CswCMzqIIKFdLMSmT6hB3XHbEfsL83rt8FjAWGrfEJ1WsiuBmndzdGa+nrQQ==
X-Received: by 2002:adf:efc8:: with SMTP id i8mr107911287wrp.220.1565028098337;
        Mon, 05 Aug 2019 11:01:38 -0700 (PDT)
Received: from szeder.dev (x4db4a28a.dyn.telefonica.de. [77.180.162.138])
        by smtp.gmail.com with ESMTPSA id n5sm63445003wmi.21.2019.08.05.11.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 11:01:37 -0700 (PDT)
Date:   Mon, 5 Aug 2019 20:01:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com
Subject: Re: [RFC PATCH v2 2/2] trace2: don't overload target directories
Message-ID: <20190805180135.GD20404@szeder.dev>
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1564771000.git.steadmon@google.com>
 <a779e272df958702c0df06ab58f1f6d6f8086a30.1564771000.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a779e272df958702c0df06ab58f1f6d6f8086a30.1564771000.git.steadmon@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 02, 2019 at 03:02:35PM -0700, Josh Steadmon wrote:
> +test_expect_success "don't overload target directory" '
> +	mkdir trace_target_dir &&
> +	test_when_finished "rm -r trace_target_dir" &&
> +	(
> +		GIT_TRACE2_MAX_FILES=5 &&
> +		export GIT_TRACE2_MAX_FILES &&
> +		cd trace_target_dir &&
> +		test_seq $GIT_TRACE2_MAX_FILES >../expected_filenames.txt &&
> +		xargs touch <../expected_filenames.txt &&
> +		cd .. &&
> +		ls trace_target_dir >first_ls_output.txt &&
> +		test_cmp expected_filenames.txt first_ls_output.txt &&

Nit: what's the purpose of this 'ls' and 'test_cmp'?

It looks like they check that xargs created all the files it was told
to create.  I think that this falls into the category "We are not in
the business of verifying that the world given to us sanely works."
and is unnecessary.

> +		GIT_TRACE2="$(pwd)/trace_target_dir" test-tool trace2 001return 0
> +	) &&
> +	echo git-trace2-overload >>expected_filenames.txt &&
> +	ls trace_target_dir >second_ls_output.txt &&
> +	test_cmp expected_filenames.txt second_ls_output.txt
> +'
> +
>  test_done
