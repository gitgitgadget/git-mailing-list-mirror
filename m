Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C8613D286
	for <git@vger.kernel.org>; Thu, 23 May 2024 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460570; cv=none; b=C8svvA9rcEI3AGYxNJt68GIO2tD7FDWD7Ww5xvUZME1LycHTC9/jXWptgNaMND62cNAadF+CW7MPpp2aC8cS2R6QWa9DRi1JgL1Q1RsToRFus1IwQPslwHdCPoxuvhOBCqL8h4JSigwfKMAbM5VhRn/cVjlq5r2fC1TTttmI3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460570; c=relaxed/simple;
	bh=4KjvEzciI05vM5oSIPbzyyL2bHfq+IUx+mGvr01pRvY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eNNZG+GAn1rwo1sF5xOmTHIgBD4pP/cgNVeoDF1Cd7WWkvaSUSj2ZfypfDtDlLyU08mIEJtUrymRjqsvVdwF6BtDMEkEe7RUyMoXdnJ63+BQE5BL4xFdfMtsHTBd18+fpW6POqPsuySmXgKCwi3ovy4m7SzoHHeD/Bm7vTO2m9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=pOi3PUuh; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="pOi3PUuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716460564; x=1717065364;
	i=johannes.schindelin@gmx.de;
	bh=kk1i9NyvqVnrnv7rTIIjJtncgpltgzkoMKQ5SPwEHZw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pOi3PUuhB/PqlZR3i/zg77Qs7MWhlKtg2nA1AmIJe3euMinZgX2LRNVRf8okJQI1
	 5mLr8xfuK/8wRiv5E829uYUusKQcp0uhyUKxZK/dxkFfGZ5HVuLgMWtnqXCGp6A+s
	 0BpxspimfgmQjrfW54RJFWQOzNdvQwaJw0jpJEF+NBXoo9ZWuTEofSPwLaEzVLJ1l
	 lgkCSQc2xjlVQGDKvyzxxM3v25EgdLW5JGLqAN8VSyQvdUvljG1BFYPeZzxihN+44
	 k4VAQavXLZ74RVKxxLFE/wWvGimAPGp2PAQLRiFTcw7wT/0AvLftSyaSg1gjNf24P
	 fPAat/k/dDlqgu7Zxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.216.58]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq2E-1sPgqZ3coi-00s3qT; Thu, 23
 May 2024 12:36:03 +0200
Date: Thu, 23 May 2024 12:36:00 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Reviewing merge commits, was Re: [rPATCH 13/12] Merge branch
 'jc/fix-aggressive-protection-2.39'
In-Reply-To: <20240521204507.1288528-1-gitster@pobox.com>
Message-ID: <79a2c761-870a-cc0c-ce46-440af3bad152@gmx.de>
References: <20240521195659.870714-1-gitster@pobox.com> <20240521204507.1288528-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:97X357g0gxCFTvMGqZP6Nw7FhdpX183p3ZF4u672tonhpyStzvf
 /KRWys6EPbPNVyGk2UsM+la1SQljjK9v0jX40V5Gwzuu+iNTW/nnPo55ZgXjgs+nn5N3gCn
 70hlpEM6uYrUVHlFEamyg5PTvgOLOUA1MRzYiAR0DZ+5dbanm/JRY3O84mVWqsAWGZq+XuU
 ToZf5hc2FibVXjupOIZig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qz6CTmxbTmk=;wHMZ+3CZ8R1OICvlUjKnJeNqnlz
 sVHydohCMnNSIRUk2Db+JGHDC+Jqq6knW9r4jPn1Z/QbIDQfnH930aoSYAjEQWuE3pQP4Ve2N
 f3A/LUbrfgQyxk9nCGWAZPsQpNq+zHiNLzI5TZJhNgek+fhWbfpXK+44mlnfDMtzlYufjNXZR
 P48/d7LJFaa2UzwcxV6DHdEJfLdOUk1gFDsik5rF3RF141oT085k+M3YfJ+3bxjDGJO5q4b2S
 HfPT+MNI0kC69mgS/zlpYffWaKb4Uu10q/YQuUAMEX196nFtWo7OR/9/cuVLAyK7G1q6tc5tu
 y6YySGgTYvuXfC0sLyLNhyG3Lsp146FFDmd3H5nLZUOkbN8wXECoANXEv3tZtJoNGx/a3nUGt
 szQDFpdXNq++jN11/fDt2eeKXkyjzNQ2TYBTN4g9Dk6f2zGk9+1ATb0otdDZqtXuHRdmwwH15
 HrmKIlTUk0lkDFSe7VguU0zuLbnGJaI0+6B1g6vQKI2UVeRNPEd4wghV41GppVwzi8PSa4kqb
 DAFQNDMe3Xdou/dQWv+PVw+dX12LNpSnBzlrBN2kdkHG2YCJ+KKJtfXS0Ye7J6oiyKVgvgczG
 gE4PitgJ4qs/rpUFVHOKnw505WUokOZb68MSD7i0hDygvqIY3QMjaV3H3yF6Uh2efm6a3Qs3v
 ny11/3VRoKwZxE53nXo8d7yYGYYCJ6MSxfww8Wt6KVdfzG0ezQPImd/92h8Qjy4TZtnkvi7hx
 EWRpkb/LmP+mdtCAUMU1uyau+CMs5ZoM+GWE3ktTjRvAJqbQbQp62CePU2DrOuEXpk/ZN2MMz
 yjeDbtlcfBci2k9InANXf89yqLr8inBSBg97DFV9ZsPc4=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 21 May 2024, Junio C Hamano wrote:

