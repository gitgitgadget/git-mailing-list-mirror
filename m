Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B331F404
	for <e@80x24.org>; Wed, 12 Sep 2018 13:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeILS6W (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 14:58:22 -0400
Received: from sebastianaudet.com ([45.56.118.10]:55080 "EHLO localhost"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726836AbeILS6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 14:58:21 -0400
X-Greylist: delayed 2248 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Sep 2018 14:58:21 EDT
Received: from smaudet by localhost with local (Exim 4.89)
        (envelope-from <smaudet@sebastianaudet.com>)
        id 1g050L-0002DG-La
        for git@vger.kernel.org; Wed, 12 Sep 2018 13:16:25 +0000
Date:   Wed, 12 Sep 2018 13:16:25 +0000
From:   smaudet@sebastianaudet.com
To:     git@vger.kernel.org
Subject: Gitattributes not properly supported with add command
Message-ID: <20180912131625.GA7736@sebastianaudet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following:

git add -u :\(glob,attr:-someAttr\):src/**

Produces an error that, according to the source code, should never be visible to the user. This attribute/pathspec *should* be supported according to the documentation provided by git:

fatal: BUG:builtin/add.c:498: unsupported magic 40

It looks like the documentation claims more features than the source code supports, perhaps incorrectly because I think you shouldn't be restricted to a set of attributes, and the source code 
doesn't properly do its job anyways and never handles this scenario.

This should be fixed, if I have any time I'll look into what it would take to submit a patch, but I don't have the time for this right now.


