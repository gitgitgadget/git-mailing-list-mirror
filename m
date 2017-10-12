Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463DC20372
	for <e@80x24.org>; Thu, 12 Oct 2017 20:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754409AbdJLUGS (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 16:06:18 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:53774 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753255AbdJLUGN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 16:06:13 -0400
Received: by mail-oi0-f48.google.com with SMTP id j126so10254758oia.10
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 13:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=cAqE5HqKpYyWPbtjOsMDLW6O8IbEAJ1kEF5dK+4Z+xk=;
        b=V9UVYLodWasQNxDVIb/OOAuFO39ZKEoar+MtE5art96FgePavGjqHlhvqKhfQM6wVi
         P7++Oilbv4yFFRsMsnVXL5dVm1ZOasHquj/Ga+tLL05gMNLILUtFB+PucBKYBlFBHA7j
         RXvKFRbi9hpaVDlGrb9kVLgSAOC59Mwd9+zc6gaegDJLyBOzWyra9WwuZQMSp+dmHC1b
         zDsjhdpgqsEf24Gdajo74p5USMBQ/YEVUK1sxdw97b5wGlvu8iC/fyZghLxq8B4aI8c1
         hi+kLJHXkhILGRET/sHxWiMVSzlY9Fpn2i52CWy/wwhcwqFKTZLcPVWxzPBfdD9TNFnp
         efzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=cAqE5HqKpYyWPbtjOsMDLW6O8IbEAJ1kEF5dK+4Z+xk=;
        b=WA5j7jdPoE7nHH8lErg04Skn5g5s2N072pzUxZqfRStyRk8I3q/HT2VRL+3dW0bnNd
         kIh7KAsOIblRGz0AkscRxTRmyQhAJL32ANGwxKFvqP0kXoYI3Fk85EGOKD2TAOG9bViq
         1zOkAz70xZ7be2NnEZZP+6VwoaEwUFjOuRV9RZ2QaPv3SH53nyl0dEuQyLVvf0wmZsVm
         DZ/Lsxajo8F9agbU+lSiOCdiY/ei+/yvdvWw6vnZS2+JPaIO5tfRRcuvc6WvLZbJHzOp
         CKWNj5WD27KFQ6cl6T7pUFawtggRJH8zUrowXuzU1elZRm/r1Ose2lm2iuiDRw4rXRgS
         O1pA==
X-Gm-Message-State: AMCzsaXTmtPw6SFJ5fcJOvN0Ivz16N/vzKoyXLll9sqU7HdwYh5v4qIY
        dLxUAJGSd2djPNORKJ9bjw/6kuTt5pzKGTyZ5nJfxrDl
X-Google-Smtp-Source: AOwi7QDWpXeX3ynUo1BYuAM2NcjaHLVJSzCooFdr1UZ7I4bTsddV7Kb8AVA2KNV479csyZfz1g5BI9xp3/w6onBxyD4=
X-Received: by 10.202.71.151 with SMTP id u145mr1796116oia.133.1507838772638;
 Thu, 12 Oct 2017 13:06:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.19.87 with HTTP; Thu, 12 Oct 2017 13:06:11 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 12 Oct 2017 16:06:11 -0400
Message-ID: <CAH8yC8mvG3bSpgshHay7B0SSyAafWLrPTtVZRuq2cShn9xQ9JA@mail.gmail.com>
Subject: undefined reference to `pcre_jit_exec'
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I have a script to build Git on some old platforms to ease testing.
Old platforms include CentOS 5. The script is available at
https://github.com/noloader/Build-Scripts/blob/master/build-ssh.sh.

It looks like something got knocked loose recently. I'm seeing several
of these when building with PCRE 8.41 with Git 2.14.2. Old and new
platforms are witnessing it. I observe it on CentOS 5 with GCC 4.1;
and Fedora 26 with GCC 7.2.

    ...
    LINK git-credential-store
libgit.a(grep.o): In function `pcre1match':
grep.c:(.text+0x1219): undefined reference to `pcre_jit_exec'
collect2: error: ld returned 1 exit status
make: *** [Makefile:2145: git-credential-store] Error 1

Jeff

****************************************

./configure ...

config.status: executing config.mak.autogen commands
    * new build flags
    * new prefix flags
    * new link flags
    GEN common-cmds.h
    CC hex.o
    CC ident.o
    CC kwset.o
    CC levenshtein.o
    CC line-log.o
    CC line-range.o
    CC list-objects.o
    CC ll-merge.o
    CC lockfile.o
    CC log-tree.o
    CC mailinfo.o
    CC mailmap.o
    CC match-trees.o
    CC merge.o
    CC merge-blobs.o
    CC merge-recursive.o
    CC mergesort.o
    CC mru.o
    CC name-hash.o
    CC notes.o
    CC notes-cache.o
    CC notes-merge.o
    CC notes-utils.o
    CC object.o
    CC oidset.o
    CC pack-bitmap.o
    CC pack-bitmap-write.o
    CC pack-check.o
    CC pack-objects.o
    CC pack-revindex.o
    CC pack-write.o
    CC pager.o
    CC parse-options.o
    CC parse-options-cb.o
    CC patch-delta.o
    CC patch-ids.o
    CC path.o
    CC pathspec.o
    CC pkt-line.o
    CC preload-index.o
    CC pretty.o
    CC prio-queue.o
    CC progress.o
    CC prompt.o
    CC quote.o
    CC reachable.o
    CC read-cache.o
    CC reflog-walk.o
    CC refs.o
    CC refs/files-backend.o
    CC refs/iterator.o
    CC refs/ref-cache.o
    CC ref-filter.o
    CC remote.o
    CC replace_object.o
    CC repository.o
    CC rerere.o
    CC resolve-undo.o
    CC revision.o
    CC run-command.o
    CC send-pack.o
    CC sequencer.o
    CC server-info.o
    CC setup.o
    CC sha1-array.o
    CC sha1-lookup.o
    CC sha1_file.o
    CC sha1_name.o
    CC shallow.o
    CC sideband.o
    CC sigchain.o
    CC split-index.o
    CC strbuf.o
    CC streaming.o
    CC string-list.o
    CC submodule.o
    CC submodule-config.o
    CC sub-process.o
    CC symlinks.o
    CC tag.o
    CC tempfile.o
    CC tmp-objdir.o
    CC trace.o
    CC trailer.o
    CC transport.o
    CC transport-helper.o
    CC tree-diff.o
    CC tree.o
    CC tree-walk.o
    CC unpack-trees.o
    CC url.o
    CC urlmatch.o
    CC usage.o
    CC userdiff.o
    CC utf8.o
    CC varint.o
    CC versioncmp.o
    CC walker.o
    CC wildmatch.o
    CC worktree.o
    CC wrapper.o
    CC write_or_die.o
    CC ws.o
    CC wt-status.o
    CC xdiff-interface.o
    CC zlib.o
    CC unix-socket.o
    CC sha1dc/sha1.o
    CC sha1dc/ubc_check.o
    CC thread-utils.o
    CC compat/fopen.o
    CC compat/strlcpy.o
    CC compat/qsort_s.o
    CC xdiff/xdiffi.o
    CC xdiff/xprepare.o
    CC xdiff/xutils.o
    CC xdiff/xemit.o
    CC xdiff/xmerge.o
    CC xdiff/xpatience.o
    CC xdiff/xhistogram.o
    CC daemon.o
    CC fast-import.o
    CC http-backend.o
    CC imap-send.o
    CC http.o
    CC sh-i18n--envsubst.o
    CC shell.o
    CC show-index.o
    CC upload-pack.o
    CC remote-testsvn.o
    CC vcs-svn/line_buffer.o
    CC vcs-svn/sliding_window.o
    CC vcs-svn/fast_export.o
    CC vcs-svn/svndiff.o
    CC vcs-svn/svndump.o
    CC http-walker.o
    CC http-fetch.o
    CC credential-cache.o
    CC credential-cache--daemon.o
    CC remote-curl.o
    * new script parameters
    * new perl-specific parameters
    * new Python interpreter location
    GEN git-instaweb
    GEN git-mergetool--lib
    GEN git-parse-remote
    GEN git-rebase--am
    GEN git-rebase--interactive
    GEN git-rebase--merge
    GEN git-sh-setup
    GEN git-sh-i18n
    CC git.o
    CC builtin/add.o
    CC builtin/am.o
    CC builtin/annotate.o
    CC builtin/apply.o
    CC builtin/archive.o
    CC builtin/bisect--helper.o
    CC builtin/blame.o
    CC builtin/branch.o
    CC builtin/bundle.o
    CC builtin/cat-file.o
    CC builtin/check-attr.o
    CC builtin/check-ignore.o
    CC builtin/check-mailmap.o
    CC builtin/check-ref-format.o
    CC builtin/checkout-index.o
    CC builtin/checkout.o
    CC builtin/clean.o
    CC builtin/clone.o
    CC builtin/column.o
    CC builtin/commit-tree.o
    CC builtin/commit.o
    CC builtin/config.o
    CC builtin/count-objects.o
    CC builtin/credential.o
    CC builtin/describe.o
    CC builtin/diff-files.o
    CC builtin/diff-index.o
    CC builtin/diff-tree.o
    CC builtin/diff.o
    CC builtin/difftool.o
    CC builtin/fast-export.o
    CC builtin/fetch-pack.o
    CC builtin/fetch.o
    CC builtin/fmt-merge-msg.o
    CC builtin/for-each-ref.o
    CC builtin/fsck.o
    CC builtin/gc.o
    CC builtin/get-tar-commit-id.o
    CC builtin/grep.o
    CC builtin/hash-object.o
    CC builtin/help.o
    CC builtin/index-pack.o
    CC builtin/init-db.o
    CC builtin/interpret-trailers.o
    CC builtin/log.o
    CC builtin/ls-files.o
    CC builtin/ls-remote.o
    CC builtin/ls-tree.o
    CC builtin/mailinfo.o
    CC builtin/mailsplit.o
    CC builtin/merge.o
    CC builtin/merge-base.o
    CC builtin/merge-file.o
    CC builtin/merge-index.o
    CC builtin/merge-ours.o
    CC builtin/merge-recursive.o
    CC builtin/merge-tree.o
    CC builtin/mktag.o
    CC builtin/mktree.o
    CC builtin/mv.o
    CC builtin/name-rev.o
    CC builtin/notes.o
    CC builtin/pack-objects.o
    CC builtin/pack-redundant.o
    CC builtin/pack-refs.o
    CC builtin/patch-id.o
    CC builtin/prune-packed.o
    CC builtin/prune.o
    CC builtin/pull.o
    CC builtin/push.o
    CC builtin/read-tree.o
    CC builtin/rebase--helper.o
    CC builtin/receive-pack.o
    CC builtin/reflog.o
    CC builtin/remote.o
    CC builtin/remote-ext.o
    CC builtin/remote-fd.o
    CC builtin/repack.o
    CC builtin/replace.o
    CC builtin/rerere.o
    CC builtin/reset.o
    CC builtin/rev-list.o
    CC builtin/rev-parse.o
    CC builtin/revert.o
    CC builtin/rm.o
    CC builtin/send-pack.o
    CC builtin/shortlog.o
    CC builtin/show-branch.o
    CC builtin/show-ref.o
    CC builtin/stripspace.o
    CC builtin/submodule--helper.o
    CC builtin/symbolic-ref.o
    CC builtin/tag.o
    CC builtin/unpack-file.o
    CC builtin/unpack-objects.o
    CC builtin/update-index.o
    CC builtin/update-ref.o
    CC builtin/update-server-info.o
    CC builtin/upload-archive.o
    CC builtin/var.o
    CC builtin/verify-commit.o
    CC builtin/verify-pack.o
    CC builtin/verify-tag.o
    CC builtin/worktree.o
    CC builtin/write-tree.o
    CC credential-store.o
    CC common-main.o
    CC abspath.o
    CC advice.o
    CC alias.o
    CC alloc.o
    CC apply.o
    CC archive.o
    CC archive-tar.o
    CC archive-zip.o
    CC argv-array.o
    CC attr.o
    CC base85.o
    CC bisect.o
    CC blame.o
    CC blob.o
    CC branch.o
    CC bulk-checkin.o
    CC bundle.o
    CC cache-tree.o
    CC color.o
    CC column.o
    CC combine-diff.o
    CC commit.o
    CC compat/obstack.o
    CC compat/terminal.o
    CC config.o
    CC connect.o
    CC connected.o
    CC convert.o
    CC copy.o
    CC credential.o
    CC csum-file.o
    CC ctype.o
    CC date.o
    CC decorate.o
    CC diffcore-break.o
    CC diffcore-delta.o
    CC diffcore-order.o
    CC diffcore-pickaxe.o
    CC diffcore-rename.o
    CC diff-delta.o
    CC diff-lib.o
    CC diff-no-index.o
    CC diff.o
    CC dir.o
    CC dir-iterator.o
    CC editor.o
    CC entry.o
    CC environment.o
    CC ewah/bitmap.o
    CC ewah/ewah_bitmap.o
    CC ewah/ewah_io.o
    CC ewah/ewah_rlw.o
    CC exec_cmd.o
    CC fetch-pack.o
    CC fsck.o
    CC gettext.o
    CC gpg-interface.o
    CC graph.o
    CC grep.o
    CC hashmap.o
    CC help.o
    CC version.o
    AR xdiff/lib.a
    AR vcs-svn/lib.a
    GEN git-bisect
    GEN git-difftool--helper
    GEN git-filter-branch
    GEN git-merge-octopus
    GEN git-merge-one-file
    GEN git-merge-resolve
    GEN git-mergetool
    GEN git-quiltimport
    GEN git-rebase
    GEN git-request-pull
    GEN git-stash
    GEN git-submodule
    GEN git-web--browse
    SUBDIR perl
    GEN git-p4
/usr/local/bin/perl Makefile.PL PREFIX='/usr/local' INSTALL_BASE=''
--localedir='/usr/local/share/locale'
    AR libgit.a
    LINK git-credential-store
    LINK git-daemon
    LINK git-fast-import
libgit.a(grep.o): In function `pcre1match':
grep.c:(.text+0x1219): undefined reference to `pcre_jit_exec'
collect2: error: ld returned 1 exit status
make: *** [Makefile:2145: git-credential-store] Error 1
make: *** Waiting for unfinished jobs....
libgit.a(grep.o): In function `pcre1match':
grep.c:(.text+0x1219): undefined reference to `pcre_jit_exec'
collect2: error: ld returned 1 exit status
make: *** [Makefile:2145: git-fast-import] Error 1
libgit.a(grep.o): In function `pcre1match':
grep.c:(.text+0x1219): undefined reference to `pcre_jit_exec'
collect2: error: ld returned 1 exit status
make: *** [Makefile:2145: git-daemon] Error 1
Generating a Unix-style perl.mak
Writing perl.mak for Git
Writing MYMETA.yml and MYMETA.json
    * new build flags
    CC credential-store.o
    CC common-main.o
    CC abspath.o
    CC advice.o
    CC alias.o
    CC alloc.o
    CC apply.o
    CC archive.o
    CC archive-tar.o
    CC archive-zip.o
    CC argv-array.o
    CC attr.o
    CC base85.o
    CC bisect.o
    CC blame.o
    CC blob.o
    CC branch.o
    CC bulk-checkin.o
    CC bundle.o
    CC cache-tree.o
    CC color.o
    CC column.o
    CC combine-diff.o
    CC commit.o
    CC compat/obstack.o
    CC compat/terminal.o
    CC config.o
    CC connect.o
    CC connected.o
    CC convert.o
    CC copy.o
    CC credential.o
    CC csum-file.o
    CC ctype.o
    CC date.o
    CC decorate.o
    CC diffcore-break.o
    CC diffcore-delta.o
    CC diffcore-order.o
    CC diffcore-pickaxe.o
    CC diffcore-rename.o
    CC diff-delta.o
    CC diff-lib.o
    CC diff-no-index.o
    CC diff.o
    CC dir.o
    CC dir-iterator.o
    CC editor.o
    CC entry.o
    CC environment.o
    CC ewah/bitmap.o
    CC ewah/ewah_bitmap.o
    CC ewah/ewah_io.o
    CC ewah/ewah_rlw.o
    CC exec_cmd.o
    CC fetch-pack.o
    CC fsck.o
    CC gettext.o
    CC gpg-interface.o
    CC graph.o
    CC grep.o
    CC hashmap.o
    CC help.o
    CC hex.o
    CC ident.o
    CC kwset.o
    CC levenshtein.o
    CC line-log.o
    CC line-range.o
    CC list-objects.o
    CC ll-merge.o
    CC lockfile.o
    CC log-tree.o
    CC mailinfo.o
    CC mailmap.o
    CC match-trees.o
    CC merge.o
    CC merge-blobs.o
    CC merge-recursive.o
    CC mergesort.o
    CC mru.o
    CC name-hash.o
    CC notes.o
    CC notes-cache.o
    CC notes-merge.o
    CC notes-utils.o
    CC object.o
    CC oidset.o
    CC pack-bitmap.o
    CC pack-bitmap-write.o
    CC pack-check.o
    CC pack-objects.o
    CC pack-revindex.o
    CC pack-write.o
    CC pager.o
    CC parse-options.o
    CC parse-options-cb.o
    CC patch-delta.o
    CC patch-ids.o
    CC path.o
    CC pathspec.o
    CC pkt-line.o
    CC preload-index.o
    CC pretty.o
    CC prio-queue.o
    CC progress.o
    CC prompt.o
    CC quote.o
    CC reachable.o
    CC read-cache.o
    CC reflog-walk.o
    CC refs.o
    CC refs/files-backend.o
    CC refs/iterator.o
    CC refs/ref-cache.o
    CC ref-filter.o
    CC remote.o
    CC replace_object.o
    CC repository.o
    CC rerere.o
    CC resolve-undo.o
    CC revision.o
    CC run-command.o
    CC send-pack.o
    CC sequencer.o
    CC server-info.o
    CC setup.o
    CC sha1-array.o
    CC sha1-lookup.o
    CC sha1_file.o
    CC sha1_name.o
    CC shallow.o
    CC sideband.o
    CC sigchain.o
    CC split-index.o
    CC strbuf.o
    CC streaming.o
    CC string-list.o
    CC submodule.o
    CC submodule-config.o
    CC sub-process.o
    CC symlinks.o
    CC tag.o
    CC tempfile.o
    CC tmp-objdir.o
    CC trace.o
    CC trailer.o
    CC transport.o
    CC transport-helper.o
    CC tree-diff.o
    CC tree.o
    CC tree-walk.o
    CC unpack-trees.o
    CC url.o
    CC urlmatch.o
    CC usage.o
    CC userdiff.o
    CC utf8.o
    CC varint.o
    CC version.o
    CC versioncmp.o
    CC walker.o
    CC wildmatch.o
    CC worktree.o
    CC wrapper.o
    CC write_or_die.o
    CC ws.o
    CC wt-status.o
    CC xdiff-interface.o
    CC zlib.o
    CC unix-socket.o
    CC sha1dc/sha1.o
    CC sha1dc/ubc_check.o
    CC thread-utils.o
    CC compat/fopen.o
    CC compat/strlcpy.o
    CC compat/qsort_s.o
    AR libgit.a
    CC xdiff/xdiffi.o
    CC xdiff/xprepare.o
    CC xdiff/xutils.o
    CC xdiff/xemit.o
    CC xdiff/xmerge.o
    CC xdiff/xpatience.o
    CC xdiff/xhistogram.o
    AR xdiff/lib.a
    LINK git-credential-store
libgit.a(grep.o): In function `pcre1match':
grep.c:(.text+0x1219): undefined reference to `pcre_jit_exec'
collect2: error: ld returned 1 exit status
make: *** [Makefile:2145: git-credential-store] Error 1
