Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 422FA1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeFGFUG (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:20:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51185 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeFGFUF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:20:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BDF3F168A;
        Thu,  7 Jun 2018 01:20:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=MwGa
        oYkwflhwQB872KGdwFel9Bs=; b=viFNnsWBbaqT7EdYbCQc1HBW4G7TFBDH1D4q
        ZfbS0mX5uMK+ekYLXpQFIXhYNvRZ8NShZ9+a0BM7pBZA6hoSt3hr8Pz7z5Fpl8QD
        hSnt9FAAZZydI46od0514Khzc1oWwE4MWQpHzp7f9jHodFIjzOL4peHvfcLUpQo2
        8kOBz9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        ePdSx+j5ezI08Q35I0mo8tF2Z9PM1voRYumh0tTG6curDVl+Q2YSM4dhdF4rWHGj
        0F+rYf0mSb4/oQqGoIp3d/HuARk43jk8JaxsBdoowYMqronXVm8SVHn5PnzjRkZE
        8/nE4Lp+HxxEJRcd4ROZX+2FwVWG+hn+GfCmjNaLfbU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72193F1687;
        Thu,  7 Jun 2018 01:20:03 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.85.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1212AF1682;
        Thu,  7 Jun 2018 01:20:01 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/2] git-credential-netrc: make "all" default target of Makefile
Date:   Thu,  7 Jun 2018 01:19:57 -0400
Message-Id: <20180607051958.759-2-tmz@pobox.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607051958.759-1-tmz@pobox.com>
References: <20180607051958.759-1-tmz@pobox.com>
X-Pobox-Relay-ID: 6E06D4DC-6A12-11E8-9573-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running "make" in contrib/credential/netrc should run the "all" target
rather than the "test" target.  Add an empty "all::" target like most of
our other Makefiles.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 contrib/credential/netrc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/credential/netrc/Makefile b/contrib/credential/netrc/Makefile
index 0ffa407191..6174e3bb83 100644
--- a/contrib/credential/netrc/Makefile
+++ b/contrib/credential/netrc/Makefile
@@ -1,3 +1,6 @@
+# The default target of this Makefile is...
+all::
+
 test:
 	./t-git-credential-netrc.sh
 
-- 
2.18.0.rc1

