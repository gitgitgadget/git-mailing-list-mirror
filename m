Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 108A820382
	for <e@80x24.org>; Mon,  1 Apr 2019 16:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfDAQld (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:41:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36422 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfDAQlc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:41:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so122826wml.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+7wMX1FZ8lsyFPdUzNMI0GN84DRQK86a+6V7g/ygoP0=;
        b=cqOCWlOPfnZI1E+/gv29Te0AQAkm1ydslavkU/rdT/b1CdljLlV95+xMD/ULMA+hF5
         UbODLETYQF/teitXAnuNCzvSQMACe9Ecj6eElXhYsTR1Lz7koEnfzztQC/0LRxDW3/bq
         ZUq6VWrGqwSNuAese8PTY+eoHLATyH6QYbeBRl8FKUxN3sIblurC4LHXfLv+LcFB/t2s
         FqIZvuDqaQaqTo4/YEuj8V3Z6ynJq11TUdFHiGY39R1WutdHh2rl+tFMrKElHZIQZqt+
         UEyDiVSmXYG9hQ7lc96wxYliOb0VARe6BDoOXPl2CWWv2pEWhnzg9RR0/d6KmviLXBfl
         sPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7wMX1FZ8lsyFPdUzNMI0GN84DRQK86a+6V7g/ygoP0=;
        b=NGrEJoWNucyqdVdoGg253BY2NvIZZ3ivNOfH8CuFFbxiojlYb9ukxnGGexpehGCzGs
         8iuOugbdoOb3VxgYt+A+JE3S1KWRKC4ObzwxiViAQLDsCSMNDRCh+bvpDCUDJPQnYVHt
         vewbx4nXsMlSAuwftDXeffrL3OVb1BB9A2dRYiNnuo6XnH5M8zDnmvgGsg3VhHu/fC6J
         5+5pTvrVP3A2/Ra0NZ8G5mdMUpr3JHJaXoSlroYFAvTl5WCaVNnync/a83hsXbrLvq/G
         JJWIsOG5mx3OPwMAFkLh3vy/pNpDb0/+oT4rsJdyf8jwP36MGr/VMdNCSz7+KbkT/r/x
         oMfA==
X-Gm-Message-State: APjAAAXWhwo6RSJP+Vfi1s5z1GrzPqoBlpUFwTu7RQMcPdxTHRlvTWoB
        +/DMfLsgSArZASBH+4mng8MruH/v
X-Google-Smtp-Source: APXvYqylfSTOxTLTbZ7T3cXWnzHZbXiGNSXt55axyiT9+48TCNzgyLrzsc4PZOBgh/WkHxT70oA3tw==
X-Received: by 2002:a1c:c504:: with SMTP id v4mr331739wmf.45.1554136889904;
        Mon, 01 Apr 2019 09:41:29 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:101d:3e80:8542:d1d4:667f:a0da])
        by smtp.gmail.com with ESMTPSA id s10sm11749070wmh.0.2019.04.01.09.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:41:29 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v4 10/11] partial-clone: add multiple remotes in the doc
Date:   Mon,  1 Apr 2019 18:40:44 +0200
Message-Id: <20190401164045.17328-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.203.gd44fa53258
In-Reply-To: <20190401164045.17328-1-chriscool@tuxfamily.org>
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at it, let's remove a reference to ODB effort as the ODB
effort has been replaced by directly enhancing partial clone
and promisor remote features.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/technical/partial-clone.txt | 83 ++++++++++++++++-------
 1 file changed, 58 insertions(+), 25 deletions(-)

diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index 896c7b3878..58adcc5ce1 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -100,18 +100,18 @@ or commits that reference missing trees.
 Handling Missing Objects
 ------------------------
 
-- An object may be missing due to a partial clone or fetch, or missing due
-  to repository corruption.  To differentiate these cases, the local
-  repository specially indicates such filtered packfiles obtained from the
-  promisor remote as "promisor packfiles".
+- An object may be missing due to a partial clone or fetch, or missing
+  due to repository corruption.  To differentiate these cases, the
+  local repository specially indicates such filtered packfiles
+  obtained from promisor remotes as "promisor packfiles".
 +
 These promisor packfiles consist of a "<name>.promisor" file with
 arbitrary contents (like the "<name>.keep" files), in addition to
 their "<name>.pack" and "<name>.idx" files.
 
 - The local repository considers a "promisor object" to be an object that
