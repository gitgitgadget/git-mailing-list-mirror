Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42CD01F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 00:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbeDLAVZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:21:25 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:44322 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeDLAVY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:24 -0400
Received: by mail-pf0-f170.google.com with SMTP id p15so2071064pff.11
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhB6yfqfX3DIBFsq+zqg8ONig8vBL9yQv2BVJpaDNSM=;
        b=kXAxWYLHw25RxuTG9abeHsN/DcmRrtGdXKdnTjPQEVgljxjTvNATy+ViIjEeIzpmP3
         cxjw+786zLJQ0+qRZg2cA8wK80ALW2EJHamEUNqgTGgmPkzEyY8M9ddjaA4FLU0qnj4I
         5/Nc0CSZ8Px2PMzSswxEbDsThtIoEhC0mzOMWxQmB1qwhP4F9vvWkHxyDrMRmwTxgxDC
         tZdx4EVhZjCkbVokO0zAqIIhu4LD3bOudOaGJScUbnAPZnAkUzsrxEnVK49vhk80Gwr1
         ccI+FBoz1aroXaEYPRMXMxtTZ6SN4f7PAcr+WTi4zYpiDgSUJRvj9GAIOsywKtytXDkD
         hShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhB6yfqfX3DIBFsq+zqg8ONig8vBL9yQv2BVJpaDNSM=;
        b=GFwwKLzv5RagZWEg/SePCFXtN8z5oNyW1jflEyCaQoNCbxlWEr/qwvFOJfZr0kziTC
         OVbzFZ7xV8PxzNaf+3hgqJRfSCbErc5ln2OFqZaB9yQg4s29chFu3twTMA35VnYCXhsD
         YifPqrO8N+nfwWN8XgIRDqlifGXRi6UDto05Me4KkFzqiElE7C4lVt/c0E4guAzEYOkT
         GmI9B/PTnWysF4JmN9x662YesDyb5fiUdZi6+DPeOjpi+PXceafTt4f1fBbRoZYPvQPz
         BrQaFNL53ZXbNzQwehHQ/EUHkgClCsSrF8byGvF9/+SthFVMce8MZqUX7F/JLEpzXqoY
         j0Cg==
X-Gm-Message-State: ALQs6tBRHR9jEICcMhOhSk2kMbVD+FTnpATUnGhyrU7iRLFgiFn+0tFz
        tycG53mtDL2XpATOCvKgenwM2w==
X-Google-Smtp-Source: AIpwx490o78s5OZ5VanmI1D+KXEGqZ0tlHHOrm1xKRecG0ZRFhwJtnZJB4hXkjmYWxJUjtqHbCF7JQ==
X-Received: by 10.167.131.201 with SMTP id j9mr5742315pfn.214.1523492483783;
        Wed, 11 Apr 2018 17:21:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id d199sm4707895pfd.95.2018.04.11.17.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCHv3 00/15] replace_object.c: rename to use dash in file name 
Date:   Wed, 11 Apr 2018 17:21:03 -0700
Message-Id: <20180412002118.102976-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180409224533.17764-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3:
* interdiff below,
  the only changes are renaming the variable 
  -       struct ref_store *main_ref_store;
  +       struct ref_store *refs;
  in struct repository.
  as well as dropping the file rename patch.
* improved commit messages from discussion on the single patches.

v2:
This applies on top of a merge of
origin/bc/object-id and origin/sb/packfiles-in-repository,
both of which are pending merge to master. It is also available at
https://github.com/stefanbeller/git/tree/object-store-3

* removed whitespaces as noted by Stolee
* incorporated Renes patch as the first patch of this series
  (It may go independently if this series takes too long)
