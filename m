Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B9FF202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 18:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbdCISL4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 13:11:56 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:37771 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932290AbdCISL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 13:11:56 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3vfJPh5TQqz5tlR;
        Thu,  9 Mar 2017 19:11:52 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0188F3A6;
        Thu,  9 Mar 2017 19:11:51 +0100 (CET)
Subject: Re: [PATCH 03/10] pack-objects: test for --partial-by-size
 --partial-special
To:     Jeff Hostetler <jeffhost@microsoft.com>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
 <1488994685-37403-4-git-send-email-jeffhost@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com, Jeff Hostetler <git@jeffhostetler.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <afd40132-ef85-1713-e3ab-f6bef6b30646@kdbg.org>
Date:   Thu, 9 Mar 2017 19:11:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1488994685-37403-4-git-send-email-jeffhost@microsoft.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.03.2017 um 18:37 schrieb Jeff Hostetler:
> +test_expect_success 'setup' '
> +	perl -e "print \"a\" x 11;"      > a &&
> +	perl -e "print \"a\" x 1100;"    > b &&
> +	perl -e "print \"a\" x 1100000;" > c &&

If the file contents do not matter, you can have the same without perl 
like this:

	printf "%011d" 0      >a &&
	printf "%01100d" 0    >b &&
	printf "%01100000d" 0 >c &&

-- Hannes

