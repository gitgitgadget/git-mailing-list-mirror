Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E661F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933837AbeFUV3h (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:29:37 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:36533 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933745AbeFUV3f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:35 -0400
Received: by mail-yw0-f201.google.com with SMTP id 202-v6so2529228ywo.3
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=PToBQ6jRlH0qksRCkvJcxSg1GCi6hsYYr9BKtMtEkM4=;
        b=HjlQkp/7i3cRP5ppHLc5NMknA7ftKGqVPGQEhUALPxVl0Xmdd/8FpT2KAqnBnfqkcU
         IxoxaVK6aFibwSkjnlCxUBqRwPQZO71yu+FhSZQz1mi/6/mSL31RhGtPKCjTBvTIQjvY
         x5Tdd6Nr1ZCMYbAjaLe6Ha5ivGgMhGEdWD6Ti5jsLfbPGX3cMbr9JBOimPZEQfcfOy9K
         vewid+in976nQGqYcpUi2w3NOM/hSR1NDa/ROpZLCn1XwzPbTF6g79reg8a5vwDY2Eyg
         YdArNeifu5pZrnKd2vZSXd6O4ZytzOaajn1NZTebUQZxw3HUjSjG564hG+e8YXRImyWD
         otxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=PToBQ6jRlH0qksRCkvJcxSg1GCi6hsYYr9BKtMtEkM4=;
        b=M0M0BaDj/qmq/60szkRLd9YtEYJLWZOo6DgpKr8rw9hlRfcjMpnzUvlLOoDfFE8llI
         I9TXDIdlfxvQ8B7syj+Vx3HTWWRlW/9MFCHivxrZkf0IdbDi0EVmuG/6Pgi+VzSGghkR
         ZsJ03DBI4tC0cI+Tp/+BkE68dWEDEtXh88VT0YiyWe7cv7gihcXwbRAFltWGjqcq28dF
         eM8XEdwSRzKr9eU/IGPkORhnx1s7yB2+jPu5yHvnnTz5EI7ZyN8aHHNnoGA7Rmtz+kO7
         Nc/b/qVevV/LnIdaj0FrcJ7dOQK+y/sslV58RIvwiTQRXZj3MDms1fWQHAIkgqV2GERI
         x79A==
X-Gm-Message-State: APt69E1kZ2ROHf3TjiP8F+jeVhhCEdll0pa1SLnwTlNxe3IAHOlka72v
        dD7HLBqucasN0SrDrp+3eM5GjJ+vUEBgNXz50vpzmC4xpc6TTTUQzB/nI0+7P9GGjDr/kCiA76a
        ngqj7/5mXzNcRNNZzXNvdFSBNmGvzs5qnmlVRsqBs0CDSPbKVjLyrut8vdmp1RAH9UxM6pw1Hyy
        W7
X-Google-Smtp-Source: ADUXVKLupDuCKIzrcAEQMbtR2UC86wmBPG2T9HXjXjir2+GEnmRo3mkUajpO4CQk6JIpywOTZYhPeXjeBcIeQoe5MBpN
MIME-Version: 1.0
X-Received: by 2002:a25:b196:: with SMTP id h22-v6mr7587023ybj.27.1529616574481;
 Thu, 21 Jun 2018 14:29:34 -0700 (PDT)
Date:   Thu, 21 Jun 2018 14:29:22 -0700
In-Reply-To: <cover.1529616356.git.jonathantanmy@google.com>
Message-Id: <82c9edb9108f49468031bfd7c65a9eb8db2cb671.1529616356.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: [PATCH 2/5] commit-graph: add missing forward declaration
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 commit-graph.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/commit-graph.h b/commit-graph.h
index 260a468e73..7004dfdca9 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -3,6 +3,8 @@
 
 #include "git-compat-util.h"
 
+struct commit;
+
 char *get_commit_graph_filename(const char *obj_dir);
 
 /*
-- 
2.18.0.rc2.347.g0da03f3a46.dirty

