From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/23] nd/sparse reroll
Date: Mon, 14 Dec 2009 17:30:43 +0700
Message-ID: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:31:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8Db-0007Sc-NL
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbZLNKbw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbZLNKbw
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:31:52 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:47974 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbZLNKbv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:31:51 -0500
Received: by pzk1 with SMTP id 1so2177665pzk.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=4bDSacfipvEcFHba4YxU5VVcy6DWTEkBY2Ea7WWc6RA=;
        b=x+JpYgeF78s7vPPNFIUKk1vFOftCMLDgQpnfQMJoUepOUYT1+lORQ21rqOojZXMyF4
         mSrGGlXCgnGe2i+0m/3vBZx9+hepNrwIah7gDsppCCQklyRGzKImzVSpkVUYdbxCDCDW
         boHlLADJWKwxXk+I5UfD6k3p4alBb70aes6mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=DNI94APZefv+GYpaj4DrkKdy0oGtF9sP5VyMhbVO6r7emCD0u6nWlXscn4EhVKSySH
         AsvSidMyapzu04O+mPExVZVS77shnEKilB9YV7qmICRGz0+E80ch5iw/BDjjtNvTh/3u
         wFFNu3JGGpWe0sId7GnuImvHIk6yosAaxzxxQ=
Received: by 10.141.100.14 with SMTP id c14mr3221157rvm.99.1260786710152;
        Mon, 14 Dec 2009 02:31:50 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 21sm4903916pzk.7.2009.12.14.02.31.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:31:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:31:07 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135173>

Compared to the current series in pu, patch "Teach Git to respect
skip-worktree (reading part)" has been broken up into smaller patches.
builtin-commit.c is also fixed to make the two failed test cases in
t7011 now pass. Skip-worktree bit no longer relies on
CE_MATCH_IGNORE_VALID flag, which means=20
"git update-index --really-refresh" respects skip-worktree bit too. =20

The rest is unchanged.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (23):
  update-index: refactor mark_valid() in preparation for new options
  Add test-index-version
  Introduce "skip-worktree" bit in index, teach Git to get/set this bit
  update-index: ignore update request if it's skip-worktree
  Teach ls-files and update-index to respect skip-worktree bit
  Teach diff machinery to respect skip-worktree bit
  Teach grep to respect skip-worktree bit
  Teach commit to respect skip-worktree bit
  Teach Git to respect skip-worktree bit (writing part)
  Avoid writing to buffer in add_excludes_from_file_1()
  Read .gitignore from index if it is skip-worktree
  unpack-trees(): carry skip-worktree bit over in merged_entry()
  excluded_1(): support exclude files in index
  dir.c: export excluded_1() and add_excludes_from_file_1()
  Introduce "sparse checkout"
  unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
  unpack-trees.c: generalize verify_* functions
  unpack-trees(): "enable" sparse checkout and load
    $GIT_DIR/info/sparse-checkout
  unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final
    index
  unpack-trees(): ignore worktree check outside checkout area
  read-tree: add --no-sparse-checkout to disable sparse checkout
    support
  Add tests for sparse checkout
  sparse checkout: inhibit empty worktree

 .gitignore                                        |    1 +
 Documentation/config.txt                          |    4 +
 Documentation/git-ls-files.txt                    |    1 +
 Documentation/git-read-tree.txt                   |   52 ++++++-
 Documentation/git-update-index.txt                |   29 ++++
 Documentation/technical/api-directory-listing.txt |    3 +
 Makefile                                          |    1 +
 builtin-apply.c                                   |    2 +-
 builtin-clean.c                                   |    4 +-
 builtin-commit.c                                  |   11 +-
 builtin-grep.c                                    |    2 +-
 builtin-ls-files.c                                |   11 +-
 builtin-read-tree.c                               |    4 +-
 builtin-update-index.c                            |   78 ++++++----
 cache.h                                           |   10 +-
 config.c                                          |    5 +
 diff-lib.c                                        |    5 +-
 diff.c                                            |    2 +-
 dir.c                                             |  100 ++++++++----
 dir.h                                             |    4 +
 entry.c                                           |    2 +-
 environment.c                                     |    1 +
 read-cache.c                                      |   17 ++-
 t/t1011-read-tree-sparse-checkout.sh              |  150 +++++++++++++=
++++
 t/t2104-update-index-skip-worktree.sh             |   57 +++++++
 t/t3001-ls-files-others-exclude.sh                |   22 +++
 t/t7011-skip-worktree-reading.sh                  |  158 +++++++++++++=
+++++
 t/t7012-skip-worktree-writing.sh                  |  139 +++++++++++++=
+++
 t/t7300-clean.sh                                  |   19 +++
 test-index-version.c                              |   14 ++
 unpack-trees.c                                    |  181 +++++++++++++=
++++++--
 unpack-trees.h                                    |    6 +
 32 files changed, 994 insertions(+), 101 deletions(-)
 create mode 100755 t/t1011-read-tree-sparse-checkout.sh
 create mode 100755 t/t2104-update-index-skip-worktree.sh
 create mode 100755 t/t7011-skip-worktree-reading.sh
 create mode 100755 t/t7012-skip-worktree-writing.sh
 create mode 100644 test-index-version.c
