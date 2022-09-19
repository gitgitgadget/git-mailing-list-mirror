Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865BFECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 19:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiISTMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 15:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiISTMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 15:12:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E85826555
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:12:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g3so584337wrq.13
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=jIV2J5kFlSiV+Tv0V1X91gVwA+0hFmPEkKZ1/hZHaDQ=;
        b=kw2Flo2Okocvcvo6FVIof8IA4qYAY7/A1MgVX2EiR93iAQTnI7OM72571D/StGzYTT
         MZbiGGHV3N6xULMQ5zpMBbzNV7jMRhCt4xqMiDCSptjjgSBvis2aO0tNS5GZGuTAzG2a
         1bLTCtSuBRp89b8GKGhYpsC7u0sgrxDldRtOIm2SMSX7RJI3+f/tAVrwjDNWhgrqb53/
         GoX7LMbQibcWhG/ru8NNTAj7Yoa6HaNyi6O3wNVG3fnpwj3SsINLNFA5bpMoX3NZ7byS
         updroFycwCwfHEasiecfjb01prmhBW+JSutlpd/cHQiBSI7X7PNwtumarS7YzJV30djz
         KBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jIV2J5kFlSiV+Tv0V1X91gVwA+0hFmPEkKZ1/hZHaDQ=;
        b=sSEO80uxD+xxIOcpA/qlE4YYZEj1sD7miwCUy4QkGMODs2IPszk1gcwyd790/K9GEV
         d1swU9eVKjDjMceK5DVHqWrvOjOBuz142sdEfN/ATOylBB1BUpY4JApR2X1rMq2w+1xG
         cEQiBQXipBULAe6BaY+48iJZaw+S5ccQDJ8mByD61YIUqfi/ayxnrus0JlVq2TmCwTmO
         0XtSHOWrXvcrZRjfAm8pFEcUcWvmThzUAGAQh86/o9FwstHxrKNkca9916kG6knGQg7v
         2Hd6Q4XmijvFj8gHc5XkE0SolqRb03DJfnCIuKEfD8Eac/TKy2vHbsQoI0Mbqvr7pWex
         9nKA==
X-Gm-Message-State: ACrzQf2H+ALdqjtwu/8HhVXknLB6RRe8X4w7meEayEMcjD+bhfmSW8vA
        NbRZyaEPnwCi30rnR97hONOL3p2t3As=
X-Google-Smtp-Source: AMsMyM5xmjLtVzpAN4RsYzed5jbRrZN89T5X/OZ8a4Gw2kCzZf/82Ptka6k9VWOD/uFCK42MChGJpw==
X-Received: by 2002:a05:6000:387:b0:22a:3cae:93c4 with SMTP id u7-20020a056000038700b0022a3cae93c4mr12427292wrf.321.1663614768181;
        Mon, 19 Sep 2022 12:12:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003b47581979bsm15962418wmq.33.2022.09.19.12.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:12:47 -0700 (PDT)
Message-Id: <pull.1348.v2.git.1663614767058.gitgitgadget@gmail.com>
In-Reply-To: <pull.1348.git.1662747205235.gitgitgadget@gmail.com>
References: <pull.1348.git.1662747205235.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 19:12:46 +0000
Subject: [PATCH v2] Documentation: add ReviewingGuidelines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Johannes.Schindelin@gmx.de,
        steadmon@google.com, chooglen@google.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add a reviewing guidelines document including advice and common terminology
