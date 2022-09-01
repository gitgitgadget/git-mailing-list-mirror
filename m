Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6421ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 22:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiIAWkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiIAWkF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 18:40:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE67DDE92
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 15:40:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u18so131183wrq.10
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 15:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=MdhWoBMsuyG7iCe9BxXfdroz7Oy34kbx1EYw6HrMDgA=;
        b=dn+RMNOd09qAmYa70+a2zNqhH4+Jg0PoWfoycFxh4RtzYEXaoH9vWwEPP0ZHWU9A0m
         DFUXI4IzTasFVLth4y2UbOxWsx5OxtJFT2UHU3HLhi8XVCaRkmXGqhWAhBrSlgMJo/v2
         2lBsQ6dG8IAW13h9zhNfMNxvRhZCFEC1jZqcNBfqzslLjLVxYaD55w4zxFJxhxuZEM4r
         PF+4KXKcdWbGlkai/hdmQI6wPuhKp8NhedW/gCieHt4ZBwV6t1taOptilo5S5FYeTtNQ
         8fT66f/bTs1S6RUCLtzqFX2ifeC2zauIwti5Jnr0+kTOLqFxfqPvgPsDhG+p2oRIcXkJ
         toqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=MdhWoBMsuyG7iCe9BxXfdroz7Oy34kbx1EYw6HrMDgA=;
        b=ywAsLN5hy6rgWHcHBnm66P0nKX0FOE66yosXae9YpTO2d0rFI3fzStxg9cOfl/wb/D
         TvGS6HQiYYvjZi93qeiU8CnBySBG+WKZTTwh9rQgtEg36qRUqmml+b91fRzTjLTNaze+
         PFQ/IgQUg14oGbxlesNDJlcdwuWRm5gE92hxBQK01i2IG12WoJN9TPYoWPVJGWg9g/CL
         v12JDHaHnaNEeoDYoqnfLLBL5O3Z25IYfzvKtvs/krYZh/xM7kJNOX0DOX+CKiR0FWFo
         kFiMbpdNI53Kb6NjiJBpHU4QybSzd+XbsMGKn99fFwVgOJAYWkRW0kPozvbGNoL6UFZB
         GjfA==
X-Gm-Message-State: ACgBeo2fUFdTsIYvdIKPtJC+8N1QvfJMhZkQL2zlc8A/+Ze5XXAfeJFJ
        3MOVtiq4DaWJF+wj6QuksOT6BiEgfDM=
X-Google-Smtp-Source: AA6agR7Diwdn8wZfvISjAEXjQVsrv33IN1Uj7Piv4hMEo3nwIfZ3HHuEo3uKXLbuQM52Mop8kOqyFQ==
X-Received: by 2002:a5d:4d12:0:b0:226:d878:e096 with SMTP id z18-20020a5d4d12000000b00226d878e096mr13310291wrt.377.1662072000158;
        Thu, 01 Sep 2022 15:40:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9-20020adff189000000b00226d01a4635sm72768wro.35.2022.09.01.15.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:39:59 -0700 (PDT)
Message-Id: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
From:   "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 22:39:58 +0000
Subject: [PATCH] embargoed releases: also describe the git-security list and
 the process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     git-security@googlegroups.com, Julia Ramer <gitprplr@gmail.com>,
        Julia Ramer <gitprplr@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Julia Ramer <gitprplr@gmail.com>

With the recent turnover on the git-security list, questions came up how
things are usually run. Rather than answering questions individually,
extend Git's existing documentation about security vulnerabilities to
describe the git-security mailing list, how things are run on that list,
and what to expect throughout the process from the time a security bug
is reported all the way to the time when a fix is released.

Signed-off-by: Julia Ramer <gitprplr@gmail.com>
---
    embargoed releases: also describe the git-security list and the process

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1345%2Fprplr%2Fupdate_embargo_doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1345/prplr/update_embargo_doc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1345

 .../howto/coordinate-embargoed-releases.txt   | 143 +++++++++++++++---
 1 file changed, 122 insertions(+), 21 deletions(-)

diff --git a/Documentation/howto/coordinate-embargoed-releases.txt b/Documentation/howto/coordinate-embargoed-releases.txt
index 601aae88e9a..43400fd6025 100644
--- a/Documentation/howto/coordinate-embargoed-releases.txt
+++ b/Documentation/howto/coordinate-embargoed-releases.txt
@@ -1,6 +1,121 @@
 Content-type: text/asciidoc
