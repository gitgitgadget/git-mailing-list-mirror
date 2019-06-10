Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FDD21F462
	for <e@80x24.org>; Mon, 10 Jun 2019 15:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391085AbfFJPHU (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 11:07:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:43138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389368AbfFJPHU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 11:07:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BEF8AE20
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 15:07:19 +0000 (UTC)
Date:   Mon, 10 Jun 2019 17:07:18 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     git <git@vger.kernel.org>
Subject: rebase / am separation problem
Message-ID: <20190610170718.2f9fe177@naga.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

there is an issue with rebase vs am separation.

I am using git 2.20.1 and just observed this behavior:

 - rebase started ( possibly with previous am in progress on 
   different branch - not known)
 - rebase stopped, used am --skip to continue
 - renase was not able to finish

Does anybody else observe this issue?

There is some nesting possible - I am sure that at least one of
cherry-pick and am can be included on top of a commit where git stopped
during rebase -i. However, git should either isolate the three properly
so they can be layered one on top of another of reject the command if
it would corrupt state of currently running command.

Thanks

Michal
