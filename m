Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04DDC4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 12:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579C120782
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 12:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NKAj/fbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgJGMDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 08:03:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:50351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbgJGMDW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 08:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602072190;
        bh=SEgTxVjDH7DrUQHSGLLPz9rzTnK22Rt7vp6EUbjKHXA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NKAj/fbwZxStmPiQSGsAIMBJHQmuJh7tkHoLdwfB115tiGajB2TzRd+6kloW9Nkkv
         UXHHEte934ir4i8DT55K1dl+mep8+N0BfO8gzUSpK5rscJM+OEUYZw1QDwmrCtShXr
         mkw402C3oIv0lIH29yS6HqyItFvEfjmxUCtJLLdQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.215.4]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49hB-1kYYMJ0tGb-0102ZA; Wed, 07
 Oct 2020 14:03:10 +0200
Date:   Wed, 7 Oct 2020 08:57:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 00/11] Rewrite the remaining merge strategies from
 shell to C
In-Reply-To: <20201005122646.27994-1-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010070855280.50@tvgsbejvaqbjf.bet>
References: <20200901105705.6059-1-alban.gruin@gmail.com> <20201005122646.27994-1-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:e0ENtX9vDaCCGbnD6FDQwlj99RAVQA7CzmoEdGPvNb7V5iT6hn/
 LTauLtUmbDX8NtaiysWvie/pOhW9IO8xF3Thr5NS5oF2+N9s5zYNAjo4kWxUF9oLbYIc/t0
 NO959TqYnV+bXo4bNRALvxWIqxesgoeiWl885FJcIyqgRf0+32GedCx6wSsUxRUl8NKS1hI
 7FaZOgN8ZZoFl6drpnsMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jy17KGQ4C0A=:nZ0DjdmVH0Hi7sGKGvpWMw
 iBGATb4k6iBTOTUsyiNGRzKoMfUmbIuul+myPVHpY5qw3Auxsu0lYdCWJigW1C16QcG5Tthp+
 rfJTyydHLlBJJXHie0fZ1NBpKb1CUjJ+xC0DKtK9aRs++jyxivCO0TwryjtbFCvaAmp5TFf/u
 vdynPP8HQLXEsrYMiLJ5W8fadj9DiqquwT86LNDXWrC0IpjPEzutrC31eQY4OSHBEk2EEX+xk
 5oL8SfuBcmm+FQpg+GUXbuBt6RTmlhbNmIhSZ4bwkYrqrXd8g3PxNuhuvaq42fBTiF7BN1KCi
 5po+ZAmrgT8A5vzCee5ihGIhmRmztaVYrOdo6RPQ5XVK98j7ACBSDanHxNhjMw0llA7u/tOk8
 r6p2PNckNJUoy4OQ4pxV8nygKkQYhudYmrYUVI58+egimw/JuUaOSjnOrgFJFDk5PgakSpc1/
 syIcLOXAJyCsmlUihu4s0zKmwNBTCbblLsOho8TGKzEkDPhJiOL1OSH3RIfgzzt2J6ebZAFaK
 Z0nBaZXQqbtf7Mf1oWp6B2DznACxSr7SOSNGMu+c71gAJtyXJLuJSJZa+b5qLEdAxRFli0Qyr
 BVtbOmssjXuWLtK/Tybz6hcDR1CcFcrfka3YaRIlr95420MuYzcaTXrAHbMUXCTZ81tWg1HVH
 m92RccWPudy+LV1bmWsdTujBxkpCp0bi5LM/LJfdjITChc4b2z+w6odI5ZBN4OIt+fS9xVsJY
 nesXzcodniybEDGmxNqhF3cjPPYiUxIDkaHbK6F3bJEJUvN3vbBkXtg6j4DGkAr06ztvwqMd4
 7pvo8gZbBXG2ya9DnBcZgc2cK3/RmtH1sAoThUOm7H+Cy6FufSTwUDlWxCnamao+fDdzZoU8i
 4RL11qvKYgbrszYg4VVgJ0MiThBT30coZ+yRXOfnEU+GVz0nf1hVyA38XCv8fMX1ZMYf5c07u
 QuJBlXOsYQ0P15tInf38cJSuvud8qOhnoNtFB7kSbZvw6SR+CPO67QLYWTHFmZ4elwK8cvOab
 7UWcmZM30ClpZygEZqetE1VVz1mhFT/Nqz1hgw/eADZ3Bw2dPf3ZbLFfCpCGcxQxO/R6KLf16
 /6GxPtgk8mggT62wQcYicFsdjmyqgThS+0TKXApULnhvBofaWRGJEoQvu3PyBxf0ex+mgl5LC
 Q/71T8HXaTsWWAmwypcOEg1dHHRn5mgcFwnGF9j86P5Dn/44BStsBip7oEAjBFZQ8ZXfWH7UX
 NfbzlrId9AX34hgIS/rr6EMzsITGduEpcce675A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Mon, 5 Oct 2020, Alban Gruin wrote:

