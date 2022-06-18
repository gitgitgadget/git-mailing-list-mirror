Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C726EC43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 06:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiFRGuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 02:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiFRGuW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 02:50:22 -0400
X-Greylist: delayed 1688 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Jun 2022 23:50:21 PDT
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBB7446B05
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 23:50:21 -0700 (PDT)
Received: from [192.168.5.3] (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 25I6MCbm079452
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 23:22:12 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be [192.168.5.3]
Message-ID: <a41e809c-4d91-cfc4-a512-77173f920d38@tsoft.com>
Date:   Fri, 17 Jun 2022 23:22:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@rawbw.com>
Subject: 'git stash push -m "label" -- dir' saves into stash changes outside
 dir
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am working in the FreeBSD ports repository.

The Mk directory has some changes and additions.

Other directories outside of Mk also have some additions.


The command I ran is:

 > git stash push -m "x" -- Mk/


It is supposed to create a stash entry with only changes under Mk.

However, 'git stash show -p stash@{0}' shows changes outside of Mk as well.

Changes under Mk went into stash and disappeared from the directory. 
Changes outside of Mk (wrongfully) also went into stash and remained in 
the directory.


IMO, this is a bug in git-2.35.1


FreeBSD 13.1


Yuri


