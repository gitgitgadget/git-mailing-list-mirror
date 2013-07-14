From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/46] "struct pathspec" conversion and :(glob) and :(icase)
Date: Sun, 14 Jul 2013 15:35:23 +0700
Message-ID: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:36:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHn8-0000yT-VG
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816Ab3GNIgW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:36:22 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:45032 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIgU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:36:20 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so10238740pbc.40
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=pRUWVoJOMghpvyx6geVr8BKZTD/hzMduYSpTPTAbtZ8=;
        b=Nux6hdIRkksp4Qll24H0n87W4k98XFGFvV+9OpymDOpPi5Kgw2hGoQRckNRVGw2IGU
         ai0qeDip3Et7uwAbPkQpPjIA3hUhZt+SFjXOAlXusVy9Is3Tc/3AQE2AiY/au432Yk7K
         wWZlzUvUj0gYHPpzw66MXDi8bNyqvP4AxAHdPNrOTqlWkDl5CaVPvWi9tPbuWNsLl+bz
         uMV62XknlstiPwXJaQK3PcXIeaTUVmPUE76KhJ42VTmHsB8tkREAmZlO8QBC2EnIIeZ8
         2u8SJCiR+dcGfNGhC1tAULervjMgRzAUq4myttcHwgrzkggknscBoE9fSVbqdgPEpEG+
         LFMw==
X-Received: by 10.68.134.103 with SMTP id pj7mr48320347pbb.171.1373790980123;
        Sun, 14 Jul 2013 01:36:20 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id y9sm54514524pbb.46.2013.07.14.01.36.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:36:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:36:31 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230312>

Compared to the last round [1] this series mainly fixes comments and
commit messages suggested by Eric and Junio. It also fixes a conflict
with cb/log-follow-with-combined (in master) and introduces :(icase)
mentioned in the last round.

[1] http://thread.gmane.org/gmane.comp.version-control.git/226892

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (46):
  clean: remove unused variable "seen"
  Move struct pathspec and related functions to pathspec.[ch]
  pathspec: i18n-ize error strings in pathspec parsing code
  pathspec: add copy_pathspec
  Add parse_pathspec() that converts cmdline args to struct pathspec
  parse_pathspec: save original pathspec for reporting
  parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
  Convert some get_pathspec() calls to parse_pathspec()
  parse_pathspec: add special flag for max_depth feature
  parse_pathspec: support stripping submodule trailing slashes
  parse_pathspec: support stripping/checking submodule paths
  parse_pathspec: support prefixing original patterns
  Guard against new pathspec magic in pathspec matching code
  clean: convert to use parse_pathspec
  commit: convert to use parse_pathspec
  status: convert to use parse_pathspec
  rerere: convert to use parse_pathspec
  checkout: convert to use parse_pathspec
  rm: convert to use parse_pathspec
  ls-files: convert to use parse_pathspec
  archive: convert to use parse_pathspec
  check-ignore: convert to use parse_pathspec
  add: convert to use parse_pathspec
  reset: convert to use parse_pathspec
  line-log: convert to use parse_pathspec
  Convert read_cache_preload() to take struct pathspec
  Convert run_add_interactive to use struct pathspec
  Convert unmerge_cache to take struct pathspec
  checkout: convert read_tree_some to take struct pathspec
  Convert report_path_error to take struct pathspec
  Convert refresh_index to take struct pathspec
  Convert {read,fill}_directory to take struct pathspec
  Convert add_files_to_cache to take struct pathspec
  Convert common_prefix() to use struct pathspec
  Remove diff_tree_{setup,release}_paths
  Remove init_pathspec() in favor of parse_pathspec()
  Remove match_pathspec() in favor of match_pathspec_depth()
  tree-diff: remove the use of pathspec's raw[] in follow-rename codepa=
th
  Rename field "raw" to "_raw" in struct pathspec
  parse_pathspec: make sure the prefix part is wildcard-free
  parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
  Kill limit_pathspec_to_literal() as it's only used by parse_pathspec(=
)
  pathspec: support :(literal) syntax for noglob pathspec
  pathspec: make --literal-pathspecs disable pathspec magic
  pathspec: support :(glob) syntax
  parse_pathspec: accept :(icase)path syntax

 Documentation/git.txt                 |  31 ++-
 Documentation/glossary-content.txt    |  52 +++-
 Documentation/technical/api-setup.txt |  38 ++-
 archive.c                             |  18 +-
 archive.h                             |   4 +-
 builtin/add.c                         | 166 ++++++-------
 builtin/blame.c                       |  14 +-
 builtin/check-ignore.c                |  35 ++-
 builtin/checkout.c                    |  40 +--
 builtin/clean.c                       |  24 +-
 builtin/commit.c                      |  37 ++-
 builtin/diff-files.c                  |   2 +-
 builtin/diff-index.c                  |   2 +-
 builtin/diff.c                        |   6 +-
 builtin/grep.c                        |  10 +-
 builtin/log.c                         |   2 +-
 builtin/ls-files.c                    |  75 +++---
 builtin/ls-tree.c                     |  13 +-
 builtin/mv.c                          |  13 +-
 builtin/rerere.c                      |   8 +-
 builtin/reset.c                       |  33 ++-
 builtin/rm.c                          |  24 +-
 builtin/update-index.c                |   6 +-
 cache.h                               |  35 +--
 combine-diff.c                        |   4 +-
 commit.h                              |   2 +-
 diff-lib.c                            |   3 +-
 diff.h                                |   3 +-
 dir.c                                 | 319 +++++++++---------------
 dir.h                                 |  18 +-
 git.c                                 |  12 +
 line-log.c                            |   2 +-
 merge-recursive.c                     |   2 +-
 notes-merge.c                         |   4 +-
 path.c                                |  15 +-
 pathspec.c                            | 449 ++++++++++++++++++++++++++=
+++++---
 pathspec.h                            |  88 ++++++-
 preload-index.c                       |  21 +-
 read-cache.c                          |   5 +-
 rerere.c                              |   7 +-
 rerere.h                              |   4 +-
 resolve-undo.c                        |   4 +-
 resolve-undo.h                        |   2 +-
 revision.c                            |  11 +-
 setup.c                               | 173 ++-----------
 t/t0008-ignores.sh                    |   8 +-
 t/t6130-pathspec-noglob.sh            |  87 +++++++
 t/t6131-pathspec-icase.sh (new +x)    |  97 ++++++++
 tree-diff.c                           |  48 ++--
 tree-walk.c                           |  78 ++++--
 tree.c                                |   4 +-
 tree.h                                |   2 +-
 wt-status.c                           |  16 +-
 wt-status.h                           |   2 +-
 54 files changed, 1385 insertions(+), 793 deletions(-)
 create mode 100755 t/t6131-pathspec-icase.sh

--=20
1.8.2.83.gc99314b
