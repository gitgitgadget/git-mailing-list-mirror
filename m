Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F468C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 12:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DAE6139A
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 12:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhGIMvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 08:51:16 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:61109 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhGIMvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 08:51:16 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jul 2021 08:51:16 EDT
Received: from [84.163.73.96] (helo=[192.168.2.202])
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <me@mfriebe.de>)
        id 1m1pnF-0007lU-Ti
        for git@vger.kernel.org; Fri, 09 Jul 2021 14:39:45 +0200
To:     git@vger.kernel.org
From:   Martin <me@mfriebe.de>
Subject:  git checkout -b refs/master origin/master
Message-ID: <71d3662c-411b-88aa-5cfc-b2f86a067507@mfriebe.de>
Date:   Fri, 9 Jul 2021 14:40:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just curious..

"refs/master" is allowed as local branch name (git checkout / git branch 
/ git switch)

Is that intentionally allowed?

  git for-each-ref
6faf346455d0a024cb1edf2d64fc4c42b450c53d commit refs/heads/refs/master

  git for-each-ref --format="ref=%(refname)"
ref=refs/heads/refs/master

Especially the effect on
git for-each-ref --format="ref=%(refname:lstrip=-1)"
master

You only get part of the branch name.
Because "lstrip" does not distinguish between the / as separator in the 
refs, and the "/" as part of the name.
