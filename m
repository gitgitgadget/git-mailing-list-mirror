Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFAD81FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 09:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbcFPJlP (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 05:41:15 -0400
Received: from continuum.iocl.org ([217.140.74.2]:32818 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbcFPJlO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 05:41:14 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id u5G9f9O15229;
	Thu, 16 Jun 2016 11:41:09 +0200
Date:	Thu, 16 Jun 2016 11:41:08 +0200
From:	Andreas Krey <a.krey@gmx.de>
To:	git@vger.kernel.org
Subject: Code review tool recommendations - replacement for crucible?
Message-ID: <20160616094108.GA14661@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag:	What did you expect to see here?
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi all,

I'm looking for pointers to review tools that work with git (obviously),
and can deal sensibly with bigger reviews. Things we need:

- Ability to split (set of) commits into multiple reviews,
  so parts of changes can be reviewed by the respective owners
  (or assign different reviewers to different files/subtrees
  in a review).

- Tracking of files (or changes) already reviewed (due to the large numbers),
  and of the handling of issues found so far.

- Support incremental reviews, not just e.g. over the content of a
  pull request (bitbucket) When review comments are processed people
  want to be able to only review that change, and not to be forced
  to find that change in the entire previous changeset without
  the tool's support.

We were mostly content with atlassian crucible so far, but
it simply fails to index[1] our large product repo (5+ Gb) so
we switched to just give it diffs to review, and it fails
to properly display renames, and fails in a few minor
but annoying ways in dealing with these big reviews.

Any pointers?

- Andreas

[1] Crucible seems to be svn-centric, and the mapping
    from git to svn changesets they use internally
    apparently is O(n^{too much}) - just indexing
    a new branch identical to an existing one takes
    hours here.

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
