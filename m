Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AA4F1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 01:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfBHBtH (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 20:49:07 -0500
Received: from ozlabs.org ([203.11.71.1]:57643 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfBHBtH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 20:49:07 -0500
Received: by ozlabs.org (Postfix, from userid 1011)
        id 43wdQ91pJbz9sMl; Fri,  8 Feb 2019 12:49:05 +1100 (AEDT)
From:   Rusty Russell <rusty@rustcorp.com.au>
To:     git@vger.kernel.org
Cc:     "Joel Stanley" <joel@jms.id.au>
Subject: `git status -u no` suppresses modified files too.
Date:   Fri, 08 Feb 2019 12:18:57 +1030
Message-ID: <87y36rcanq.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This broke my "is this clean?" sanity check and very much violates
the man page description.

(I am now using `git diff --name-only` instead at Joel's suggestion.)

        $ git status
        On branch guilt/repro
        Changes not staged for commit:
          (use "git add <file>..." to update what will be committed)
          (use "git checkout -- <file>..." to discard changes in working directory)
        
        	modified:   tools/repro-build.sh
        
        Untracked files:
          (use "git add <file>..." to include in what will be committed)
        
        	.cache/
        	ANALYSIS
        	NOTES
        	SHA256SUMS
        	SHA256SUMS.asc
        	badpeer.json
        	base
        	channels.out.xz
        
        no changes added to commit (use "git add" and/or "git commit -a")
        $ git status -u no
        On branch guilt/repro
        nothing to commit, working tree clean
        $ git --version
        git version 2.19.1
        $

Cheers,
Rusty.
