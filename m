Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDF871F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJQH2m (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:28:42 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:47389 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeJQH2m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:28:42 -0400
Received: by mail-qt1-f202.google.com with SMTP id q6-v6so26766434qtb.14
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5bM7dHA3+rpa2OKdFPPny27Ax7N06cOQTFrx9EaOEGY=;
        b=rsSQaKrAKF+GzhQxQCsz50Z/crYVQtva6H253ulQIdism/dU8He7K2inUvxF7PrwN8
         l7vEhOLuc/a9YWjUbUyOQA3rS8DUkhU4lAqLgKtCNLWRP8ez1mOWoe1Xw+fypWX8V6cq
         H1Na30K8udb8+AVz2A5TVCYOe7zzAAxLA7DRzVhlcPoh1eZRpNDtY0g9eApVQJ4OI8Oq
         eQsybSyAoYvySAa5fL6lsdTQU2AWxDiGP/UscPb4/gjzMe0841Shwxe7OPjLjeme5uwZ
         eo3iyUUvOEbg86NHhvVfOLeVI+7Y2wQ6Fq9y6mo6s9j4oqXnOwieXY+qPlXUvSX6gJRI
         kvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5bM7dHA3+rpa2OKdFPPny27Ax7N06cOQTFrx9EaOEGY=;
        b=NFGcKwL55IFAAKXrn1ZL98nuBI1o+u8gDfW+zkJb6CLW9FiK5l/mCIvPGBSVea4ZS9
         Q0zjb/S89iCeFttx8v1jvrlsTBZjLmEjqMLnDXeGLj+kmlWu3oTBZlSqozLpuoAmqXWh
         hiTmccEUD/qrydiocsvOOUWfFXNqY/JtswDhnynNq83jaj2yF0/mI+ZfFZJWtW3mZDUO
         OLpdciaR2FDt0m19aSb7nzpH5KrEcKhMcJCpHw1oXx1pt7vohaPBOKxmcHP2bo55JU4m
         Z1QrMy5nygDBu384eY3SEkx33lG2Dv9dQYa+mJ2jCJqmZq6c0rIz6jdn4P0iHp1Qt4/5
         0Xsw==
X-Gm-Message-State: ABuFfoiuTc6btBHljCOnvmWI1MEG4jJdLpGm3h2pNTdY7HYCyKmzbn0u
        baBGKvUwnTz+WCmrOHhrWB5NIEhivVLfwM7U9/bKZ7C3av90UcbNWOjScMolTfI5BfBten8oYgg
        nza0ZHCk4BSzGuuMaoZ1SAit5dgARKHpZhJghC1zYrgHp+DcT2GrgcqVXoit4
X-Google-Smtp-Source: ACcGV61ymUtJnAQeOnAcZo+6AMtgBpYuOG7Nd+4KUh6aBBPvOeNQ9ASjBMsFcZ/Eh8dE70tzscy5fO0PSzzH
X-Received: by 2002:a0c:9214:: with SMTP id a20mr19275174qva.21.1539732955930;
 Tue, 16 Oct 2018 16:35:55 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:31 -0700
Message-Id: <20181016233550.251311-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 00/19] Bring more repository handles into our code base
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rerolls sb/more-repo-in-api.
It applies on nd/the-index merged with ds/reachable and is available via
    git fetch https://github.com/stefanbeller/git object-store-final-3

I addressed all of Jonathans comments, see range-diff below;
the last patch (applying the semantic patches) has been omitted as that
would produce a lot of merge conflicts. Without that patch, this merges
cleanly to next.

As for when to apply the semantic patches, I wondered if we would prefer a dirty merge
(created via "make coccicheck && git apply contrib/coccinelle/the_repository.cocci.patch")
of the semantic patches, or if we'd actually trickle in the changes over some time?

Thanks,
Stefan

