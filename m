Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598B6C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjAMQgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjAMQf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:35:59 -0500
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED69082F7B
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:30:21 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 256872628C6;
        Fri, 13 Jan 2023 17:30:20 +0100 (CET)
Message-ID: <95797daa-4d5d-73d3-fec5-6b25707182fd@selasky.org>
Date:   Fri, 13 Jan 2023 17:30:20 +0100
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
 <20230113162721.qwl2asjo542cxe3c@meerkat.local>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <20230113162721.qwl2asjo542cxe3c@meerkat.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/13/23 17:27, Konstantin Ryabitsev wrote:
> The answer is, unhelpfully, "because that's how git works." Every commit is a
> standalone object that references the previous commit, plus includes hashes of
> all trees, and those include hashes of all blobs. SHA-1 was picked because of
> its speed and the fact that it guarantees an extremely low potential for
> collisions (even better with SHA256). As a side-effect, it's easy to calculate
> the integrity of the entire tree, including its history, by verifying its
> hashes (this is what git fsck does).

Same thing can be said for CRC-XXX. Just some magic CPU instructions and 
we're good. You don't even need a library.

--HPS
