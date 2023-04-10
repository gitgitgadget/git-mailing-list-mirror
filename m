Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F894C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 14:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjDJODe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 10:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDJODc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 10:03:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D177049C2
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 07:03:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l16so2376624wms.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 07:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681135385;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qc8/6xMktDaMI1nH6k3UkGzW1F7SMtuQhXK2s35adlc=;
        b=SAvEJeM04/ur8XXr99bKCsxOeiGvNEfpY5OjPm4ofCZzhC22jhf5zhPIwY6Tx9jI4L
         dOv8d2+fECwSUbRFAkrbSsDeh3qbJHelbefSIuNtBxkd52swpUBQOw6wLZwAAsc+8inc
         BWQQmHc8rn6Y8E1YipE2PqLmfKqodIg6luIaDacQYBp8DmsVgtYqyB6vt+ypYOtRnKoe
         kc6xY9WmL0j70A3BoiWnsoexmCqKB5j4PqauFPSbYsVO+oTg4V5mWnj4kfGV7mC8BQNB
         qZTMd5lkGQJJmjL/sSCiQpJdkQCjFwAcUgWYPUKKXWmAIz0RTO6SII27ukWfZRF7KUWr
         7HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681135385;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qc8/6xMktDaMI1nH6k3UkGzW1F7SMtuQhXK2s35adlc=;
        b=v+DPUZTE6RF39TM92G52oLeRXLrSaXhDSX4YAJhb9Y/vQ5LbykXgxW087ezc/CAxbC
         O7JvMdULXq7T99A5CbKgMwDthNJK6+hgDufD8D2WbMG6YDiyx7GAsZaPsVQHuaLycRFH
         iMQ05Sec29HHBx0jHIBw+h47YVrB35uN5nJAjinRZng8ZMMeNfkpWvdnWNxZcfaUQuTH
         NRDSUHtT5Xrspv2tSUbUcUxHV8UMhOxzi3WS65vRV+C044O3CNhfyTwM7nKvIgaDWegX
         EqDYMLSTZVSoPfe5Gw1q+SikZstBbX9OAXO+PAMVra/y2Dj9egEGeRFm3YtG0O6q6Sd9
         c9dQ==
X-Gm-Message-State: AAQBX9cpby/jiIT/ETWMQXou7o1531Ocp/b3jR4mupaxd9grNxFgcHGP
        arWgpAPAugtJ4J4aMjQ9TPt56NVdVMU=
X-Google-Smtp-Source: AKy350a9rNmjkP4OtKR2SJpPdJ00tYgOwgZe7ZAMWpNs6om4TSRIpRQQ1gl6C3kjnSFQac/wTEIR8A==
X-Received: by 2002:a05:600c:284:b0:3df:de28:f819 with SMTP id 4-20020a05600c028400b003dfde28f819mr7553138wmk.15.1681135384958;
        Mon, 10 Apr 2023 07:03:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bca53000000b003ede06f3178sm13756062wml.31.2023.04.10.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 07:03:04 -0700 (PDT)
Message-Id: <pull.1494.git.git.1681135384039.gitgitgadget@gmail.com>
From:   "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Apr 2023 14:03:03 +0000
Subject: [PATCH] git-merge: improve conflict presentation documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Adam Johnson <me@adamj.eu>, Adam Johnson <me@adamj.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Adam Johnson <me@adamj.eu>

Imporvements:

1. Remove the sexist example ("Barbie... wants to go shopping")
2. Show real merge marker contents, rather than e.g. "yours:sample.txt".
3. Swap yours/theirs terms for source/target.
4. General wordsmithing.

Signed-off-by: Adam Johnson <me@adamj.eu>
---
    git-merge: improve conflict presentation documentation
    
    Imporvements:
    
     1. Remove the sexist example ("Barbie... wants to go shopping")
     2. Show real merge marker contents, rather than e.g.
        "yours:sample.txt".
     3. Swap yours/theirs terms for source/target.
     4. General wordsmithing.
    
    Signed-off-by: Adam Johnson me@adamj.eu

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1494%2Fadamchainz%2Fgit_merge_conflicts-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1494/adamchainz/git_merge_conflicts-v1
Pull-Request: https://github.com/git/git/pull/1494

 Documentation/git-merge.txt | 67 ++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 0aeff572a59..409a564ca39 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -245,71 +245,70 @@ from the RCS suite to present such a conflicted hunk, like this:
 ------------
 Here are lines that are either unchanged from the common
 ancestor, or cleanly resolved because only one side changed,
