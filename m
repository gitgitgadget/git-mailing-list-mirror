Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70759C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 18:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiLBSFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 13:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiLBSFh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 13:05:37 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656BDE61F1
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 10:05:36 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 39683CA1234;
        Fri,  2 Dec 2022 13:05:35 -0500 (EST)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F3258CC831A;
        Fri,  2 Dec 2022 13:05:34 -0500 (EST)
Message-ID: <34ed06a2-9c67-62d5-7985-4b7379a0cf6c@jeffhostetler.com>
Date:   Fri, 2 Dec 2022 13:05:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] maintenance: compare output of pthread functions for
 inequality with 0
Content-Language: en-US
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija <doremylover123@gmail.com>
References: <pull.1389.git.git.1670000578395.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <pull.1389.git.git.1670000578395.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/2/22 12:02 PM, Rose via GitGitGadget wrote:
> From: Seija <doremylover123@gmail.com>
> 
> The documentation for pthread_create and pthread_sigmask state that:
> 
> "On success, pthread_create() returns 0;
> on error, it returns an error number"
> 
> As such, we ought to check for an error
> by seeing if the output is not 0.
> 
> Checking for "less than" is a mistake
> as the error code numbers can be greater than 0.
> 
> Signed-off-by: Seija <doremylover123@gmail.com>
> ---
>      maintenance: compare output of pthread functions for inequality with 0
>      
>      The documentation for pthread_create and pthread_sigmask state that "On
>      success, pthread_create() returns 0; on error, it returns an error
>      number, and the contents of *thread are undefined."
>      
>      As such, we ought to check for an error by seeing if the output is not
>      0, rather than being less than 0, since nothing stops these functions
>      from returning a positive number.
>      
>      Signed-off by: Seija doremylover123@gmail.com

Good catch!

LGTM

Thanks,
Jeff

