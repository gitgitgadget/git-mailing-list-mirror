Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AADE1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbeFHWm0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37149 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753260AbeFHWmN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id r125-v6so6247760wmg.2
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o86v17yX/rrhZoapMbqR50SOZ66KyeTiV0zWdEvxo2E=;
        b=cYlwK3mQ/vwrix9iDQAFK9rF0J1Sl13JtPk560RA5HMhdjj8xoaB2cKkW1OOO+j3EO
         s8o9Gm8+beeBb8tiXfMDWO/TOSX+clKe308zR9YM8HCBleBOiRZrVRL8TkZky74BIR+i
         MKoy4RgPPpc5gX9AxNqTQ4LX6KFZESjuQhDUqRTnjgYRlFyKRcRWVPl6O+rNKyt53wja
         h8BBDX0proc76bj10ehH8Ao+yPWjAY1+4Z7UhSoc7I5kUmLZw3Sl/iA7LTM378A+uuI8
         mayH1L8tXjfrSwSOY2KGPnWGjlNkp5kg8PjjlwjaTZXtSQI1GBd8hgIALj7kqYT/0rfD
         pxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o86v17yX/rrhZoapMbqR50SOZ66KyeTiV0zWdEvxo2E=;
        b=bAiLA65pPJhFXO074jbzk8MKnnrbAk4hb+uU/HBNe34iYSitlF5D+NEtx9ENodco7q
         BRfy8mE6NiJuH4P/ToDgZPW5pzVHoEOE8xNqnYFyuTPIsILBuYeMlEByobwwvjf/T3mg
         u46drF0CfJRrHy6lAhlfkbYceijv9kpQlqon/2rS1lhK1QZHd1mTfHWbojyWs016/+UD
         mKo4QZt3Yc3rrUM1pCvedk/rAHQirRBYcwXQCRExOH0nNo21ejcOLcVEkC9/LsarIw5S
         naMRaFDnLPY/8WmoY4oC/mUS2oW+cVXN06oSIhva2SAYzM8aG4Aa9U8T4pvJY+RwZxxZ
         dbTQ==
X-Gm-Message-State: APt69E0K9t0gho3niS/NmM8bAI6rNUcDrIYAUHuSkj47S2t17PyCj10g
        QRM5PJ6u3L7D1mBS9JzFzvSelmNb
X-Google-Smtp-Source: ADUXVKJ/nvEusOkVqGDuUIHQhrXxDABc6CBrAm7YM6MTW7IpE0oDVKJsfGKuvtUGRC09oTmH2IJoPQ==
X-Received: by 2002:a1c:4405:: with SMTP id r5-v6mr2427757wma.62.1528497731869;
        Fri, 08 Jun 2018 15:42:11 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:42:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 18/20] abbrev parsing: use braces on multiple conditional arms
Date:   Fri,  8 Jun 2018 22:41:34 +0000
Message-Id: <20180608224136.20220-19-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180608224136.20220-1-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust this code that'll be modified in a subsequent change to have
more than one line per branch to use braces per the CodingGuidelines,
this makes the later change easier to understand.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c     | 5 +++--
 revision.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index cab79d24ab..e0141cfbc0 100644
--- a/diff.c
+++ b/diff.c
@@ -4807,10 +4807,11 @@ int diff_opt_parse(struct diff_options *options,
 		options->abbrev = strtoul(arg, &end, 10);
 		if (*end)
 			die("--abbrev expects a numerical value, got '%s'", arg);
-		if (options->abbrev < MINIMUM_ABBREV)
+		if (options->abbrev < MINIMUM_ABBREV) {
 			options->abbrev = MINIMUM_ABBREV;
-		else if (the_hash_algo->hexsz < options->abbrev)
+		} else if (the_hash_algo->hexsz < options->abbrev) {
 			options->abbrev = the_hash_algo->hexsz;
+		}
 	}
 	else if ((argcount = parse_long_opt("src-prefix", av, &optarg))) {
 		options->a_prefix = optarg;
diff --git a/revision.c b/revision.c
index d39a292895..2a75fef22d 100644
--- a/revision.c
+++ b/revision.c
@@ -2053,10 +2053,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->abbrev = strtoul(optarg, &end, 10);
 		if (*end)
 			die("--abbrev expects a numerical value, got '%s'", optarg);
-		if (revs->abbrev < MINIMUM_ABBREV)
+		if (revs->abbrev < MINIMUM_ABBREV) {
 			revs->abbrev = MINIMUM_ABBREV;
-		else if (revs->abbrev > hexsz)
+		} else if (revs->abbrev > hexsz) {
 			revs->abbrev = hexsz;
+		}
 	} else if (!strcmp(arg, "--abbrev-commit")) {
 		revs->abbrev_commit = 1;
 		revs->abbrev_commit_given = 1;
-- 
2.17.0.290.gded63e768a

