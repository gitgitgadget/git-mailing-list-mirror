Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06ADA2018D
	for <e@80x24.org>; Thu, 11 May 2017 18:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757234AbdEKSgt (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 14:36:49 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:32962 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757155AbdEKSgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 14:36:48 -0400
Received: by mail-pg0-f45.google.com with SMTP id u187so18623278pgb.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 11:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LIs+xMF06lLCJH4HsILQHfqjfCh+LN8RbydSF39FOOM=;
        b=XFUDcmhGOGT09jdGuPAZZDPmXeEf6tveBvfY36AyZTvML892JdT5lMJBtKwWgopXbw
         qfJyNMNe8Sf1VAtyccttKx3tzx5hUEiG1xlLbSqJOmsSIpl2uKzc7IatGl1gJeCRPSOp
         +iRsCkAq2pz9pqAWxK5mbQrl2F27g0bxwGGZnGLw43UhH/yPeSQSJo1Uid14753F6iiE
         /j484nxgxTQCx6CQhW/5JTbGa8M17LzMXXTxzW2NQ0rEa4vpOq9ribt7brHbt6XwoJ3y
         2QOPJNYJS/GO0GMQGnG51MOnEMyM70Aq5x/W+uOvcpM3cHJEujEbepeUptg9qSYL/J6v
         bkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LIs+xMF06lLCJH4HsILQHfqjfCh+LN8RbydSF39FOOM=;
        b=BANU6GDQqUsxL1d2Ybl2KXl6+4GnZL9POSskzH+l+eOsyMBKUu5L/7RDgTVMsqZX47
         Ql/3cpPWljGNskXq621IaaKYd31B4crqvzKjM8VIG/WePtuZtVO4i/o+JqgMPXUAGJuT
         0xo0PyIepnFfLUU+8y6M0aI3vci825aCKMllCSOAMWROv0O+pqKlF5EliVvckHWHGS+U
         BmQU+szHLLyFqf5iOgm28YYCse5qNQ9rNHDFqU7LqBP3bcAAIGGKUg82zIKgG7/C0sSP
         0Eyy7671vay93K92/A6UQ3r/aS6JXlIRyRhcVSH9I88KiST2nvdcBUUWjTshxqUZe6B1
         S94g==
X-Gm-Message-State: AODbwcABM28tN4ysSsUA356Y+LYSUHivmwLXlmlUWf9t06QW+fxz/DeB
        x954sWoK0epR7D2k
X-Received: by 10.84.129.131 with SMTP id b3mr254095plb.1.1494527802930;
        Thu, 11 May 2017 11:36:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id p84sm1485511pfi.25.2017.05.11.11.36.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 11:36:41 -0700 (PDT)
Date:   Thu, 11 May 2017 11:36:40 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 08/29] grep: add tests for --threads=N and grep.threads
Message-ID: <20170511183640.GD83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com>
 <20170511091829.5634-9-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170511091829.5634-9-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Ævar Arnfjörð Bjarmason wrote:
> Add tests for --threads=N being supplied on the command-line, or when
> grep.threads=N being supplied in the configuration.
> 
> When the threading support was made run-time configurable in commit
> 89f09dd34e ("grep: add --threads=<num> option and grep.threads
> configuration", 2015-12-15) no tests were added for it.
> 
> In developing a change to the grep code I was able to make
> '--threads=1 <pat>` segfault, while the test suite still passed. This
> change fixes that blind spot in the tests.
> 
> In addition to asserting that asking for N threads shouldn't segfault,
> test that the grep output given any N is the same.
> 
> The choice to test only 1..10 as opposed to 1..8 or 1..16 or whatever
> is arbitrary. Testing 1..1024 works locally for me (but gets
> noticeably slower as more threads are spawned). Given the structure of
> the code there's no reason to test an arbitrary number of threads,
> only 0, 1 and >=2 are special modes of operation.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t7810-grep.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index daa906b9b0..561709ef6a 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -775,6 +775,22 @@ test_expect_success 'grep -W with userdiff' '
>  	test_cmp expected actual
>  '
>  
> +for threads in $(test_seq 0 10)
> +do
> +	test_expect_success "grep --threads=$threads & -c grep.threads=$threads" "
> +		git grep --threads=$threads . >actual.$threads &&
> +		if test $threads -ge 1
> +		then
> +			test_cmp actual.\$(($threads - 1)) actual.$threads
> +		fi &&
> +		git -c grep.threads=$threads grep . >actual.$threads &&
> +		if test $threads -ge 1
> +		then
> +			test_cmp actual.\$(($threads - 1)) actual.$threads
> +		fi
> +	"
> +done
> +

Is there a test condition to require PTHREADS?  Otherwise this might
break if git is compiled with NO_PTHREADS.

-- 
Brandon Williams
