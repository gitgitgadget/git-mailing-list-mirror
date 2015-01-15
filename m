From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: Unused #include statements
Date: Thu, 15 Jan 2015 14:43:06 +1100
Message-ID: <CAKJhZwR+iMYAMCxurgc7z2dhqoqx_RxV1G4Jh3phPAOGptp_XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 15 04:43:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBbL1-0003ou-P4
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 04:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbbAODnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 22:43:09 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:42311 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbbAODnH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 22:43:07 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so12791092ieb.7
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 19:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=SYbz+78mE8w5knZoGDXvXfXBAhR5qH5r8X9REJCqAPM=;
        b=rkgSDhwYSPiuD+M175xgYKDbtEvzE9ab8WulFM6zzG+VEtPyPpxhFAGEES6qZAPmwW
         zRtK4YzQ0Y4+jnAtrgDo4BBUWQDsInepKmZ6N3hdSQmWPGnthKeNIbJ7GyuBPgWLPHL1
         wTq9bQW4tf08z5aoVgc0rgtyyPpVaypi3tEA3ARkHBYe5a3oXphHj0JyhrcmIDFW1zSE
         x10vPyBXOQVVP7FJvWcnz1pmGfcOOke5pjbNagM1f4WeMwNrsDH1ok+jztq1fS2eslV+
         Y86vhVYbmNrTfT1fysma5V+D/b1MNh4jacCinPfRUIEIeEvVrcCUhwErVfs/ji5H0VOr
         sltA==
X-Received: by 10.50.79.196 with SMTP id l4mr8242785igx.14.1421293386414; Wed,
 14 Jan 2015 19:43:06 -0800 (PST)
Received: by 10.50.6.197 with HTTP; Wed, 14 Jan 2015 19:43:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262454>

Hello there,

Since reading a post [1] about removing some unnecessary #include statements
from a git C source file I've been intrigued to see how many more might be
lurking in the code base.

After a bit of digging around, my brute force approach of 'remove as many
#includes as possible while making sure the code still successfully compiles'
has returned the following results:


