Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84ECB1F453
	for <e@80x24.org>; Tue, 18 Sep 2018 13:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbeIRTRU (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 15:17:20 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:35433 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRTRT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 15:17:19 -0400
Received: by mail-pg1-f182.google.com with SMTP id 205-v6so127594pgd.2
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9A1eHX7m4xtzAj4sIHkmks2dj0pJ0PTnl2PRnuagGFM=;
        b=XrN59ZQOktGpYgqa6+Q1G29pF0INz5bQAaZ+v7r/PhSP0++uohZVFptKhvfHv6QPer
         pGQNZ5EtbNJqJazy3FvuRlS2LIP4X9+951CDIdX0hhgfnREU2wcDW7zzsBLmYk0z4ME5
         +Nl0owz35/IfIOnKdUAUiBwGbkH24tQkDnRxMPHAZYIGIT+IilfegIR493F7WH58PdGv
         KJzs4RQKQo+TJ3tf1+iKRetoNQTC5Ha9KvOi+a6+41GxHcnLdupHmxsCezcAcTi0wfGR
         lHdeLPHffb3ezxmOHJ2HXcP0Gjay+aDUOA9uEhytbSPMJFxCzRxDuW7FJbxZ+tltcpH/
         e8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9A1eHX7m4xtzAj4sIHkmks2dj0pJ0PTnl2PRnuagGFM=;
        b=STKc5uWxiUArkNWlp14P93OhE3YJ7x6P0rrxTYGZYFFJ1V5rx99K3B9XM9LS5tlvTm
         EpTAtDdetbl/4XisOVlsajj2FNZMeFy56qdMkT42bOUnh6OtOhjlc/sUyqrLjslxFE/S
         smZGOdb1/nltxPjjMk0BYVbN6OVJ7xMc46J0UzPDbaxxsAoN8PU0OdAcXYUdrGeHiD1D
         I3Up36H8MALhnNJjdd7LF9Cu4swStZYXMlUGVs/Mi74TmblfmWphBSsKqrQ1J3Lu1nFu
         8aB9QwHf/Usr/jlspD9YgeU1V6KT2T7aVk+J/hOacjQZ+ZDEUFFoZw+mXxzaa+wZJapR
         A+/w==
X-Gm-Message-State: APzg51Dekj+VQPKWALOrc14aAUGQZ6loo10wXh7hqteinbIN0JAooPNV
        OZPURzsl8+rh+96QFQEznFaCBKrE
X-Google-Smtp-Source: ANB0VdZnZl8kGhJhwYaW04JILVRL58fizpxuIQ2vIESbrvbB1WppNnUkvCNR7OXjluFuE0D84d6VMQ==
X-Received: by 2002:a63:5b1b:: with SMTP id p27-v6mr27983241pgb.322.1537278279188;
        Tue, 18 Sep 2018 06:44:39 -0700 (PDT)
Received: from localhost.localdomain ([180.245.188.101])
        by smtp.gmail.com with ESMTPSA id i5-v6sm31600591pfe.140.2018.09.18.06.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 06:44:38 -0700 (PDT)
From:   Shulhan <m.shulhan@gmail.com>
To:     git@vger.kernel.org
Cc:     Shulhan <m.shulhan@gmail.com>, Wink Saville <wink@saville.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/1] git-rebase--interactive.sh: fix trailing spaces on empty $todo
Date:   Tue, 18 Sep 2018 20:44:11 +0700
Message-Id: <20180918134412.32766-2-m.shulhan@gmail.com>
X-Mailer: git-send-email 2.19.0.446.g26223adc4
In-Reply-To: <20180918134412.32766-1-m.shulhan@gmail.com>
References: <20180918134412.32766-1-m.shulhan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When issuing interactive rebase, git will open a text editor with list
of commits to rebase and documentation on how to edit it.  At the end
of documentation it display,

  #	However, if you remove everything, the rebase will be aborted.
  #
  #\t
  # Note that empty commits are commented out

The "\t" is white space tab.

This commit remove the empty tab at the last two line.
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 299ded213..0bf9eefad 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -224,7 +224,7 @@ EOF
 	gettext "
 	However, if you remove everything, the rebase will be aborted.
 
-	" | git stripspace --comment-lines >>"$todo"
+" | git stripspace --comment-lines >>"$todo"
 
 	if test -z "$keep_empty"
 	then
-- 
2.19.0.446.g26223adc4

