Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F6620966
	for <e@80x24.org>; Wed,  5 Apr 2017 18:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755712AbdDESGr (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 14:06:47 -0400
Received: from siwi.pair.com ([209.68.5.199]:59734 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755460AbdDESGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 14:06:45 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 65AB1846BC;
        Wed,  5 Apr 2017 14:06:44 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6] read-cache: call verify_hdr() in a background thread
Date:   Wed,  5 Apr 2017 18:06:24 +0000
Message-Id: <20170405180625.12439-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 6 of this patch series cleans up a little further
and uses test_when_finished in the unit test.

================
Version 5 of this patch series further simplifies the change to a
single global variable for use by fsck.  It eliminates the core
config setting.  Further discussion on the mailing list indicated
that the config setting only added confusion and probably would not
be used by anyone.


Jeff Hostetler (1):
  read-cache: force_verify_index_checksum

 builtin/fsck.c  |  1 +
 cache.h         |  2 ++
 read-cache.c    |  7 +++++++
 t/t1450-fsck.sh | 13 +++++++++++++
 4 files changed, 23 insertions(+)

-- 
2.9.3

