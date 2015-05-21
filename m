From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v10 2/5] command-list.txt: add the common groups block
Date: Thu, 21 May 2015 15:13:06 +0200
Message-ID: <1432213989-3932-3-git-send-email-sebastien.guimmara@gmail.com>
References: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>, gitster@pobox.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 15:13:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvQHz-0001fi-O6
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 15:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbbEUNNY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 09:13:24 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:32810 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbbEUNNU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 09:13:20 -0400
Received: by wicmx19 with SMTP id mx19so12577868wic.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=agVXSX9brECKEJtjaUj6Pi5GA0Wk5H8ZlgVnolwDFOA=;
        b=k0d1G85hoB6xFcn+7dJhgms0CTFhL4gvhCORIpVX81AjUZjW9weFKXgHt8ReNl1KIz
         zypbRjnDRb73rs80Z5Wc8H8cJgxVOoDPNVq+fO0FbMM0pheJRS9lXVZcfM6TsHwScIDl
         lXbGSGB9HoOfp0zJTSOE4vSe2hqDbmRszpQcZ2/snktZHxtLiBAiFO068lmxfnVCo6Vy
         OwxbMsFXRQM/Hs/ZFDpCwL/Fv+ZbRF5uqf2XMEgHcAoVw9RV4l+0a1iJCjkjDb7FTosS
         0tahcDsHKtNppBZ2EPhx8ZTIe6SMQzb3HzUZQiP39N8A8rWV0B6gLyf9QQbhSNIAEYc2
         MeQA==
X-Received: by 10.180.24.65 with SMTP id s1mr6144918wif.66.1432213999332;
        Thu, 21 May 2015 06:13:19 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id fb3sm2816361wib.21.2015.05.21.06.13.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 May 2015 06:13:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269586>

The ultimate goal is for "git help" to display common commands in
groups rather than alphabetically. As a first step, define the
groups in a new block, and then assign a group to each
common command.

Add a block at the beginning of command-list.txt:

    init         start a working area (see also: git help tutorial)
    worktree     work on the current change (see also:[...]
    info         examine the history and state (see also: git [...]
    history      grow, mark and tweak your history
    remote       collaborate (see also: git help workflows)

storing information about common commands group, then map each common
command to a group:

    git-add          mainporcelain        common worktree

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by:  Emma Jane Hogbin Westby <emma.westby@gmail.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 command-list.txt | 51 +++++++++++++++++++++++++++++++-----------------=
---
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index 181a9c2..32ddab3 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,3 +1,14 @@
+# common commands are grouped by themes
+# these groups are output by 'git help' in the order declared here.
+# map each common command in the command list to one of these groups.
+### common groups (do not change this line)
+init         start a working area (see also: git help tutorial)
+worktree     work on the current change (see also: git help everyday)
+info         examine the history and state (see also: git help revisio=
ns)
+history      grow, mark and tweak your common history
+remote       collaborate (see also: git help workflows)
+
+# List of known git commands.
 ### command list (do not change this line)
 # command name                          category [deprecated] [common]
 git-add                                 mainporcelain common
@@ -6,24 +17,24 @@ git-annotate                            ancillaryint=
errogators
 git-apply                               plumbingmanipulators
 git-archimport                          foreignscminterface
 git-archive                             mainporcelain
-git-bisect                              mainporcelain common
+git-bisect                              mainporcelain           common=
 info
 git-blame                               ancillaryinterrogators
-git-branch                              mainporcelain common
+git-branch                              mainporcelain           common=
 history
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
 git-check-ignore                        purehelpers
 git-check-mailmap                       purehelpers
-git-checkout                            mainporcelain common
+git-checkout                            mainporcelain           common=
 history
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
 git-cherry                              ancillaryinterrogators
 git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
-git-clone                               mainporcelain common
+git-clone                               mainporcelain           common=
 init
 git-column                              purehelpers
-git-commit                              mainporcelain common
+git-commit                              mainporcelain           common=
 history
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
@@ -35,14 +46,14 @@ git-cvsimport                           foreignscmi=
nterface
 git-cvsserver                           foreignscminterface
 git-daemon                              synchingrepositories
 git-describe                            mainporcelain
-git-diff                                mainporcelain common
+git-diff                                mainporcelain           common=
 history
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
 git-difftool                            ancillaryinterrogators
 git-fast-export                         ancillarymanipulators
 git-fast-import                         ancillarymanipulators
-git-fetch                               mainporcelain common
+git-fetch                               mainporcelain           common=
 remote
 git-fetch-pack                          synchingrepositories
 git-filter-branch                       ancillarymanipulators
 git-fmt-merge-msg                       purehelpers
@@ -51,7 +62,7 @@ git-format-patch                        mainporcelain
 git-fsck                                ancillaryinterrogators
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
-git-grep                                mainporcelain common
+git-grep                                mainporcelain           common=
 info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators
@@ -60,17 +71,17 @@ git-http-fetch                          synchelpers
 git-http-push                           synchelpers
 git-imap-send                           foreignscminterface
 git-index-pack                          plumbingmanipulators
-git-init                                mainporcelain common
+git-init                                mainporcelain           common=
 init
 git-instaweb                            ancillaryinterrogators
 git-interpret-trailers                  purehelpers
 gitk                                    mainporcelain
-git-log                                 mainporcelain common
+git-log                                 mainporcelain           common=
 info
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
 git-mailinfo                            purehelpers
 git-mailsplit                           purehelpers
-git-merge                               mainporcelain common
+git-merge                               mainporcelain           common=
 history
 git-merge-base                          plumbinginterrogators
 git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
@@ -79,7 +90,7 @@ git-mergetool                           ancillarymani=
pulators
 git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
-git-mv                                  mainporcelain common
+git-mv                                  mainporcelain           common=
 worktree
 git-name-rev                            plumbinginterrogators
 git-notes                               mainporcelain
 git-p4                                  foreignscminterface
@@ -90,11 +101,11 @@ git-parse-remote                        synchelper=
s
 git-patch-id                            purehelpers
 git-prune                               ancillarymanipulators
 git-prune-packed                        plumbingmanipulators
-git-pull                                mainporcelain common
-git-push                                mainporcelain common
+git-pull                                mainporcelain           common=
 remote
+git-push                                mainporcelain           common=
 remote
 git-quiltimport                         foreignscminterface
 git-read-tree                           plumbingmanipulators
-git-rebase                              mainporcelain common
+git-rebase                              mainporcelain           common=
 history
 git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators
 git-relink                              ancillarymanipulators
@@ -103,28 +114,28 @@ git-repack                              ancillary=
manipulators
 git-replace                             ancillarymanipulators
 git-request-pull                        foreignscminterface
 git-rerere                              ancillaryinterrogators
-git-reset                               mainporcelain common
+git-reset                               mainporcelain           common=
 worktree
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
-git-rm                                  mainporcelain common
+git-rm                                  mainporcelain           common=
 worktree
 git-send-email                          foreignscminterface
 git-send-pack                           synchingrepositories
 git-shell                               synchelpers
 git-shortlog                            mainporcelain
-git-show                                mainporcelain common
+git-show                                mainporcelain           common=
 info
 git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-i18n                             purehelpers
 git-sh-setup                            purehelpers
 git-stash                               mainporcelain
-git-status                              mainporcelain common
+git-status                              mainporcelain           common=
 info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
 git-svn                                 foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
-git-tag                                 mainporcelain common
+git-tag                                 mainporcelain           common=
 history
 git-unpack-file                         plumbinginterrogators
 git-unpack-objects                      plumbingmanipulators
 git-update-index                        plumbingmanipulators
--=20
2.4.0.GIT