An earlier RFC was sent out at
https://public-inbox.org/git/20181011211754.31369-1-sbeller@google.com/ and said:
    This applies on nd/the-index (b3c7eef9b05) and is the logical continuation of
    the object store series, which I sent over the last year.
    
    The previous series did take a very slow and pedantic approach,
    using a #define trick, see cfc62fc98c for details, but it turns out,
    that it doesn't work:
       When changing the signature of widely used functions, it burdens the
       maintainer in resolving the semantic conflicts.
       
       In the orginal approach this was called a feature, as then we can ensure
       that not bugs creep into the code base during the merge window (while such
       a refactoring series wanders from pu to master). It turns out this
       was not well received and was just burdensome.
       
       The #define trick doesn't buy us much to begin with when dealing with
       non-merge-conflicts.  For example, see deref_tag at tag.c:68, which got
       the repository argument in 286d258d4f (tag.c: allow deref_tag to handle
       arbitrary repositories, 2018-06-28) but lost its property of working on any
       repository while 8c4cc32689 (tag: don't warn if target is missing but
       promised, 2018-07-12) was in flight simultaneously.
       
       Another example of failure of this approach is seen in patch 5, which
       shows that the pedantry was missed.
            
    This series takes another approach as it doesn't change the signature of
    functions, but introduces new functions that can deal with arbitrary 
    repositories, keeping the old function signature around using a shallow wrapper.
    
    Additionally each patch adds a semantic patch, that would port from the old to
    the new function. These semantic patches are all applied in the very last patch,
    but we could omit applying the last patch if it causes too many merge conflicts
    and trickl in the semantic patches over time when there are no merge conflicts.
    
    
    The original goal of all these refactoring series was to remove add_submodule_odb 
    in submodule.c, which was partially reached with this series. I'll investigate the
    remaining calls in another series, but it shows we're close to be done with these
    large refactorings as far as I am concerned.
    
    Thanks,
    Stefan
    

