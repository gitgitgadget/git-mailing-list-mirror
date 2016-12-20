Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E761A1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 18:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764569AbcLTSMl (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 13:12:41 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:51366 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764561AbcLTSMk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 13:12:40 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tjm8x30CYz5tlB;
        Tue, 20 Dec 2016 19:12:33 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BEBBE2222;
        Tue, 20 Dec 2016 19:12:32 +0100 (CET)
Subject: Re: Allow "git shortlog" to group by committer information
To:     Jeff King <peff@peff.net>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
 <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
 <20161216133940.hu474phggdslh6ka@sigill.intra.peff.net>
 <20161216135141.yhas67pzfm7bxxum@sigill.intra.peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <16b115e0-3a7e-a5c2-1526-44bbcfc97db8@kdbg.org>
Date:   Tue, 20 Dec 2016 19:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161216135141.yhas67pzfm7bxxum@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.12.2016 um 14:51 schrieb Jeff King:
> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> index ae08b57712..6c7c637481 100755
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -190,4 +190,17 @@ test_expect_success 'shortlog with --output=<file>' '
>  	test_line_count = 3 shortlog
>  '
>
> +test_expect_success 'shortlog --committer (internal)' '
> +	cat >expect <<-\EOF &&
> +	     3	C O Mitter
> +	EOF
> +	git shortlog -nsc HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'shortlog --committer (external)' '
> +	git log --format=full | git shortlog -nsc >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
>

May I kindly ask you to make this work on Windows, too? Just

sed -i -e s/MINGW/MINGW,HAVENOT/ t4201-shortlog.sh

on your Linux box and make it pass the tests.

Thank you so much in advance.

-- Hannes