$ git diff --stat
 alloc.c                                                    |  2 --
 archive-zip.c                                              |  1 -
 archive.c                                                  |  1 -
 argv-array.c                                               |  1 -
 bisect.c                                                   |  9 ---------
 block-sha1/sha1.c                                          |  2 --
 branch.c                                                   |  1 -
 builtin/add.c                                              |  7 -------
 builtin/annotate.c                                         |  1 -
 builtin/apply.c                                            |  8 --------
 builtin/archive.c                                          |  3 ---
 builtin/bisect--helper.c                                   |  2 --
 builtin/blame.c                                            | 13 -------------
 builtin/branch.c                                           |  8 --------
 builtin/bundle.c                                           |  1 -
 builtin/cat-file.c                                         |  3 ---
 builtin/check-attr.c                                       |  2 --
 builtin/check-ignore.c                                     |  2 --
 builtin/check-mailmap.c                                    |  2 --
 builtin/check-ref-format.c                                 |  2 --
 builtin/checkout-index.c                                   |  2 --
 builtin/checkout.c                                         | 11 -----------
 builtin/clean.c                                            |  3 ---
 builtin/clone.c                                            | 10 ----------
 builtin/column.c                                           |  3 ---
 builtin/commit-tree.c                                      |  4 ----
 builtin/commit.c                                           | 13 -------------
 builtin/config.c                                           |  1 -
 builtin/count-objects.c                                    |  2 --
 builtin/credential.c                                       |  1 -
 builtin/describe.c                                         |  5 -----
 builtin/diff-files.c                                       |  4 ----
 builtin/diff-index.c                                       |  4 ----
 builtin/diff-tree.c                                        |  4 ----
 builtin/diff.c                                             |  6 ------
 builtin/fast-export.c                                      |  8 --------
 builtin/fetch.c                                            |  8 --------
 builtin/fmt-merge-msg.c                                    |  6 ------
 builtin/for-each-ref.c                                     |  6 ------
 builtin/fsck.c                                             |  7 -------
 builtin/gc.c                                               |  3 ---
 builtin/get-tar-commit-id.c                                |  3 ---
 builtin/grep.c                                             |  6 ------
 builtin/hash-object.c                                      |  2 --
 builtin/help.c                                             |  2 --
 builtin/index-pack.c                                       |  5 -----
 builtin/init-db.c                                          |  1 -
 builtin/interpret-trailers.c                               |  3 ---
 builtin/log.c                                              | 14 --------------
 builtin/ls-files.c                                         |  3 ---
 builtin/ls-remote.c                                        |  3 ---
 builtin/ls-tree.c                                          |  3 ---
 builtin/mailinfo.c                                         |  2 --
 builtin/mailsplit.c                                        |  3 ---
 builtin/merge-base.c                                       |  5 -----
 builtin/merge-file.c                                       |  2 --
 builtin/merge-index.c                                      |  1 -
 builtin/merge-ours.c                                       |  1 -
 builtin/merge-recursive.c                                  |  3 ---
 builtin/merge-tree.c                                       |  2 --
 builtin/merge.c                                            | 10 ----------
 builtin/mktree.c                                           |  2 --
 builtin/mv.c                                               |  4 ----
 builtin/name-rev.c                                         |  3 ---
 builtin/notes.c                                            |  4 ----
 builtin/pack-objects.c                                     | 14 --------------
 builtin/prune-packed.c                                     |  1 -
 builtin/prune.c                                            |  5 -----
 builtin/push.c                                             |  6 ------
 builtin/read-tree.c                                        |  4 ----
 builtin/receive-pack.c                                     | 12 ------------
 builtin/reflog.c                                           |  5 -----
 builtin/remote-ext.c                                       |  1 -
 builtin/remote-fd.c                                        |  1 -
 builtin/remote.c                                           |  6 ------
 builtin/repack.c                                           |  6 ------
 builtin/replace.c                                          |  1 -
 builtin/rerere.c                                           |  4 ----
 builtin/reset.c                                            |  7 -------
 builtin/rev-list.c                                         |  7 -------
 builtin/rev-parse.c                                        |  5 -----
 builtin/revert.c                                           |  4 ----
 builtin/rm.c                                               |  4 ----
 builtin/send-pack.c                                        |  7 -------
 builtin/shortlog.c                                         |  7 -------
 builtin/show-branch.c                                      |  3 ---
 builtin/show-ref.c                                         |  5 -----
 builtin/stripspace.c                                       |  1 -
 builtin/symbolic-ref.c                                     |  1 -
 builtin/tag.c                                              |  4 ----
 builtin/unpack-objects.c                                   |  7 -------
 builtin/update-index.c                                     |  7 -------
 builtin/update-ref.c                                       |  3 ---
 builtin/update-server-info.c                               |  1 -
 builtin/upload-archive.c                                   |  5 -----
 builtin/verify-commit.c                                    |  5 -----
 builtin/verify-pack.c                                      |  1 -
 builtin/verify-tag.c                                       |  5 -----
 builtin/write-tree.c                                       |  2 --
 bulk-checkin.c                                             |  3 ---
 bundle.c                                                   |  5 -----
 cache-tree.c                                               |  2 --
 check-racy.c                                               |  1 -
 column.c                                                   |  2 --
 combine-diff.c                                             |  6 ------
 commit.c                                                   |  7 -------
 compat/basename.c                                          |  1 -
 compat/fopen.c                                             |  1 -
 compat/gmtime.c                                            |  1 -
 compat/hstrerror.c                                         |  3 ---
 compat/inet_ntop.c                                         |  1 -
 compat/inet_pton.c                                         |  1 -
 compat/mingw.c                                             |  7 -------
 compat/mkdir.c                                             |  1 -
 compat/mkdtemp.c                                           |  1 -
 compat/mmap.c                                              |  1 -
 compat/msvc.c                                              |  5 -----
 compat/nedmalloc/nedmalloc.c                               |  2 --
 compat/obstack.c                                           |  1 -
 compat/poll/poll.c                                         |  6 ------
 compat/pread.c                                             |  1 -
 compat/precompose_utf8.c                                   |  1 -
 compat/qsort.c                                             |  1 -
 compat/regex/regex.c                                       |  2 --
 compat/setenv.c                                            |  1 -
 compat/snprintf.c                                          |  1 -
 compat/strcasestr.c                                        |  1 -
 compat/strlcpy.c                                           |  1 -
 compat/strtoimax.c                                         |  1 -
 compat/strtoumax.c                                         |  1 -
 compat/terminal.c                                          |  2 --
 compat/unsetenv.c                                          |  1 -
 compat/win32/dirent.c                                      |  1 -
 compat/win32/pthread.c                                     |  4 ----
 compat/win32/syslog.c                                      |  1 -
 compat/win32mmap.c                                         |  1 -
 compat/winansi.c                                           |  3 ---
 config.c                                                   |  4 ----
 connect.c                                                  |  4 ----
 connected.c                                                |  2 --
 contrib/convert-objects/convert-objects.c                  |  4 ----
 .../gnome-keyring/git-credential-gnome-keyring.c           |  6 ------
 .../credential/osxkeychain/git-credential-osxkeychain.c    |  4 ----
 contrib/credential/wincred/git-credential-wincred.c        |  4 ----
 contrib/examples/builtin-fetch--tool.c                     |  5 -----
 contrib/svn-fe/svn-fe.c                                    |  2 --
 convert.c                                                  |  2 --
 credential-cache--daemon.c                                 |  2 --
 credential-cache.c                                         |  3 ---
 credential-store.c                                         |  1 -
 credential.c                                               |  1 -
 csum-file.c                                                |  1 -
 daemon.c                                                   |  3 ---
 diff-delta.c                                               |  1 -
 diff-lib.c                                                 |  5 -----
 155 files changed, 562 deletions(-)


So my questions are as follows:

(1) Is it worth turning this into a proper patch?

(2) Given the large number of files (150+) what would be the best
    approach in preparing the patch?

        (a) One commit containing all the changes? Would it be a bit too much
            to digest in one go?

        (b) One commit per file changed? Feels a bit over the top also it
            would flood the mailing list.

        (c) One commit each for changes in the root directory, builtin,
            compat and contrib directories?

Thanks,
Zoltan

[1] http://article.gmane.org/gmane.comp.version-control.git/262402
