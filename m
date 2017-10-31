Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 816861FAED
	for <e@80x24.org>; Tue, 31 Oct 2017 00:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbdJaAe3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 20:34:29 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:50878 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753722AbdJaAeF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 20:34:05 -0400
Received: by mail-io0-f195.google.com with SMTP id 97so31320916iok.7
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 17:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e0RIBeRodSl7SThuNXST8StLsMyieXD+YpYSVDHXtNA=;
        b=ZqK0/kd+QklQ1gT+cb0FVFXeFBgsCfUYOykLly2uVP3v+x/rXdNJI3jKpS8pYgXY8e
         6CNIrCnyxqt4NvY6dcGuRQ4p5UnsKB1AICGPgTpZ+l+F+ESogL4c/YWNu6bXXawDzzcQ
         uov+xPXmesRS6noZkdlh6HuxWZo0udTX6eP/+PkWLV3XN5CkP9I7rpSrIIpLTbcYy4PO
         Xxs00OOkYLzXQtmQANTns2S1q4IbJWb900/pUMjyNgsvbFR61u7bL7ObCN3F9BrRWLlW
         BCu143HuY7IOkICuPrbnSXJl/F/ucQOgc0HeufpoM8eUQ6VYo+FtVpXwCN2OVB0fSjih
         LSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e0RIBeRodSl7SThuNXST8StLsMyieXD+YpYSVDHXtNA=;
        b=Na1kWGuCNiGvU93uMNa9rGNhpDlbPHj1HH6E1ceXRuJlRMABdDTCpHJ2TooojSUdSN
         UTV9H4bNDwoK5d5w6Ngp85CqDEUhNRhyU1a8LleWHLc/BObeJ7MX/dyIfrcLBwlAk3Cb
         N3RJEs6NeeI7L/C4p0PbnBm3fmUybqfB1jM1ycPC+h/MkGieflpvNPxnN4WdgpekDDVR
         JbANwQiqWzoZwyaVrIIX1OP09v9cNb0PlYEK5Y7+luoBgPDmXoMzCBwSBkSlJIDALw8n
         khARq1E+Y9M4l7cpT9q9OTpEDUYME/ksnyg3FyzorSsrOriVxA9VSQ4Xfu13J9n6F+38
         RcXA==
X-Gm-Message-State: AMCzsaW5CoyeKn71/v4tEC9Ule6YHA1SbHciHrjeNlvb6R/y/TnOPCsp
        ZCB8C8VRKoAigh55kkGI6oDorw==
X-Google-Smtp-Source: ABhQp+TeKQ8E2jl7e3dqONV2BAB7bRYjVYnxDv8ou6pIxqXcklArmSq3p9tNzLcYFxCxU8lkRdzWzQ==
X-Received: by 10.36.55.210 with SMTP id r201mr726150itr.132.1509410044272;
        Mon, 30 Oct 2017 17:34:04 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:58cb:1473:3cb:a95f])
        by smtp.gmail.com with ESMTPSA id i130sm245205itf.42.2017.10.30.17.34.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 17:34:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH 3/7] builtin/describe.c: rename `oid` to avoid variable shadowing
Date:   Mon, 30 Oct 2017 17:33:47 -0700
Message-Id: <20171031003351.22341-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171031003351.22341-1-sbeller@google.com>
References: <20171028004419.10139-1-sbeller@google.com>
 <20171031003351.22341-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function `describe` has already a variable named `oid` declared at
the beginning of the function for an object id.  Do now shadow that
variable with a pointer to an object id.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/describe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 29075dbd0f..fd61f463cf 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -381,9 +381,9 @@ static void describe(const char *arg, int last_one)
 	}
 
 	if (!match_cnt) {
-		struct object_id *oid = &cmit->object.oid;
+		struct object_id *cmit_oid = &cmit->object.oid;
 		if (always) {
-			printf("%s", find_unique_abbrev(oid->hash, abbrev));
+			printf("%s", find_unique_abbrev(cmit_oid->hash, abbrev));
 			if (suffix)
 				printf("%s", suffix);
 			printf("\n");
@@ -392,11 +392,11 @@ static void describe(const char *arg, int last_one)
 		if (unannotated_cnt)
 			die(_("No annotated tags can describe '%s'.\n"
 			    "However, there were unannotated tags: try --tags."),
-			    oid_to_hex(oid));
+			    oid_to_hex(cmit_oid));
 		else
 			die(_("No tags can describe '%s'.\n"
 			    "Try --always, or create some tags."),
-			    oid_to_hex(oid));
+			    oid_to_hex(cmit_oid));
 	}
 
 	QSORT(all_matches, match_cnt, compare_pt);
-- 
2.15.0.rc2.443.gfcc3b81c0a

