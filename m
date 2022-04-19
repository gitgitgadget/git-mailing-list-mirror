Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF7CC433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 04:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347495AbiDSERX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 00:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiDSERX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 00:17:23 -0400
X-Greylist: delayed 1212 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Apr 2022 21:14:41 PDT
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.59.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03552611A
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 21:14:41 -0700 (PDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 00A56401070A6
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 22:54:29 -0500 (CDT)
Received: from gator3142.hostgator.com ([50.87.144.177])
        by cmsmtp with SMTP
        id geuhnFF4pHnotgeuineyfW; Mon, 18 Apr 2022 22:52:28 -0500
X-Authority-Reason: nr=8
Received: from 92-249-234-155.pool.digikabel.hu ([92.249.234.155]:29412 helo=[192.168.0.107])
        by gator3142.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <csosza@designsoftware.com>)
        id 1ngeuh-002mHx-Dd; Mon, 18 Apr 2022 22:52:27 -0500
Message-ID: <fa40a6e6-dd83-9e88-e2f7-ab8aff2ca5a4@designsoftware.com>
Date:   Tue, 19 Apr 2022 05:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Git bug report - disk errors on Windows after push
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <4026b85f-8cae-bcca-af14-e886e80725d4@designsoftware.com>
 <Yl2h5I0apzWhpVtr@camp.crustytoothpaste.net>
From:   Attila Csosz <csosza@designsoftware.com>
In-Reply-To: <Yl2h5I0apzWhpVtr@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3142.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - designsoftware.com
X-BWhitelist: no
X-Source-IP: 92.249.234.155
X-Source-L: No
X-Exim-ID: 1ngeuh-002mHx-Dd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 92-249-234-155.pool.digikabel.hu ([192.168.0.107]) [92.249.234.155]:29412
X-Source-Auth: csosza@designsoftware.com
X-Email-Count: 6
X-Source-Cap: ZHNnNHQwcjtkc2c0dDByO2dhdG9yMzE0Mi5ob3N0Z2F0b3IuY29t
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've experienced the problem at least 3 different external disk.
I'm not using cloud syncing service (e.g., Dropbox or OneDrive) for git.

Attila

On 4/18/2022 19:37, brian m. carlson wrote:
> Hey,
>
> On 2022-04-18 at 07:47:07, Attila Csosz wrote:
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your issue.
>>
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> Pushing to a directory directly.
>>
>> What did you expect to happen? (Expected behavior)
>> Good behavior
>>
>> What happened instead? (Actual behavior)
>> Disk errors. After pushing to a directory (my origin field is C:\Work for
>> example) the git repository will be corrupted.
>> Moreover causing disk errors not only in the target git bare repository.
>> I've loosed some other files.
>> Cannot be reproduced exactly. However I have decided to report this problem.
>> I've experienced this problem for several years.
> There's nothing that Git should be able to do as a normal operating
> system that causes disk errors.  If you're seeing those kinds of errors,
> the likelihood is that your disk is bad and you need to replace it.
>
> Do note that if you're storing your data in a directory managed by a
> cloud syncing service (e.g., Dropbox or OneDrive), then it is known that
> those file systems corrupt Git repositories and you shouldn't use them
> with Git.  That's due to the way they sync data.
>
> However, if this is a regular file system (e.g., NTFS), then Git
> shouldn't be able to cause disk problems, and if it could, that would be
> a serious defect in Windows, so it's almost certainly going to be a
> hardware problem.
