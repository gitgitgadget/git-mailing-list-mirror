Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D36B1F461
	for <e@80x24.org>; Sun, 23 Jun 2019 20:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfFWUGE (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 16:06:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33591 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFWUGE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 16:06:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so6268766pfq.0
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wfwetWPcY0ifTB5OqiiOsCs1cIb+E7JAq6rJrad6EzI=;
        b=Vf0qYxdp9bd5OQynp4geN+1xOUwQgPz1BwGQgNJTmsnj+pCpDKgH7dwO0sYjQQxGdi
         3fEM4EVdvpxhXjTlY6JeOaO4P8CubXJRvy+fMKenAtzlE3s6rm0lUCCs/m4vrgj4O8r0
         tzaUkTXsv1oJTeSFgC3VPn7TDs6pk+hFdIsUOFRFS5o8GtDoJMtXL8UMUHiblRmrvfba
         dPAL4VcSCXdKRYagpbQEHkqJzVTfoubXN0Sd9IWkQogVKXf6wVShdDSBfUaptmvlPITQ
         gk8XoUMmuel9SHG4gs2+dI3ieb+21wvlr5M2t4nW6BaWK5PzuVri858QFWgSxpvkydKu
         AJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfwetWPcY0ifTB5OqiiOsCs1cIb+E7JAq6rJrad6EzI=;
        b=al3OO4STZo8SM3w1ZTHv+9yxOJaNzd0Q7Llk+51rO2a/bGul9IkqfIaGuPYb614hTH
         vLmifSshPWbyDLtt2xhtmeeNFxoIsaEVLnoDmvEj8VC5OEz+lzuY3dYh1AoeM+M8iv1n
         nVSKV7RTgN7oNBTrvF3ERNcsAEeGOrvnCIY+jLBOxSt0+oxv1FDYxi9Qm0YU98Al2g5t
         pdC2U4D/QC9LeV/bd3uBvCQbMFGbJgxmsTx6RqJpyVBxgAC9CTU3RMKa8viqs1BYULqt
         k0RpqDbIixqqS6946Ku2/ZDple5JwNSi3w60GcSVpitKKCN75e8ajGZRtmSPDecucuRZ
         4omw==
X-Gm-Message-State: APjAAAU7YzH4iEtNTIqrBcFzbSPbHYT9jrOdYKppczgyL+nOqOZfIJqm
        CJp+a6WlXNhREQVx9FDAyL8DZzzHQbo=
X-Google-Smtp-Source: APXvYqwwa7EvesFy/UQkzkKbVJ0neSoT/9gzEHbaHxhVg51PGKGRZ2WUFBkSJfIMop1PDoajDzYQDw==
X-Received: by 2002:a63:de50:: with SMTP id y16mr12965141pgi.431.1561320363479;
        Sun, 23 Jun 2019 13:06:03 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.213])
        by smtp.gmail.com with ESMTPSA id 27sm8621882pgt.6.2019.06.23.13.05.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 13:06:02 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [GSoC][PATCH v7 1/6] advice: add sequencerInUse config variable
Date:   Mon, 24 Jun 2019 01:33:33 +0530
Message-Id: <20190623200338.17144-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190623200338.17144-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190623200338.17144-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calls to advise() which are not guarded by advice.* config variables
are "bad" as they do not let the user say, "I've learned this part
of Git enough, please don't tell me what to do verbosely.". Add a
configuration variable "sequencerInUse" which controls whether to
display advice when any sequencer command is in progress.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/config/advice.txt | 2 ++
 advice.c                        | 2 ++
 advice.h                        | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index ec4f6ae658..1cd9096c98 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -57,6 +57,8 @@ advice.*::
 	resolveConflict::
 		Advice shown by various commands when conflicts
 		prevent the operation from being performed.
+	sequencerInUse::
+		Advice shown when a sequencer command is already in progress.
 	implicitIdentity::
 		Advice on how to set your identity configuration when
 		your information is guessed from the system username and
diff --git a/advice.c b/advice.c
index ce5f374ecd..b101f0c264 100644
--- a/advice.c
+++ b/advice.c
@@ -15,6 +15,7 @@ int advice_status_u_option = 1;
 int advice_commit_before_merge = 1;
 int advice_reset_quiet_warning = 1;
 int advice_resolve_conflict = 1;
+int advice_sequencer_in_use = 1;
 int advice_implicit_identity = 1;
 int advice_detached_head = 1;
 int advice_set_upstream_failure = 1;
@@ -71,6 +72,7 @@ static struct {
 	{ "commitBeforeMerge", &advice_commit_before_merge },
 	{ "resetQuiet", &advice_reset_quiet_warning },
 	{ "resolveConflict", &advice_resolve_conflict },
+	{ "sequencerInUse", &advice_sequencer_in_use },
 	{ "implicitIdentity", &advice_implicit_identity },
 	{ "detachedHead", &advice_detached_head },
 	{ "setupStreamFailure", &advice_set_upstream_failure },
diff --git a/advice.h b/advice.h
index e50f02cdfe..ebc838d7bc 100644
--- a/advice.h
+++ b/advice.h
@@ -15,6 +15,7 @@ extern int advice_status_u_option;
 extern int advice_commit_before_merge;
 extern int advice_reset_quiet_warning;
 extern int advice_resolve_conflict;
+extern int advice_sequencer_in_use;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
 extern int advice_set_upstream_failure;
-- 
2.21.0

