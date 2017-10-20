Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E61C202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 01:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbdJTBMB (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 21:12:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44728 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbdJTBL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 21:11:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id x7so8581186pfa.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=H/2OdUdXYFIAO//V33DONaA7mOHDyq4eDKf4Oc37hEk=;
        b=cJ4gbCi1rL0kRwYpa6JILHn+HYmf2DfbmDFlE+eALyu/jGNV4omCjeoPPA33s5qY4W
         jKVbgs6leHXMcRbahwrP9TPUBf3t8ih65YKPv1rM91Yfkxu2TDimjBFXCH6T2R/0IZEG
         ZdQekcXqyVIX3n9QNkTBzBYnWwKpcZpvJ5pKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=H/2OdUdXYFIAO//V33DONaA7mOHDyq4eDKf4Oc37hEk=;
        b=K2CA5LdGkDCXjr9mJWfBUQOR3PgkVpWe0QX15g62jsEd0G5F98Z4QQ2I6o44SyjuaJ
         R0YzIVomnWU0C23RsEgp6cactdF5MZL6fEnojVz9ouvaIdbd9UXVWZnwciT0YjNUEsHO
         4i7gYpC9WMtJe55tdbTuLqr1qZXbAMjoC+fZxH7sQgxBQ6r4gmYyW0bN2Wsy9Ma4qXrh
         1Rh1jeikjVvfhOxHJdsQ+ohuuVvEogq8XUH9cQASgQ7EZqm1E6lVOTr0JYxdqNbjK9Cl
         vm0s/7SX+RZpBpYay02Q6t1Woy1dUrRA0orlUGSfVsBSX5OO4pYlmPolN4yPi90ndIWl
         FMBA==
X-Gm-Message-State: AMCzsaV5UAHCpS29XsnSfU2mU87MjRzOtWpgXzaaDA42wNQ7xqAkmh4y
        HCel+G/4Rf0wYhbydGC3XlQ41mZ59Po=
X-Google-Smtp-Source: ABhQp+QbuZwdFSSQ5yBgZ9qYYtDnqzUEggjnrcTdiAO4AjNo3Oj/7/iuOBnB0EJNNMn8DwvUy4bM1Q==
X-Received: by 10.84.235.69 with SMTP id g5mr2900098plt.239.1508461915707;
        Thu, 19 Oct 2017 18:11:55 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id x19sm403583pgc.60.2017.10.19.18.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 18:11:54 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Ben Peart <peartben@gmail.com>, Alex Vandiver <alexmv@dropbox.com>
Subject: [PATCH 3/4] fsmonitor: Document GIT_TRACE_FSMONITOR
Date:   Thu, 19 Oct 2017 18:11:35 -0700
Message-Id: <169bbc6117f518ffc9371fea7dfd11439105cc80.1508461850.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.417.g05670bb6e
In-Reply-To: <20171020011136.14170-1-alexmv@dropbox.com>
References: <20171020011136.14170-1-alexmv@dropbox.com>
In-Reply-To: <4f8e3dab26cf50cc6aa055605784680f5c33fcfa.1508461850.git.alexmv@dropbox.com>
References: <4f8e3dab26cf50cc6aa055605784680f5c33fcfa.1508461850.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 Documentation/git.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1fca63634..720db196e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -594,6 +594,10 @@ into it.
 Unsetting the variable, or setting it to empty, "0" or
 "false" (case insensitive) disables trace messages.
 
+`GIT_TRACE_FSMONITOR`::
+	Enables trace messages for the filesystem monitor extension.
+	See `GIT_TRACE` for available trace output options.
+
 `GIT_TRACE_PACK_ACCESS`::
 	Enables trace messages for all accesses to any packs. For each
 	access, the pack file name and an offset in the pack is
-- 
2.15.0.rc1.417.g05670bb6e

