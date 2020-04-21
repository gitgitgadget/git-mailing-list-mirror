Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8E1C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF95220736
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgDUU7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:59:53 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:11963 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgDUU7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 16:59:53 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 496GCq52z8z5tlC;
        Tue, 21 Apr 2020 22:59:51 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A53FB2817;
        Tue, 21 Apr 2020 22:59:50 +0200 (CEST)
Subject: Re: [PATCH 3/8] t7508: don't use `test_must_fail test_cmp`
To:     Denton Liu <liu.denton@gmail.com>
References: <cover.1587372771.git.liu.denton@gmail.com>
 <fd79ade3527e6be6b97f07d798a0ea38507f24c0.1587372771.git.liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <90faeb7a-1c6a-3fc6-6410-5e264c9340e8@kdbg.org>
Date:   Tue, 21 Apr 2020 22:59:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fd79ade3527e6be6b97f07d798a0ea38507f24c0.1587372771.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.04.20 um 10:54 schrieb Denton Liu:
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1471,7 +1471,7 @@ test_expect_success '"status.branch=true" same as "-b"' '
>  test_expect_success '"status.branch=true" different from "--no-branch"' '
>  	git status -s --no-branch  >expected_nobranch &&
>  	git -c status.branch=true status -s >actual &&
> -	test_must_fail test_cmp expected_nobranch actual
> +	! test_cmp expected_nobranch actual
>  '

Not your fault, but this is, of course, a very weak test case. Check
that some output that the program generates is _not_ equal to something
else? That condition should be very easy to satisfy.

-- Hannes
