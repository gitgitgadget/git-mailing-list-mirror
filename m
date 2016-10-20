Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EBB520987
	for <e@80x24.org>; Thu, 20 Oct 2016 06:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753318AbcJTGwI (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 02:52:08 -0400
Received: from mout.web.de ([212.227.17.11]:50229 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbcJTGwH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 02:52:07 -0400
Received: from [192.168.209.54] ([195.252.60.88]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MX0Q4-1cSvqL2yhg-00VxOz; Thu, 20 Oct 2016 08:51:49
 +0200
Subject: Re: [PATCH] rev-list: restore the NUL commit separator in --header
 mode
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
References: <1476908699.26043.9.camel@kaarsemaker.net>
 <20161019210448.aupphybw5qar6mqe@hurricane>
Cc:     jacob.e.keller@intel.com, stefanbeller@gmail.com, peff@peff.net,
        j6t@kdbg.org, jacob.keller@gmail.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <39b98123-f2c6-a09a-8ab4-5c246ffe4623@web.de>
Date:   Thu, 20 Oct 2016 08:51:39 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161019210448.aupphybw5qar6mqe@hurricane>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:p/8BovXUGbaDzMMHxW3JzvT0+eInSaRU36bVWL9jB/AxFLsvJcQ
 /oLcquHtKtOLFpkWN0k7jvHqW4hXlueNbcBUL2KFFUzOjuXSMEhhKsjzNFnRYjsPkQAFgK4
 wRT0tCf0PqMIhsv8VUogP0HsyGNYRVCNxmVzIfTSvTnoUQwZ3bvZnBjsUzT2dZRHFiye9qo
 CTR6EJ10XBzaPKOs6+PFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P0zyBVJebfo=:3NbDGPiepmZn5rnjz2fnLO
 5gQMIo9ECt+20E9ceQQs+0lZlXNi7ASpATnM84Hlu0gaTZ2mEDeKCYvkY6b+KGl1/MaGkRN4k
 slFPlJ3Ruiv+P8neVeMZ6JVwLDC4hOnROP/eSCXtRX6tZDiBEcKnpYmwX9rdFRYh3lwykX4GR
 adEGjoiKTqFy77EQQDZSs489iw+sK135KtSnU0XB3iopiFrm8zy5oloK7t+uSffomZ5YZtRGC
 vJL2X5fzZsOixPNi2duNcCWEc6S0feOKYXUDi5P7GkQL8NWe2Ibf4RmNKwjiQlVz0xydrGsV1
 2dCsj/j1k92BRIIxHXp6vVwKqd1rlKcSSSMH7AcMXzKqIKw1hV9UTjQDpdR1WvYI8KqpgKL3R
 ty8hqVtH77XpXbznDA1zH+9zE31BcIio+qcuPbKv9obFilogkB3RJELAzWSgSPU0lDqmrcKrj
 ms3v0maiPemG2q4THJ/MOB9iSAGXFNO2izNGqsR2aGbAAe11rk7WUDpfv/HJkfmOFQCvk2v+K
 hzVnNeDchTguYi5FUSXE0iDRDR+6R06//bMabg3ZP9kv35HvF4vI+5DVT2sK8a5SnYpg9k9Pl
 jjuSLj6oeBeOYFKQBhGCP6cfSeKd9xL3kM2afRvuOtSiVPGfXoG25inbH3Ri8oFq9nEHQYoEj
 Bx9okxQP8tS6tr7PJBmBx2glS8J8OuDy8K+T02YN3TscqOqtot6s/O0bFKrLriG9N+lWT3cQR
 COmQWofJ6uBkWpWI83tHq/4xYDuvHgRNuyqK5ZhtBK1Kaeyv/856bF/m8FqDbgpnyyEJwSvRE
 xFdo6PD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
> index 3e752ce..a2acff3 100755
> --- a/t/t6000-rev-list-misc.sh
> +++ b/t/t6000-rev-list-misc.sh
> @@ -100,4 +100,11 @@ test_expect_success '--bisect and --first-parent can not be combined' '
>   	test_must_fail git rev-list --bisect --first-parent HEAD
>   '
>   
> +test_expect_success '--header shows a NUL after each commit' '
> +	touch expect &&
> +	printf "\0" > expect &&
Micronit: No ' ' after '>'
(And why do we need the touch ?)

+	printf "\0" >expect &&


> +	git rev-list --header --max-count=1 HEAD | tail -n1 >actual &&
> +	test_cmp_bin expect actual
> +'
> +
>   test_done

