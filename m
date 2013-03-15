From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 00/45] nd/parse-pathspec and :(glob) pathspec magic
Date: Fri, 15 Mar 2013 13:06:15 +0700
Message-ID: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:24:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO43-0003Ka-JA
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952Ab3COGYA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:24:00 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:64872 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab3COGX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:23:59 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so3913677ieb.6
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=x6L4P/ZfYbNQM8mnzxU5C+V3lvyqLQNTXNZIQLXB+dM=;
        b=RUapXIqJjLugInONmz1AuK4I3FZBlbmkvYmLPkVshoQVK8vminkd0l7T3VZnMwUWFt
         h/aWZP+nIIF2VoHwqhhNu4VTj0tm6qGDxiQvs7LhRcL0/d5g83P16ZVG/MMda7kksE6y
         dC2Umty0fBpOKJTGpnM8NYba6dl0IeFci6jjEvH3w/Nog2NFjr1uNoIBPtGFUoYHlKAw
         Hu2X6gvwmy00nRcW3PbgLm2BTqqjY5JZvqM2vJACVj7UygVrx+rr5Xj1uTairDQ6J7as
         vlYtIy/cJD2tM4S8h/nP4VtqIak66NR5Cxjyd+VVrqP67gu7+p8p6tmUAjUbRe61v6H8
         8WYg==
X-Received: by 10.42.159.194 with SMTP id m2mr3950235icx.13.1363328638786;
        Thu, 14 Mar 2013 23:23:58 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id g6sm620909ign.4.2013.03.14.23.23.55
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:23:57 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:07:01 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218187>

Probably not much to say. A big portion of this series is the
conversion to struct pathspec, which enables more use of pathspec
magic. :(glob) magic is added to verify that the conversion makes
sense.

Andrew Wong (1):
  setup.c: check that the pathspec magic ends with ")"

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (44):
  clean: remove unused variable "seen"
  Move struct pathspec and related functions to pathspec.[ch]
  pathspec: i18n-ize error strings in pathspec parsing code
  pathspec: add copy_pathspec
  Add parse_pathspec() that converts cmdline args to struct pathspec
  parse_pathspec: save original pathspec for reporting
  parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
  Convert some get_pathspec() calls to parse_pathspec()
  parse_pathspec: a special flag for max_depth feature
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
  parse_pathspec: make sure the prefix part is wildcard-free
  parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
  Kill limit_pathspec_to_literal() as it's only used by parse_pathspec(=
)
  pathspec: support :(literal) syntax for noglob pathspec
  pathspec: make --literal-pathspecs disable pathspec magic
  pathspec: support :(glob) syntax
  Rename field "raw" to "_raw" in struct pathspec

 Documentation/git.txt              |  23 +-
 Documentation/glossary-content.txt |  33 +++
 archive.c                          |  18 +-
 archive.h                          |   4 +-
 builtin/add.c                      | 156 ++++++--------
 builtin/blame.c                    |  14 +-
 builtin/check-ignore.c             |  34 +--
 builtin/checkout.c                 |  46 ++--
 builtin/clean.c                    |  24 +--
 builtin/commit.c                   |  37 ++--
 builtin/diff-files.c               |   2 +-
 builtin/diff-index.c               |   2 +-
 builtin/diff.c                     |   6 +-
 builtin/grep.c                     |  10 +-
 builtin/log.c                      |   2 +-
 builtin/ls-files.c                 |  75 +++----
 builtin/ls-tree.c                  |  13 +-
 builtin/mv.c                       |  13 +-
 builtin/rerere.c                   |   8 +-
 builtin/reset.c                    |  33 +--
 builtin/rm.c                       |  24 +--
 builtin/update-index.c             |   6 +-
 cache.h                            |  34 +--
 commit.h                           |   2 +-
 diff-lib.c                         |   3 +-
 diff.h                             |   3 +-
 dir.c                              | 261 +++++-----------------
 dir.h                              |  18 +-
 git.c                              |   8 +
 merge-recursive.c                  |   2 +-
 notes-merge.c                      |   4 +-
 path.c                             |  15 +-
 pathspec.c                         | 431 +++++++++++++++++++++++++++++=
++++----
 pathspec.h                         |  59 ++++-
 preload-index.c                    |  21 +-
 read-cache.c                       |   5 +-
 rerere.c                           |   7 +-
 rerere.h                           |   4 +-
 resolve-undo.c                     |   4 +-
 resolve-undo.h                     |   2 +-
 revision.c                         |  11 +-
 setup.c                            | 157 +-------------
 t/t0008-ignores.sh                 |   8 +-
 t/t6130-pathspec-noglob.sh         |  18 ++
 tree-diff.c                        |  48 +++--
 tree-walk.c                        |  21 +-
 tree.c                             |   4 +-
 tree.h                             |   2 +-
 wt-status.c                        |  18 +-
 wt-status.h                        |   2 +-
 50 files changed, 983 insertions(+), 772 deletions(-)

--=20
1.8.0.rc0.19.g7bbb31d
