Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8982032D
	for <e@80x24.org>; Tue, 12 Mar 2019 13:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCLNab (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:30:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34989 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfCLNa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id g19so2311744edp.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8inGzJVVs3vWJ2vLGz2G3C7Zs7OmL5oh2wy/bfdAG8=;
        b=l0bhlv/9KEDWwXfO1UdoghsWejmhL2xRMBLceVbDl6O9T3eYrzEXL3em2HbvT9GqpG
         uNr+Y3R+cQdKEcXWaHl3KKrBfeIjxeC3N7Gj+F2zf7KtyCZ21y5sEyWJDxDIfLFQVzS9
         isC/Wdi+CcFwfrwg2gEoAPVUNFh4A5CGKbJRncUrwdaAFrrrkIF5kivqWRvrC0uCduwW
         6kPktRAl2v2wT2H7pJRzdhpT9VxJiY6Z53YLJficT8XAoAzsV7dBGkBuunkhRW3fC5Yf
         TODg3rZzC2O/UKav8fsBpzWKoGpM1T+EuaRjn8er+nNeemLmqs6RxU71f6yVH5qAShtT
         HSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8inGzJVVs3vWJ2vLGz2G3C7Zs7OmL5oh2wy/bfdAG8=;
        b=kYLoyJWu/Fo6L/PZyAENxG2V7XA1mmKLgLB1fqYY3EoThU6/5D7hUJEmlZSbI8J40w
         s+Is0q6OEQUEwR/eZ+wpl5c6D/yuS8M9nsucxOuKA8MkYV5o+66D0/4otTQZxEvZxuxT
         BLcH0SoYyK6+CGe4aOg1OPxsyLu2wMvKzUP3Kxm4/N2Usk7S7O8Hbmze9l/hQsXdEz/F
         8DCh3VxWoOo4mBM5MhR6J/HNtNJn7/BrqXizuhnuq1VcXthvpCuUQLC8DAH6b1pvbI4y
         H0ca8UI6/SssaG0m9W8rEn0ubKvXRSOqXJmXBclBT2oVKvwwxw1pf1g+BJkVfc7eZQXf
         ptgw==
X-Gm-Message-State: APjAAAU1byayreVwGoQgHdBhZLRPZavZ/Kvke8zF02mbUne1H8MOMdLh
        NoktgufB9cCNJHXDKLNezLjOGc9+
X-Google-Smtp-Source: APXvYqzb20Qcngab1LQRrvjecTVjLKPf6noX+GmHFhDWtxYEnjDZwFzSzqkrec/bZNg97vGIQz4BKA==
X-Received: by 2002:a50:b527:: with SMTP id y36mr3529958edd.83.1552397426174;
        Tue, 12 Mar 2019 06:30:26 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id h8sm5875213edk.21.2019.03.12.06.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:25 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3 10/11] partial-clone: add multiple remotes in the doc
Date:   Tue, 12 Mar 2019 14:29:58 +0100
Message-Id: <20190312132959.11764-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.166.gb5e4dbcfd3
In-Reply-To: <20190312132959.11764-1-chriscool@tuxfamily.org>
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
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
2.21.0.166.gb5e4dbcfd3

