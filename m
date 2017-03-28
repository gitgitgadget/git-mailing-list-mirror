Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A3AA2096B
	for <e@80x24.org>; Tue, 28 Mar 2017 19:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755660AbdC1TIB (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:08:01 -0400
Received: from siwi.pair.com ([209.68.5.199]:29538 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755631AbdC1TIA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:08:00 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E5A2684622;
        Tue, 28 Mar 2017 15:07:52 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 0/2] read-cache: call verify_hdr() in a background thread
Date:   Tue, 28 Mar 2017 19:07:30 +0000
Message-Id: <20170328190732.59486-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 3 of this patch series simplifies this effort to just turn
on/off the hash verification using a "core.checksumindex" config variable.

I've preserved the original checksum validation code so that we can
force it on in fsck if desired.

It eliminates the original threading model completely.

Jeff Hostetler (2):
  read-cache: core.checksumindex
  test-core-checksum-index: core.checksumindex test helper

 Makefile                            |  1 +
 read-cache.c                        | 12 ++++++
 t/helper/.gitignore                 |  1 +
 t/helper/test-core-checksum-index.c | 77 +++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 t/helper/test-core-checksum-index.c

-- 
2.9.3

