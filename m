Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7961F428
	for <e@80x24.org>; Tue, 14 Aug 2018 22:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeHOBSI (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 21:18:08 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:43551 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeHOBSI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 21:18:08 -0400
Received: by mail-pf1-f176.google.com with SMTP id j26-v6so9868353pfi.10
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 15:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4z1XAXjkFwamWGHIc++gXEIvKESfwToRPtoSUY/MI1Q=;
        b=RS2AD+XvVzIde+HVHn5EWEMGt7OGrW45/JwhfyW8/XcNtiVkYL0PqAxHBGW/s8NErl
         +2qLw4be4iEEeFFy6qdM/4Fv4BVAqOirIuF5Q13eVUIRae6EFQ1Ci23Ot+4Jy92STy30
         J4tfXoMribyn7+DB4qRQ1g1z9EQmAItSThPCOAq2CbaYg1/EpHEVDOFHqs8PIBtkwNjx
         AM7Z4/xs8H9T00wYuOEYPZrcL8LUkw+rdV5j+DKeNRN2pXEBiMxALYQpmnZMISjENCwf
         yeJqrnmJD9rpUtgJttmjN4eYkDQHM9EZyklhTCDfFw3ephBltp71HavSWYnzpstwNxX7
         YREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4z1XAXjkFwamWGHIc++gXEIvKESfwToRPtoSUY/MI1Q=;
        b=uYpY5MnifUwuiXhMv7/Xnr+4Lz9pFtUQ8Y/1jz31Bl/tDFJOMdCbfI3N7KAuamTpXT
         eb32BS6UMTG2uoFef8x1eB7JwHpCsD5fB0sDO9JpqysTAF9hKytfENoisN+iQkQskIBt
         AQZfIeJubV5DwXiG1jwijy1cJy1oHD9DQDMIEkKwoDYQAhpSS7rFLIG1rpfBD2Xpv0rb
         EnCpL/i5KYOK1nPJYsaCvSxXqnvhf98fLEERthw+GlP8ybvjXFc+GtJTzmQVO8NzMRwu
         zbSLpZ7vehlOCi9HTgSxNECmQd2Ou6pnmL51RZ9dPh6znn160283D8rcY2qbJXJwxV7n
         EelQ==
X-Gm-Message-State: AOUpUlHhbrUMTPZSwaCgv4fK0iJw6pVTcofFfNj/MyJvyVi+WxjZQuF8
        4hawzMfLIwJxtdzraFHATgbFgOlS
X-Google-Smtp-Source: AA+uWPxnLN+opnDHyctq9VImbTx1kqro9VSZ6McBDhdKZOahle/GoZXjBXQuvmdTOI3guVooF1Igcw==
X-Received: by 2002:aa7:87d0:: with SMTP id i16-v6mr25157522pfo.82.1534285728969;
        Tue, 14 Aug 2018 15:28:48 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d75-v6sm33938329pfd.49.2018.08.14.15.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 15:28:48 -0700 (PDT)
Date:   Tue, 14 Aug 2018 15:28:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH] partial-clone: render design doc using asciidoc
Message-ID: <20180814222846.GG142615@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rendered documentation can be easier to read than raw text because
headings and emphasized phrases stand out.  Add the missing markup and
Makefile rule required to render this design document using asciidoc.

Tested by running

  make -C Documentation technical/partial-clone.html

and viewing the output in a browser.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Today I noticed that this document wasn't available at
https://www.kernel.org/pub/software/scm/git/docs/technical/partial-clone.html,
so I wrote this patch.

Thoughts of all kinds welcome, as always.

 Documentation/Makefile                    |   1 +
 Documentation/technical/partial-clone.txt | 208 +++++++++++-----------
 2 files changed, 105 insertions(+), 104 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d079d7c73ac..a42dcfc7459 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -76,6 +76,7 @@ TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/pack-format
 TECH_DOCS += technical/pack-heuristics
 TECH_DOCS += technical/pack-protocol
+TECH_DOCS += technical/partial-clone
 TECH_DOCS += technical/protocol-capabilities
 TECH_DOCS += technical/protocol-common
 TECH_DOCS += technical/protocol-v2
diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index 0bed2472c81..1ef66bd788a 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -69,24 +69,24 @@ Design Details
 
 - A new pack-protocol capability "filter" is added to the fetch-pack and
   upload-pack negotiation.