> If this format looks reasonable to folks as a way to review the result
> of merging up fixes, I'll follow up with "patches" for more recent
> maintenance tracks.

Personally, I find this format quite hard to parse, and I am concerned
that the focus on the merge conflicts may distract too much from verifying
the correctness of the result. Much of what is tricky about these merges
happens outside conflict markers.

If it was up to me to verify such fixes, short of using Git and validating
the correctness by performing the merge independently instead of trying to
accomplish the validation by looking at a plain-text mail, I would compare
the diff of `maint-2.39` to the diff of `maint-2.40`. Something like this
[*1*]:

  $ git range-diff \
    mbox:<(git diff v2.45.1...gitster/jc/fix-2.45.1-and-friends-for-2.39) =
\
    mbox:<(git diff v2.45.1...gitster/fixes/2.45.1/2.40)
  1:  00000000000 ! 1:  00000000000
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const=
 char *prefix)

          if (real_git_dir) {
       @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
      -   free(unborn_head);
          free(dir);
          free(path);
      +   free(repo_to_free);
       -  free(template_dir_dup);
      -   UNLEAK(repo);
      ++  UNLEAK(repo);
          junk_mode =3D JUNK_LEAVE_ALL;

      +   transport_ls_refs_options_release(&transport_ls_refs_options);

        ## cache.h ##
       @@ cache.h: int copy_fd(int ifd, int ofd);
      @@ t/t1450-fsck.sh: test_expect_success 'fsck error on gitattributes=
 with excessive
        test_done

        ## t/t1800-hook.sh ##
      -@@ t/t1800-hook.sh: test_expect_success 'git hook run a hook with a=
 bad shebang' '
      +@@ t/t1800-hook.sh: test_expect_success 'stdin to hooks' '
          test_cmp expect actual
        '
It does get a bit more confusing with the diff between `maint-2.40` and
`maint-2.41` because the declaration of `do_files_match()` moved from
`cache.h` to `copy.h`, and the hunks removing that declaration are at
different locations in the diffs:

  $ git range-diff \
    mbox:<(git diff v2.45.1...gitster/fixes/2.45.1/2.40) \
    mbox:<(git diff v2.45.1...gitster/fixes/2.45.1/2.41)
  1:  00000000000 ! 1:  00000000000
      @@ Makefile: exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS =3D \

        ## builtin/clone.c ##
       @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
      - 	int err =3D 0, complete_refs_before_fetch =3D 1;
        	int submodule_progress;
        	int filter_submodules =3D 0;
      + 	int hash_algo;
       -	const char *template_dir;
       -	char *template_dir_dup =3D NULL;

      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const=
 char *prefix)

        	transport_ls_refs_options_release(&transport_ls_refs_options);

      - ## cache.h ##
      -@@ cache.h: int copy_fd(int ifd, int ofd);
      - int copy_file(const char *dst, const char *src, int mode);
      - int copy_file_with_time(const char *dst, const char *src, int mode=
);
      -
      --/*
      -- * Compare the file mode and contents of two given files.
      -- *
      -- * If both files are actually symbolic links, the function returns=
 1 if the link
      -- * targets are identical or 0 if they are not.
      -- *
      -- * If any of the two files cannot be accessed or in case of read f=
ailures, this
      -- * function returns 0.
      -- *
      -- * If the file modes and contents are identical, the function retu=
rns 1,
      -- * otherwise it returns 0.
      -- */
      --int do_files_match(const char *path1, const char *path2);
      --
      - void write_or_die(int fd, const void *buf, size_t count);
      - void fsync_or_die(int fd, const char *);
      - int fsync_component(enum fsync_component component, int fd);
      -
        ## ci/install-dependencies.sh ##
       @@ ci/install-dependencies.sh: macos-*)
        	export HOMEBREW_NO_AUTO_UPDATE=3D1 HOMEBREW_NO_INSTALL_CLEANUP=3D=
