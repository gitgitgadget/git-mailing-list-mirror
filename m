Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE2320A17
	for <e@80x24.org>; Thu, 19 Jan 2017 15:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbdASP2Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 10:28:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43433 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753161AbdASP2V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 10:28:21 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 858148123D;
        Thu, 19 Jan 2017 15:03:53 +0000 (UTC)
Received: from localhost (ovpn-116-186.ams2.redhat.com [10.36.116.186])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0JF3qIe021349;
        Thu, 19 Jan 2017 10:03:52 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 0/2] grep: make output consistent with revision syntax
Date:   Thu, 19 Jan 2017 15:03:45 +0000
Message-Id: <20170119150347.3484-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 19 Jan 2017 15:03:53 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-grep(1)'s output is not consistent with git-rev-parse(1) revision syntax.

This means you cannot take "rev:path/to/file.c: foo();" output from git-grep(1)
and expect "git show rev:path/to/file.c" to work.  See the individual patches
for examples of command-lines that produce invalid output.

This series is an incomplete attempt at solving the issue.  I'm not familiar
enough with the git codebase to propose a better solution.  Perhaps someone is
interested in a proper fix?

Stefan Hajnoczi (2):
  grep: only add delimiter if there isn't one already
  grep: use '/' delimiter for paths

 builtin/grep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.9.3

