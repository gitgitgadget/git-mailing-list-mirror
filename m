Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40271C00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 05:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiHXFXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 01:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiHXFXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 01:23:16 -0400
X-Greylist: delayed 555 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Aug 2022 22:23:14 PDT
Received: from blade-b3-vm-relay.servers.aueb.gr (blade-b3-vm-relay.servers.aueb.gr [195.251.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3534B8003A
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 22:23:14 -0700 (PDT)
Received: from blade-a1-vm-smtp.servers.aueb.gr (blade-a1-vm-smtp.servers.aueb.gr [195.251.255.217])
        by blade-b3-vm-relay.servers.aueb.gr (Postfix) with ESMTP id 2E20C245A;
        Wed, 24 Aug 2022 08:13:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aueb.gr; s=201901;
        t=1661318037; bh=VH4l9t5JirnGYabwJQn7W8zVDFmZ4NuY2KBl2DWz/Ao=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eLk8i/TZZICFr6Xz40FtjVZfdF1Kq4cjcdK8i47DqOO1OZUV3tIHPR4ETln+vPn0C
         E57HWfJ6UPZnXLxgDqJSmwywBcxN7IE0NfX+63LBSloMCqi3oaEpO9JMhtCbWcA87M
         CU9zO4CI9MvdtckXHyDyNKiaHvWbcVxcW9ETyjOXoRj65UbvfvkaBx7mLSnzjvqSdp
         d3bhzXdIVduKJq6FZ42jvKl68TDEktfgNW88hULgu7ZnUY2JPJKSl9x9zyvZ5SYzOn
         3xNp3T3UVrDmXpSMX4SLTBOxCX3W4XgCUKHzMbLu1aHGbhuoh7X9Xtjrky2wjfB1Eq
         xdI/GkxoriO+g==
Received: from [192.168.1.3] (dspi67.static.otenet.gr [83.235.16.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dds)
        by blade-a1-vm-smtp.servers.aueb.gr (Postfix) with ESMTPSA id 9E3E36A4;
        Wed, 24 Aug 2022 08:13:56 +0300 (EEST)
Message-ID: <05275758-2b69-a4bd-30ca-4d48cbfe39f5@aueb.gr>
Date:   Wed, 24 Aug 2022 08:13:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] grep: fix multibyte regex handling under macOS
Content-Language: el
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Diomidis Spinellis via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1313.git.git.1661281689747.gitgitgadget@gmail.com>
 <CAPig+cSf+Gi4cHQLcTenxH=RzBxxqCApKhFTkCUMAS=0fYXZDA@mail.gmail.com>
From:   Diomidis Spinellis <dds@aueb.gr>
Organization: Athens University of Economics and Business
Phone:  +30 210 8203621
In-Reply-To: <CAPig+cSf+Gi4cHQLcTenxH=RzBxxqCApKhFTkCUMAS=0fYXZDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23-Aug-22 23:40, Eric Sunshine wrote:
> On Tue, Aug 23, 2022 at 4:04 PM Diomidis Spinellis via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> diff --git a/t/t7818-grep-multibyte.sh b/t/t7818-grep-multibyte.sh
>> +# Multibyte regex search is only supported with a native regex library
>> +# that supports them.
>> +# (The included library is compiled with NO_MBSUPPORT) and only if it
>> +test -z "$NO_REGEX" &&
> 
> The comment above seems incomplete (i.e. "and only if it...").

Thank you for pointing this out. I posted an update that fixes this.

Diomidis
