Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BCD21F454
	for <e@80x24.org>; Fri, 18 Jan 2019 03:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfARDiq (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 22:38:46 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:59678 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfARDiq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 22:38:46 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E88051F453;
        Fri, 18 Jan 2019 03:38:45 +0000 (UTC)
Date:   Fri, 18 Jan 2019 03:38:45 +0000
From:   Eric Wong <e@80x24.org>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org
Subject: cat-file ambiguity prints "dangling"
Message-ID: <20190118033845.s2vlrb3wd3m2jfzu@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

Perhaps I'm confused, the cat-file manpage seems to indicate
"dangling" only gets printed if I use "--follow-symlinks".

However, I'm not using "--follow-symlinks" and I get
"dangling" when passing ambiguous object IDs:

Trying to check the ambiguous "dead" against git.git, I get:

	$ echo dead | git cat-file --batch-check 2>/dev/null
	dangling 4
	dead

Is the above intended?

stderr shows the ambiguity and gives me hints, which is expected.

Thanks.
