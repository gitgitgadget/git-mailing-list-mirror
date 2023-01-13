Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5E0C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjAMQqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjAMQpx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:45:53 -0500
Received: from mail.turbocat.net (turbocat.net [88.99.82.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521AF84634
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:44:05 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 6589A26001F;
        Fri, 13 Jan 2023 17:44:03 +0100 (CET)
Message-ID: <7a51b925-cb0a-4b48-fc14-171006f73298@selasky.org>
Date:   Fri, 13 Jan 2023 17:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Content-Language: en-US
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
 <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
 <20230113154516.jxm2cer4sogatayp@meerkat.local>
 <d087568b-919e-61f8-c203-e59a2e0572c6@selasky.org>
 <20230113160218.d3nsoxpbrxrrszhz@meerkat.local>
 <a2e6fdc3-fbb0-821c-078f-1ad4e55dc8e3@selasky.org>
 <5971b434-6409-8fd6-130f-f5b871a10f6d@selasky.org>
 <20230113163619.4ab5oyqyjrthxrwv@meerkat.local>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <20230113163619.4ab5oyqyjrthxrwv@meerkat.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/13/23 17:36, Konstantin Ryabitsev wrote:
> I'm not sure what you mean here, but git is certainly not zero-trust. When you
> clone linux.git from git.kernel.org, you're very much trusting that:
> 
> - I (or members of my team) didn't mess with the repository
> - Linus (or someone who hacked his laptop) didn't mess with the repository
> 
> Git is tamper-evident, not tamper-proof, so by definition it cannot be
> zero-trust.

Hi,

By using a cryptographic hash algorithm, the goal is to avoid tampering 
you say, like tampering on the internet, ISP, cache node and so on. To 
me that's clearly a zero-trust thought. You don't trust the guy(s) that 
put down the infrastructure, neither those that provide that local cache 
for the GIT repository, only the master repository. SHA-1 gives a 
certain confidence, that if you checkout XXXXXXX, then you get a likely 
expected result with reduced possibility of tampering.

Anyone could intercept a CRC protected blob and re-compute the hash and 
send it on. But not a SHA-1 one.

I on the other hand trust the guys that put down the internet and are 
providing the cache nodes for GIT.

It's two different world views.

--HPS
