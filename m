From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH 1/3] command-list.txt: group common commands by theme
Date: Mon,  4 May 2015 22:28:08 +0200
Message-ID: <b89d3fec640cb6fb01aa32ad50bae4e064528220.1430770308.git.sebastien.guimmara@gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>, gitster@pobox.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 22:28:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpMyh-0001qX-AV
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 22:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbbEDU2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 May 2015 16:28:31 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34441 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbbEDU23 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 16:28:29 -0400
Received: by wicmx19 with SMTP id mx19so85644072wic.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 13:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=if0TamAQlLHB43MElS3aj/W70b1N5PMh30pnuWnOz7A=;
        b=e55lYh4ByhoUWTDh90XFwcHbyato7k258/CtU22nkdIjft/y6VBhinRdHAb6gdy3DY
         AyhrrEkQ8ny7MX2/0eitZQO21tLiQnfUeBdX5HN3XU+10HLNNboVRu2mYdMcGIzFBKoV
         Qsn0JOY9DVzM/oNSQy4VDza59mipBFuKA+qIdQxkwiEKAU7zq4+hBdUTUPMB0TSaKeok
         JcnQi6cSEjBSlRzVEPIi4tlY8QpsCGvPDvtofE29erLa9PrXma+NbJZSj72a5ijLEVNX
         0VWQsyUd85KMUiS/0yW33RTZ6k6cmB0UMtbI8r9N7cmFcJJ43dLvTqe8ba2IRtmkUGxZ
         63Vg==
X-Received: by 10.180.80.197 with SMTP id t5mr510486wix.63.1430771308395;
        Mon, 04 May 2015 13:28:28 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id xb3sm22164354wjc.38.2015.05.04.13.28.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 13:28:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1430770308.git.sebastien.guimmara@gmail.com>
In-Reply-To: <cover.1430770308.git.sebastien.guimmara@gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268347>

Declare groups for common commands in the [groups] block,
followed by group names and descriptions:

   [groups]
   init                   starting a working area
   worktree               working on the current change
   remote                 working with others
   info                   examining the history and state
   history                growing, marking and tweaking your history

Then, in the [commands] block, map all common commands with a group:

   [commands]
   git-add        mainporcelain     common-worktree
   git-branch     mainporcelain     common-history
   git-checkout   mainporcelain     common-history
   [...]

command names and groups are then parsed with generate-cmdlist.sh to
generate common-commands.h.

Those commands are displayed in groups in the output of 'git help'.

Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 command-list.txt | 64 ++++++++++++++++++++++++++++++++----------------=
--------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index f1eae08..64394ca 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,29 +1,39 @@
 # List of known git commands.
-# command name				category [deprecated] [common]
-git-add                                 mainporcelain common
+# only add group information for common commands
+
+[groups]
+init                   starting a working area
+worktree               working on the current change
+remote                 working with others
+info                   examining the history and state
+history                growing, marking and tweaking your history
+
+# command name         [deprecated]     category                     [=
group]
+[commands]
+git-add                                 mainporcelain                c=
ommon-worktree
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
 git-apply                               plumbingmanipulators
 git-archimport                          foreignscminterface
 git-archive                             mainporcelain
-git-bisect                              mainporcelain common
+git-bisect                              mainporcelain
 git-blame                               ancillaryinterrogators
-git-branch                              mainporcelain common
+git-branch                              mainporcelain                c=
ommon-history
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
 git-check-ignore                        purehelpers
 git-check-mailmap                       purehelpers
-git-checkout                            mainporcelain common
+git-checkout                            mainporcelain                c=
ommon-history
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
 git-cherry                              ancillaryinterrogators
 git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
-git-clone                               mainporcelain common
+git-clone                               mainporcelain                c=
ommon-init
 git-column                              purehelpers
-git-commit                              mainporcelain common
+git-commit                              mainporcelain                c=
ommon-history
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
@@ -35,42 +45,42 @@ git-cvsimport                           foreignscmi=
nterface
 git-cvsserver                           foreignscminterface
 git-daemon                              synchingrepositories
 git-describe                            mainporcelain
