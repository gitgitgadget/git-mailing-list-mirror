Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3311F461
	for <e@80x24.org>; Mon,  8 Jul 2019 08:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfGHIWU (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 04:22:20 -0400
Received: from 79-149-172-163.rev.cloud.scaleway.com ([163.172.149.79]:54240
        "EHLO eyoman.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfGHIWT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 04:22:19 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jul 2019 04:22:19 EDT
Received: by eyoman.com (Postfix, from userid 1004)
        id 23601180598; Mon,  8 Jul 2019 11:14:49 +0300 (IDT)
Received: from zen (unknown [176.230.45.210])
        by eyoman.com (Postfix) with ESMTPA id 64CF5180120
        for <git@vger.kernel.org>; Mon,  8 Jul 2019 11:14:48 +0300 (IDT)
Date:   Mon, 8 Jul 2019 11:14:59 +0300
From:   Daniel Zaoui <jackdanielz@eyomi.org>
To:     git@vger.kernel.org
Subject: Weird behavior with git grep --recurse-submodules
Message-ID: <20190708111459.135abe50@zen>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys,

I work with submodules and use git grep a lot.

I noted that when it is invoked used with --recurse-submodules, the result is not as expected for the submodules. I get submodules results as if no files were modified (like --cached option) although I would expect results taking into account the modifications.

Expected behavior:
git grep --recurse-submodules string:
- git grep string // search into main repo
- for each submodule, git grep string // search into submodule

Actual behavior:
git grep --recurse-submodules string:
- git grep string // search into main repo
- for each submodule, git grep --cached string // search into submodule

Do you get the same behavior? Am I doing something wrong? Was I understandable :-)? Is it a bug?

git --version: git version 2.22.0
uname -a: Linux daniel 5.1.15-arch1-1-ARCH #1 SMP PREEMPT Tue Jun 25 04:49:39 UTC 2019 x86_64 GNU/Linux

Thanks
Daniel
