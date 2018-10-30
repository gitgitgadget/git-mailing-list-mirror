Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143931F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeJaHDr (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:03:47 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:33399 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbeJaHDr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:03:47 -0400
Received: by mail-vs1-f74.google.com with SMTP id t25so3060778vsk.0
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=tL0fLw0DG14tIsi5L5BndcgvlrWVFPQLDz43CO2QiCg=;
        b=b1yMPsO5KaOBgY1XjbBvmyo0yK570S1QUTpP/VF9oVsg+Zrm0OlTfib0V5CjrWq0XW
         jEsV1/teAqMnsRtgY3MHw0hl3yfl9FNCXlROUlPn71ZqqQGMieoEVW2Icf5bGwv6jOH9
         Yt/i5+50psrhuGtVn/0LBX0/SPldkg+yz9vru0QApKzr5fEoFjfhR/TFsugf1J1i9hUM
         3w3pAK1uygpeX3274zDMWIA82b0KmCHwz65j+Mx/nrVfRwaCv+MMhbgp09AxpghkwHM3
         5SCTBLz0zO5Zyk0Z5cUWGBuNnSDNj/C+Qn2JovMoJ4ZMhcpXw56I6Rb+dlfoJn1upnIw
         GsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=tL0fLw0DG14tIsi5L5BndcgvlrWVFPQLDz43CO2QiCg=;
        b=QGwKJc6zXXxvQP+IDg10Ze7GKwabnRPzA2tXCc+6mY8LTD1ImCjshCBChtMKmVQrxO
         vXSupcWT4b27KnXDrGRpOqDRUZ9+8+Fe9SYOUa5N2KS0vqQzmlRcuaCwRfr+vVqvTnFP
         E/p3PFYMbDBUbgTSfXqnG99gWFvoQhGX9FnTQs6/LW2a7KQzeyNFLOAxVsaCa0ic7ipu
         Ssy9eE8dLXxzNlHc/Gl18RXxru/YXvQevxuwB2ubfsUshvijjczRI+4TWjCPAXAyf3NX
         wgjpUMqpVojBfxMJkfo3Q8EbqBi8LWDpzo284CpXewOwnFyE0noWPJ9n55xcTJz+ZUDk
         P2Jg==
X-Gm-Message-State: AGRZ1gK+kIteCiY3eAK8GzdhlSzgr44dB8/GvXH5t2Nqy3bXdDr03G2a
        B1KKZi9UXOtj50C397mzwPH2Cpq+pMQcK6zNV0dPWivKSQuIl26gXkqk7bWcMwLX5Ul8PXMKwmO
        8WA05njj3FVomgnUfhSLsimlEKtHFhs25k5DkZS4ZBJtlyep2ooWVfgxhSmxX
X-Google-Smtp-Source: AJdET5e05yuqewFN5h+Zylic6MOJ8YfCqfC1PXtaz3iTKkIJtxW1wIFp69WkacVaJU9J7LOmRsbm2Xn+K3Ud
X-Received: by 2002:a67:878a:: with SMTP id j132-v6mr472350vsd.43.1540937310368;
 Tue, 30 Oct 2018 15:08:30 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:07:53 -0700
Message-Id: <20181030220817.61691-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCHv2 00/24] Bring more repository handles into our code base]
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This resends sb/more-repo-in-api

On Thu, Oct 25, 2018 at 2:14 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> On Tue, Oct 16, 2018 at 04:35:49PM -0700, Stefan Beller wrote:
> > This converts the 'show_submodule_header' function to use
> > the repository API properly, such that the submodule objects
> > are not added to the main object store.
>
> This patch breaks the test suite with 'GIT_TEST_COMMIT_GRAPH=3D1', in
> particular 't4041-diff-submodule-option.sh' fails with:
> [...]

I debugged into this and the last four patches will fix it.

I also picked up the patch for pending semantic patches, as the
first patch, can I have your sign off, please?

This also addresses Jonathans feedback in
https://public-inbox.org/git/20181019203750.110741-1-jonathantanmy@google.c=
om/

A range-diff is below.

Thanks,
Stefan

SZEDER G=C3=A1bor (1):
  Makefile: add pending semantic patches