-
-  This uses the existing capability discovery mechanism.
-  See "filter" in Documentation/technical/pack-protocol.txt.
++
+This uses the existing capability discovery mechanism.
+See "filter" in Documentation/technical/pack-protocol.txt.
 
 - Clients pass a "filter-spec" to clone and fetch which is passed to the
   server to request filtering during packfile construction.
-
-  There are various filters available to accommodate different situations.
-  See "--filter=<filter-spec>" in Documentation/rev-list-options.txt.
++
+There are various filters available to accommodate different situations.
+See "--filter=<filter-spec>" in Documentation/rev-list-options.txt.
 
 - On the server pack-objects applies the requested filter-spec as it
   creates "filtered" packfiles for the client.
-
-  These filtered packfiles are *incomplete* in the traditional sense because
-  they may contain objects that reference objects not contained in the
-  packfile and that the client doesn't already have.  For example, the
-  filtered packfile may contain trees or tags that reference missing blobs
-  or commits that reference missing trees.
++
+These filtered packfiles are *incomplete* in the traditional sense because
+they may contain objects that reference objects not contained in the
+packfile and that the client doesn't already have.  For example, the
+filtered packfile may contain trees or tags that reference missing blobs
+or commits that reference missing trees.
 
 - On the client these incomplete packfiles are marked as "promisor packfiles"
   and treated differently by various commands.
@@ -104,47 +104,47 @@ Handling Missing Objects
   to repository corruption.  To differentiate these cases, the local
   repository specially indicates such filtered packfiles obtained from the
   promisor remote as "promisor packfiles".
-
-  These promisor packfiles consist of a "<name>.promisor" file with
-  arbitrary contents (like the "<name>.keep" files), in addition to
-  their "<name>.pack" and "<name>.idx" files.
++
+These promisor packfiles consist of a "<name>.promisor" file with
+arbitrary contents (like the "<name>.keep" files), in addition to
+their "<name>.pack" and "<name>.idx" files.
 
 - The local repository considers a "promisor object" to be an object that
   it knows (to the best of its ability) that the promisor remote has promised
   that it has, either because the local repository has that object in one of
   its promisor packfiles, or because another promisor object refers to it.
-
-  When Git encounters a missing object, Git can see if it a promisor object
-  and handle it appropriately.  If not, Git can report a corruption.
-
-  This means that there is no need for the client to explicitly maintain an
-  expensive-to-modify list of missing objects.[a]
++
+When Git encounters a missing object, Git can see if it a promisor object
+and handle it appropriately.  If not, Git can report a corruption.
++
+This means that there is no need for the client to explicitly maintain an
+expensive-to-modify list of missing objects.[a]
 
 - Since almost all Git code currently expects any referenced object to be
   present locally and because we do not want to force every command to do
   a dry-run first, a fallback mechanism is added to allow Git to attempt
   to dynamically fetch missing objects from the promisor remote.
-
-  When the normal object lookup fails to find an object, Git invokes
-  fetch-object to try to get the object from the server and then retry
-  the object lookup.  This allows objects to be "faulted in" without
-  complicated prediction algorithms.
-
-  For efficiency reasons, no check as to whether the missing object is
-  actually a promisor object is performed.
-
-  Dynamic object fetching tends to be slow as objects are fetched one at
-  a time.
++
+When the normal object lookup fails to find an object, Git invokes
+fetch-object to try to get the object from the server and then retry
+the object lookup.  This allows objects to be "faulted in" without
+complicated prediction algorithms.
++
+For efficiency reasons, no check as to whether the missing object is
+actually a promisor object is performed.
++
+Dynamic object fetching tends to be slow as objects are fetched one at
+a time.
 
 - `checkout` (and any other command using `unpack-trees`) has been taught
   to bulk pre-fetch all required missing blobs in a single batch.
 
 - `rev-list` has been taught to print missing objects.
-
-  This can be used by other commands to bulk prefetch objects.
-  For example, a "git log -p A..B" may internally want to first do
-  something like "git rev-list --objects --quiet --missing=print A..B"
-  and prefetch those objects in bulk.
++
+This can be used by other commands to bulk prefetch objects.
+For example, a "git log -p A..B" may internally want to first do
+something like "git rev-list --objects --quiet --missing=print A..B"
+and prefetch those objects in bulk.
 
 - `fsck` has been updated to be fully aware of promisor objects.
 
@@ -154,11 +154,11 @@ Handling Missing Objects
 - The global variable "fetch_if_missing" is used to control whether an
   object lookup will attempt to dynamically fetch a missing object or
   report an error.
