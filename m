Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6AFC54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 13:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjAMNqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 08:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbjAMNqK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 08:46:10 -0500
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8877C85CBA
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 05:39:39 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id AA31E26001F
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 14:39:37 +0100 (CET)
Message-ID: <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
Date:   Fri, 13 Jan 2023 14:39:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Content-Language: en-US
To:     git@vger.kernel.org
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <20230113133059.snyjblh3sz2wzcnd@carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/13/23 14:30, Konstantin Khomoutov wrote:
> On Fri, Jan 13, 2023 at 01:59:44PM +0100, Hans Petter Selasky wrote:
> 
>> Currently GIT only supports cryptographic hashes for its commit tags.
> [...]
> 
> https://github.com/git/git/blob/9bf691b78cf906751e65d65ba0c6ffdcd9a5a12c/Documentation/technical/hash-function-transition.txt
> 
> It's not clear why are you referring to Gitorious in your mail's subject and
> then talk about Git.
> 

Hi,

I thought that Git was short for Gitorious? My bad.

The document you refer to really highlights my concerns, that a strong 
cryptographic hash algorithm is the highway to hell.

Do _not_ use a cryptographic hash for Git. Use plain good old CRC hashes.

Just imagine the consequences of finding child porn inside a 10-year old 
firmware binary blob in the Linux kernel. Will you just ignore it, or 
will you fix it?

That's why I say, that it must be possible to forge the hashes by default.

--HPS
