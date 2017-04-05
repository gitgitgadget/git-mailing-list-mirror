Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99A92096C
	for <e@80x24.org>; Wed,  5 Apr 2017 14:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755807AbdDEOzg (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 10:55:36 -0400
Received: from siwi.pair.com ([209.68.5.199]:30074 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755793AbdDEOz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 10:55:27 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4D1C98468B;
        Wed,  5 Apr 2017 10:55:26 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5] read-cache: call verify_hdr() in a background thread
Date:   Wed,  5 Apr 2017 14:55:09 +0000
Message-Id: <20170405145510.2324-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

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
 t/t1450-fsck.sh | 11 +++++++++++
 4 files changed, 21 insertions(+)

-- 
2.9.3

