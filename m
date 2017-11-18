Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E0E201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 17:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424350AbdKRR14 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 12:27:56 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45926 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424344AbdKRR1y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 12:27:54 -0500
Received: by mail-pf0-f194.google.com with SMTP id 17so4205317pfn.12
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 09:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1k0ZWvZlxW7VmwfeyZBq36MX6qcryfB/c8OjJrnrEdg=;
        b=JgLNZJUkVFUF+YOjZ+3Y0aiZBbStacyE/Ef/HV9j2qINWfb75gbRhpyhExDoY2/3VU
         Xm0t1jtg632erJMmP2yYqVc4edQo7dL4AGfnKTgAyiqpmOQYCIu09H41OM/sOyfEPTwd
         v+sUDSAgYBMjfxuD9mtCpYTHH+Wtx4sjKwKF4AzPOBhqfqxIk1rrCz0bhLcc+c/C7k8f
         qxkWLB6Tr+1xIe3Ts2IotG/8xajozKoQ471hmf4YtOsg26kBYYO17LQPzMYKXNzu8rIW
         ZT54U+0vrPSVDr33klKLnLNuqIIAlFUfQOHEsYd4UE98ml9KgQrBmpFifCITu5BRDGsB
         ObpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1k0ZWvZlxW7VmwfeyZBq36MX6qcryfB/c8OjJrnrEdg=;
        b=aCHNxHeSQiSPnpFq4mBYxKihUAzVwppron0PN3ZLNbHjb8E0ogYVGzNlGreOn4haT3
         +K+rHNUkyet+sd4LiW3sYMpDrH4SpmoUNp3YeZ13Zz4t816XFZvCkZjstsdF8jdGCeZV
         rgQ61NbZ5fBOs59dQ37hqrSR6ErUTWokXzneSjX7Vgxgrbd/DLvHqKzmYXxjZI6i26d+
         QKvaOG9kQIVrrGszKctkFMTJBvybHIFFWPf5+a0wvU9Q8MVBvLZ0qNxhvBu7ZorpBt12
         PoJoLfLdgKqbrIU5rvRexC5Gfi2xUgSUf5rc8SvgfiJNgI9pgWF0yWAatoCRleHarP44
         XKqg==
X-Gm-Message-State: AJaThX4CKKhf0StRcFmI1jwemFK9XxXJ6m4WK54oNg67sfSUygJIJrcR
        pcF1KLMkkNMxroexfK2OaFTyufFX
X-Google-Smtp-Source: AGs4zMYC5rmAFB2x1V1JMZ8iA3bqiwB+rosThvSc1qWIgqe0dfwVocSZP6cgcvtKgGiz3j+4cgdKvQ==
X-Received: by 10.98.27.3 with SMTP id b3mr5872534pfb.159.1511026073982;
        Sat, 18 Nov 2017 09:27:53 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72c0:fc36:f2a4:a5ab:70fc:f807])
        by smtp.gmail.com with ESMTPSA id d12sm10479749pgt.16.2017.11.18.09.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Nov 2017 09:27:53 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/4] branch: improve documentation and naming of create_branch() parameters
Date:   Sat, 18 Nov 2017 22:56:45 +0530
Message-Id: <20171118172648.17918-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.291.g0d8980c5d
In-Reply-To: <20171118172648.17918-1-kaartic.sivaraam@gmail.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171118172648.17918-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for 'create_branch()' was incomplete as it didn't say
what certain parameters were used for. Further a parameter name wasn't
very communicative.

So, add missing documentation for the sake of completeness and easy
reference. Also, rename the concerned parameter to make its name more
communicative.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 branch.c | 4 ++--
 branch.h | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index 62f7b0d8c..3e8d2f93f 100644
--- a/branch.c
+++ b/branch.c
@@ -228,7 +228,7 @@ N_("\n"
 "\"git push -u\" to set the upstream config as you push.");
 
 void create_branch(const char *name, const char *start_name,
-		   int force, int reflog, int clobber_head,
+		   int force, int reflog, int clobber_head_ok,
 		   int quiet, enum branch_track track)
 {
 	struct commit *commit;
@@ -244,7 +244,7 @@ void create_branch(const char *name, const char *start_name,
 
 	if (validate_new_branchname(name, &ref, force,
 				    track == BRANCH_TRACK_OVERRIDE ||
-				    clobber_head)) {
+				    clobber_head_ok)) {
 		if (!force)
 			dont_change_ref = 1;
 		else
diff --git a/branch.h b/branch.h
index b07788558..cb6411f84 100644
--- a/branch.h
+++ b/branch.h
@@ -15,12 +15,17 @@
  *
  *   - reflog creates a reflog for the branch
  *
+ *   - clobber_head_ok allows the currently checked out (hence existing)
+ *     branch to be overwritten; without 'force', it has no effect.
+ *
+ *   - quiet suppresses tracking information
+ *
  *   - track causes the new branch to be configured to merge the remote branch
  *     that start_name is a tracking branch for (if any).
  */
 void create_branch(const char *name, const char *start_name,
 		   int force, int reflog,
-		   int clobber_head, int quiet, enum branch_track track);
+		   int clobber_head_ok, int quiet, enum branch_track track);
 
 /*
  * Validates that the requested branch may be created, returning the
-- 
2.15.0.291.g0d8980c5d