Stefan Beller (23):
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
  commit-graph: convert remaining function to handle arbitrary
    repositories
  commit: make free_commit_buffer and release_commit_memory repository
    agnostic
  path.h: make REPO_GIT_PATH_FUNC repository agnostic
  t/helper/test-repository: celebrate independence from the_repository

 Makefile                                      |   6 +-
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
 submodule.c                                   |  79 +++++++---
 t/helper/test-repository.c                    |  10 ++
 22 files changed, 459 insertions(+), 152 deletions(-)
 create mode 100644 contrib/coccinelle/the_repository.pending.cocci

git range-diff origin/sb/more-repo-in-api...
[...] # rebased to origin/master
  -:  ---------- > 116:  4ede3d42df Seventh batch for 2.20
  -:  ---------- > 117:  b1de196491 Makefile: add pending semantic patches
  1:  1b9b5c695e =3D 118:  f1be5eb487 sha1_file: allow read_object to read =
objects in arbitrary repositories
  2:  33b94066f2 =3D 119:  9100a5705d packfile: allow has_packed_and_bad to=
 handle arbitrary repositories
  3:  5217b6b1e1 =3D 120:  a4ad7791da object-store: allow read_object_file_=
extended to read from arbitrary repositories
  4:  2b7239b55b ! 121:  5d7b3a6dd9 object-store: prepare read_object_file =
to deal with arbitrary repositories
    @@ -19,10 +19,10 @@
         Signed-off-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccin=
