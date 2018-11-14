Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2DE71F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeKNKOP (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:15 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:33944 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNKOP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:15 -0500
Received: by mail-vk1-f201.google.com with SMTP id q203so2428019vkb.1
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=V4f8GHSOlUN+YRDPDkVBSqjS/ZUlL3No8Lbv/8qGk1U=;
        b=OBJrKZoFdSe45LrOCNIEedfr4Gv9eQnlTfw6rvJbs6IpeeKLtldT8r7nkNdaL3TG2B
         3afUHmLyMQP0MbMDySUJmnvbsJrJu9PiDQQGrjJoNiAHDM1a+FB/YDHmVVbXXMLa7yQE
         fP7hPzXqmVfTSCdhaYCs8zsf6y8U4OmCTJoOOd8o3MxhSoj2vRTJNdcO4XTkCHwgs4ft
         eA6rLw2me2h49QsfDF92yhNrWHIytL4DJUYEUuWELLGzxXrUlqTFDahkbtboxCT3Ky4N
         ZyDwN2m1ovJ6VK/8pKqpiNIpmndORYQBM33k/FmcMTlgmdnwlkIt1SZ9TtJ3n9y/Rl4o
         Xpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=V4f8GHSOlUN+YRDPDkVBSqjS/ZUlL3No8Lbv/8qGk1U=;
        b=ZgD7LqEi4NHuke4PugMcSAwHo8JpVIVoGWVwpAyhZIN9k4DWBB41POpeWSBb5Mg4Df
         MTIohyCTXdObtSX/DOSdCB+QTX8PTfwatYiWAVSka8RUmKTn0WAjYm5qnQAWJr8H5WJ6
         98rR5FM/grTOfIH4Ca/rxQ30CJItpwKSK3XHdyBJJG30OzITG+ye/50YrpKdEGaYmGEj
         bF0TfSfy3Gc7tbedcnERXb4BGF4TphsnBkD4wDFnL1Rn3KUAbCx4eV5vE3lQBGOTohyT
         /qwxOAHpxIEV3rBQR+iTEpAZ5wL/FrPP7DzjV/H2hhgN2MdWVBdV/yXf1PcnQMvxrnhY
         OnTA==
X-Gm-Message-State: AGRZ1gLSy6Q+LeI1/b1maPHaVwO1PmKN0UnAj+3sdU1Vb8FUx6N7sdYg
        3MwxcF5F25LwtTFGDPFbIpFcOxjFzmfH
X-Google-Smtp-Source: AJdET5eEA1Pd02QZfD5a7C6T4IXQCb0VE5a9zjvqlztJ44lkmbts2EfWczPZ4uSiJ40IqvWR1qsoIr4pmV5I
X-Received: by 2002:a1f:10a5:: with SMTP id 37mr6054143vkq.16.1542154411058;
 Tue, 13 Nov 2018 16:13:31 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:43 -0800
Message-Id: <20181114001306.138053-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCHv3 00/23] Bring more repository handles into our code base
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This resends origin/sb/more-repo-in-api.

Unlike the previous resend (v2), this is not rebased to a newer base.
This doesn't contain the patch for pending semantic changes, as that
seems to go in its own topic branch.

Please have a look at the last 4 patches specifically as they were new in
the last iteration (but did not receive any comment), as they demonstrate
and fix a problem that is only exposed when using GIT_TEST_COMMIT_GRAPH=1
for the test suite.

Previous discussion at
https://public-inbox.org/git/20181030220817.61691-1-sbeller@google.com/

Thanks,
Stefan

