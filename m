Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC9EB1FEEF
	for <e@80x24.org>; Tue, 22 Nov 2016 01:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbcKVBgH (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 20:36:07 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36691 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbcKVBgC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 20:36:02 -0500
Received: by mail-pg0-f48.google.com with SMTP id f188so1467161pgc.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 17:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CJTrpILqIAObPlWnF0sNpGOJXerr+mKQYoufpc4C1u0=;
        b=miLB0OgBckj9k6Pu8xNphFYs9DRobsw2CnHEeXUYVeeTl+r8BWPFk8tjvxUwJ93Wfh
         B6ywZjE/vlGjsnUFfb2h1ej3BBipZIErOkyJ464qaTwu8HYLVP+kcUCG07WbMlSxQ8NX
         ghc+YXIs/jMtp/nLilw8+IbsFGJ59gMX+FwAZJJwOfPTR91s1kq2klSIh+5MV04/quPL
         08HW1fXYLOcPUjwZIwvnuQ+K1PXztyTpfbJZ6seaYePTSVYn7+dYh4AWJRK+j9NDlYB8
         baIJWZIpdSzAEHfsblmoj7dLa5uShhViKo9N/oYeqXywsyHfjLCzCUAAonOFHmi6y75x
         XLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CJTrpILqIAObPlWnF0sNpGOJXerr+mKQYoufpc4C1u0=;
        b=UQYLBL6PeFjCN3wA4caCHZJUnaxFQqIdYy3yhkoxMkkO5XyFnSxw2m89ubL5RLbKyN
         bQPNeVymHYbmWBhKz7Pi2YD2bWMgu3vaseQwLx7nfCslCFE4DSono/EVcQHCBk45rf1h
         vlUb37nsWxED09DLCBY+fi0bHjL+/l//5uwTmrIm9rBJdsSA2ZNEXBiPVW1sRpIQG1IY
         +UeG5TE9WHrusgKPCJfhyAAnv/ugyHRu9AAzHqLWckYvKkPOP0PN1g/41ApBxXlTWxH9
         nTC3tkvhOit5rrsyMZgX0nWh5tx7CFRqEPhPTCbHFLay+i97V3EyUG1xY1HaLlHrWzNX
         fxRw==
X-Gm-Message-State: AKaTC03XeczJMgfumqHsu+3KB5429Dn/PEdNqScW7AI+vrRVHItyj9DBvESYf97jyj7P/Vm/
X-Received: by 10.99.167.15 with SMTP id d15mr38352135pgf.167.1479778562049;
        Mon, 21 Nov 2016 17:36:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1d4e:2913:1c16:dc05])
        by smtp.gmail.com with ESMTPSA id p25sm40233465pfk.20.2016.11.21.17.36.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 17:36:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 3/3] submodule-config: clarify parsing of null_sha1 element
Date:   Mon, 21 Nov 2016 17:35:50 -0800
Message-Id: <20161122013550.1800-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.18.g0126045.dirty
In-Reply-To: <20161122013550.1800-1-sbeller@google.com>
References: <20161122013550.1800-1-sbeller@google.com>
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
index 768458580f..e06a3fd2de 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -55,8 +55,11 @@ Functions
 
 	The same as above but lookup by name.
 
-If given the null_sha1 as commit_or_tree the local configuration of a
-submodule will be returned (e.g. consolidated values from local git
+Whenever a submodule configuration is parsed in `parse_submodule_config_option`
+via e.g. `gitmodules_config()`, it will be overwrite the null_sha1 entry.
+So in the normal case, when HEAD:.gitmodules is parsed first and then overlayed
+with the repository configuration, the null_sha1 entry contains the local
+configuration of a submodule (e.g. consolidated values from local git
 configuration and the .gitmodules file in the worktree).
 
 For an example usage see test-submodule-config.c.
-- 
2.11.0.rc2.18.g0126045.dirty

