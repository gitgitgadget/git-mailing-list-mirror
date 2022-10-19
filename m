Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19444C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 01:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJSBQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 21:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiJSBQG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 21:16:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E583DEF3E
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:16:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bk15so26549683wrb.13
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhKjnbZD+VkiyK7UQ12YdxOUkotZaF8tGM6wtcIh4vw=;
        b=my3GyGeSi9pmEOA1Bbh5IDZOk1rvfgSa9Vvb8ObH9rxmgdrJ0KOV8ajklsyeJq16m8
         aIMQ1z4nWjQ0DWZ7R5L0KmUu18YwZqRCcWg8+zT6huro5xlf4s3IyrPGuJENxQAoxRRA
         pghjmo04+6NXWW4tIVZqVVAo3m5w3ZH+9dzB+FY8Whd8sbJocXuDwQb6kCjC64yXLVm+
         hasjHwL6l/g7bWbysZ85WQdbpuzkGcAC06dKiYovwYELamoe2y8xlG0CVu/uH2JP5zX0
         8xKxdMsr1jaRKXy4xlc3EiAMJ2RSHHcYQBE4J0OuTHj1/j+jB7uhp1TVNauuXt4oWn3t
         j64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhKjnbZD+VkiyK7UQ12YdxOUkotZaF8tGM6wtcIh4vw=;
        b=JiQm5a9LKfiWfjf4JcBUJfdQEDIuAfDRPq/0PXzAtOA8os5U7/UwoE1h6+1P2FgCd9
         IKB74jhi28nXR1BxMtSNzIMpwX2hTFC602RAAmVDVwR1fJpjE5z9KDNvR1oz01yNGeTN
         ZYCl7oD5Jj0hfHMH4lvZLyqIkStR9tmy/P2/6TwCgw0+kjYdy/2sFQTOzPqXOooeupRE
         Z+Hm7GAZTlP5sdhiU8voANC59ibgPHVrNw2APEM8ntdrkmzeyDauVn/JbInNzjpj/yiB
         STjUL0hGAcWNzZ6RtAXLS/YqwRWIadIFXHF9m8JXzriDWa1y8rkteecXMkyUyvSxz9Ab
         OubQ==
X-Gm-Message-State: ACrzQf2NkY+hK3aCq65EhI3m/atSo1bj2X62Yf7/8+lSYd+e/SSyKwco
        DbmfBm3QWY2m67KWxTDism5EnmQMmBg=
X-Google-Smtp-Source: AMsMyM5HP67syVxGB3VPys64fM41vNnPa+4DYMWn0t7xsgz/9MbkNA6hXFiPsWHXPnf1B0cXDYoIwA==
X-Received: by 2002:a05:6000:180b:b0:22e:4998:fd55 with SMTP id m11-20020a056000180b00b0022e4998fd55mr3513481wrh.399.1666142161905;
        Tue, 18 Oct 2022 18:16:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b003c6cc57566fsm20094176wmq.14.2022.10.18.18.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 18:16:01 -0700 (PDT)
Message-Id: <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
In-Reply-To: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
From:   "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Oct 2022 01:16:00 +0000
Subject: [PATCH v2] embargoed releases: also describe the git-security list
 and the process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Ramer <prplr@github.com>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Julia Ramer <gitprplr@gmail.com>,
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
    
    Changes since v1:
    
     * Fixed the build
     * Changed the wording based on various feedback

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1345%2Fprplr%2Fupdate_embargo_doc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1345/prplr/update_embargo_doc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1345

