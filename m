Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14C41F597
	for <e@80x24.org>; Sun,  5 Aug 2018 13:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeHEPFr (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 11:05:47 -0400
Received: from codesynthesis.com ([142.44.161.217]:43658 "EHLO
        codesynthesis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeHEPFr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 11:05:47 -0400
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Aug 2018 11:05:47 EDT
Received: from [10.5.0.1] (unknown [178.219.147.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id 7E78C5E6F2;
        Sun,  5 Aug 2018 13:01:15 +0000 (UTC)
To:     git@vger.kernel.org
From:   Karen Arutyunov <karen@codesynthesis.com>
Subject: git worktree add prints to stdout
Organization: Code Synthesis
Message-ID: <631ae70d-9b5f-613d-5b6f-5064d548a894@codesynthesis.com>
Date:   Sun, 5 Aug 2018 16:01:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

The 'git worktree add' command prints to both standard streams. So in 
the following example the first line is printed to stderr and the second 
to stdout.

$ git worktree add ../pub build2-control
Preparing ../pub (identifier pub)
HEAD is now at b03ea86 Update

This looks like a bug, as, for example, the checkout command prints 
'HEAD is now at...' message to stderr.

Best regards,
Karen
