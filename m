Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781EAC432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 03:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F17860E8B
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 03:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhH1DrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 23:47:03 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:64477 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233170AbhH1DrC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 23:47:02 -0400
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 17S3kASM017292
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 20:46:12 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@rawbw.com>
Subject: Git re-creates newly added directory when it is pushed
Message-ID: <c0557284-8f82-76cc-8c47-0b1bc9f2ce5a@rawbw.com>
Date:   Fri, 27 Aug 2021 20:46:08 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I create a new directory, add it to git and push it.

After push it says: Unable to read current working directory: No such 
file or directory


[yuri@yv /usr/ports/math/stanmath]$ git pull -r && git push origin 
--push-option=confirm-author
remote: Enumerating objects: 283, done.
remote: Counting objects: 100% (283/283), done.
remote: Compressing objects: 100% (187/187), done.
remote: Total 188 (delta 94), reused 3 (delta 0), pack-reused 0
Receiving objects: 100% (188/188), 29.37 KiB | 578.00 KiB/s, done.
Resolving deltas: 100% (94/94), completed with 50 local objects.
 From ssh://gitrepo.freebsd.org/ports
    80469139f77f..cf8b94761057  main       -> origin/main
Successfully rebased and updated refs/heads/main.
fatal: Unable to read current working directory: No such file or directory


Why does Git have to delete and then create again the directory when it 
is already there?


This isn't a big issue, but it is very odd that git deletes the working 
directory.


FreeBSD 13.



Yuri

