Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85C5C1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 02:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfICCWD (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 22:22:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36072 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfICCWD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 22:22:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id p13so16329607wmh.1
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 19:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vIEJ+JGJrWGS+PfSCY2eGUAJKB07AkGucdK7N2NB5sI=;
        b=Ol+sz/BmxIdz5v4+Blw1xLivELc9NoVn9aOeLHN0RZx1er0gDmWY5KjwkE6/kFrmT9
         vYHvYiWns4gjjC5yImSiffVJ2TxddmMEFJAA2z7Zwy+KtK0KsqwLMJUXHSM6omCIuYhu
         lM0VnU2sdFaphCfm9PwFI9cgogPocsQW6afUEB8P4Tau6knNiDqpZp1w8FkRYfJsb4BA
         KYiL/WFDFq0uX6MhxSLgCpMjNeVnjWOES+Jo9dT2eI8IPLS/Qtyyvdb41fpaTngzrEsr
         QGlvzNSMeqQbQ+YOABvgD0q8K0ZZ5iupSzdIQvIb+87Nlf8w1Qme8pG+lN5LkPJzhOL3
         5yMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vIEJ+JGJrWGS+PfSCY2eGUAJKB07AkGucdK7N2NB5sI=;
        b=p/zyQq0nnKilwuks6xFkvcKnCrWAOaieQI5ZfH9WKzuvl+g6QL9hCOodZ9CRDeJdza
         XYC7hcRo46v2LbCQWgXatNHgBcNTNr6LpQuQ71TUzZhll4phrAiycVxBWJZC7WizU7Of
         4y+5uqXvWdWpryDeXRGv8uFEF/xD1NhZysX1572OdMdwYecs0ehNUlcr2fgoR1bKwMlY
         Usl4yd66KU96giF9cMq2xTiArivRFwMTWbdmsBHcts4P1IhEctap1dnYHq1TTu1OD0ID
         zwIuUjTmQNDWGPp1QRFBXjZNCkJ28+9htCDG6oQUi03/p/l4ywh3RgDeMfVurSdR0Cjf
         KlxQ==
X-Gm-Message-State: APjAAAXCq0HgOpvdpSCBJ3CW+XKg7fWdkifKAczhkhIKz9mqhUtff/fN
        5vw4RqDl8KmagfORr2dsP2i4IbNF
X-Google-Smtp-Source: APXvYqyBsulFUzGy4F4r3gueJIQPKQlmkTaAiH2wy5uL7QFBEbPN0I5oG3E79ilxjeAks3SQNxjxuw==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr40582027wmh.81.1567477321862;
        Mon, 02 Sep 2019 19:22:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14sm9897056wmk.21.2019.09.02.19.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 19:22:01 -0700 (PDT)
Date:   Mon, 02 Sep 2019 19:22:01 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Sep 2019 02:21:59 GMT
Message-Id: <pull.328.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Write commit-graph on fetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, garimasigit@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of waiting for a non-trivial GC command to write the commit-graph,
write one during 'git fetch'. By using the equivalent method for 'git
commit-graph write --split --reachable', we create a commit-graph chain that
includes all reachable commits. Most of the time, these writes only add the
newly-downloaded commits in a small file at the top of the commit-graph
chain. Commits that are no longer reachable still exist in the commit-graph,
but will be cleaned up by a later GC command that forces the commit-graph to
be rewritten completely.

A version of this patch [1] used to be a part of
ds/commit-graph-incremental, but was removed to focus on the incremental
commit-graph file format. Now that the incremental file format has been
shipped in v2.23.0 and some config things have adjusted in
ds/feature-macros, I'm reintroducing the idea.

Ævar had mentioned wanting to do something with "incremental maintenance
during GC" [2]. I haven't seen any patches towards that aim (please point me
in that direction if they have been submitted). I still think it is worth
allowing a write at fetch time, as some users have GC disabled. I know for
sure that users who only interact with their Git repos via Visual Studio
Team Explorer have all Git commands running with GC disabled, and likely
other desktop GUI clients have it disabled to avoid blocking processes.

Aside: VFS for Git users have GC disabled, but the commit-graph is being
written in the background by a monitoring process. We shipped the
incremental commit-graph writes in a recent version and reduced our writes
from ~60 seconds each to less than a second on average. Very rarely, the
layers of the commit-graph chain collapse and return to the old values. This
feature has been performing well with no known issues.

Thanks, -Stolee

[1] 
https://public-inbox.org/git/3c52385e5696887c40cab4a6b9b7923d60a0567c.1557330827.git.gitgitgadget@gmail.com/

[2] 
https://public-inbox.org/git/b1de6af2-c015-098e-a656-e1b68056e037@gmail.com/

Derrick Stolee (1):
  fetch: add fetch.writeCommitGraph config setting

 Documentation/config/feature.txt |  8 ++++++++
 Documentation/config/fetch.txt   | 10 ++++++++++
 builtin/fetch.c                  | 15 +++++++++++++++
 repo-settings.c                  |  4 ++++
 repository.h                     |  1 +
 t/t5510-fetch.sh                 | 13 +++++++++++++
 6 files changed, 51 insertions(+)


base-commit: aaf633c2ad10b47af7623c130ddfe7231658c7e4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-328%2Fderrickstolee%2Ffetch-write-commit-graph-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-328/derrickstolee/fetch-write-commit-graph-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/328
-- 
gitgitgadget