> In a effort to reduce the number of shell scripts in git's codebase, I
> propose this patch series converting the two remaining merge strategies,
> resolve and octopus, from shell to C.  This will enable slightly better
> performance, better integration with git itself (no more forking to
> perform these operations), better portability (Windows and shell scripts
> don't mix well).
>
> Three scripts are actually converted: first git-merge-one-file.sh, then
> git-merge-resolve.sh, and finally git-merge-octopus.sh.  Not only they
> are converted, but they also are modified to operate without forking,
> and then libified so they can be used by git without spawning another
> process.
>
> The first patch is not important to make the whole series work, but I
> made this patch while working on it.
>
> This series keeps the commands `git merge-one-file', `git
> merge-resolve', and `git merge-octopus', so any script depending on them
> should keep working without any changes.

While that may be true, with SKIP_DASHED_BUILT_INS=3DYesPlease, it is no
longer true. And that is a good thing!

However, it also broke the CI build (`seen` sees a breakage in t9902.199).

I will send out a fix shortly (see
https://github.com/gitgitgadget/git/pull/745 for details).

Ciao,
Dscho

>
> This series is based on 306ee63a70 (Eighteenth batch, 2020-09-29).  The
> tip is tagged as "rewrite-merge-strategies-v3" at
> https://github.com/agrn/git.
>
> Changes since v2:
>
>  - Enable `USE_THE_INDEX_COMPATIBILITY_MACROS' in merge-one-file.c and
>    use read_cache() and hold_locked_index() instead of repo_read_index()
>    and repo_hold_locked_index() to improve readability.
>
>  - Move file mode parsing to its own function in merge-one-file.c.
>
>  - Improve IO errors handling in do_merge_one_file().
>
>  - Return -1 instead of 1 when erroring out in do_merge_one_file() and
>    merge_strategies_one_file().
>
>  - Use oid_to_hex_r() instead of oid_to_hex() in do_merge_one_file().
>
>  - Reformat multilines comments.
>
>  - Reworded a sentence in commit 3/11.
>
> Alban Gruin (11):
>   t6027: modernise tests
>   merge-one-file: rewrite in C
>   merge-index: libify merge_one_path() and merge_all()
>   merge-index: don't fork if the requested program is
>     `git-merge-one-file'
>   merge-resolve: rewrite in C
>   merge-recursive: move better_branch_name() to merge.c
>   merge-octopus: rewrite in C
>   merge: use the "resolve" strategy without forking
>   merge: use the "octopus" strategy without forking
>   sequencer: use the "resolve" strategy without forking
>   sequencer: use the "octopus" merge strategy without forking
>
>  Makefile                        |   7 +-
>  builtin.h                       |   3 +
>  builtin/merge-index.c           | 102 ++----
>  builtin/merge-octopus.c         |  69 ++++
>  builtin/merge-one-file.c        |  92 +++++
>  builtin/merge-recursive.c       |  16 +-
>  builtin/merge-resolve.c         |  69 ++++
>  builtin/merge.c                 |   9 +-
>  cache.h                         |   2 +-
>  git-merge-octopus.sh            | 112 ------
>  git-merge-one-file.sh           | 167 ---------
>  git-merge-resolve.sh            |  54 ---
>  git.c                           |   3 +
>  merge-strategies.c              | 613 ++++++++++++++++++++++++++++++++
>  merge-strategies.h              |  44 +++
>  merge.c                         |  12 +
>  sequencer.c                     |  16 +-
>  t/t6407-merge-binary.sh         |  27 +-
>  t/t6415-merge-dir-to-symlink.sh |   2 +-
>  19 files changed, 972 insertions(+), 447 deletions(-)
>  create mode 100644 builtin/merge-octopus.c
>  create mode 100644 builtin/merge-one-file.c
>  create mode 100644 builtin/merge-resolve.c
>  delete mode 100755 git-merge-octopus.sh
>  delete mode 100755 git-merge-one-file.sh
>  delete mode 100755 git-merge-resolve.sh
>  create mode 100644 merge-strategies.c
>  create mode 100644 merge-strategies.h
>
> Range-diff against v2:
>  1:  28c8fd11b6 =3D  1:  08c7df596a t6027: modernise tests
>  2:  f5ab0fdf0a !  2:  ce911c99c0 merge-one-file: rewrite in C
>     @@ builtin/merge-one-file.c (new)
>      + * that might change the tree layout.
>      + */
>      +
>     ++#define USE_THE_INDEX_COMPATIBILITY_MACROS
>      +#include "cache.h"
>      +#include "builtin.h"
>      +#include "lockfile.h"
>     @@ builtin/merge-one-file.c (new)
>      +	"<orig mode> <our mode> <their mode>\n\n"
>      +	"Blob ids and modes should be empty for missing files.";
>      +
>     ++static int read_mode(const char *name, const char *arg, unsigned i=
nt *mode)
>     ++{
>     ++	char *last;
>     ++	int ret =3D 0;
>     ++
>     ++	*mode =3D strtol(arg, &last, 8);
>     ++
>     ++	if (*last)
>     ++		ret =3D error(_("invalid '%s' mode: expected nothing, got '%c'")=
, name, *last);
>     ++	else if (!(S_ISREG(*mode) || S_ISDIR(*mode) || S_ISLNK(*mode)))
>     ++		ret =3D error(_("invalid '%s' mode: %o"), name, *mode);
>     ++
>     ++	return ret;
>     ++}
>     ++
>      +int cmd_merge_one_file(int argc, const char **argv, const char *pr=
efix)
>      +{
>      +	struct object_id orig_blob, our_blob, their_blob,
>     @@ builtin/merge-one-file.c (new)
>      +	if (argc !=3D 8)
>      +		usage(builtin_merge_one_file_usage);
>      +
>     -+	if (repo_read_index(the_repository) < 0)
>     ++	if (read_cache() < 0)
>      +		die("invalid index");
>      +
>     -+	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
>     ++	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
>      +
>      +	if (!get_oid(argv[1], &orig_blob)) {
>      +		p_orig_blob =3D &orig_blob;
>     -+		orig_mode =3D strtol(argv[5], NULL, 8);
>     -+
>     -+		if (!(S_ISREG(orig_mode) || S_ISDIR(orig_mode) || S_ISLNK(orig_m=
ode)))
>     -+			ret |=3D error(_("invalid 'orig' mode: %o"), orig_mode);
>     ++		ret =3D read_mode("orig", argv[5], &orig_mode);
>      +	}
>      +
>      +	if (!get_oid(argv[2], &our_blob)) {
>      +		p_our_blob =3D &our_blob;
>     -+		our_mode =3D strtol(argv[6], NULL, 8);
>     -+
>     -+		if (!(S_ISREG(our_mode) || S_ISDIR(our_mode) || S_ISLNK(our_mode=
)))
>     -+			ret |=3D error(_("invalid 'our' mode: %o"), our_mode);
>     ++		ret =3D read_mode("our", argv[6], &our_mode);
>      +	}
>      +
>      +	if (!get_oid(argv[3], &their_blob)) {
>      +		p_their_blob =3D &their_blob;
>     -+		their_mode =3D strtol(argv[7], NULL, 8);
>     -+
>     -+		if (!(S_ISREG(their_mode) || S_ISDIR(their_mode) || S_ISLNK(thei=
r_mode)))
>     -+			ret =3D error(_("invalid 'their' mode: %o"), their_mode);
>     ++		ret =3D read_mode("their", argv[7], &their_mode);
>      +	}
>      +
>      +	if (ret)
>     @@ builtin/merge-one-file.c (new)
>      +
>      +	if (ret) {
>      +		rollback_lock_file(&lock);
>     -+		return ret;
>     ++		return !!ret;
>      +	}
>      +
>     -+	return write_locked_index(the_repository->index, &lock, COMMIT_LO=
CK);
>     ++	return write_locked_index(&the_index, &lock, COMMIT_LOCK);
>      +}
>
>       ## git-merge-one-file.sh (deleted) ##
>     @@ merge-strategies.c (new)
>      +			     unsigned int orig_mode, unsigned int our_mode, unsigned in=
t their_mode)
>      +{
>      +	int ret, i, dest;
>     ++	ssize_t written;
>      +	mmbuffer_t result =3D {NULL, 0};
>      +	mmfile_t mmfs[3];
>      +	struct ll_merge_options merge_opts =3D {0};
>     @@ merge-strategies.c (new)
>      +	for (i =3D 0; i < 3; i++)
>      +		free(mmfs[i].ptr);
>      +
>     -+	if (ret > 127 || !orig_blob)
>     -+		ret =3D error(_("content conflict in %s"), path);
>     ++	if (ret < 0) {
>     ++		free(result.ptr);
>     ++		return error(_("Failed to execute internal merge"));
>     ++	}
>      +
>     -+	/* Create the working tree file, using "our tree" version from
>     -+	   the index, and then store the result of the merge. */
>     ++	/*
>     ++	 * Create the working tree file, using "our tree" version from
>     ++	 * the index, and then store the result of the merge.
>     ++	 */
>      +	ce =3D index_file_exists(istate, path, strlen(path), 0);
>      +	if (!ce)
>      +		BUG("file is not present in the cache?");
>      +
>      +	unlink(path);
>     -+	dest =3D open(path, O_WRONLY | O_CREAT, ce->ce_mode);
>     -+	write_in_full(dest, result.ptr, result.size);
>     ++	if ((dest =3D open(path, O_WRONLY | O_CREAT, ce->ce_mode)) < 0) {
>     ++		free(result.ptr);
>     ++		return error_errno(_("failed to open file '%s'"), path);
>     ++	}
>     ++
>     ++	written =3D write_in_full(dest, result.ptr, result.size);
>      +	close(dest);
>      +
>      +	free(result.ptr);
>      +
>     -+	if (ret && our_mode !=3D their_mode)
>     ++	if (written < 0)
>     ++		return error_errno(_("failed to write to '%s'"), path);
>     ++
>     ++	if (ret !=3D 0 || !orig_blob)
>     ++		ret =3D error(_("content conflict in %s"), path);
>     ++	if (our_mode !=3D their_mode)
>      +		return error(_("permission conflict: %o->%o,%o in %s"),
>      +			     orig_mode, our_mode, their_mode, path);
>      +	if (ret)
>     -+		return 1;
>     ++		return -1;
>      +
>      +	return add_file_to_index(istate, path, 0);
>      +}
>     @@ merge-strategies.c (new)
>      +	if (orig_blob &&
>      +	    ((!their_blob && our_blob && oideq(orig_blob, our_blob)) ||
>      +	     (!our_blob && their_blob && oideq(orig_blob, their_blob))))
>     -+		/* Deleted in both or deleted in one and unchanged in
>     -+		   the other */
>     ++		/* Deleted in both or deleted in one and unchanged in the other.=
 */
>      +		return merge_one_file_deleted(r->index,
>      +					      orig_blob, our_blob, their_blob, path,
>      +					      orig_mode, our_mode, their_mode);
>      +	else if (!orig_blob && our_blob && !their_blob) {
>     -+		/* Added in one.  The other side did not add and we
>     -+		   added so there is nothing to be done, except making
>     -+		   the path merged. */
>     ++		/*
>     ++		 * Added in one.  The other side did not add and we
>     ++		 * added so there is nothing to be done, except making
>     ++		 * the path merged.
>     ++		 */
>      +		return add_to_index_cacheinfo(r->index, our_mode, our_blob, path=
);
>      +	} else if (!orig_blob && !our_blob && their_blob) {
>      +		printf(_("Adding %s\n"), path);
>     @@ merge-strategies.c (new)
>      +			return error(_("untracked %s is overwritten by the merge."), pa=
th);
>      +
>      +		if (add_to_index_cacheinfo(r->index, their_mode, their_blob, pat=
h))
>     -+			return 1;
>     ++			return -1;
>      +		return checkout_from_index(r->index, path);
>      +	} else if (!orig_blob && our_blob && their_blob &&
>      +		   oideq(our_blob, their_blob)) {
>     -+		/* Added in both, identically (check for same
>     -+		   permissions). */
>     ++		/* Added in both, identically (check for same permissions). */
>      +		if (our_mode !=3D their_mode)
>      +			return error(_("File %s added identically in both branches, "
>      +				       "but permissions conflict %o->%o."),
>     @@ merge-strategies.c (new)
>      +		printf(_("Adding %s\n"), path);
>      +
>      +		if (add_to_index_cacheinfo(r->index, our_mode, our_blob, path))
>     -+			return 1;
>     ++			return -1;
>      +		return checkout_from_index(r->index, path);
>      +	} else if (our_blob && their_blob)
>      +		/* Modified in both, but differently. */
>     @@ merge-strategies.c (new)
>      +					 orig_blob, our_blob, their_blob, path,
>      +					 orig_mode, our_mode, their_mode);
>      +	else {
>     -+		char *orig_hex =3D "", *our_hex =3D "", *their_hex =3D "";
>     ++		char orig_hex[GIT_MAX_HEXSZ] =3D {0}, our_hex[GIT_MAX_HEXSZ] =3D=
 {0},
>     ++			their_hex[GIT_MAX_HEXSZ] =3D {0};
>      +
>      +		if (orig_blob)
>     -+			orig_hex =3D oid_to_hex(orig_blob);
>     ++			oid_to_hex_r(orig_hex, orig_blob);
>      +		if (our_blob)
>     -+			our_hex =3D oid_to_hex(our_blob);
>     ++			oid_to_hex_r(our_hex, our_blob);
>      +		if (their_blob)
>     -+			their_hex =3D oid_to_hex(their_blob);
>     ++			oid_to_hex_r(their_hex, their_blob);
>      +
>      +		return error(_("%s: Not handling case %s -> %s -> %s"),
>      +			     path, orig_hex, our_hex, their_hex);
>  3:  7f3ce7da17 !  3:  7f0999f5a3 merge-index: libify merge_one_path() a=
nd merge_all()
>     @@ Commit message
>
>          To avoid this, this moves merge_one_path(), merge_all(), and th=
eir
>          helpers to merge-strategies.c.  They also take a callback to di=
ctate
>     -    what they should do for each file.  For now, only one launching=
 a new
>     -    process is defined to preserve the behaviour of the builtin ver=
sion.
>     +    what they should do for each file.  For now, to preserve the be=
haviour
>     +    of `merge-index', only one callback, launching a new process, i=
s
>     +    defined.
>
>          Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>
>  4:  07e6a6aaef =3D  4:  c0bc05406d merge-index: don't fork if the reque=
sted program is `git-merge-one-file'
>  5:  117d4fc840 =3D  5:  cbfe192982 merge-resolve: rewrite in C
>  6:  4fc955962b =3D  6:  35e386f626 merge-recursive: move better_branch_=
name() to merge.c
>  7:  e7b9e15b34 !  7:  41eb0f7199 merge-octopus: rewrite in C
>     @@ Makefile: BUILTIN_OBJS +=3D builtin/mailsplit.o
>       BUILTIN_OBJS +=3D builtin/merge-recursive.o
>
>       ## builtin.h ##
>     -@@ builtin.h: int cmd_mailsplit(int argc, const char **argv, const =
char *prefix);
>     +@@ builtin.h: int cmd_maintenance(int argc, const char **argv, cons=
t char *prefix);
>       int cmd_merge(int argc, const char **argv, const char *prefix);
>       int cmd_merge_base(int argc, const char **argv, const char *prefix=
);
>       int cmd_merge_index(int argc, const char **argv, const char *prefi=
x);
>     @@ builtin/merge-octopus.c (new)
>      +	if (repo_read_index(the_repository) < 0)
>      +		die("corrupted cache");
>      +
>     -+	/* The first parameters up to -- are merge bases; the rest are
>     -+	 * heads. */
>     ++	/*
>     ++	 * The first parameters up to -- are merge bases; the rest are
>     ++	 * heads.
>     ++	 */
>      +	for (i =3D 1; i < argc; i++) {
>      +		if (strcmp(argv[i], "--") =3D=3D 0)
>      +			sep_seen =3D 1;
>     @@ builtin/merge-octopus.c (new)
>      +		}
>      +	}
>      +
>     -+	/* Reject if this is not an octopus -- resolve should be used
>     -+	 * instead. */
>     ++	/*
>     ++	 * Reject if this is not an octopus -- resolve should be used
>     ++	 * instead.
>     ++	 */
>      +	if (commit_list_count(remotes) < 2)
>      +		return 2;
>      +
>     @@ merge-strategies.c: int merge_strategies_resolve(struct repositor=
y *r,
>      +		int can_ff =3D 1;
>      +
>      +		if (ret) {
>     -+			/* We allow only last one to have a
>     -+			   hand-resolvable conflicts.  Last round failed
>     -+			   and we still had a head to merge. */
>     ++			/*
>     ++			 * We allow only last one to have a
>     ++			 * hand-resolvable conflicts.  Last round failed
>     ++			 * and we still had a head to merge.
>     ++			 */
>      +			puts(_("Automated merge did not work."));
>      +			puts(_("Should not be doing an octopus."));
>      +
>     @@ merge-strategies.c: int merge_strategies_resolve(struct repositor=
y *r,
>      +		}
>      +
>      +		if (!non_ff_merge && can_ff) {
>     -+			/* The first head being merged was a
>     -+			   fast-forward.  Advance the reference commit
>     -+			   to the head being merged, and use that tree
>     -+			   as the intermediate result of the merge.  We
>     -+			   still need to count this as part of the
>     -+			   parent set. */
>     ++			/*
>     ++			 * The first head being merged was a
>     ++			 * fast-forward.  Advance the reference commit
>     ++			 * to the head being merged, and use that tree
>     ++			 * as the intermediate result of the merge.  We
>     ++			 * still need to count this as part of the
>     ++			 * parent set.
>     ++			 */
>      +			struct object_id oids[2];
>      +			printf(_("Fast-forwarding to: %s\n"), branch_name);
>      +
>  8:  cd0662201d =3D  8:  8f6c1ac057 merge: use the "resolve" strategy wi=
thout forking
>  9:  0525ff0183 =3D  9:  b1125261d1 merge: use the "octopus" strategy wi=
thout forking
> 10:  6fbf599ba4 =3D 10:  8d0932fd02 sequencer: use the "resolve" strateg=
y without forking
> 11:  2c2dc3cc62 =3D 11:  e304723957 sequencer: use the "octopus" merge s=
trategy without forking
> --
> 2.28.0.662.ge304723957
>
>
>
