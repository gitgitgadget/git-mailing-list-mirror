Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6139B20958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755470AbdCWNHI (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:07:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33800 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754013AbdCWNHD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:07:03 -0400
Received: by mail-wr0-f193.google.com with SMTP id y90so7323265wrb.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55ZHZJOaPv8yKwr6MnU1F0BP+6rdPfT8TRed4gmOdEk=;
        b=pmyTU6Ov//75xAXDSif/7rJlizxom5HoUC16gGm6Pz4rQJRwhDDbJu0CPtNDA84h9E
         DR49YNkmTSm4UzPPBkj1mUpfsUY+0E5hHQTR1lb/I7OELeVb1woyamiyRnhre4Gd/F0G
         nl2H1X1qX3ulQwcZjj1ZR+hBy3MLfFp2P1BwrE+zempXpmdeU+alKyH/OUgD8VOVZKCZ
         gIhMTSXQoz6D7B2jIN444lehX3WjZYvNE4pX6ITuKPa6ENKt+yEP58RKggsUg7qmW59l
         Dixo87SZIEmn8G37qm0RJb3bcvEZJ3EzeZ56Q+KYjbjgp7l4fmN67Jbus/Jl77iCJLCw
         2gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55ZHZJOaPv8yKwr6MnU1F0BP+6rdPfT8TRed4gmOdEk=;
        b=IueDCzWHk+vehQcGJXTBJ8fEmvhychqRIqHNmEQjfnwqUVcj3UOB2JsdKH5HOJePi9
         kYffzxFKzJN1AQ6K32xQSBS6zn6vHlMkgnXtnBpYxEXUKOdP1nArrZgUcq5DzNnOAVxe
         7I3pRv2mEM4oFTffV0ci5AtZIQYRPJb5N17l5VW4GpXqG/cWHnk9j3oDfStSAXK1Fr8U
         YafoSasLnVQUFqRBNcbZ+rEYdizs3iaNtJ4w/MtQrSEnr5m0qo0edn/SU9ERalrMXnhE
         YZYjwVty332XzYqljKAeoB2+7nh1AqjTlxt/h3cqFSjNGjoN5dcssHHqAKMHXm2vXnEa
         BxUw==
X-Gm-Message-State: AFeK/H0xStlDEaTfBfM23m6gGxzI3iHVsehxA9NFucqA6jjwadbC4vC8wb6qvDQkrBsS2w==
X-Received: by 10.223.154.199 with SMTP id a65mr1341245wrc.78.1490274421929;
        Thu, 23 Mar 2017 06:07:01 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:07:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 15/16] ref-filter: reflow recently changed branch/tag/for-each-ref docs
Date:   Thu, 23 Mar 2017 13:05:28 +0000
Message-Id: <20170323130529.11361-16-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reflow the recently changed branch/tag-for-each-ref
documentation. This change shows no changes under --word-diff, except
the innocuous change of moving git-tag.txt's "[--sort=<key>]" around
slightly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-branch.txt | 15 ++++++++-------
 Documentation/git-tag.txt    |  7 ++++---
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index e4b5d5c3e1..5e175ec339 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -10,9 +10,9 @@ SYNOPSIS
 [verse]
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
 	[--list] [-v [--abbrev=<length> | --no-abbrev]]
-	[--column[=<options>] | --no-column]
+	[--column[=<options>] | --no-column] [--sort=<key>]
 	[(--merged | --no-merged) [<commit>]]
-	[--contains [<commit]] [--no-contains [<commit>]] [--sort=<key>]
+	[--contains [<commit]] [--no-contains [<commit>]]
 	[--points-at <object>] [--format=<format>] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
@@ -36,11 +36,12 @@ as branch creation.
 
 With `--contains`, shows only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
-named commit), `--no-contains` inverts it. With `--merged`, only branches merged into the named
-commit (i.e. the branches whose tip commits are reachable from the named
-commit) will be listed.  With `--no-merged` only branches not merged into
-the named commit will be listed.  If the <commit> argument is missing it
-defaults to `HEAD` (i.e. the tip of the current branch).
+named commit), `--no-contains` inverts it. With `--merged`, only branches
+merged into the named commit (i.e. the branches whose tip commits are
+reachable from the named commit) will be listed.  With `--no-merged` only
+branches not merged into the named commit will be listed.  If the <commit>
+argument is missing it defaults to `HEAD` (i.e. the tip of the current
+branch).
 
 The command's second form creates a new branch head named <branchname>
 which points to the current `HEAD`, or <start-point> if given.
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 028a8ce4a9..3b018f40c8 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,9 +12,10 @@ SYNOPSIS
 'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [--contains <commit>] [--points-at <object>]
-	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
-	[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]
+'git tag' [-n[<num>]] -l [--contains <commit>] [--contains <commit>]
+	[--points-at <object>] [--column[=<options>] | --no-column]
+	[--create-reflog] [--sort=<key>] [--format=<format>]
+	[--[no-]merged [<commit>]] [<pattern>...]
 'git tag' -v [--format=<format>] <tagname>...
 
 DESCRIPTION
-- 
2.11.0

