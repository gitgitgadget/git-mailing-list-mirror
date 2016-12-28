Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70BD920441
	for <e@80x24.org>; Wed, 28 Dec 2016 17:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbcL1Rlb (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 12:41:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750976AbcL1Rla (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 12:41:30 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F66F3D95C;
        Wed, 28 Dec 2016 17:40:45 +0000 (UTC)
Received: from localhost (ovpn-116-29.gru2.redhat.com [10.97.116.29])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBSHeigx025836;
        Wed, 28 Dec 2016 12:40:44 -0500
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>
Subject: [PATCH] am: add am.signoff add config variable
Date:   Wed, 28 Dec 2016 15:40:38 -0200
Message-Id: <1482946838-28779-1-git-send-email-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 28 Dec 2016 17:40:45 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-am has options to enable --message-id and --3way by default,
but no option to enable --signoff by default. Add a "am.signoff"
config option.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 builtin/am.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 31fb605..d2e0233 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -154,6 +154,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 
 	git_config_get_bool("am.messageid", &state->message_id);
 
+	git_config_get_bool("am.signoff", &state->signoff);
+
 	state->scissors = SCISSORS_UNSET;
 
 	argv_array_init(&state->git_apply_opts);
-- 
2.7.4

