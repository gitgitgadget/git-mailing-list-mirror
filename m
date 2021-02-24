Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74115C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BEF564ECE
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBXR7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 12:59:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:35882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhBXR7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 12:59:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 600AAADDB
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 17:58:35 +0000 (UTC)
Date:   Wed, 24 Feb 2021 18:58:34 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     git@vger.kernel.org
Subject: Getting an actuallt useful merge base?
Message-ID: <20210224175834.GT6564@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I find the results of git merge-base A B quite useless.

Suppose you have a repository with file sets

S and T

where S are sources which are developed in mainline and number of stable
versions, and feature branches, and T are build tools (such as autoconf
tests or whatever) that are largely independent of the source version.

Because of the independence of T from S T are developed in a separate
branch t which is merged into all branches developing S as needed.

Fixes to S may affect more than one version, and depending on the
situation it might be useful to apply fixes to S to mutiple
stable/feature branche at once. For that one would need a merge base of
the branches in question.

However, merge-base almost always give a commit on branch t which is the
merge base of files in set T and does not contain files in set S at all.
In other words it is merge base only for files from set T and not set S.
Can I get merge base that is merge base for all files that have common
history between two branches?

Thanks

Michal
