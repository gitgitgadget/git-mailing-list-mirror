Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51998C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C90F2071C
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389665AbgEYURq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 25 May 2020 16:17:46 -0400
Received: from westphal.uberspace.de ([185.26.156.72]:35374 "EHLO
        westphal.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388994AbgEYURp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 16:17:45 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2020 16:17:45 EDT
Received: (qmail 21444 invoked from network); 25 May 2020 20:11:02 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by westphal.uberspace.de with SMTP; 25 May 2020 20:11:02 -0000
Date:   Mon, 25 May 2020 22:11:00 +0200
From:   Merlin =?UTF-8?B?QsO8Z2U=?= <toni@bluenox07.de>
To:     git@vger.kernel.org
Subject: Question about behaviour of git-checkout --patch option
Message-ID: <20200525221100.31d36d4d.toni@bluenox07.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all!


I have a question about the behaviour of the git-checkout --patch/-p
option.

I have a small local git repository containing empty and non-empty
files. I wanted to replicate it in another directory and did the
following:

	cd <target_dir>
	git init
	git remote add origin <origin_dir>
	git fetch
	git branch --track master origin/master
	git checkout master .

This works like expected, I end up with a 1:1 copy of the original
worktree, including empty files. However, if I include the -p option in
the last step:

	git checkout -p master .

... I correctly get asked for any non-empty files/hunks if I want to
apply them - but not for empty ones. It would just display e.g.

	diff --git b/emptyfile a/emptyfile
	new file mode 100644
	index 0000000..e69de29

and then skip over it, asking for the next non-empty hunk.

Why does it skip over empty hunks?


Thanks!

-- 
Merlin Büge
