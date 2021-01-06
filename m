Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB7FC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 16:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799FA23130
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 16:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbhAFQRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:17:49 -0500
Received: from ciao.gmane.io ([116.202.254.214]:41222 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbhAFQRt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 11:17:49 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1kxBUi-0003r9-FY
        for git@vger.kernel.org; Wed, 06 Jan 2021 17:17:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Stefan Monnier <monnier@iro.umontreal.ca>
Subject: New orphan worktree?
Date:   Wed, 06 Jan 2021 11:17:02 -0500
Message-ID: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Cancel-Lock: sha1:i5TZGH9llZyDl8Bw92DzYZETq5k=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I use worktrees extensively (and rarely use `git checkout`).

When I need to create a new orphan branch with a new matching worktree
(or submodule), I find it is quite cumbersome.  I basically have
to do something like:

    git worktree add -b dummy foo
    cd foo
    git checkout --orphan newbranch
    git rm -rf .
    git branch -D dummy

I wish I could just do something like:

    git worktree add --orphan foo newbranch

instead,


        Stefan

