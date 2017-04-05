Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BF5020966
	for <e@80x24.org>; Wed,  5 Apr 2017 19:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933498AbdDET4L (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 15:56:11 -0400
Received: from siwi.pair.com ([209.68.5.199]:43759 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932666AbdDET4J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 15:56:09 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CE804845EF;
        Wed,  5 Apr 2017 15:56:06 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 0/2] string-list: use ALLOC_GROW macro when reallocing
Date:   Wed,  5 Apr 2017 19:55:58 +0000
Message-Id: <20170405195600.54801-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use ALLOC_GROW() macro when reallocating a string_list array
rather than simply increasing it by 32.  This helps performance
of status on very large repos on Windows.

Jeff Hostetler (2):
  string-list: use ALLOC_GROW macro when reallocing string_list
  p0005-status: time status on very large repo

 string-list.c          |  6 ++---
 t/perf/p0005-status.sh | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 4 deletions(-)
 create mode 100644 t/perf/p0005-status.sh

-- 
2.9.3

