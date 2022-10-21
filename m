Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0C4C38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 19:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJUTzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 15:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJUTzl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 15:55:41 -0400
X-Greylist: delayed 881 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Oct 2022 12:55:35 PDT
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E256313B514
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 12:55:34 -0700 (PDT)
Received: from [192.168.5.3] (c-73-93-225-239.hsd1.ca.comcast.net [73.93.225.239])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 29LJeqcQ096914
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 12:40:52 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-93-225-239.hsd1.ca.comcast.net [73.93.225.239] claimed to be [192.168.5.3]
Message-ID: <3a4dfad5-0f2e-14d8-61f2-779616de1ae0@tsoft.com>
Date:   Fri, 21 Oct 2022 12:40:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@rawbw.com>
Subject: 'git commit .' in a subdirectory also commits staged files in other
 subdirectories
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had several staged files in various subdirectories of the cloned 
repository tree.

'git commit .' in one of them attempted to commit all of them, not only 
the files in that subdirectory.

This is a very unreasonable behavior, because while being in any 
subdirectory 'git commit .' should only affect that subdirectory, and 
not files elsewhere.


git-2.38.0

FreeBSD 13.1


Yuri