Stefan Beller (19):
  sha1_file: allow read_object to read objects in arbitrary repositories
  packfile: allow has_packed_and_bad to handle arbitrary repositories
  object-store: allow read_object_file_extended to read from arbitrary
    repositories
  object-store: prepare read_object_file to deal with arbitrary
    repositories
  object-store: prepare has_{sha1, object}_file[_with_flags] to handle
    arbitrary repositories
  object: parse_object to honor its repository argument
  commit: allow parse_commit* to handle arbitrary repositories
  commit-reach.c: allow paint_down_to_common to handle arbitrary
    repositories
  commit-reach.c: allow merge_bases_many to handle arbitrary
    repositories
  commit-reach.c: allow remove_redundant to handle arbitrary
    repositories
  commit-reach.c: allow get_merge_bases_many_0 to handle arbitrary
    repositories
  commit-reach: prepare get_merge_bases to handle arbitrary repositories
  commit-reach: prepare in_merge_bases[_many] to handle arbitrary
    repositories
  commit: prepare get_commit_buffer to handle arbitrary repositories
  commit: prepare repo_unuse_commit_buffer to handle arbitrary
    repositories
  commit: prepare logmsg_reencode to handle arbitrary repositories
  pretty: prepare format_commit_message to handle arbitrary repositories
  submodule: use submodule repos for object lookup
  submodule: don't add submodule as odb for push

 commit-reach.c                          |  73 +++++++-----
 commit-reach.h                          |  38 +++++--
 commit.c                                |  32 ++++--
 commit.h                                |  39 ++++++-
 contrib/coccinelle/the_repository.cocci | 144 ++++++++++++++++++++++++
 object-store.h                          |  35 ++++--
 object.c                                |   6 +-
 packfile.c                              |   5 +-
 packfile.h                              |   2 +-
 pretty.c                                |  28 ++---
 pretty.h                                |   7 +-
 sha1-file.c                             |  34 +++---
 streaming.c                             |   2 +-
 submodule.c                             |  78 ++++++++++---
 14 files changed, 402 insertions(+), 121 deletions(-)
 create mode 100644 contrib/coccinelle/the_repository.cocci

 git range-diff origin/sb/more-repo-in-api...

 -:  ---------- >  1:  5227c38566 commit-reach: move walk methods from commit.c
 -:  ---------- >  2:  6404355657 commit.h: remove method declarations
 -:  ---------- >  3:  1d614d41e5 commit-reach: move ref_newer from remote.c
 -:  ---------- >  4:  920f93ca1c commit-reach: move commit_contains from ref-filter
 -:  ---------- >  5:  f044bb49ad upload-pack: make reachable() more generic
 -:  ---------- >  6:  921bf7734f upload-pack: refactor ok_to_give_up()
 -:  ---------- >  7:  118be5785e upload-pack: generalize commit date cutoff
 -:  ---------- >  8:  ba3ca1edce commit-reach: move can_all_from_reach_with_flags
 -:  ---------- >  9:  ab176ac4ae test-reach: create new test tool for ref_newer
 -:  ---------- > 10:  5cd52de326 test-reach: test in_merge_bases
 -:  ---------- > 11:  6255232ec1 test-reach: test is_descendant_of
 -:  ---------- > 12:  324dec0191 test-reach: test get_merge_bases_many
 -:  ---------- > 13:  0c89f715d0 test-reach: test reduce_heads
 -:  ---------- > 14:  1792bc1250 test-reach: test can_all_from_reach_with_flags
 -:  ---------- > 15:  1fee124257 test-reach: test commit_contains
 -:  ---------- > 16:  1e3497a24c commit-reach: replace ref_newer logic
 -:  ---------- > 17:  4fbcca4eff commit-reach: make can_all_from_reach... linear
 -:  ---------- > 18:  6cc017431c commit-reach: use can_all_from_reach
 -:  ---------- > 19:  6621c83874 commit-reach: correct accidental #include of C file
 -:  ---------- > 20:  b67f6b26e3 commit-reach: properly peel tags
 -:  ---------- > 21:  4067a64672 commit-reach: fix memory and flag leaks
 1:  2c13c6101f = 22:  14c12a5350 sha1_file: allow read_object to read objects in arbitrary repositories
 2:  82848c2571 = 23:  f978950604 packfile: allow has_packed_and_bad to handle arbitrary repositories
 3:  717023d801 = 24:  852f6696d1 object-store: allow read_object_file_extended to read from arbitrary repositories
 4:  fab6bdfad0 ! 25:  b185b88ad8 object-store: prepare read_object_file to deal with arbitrary repositories
    @@ -9,7 +9,7 @@
     
         Introduce repo_read_object_file which takes the repository argument, and
         hide the original read_object_file as a macro behind
    -    NO_THE_REPOSITORY_COMPATIBILITY_MACROS, which we planned for in
    +    NO_THE_REPOSITORY_COMPATIBILITY_MACROS, similar to
         e675765235 (diff.c: remove implicit dependency on the_index, 2018-09-21)
     
         Add a coccinelle patch to convert existing callers, but do not apply
 -:  ---------- > 26:  009d6f350b object-store: prepare has_{sha1, object}_file[_with_flags] to handle arbitrary repositories
 5:  9e34d76c53 ! 27:  df2feb2baf object: parse_object to honor its repository argument
    @@ -12,6 +12,17 @@
     diff --git a/object.c b/object.c
     --- a/object.c
     +++ b/object.c
    +@@
    + 	if (obj && obj->parsed)
    + 		return obj;
    + 
    +-	if ((obj && obj->type == OBJ_BLOB && has_object_file(oid)) ||
    +-	    (!obj && has_object_file(oid) &&
    ++	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
    ++	    (!obj && repo_has_object_file(r, oid) &&
    + 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
    + 		if (check_object_signature(repl, NULL, 0, NULL) < 0) {
    + 			error(_("sha1 mismatch %s"), oid_to_hex(oid));
     @@
      		return lookup_object(r, oid->hash);
      	}
 6:  9cb7efc7b2 ! 28:  18b7073c25 commit: allow parse_commit* to handle arbitrary repositories
    @@ -97,9 +97,10 @@
     --- a/contrib/coccinelle/the_repository.cocci
     +++ b/contrib/coccinelle/the_repository.cocci
     @@
    - + repo_read_object_file(the_repository,
    -   E, F, G)
    - 
    + - has_object_file_with_flags(
    + + repo_has_object_file_with_flags(the_repository,
    +   E)
    ++
     +@@
     +expression E;
     +expression F;
    @@ -123,4 +124,3 @@
     +- parse_commit(
     ++ repo_parse_commit(the_repository,
     +  E)
    -+
 7:  fcab4a4000 ! 29:  48f8999e95 commit.c: allow paint_down_to_common to handle arbitrary repositories
    @@ -1,15 +1,14 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit.c: allow paint_down_to_common to handle arbitrary repositories
    +    commit-reach.c: allow paint_down_to_common to handle arbitrary repositories
     
         As the function is file local and not widely used, migrate it all at once.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    -diff --git a/commit.c b/commit.c
    ---- a/commit.c
    -+++ b/commit.c
    +diff --git a/commit-reach.c b/commit-reach.c
    +--- a/commit-reach.c
    ++++ b/commit-reach.c
     @@
      }
      
 8:  324422f0d3 ! 30:  b84d32c972 commit.c: allow merge_bases_many to handle arbitrary repositories
    @@ -1,13 +1,12 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit.c: allow merge_bases_many to handle arbitrary repositories
    +    commit-reach.c: allow merge_bases_many to handle arbitrary repositories
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    -diff --git a/commit.c b/commit.c
    ---- a/commit.c
    -+++ b/commit.c
    +diff --git a/commit-reach.c b/commit-reach.c
    +--- a/commit-reach.c
    ++++ b/commit-reach.c
     @@
      	return result;
      }
 9:  9c43e74d6c ! 31:  cd0e595b8d commit.c: allow remove_redundant to handle arbitrary repositories
    @@ -1,13 +1,12 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit.c: allow remove_redundant to handle arbitrary repositories
    +    commit-reach.c: allow remove_redundant to handle arbitrary repositories
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    -diff --git a/commit.c b/commit.c
    ---- a/commit.c
    -+++ b/commit.c
    +diff --git a/commit-reach.c b/commit-reach.c
    +--- a/commit-reach.c
    ++++ b/commit-reach.c
     @@
      	return ret;
      }
10:  e5c2e2fa8e ! 32:  40ebd46acd commit: allow get_merge_bases_many_0 to handle arbitrary repositories
    @@ -1,13 +1,12 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit: allow get_merge_bases_many_0 to handle arbitrary repositories
    +    commit-reach.c: allow get_merge_bases_many_0 to handle arbitrary repositories
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    -diff --git a/commit.c b/commit.c
    ---- a/commit.c
    -+++ b/commit.c
    +diff --git a/commit-reach.c b/commit-reach.c
    +--- a/commit-reach.c
    ++++ b/commit-reach.c
     @@
      	return filled;
      }
11:  27d4669ccb ! 33:  151cc8cd9b commit: prepare get_merge_bases to handle arbitrary repositories
    @@ -1,6 +1,6 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit: prepare get_merge_bases to handle arbitrary repositories
    +    commit-reach: prepare get_merge_bases to handle arbitrary repositories
     
         Similarly to previous patches, the get_merge_base functions are used
         often in the code base, which makes migrating them hard.
    @@ -9,11 +9,10 @@
         functions behind a wrapper macro.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    -diff --git a/commit.c b/commit.c
    ---- a/commit.c
    -+++ b/commit.c
    +diff --git a/commit-reach.c b/commit-reach.c
    +--- a/commit-reach.c
    ++++ b/commit-reach.c
     @@
      	return result;
      }
    @@ -53,16 +52,21 @@
      
      /*
     
    -diff --git a/commit.h b/commit.h
    ---- a/commit.h
    -+++ b/commit.h
    +diff --git a/commit-reach.h b/commit-reach.h
    +--- a/commit-reach.h
    ++++ b/commit-reach.h
     @@
    - int register_commit_graft(struct repository *r, struct commit_graft *, int);
    - struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
    + struct contains_cache;
    + struct ref_filter;
      
    --extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
    --extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos);
    --extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
    +-struct commit_list *get_merge_bases_many(struct commit *one,
    +-					 int n,
    +-					 struct commit **twos);
    +-struct commit_list *get_merge_bases_many_dirty(struct commit *one,
    +-					       int n,
    +-					       struct commit **twos);
    +-struct commit_list *get_merge_bases(struct commit *one, struct commit *two);
    +-struct commit_list *get_octopus_merge_bases(struct commit_list *in);
     -
     +struct commit_list *repo_get_merge_bases(struct repository *r,
     +					 struct commit *rev1,
    @@ -71,7 +75,7 @@
     +					      struct commit *one, int n,
     +					      struct commit **twos);
      /* To be used only when object flags after this call no longer matter */
    --extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, struct commit **twos);
    +-struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, struct commit **twos);
     +struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
     +						    struct commit *one, int n,
     +						    struct commit **twos);
    @@ -80,18 +84,20 @@
     +#define get_merge_bases_many(one, n, two) repo_get_merge_bases_many(the_repository, one, n, two)
     +#define get_merge_bases_many_dirty(one, n, twos) repo_get_merge_bases_many_dirty(the_repository, one, n, twos)
     +#endif
    -+extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
    ++
    ++struct commit_list *get_octopus_merge_bases(struct commit_list *in);
      
    - /* largest positive number a signed 32-bit integer can contain */
    - #define INFINITE_DEPTH 0x7fffffff
    + int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
    + int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference);
     
     diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
     --- a/contrib/coccinelle/the_repository.cocci
     +++ b/contrib/coccinelle/the_repository.cocci
     @@
    + - parse_commit(
      + repo_parse_commit(the_repository,
        E)
    - 
    ++
     +@@
     +expression E;
     +expression F;
13:  977359ec86 ! 34:  b508acf4fd commit: prepare in_merge_bases[_many] to handle arbitrary repositories
    @@ -1,13 +1,12 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    commit: prepare in_merge_bases[_many] to handle arbitrary repositories
    +    commit-reach: prepare in_merge_bases[_many] to handle arbitrary repositories
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    -diff --git a/commit.c b/commit.c
    ---- a/commit.c
    -+++ b/commit.c
    +diff --git a/commit-reach.c b/commit-reach.c
    +--- a/commit-reach.c
    ++++ b/commit-reach.c
     @@
      /*
       * Is "commit" an ancestor of one of the "references"?
    @@ -53,33 +52,36 @@
      
      struct commit_list *reduce_heads(struct commit_list *heads)
     
    -diff --git a/commit.h b/commit.h
    ---- a/commit.h
    -+++ b/commit.h
    +diff --git a/commit-reach.h b/commit-reach.h
    +--- a/commit-reach.h
    ++++ b/commit-reach.h
     @@
    - extern struct trace_key trace_shallow;
    + struct commit_list *get_octopus_merge_bases(struct commit_list *in);
      
    - int is_descendant_of(struct commit *, struct commit_list *);
    --int in_merge_bases(struct commit *, struct commit *);
    --int in_merge_bases_many(struct commit *, int, struct commit **);
    -+int repo_in_merge_bases(struct repository *r, struct commit *, struct commit *);
    -+int repo_in_merge_bases_many(struct repository *r, struct commit *, int, struct commit **);
    + int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
    +-int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference);
    +-int in_merge_bases(struct commit *commit, struct commit *reference);
    ++int repo_in_merge_bases(struct repository *r,
    ++			struct commit *commit,
    ++			struct commit *reference);
    ++int repo_in_merge_bases_many(struct repository *r,
    ++			     struct commit *commit,
    ++			     int nr_reference, struct commit **reference);
     +#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
     +#define in_merge_bases(c1, c2) repo_in_merge_bases(the_repository, c1, c2)
     +#define in_merge_bases_many(c1, n, cs) repo_in_merge_bases_many(the_repository, c1, n, cs)
     +#endif
      
    - extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
    - extern int run_add_interactive(const char *revision, const char *patch_mode,
    + /*
    +  * Takes a list of commits and returns a new list where those
     
     diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
     --- a/contrib/coccinelle/the_repository.cocci
     +++ b/contrib/coccinelle/the_repository.cocci
     @@
    - - get_commit_buffer(
    - + repo_get_commit_buffer(the_repository,
    -   E, F);
    -+
    + + repo_get_merge_bases_many_dirty(the_repository,
    +   E, F, G);
    + 
     +@@
     +expression E;
     +expression F;
12:  044bf2917c ! 35:  c825f2703c commit: prepare get_commit_buffer to handle arbitrary repositories
    @@ -3,7 +3,6 @@
         commit: prepare get_commit_buffer to handle arbitrary repositories
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/commit.c b/commit.c
     --- a/commit.c
    @@ -50,9 +49,10 @@
     --- a/contrib/coccinelle/the_repository.cocci
     +++ b/contrib/coccinelle/the_repository.cocci
     @@
    - + repo_get_merge_bases_many_dirty(the_repository,
    + - in_merge_bases_many(
    + + repo_in_merge_bases_many(the_repository,
        E, F, G);
    - 
    ++
     +@@
     +expression E;
     +expression F;
14:  65771970b9 ! 36:  bea6ff2e6d commit: prepare repo_unuse_commit_buffer to handle arbitrary repositories
    @@ -3,7 +3,6 @@
         commit: prepare repo_unuse_commit_buffer to handle arbitrary repositories
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/commit.c b/commit.c
     --- a/commit.c
    @@ -46,9 +45,10 @@
     --- a/contrib/coccinelle/the_repository.cocci
     +++ b/contrib/coccinelle/the_repository.cocci
     @@
    + - get_commit_buffer(
      + repo_get_commit_buffer(the_repository,
        E, F);
    - 
    ++
     +@@
     +expression E;
     +expression F;
    @@ -56,7 +56,3 @@
     +- unuse_commit_buffer(
     ++ repo_unuse_commit_buffer(the_repository,
     +  E, F);
    -+
    - @@
    - expression E;
    - expression F;
15:  ddef24685d ! 37:  11ea084cd2 commit: prepare logmsg_reencode to handle arbitrary repositories
    @@ -28,9 +28,9 @@
     --- a/contrib/coccinelle/the_repository.cocci
     +++ b/contrib/coccinelle/the_repository.cocci
     @@
    - - in_merge_bases_many(
    - + repo_in_merge_bases_many(the_repository,
    -   E, F, G);
    + - unuse_commit_buffer(
    + + repo_unuse_commit_buffer(the_repository,
    +   E, F);
     +
     +@@
     +expression E;
16:  8612153e23 = 38:  9f50edd155 pretty: prepare format_commit_message to handle arbitrary repositories
17:  eba296fc18 ! 39:  1a4a392233 submodule: use submodule repos for object lookup
    @@ -7,7 +7,6 @@
         are not added to the main object store.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/submodule.c b/submodule.c
     --- a/submodule.c
    @@ -35,12 +34,15 @@
      			 DEFAULT_GIT_DIR_ENVIRONMENT);
      }
      
    +-/* Helper function to display the submodule header line prior to the full
    +- * summary output. If it can locate the submodule objects directory it will
    +- * attempt to lookup both the left and right commits and put them into the
    +- * left and right pointers.
     +/*
     + * Initialize 'out' based on the provided submodule path.
     + *
     + * Unlike repo_submodule_init, this tolerates submodules not present
    -+ * in .gitmodules. NEEDSWORK: The repo_submodule_init behavior is
    -+ * preferrable. This function exists only to preserve historical behavior.
    ++ * in .gitmodules. This function exists only to preserve historical behavior,
     + *
     + * Returns 0 on success, -1 when the submodule is not present.
     + */
    @@ -54,28 +56,38 @@
     +	}
     +
     +	out->submodule_prefix = xstrdup(path);
    ++	out->submodule_prefix = xstrfmt("%s%s/",
    ++					the_repository->submodule_prefix ?
    ++					the_repository->submodule_prefix :
    ++					"", path);
     +
     +	strbuf_release(&sb);
     +	return 0;
     +}
     +
    - /* Helper function to display the submodule header line prior to the full
    -  * summary output. If it can locate the submodule objects directory it will
    -  * attempt to lookup both the left and right commits and put them into the
    -  * left and right pointers.
    ++/*
    ++ * Helper function to display the submodule header line prior to the full
    ++ * summary output.
    ++ *
    ++ * If it can locate the submodule git directory it will create a repository
    ++ * handle for the submodule and lookup both the left and right commits and
    ++ * put them into the left and right pointers.
       */
     -static void show_submodule_header(struct diff_options *o, const char *path,
    -+static void show_submodule_header(struct diff_options *o, struct repository *sub,
    ++static void show_submodule_header(struct diff_options *o,
     +		const char *path,
      		struct object_id *one, struct object_id *two,
      		unsigned dirty_submodule,
    ++		struct repository *sub,
      		struct commit **left, struct commit **right,
    + 		struct commit_list **merge_bases)
    + {
     @@
      	else if (is_null_oid(two))
      		message = "(submodule deleted)";
      
     -	if (add_submodule_odb(path)) {
    -+	if (open_submodule(sub, path) < 0) {
    ++	if (!sub) {
      		if (!message)
      			message = "(commits not present)";
      		goto output_header;
    @@ -103,30 +115,63 @@
      	struct rev_info rev;
      	struct commit *left = NULL, *right = NULL;
      	struct commit_list *merge_bases = NULL;
    -+	struct repository sub;
    ++	struct repository subrepo, *sub = &subrepo;
    ++
    ++	if (open_submodule(&subrepo, path) < 0)
    ++		sub = NULL;
      
    --	show_submodule_header(o, path, one, two, dirty_submodule,
    -+	show_submodule_header(o, &sub, path, one, two, dirty_submodule,
    - 			      &left, &right, &merge_bases);
    + 	show_submodule_header(o, path, one, two, dirty_submodule,
    +-			      &left, &right, &merge_bases);
    ++			      sub, &left, &right, &merge_bases);
      
      	/*
    + 	 * If we don't have both a left and a right pointer, there is no
    + 	 * reason to try and display a summary. The header line should contain
    + 	 * all the information the user needs.
    + 	 */
    +-	if (!left || !right)
    ++	if (!left || !right || !sub)
    + 		goto out;
    + 
    + 	/* Treat revision walker failure the same as missing commits */
     @@
      		goto out;
      	}
      
     -	print_submodule_summary(&rev, o);
    -+	print_submodule_summary(&sub, &rev, o);
    ++	print_submodule_summary(sub, &rev, o);
      
      out:
      	if (merge_bases)
    + 		free_commit_list(merge_bases);
    + 	clear_commit_marks(left, ~0);
    + 	clear_commit_marks(right, ~0);
    ++	if (sub)
    ++		repo_clear(sub);
    + }
    + 
    + void show_submodule_inline_diff(struct diff_options *o, const char *path,
     @@
      	struct commit_list *merge_bases = NULL;
      	struct child_process cp = CHILD_PROCESS_INIT;
      	struct strbuf sb = STRBUF_INIT;
    -+	struct repository sub;
    ++	struct repository subrepo, *sub = &subrepo;
    ++
    ++	if (open_submodule(&subrepo, path) < 0)
    ++		sub = NULL;
      
    --	show_submodule_header(o, path, one, two, dirty_submodule,
    -+	show_submodule_header(o, &sub, path, one, two, dirty_submodule,
    - 			      &left, &right, &merge_bases);
    + 	show_submodule_header(o, path, one, two, dirty_submodule,
    +-			      &left, &right, &merge_bases);
    ++			      sub, &left, &right, &merge_bases);
      
      	/* We need a valid left and right commit to display a difference */
    + 	if (!(left || is_null_oid(one)) ||
    +@@
    + 		clear_commit_marks(left, ~0);
    + 	if (right)
    + 		clear_commit_marks(right, ~0);
    ++	if (sub)
    ++		repo_clear(sub);
    + }
    + 
    + int should_update_submodules(void)
18:  4b2033017a ! 40:  1ce2d0a867 submodule: don't add submodule as odb for push
    @@ -2,20 +2,13 @@
     
         submodule: don't add submodule as odb for push
     
    -    The submodule was added as an alternative in eb21c732d6 (push: teach
    -    --recurse-submodules the on-demand option, 2012-03-29), but was
    -    not explained, why.
    -
    -    In similar code, submodule_has_commits, the submodule is added as an
    -    alternative to perform a quick check if we need to dive into the submodule.
    -
    -    However in push_submodule
    -    (a) for_each_remote_ref_submodule will also provide the quick check and
    -    (b) after that we don't need to have submodule objects around, as all
    -        further code is to spawn a separate process.
    +    In push_submodule(), because we do not actually need access to objects
    +    in the submodule, do not invoke add_submodule_odb().
    +    (for_each_remote_ref_submodule() does not require access to those
    +    objects, and the actual push is done by spawning another process,
    +    which handles object access by itself.)
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/submodule.c b/submodule.c
     --- a/submodule.c
19:  c74af1496b <  -:  ---------- Apply semantic patches from previous patches
