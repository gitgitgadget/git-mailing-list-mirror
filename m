Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F77C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjAMQKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjAMQJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:09:27 -0500
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FF661302
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:02:25 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 3A9C426240E;
        Fri, 13 Jan 2023 17:02:24 +0100 (CET)
Message-ID: <078526fc-7f2d-c745-a292-ff78dc06e407@selasky.org>
Date:   Fri, 13 Jan 2023 17:02:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Content-Language: en-US
To:     rsbecker@nexbridge.com,
        'Konstantin Ryabitsev' <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
 <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
 <20230113154516.jxm2cer4sogatayp@meerkat.local>
 <6061d012-13b7-ca4b-5556-70875b65c887@selasky.org>
 <00b201d92767$a0403ee0$e0c0bca0$@nexbridge.com>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <00b201d92767$a0403ee0$e0c0bca0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/13/23 16:56, rsbecker@nexbridge.com wrote:
> git is using SHA1/SHA256 (which happen to be coincidentally cryptographic) as message digests with a very low probability of collisions when the hashes are computed. There is never a situation, implied by cryptography, where there is a decode of a git hash.  In order to make git a blockchain, you would need to implement central signing authorities, which would require a fork if the signature mechanism changes. The signature mechanism (SSH, GPG) is distinct from hash computation in git's trees, but depends on hash integrity.

I see.

But at the same time any unique enough hash, identifies a specific piece 
of code or checkout, even though it is not under a specific signing 
authority. And that is the problem, that authorities may distribute 
allowed-only-hashes for their hardware ...

--HPS