elle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contri=
b/coccinelle/the_repository.pending.cocci
      new file mode 100644
      --- /dev/null
    - +++ b/contrib/coccinelle/the_repository.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
     +// This file is used for the ongoing refactoring of
     +// bringing the index or repository struct in all of
    @@ -36,6 +36,7 @@
     +- read_object_file(
     ++ repo_read_object_file(the_repository,
     +  E, F, G)
    ++
    =20
      diff --git a/object-store.h b/object-store.h
      --- a/object-store.h
  5:  24291f4d84 ! 122:  77d406fc51 object-store: prepare has_{sha1, object=
}_file[_with_flags] to handle arbitrary repositories
    @@ -3,16 +3,14 @@
         object-store: prepare has_{sha1, object}_file[_with_flags] to hand=
le arbitrary repositories
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccin=
elle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contri=
b/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
    - - read_object_file(
      + repo_read_object_file(the_repository,
        E, F, G)
    -+
    +=20
     +@@
     +expression E;
     +@@
  6:  6aa209978e =3D 123:  7224b378d8 object: parse_object to honor its rep=
ository argument
  7:  9b2d6aa7c3 ! 124:  e4d4ae08ca commit: allow parse_commit* to handle a=
rbitrary repositories
    @@ -93,9 +93,9 @@
     =20
      struct buffer_slab;
    =20
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccin=
elle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contri=
b/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - has_object_file_with_flags(
      + repo_has_object_file_with_flags(the_repository,
  8:  0e7e681118 ! 125:  f739ef6078 commit-reach.c: allow paint_down_to_com=
mon to handle arbitrary repositories
    @@ -5,7 +5,6 @@
         As the function is file local and not widely used, migrate it all =
at once.
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/commit-reach.c b/commit-reach.c
      --- a/commit-reach.c
  9:  e83b26f5b3 ! 126:  c054a80564 commit-reach.c: allow merge_bases_many =
to handle arbitrary repositories
    @@ -3,7 +3,6 @@
         commit-reach.c: allow merge_bases_many to handle arbitrary reposit=
ories
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/commit-reach.c b/commit-reach.c
      --- a/commit-reach.c
 10:  d80b9de832 ! 127:  3434a5a262 commit-reach.c: allow remove_redundant =
to handle arbitrary repositories
    @@ -3,7 +3,6 @@
         commit-reach.c: allow remove_redundant to handle arbitrary reposit=
ories
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/commit-reach.c b/commit-reach.c
      --- a/commit-reach.c
 11:  3ec21ad503 ! 128:  82f6e797bf commit-reach.c: allow get_merge_bases_m=
any_0 to handle arbitrary repositories
    @@ -3,7 +3,6 @@
         commit-reach.c: allow get_merge_bases_many_0 to handle arbitrary r=
epositories
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/commit-reach.c b/commit-reach.c
      --- a/commit-reach.c
 12:  3f21279f50 ! 129:  b66b636a97 commit-reach: prepare get_merge_bases t=
o handle arbitrary repositories
    @@ -9,7 +9,6 @@
         functions behind a wrapper macro.
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/commit-reach.c b/commit-reach.c
      --- a/commit-reach.c
    @@ -91,9 +90,9 @@
      int is_descendant_of(struct commit *commit, struct commit_list *with_=
commit);
      int in_merge_bases_many(struct commit *commit, int nr_reference, stru=
ct commit **reference);
    =20
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccin=
elle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contri=
b/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - parse_commit(
      + repo_parse_commit(the_repository,
    @@ -124,3 +123,4 @@
     +- get_merge_bases_many_dirty(
     ++ repo_get_merge_bases_many_dirty(the_repository,
     +  E, F, G);
    ++
 13:  4decc3acc1 ! 130:  e68e48ca91 commit-reach: prepare in_merge_bases[_m=
any] to handle arbitrary repositories
    @@ -3,7 +3,6 @@
         commit-reach: prepare in_merge_bases[_many] to handle arbitrary re=
positories
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/commit-reach.c b/commit-reach.c
      --- a/commit-reach.c
    @@ -76,14 +75,13 @@
      /*
       * Takes a list of commits and returns a new list where those
    =20
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccin=
elle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contri=
b/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
    - - get_merge_bases_many_dirty(
      + repo_get_merge_bases_many_dirty(the_repository,
        E, F, G);
    -+
    +=20
     +@@
     +expression E;
     +expression F;
 14:  141b86ea89 ! 131:  aac401ca98 commit: prepare get_commit_buffer to ha=
ndle arbitrary repositories
    @@ -3,7 +3,6 @@
         commit: prepare get_commit_buffer to handle arbitrary repositories
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/commit.c b/commit.c
      --- a/commit.c
    @@ -46,9 +45,9 @@
      /*
       * Tell the commit subsytem that we are done with a particular commit=
 buffer.
    =20
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccin=
elle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contri=
b/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - in_merge_bases_many(
      + repo_in_merge_bases_many(the_repository,
 15:  2cc415c1db ! 132:  c45e6d2c0c commit: prepare repo_unuse_commit_buffe=
r to handle arbitrary repositories
    @@ -3,7 +3,6 @@
         commit: prepare repo_unuse_commit_buffer to handle arbitrary repos=
itories
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/commit.c b/commit.c
      --- a/commit.c
    @@ -42,9 +41,9 @@
      /*
       * Free any cached object buffer associated with the commit.
    =20
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccin=
elle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contri=
b/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - get_commit_buffer(
      + repo_get_commit_buffer(the_repository,
 16:  554daa8cfc ! 133:  25e8f5dec4 commit: prepare logmsg_reencode to hand=
le arbitrary repositories
    @@ -24,9 +24,9 @@
     =20
      /** Removes the first commit from a list sorted by date, and adds all
    =20
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccin=
elle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contri=
b/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - unuse_commit_buffer(
      + repo_unuse_commit_buffer(the_repository,
 17:  bd8737176b ! 134:  2cab6c18b6 pretty: prepare format_commit_message t=
o handle arbitrary repositories
    @@ -5,9 +5,9 @@
         Signed-off-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
    - diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccin=
elle/the_repository.cocci
    - --- a/contrib/coccinelle/the_repository.cocci
    - +++ b/contrib/coccinelle/the_repository.cocci
    + diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contri=
b/coccinelle/the_repository.pending.cocci
    + --- a/contrib/coccinelle/the_repository.pending.cocci
    + +++ b/contrib/coccinelle/the_repository.pending.cocci
     @@
      - logmsg_reencode(
      + repo_logmsg_reencode(the_repository,
 18:  b303ef65e7 ! 135:  794592c573 submodule: use submodule repos for obje=
ct lookup
    @@ -7,7 +7,6 @@
         are not added to the main object store.
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
    @@ -46,24 +45,26 @@
     + * in .gitmodules. This function exists only to preserve historical b=
ehavior,
     + *
     + * Returns 0 on success, -1 when the submodule is not present.
    -+ */
    -+static int open_submodule(struct repository *out, const char *path)
    +  */
    +-static void show_submodule_header(struct diff_options *o, const char =
*path,
    ++static struct repository *open_submodule(const char *path)
     +{
     +	struct strbuf sb =3D STRBUF_INIT;
    ++	struct repository *out =3D xmalloc(sizeof(*out));
     +
     +	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) =
{
     +		strbuf_release(&sb);
    -+		return -1;
    ++		free(out);
    ++		return NULL;
     +	}
     +
    -+	out->submodule_prefix =3D xstrdup(path);
     +	out->submodule_prefix =3D xstrfmt("%s%s/",
     +					the_repository->submodule_prefix ?
     +					the_repository->submodule_prefix :
     +					"", path);
     +
     +	strbuf_release(&sb);
    -+	return 0;
    ++	return out;
     +}
     +
     +/*
    @@ -73,8 +74,7 @@
     + * If it can locate the submodule git directory it will create a repo=
sitory
     + * handle for the submodule and lookup both the left and right commit=
s and
     + * put them into the left and right pointers.
    -  */
    --static void show_submodule_header(struct diff_options *o, const char =
*path,
    ++ */
     +static void show_submodule_header(struct diff_options *o,
     +		const char *path,
      		struct object_id *one, struct object_id *two,
    @@ -116,11 +116,9 @@
      	struct rev_info rev;
      	struct commit *left =3D NULL, *right =3D NULL;
      	struct commit_list *merge_bases =3D NULL;
    -+	struct repository subrepo, *sub =3D &subrepo;
    -+
    -+	if (open_submodule(&subrepo, path) < 0)
    -+		sub =3D NULL;
    ++	struct repository *sub;
     =20
    ++	sub =3D open_submodule(path);
      	show_submodule_header(o, path, one, two, dirty_submodule,
     -			      &left, &right, &merge_bases);
     +			      sub, &left, &right, &merge_bases);
    @@ -147,8 +145,10 @@
      		free_commit_list(merge_bases);
      	clear_commit_marks(left, ~0);
      	clear_commit_marks(right, ~0);
    -+	if (sub)
    ++	if (sub) {
     +		repo_clear(sub);
    ++		free(sub);
    ++	}
      }
     =20
      void show_submodule_inline_diff(struct diff_options *o, const char *p=
ath,
    @@ -156,11 +156,9 @@
      	struct commit_list *merge_bases =3D NULL;
      	struct child_process cp =3D CHILD_PROCESS_INIT;
      	struct strbuf sb =3D STRBUF_INIT;
    -+	struct repository subrepo, *sub =3D &subrepo;
    -+
    -+	if (open_submodule(&subrepo, path) < 0)
    -+		sub =3D NULL;
    ++	struct repository *sub;
     =20
    ++	sub =3D open_submodule(path);
      	show_submodule_header(o, path, one, two, dirty_submodule,
     -			      &left, &right, &merge_bases);
     +			      sub, &left, &right, &merge_bases);
    @@ -171,8 +169,10 @@
      		clear_commit_marks(left, ~0);
      	if (right)
      		clear_commit_marks(right, ~0);
    -+	if (sub)
    ++	if (sub) {
     +		repo_clear(sub);
    ++		free(sub);
    ++	}
      }
     =20
      int should_update_submodules(void)
 19:  dbb0dd9322 ! 136:  df748a859f submodule: don't add submodule as odb f=
or push
    @@ -8,8 +8,10 @@
         objects, and the actual push is done by spawning another process,
         which handles object access by itself.)
    =20
    +    This code of push_submodule() is exercised in t5531 and continues
    +    to work, showing that the submodule odbc is not needed.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
  -:  ---------- > 137:  c9e990afac commit-graph: convert remaining functio=
n to handle arbitrary repositories
  -:  ---------- > 138:  a086f3dd11 commit: make free_commit_buffer and rel=
ease_commit_memory repository agnostic
  -:  ---------- > 139:  878bd34799 path.h: make REPO_GIT_PATH_FUNC reposit=
ory agnostic
  -:  ---------- > 140:  641824bbeb t/helper/test-repository: celebrate ind=
ependence from the_repository