-
-  We are not happy with this global variable and would like to remove it,
-  but that requires significant refactoring of the object code to pass an
-  additional flag.  We hope that concurrent efforts to add an ODB API can
-  encompass this.
++
+We are not happy with this global variable and would like to remove it,
+but that requires significant refactoring of the object code to pass an
+additional flag.  We hope that concurrent efforts to add an ODB API can
+encompass this.
 
 
 Fetching Missing Objects
@@ -168,10 +168,10 @@ Fetching Missing Objects
   transport_fetch_refs(), setting a new transport option
   TRANS_OPT_NO_DEPENDENTS to indicate that only the objects themselves are
   desired, not any object that they refer to.
-
-  Because some transports invoke fetch_pack() in the same process, fetch_pack()
-  has been updated to not use any object flags when the corresponding argument
-  (no_dependents) is set.
++
+Because some transports invoke fetch_pack() in the same process, fetch_pack()
+has been updated to not use any object flags when the corresponding argument
+(no_dependents) is set.
 
 - The local repository sends a request with the hashes of all requested
   objects as "want" lines, and does not perform any packfile negotiation.
@@ -187,13 +187,13 @@ Current Limitations
 
 - The remote used for a partial clone (or the first partial fetch
   following a regular clone) is marked as the "promisor remote".
-
-  We are currently limited to a single promisor remote and only that
-  remote may be used for subsequent partial fetches.
-
-  We accept this limitation because we believe initial users of this
-  feature will be using it on repositories with a strong single central
-  server.
++
+We are currently limited to a single promisor remote and only that
+remote may be used for subsequent partial fetches.
++
+We accept this limitation because we believe initial users of this
+feature will be using it on repositories with a strong single central
+server.
 
 - Dynamic object fetching will only ask the promisor remote for missing
   objects.  We assume that the promisor remote has a complete view of the
@@ -221,13 +221,13 @@ Future Work
 - Allow more than one promisor remote and define a strategy for fetching
   missing objects from specific promisor remotes or of iterating over the
   set of promisor remotes until a missing object is found.
-
-  A user might want to have multiple geographically-close cache servers
-  for fetching missing blobs while continuing to do filtered `git-fetch`
-  commands from the central server, for example.
-
-  Or the user might want to work in a triangular work flow with multiple
-  promisor remotes that each have an incomplete view of the repository.
++
+A user might want to have multiple geographically-close cache servers
+for fetching missing blobs while continuing to do filtered `git-fetch`
+commands from the central server, for example.
++
+Or the user might want to work in a triangular work flow with multiple
+promisor remotes that each have an incomplete view of the repository.
 
 - Allow repack to work on promisor packfiles (while keeping them distinct
   from non-promisor packfiles).
@@ -238,25 +238,25 @@ Future Work
 - Investigate use of a long-running process to dynamically fetch a series
   of objects, such as proposed in [5,6] to reduce process startup and
   overhead costs.
-
-  It would be nice if pack protocol V2 could allow that long-running
-  process to make a series of requests over a single long-running
-  connection.
++
+It would be nice if pack protocol V2 could allow that long-running
+process to make a series of requests over a single long-running
+connection.
 
 - Investigate pack protocol V2 to avoid the info/refs broadcast on
   each connection with the server to dynamically fetch missing objects.
 
 - Investigate the need to handle loose promisor objects.
-
-  Objects in promisor packfiles are allowed to reference missing objects
-  that can be dynamically fetched from the server.  An assumption was
-  made that loose objects are only created locally and therefore should
-  not reference a missing object.  We may need to revisit that assumption
-  if, for example, we dynamically fetch a missing tree and store it as a
-  loose object rather than a single object packfile.
-
-  This does not necessarily mean we need to mark loose objects as promisor;
-  it may be sufficient to relax the object lookup or is-promisor functions.
++
+Objects in promisor packfiles are allowed to reference missing objects
+that can be dynamically fetched from the server.  An assumption was
+made that loose objects are only created locally and therefore should
+not reference a missing object.  We may need to revisit that assumption
+if, for example, we dynamically fetch a missing tree and store it as a
+loose object rather than a single object packfile.
++
+This does not necessarily mean we need to mark loose objects as promisor;
+it may be sufficient to relax the object lookup or is-promisor functions.
 
 
 Non-Tasks
@@ -265,13 +265,13 @@ Non-Tasks
 - Every time the subject of "demand loading blobs" comes up it seems
   that someone suggests that the server be allowed to "guess" and send
   additional objects that may be related to the requested objects.