1
      @@ copy.c: int copy_file_with_time(const char *dst, const char *src,=
 int mode)
       -	return ret;
       -}

      + ## copy.h ##
      +@@ copy.h: int copy_fd(int ifd, int ofd);
      + int copy_file(const char *dst, const char *src, int mode);
      + int copy_file_with_time(const char *dst, const char *src, int mode=
);
      +
      +-/*
      +- * Compare the file mode and contents of two given files.
      +- *
      +- * If both files are actually symbolic links, the function returns=
 1 if the link
      +- * targets are identical or 0 if they are not.
      +- *
      +- * If any of the two files cannot be accessed or in case of read f=
ailures, this
      +- * function returns 0.
      +- *
      +- * If the file modes and contents are identical, the function retu=
rns 1,
      +- * otherwise it returns 0.
      +- */
      +-int do_files_match(const char *path1, const char *path2);
      +-
      + #endif /* COPY_H */
      +
        ## fsck.c ##
       @@ fsck.c: static int fsck_tree(const struct object_id *tree_oid,
        				retval +=3D report(options, tree_oid, OBJ_TREE,
      @@ git-send-email.perl: sub get_patch_subject {

        ## hook.c ##
       @@
      - #include "run-command.h"
      - #include "config.h"
      -
      + #include "strbuf.h"
      + #include "environment.h"
      + #include "setup.h"
      +-#include "copy.h"
      +-
       -static int identical_to_template_hook(const char *name, const char=
 *path)
       -{
       -	const char *env =3D getenv("GIT_CLONE_TEMPLATE_DIR");
      @@ hook.c
       -	strbuf_release(&template_path);
       -	return ret;
       -}
      --
      +
        const char *find_hook(const char *name)
        {
      - 	static struct strbuf path =3D STRBUF_INIT;
       @@ hook.c: const char *find_hook(const char *name)
        		}
        		return NULL;
      @@ t/t1350-config-hooks-path.sh: test_expect_success 'git rev-parse =
=2D-git-path hook
        test_done

        ## t/t1450-fsck.sh ##
      -@@ t/t1450-fsck.sh: test_expect_success 'fsck error on gitattribute=
s with excessive size' '
      - 	test_cmp expected actual
      +@@ t/t1450-fsck.sh: test_expect_success 'fsck reports problems in m=
ain index without filename' '
      + 	test_cmp expect actual
        '

       -test_expect_success 'fsck warning on symlink target with excessive=
 length' '

Another thing that makes the review of these diffs-of-diffs harder than
necessary is the lack of color-coding in plain-text emails. When I look at
the color-coded version, my eyes are immediately drawn away from the
unimportant lines that start with a `-` or `+` but then continue in
uncolored text that indicates context line changes only. Instead, my eyes
shift immediately to the relevant parts, the blankets of red color.

Both the remerge-diff and the range-diff output do nothing, though, to
help verifying that no-longer-needed `#include`s are removed (you can see
that `#include "copy.h"` was removed from `hook.c`, but if that had been
missed there would be no indicator thereof).

So while I find this output more useful than the remerge diffs, it is
still far from ideal. I will therefore refrain from posting the
range-diffs that correspond to the remaining `maint-*` merges.

Ciao,
Johannes

Footnote *1*: This `mbox:` construct requires
https://github.com/gitgitgadget/git/pull/1420 (or `js/range-diff-mbox`) to
work as intended.