-git-diff                                mainporcelain common
+git-diff                                mainporcelain                c=
ommon-history
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
 git-difftool                            ancillaryinterrogators
-git-fast-export				ancillarymanipulators
-git-fast-import				ancillarymanipulators
-git-fetch                               mainporcelain common
+git-fast-export                         ancillarymanipulators
+git-fast-import                         ancillarymanipulators
+git-fetch                               mainporcelain                c=
ommon-remote
 git-fetch-pack                          synchingrepositories
 git-filter-branch                       ancillarymanipulators
 git-fmt-merge-msg                       purehelpers
 git-for-each-ref                        plumbinginterrogators
 git-format-patch                        mainporcelain
-git-fsck	                        ancillaryinterrogators
+git-fsck                                ancillaryinterrogators
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
-git-grep                                mainporcelain common
+git-grep                                mainporcelain
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
-git-help				ancillaryinterrogators
+git-help                                ancillaryinterrogators
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
 git-imap-send                           foreignscminterface
 git-index-pack                          plumbingmanipulators
-git-init                                mainporcelain common
+git-init                                mainporcelain                c=
ommon-init
 git-instaweb                            ancillaryinterrogators
 git-interpret-trailers                  purehelpers
 gitk                                    mainporcelain
-git-log                                 mainporcelain common
+git-log                                 mainporcelain                c=
ommon-info
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
 git-mailinfo                            purehelpers
 git-mailsplit                           purehelpers
-git-merge                               mainporcelain common
+git-merge                               mainporcelain                c=
ommon-history
 git-merge-base                          plumbinginterrogators
 git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
@@ -79,7 +89,7 @@ git-mergetool                           ancillarymani=
pulators
 git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
-git-mv                                  mainporcelain common
+git-mv                                  mainporcelain
 git-name-rev                            plumbinginterrogators
 git-notes                               mainporcelain
 git-p4                                  foreignscminterface
@@ -90,11 +100,11 @@ git-parse-remote                        synchelper=
s
 git-patch-id                            purehelpers
 git-prune                               ancillarymanipulators
 git-prune-packed                        plumbingmanipulators
-git-pull                                mainporcelain common
-git-push                                mainporcelain common
+git-pull                                mainporcelain                c=
ommon-remote
+git-push                                mainporcelain                c=
ommon-remote
 git-quiltimport                         foreignscminterface
 git-read-tree                           plumbingmanipulators
-git-rebase                              mainporcelain common
+git-rebase                              mainporcelain
 git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators
 git-relink                              ancillarymanipulators
@@ -103,28 +113,28 @@ git-repack                              ancillary=
manipulators
 git-replace                             ancillarymanipulators
 git-request-pull                        foreignscminterface
 git-rerere                              ancillaryinterrogators
-git-reset                               mainporcelain common
+git-reset                               mainporcelain                c=
ommon-worktree
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
-git-rm                                  mainporcelain common
+git-rm                                  mainporcelain
 git-send-email                          foreignscminterface
 git-send-pack                           synchingrepositories
 git-shell                               synchelpers
 git-shortlog                            mainporcelain
-git-show                                mainporcelain common
+git-show                                mainporcelain
 git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-i18n                             purehelpers
 git-sh-setup                            purehelpers
 git-stash                               mainporcelain
-git-status                              mainporcelain common
+git-status                              mainporcelain                c=
ommon-info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
 git-svn                                 foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
-git-tag                                 mainporcelain common
+git-tag                                 mainporcelain
 git-unpack-file                         plumbinginterrogators
 git-unpack-objects                      plumbingmanipulators
 git-update-index                        plumbingmanipulators
@@ -138,4 +148,4 @@ git-verify-pack                         plumbingint=
errogators
 git-verify-tag                          ancillaryinterrogators
 gitweb                                  ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators
-git-write-tree                          plumbingmanipulators
+git-write-tree                          plumbingmanipulators
\ No newline at end of file
--=20
2.4.0