-  it knows (to the best of its ability) that the promisor remote has promised
-  that it has, either because the local repository has that object in one of
+  it knows (to the best of its ability) that promisor remotes have promised
+  that they have, either because the local repository has that object in one of
   its promisor packfiles, or because another promisor object refers to it.
 +
 When Git encounters a missing object, Git can see if it is a promisor object
@@ -123,7 +123,7 @@ expensive-to-modify list of missing objects.[a]
 - Since almost all Git code currently expects any referenced object to be
   present locally and because we do not want to force every command to do
   a dry-run first, a fallback mechanism is added to allow Git to attempt
-  to dynamically fetch missing objects from the promisor remote.
+  to dynamically fetch missing objects from promisor remotes.
 +
 When the normal object lookup fails to find an object, Git invokes
 fetch-object to try to get the object from the server and then retry
@@ -157,8 +157,7 @@ and prefetch those objects in bulk.
 +
 We are not happy with this global variable and would like to remove it,
 but that requires significant refactoring of the object code to pass an
-additional flag.  We hope that concurrent efforts to add an ODB API can
-encompass this.
+additional flag.
 
 
 Fetching Missing Objects
@@ -182,21 +181,53 @@ has been updated to not use any object flags when the corresponding argument
   though they are not necessary.
 
 
+Using many promisor remotes
+---------------------------
+
+Many promisor remotes can be configured and used.
+
+This allows for example a user to have multiple geographically-close
+cache servers for fetching missing blobs while continuing to do
+filtered `git-fetch` commands from the central server.
+
+When fetching objects, promisor remotes are tried one after the other
+until all the objects have been fetched.
+
+Remotes that are considered "promisor" remotes are those specified by
+the following configuration variables:
+
+- `extensions.partialClone = <name>`
+
+- `remote.<name>.promisor = true`
+
+- `remote.<name>.partialCloneFilter = ...`
+
+Only one promisor remote can be configured using the
+`extensions.partialClone` config variable. This promisor remote will
+be the last one tried when fetching objects.
+
+The other promisor remotes will be tried in the order they appear in
+the config file.
+
 Current Limitations
 -------------------
 
-- The remote used for a partial clone (or the first partial fetch
-  following a regular clone) is marked as the "promisor remote".
+- It is not possible to specify the order in which the promisor
+  remotes are tried in other ways than the order in which they appear
+  in the config file.
 +
-We are currently limited to a single promisor remote and only that
-remote may be used for subsequent partial fetches.
+It is also not possible to specify an order to be used when fetching
+from one remote and a different order when fetching from another
+remote.
+
+- It is not possible to push only specific objects to a promisor
+  remote.
 +
-We accept this limitation because we believe initial users of this
-feature will be using it on repositories with a strong single central
-server.
+It is not possible to push at the same time to multiple promisor
+remote in a specific order.
 
-- Dynamic object fetching will only ask the promisor remote for missing
-  objects.  We assume that the promisor remote has a complete view of the
+- Dynamic object fetching will only ask promisor remotes for missing
+  objects.  We assume that promisor remotes have a complete view of the
   repository and can satisfy all such requests.
 
 - Repack essentially treats promisor and non-promisor packfiles as 2
@@ -218,15 +249,17 @@ server.
 Future Work
 -----------
 
-- Allow more than one promisor remote and define a strategy for fetching
-  missing objects from specific promisor remotes or of iterating over the
-  set of promisor remotes until a missing object is found.
+- Improve the way to specify the order in which promisor remotes are
+  tried.
 +
-A user might want to have multiple geographically-close cache servers
-for fetching missing blobs while continuing to do filtered `git-fetch`
-commands from the central server, for example.
+For example this could allow to specify explicitly something like:
+"When fetching from this remote, I want to use these promisor remotes
+in this order, though, when pushing or fetching to that remote, I want
+to use those promisor remotes in that order."
+
+- Allow pushing to promisor remotes.
 +
-Or the user might want to work in a triangular work flow with multiple
+The user might want to work in a triangular work flow with multiple
 promisor remotes that each have an incomplete view of the repository.
 
 - Allow repack to work on promisor packfiles (while keeping them distinct
-- 
2.21.0.203.gd44fa53258