used in Git mailing list reviews. The document is included in the
'TECH_DOCS' list in order to include it in Git's published documentation.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
    Documentation: add ReviewingGuidelines
    
    This patch follows up on a discussion a few weeks ago in the Git IRC
    standup [1], where it was mentioned that it would be nice to have
    consistent definitions for common review terminology (like 'nit:'). The
    "ReviewingGuidelines" document created here builds on that idea, as well
    as past discussions around the idea of advice for reviewers (similar to
    the guidelines for new contributors in MyFirstContribution [2]).
    
    The goal of this document is to clarify & standardize some of the more
    niche concepts important to the Git project ("What's cooking" emails,
    terminology), as well as provide general reviewing advice based on my
    observations of effective reviews from others on the mailing list.
    
    One thing that's particularly important to me here is that the advice
    presented here does not gatekeep or otherwise denigrate the personal
    preferences or style of reviewers. With that in mind, one of the things
    I'm looking for in reviews of this document is making sure that the tone
    & content reflect that more positive/encouraging intent. And, of course,
    I'm happy to hear what other tips & terminology people think would be
    helpful to include!
    
    
    Changes since V1
    ================
    
     * Reorganized "Principles" section advice into "High-level guidance"
       and "Performing your review" subsections.
     * Dropped recommendation to comment on cover letter with "LGTM" if you
       have no other recommendations (somewhat redundant with the
       "Completing a review" section, and such comments don't tend to add
       value except when coming from highly-experienced reviewers anyway).
     * Added clarity & modified reasoning for why reviewing CC'd patches is
       helpful.
     * Miscellaneous other revisions recommended by [3].
    
    Thanks!
    
     * Victoria
    
    [1]
    https://colabti.org/irclogger/irclogger_log/git-devel?date=2022-08-29#l53
    [2] https://git-scm.com/docs/MyFirstContribution [3]
    https://lore.kernel.org/git/xmqqwnacibbm.fsf@gitster.g/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1348%2Fvdye%2Ffeature%2Freviewing-guidelines-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1348/vdye/feature/reviewing-guidelines-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1348

