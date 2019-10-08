Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9B021F4BE
	for <e@80x24.org>; Tue,  8 Oct 2019 07:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfJHHzJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 03:55:09 -0400
Received: from smtp.soverin.net ([159.69.232.138]:55771 "EHLO smtp.soverin.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730209AbfJHHzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 03:55:08 -0400
Received: from soverin.net by soverin.net
From:   Toon Claes <toon@iotcl.com>
To:     git@vger.kernel.org
Cc:     Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/1] Add support for Co-authored-by
Date:   Tue,  8 Oct 2019 09:45:38 +0200
Message-Id: <20191008074538.4950-1-toon@iotcl.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.101.4 at c03mi01
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With this patch it is possible to specify a co-author when
committing. You'd just need to provide the --coauthor argument with a
co-author in the format "Co Artur <co-artur@example.com>". You can
specify multiple co-authors by using the --coauthor argument multiple
times.

The Co-authored-by trailer is something that is commonly used when
people pair up and want multiple authors in the commit message.

The feature was originally proposed here:
https://github.com/gitgitgadget/git/issues/343

Toon Claes (1):
  commit: add support to provide --coauthor

 Documentation/git-commit.txt |  5 ++++
 builtin/commit.c             |  7 ++++++
 sequencer.c                  | 44 ++++++++++++++++++++++++++----------
 sequencer.h                  |  2 ++
 t/t7502-commit-porcelain.sh  | 11 +++++++++
 5 files changed, 57 insertions(+), 12 deletions(-)

--
2.22.0.rc3
