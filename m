Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D011F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 12:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633912AbfJRMqz (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 08:46:55 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:53514 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2633907AbfJRMqz (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Oct 2019 08:46:55 -0400
X-Greylist: delayed 2662 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Oct 2019 08:46:54 EDT
Received: from [80.153.18.91] (helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1iLQxj-0004yD-Mw; Fri, 18 Oct 2019 14:02:31 +0200
Subject: Re: bug: Directory replaced by submodule -> checkout fails
To:     Christopher Collins <chris@runtime.io>, git@vger.kernel.org
References: <20191017230751.GC4049@pseudoephedrine.nightmare-heaven.no-ip.biz>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <f66f0587-4d61-71e8-fc87-3278f1023e3d@virtuell-zuhause.de>
Date:   Fri, 18 Oct 2019 14:02:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017230751.GC4049@pseudoephedrine.nightmare-heaven.no-ip.biz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1571402814;8feb6b17;
X-HE-SMSGID: 1iLQxj-0004yD-Mw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.10.2019 um 01:07 schrieb Christopher Collins:

Hi Christopher,

> ### Reproduce:>
> 
> git clone git@github.com:JuulLabs-OSS/mcuboot.git
> cd mcuboot
> git submodule init
> git submodule update
> git checkout ae01f153b11637feaedbc9d9042172fba2e080c0
> 
> ### Discussion:
> 
> In the above sequence, the last step (checkout) fails with this error:
> 
>     error: The following untracked working tree files would be overwritten by checkout:
>             ext/mbedtls/include/mbedtls/asn1.h
>             ext/mbedtls/include/mbedtls/bignum.h
>             ext/mbedtls/include/mbedtls/check_config.h
>             ext/mbedtls/include/mbedtls/config.h
>             ext/mbedtls/include/mbedtls/ecdsa.h
>             ext/mbedtls/include/mbedtls/ecp.h
>             ext/mbedtls/include/mbedtls/md.h
>             ext/mbedtls/include/mbedtls/oid.h
>             ext/mbedtls/include/mbedtls/pk.h
>             ext/mbedtls/include/mbedtls/platform.h
>             ext/mbedtls/include/mbedtls/platform_util.h
>             ext/mbedtls/include/mbedtls/threading.h
>     Please move or remove them before you switch branches.
>     Aborting
> 

This is a known bug unfortunately. See
https://public-inbox.org/git/CAGZ79kYTY6U0eNwvU0PcDyt_QXGyYGm5VkDvWLtuQgQG6BbtFA@mail.gmail.com/
for reference.