-or cleanly resolved because both sides changed the same way.
-<<<<<<< yours:sample.txt
-Conflict resolution is hard;
-let's go shopping.
+or cleanly resolved because both sides changed identically.
+<<<<<<< HEAD
+Git makes conflict resolution straightforward.
 =======
 Git makes conflict resolution easy.
->>>>>>> theirs:sample.txt
+>>>>>>> main
 And here is another line that is cleanly resolved or unmodified.
 ------------
 
 The area where a pair of conflicting changes happened is marked with markers
 `<<<<<<<`, `=======`, and `>>>>>>>`.  The part before the `=======`
-is typically your side, and the part afterwards is typically their side.
+is typically the target that you’re merging into, and the part afterwards
+is typically the source that you’re merging from.
+
+The default format does not show what the original version contained in the
+conflicting area.  You cannot tell how many lines have been deleted and
+replaced on either side. The only thing you can tell is that the target side
+says "straightforward", while the source side says "easy".
 
-The default format does not show what the original said in the conflicting
-area.  You cannot tell how many lines are deleted and replaced with
-Barbie's remark on your side.  The only thing you can tell is that your
-side wants to say it is hard and you'd prefer to go shopping, while the
-other side wants to claim it is easy.
+You can use an alternative conflict marker style by setting the
+`merge.conflictStyle` configuration variable to either "diff3" or "zdiff3".
+Both of these styles show the original version of the conflicted area, which
+may help you find a better resolution.
 
-An alternative style can be used by setting the "merge.conflictStyle"
-configuration variable to either "diff3" or "zdiff3".  In "diff3"
-style, the above conflict may look like this:
+In the "diff3" style, the above conflict looks like this:
 
 ------------
 Here are lines that are either unchanged from the common
 ancestor, or cleanly resolved because only one side changed,
-<<<<<<< yours:sample.txt
-or cleanly resolved because both sides changed the same way.
-Conflict resolution is hard;
-let's go shopping.
-||||||| base:sample.txt
+<<<<<<< HEAD
 or cleanly resolved because both sides changed identically.
+Git makes conflict resolution straightforward.
+||||||| 81821ce
+or cleanly resolved because both sides changed the same way.
 Conflict resolution is hard.
 =======
-or cleanly resolved because both sides changed the same way.
+or cleanly resolved because both sides changed identically.
 Git makes conflict resolution easy.
->>>>>>> theirs:sample.txt
+>>>>>>> main
 And here is another line that is cleanly resolved or unmodified.
 ------------
 
-while in "zdiff3" style, it may look like this:
+while in the "zdiff3" style, it looks like this:
 
 ------------
 Here are lines that are either unchanged from the common
 ancestor, or cleanly resolved because only one side changed,
-or cleanly resolved because both sides changed the same way.
-<<<<<<< yours:sample.txt
-Conflict resolution is hard;
-let's go shopping.
-||||||| base:sample.txt
 or cleanly resolved because both sides changed identically.
+<<<<<<< HEAD
+Git makes conflict resolution straightforward.
+||||||| 81821ce
+or cleanly resolved because both sides changed the same way.
 Conflict resolution is hard.
 =======
 Git makes conflict resolution easy.
->>>>>>> theirs:sample.txt
+>>>>>>> main
 And here is another line that is cleanly resolved or unmodified.
 ------------
 
-In addition to the `<<<<<<<`, `=======`, and `>>>>>>>` markers, it uses
-another `|||||||` marker that is followed by the original text.  You can
-tell that the original just stated a fact, and your side simply gave in to
-that statement and gave up, while the other side tried to have a more
-positive attitude.  You can sometimes come up with a better resolution by
-viewing the original.
+The original commit SHA and text are shown after another marker, `|||||||`.
+This region lets you now see that both sides made the edit from "the same way"
+to "identically", as well as editing the following line.  The "diff3" style
+keeps all changed lines within the markers, whilst the "zdiff3" style moves the
+commonly edited line before the marker.
 
 
 HOW TO RESOLVE CONFLICTS

base-commit: f285f68a132109c234d93490671c00218066ace9
-- 
gitgitgadget
