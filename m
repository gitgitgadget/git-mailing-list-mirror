Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67DFC54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 21:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A092076C
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 21:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgDVVCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:02:54 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:31815 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgDVVCx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 17:02:53 -0400
X-Greylist: delayed 1323 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2020 17:02:53 EDT
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 03MKen6J001179
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 13:40:49 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
To:     git@vger.kernel.org
From:   Yuri <yuri@rawbw.com>
Subject: [BUG REPORT] --date argument doesn't validate dates
Message-ID: <d633919a-99a4-0b90-f355-66a17000f83f@rawbw.com>
Date:   Wed, 22 Apr 2020 13:40:48 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For example, the following command accepts an invalid month "Dx" and an 
invalid year "20221" and sets the month to "Apr" and the year to "2020".


Yuri



$ git commit --amend --no-edit --date "Mon 20 Dx 20221 20:19:19 PST"
[master 668e255] Initial
  Date: Mon Apr 20 20:19:19 2020 -0700
  1 file changed, 1 insertion(+)
  create mode 100644 File
[yuri@yv /usr/home/yuri/github/git-date]$ git log
commit 668e255b54d08ed898e6d44f19954b2116d5a56c (HEAD -> master)
Author: Yuri <yuri@rawbw.com>
Date:   Mon Apr 20 20:19:19 2020 -0700

     Initial