Range-diff vs v1:

 1:  4d187f897d6 ! 1:  766c92e9031 embargoed releases: also describe the git-security list and the process
     @@ Documentation/howto/coordinate-embargoed-releases.txt
      + security releases.
      +
      +The `git-security` mailing list
     -+===============================
     ++-------------------------------
      +
      +Responsible disclosures of vulnerabilities, analysis, proposed fixes as
      +well as the orchestration of coordinated embargoed releases all happen on the
     @@ Documentation/howto/coordinate-embargoed-releases.txt
      +embargo" refers to publishing the version that fixes the vulnerabilities.
      +
      +Audience of the `git-security` mailing list
     -+-------------------------------------------
     ++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      +
      +Anybody may contact the `git-security` mailing list by sending an email
      +to <git-security@googlegroups.com>, though the archive is closed to the
     @@ Documentation/howto/coordinate-embargoed-releases.txt
      +requirements.
      +
      +Communications
     -+--------------
     ++~~~~~~~~~~~~~~
      +
      +If you are a stakeholder, it is a good idea to pay close attention to the
      +discussions, as pertinent information may be buried in the middle of a lively
     @@ Documentation/howto/coordinate-embargoed-releases.txt
      +agreements, assessments or timelines.
      +
      +A bug's life: Typical timeline
     -+==============================
     ++------------------------------
      +
      +- A bug is reported to the `git-security` mailing list.
      +
     @@ Documentation/howto/coordinate-embargoed-releases.txt
      +  fork associated with the draft security advisory.
      +
      +- Once the review has settled and everyone involved in the review agrees that
     -+  the patches are ready, the Git maintainer determines a release date as well
     -+  as the release trains that are serviced. The decision regarding which versions
     -+  need a backported fix is based on input from the reporter, the contributor who
     -+  worked on the patches, and from stakeholders (e.g. operators of hosting sites
     -+  who may want to analyze whether the given bug is exploited via any of the
     -+  repositories they host).
     ++  the patches are ready, the Git maintainer, and others determine a release date
     ++  as well as the release trains that are serviced. The decision regarding which
     ++  versions need a backported fix is based on input from the reporter, the
     ++  contributor who worked on the patches, and from stakeholders (e.g. operators
     ++  of hosting sites who may want to analyze whether the given bug is exploited
     ++  via any of the repositories they host).
     ++
     ++- While the Git community does its best to accommodate the specific timeline
     ++  requests of the various binary packagers, the nature of the issue may preclude
     ++  a prolonged release schedule. For fixes deemed urgent, it may be in the best
     ++  interest of the Git users community to shorten the disclosure and release
     ++  timeline, and packagers may need to adapt accordingly.
      +
      +- Subsequently, branches with the fixes are pushed to private repositories that
      +  are owned by the Git project, with tightly controlled access.
     @@ Documentation/howto/coordinate-embargoed-releases.txt
      +- The tags are created by the Git maintainer and pushed to the same
      +  repositories.
      +
     ++- The Git for Windows, Git for macOS, BSD, Debian, etc maintainers prepares the
     ++  corresponding release artifacts, based on the tags created that have been
     ++  prepared by the Git maintainer.
     ++
     ++- Git for Windows release artifacts are made available under embargo to
     ++  stakeholders via a mail to the `git-security` list.
     ++
      +- Less than a week before the release, a mail with the relevant information is
     -+  sent to <distros@vs.openwall.org> (see below), a list used to pre-announce embargoed
     -+  releases of open source projects to the stakeholders of all major Linux
     -+  distributions. This includes a Git bundle of the tagged version(s), but no
     -+  further specifics of the vulnerability.
     ++  sent to <distros@vs.openwall.org> (see below), a list used to pre-announce
     ++  embargoed releases of open source projects to the stakeholders of all major
     ++  Linux distributions. This includes a Git bundle of the tagged version(s), but
     ++  no further specifics of the vulnerability.
      +
      +- Public communication is then prepared in advance of the release date. This
      +  includes blog posts and mails to the Git and Git for Windows mailing lists.
      +
     -+- The Git for Windows maintainer prepares the corresponding release artifacts,
     -+  based on the tags created that have been prepared by the Git maintainer.
     -+
     -+- Git for Windows release artifacts are made available under embargo to
     -+  stakeholders via a mail to the `git-security` list.
     -+
      +- On the day of the release, at around 10am Pacific Time, the Git maintainer
      +  pushes the tag and the `master` branch to the public repository, then sends
      +  out an announcement mail.
     @@ Documentation/howto/coordinate-embargoed-releases.txt
      +- Git for Windows release is then announced via a mail to the public Git and
      +  Git for Windows mailing lists as well as via a tweet.
      +
     -+- A mail to <oss-security@lists.openwall.org> (see below for details) is sent as a
     -+  follow-up to the <distros@vs.openwall.org> one, describing the vulnerability in
     -+  detail, often including a proof of concept of an exploit.
     ++- Ditto for Linux distribution packagers: their releases are announced via
     ++  their preferred channels.
     ++
     ++- A mail to <oss-security@lists.openwall.org> (see below for details) is sent
     ++  as a follow-up to the <distros@vs.openwall.org> one, describing the
     ++  vulnerability in detail, often including a proof of concept of an exploit.
      +
      +Note: The Git project makes no guarantees about timelines, but aims to keep
      +embargoes reasonably short in the interest of keeping Git's users safe.
       
       How we coordinate embargoed releases
     - ====================================
     -@@ Documentation/howto/coordinate-embargoed-releases.txt: what Operating System or distribution they run.
     - Open a Security Advisory draft
     - ------------------------------
     +-====================================
     ++------------------------------------
       
     + To protect Git users from critical vulnerabilities, we do not just release
     + fixed versions like regular maintenance releases. Instead, we coordinate
     +@@ Documentation/howto/coordinate-embargoed-releases.txt: date. That way, users will have a chance to upgrade on that date, no matter
     + what Operating System or distribution they run.
     + 
     + Open a Security Advisory draft
     +-------------------------------
     +-
      -The first step is to https://github.com/git/git/security/advisories/new[open an
      -advisory]. Technically, it is not necessary, but it is convenient and saves a
      -bit of hassle. This advisory can also be used to obtain the CVE number and it
      -will give us a private fork associated with it that can be used to collaborate
      -on a fix.
     --
     ++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     + 
      -Release date of the embargoed version
      --------------------------------------
      -
     @@ Documentation/howto/coordinate-embargoed-releases.txt: what Operating System or
      +associated with it that can be used to collaborate on a fix.
       
       Notifying the Linux distributions
     - ---------------------------------
     +----------------------------------
     ++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       
       At most two weeks before release date, we need to send a notification to
      -distros@vs.openwall.org, preferably less than 7 days before the release date.
     @@ Documentation/howto/coordinate-embargoed-releases.txt: what Operating System or
       This will reach most (all?) Linux distributions. See an example below, and the
       guidelines for this mailing list at
       https://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists[here].
     +@@ Documentation/howto/coordinate-embargoed-releases.txt: created using a command like this:
     + 	tar cJvf cve-xxx.bundle.tar.xz cve-xxx.bundle
     + 
     + Example mail to distros@vs.openwall.org
     +----------------------------------------
     ++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     + 
     + ....
     + To: distros@vs.openwall.org
     +@@ Documentation/howto/coordinate-embargoed-releases.txt: Thanks,
     + ....
     + 
     + Example mail to oss-security@lists.openwall.com
     +------------------------------------------------
     ++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     + 
     + ....
     + To: oss-security@lists.openwall.com
     +@@ Documentation/howto/coordinate-embargoed-releases.txt: it goes to <developer>.
     + 
     + Thanks,
     + <name>
     +-....
     ++....
     + \ No newline at end of file


 .../howto/coordinate-embargoed-releases.txt   | 165 +++++++++++++++---
 1 file changed, 138 insertions(+), 27 deletions(-)