* Adressed Erics concern regarding sloppy commit messages
  (removed #Conflict markers), typo in comment
* I did not drop the main_ from the ref store, yet, as asked by Duy.

Thanks,
Stefan

v1:
This applies on top of 464416a2eaadf84d2bfdf795007863d03b222b7c
(sb/packfiles-in-repository).
It is also available at https://github.com/stefanbeller/git/tree/object-store-3

This series will bring the replacement mechanism (git replace)
into the object store.

The first patches are cleaning up a bit, and patches 6-19 are converting
one function at a time using the tick-tock pattern with the #define trick.
See cfc62fc98c (sha1_file: add repository argument to link_alt_odb_entry,
2018-03-23) for explanation.

Thanks,
Stefan

René Scharfe (1):
  replace_object: use oidmap

Stefan Beller (14):
  replace-object: move replace_map to object store
  object-store: move lookup_replace_object to replace-object.h
  replace-object: eliminate replace objects prepared flag
  replace-object: check_replace_refs is safe in multi repo environment
  refs: add repository argument to get_main_ref_store
  refs: add repository argument to for_each_replace_ref
  replace-object: add repository argument to prepare_replace_object
  replace-object: add repository argument to do_lookup_replace_object
  replace-object: add repository argument to lookup_replace_object
  refs: store the main ref store inside the repository struct
  refs: allow for_each_replace_ref to handle arbitrary repositories
  replace-object: allow prepare_replace_object to handle arbitrary
    repositories
  replace-object: allow do_lookup_replace_object to handle arbitrary
    repositories
  replace-object: allow lookup_replace_object to handle arbitrary
    repositories

 builtin/mktag.c           |  3 +-
 builtin/pack-refs.c       |  3 +-
 builtin/replace.c         |  4 +-
 cache.h                   | 19 --------
 environment.c             |  2 +-
 object-store.h            |  8 ++++
 object.c                  |  3 +-
 refs.c                    | 80 ++++++++++++++++----------------
 refs.h                    |  4 +-
 refs/files-backend.c      |  4 --
 replace-object.h          | 36 +++++++++++++++
 replace_object.c          | 97 ++++++++++-----------------------------
 repository.h              |  3 ++
 revision.c                |  5 +-
 sha1_file.c               |  7 +--
 streaming.c               |  3 +-
 t/helper/test-ref-store.c |  3 +-
 17 files changed, 134 insertions(+), 150 deletions(-)
 create mode 100644 replace-object.h


$ git diff github/object-store-3
 diff --git c/Makefile w/Makefile
index 94e0bf47b1..de4b8f0c02 100644
--- c/Makefile
+++ w/Makefile
@@ -871,7 +871,7 @@ LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
-LIB_OBJS += replace-object.o
+LIB_OBJS += replace_object.o
 LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
 LIB_OBJS += resolve-undo.o
diff --git c/refs.c w/refs.c
index bed5f88405..9b56fa9b81 100644
--- c/refs.c
+++ w/refs.c
@@ -1651,11 +1651,11 @@ static struct ref_store *ref_store_init(const char *gitdir,
 
 struct ref_store *get_main_ref_store(struct repository *r)
 {
-       if (r->main_ref_store)
-               return r->main_ref_store;
+       if (r->refs)
+               return r->refs;
 
-       r->main_ref_store = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
-       return r->main_ref_store;
+       r->refs = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
+       return r->refs;
 }
 
 /*
diff --git c/refs/files-backend.c w/refs/files-backend.c
index bec8e30e9e..5c76a75817 100644
--- c/refs/files-backend.c
+++ w/refs/files-backend.c
@@ -61,10 +61,6 @@ struct ref_lock {
        struct object_id old_oid;
 };
 
-/*
- * Future: need to be in "struct repository"
- * when doing a full libification.
- */
 struct files_ref_store {
        struct ref_store base;
        unsigned int store_flags;
diff --git c/replace-object.c w/replace_object.c
similarity index 100%
rename from replace-object.c
rename to replace_object.c
diff --git c/repository.h w/repository.h
index 7d0710b273..e6e00f541b 100644
--- c/repository.h
+++ w/repository.h
@@ -27,7 +27,7 @@ struct repository {
        struct raw_object_store *objects;
 
        /* The store in which the refs are held. */
-       struct ref_store *main_ref_store;
+       struct ref_store *refs;
 
        /*
         * Path to the repository's graft file.

-- 
2.17.0.484.g0c8726318c-goog

