Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EC6C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC81207CD
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgHUVsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:48:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:19358 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgHUVsj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:48:39 -0400
IronPort-SDR: lZZ4qjzmphtItJ87AuGKDJxKvRvB8n6g+EhgHmLr7RcTvQg/k5JMUpXDs3kZWZbhltlpZaMgGr
 97yID9g18nAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="135171193"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="135171193"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 14:48:39 -0700
IronPort-SDR: B6Den7pWSJbG/uGKJCN3Pwo2Uma6TwBmHEWsAA0S3C+ihFAk5VfnbIYbnZgktaZhVIqybDn5fm
 0/LiHiMZe6OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="498106699"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2020 14:48:39 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 0/2] minor refspec cleanups
Date:   Fri, 21 Aug 2020 14:48:18 -0700
Message-Id: <20200821214820.757222-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.28.0.218.ge27853923b9d.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

While preparing some patches for implementing support for negative refspecs,
I found a couple of minor nits. The first patch fixes the documentation in
refspec.h to refer to the correct structures. The second patch cleans up a
potential issue with refspec_item structures that weren't initialized
properly. While nothing breaks today, future extensions to refspec_item
would break if the structure wasn't properly initialized to zero.

Jacob Keller (2):
  refspec: fix documentation referring to refspec_item
  refspec: make sure stack refspec_item variables are zeroed

 builtin/remote.c |  1 +
 refspec.h        | 27 ++++++++++++++-------------
 transport.c      |  1 +
 3 files changed, 16 insertions(+), 13 deletions(-)


base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
-- 
2.28.0.218.ge27853923b9d.dirty