diff --git a/Documentation/howto/coordinate-embargoed-releases.txt b/Documentation/howto/coordinate-embargoed-releases.txt
index 601aae88e9a..a01398c82b5 100644
--- a/Documentation/howto/coordinate-embargoed-releases.txt
+++ b/Documentation/howto/coordinate-embargoed-releases.txt
@@ -1,9 +1,134 @@
 Content-type: text/asciidoc
-Abstract: When a critical vulnerability is discovered and fixed, we follow this
- script to coordinate a public release.
+Abstract: When a vulnerability is reported, we follow these guidelines to
+ assess the vulnerability, create and review a fix, and coordinate embargoed
+ security releases.
+
+The `git-security` mailing list
+-------------------------------
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
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+~~~~~~~~~~~~~~
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
+------------------------------
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
+  the patches are ready, the Git maintainer, and others determine a release date
+  as well as the release trains that are serviced. The decision regarding which
+  versions need a backported fix is based on input from the reporter, the
+  contributor who worked on the patches, and from stakeholders (e.g. operators
+  of hosting sites who may want to analyze whether the given bug is exploited
+  via any of the repositories they host).
+
+- While the Git community does its best to accommodate the specific timeline
+  requests of the various binary packagers, the nature of the issue may preclude
+  a prolonged release schedule. For fixes deemed urgent, it may be in the best
+  interest of the Git users community to shorten the disclosure and release
+  timeline, and packagers may need to adapt accordingly.
+
+- Subsequently, branches with the fixes are pushed to private repositories that
+  are owned by the Git project, with tightly controlled access.
+
+- The tags are created by the Git maintainer and pushed to the same
+  repositories.
+
+- The Git for Windows, Git for macOS, BSD, Debian, etc maintainers prepares the
+  corresponding release artifacts, based on the tags created that have been
+  prepared by the Git maintainer.
+
+- Git for Windows release artifacts are made available under embargo to
+  stakeholders via a mail to the `git-security` list.
+
+- Less than a week before the release, a mail with the relevant information is
+  sent to <distros@vs.openwall.org> (see below), a list used to pre-announce
+  embargoed releases of open source projects to the stakeholders of all major
+  Linux distributions. This includes a Git bundle of the tagged version(s), but
+  no further specifics of the vulnerability.
+
+- Public communication is then prepared in advance of the release date. This
+  includes blog posts and mails to the Git and Git for Windows mailing lists.
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
+- Ditto for Linux distribution packagers: their releases are announced via
+  their preferred channels.
+
+- A mail to <oss-security@lists.openwall.org> (see below for details) is sent
+  as a follow-up to the <distros@vs.openwall.org> one, describing the
+  vulnerability in detail, often including a proof of concept of an exploit.
+
+Note: The Git project makes no guarantees about timelines, but aims to keep
+embargoes reasonably short in the interest of keeping Git's users safe.
 
 How we coordinate embargoed releases