Stefan Beller (23):
  sha1_file: allow read_object to read objects in arbitrary repositories
  packfile: allow has_packed_and_bad to handle arbitrary repositories
  object-store: allow read_object_file_extended to read from any repo
  object-store: prepare read_object_file to deal with any repo
  object-store: prepare has_{sha1, object}_file to handle any repo
  object: parse_object to honor its repository argument
  commit: allow parse_commit* to handle any repo
  commit-reach.c: allow paint_down_to_common to handle any repo
  commit-reach.c: allow merge_bases_many to handle any repo
  commit-reach.c: allow remove_redundant to handle any repo
  commit-reach.c: allow get_merge_bases_many_0 to handle any repo
  commit-reach: prepare get_merge_bases to handle any repo
  commit-reach: prepare in_merge_bases[_many] to handle any repo
  commit: prepare get_commit_buffer to handle any repo
  commit: prepare repo_unuse_commit_buffer to handle any repo
  commit: prepare logmsg_reencode to handle arbitrary repositories
  pretty: prepare format_commit_message to handle arbitrary repositories
  submodule: use submodule repos for object lookup
  submodule: don't add submodule as odb for push
  commit-graph: convert remaining functions to handle any repo
  commit: prepare free_commit_buffer and release_commit_memory for any
    repo
  path.h: make REPO_GIT_PATH_FUNC repository agnostic
  t/helper/test-repository: celebrate independence from the_repository

 builtin/fsck.c                                |   3 +-
 builtin/log.c                                 |   6 +-
 builtin/rev-list.c                            |   3 +-
 cache.h                                       |   2 +
 commit-graph.c                                |  40 +++--
 commit-reach.c                                |  73 +++++----
 commit-reach.h                                |  38 +++--
 commit.c                                      |  41 ++---
 commit.h                                      |  43 +++++-
 .../coccinelle/the_repository.pending.cocci   | 144 ++++++++++++++++++
 object-store.h                                |  35 ++++-
 object.c                                      |   8 +-
 packfile.c                                    |   5 +-
 packfile.h                                    |   2 +-
 path.h                                        |   2 +-
 pretty.c                                      |  28 ++--
 pretty.h                                      |   7 +-
 sha1-file.c                                   |  34 +++--
 streaming.c                                   |   2 +-
 submodule.c                                   |  76 ++++++---
 t/helper/test-repository.c                    |  10 ++
 21 files changed, 452 insertions(+), 150 deletions(-)
 create mode 100644 contrib/coccinelle/the_repository.pending.cocci

