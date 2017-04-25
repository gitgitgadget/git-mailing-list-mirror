Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86331FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 18:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2993266AbdDYSlY (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 14:41:24 -0400
Received: from siwi.pair.com ([209.68.5.199]:15785 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2993262AbdDYSlW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 14:41:22 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6C6D684488;
        Tue, 25 Apr 2017 14:41:20 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, j6t@kdbg.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v8] read-cache: call verify_hdr() in a background thread
Date:   Tue, 25 Apr 2017 18:41:08 +0000
Message-Id: <20170425184109.46168-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 8 of this patch converts the unit test to use
perl to corrupt the index checksum (rather than altering
a filename) and also verifies the fsck error message as
suggested in response to v7 on the mailing list.

If there are no other suggestions, I think this version
should be considered final.


Jeff Hostetler (1):
  read-cache: force_verify_index_checksum

 builtin/fsck.c  |  1 +
 cache.h         |  2 ++
 read-cache.c    |  7 +++++++
 t/t1450-fsck.sh | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)

-- 
2.9.3