Range-diff vs v1:

 1:  b2ed5641c24 ! 1:  7326058b23a Documentation: add ReviewingGuidelines
     @@ Commit message
      
          Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Helped-by: Derrick Stolee <derrickstolee@github.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Josh Steadmon <steadmon@google.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Documentation/Makefile ##
     @@ Documentation/ReviewingGuidelines.txt (new)
      +latest "What's cooking in git.git" email
      +(https://lore.kernel.org/git/xmqqilm1yp3m.fsf@gitster.g/[example]). The "What's
      +cooking" emails & replies can be found using the query `s:"What's cooking"` on
     -+the mailing list archive; alternatively, you can find the contents of the
     -+"What's cooking" email tracked in `whats-cooking.txt` on the `todo` branch of
     -+Git. Topics tagged with "Needs review" and those in the "[New Topics]" section
     -+are typically those that would benefit the most from additional review.
     ++the https://lore.kernel.org/git/[`lore.kernel.org` mailing list archive];
     ++alternatively, you can find the contents of the "What's cooking" email tracked
     ++in `whats-cooking.txt` on the `todo` branch of Git. Topics tagged with "Needs
     ++review" and those in the "[New Topics]" section are typically those that would
     ++benefit the most from additional review.
      +
      +Patches can also be searched manually in the mailing list archive using a query
      +like `s:"PATCH" -s:"Re:"`. You can browse these results for topics relevant to
      +your expertise or interest.
      +
      +If you've already contributed to Git, you may also be CC'd in another
     -+contributor's patch series. These are usually topics where the author feels that
     -+your attention is warranted; this may be due to prior contributions,
     -+demonstrated expertise, and/or interest in related topics. There is no
     -+requirement to review these series, but you may find them easier to review as a
     -+result of your preexisting background knowledge on the topic.
     ++contributor's patch series. These are topics where the author feels that your
     ++attention is warranted. This may be because their patch changes something you
     ++wrote previously (making you a good judge of whether the new approach does or
     ++doesn't work), or because you have the expertise to provide an exceptionally
     ++helpful review. There is no requirement to review these patches but, in the
     ++spirit of open source collaboration, you should strongly consider doing so.
      +
      +Reviewing patches
      +~~~~~~~~~~~~~~~~~
      +While every contributor takes their own approach to reviewing patches, here are
     -+some general pieces of advice to make your reviews to be as clear and helpful as
     -+possible.
     -+
     -+- Provide your review comments per-patch in a plaintext "Reply-All" email to the
     -+  relevant patch. Comments should be made inline, immediately below the relevant
     -+  section(s).
     ++some general pieces of advice to make your reviews as clear and helpful as
     ++possible. The advice is broken into two rough categories: high-level reviewing
     ++guidance, and concrete tips for interacting with patches on the mailing list.
      +
     ++==== High-level guidance
      +- Remember to review the content of commit messages for correctness and clarity,
      +  in addition to the code change in the patch's diff. The commit message of a
      +  patch should accurately and fully explain the code change being made in the
      +  diff.
      +
     -+- You may find that the limited context provided in the patch diff is sometimes
     -+  insufficient for a thorough review. In such cases, you can review patches in
     -+  your local tree by either applying patches with linkgit:git-am[1] or checking
     -+  out the associated branch from https://github.com/gitster/git once the series
     -+  is tracked there.
     -+
     -+- Large, complicated patch diffs are sometimes unavoidable, such as when they
     -+  refactor existing code. If you find such a patch difficult to parse, try
     -+  reviewing the diff produced with the `--color-moved` and/or
     -+  `--ignore-space-change` options.
     -+
      +- Reviewing test coverage is an important - but easy to overlook - component of
      +  reviews. A patch's changes may be covered by existing tests, or new tests may
      +  be introduced to exercise new behavior. Checking out a patch or series locally
     @@ Documentation/ReviewingGuidelines.txt (new)
      +  pass/fail behavior. You can use this information to verify proper coverage or
      +  to suggest additional tests the author could add.
      +
     -+- If a patch is long, you can delete parts of it that are unrelated to your
     -+  review from the email reply. Make sure to leave enough context for readers to
     -+  understand your comments!
     ++- When providing a recommendation, be as clear as possible about whether you
     ++  consider it "blocking" (the code would be broken or otherwise made worse if an
     ++  issue isn't fixed) or "non-blocking" (the patch could be made better by taking
     ++  the recommendation, but acceptance of the series does not require it).
     ++  Non-blocking recommendations can be particularly ambiguous when they are
     ++  related to - but outside the scope of - a series ("nice-to-have"s), or when
     ++  they represent only stylistic differences between the author and reviewer.
      +
     -+- When pointing out an issue, try to include suggestions for how the author
     ++- When commenting on an issue, try to include suggestions for how the author
      +  could fix it. This not only helps the author to understand and fix the issue,
      +  it also deepens and improves your understanding of the topic.
      +
     @@ Documentation/ReviewingGuidelines.txt (new)
      +  goes a long way towards encouraging contributors to participate more actively
      +  in the Git community.
      +
     -+- When providing a recommendation, be as clear as possible about whether you
     -+  consider it "blocking" (the code would be broken or otherwise made worse if an
     -+  issue isn't fixed) or "non-blocking" (the patch could be made better by taking
     -+  the recommendation, but acceptance of the series does not require it).
     -+  Non-blocking recommendations can be particularly ambiguous when they are
     -+  related to - but outside the scope of - a series ("nice-to-have"s), or when
     -+  they represent only stylistic differences between the author and reviewer.
     ++==== Performing your review
     ++- Provide your review comments per-patch in a plaintext "Reply-All" email to the
     ++  relevant patch. Comments should be made inline, immediately below the relevant
     ++  section(s).
     ++
     ++- You may find that the limited context provided in the patch diff is sometimes
     ++  insufficient for a thorough review. In such cases, you can review patches in
     ++  your local tree by either applying patches with linkgit:git-am[1] or checking
     ++  out the associated branch from https://github.com/gitster/git once the series
     ++  is tracked there.
     ++
     ++- Large, complicated patch diffs are sometimes unavoidable, such as when they
     ++  refactor existing code. If you find such a patch difficult to parse, try
     ++  reviewing the diff produced with the `--color-moved` and/or
     ++  `--ignore-space-change` options.
     ++
     ++- If a patch is long, you are encouraged to delete parts of it that are
     ++  unrelated to your review from the email reply. Make sure to leave enough
     ++  context for readers to understand your comments!
      +
      +- If you cannot complete a full review of a series all at once, consider letting
      +  the author know (on- or off-list) if/when you plan to review the rest of the
      +  series.
      +
     -+- If you read and review a series but find nothing that warrants inline
     -+  commentary, reply to the series' cover letter to indicate that you've reviewed
     -+  the changes.
     -+
      +Completing a review
      +~~~~~~~~~~~~~~~~~~~
      +Once each patch of a series is reviewed, the author (and/or other contributors)
     @@ Documentation/ReviewingGuidelines.txt (new)
      +re-review the updates. If you are happy with the state of the patch series,
      +explicitly indicate your approval (typically with a reply to the latest
      +version's cover letter). Optionally, you can let the author know that they can
     -+add a "Reviewed-by: <you>" trailer to subsequent versions of their series.
     ++add a "Reviewed-by: <you>" trailer if they resubmit the reviewed patch verbatim
     ++in a later iteration of the series.
      +
      +Finally, subsequent "What's cooking" emails may explicitly ask whether a
      +reviewed topic is ready for merging to the `next` branch (typically phrased
     -+"Will merge to 'next'?"). You can help the maintainer and author by responding
     ++"Will merge to \'next\'?"). You can help the maintainer and author by responding
      +with a short description of the state of your (and others', if applicable)
     -+review.
     ++review, including the links to the relevant thread(s).
      +
      +Terminology
      +-----------


 Documentation/Makefile                |   1 +
 Documentation/ReviewingGuidelines.txt | 162 ++++++++++++++++++++++++++
 2 files changed, 163 insertions(+)
 create mode 100644 Documentation/ReviewingGuidelines.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index bd6b6fcb930..d3a19df8bed 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -101,6 +101,7 @@ SP_ARTICLES += howto/coordinate-embargoed-releases
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
 SP_ARTICLES += $(API_DOCS)
 
+TECH_DOCS += ReviewingGuidelines
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
diff --git a/Documentation/ReviewingGuidelines.txt b/Documentation/ReviewingGuidelines.txt
new file mode 100644
index 00000000000..0e323d54779
--- /dev/null
+++ b/Documentation/ReviewingGuidelines.txt
@@ -0,0 +1,162 @@
+Reviewing Patches in the Git Project
+====================================
+
+Introduction
+------------
+The Git development community is a widely distributed, diverse, ever-changing
+group of individuals. Asynchronous communication via the Git mailing list poses
+unique challenges when reviewing or discussing patches. This document contains
+some guiding principles and helpful tools you can use to make your reviews both
+more efficient for yourself and more effective for other contributors.
+
+Note that none of the recommendations here are binding or in any way a
+requirement of participation in the Git community. They are provided as a
+resource to supplement your skills as a contributor.
+
+Principles
+----------
+
+Selecting patch(es) to review
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+If you are looking for a patch series in need of review, start by checking
+latest "What's cooking in git.git" email
+(https://lore.kernel.org/git/xmqqilm1yp3m.fsf@gitster.g/[example]). The "What's
+cooking" emails & replies can be found using the query `s:"What's cooking"` on
+the https://lore.kernel.org/git/[`lore.kernel.org` mailing list archive];
+alternatively, you can find the contents of the "What's cooking" email tracked
+in `whats-cooking.txt` on the `todo` branch of Git. Topics tagged with "Needs
+review" and those in the "[New Topics]" section are typically those that would
+benefit the most from additional review.
+
+Patches can also be searched manually in the mailing list archive using a query
+like `s:"PATCH" -s:"Re:"`. You can browse these results for topics relevant to
+your expertise or interest.
+
+If you've already contributed to Git, you may also be CC'd in another
+contributor's patch series. These are topics where the author feels that your
+attention is warranted. This may be because their patch changes something you
+wrote previously (making you a good judge of whether the new approach does or
+doesn't work), or because you have the expertise to provide an exceptionally
+helpful review. There is no requirement to review these patches but, in the
+spirit of open source collaboration, you should strongly consider doing so.
+
+Reviewing patches
+~~~~~~~~~~~~~~~~~
+While every contributor takes their own approach to reviewing patches, here are
+some general pieces of advice to make your reviews as clear and helpful as
+possible. The advice is broken into two rough categories: high-level reviewing
+guidance, and concrete tips for interacting with patches on the mailing list.
+
+==== High-level guidance
+- Remember to review the content of commit messages for correctness and clarity,
+  in addition to the code change in the patch's diff. The commit message of a
+  patch should accurately and fully explain the code change being made in the
+  diff.
+
+- Reviewing test coverage is an important - but easy to overlook - component of
+  reviews. A patch's changes may be covered by existing tests, or new tests may
+  be introduced to exercise new behavior. Checking out a patch or series locally
+  allows you to manually mutate lines of new & existing tests to verify expected
+  pass/fail behavior. You can use this information to verify proper coverage or
+  to suggest additional tests the author could add.
+
+- When providing a recommendation, be as clear as possible about whether you
+  consider it "blocking" (the code would be broken or otherwise made worse if an
+  issue isn't fixed) or "non-blocking" (the patch could be made better by taking
+  the recommendation, but acceptance of the series does not require it).
+  Non-blocking recommendations can be particularly ambiguous when they are
+  related to - but outside the scope of - a series ("nice-to-have"s), or when
+  they represent only stylistic differences between the author and reviewer.
+
+- When commenting on an issue, try to include suggestions for how the author
+  could fix it. This not only helps the author to understand and fix the issue,
+  it also deepens and improves your understanding of the topic.
+
+- Reviews do not need to exclusively point out problems. Feel free to "think out
+  loud" in your review: describe how you read & understood a complex section of
+  a patch, ask a question about something that confused you, point out something
+  you found exceptionally well-written, etc. In particular, uplifting feedback
+  goes a long way towards encouraging contributors to participate more actively
+  in the Git community.
+
+==== Performing your review
+- Provide your review comments per-patch in a plaintext "Reply-All" email to the
+  relevant patch. Comments should be made inline, immediately below the relevant
+  section(s).
+
+- You may find that the limited context provided in the patch diff is sometimes
+  insufficient for a thorough review. In such cases, you can review patches in
+  your local tree by either applying patches with linkgit:git-am[1] or checking
+  out the associated branch from https://github.com/gitster/git once the series
+  is tracked there.
+
+- Large, complicated patch diffs are sometimes unavoidable, such as when they
+  refactor existing code. If you find such a patch difficult to parse, try
+  reviewing the diff produced with the `--color-moved` and/or
+  `--ignore-space-change` options.
+
+- If a patch is long, you are encouraged to delete parts of it that are
+  unrelated to your review from the email reply. Make sure to leave enough
+  context for readers to understand your comments!
+
+- If you cannot complete a full review of a series all at once, consider letting
+  the author know (on- or off-list) if/when you plan to review the rest of the
+  series.
+
+Completing a review
+~~~~~~~~~~~~~~~~~~~
+Once each patch of a series is reviewed, the author (and/or other contributors)
+may discuss the review(s). This may result in no changes being applied, or the
+author will send a new version of their patch(es).
+
+After a series is rerolled in response to your or others' review, make sure to
+re-review the updates. If you are happy with the state of the patch series,
+explicitly indicate your approval (typically with a reply to the latest
+version's cover letter). Optionally, you can let the author know that they can
+add a "Reviewed-by: <you>" trailer if they resubmit the reviewed patch verbatim
+in a later iteration of the series.
+
+Finally, subsequent "What's cooking" emails may explicitly ask whether a
+reviewed topic is ready for merging to the `next` branch (typically phrased
+"Will merge to \'next\'?"). You can help the maintainer and author by responding
+with a short description of the state of your (and others', if applicable)
+review, including the links to the relevant thread(s).
+
+Terminology
+-----------
+nit: ::
+	Denotes a small issue that should be fixed, such as a typographical error
+	or mis-alignment of conditions in an `if()` statement.
+
+aside: ::
+optional: ::
+non-blocking: ::
+	Indicates to the reader that the following comment should not block the
+	acceptance of the patch or series. These are typically recommendations
+	related to code organization & style, or musings about topics related to
+	the patch in question, but beyond its scope.
+
+s/<before>/<after>/::
+	Shorthand for "you wrote <before>, but I think you meant <after>," usually
+	for misspellings or other typographical errors. The syntax is a reference
+	to "substitute" command commonly found in Unix tools such as `ed`, `sed`,
+	`vim`, and `perl`.
+
+cover letter::
+	The "Patch 0" of a multi-patch series. This email describes the
+	high-level intent and structure of the patch series to readers on the
+	Git mailing list. It is also where the changelog notes and range-diff of
+	subsequent versions are provided by the author.
++
+On single-patch submissions, cover letter content is typically not sent as a
+separate email. Instead, it is inserted between the end of the patch's commit
+message (after the `---`) and the beginning of the diff.
+
+#leftoverbits::
+  Used by either an author or a reviewer to describe features or suggested
+  changes that are out-of-scope of a given patch or series, but are relevant
+  to the topic for the sake of discussion.
+
+See Also
+--------
+link:MyFirstContribution.html[MyFirstContribution]

base-commit: 79f2338b3746d23454308648b2491e5beba4beff
-- 
gitgitgadget
