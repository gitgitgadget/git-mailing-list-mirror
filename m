Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB5520193
	for <e@80x24.org>; Wed,  2 Nov 2016 23:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757282AbcKBXRf (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 19:17:35 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33258 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756975AbcKBXRe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 19:17:34 -0400
Received: by mail-pf0-f170.google.com with SMTP id d2so19676591pfd.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3eqLT9hqUI74r1pHUlrX195zKCbsQYAEQZRe+5PZ9Oo=;
        b=KaQGoAcD0m0AZQpsIWcaa9zKPbThQVVoHABqHfiBwu7UjKIp6lEkwYcwPZVm0ap/jp
         fiJpk6bKBTxBTnIr5bhRCTdWu1JizxfTV1P2fGRmTMOsisEyXra/Fn8DJLCm9WYnZWz0
         ODFcQPA6j+wBucpiytq793xwGahDfJXfiOjOJtl7O1ddVUiWhkQgL72XT6WJJlFhFTFM
         vMilHNLVMYoQ66k6AewYe8XaiAXUh7jTLbZKDPbybteBCFZUgnmRfmpbOYaYKYE+Jrdu
         ijkBUEbegoV7F3kuKj0FAt2/swBJvWyEqHpgXxQHWsOTJaKwjdeDsYSy5KrHqZ+vUu2L
         3okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3eqLT9hqUI74r1pHUlrX195zKCbsQYAEQZRe+5PZ9Oo=;
        b=hFImT97eIJ1WWfZYm1d/wE6kxAfS3uw5tZbzcxpv2eU5ySXRAnm2NkqyCkmI+KewRj
         O6uF043eCv5k81h0jW69cinVIPRhaONo2AqL7C2YXxav27PNAsd0ORS1ueYc2NUJmABu
         ySUnjRvXp9zQBu7tCeGMgPcC/rU7DQ7CHwlKoVG2b21cHXlQlO0GosCAtN6ARGNtjGTs
         dU7bUuwxl7XIBYcpFFdSyvBxXG6xbUY70O1zn+f4BohPAIdenkGHXfVu+aEwiDuZeB3m
         1EO4C71t6jnkZXJ7t6xQerSCXXqldfKREshKsoK4YS/szVcxYOBkpr0kElrTnK2tpIHh
         TkTQ==
X-Gm-Message-State: ABUngvdQwZL7Vcsx7r0mMaxV+Z87TMcT85hcBpt4UsHxLA5tAS5jjCgfX05EXRad08l6eiOM
X-Received: by 10.98.108.4 with SMTP id h4mr11241059pfc.11.1478128653356;
        Wed, 02 Nov 2016 16:17:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b836:b884:f13a:bcf4])
        by smtp.gmail.com with ESMTPSA id yc7sm7243741pab.24.2016.11.02.16.17.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 16:17:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] submodule-config: clarify parsing of null_sha1 element
Date:   Wed,  2 Nov 2016 16:17:22 -0700
Message-Id: <20161102231722.15787-4-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.621.g399b625.dirty
In-Reply-To: <20161102231722.15787-1-sbeller@google.com>
References: <20161102231722.15787-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-submodule-config.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index 81921e477b..1df7a827ff 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -55,8 +55,11 @@ Functions
 
 	The same as above but lookup by name.
 
-If given the null_sha1 as commit_sha1 the local configuration of a
-submodule will be returned (e.g. consolidated values from local git
+Whenever a submodule configuration is parsed in `parse_submodule_config_option`
+via e.g. `gitmodules_config()`, it will be overwrite the entry with the sha1
+zeroed out.  So in the normal case, when HEAD:.gitmodules is parsed first and
+then overlayed with the repository configuration, the null_sha1 entry contains
+the local configuration of a submodule (e.g. consolidated values from local git
 configuration and the .gitmodules file in the worktree).
 
 For an example usage see test-submodule-config.c.
-- 
2.10.2.621.g399b625.dirty

