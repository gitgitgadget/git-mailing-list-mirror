Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043F8C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 09:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DADC860F00
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 09:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbhHNJVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 05:21:05 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:20727 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237816AbhHNJVE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 05:21:04 -0400
X-Greylist: delayed 667 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Aug 2021 05:21:04 EDT
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 17E99TZG052413
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 02:09:29 -0700 (PDT)
        (envelope-from yuri@FreeBSD.org)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@FreeBSD.org>
Subject: 'git log' doesn't keep log of un-removed and then renamed directory
Message-ID: <75911f47-1433-f0a4-7d46-f1fb2fd44cf4@rawbw.com>
Date:   Sat, 14 Aug 2021 02:09:27 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the FreeBSD ports tree I restored the previously removed directory 
math/dynare:

1. git checkout 3fb72e318f7be~1 -- math/dynare

2. git mv math/dynare science/dynare

3. rm -rf science/dynare && cp -r science/dynare.new science/dynare

4. git add science/dynare

5. git commit science/dynare


After this 'git log science/dynare' only shows my last commit, and not 
the previous history of 'math/dynare' that existed before its removal.


The above sequence of commands should have kept and migrated the history 
of math/dynare to science/dynare, but it didn't.


The corresponding subversion command sequence keeps history.


Yuri