-Abstract: When a critical vulnerability is discovered and fixed, we follow this
- script to coordinate a public release.
+Abstract: When a vulnerability is reported, we follow these guidelines to
+ assess the vulnerability, create and review a fix, and coordinate embargoed
+ security releases.
+
+The `git-security` mailing list
+===============================
+
+Responsible disclosures of vulnerabilities, analysis, proposed fixes as
+well as the orchestration of coordinated embargoed releases all happen on the
+`git-security` mailing list at <git-security@googlegroups.com>.
+
+In this context, the term "embargo" refers to the time period that information
+about a vulnerability is kept under wraps and only shared on a need-to-know
+basis. This is necessary to protect Git's users from bad actors who would
+otherwise be made aware of attack vectors that could be exploited. "Lifting the
+embargo" refers to publishing the version that fixes the vulnerabilities.
+
+Audience of the `git-security` mailing list
+-------------------------------------------
+
+Anybody may contact the `git-security` mailing list by sending an email
+to <git-security@googlegroups.com>, though the archive is closed to the
+public and only accessible to subscribed members.
+
+There are a few dozen subscribed members: core Git developers who are trusted
+with addressing vulnerabilities, and stakeholders (i.e. owners of products
+affected by security vulnerabilities in Git).
+
+Most of the discussions revolve around assessing the severity of the reported
+bugs (including the decision whether the report is security-relevant or can be
+redirected to the public mailing list), how to remediate the bug, determining
+the timeline of the disclosure as well as aligning priorities and
+requirements.
+
+Communications
+--------------
+
+If you are a stakeholder, it is a good idea to pay close attention to the
+discussions, as pertinent information may be buried in the middle of a lively
+conversation that might not look relevant to your interests. For example, the
+tentative timeline might be agreed upon in the middle of discussing code
+comment formatting in one of the patches and whether or not to combine fixes
+for multiple, separate vulnerabilities into the same embargoed release. Most
+mail threads are not usually structured specifically to communicate
+agreements, assessments or timelines.
+
+A bug's life: Typical timeline
+==============================
+
+- A bug is reported to the `git-security` mailing list.
+
+- Within a couple of days, someone from the core Git team responds with an
+  initial assessment of the bug’s severity.
+
+- Other core developers - including the Git maintainer - chime in.
+
+- After discussion, if consensus is reached that the bug is not critical enough
+  to warrant any embargo, the reporter is redirected to the public Git mailing
+  list. This ends the reporter's interaction with the `git-security` list.
+
+- If the bug is critical enough for an embargo, ideas are presented on how to
+  address the vulnerability.
+
+- Usually around that time, the Git maintainer or their delegate(s) open a draft
+  security advisory in the `git/git` repository on GitHub (see below for more
+  details).
+
+- Depending on the preferences of the involved contributors and reviewers, code
+  review then happens either on the `git-security` mailing list or in a private
+  fork associated with the draft security advisory.
+
+- Once the review has settled and everyone involved in the review agrees that
+  the patches are ready, the Git maintainer determines a release date as well
+  as the release trains that are serviced. The decision regarding which versions
+  need a backported fix is based on input from the reporter, the contributor who
+  worked on the patches, and from stakeholders (e.g. operators of hosting sites
+  who may want to analyze whether the given bug is exploited via any of the
+  repositories they host).
+
+- Subsequently, branches with the fixes are pushed to private repositories that
+  are owned by the Git project, with tightly controlled access.
+
+- The tags are created by the Git maintainer and pushed to the same
+  repositories.
+
+- Less than a week before the release, a mail with the relevant information is
+  sent to <distros@vs.openwall.org> (see below), a list used to pre-announce embargoed
+  releases of open source projects to the stakeholders of all major Linux
+  distributions. This includes a Git bundle of the tagged version(s), but no
+  further specifics of the vulnerability.
+
+- Public communication is then prepared in advance of the release date. This
+  includes blog posts and mails to the Git and Git for Windows mailing lists.
+
+- The Git for Windows maintainer prepares the corresponding release artifacts,
+  based on the tags created that have been prepared by the Git maintainer.
+
+- Git for Windows release artifacts are made available under embargo to
+  stakeholders via a mail to the `git-security` list.
+
+- On the day of the release, at around 10am Pacific Time, the Git maintainer
+  pushes the tag and the `master` branch to the public repository, then sends
+  out an announcement mail.
+
+- Once the tag is pushed, the Git for Windows maintainer publishes the
+  corresponding tag and creates a GitHub Release with the associated release
+  artifacts (Git for Windows installer, Portable Git, MinGit, etc).
+
+- Git for Windows release is then announced via a mail to the public Git and
+  Git for Windows mailing lists as well as via a tweet.
+
+- A mail to <oss-security@lists.openwall.org> (see below for details) is sent as a
+  follow-up to the <distros@vs.openwall.org> one, describing the vulnerability in
+  detail, often including a proof of concept of an exploit.
+
+Note: The Git project makes no guarantees about timelines, but aims to keep
+embargoes reasonably short in the interest of keeping Git's users safe.
 
 How we coordinate embargoed releases
 ====================================
@@ -14,30 +129,16 @@ what Operating System or distribution they run.
 Open a Security Advisory draft
 ------------------------------
 
-The first step is to https://github.com/git/git/security/advisories/new[open an
-advisory]. Technically, it is not necessary, but it is convenient and saves a
-bit of hassle. This advisory can also be used to obtain the CVE number and it
-will give us a private fork associated with it that can be used to collaborate
-on a fix.
-
-Release date of the embargoed version
--------------------------------------
-
-If the vulnerability affects Windows users, we want to have our friends over at
-Visual Studio on board. This means we need to target a "Patch Tuesday" (i.e. a
-second Tuesday of the month), at the minimum three weeks from heads-up to
-coordinated release.
-
-If the vulnerability affects the server side, or can benefit from scans on the
-server side (i.e. if `git fsck` can detect an attack), it is important to give
-all involved Git repository hosting sites enough time to scan all of those
-repositories.
+The first step is to https://github.com/git/git/security/advisories/new[open
+an advisory]. Technically, this is not necessary. However, it is the most
+convenient way to obtain the CVE number and it give us a private repository
+associated with it that can be used to collaborate on a fix.
 
 Notifying the Linux distributions
 ---------------------------------
 
 At most two weeks before release date, we need to send a notification to
-distros@vs.openwall.org, preferably less than 7 days before the release date.
+<distros@vs.openwall.org>, preferably less than 7 days before the release date.
 This will reach most (all?) Linux distributions. See an example below, and the
 guidelines for this mailing list at
 https://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists[here].

base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
-- 
gitgitgadget