Range-diff:
 1:  1b9b5c695e =  1:  ca9fece80e sha1_file: allow read_object to read objects in arbitrary repositories
 2:  33b94066f2 =  2:  8eac25fe32 packfile: allow has_packed_and_bad to handle arbitrary repositories
 3:  5217b6b1e1 !  3:  06e5f83b66 object-store: allow read_object_file_extended to read from arbitrary repositories
    @@ -1,6 +1,6 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    object-store: allow read_object_file_extended to read from arbitrary repositories
    +    object-store: allow read_object_file_extended to read from any repo
     
         read_object_file_extended is not widely used, so migrate it all at once.
     
 4:  2b7239b55b !  4:  6167722608 object-store: prepare read_object_file to deal with arbitrary repositories
    @@ -1,6 +1,6 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    object-store: prepare read_object_file to deal with arbitrary repositories
    +    object-store: prepare read_object_file to deal with any repo
     
         As read_object_file is a widely used function (which is also regularly used
         in new code in flight between master..pu), changing its signature is painful
    @@ -13,16 +13,14 @@
         e675765235 (diff.c: remove implicit dependency on the_index, 2018-09-21)
     
         Add a coccinelle patch to convert existing callers, but do not apply
    -    the resulting patch from 'make coccicheck' to keep the diff of this
    -    patch small.
    +    the resulting patch to keep the diff of this patch small.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
      new file mode 100644
      --- /dev/null
    - +++ b/contrib/coccinelle/the_repository.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
     +// This file is used for the ongoing refactoring of
     +// bringing the index or repository struct in all of
 5:  24291f4d84 !  5:  2a88a868bb object-store: prepare has_{sha1, object}_file[_with_flags] to handle arbitrary repositories
    @@ -1,13 +1,12 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    object-store: prepare has_{sha1, object}_file[_with_flags] to handle arbitrary repositories
    +    object-store: prepare has_{sha1, object}_file to handle any repo
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - read_object_file(
      + repo_read_object_file(the_repository,
 6:  6aa209978e =  6:  fd4a151e07 object: parse_object to honor its repository argument
 7:  9b2d6aa7c3 !  7:  5484abc785 commit: allow parse_commit* to handle arbitrary repositories
    @@ -1,6 +1,6 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit: allow parse_commit* to handle arbitrary repositories
    +    commit: allow parse_commit* to handle any repo
     
         Just like the previous commit, parse_commit and friends are used a lot
         and are found in new patches, so we cannot change their signature easily.
    @@ -9,7 +9,6 @@
         argument and keep the original as a shallow macro.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/commit.c b/commit.c
      --- a/commit.c
    @@ -93,9 +92,9 @@
      
      struct buffer_slab;
     
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - has_object_file_with_flags(
      + repo_has_object_file_with_flags(the_repository,
 8:  0e7e681118 !  8:  8cc3054b31 commit-reach.c: allow paint_down_to_common to handle arbitrary repositories
    @@ -1,11 +1,10 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit-reach.c: allow paint_down_to_common to handle arbitrary repositories
    +    commit-reach.c: allow paint_down_to_common to handle any repo
     
         As the function is file local and not widely used, migrate it all at once.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/commit-reach.c b/commit-reach.c
      --- a/commit-reach.c
 9:  e83b26f5b3 !  9:  45e67ba283 commit-reach.c: allow merge_bases_many to handle arbitrary repositories
    @@ -1,9 +1,8 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit-reach.c: allow merge_bases_many to handle arbitrary repositories
    +    commit-reach.c: allow merge_bases_many to handle any repo
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/commit-reach.c b/commit-reach.c
      --- a/commit-reach.c
10:  d80b9de832 ! 10:  917d8cbaee commit-reach.c: allow remove_redundant to handle arbitrary repositories
    @@ -1,9 +1,8 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit-reach.c: allow remove_redundant to handle arbitrary repositories
    +    commit-reach.c: allow remove_redundant to handle any repo
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/commit-reach.c b/commit-reach.c
      --- a/commit-reach.c
11:  3ec21ad503 ! 11:  a008e62fea commit-reach.c: allow get_merge_bases_many_0 to handle arbitrary repositories
    @@ -1,9 +1,8 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit-reach.c: allow get_merge_bases_many_0 to handle arbitrary repositories
    +    commit-reach.c: allow get_merge_bases_many_0 to handle any repo
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/commit-reach.c b/commit-reach.c
      --- a/commit-reach.c
12:  3f21279f50 ! 12:  a50a7f52b0 commit-reach: prepare get_merge_bases to handle arbitrary repositories
    @@ -1,6 +1,6 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit-reach: prepare get_merge_bases to handle arbitrary repositories
    +    commit-reach: prepare get_merge_bases to handle any repo
     
         Similarly to previous patches, the get_merge_base functions are used
         often in the code base, which makes migrating them hard.
    @@ -9,7 +9,6 @@
         functions behind a wrapper macro.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/commit-reach.c b/commit-reach.c
      --- a/commit-reach.c
    @@ -91,9 +90,9 @@
      int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
      int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference);
     
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - parse_commit(
      + repo_parse_commit(the_repository,
13:  4decc3acc1 ! 13:  d82074d34b commit-reach: prepare in_merge_bases[_many] to handle arbitrary repositories
    @@ -1,9 +1,8 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit-reach: prepare in_merge_bases[_many] to handle arbitrary repositories
    +    commit-reach: prepare in_merge_bases[_many] to handle any repo
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/commit-reach.c b/commit-reach.c
      --- a/commit-reach.c
    @@ -76,9 +75,9 @@
      /*
       * Takes a list of commits and returns a new list where those
     
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - get_merge_bases_many_dirty(
      + repo_get_merge_bases_many_dirty(the_repository,
14:  141b86ea89 ! 14:  6035c18ca1 commit: prepare get_commit_buffer to handle arbitrary repositories
    @@ -1,9 +1,8 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit: prepare get_commit_buffer to handle arbitrary repositories
    +    commit: prepare get_commit_buffer to handle any repo
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/commit.c b/commit.c
      --- a/commit.c
    @@ -46,9 +45,9 @@
      /*
       * Tell the commit subsytem that we are done with a particular commit buffer.
     
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - in_merge_bases_many(
      + repo_in_merge_bases_many(the_repository,
15:  2cc415c1db ! 15:  85dcc6f806 commit: prepare repo_unuse_commit_buffer to handle arbitrary repositories
    @@ -1,9 +1,8 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit: prepare repo_unuse_commit_buffer to handle arbitrary repositories
    +    commit: prepare repo_unuse_commit_buffer to handle any repo
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/commit.c b/commit.c
      --- a/commit.c
    @@ -42,9 +41,9 @@
      /*
       * Free any cached object buffer associated with the commit.
     
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - get_commit_buffer(
      + repo_get_commit_buffer(the_repository,
16:  554daa8cfc ! 16:  0e1b98701f commit: prepare logmsg_reencode to handle arbitrary repositories
    @@ -24,9 +24,9 @@
      
      /** Removes the first commit from a list sorted by date, and adds all
     
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - unuse_commit_buffer(
      + repo_unuse_commit_buffer(the_repository,
17:  bd8737176b ! 17:  da611e902b pretty: prepare format_commit_message to handle arbitrary repositories
    @@ -5,9 +5,9 @@
         Signed-off-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - logmsg_reencode(
      + repo_logmsg_reencode(the_repository,
18:  b303ef65e7 ! 18:  a98112634e submodule: use submodule repos for object lookup
    @@ -7,7 +7,6 @@
         are not added to the main object store.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
    @@ -46,24 +45,23 @@
     + * in .gitmodules. This function exists only to preserve historical behavior,
     + *
     + * Returns 0 on success, -1 when the submodule is not present.
    -+ */
    -+static int open_submodule(struct repository *out, const char *path)
    +  */
    +-static void show_submodule_header(struct diff_options *o, const char *path,
    ++static struct repository *open_submodule(const char *path)
     +{
     +	struct strbuf sb = STRBUF_INIT;
    ++	struct repository *out = xmalloc(sizeof(*out));
     +
     +	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
     +		strbuf_release(&sb);
    -+		return -1;
    ++		free(out);
    ++		return NULL;
     +	}
     +
     +	out->submodule_prefix = xstrdup(path);
    -+	out->submodule_prefix = xstrfmt("%s%s/",
    -+					the_repository->submodule_prefix ?
    -+					the_repository->submodule_prefix :
    -+					"", path);
     +
     +	strbuf_release(&sb);
    -+	return 0;
    ++	return out;
     +}
     +
     +/*
    @@ -73,8 +71,7 @@
     + * If it can locate the submodule git directory it will create a repository
     + * handle for the submodule and lookup both the left and right commits and
     + * put them into the left and right pointers.
    -  */
    --static void show_submodule_header(struct diff_options *o, const char *path,
    ++ */
     +static void show_submodule_header(struct diff_options *o,
     +		const char *path,
      		struct object_id *one, struct object_id *two,
    @@ -116,11 +113,9 @@
      	struct rev_info rev;
      	struct commit *left = NULL, *right = NULL;
      	struct commit_list *merge_bases = NULL;
    -+	struct repository subrepo, *sub = &subrepo;
    -+
    -+	if (open_submodule(&subrepo, path) < 0)
    -+		sub = NULL;
    ++	struct repository *sub;
      
    ++	sub = open_submodule(path);
      	show_submodule_header(o, path, one, two, dirty_submodule,
     -			      &left, &right, &merge_bases);
     +			      sub, &left, &right, &merge_bases);
    @@ -147,8 +142,10 @@
      		free_commit_list(merge_bases);
      	clear_commit_marks(left, ~0);
      	clear_commit_marks(right, ~0);
    -+	if (sub)
    ++	if (sub) {
     +		repo_clear(sub);
    ++		free(sub);
    ++	}
      }
      
      void show_submodule_inline_diff(struct diff_options *o, const char *path,
    @@ -156,11 +153,9 @@
      	struct commit_list *merge_bases = NULL;
      	struct child_process cp = CHILD_PROCESS_INIT;
      	struct strbuf sb = STRBUF_INIT;
    -+	struct repository subrepo, *sub = &subrepo;
    -+
    -+	if (open_submodule(&subrepo, path) < 0)
    -+		sub = NULL;
    ++	struct repository *sub;
      
    ++	sub = open_submodule(path);
      	show_submodule_header(o, path, one, two, dirty_submodule,
     -			      &left, &right, &merge_bases);
     +			      sub, &left, &right, &merge_bases);
    @@ -171,8 +166,10 @@
      		clear_commit_marks(left, ~0);
      	if (right)
      		clear_commit_marks(right, ~0);
    -+	if (sub)
    ++	if (sub) {
     +		repo_clear(sub);
    ++		free(sub);
    ++	}
      }
      
      int should_update_submodules(void)
19:  dbb0dd9322 ! 19:  6aad29a006 submodule: don't add submodule as odb for push
    @@ -8,8 +8,10 @@
         objects, and the actual push is done by spawning another process,
         which handles object access by itself.)
     
    +    This code of push_submodule() is exercised in t5531 and continues
    +    to work, showing that the submodule odbc is not needed.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
 -:  ---------- > 20:  1687e96586 commit-graph: convert remaining functions to handle any repo
 -:  ---------- > 21:  d348185ca9 commit: prepare free_commit_buffer and release_commit_memory for any repo
 -:  ---------- > 22:  19f62807cc path.h: make REPO_GIT_PATH_FUNC repository agnostic
 -:  ---------- > 23:  61da0c2812 t/helper/test-repository: celebrate independence from the_repository
-- 
2.19.1.1215.g8438c0b245-goog