-
-  No work has gone into actually doing that; we're just documenting that
-  it is a common suggestion.  We're not sure how it would work and have
-  no plans to work on it.
-
-  It is valid for the server to send more objects than requested (even
-  for a dynamic object fetch), but we are not building on that.
++
+No work has gone into actually doing that; we're just documenting that
+it is a common suggestion.  We're not sure how it would work and have
+no plans to work on it.
++
+It is valid for the server to send more objects than requested (even
+for a dynamic object fetch), but we are not building on that.
 
 
 Footnotes
@@ -282,43 +282,43 @@ Footnotes
     This would essentially be a sorted linear list of OIDs that the were
     omitted by the server during a clone or subsequent fetches.
 
-    This file would need to be loaded into memory on every object lookup.
-    It would need to be read, updated, and re-written (like the .git/index)
-    on every explicit "git fetch" command *and* on any dynamic object fetch.
+This file would need to be loaded into memory on every object lookup.
+It would need to be read, updated, and re-written (like the .git/index)
+on every explicit "git fetch" command *and* on any dynamic object fetch.
 
-    The cost to read, update, and write this file could add significant
-    overhead to every command if there are many missing objects.  For example,
-    if there are 100M missing blobs, this file would be at least 2GiB on disk.
+The cost to read, update, and write this file could add significant
+overhead to every command if there are many missing objects.  For example,
+if there are 100M missing blobs, this file would be at least 2GiB on disk.
 
-    With the "promisor" concept, we *infer* a missing object based upon the
-    type of packfile that references it.
+With the "promisor" concept, we *infer* a missing object based upon the
+type of packfile that references it.
 
 
 Related Links
 -------------
-[0] https://bugs.chromium.org/p/git/issues/detail?id=2
-    Chromium work item for: Partial Clone
+[0] https://crbug.com/git/2
+    Bug#2: Partial Clone
 
-[1] https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/
-    Subject: [RFC] Add support for downloading blobs on demand
+[1] https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/ +
+    Subject: [RFC] Add support for downloading blobs on demand +
     Date: Fri, 13 Jan 2017 10:52:53 -0500
 
-[2] https://public-inbox.org/git/cover.1506714999.git.jonathantanmy@google.com/
-    Subject: [PATCH 00/18] Partial clone (from clone to lazy fetch in 18 patches)
+[2] https://public-inbox.org/git/cover.1506714999.git.jonathantanmy@google.com/ +
+    Subject: [PATCH 00/18] Partial clone (from clone to lazy fetch in 18 patches) +
     Date: Fri, 29 Sep 2017 13:11:36 -0700
 
-[3] https://public-inbox.org/git/20170426221346.25337-1-jonathantanmy@google.com/
-    Subject: Proposal for missing blob support in Git repos
+[3] https://public-inbox.org/git/20170426221346.25337-1-jonathantanmy@google.com/ +
+    Subject: Proposal for missing blob support in Git repos +
     Date: Wed, 26 Apr 2017 15:13:46 -0700
 
-[4] https://public-inbox.org/git/1488999039-37631-1-git-send-email-git@jeffhostetler.com/
-    Subject: [PATCH 00/10] RFC Partial Clone and Fetch
+[4] https://public-inbox.org/git/1488999039-37631-1-git-send-email-git@jeffhostetler.com/ +
+    Subject: [PATCH 00/10] RFC Partial Clone and Fetch +
     Date: Wed,  8 Mar 2017 18:50:29 +0000
 
-[5] https://public-inbox.org/git/20170505152802.6724-1-benpeart@microsoft.com/
-    Subject: [PATCH v7 00/10] refactor the filter process code into a reusable module
+[5] https://public-inbox.org/git/20170505152802.6724-1-benpeart@microsoft.com/ +
+    Subject: [PATCH v7 00/10] refactor the filter process code into a reusable module +
     Date: Fri,  5 May 2017 11:27:52 -0400
 
-[6] https://public-inbox.org/git/20170714132651.170708-1-benpeart@microsoft.com/
-    Subject: [RFC/PATCH v2 0/1] Add support for downloading blobs on demand
+[6] https://public-inbox.org/git/20170714132651.170708-1-benpeart@microsoft.com/ +
+    Subject: [RFC/PATCH v2 0/1] Add support for downloading blobs on demand +
     Date: Fri, 14 Jul 2017 09:26:50 -0400
-- 
2.18.0.865.gffc8e1a3cd6

