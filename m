Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F0F41FEEE
	for <e@80x24.org>; Mon, 21 Nov 2016 23:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754864AbcKUX1T (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 18:27:19 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33188 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754655AbcKUX1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 18:27:15 -0500
Received: by mail-pg0-f45.google.com with SMTP id 3so441142pgd.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 15:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lmQPkCQkpoo/L8VS69/ZDB9I9iuFx/xaFbZV+C69LJ8=;
        b=boZ1t0XYd4kgG005iriHdRd1JQlrYm0oVA2gIqUfAZDS2vTM9Djwj92FmrCDYOYbk5
         vvQnF1Mch+mz4rWHtw5IazwzdLRKFuNIWJcW/iEL1zge0CS/nHYreDb0vHo/LULql7yV
         YckctSJkY+NbdrxNBbfozyMxM84wm4acvcuLmQ62dzmI3JB+5GrRCkFT/d9PIWBYi0HY
         i3NwZEhnP0+av94ndLfR/Fcvrtgt46XA7fQk8ZgU7vjGKA76RE5orgbdjmACycrM6YN/
         /sdd1ULve/Yi4RH3Dzeh9qlSstumM5zXJ0BI9iX/MopXgAygBwe+yiLiIYDZKauJIW5t
         dAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lmQPkCQkpoo/L8VS69/ZDB9I9iuFx/xaFbZV+C69LJ8=;
        b=c+rQFW08tC7jcMUoRhqDl4ncoexVfReMpsONvpSMwFvZU9TS62x2uR/4KVawaojH59
         n14YqOaPd3IhM0ODSt6DvMWSiSTctbvo8jTrJCipIzIDy7YP/Z//t8Xpt6faiJjmgCcG
         69T2CE0saVEa8rLs0Hr4658BV6fVEJhcqVTbR1ieC07zTxmtX3s0wyfv8Kgwup00jWVh
         qbnZVq7JzgU9OX+hFpLXVZNRGJpfKqoTbcOINzxNcWNHqdmyKJWUfoKW2gtYJ2nCHQZc
         t5QXf1U/z4XJlp28dHSpe9UYMn/3VJCG1yBLk+E0V6XUKUMZM5weoo4awXSDDWVqKGo7
         +L0g==
X-Gm-Message-State: AKaTC02dP2kI04hSzcSYgzjn9Dul02puWtFypOhucCue1PDrb6QtX3Y9mxA7tYmhflWwP5O7
X-Received: by 10.98.16.7 with SMTP id y7mr21430551pfi.55.1479770834694;
        Mon, 21 Nov 2016 15:27:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1d4e:2913:1c16:dc05])
        by smtp.gmail.com with ESMTPSA id j190sm21802825pgd.23.2016.11.21.15.27.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 15:27:14 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     bmwill@google.com, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/3] submodule-config: clarify parsing of null_sha1 element
Date:   Mon, 21 Nov 2016 15:27:09 -0800
Message-Id: <20161121232709.8906-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.18.g0126045.dirty
In-Reply-To: <20161121232709.8906-1-sbeller@google.com>
References: <20161121232709.8906-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-submodule-config.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index 768458580f..a91c1f085e 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -55,8 +55,11 @@ Functions
 
 	The same as above but lookup by name.
 
-If given the null_sha1 as commit_or_tree the local configuration of a
-submodule will be returned (e.g. consolidated values from local git
+Whenever a submodule configuration is parsed in `parse_submodule_config_option`
+via e.g. `gitmodules_config()`, it will be overwrite the entry with the sha1
+zeroed out.  So in the normal case, when HEAD:.gitmodules is parsed first and
+then overlayed with the repository configuration, the null_sha1 entry contains
+the local configuration of a submodule (e.g. consolidated values from local git
 configuration and the .gitmodules file in the worktree).
 
 For an example usage see test-submodule-config.c.
-- 
2.11.0.rc2.18.g0126045.dirty