-====================================
+------------------------------------
 
 To protect Git users from critical vulnerabilities, we do not just release
 fixed versions like regular maintenance releases. Instead, we coordinate
@@ -12,32 +137,18 @@ date. That way, users will have a chance to upgrade on that date, no matter
 what Operating System or distribution they run.
 
 Open a Security Advisory draft
-------------------------------
-
-The first step is to https://github.com/git/git/security/advisories/new[open an
-advisory]. Technically, it is not necessary, but it is convenient and saves a
-bit of hassle. This advisory can also be used to obtain the CVE number and it
-will give us a private fork associated with it that can be used to collaborate
-on a fix.
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
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
----------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 At most two weeks before release date, we need to send a notification to
-distros@vs.openwall.org, preferably less than 7 days before the release date.
+<distros@vs.openwall.org>, preferably less than 7 days before the release date.
 This will reach most (all?) Linux distributions. See an example below, and the
 guidelines for this mailing list at
 https://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists[here].
@@ -65,7 +176,7 @@ created using a command like this:
 	tar cJvf cve-xxx.bundle.tar.xz cve-xxx.bundle
 
 Example mail to distros@vs.openwall.org
----------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 ....
 To: distros@vs.openwall.org
@@ -101,7 +212,7 @@ Thanks,
 ....
 
 Example mail to oss-security@lists.openwall.com
------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 ....
 To: oss-security@lists.openwall.com
@@ -128,4 +239,4 @@ it goes to <developer>.
 
 Thanks,
 <name>
-....
+....
\ No newline at end of file

base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
-- 
gitgitgadget
