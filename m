Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB961F4C1
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfFYNlX (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42050 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfFYNlV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so27210009edq.9
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vfu6BLCHfXpS0QbQy6I9jG+42bXaSELjF5aTG+mbQmU=;
        b=IVMYiLKjFQ7uGyWiDXpq2BKyPB8l45tOT3gTp5PKUdAnBTftrvU+R159fPADxjy4h3
         FQlaBxNN6Gr2q7Wp7mzIHoj+jd7jsMf+3wiGq912gTEboAOUmEPDMCnZbX5kCMi/FgBl
         hXbwtd6Zj05TAg014po1/zd3KcKzoArtxuvUdKJgivKSI46nC9AKqRA8AQWgxloJZpJ3
         Al03FzBGvG3f/UZRoYrIycGmT6mTIbUBpVhTaoqk33KirarVpSG6xDfasZ99qtOiHoBn
         /Rh5jgOn3EYPK/9n64qJlX/UyGmB6LdJ51FYxe2X7vgef7qCErC9jjfECodw/XkCimnY
         Ebpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfu6BLCHfXpS0QbQy6I9jG+42bXaSELjF5aTG+mbQmU=;
        b=e9L45YhyIoTlUqHe9HavrHWmgux9B4h0y/3jwXHOJj5yTaSWkwiToGphKFAxN69i2e
         GwIrVCdeuRvmJUqZGrlmxHj/saRx04l9GDn3qpd2SA8HlIUrrWM7XF9QTsJnGkpw2RHq
         gsqyzBo6dc6Y2f9N1jBEH491CbGnIhdJYrzgfPSnwm7NwuoaYizukfps3Ngi5wjEBF5F
         0smRAe4kOVlVQK4s2dIoq3TE8zn3uxYy1z94TDnqVtIEgqxxypQfuMgYUnxMf2CNWZCm
         3JLSKAVGLaaTc9qEJpWSBLGRQczMBDAnxQ3W3TsaCQUj4nAwrxR5G4gbuulKI/hp5XK3
         2LLw==
X-Gm-Message-State: APjAAAVzOCshdfz6upBuS/0YSFGIjctAy6blc+orwGrImp3UfL+KmIPY
        6qyVJxAEkQa0ImgmVah0jF2FdtFY0LY=
X-Google-Smtp-Source: APXvYqw4zJ0chRr87JRo3nOY06P3aT8h4RYllwdFOHNc3framKVusZE4VckFt5UoPbiSIJuvwqQJCQ==
X-Received: by 2002:a17:906:1252:: with SMTP id u18mr5754272eja.13.1561470078370;
        Tue, 25 Jun 2019 06:41:18 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:17 -0700 (PDT)
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
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v6 11/15] partial-clone: add multiple remotes in the doc
Date:   Tue, 25 Jun 2019 15:40:35 +0200
Message-Id: <20190625134039.21707-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
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
 Documentation/technical/partial-clone.txt | 117 ++++++++++++++++------
 1 file changed, 84 insertions(+), 33 deletions(-)

diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index 896c7b3878..210373e258 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -30,12 +30,20 @@ advance* during clone and fetch operations and thereby reduce download
 times and disk usage.  Missing objects can later be "demand fetched"
 if/when needed.
 
+A remote that can later provide the missing objects is called a
+promisor remote, as it promises to send the objects when
+requested. Initialy Git supported only one promisor remote, the origin
+remote from which the user cloned and that was configured in the
+"extensions.partialClone" config option. Later support for more than
+one promisor remote has been implemented.
+
 Use of partial clone requires that the user be online and the origin
-remote be available for on-demand fetching of missing objects.  This may
-or may not be problematic for the user.  For example, if the user can
-stay within the pre-selected subset of the source tree, they may not
-encounter any missing objects.  Alternatively, the user could try to
-pre-fetch various objects if they know that they are going offline.
+remote or other promisor remotes be available for on-demand fetching
+of missing objects.  This may or may not be problematic for the user.
+For example, if the user can stay within the pre-selected subset of
+the source tree, they may not encounter any missing objects.
+Alternatively, the user could try to pre-fetch various objects if they
+know that they are going offline.
 
 
 Non-Goals
@@ -100,18 +108,18 @@ or commits that reference missing trees.
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
@@ -123,12 +131,12 @@ expensive-to-modify list of missing objects.[a]
 - Since almost all Git code currently expects any referenced object to be
   present locally and because we do not want to force every command to do
   a dry-run first, a fallback mechanism is added to allow Git to attempt
-  to dynamically fetch missing objects from the promisor remote.
+  to dynamically fetch missing objects from promisor remotes.
 +
 When the normal object lookup fails to find an object, Git invokes
-fetch-object to try to get the object from the server and then retry
-the object lookup.  This allows objects to be "faulted in" without
-complicated prediction algorithms.
+promisor_remote_get_direct() to try to get the object from a promisor
+remote and then retry the object lookup.  This allows objects to be
+"faulted in" without complicated prediction algorithms.
 +
 For efficiency reasons, no check as to whether the missing object is
 actually a promisor object is performed.
@@ -157,8 +165,7 @@ and prefetch those objects in bulk.
 +
 We are not happy with this global variable and would like to remove it,
 but that requires significant refactoring of the object code to pass an
-additional flag.  We hope that concurrent efforts to add an ODB API can
-encompass this.
+additional flag.
 
 
 Fetching Missing Objects
@@ -182,21 +189,63 @@ has been updated to not use any object flags when the corresponding argument
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
+We decided to make it the last one we try, because it is likely that
+someone using many promisor remotes is doing so because the other
+promisor remotes are better for some reason (maybe they are closer or
+faster for some kind of objects) than the origin, and the origin is
+likely to be the remote specified by extensions.partialClone.
+
+This justification is not very strong, but one choice had to be made,
+and anyway the long term plan should be to make the order somehow
+fully configurable.
+
+For now though the other promisor remotes will be tried in the order
+they appear in the config file.
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
@@ -218,15 +267,17 @@ server.
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
2.22.0.229.ga13d9ffdf7.dirty

