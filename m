Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130E41F461
	for <e@80x24.org>; Wed, 28 Aug 2019 20:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfH1U0t (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 16:26:49 -0400
Received: from smtp122.iad3a.emailsrvr.com ([173.203.187.122]:53082 "EHLO
        smtp122.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726763AbfH1U0t (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Aug 2019 16:26:49 -0400
X-Auth-ID: jon@jonsimons.org
Received: by smtp8.relay.iad3a.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 1B02F5465;
        Wed, 28 Aug 2019 16:18:48 -0400 (EDT)
X-Sender-Id: jon@jonsimons.org
Received: from localhost.localdomain (c-73-223-68-105.hsd1.ca.comcast.net [73.223.68.105])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 28 Aug 2019 16:18:49 -0400
From:   Jon Simons <jon@jonsimons.org>
To:     jon@jonsimons.org, git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net
Subject: [PATCH 0/2] partial-clone: fix two issues with sparse filter handling
Date:   Wed, 28 Aug 2019 16:18:22 -0400
Message-Id: <20190828201824.1255-1-jon@jonsimons.org>
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

Jon Simons (2):
  list-objects-filter: only parse sparse OID when 'have_git_dir'
  list-objects-filter: handle unresolved sparse filter OID

 list-objects-filter-options.c |  3 ++-
 list-objects-filter.c         |  6 +++++-
 t/t5616-partial-clone.sh      | 30 ++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.23.0.37.g745f681289.dirty

