Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F200A1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 22:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfH2WqS (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 18:46:18 -0400
Received: from smtp123.ord1d.emailsrvr.com ([184.106.54.123]:58954 "EHLO
        smtp123.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728727AbfH2WqR (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Aug 2019 18:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1567118298;
        bh=4B4reGlzcYpOjVGLw2svkOXyUdseARWR9hbKAfDB2yk=;
        h=From:To:Subject:Date:From;
        b=oxaPk6GS15yGVPpuOa9Pasa2smxbLGKXmeuKjW+lgPMVGQWdKDSNFUvItj5mSMWxK
         MKIswofahcbiqhffhd4W5Xf5fITzDQXxWkLnjg3SdJJC7az+XBneY0CpVjGmXtksl8
         SDhicadSae4EZLwP2hhiE6N9hzZh8H5f5qqsbCAU=
X-Auth-ID: jon@jonsimons.org
Received: by smtp24.relay.ord1d.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id CDB6EA01EE;
        Thu, 29 Aug 2019 18:38:17 -0400 (EDT)
X-Sender-Id: jon@jonsimons.org
Received: from localhost.localdomain (c-73-223-68-105.hsd1.ca.comcast.net [73.223.68.105])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 29 Aug 2019 18:38:18 -0400
From:   Jon Simons <jon@jonsimons.org>
To:     jon@jonsimons.org, git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, sunshine@sunshineco.com,
        stolee@gmail.com
Subject: [PATCH v2 0/2] partial-clone: fix two issues with sparse filter handling
Date:   Thu, 29 Aug 2019 18:38:09 -0400
Message-Id: <20190829223811.12072-1-jon@jonsimons.org>
X-Mailer: git-send-email 2.23.0.37.g745f681289.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Included here are two fixes for partial cloning with sparse filters.
These issues were uncovered in early testing internally at GitHub,
where Taylor and Peff have provided early offlist review feedback.

In this second revision I've adopted Eric and Peff's additional
feedback on some of the test details: fixes, whitespace adjustment,
and some further simplifications -- thanks!

Jon Simons (2):
  list-objects-filter: only parse sparse OID when 'have_git_dir'
  list-objects-filter: handle unresolved sparse filter OID

 list-objects-filter-options.c |  3 ++-
 list-objects-filter.c         |  6 +++++-
 t/t5616-partial-clone.sh      | 28 ++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.23.0.37.g745f681289.dirty

