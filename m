Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93197C4BA06
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 00:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6829120658
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 00:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgBZAsf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:48:35 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55469 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgBZAsf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 19:48:35 -0500
X-Originating-IP: 73.42.98.145
Received: from Kepler (c-73-42-98-145.hsd1.nm.comcast.net [73.42.98.145])
        (Authenticated sender: greg@gpanders.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id BD7BBC0002
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 00:48:32 +0000 (UTC)
Date:   Tue, 25 Feb 2020 17:48:30 -0700
From:   Greg Anders <greg@gpanders.com>
To:     git@vger.kernel.org
Subject: git-shell default working directory
Message-ID: <20200226004830.oxd5562v7qqspnkk@Kepler>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm working on standing up a self-hosted git server. I'd like to keep my 
repositories under a dedicated directory, i.e. /srv/git, but I'd also 
like to be able to clone a repository using a simple syntax:

     git clone git@myserver:repo.git

as opposed to

     git clone git@myserver:/srv/git/repo.git

I've not yet found a way to get this to work without keeping the 
repositories in the git user's home folder. I've tried using a ~/.ssh/rc 
file to chdir into /srv/git and I've tried using the `command=` 
parameter in the authorized_keys file; however, both of these fail 
because `cd` is not recognized as a valid command by git-shell.

I suppose I could create symlinks from the repositories in /srv/git into 
/home/git, but I'm wondering if there's a cleaner way to do this?

Thanks,

Greg
