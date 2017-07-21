Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 014D320288
	for <e@80x24.org>; Fri, 21 Jul 2017 14:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbdGUOPd (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 10:15:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754584AbdGUOPb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 10:15:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C57EC04D28D
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 14:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 8C57EC04D28D
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=eblake@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 8C57EC04D28D
Received: from red.redhat.com (ovpn-120-37.rdu2.redhat.com [10.10.120.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27C3660C14
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 14:15:31 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     git@vger.kernel.org
Subject: [PATCH] git-contacts: Add recognition of Reported-by
Date:   Fri, 21 Jul 2017 09:15:30 -0500
Message-Id: <20170721141530.25907-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 21 Jul 2017 14:15:31 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's nice to cc someone that reported a bug, in order to let
them know that a fix is being considered, and possibly even
get their help in reviewing/testing the patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 contrib/contacts/git-contacts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index dbe2abf27..85ad732fc 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -11,7 +11,7 @@ use IPC::Open2;

 my $since = '5-years-ago';
 my $min_percent = 10;
-my $labels_rx = qr/Signed-off-by|Reviewed-by|Acked-by|Cc/i;
+my $labels_rx = qr/Signed-off-by|Reviewed-by|Acked-by|Cc|Reported-by/i;
 my %seen;

 sub format_contact {
-- 
2.13.3

