From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v9 2/5] command-list.txt: add the common groups block
Date: Wed, 20 May 2015 21:22:58 +0200
Message-ID: <1432149781-24596-3-git-send-email-sebastien.guimmara@gmail.com>
References: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	=?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 21:23:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9aU-0002WQ-08
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbbETTXZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 15:23:25 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:34516 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbbETTXY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:23:24 -0400
Received: by wghq2 with SMTP id q2so63269874wgh.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/5rKFedOmAKnibiyVDGx0YwCTrHiwp8fWu17w08CULg=;
        b=TtaElXtAFEagzlqwgAv/0zfVgFb4HQW0O05gq8mRlIgCP6MvzgY44iXOe3MQmj4Fos
         WOD7WBarBi17HjfiL0kfdCDx+r1nLJXaQKTipmu0DxX4UaxqApllg8F/JEQnXz0wuBje
         9Yl+7umvlZUJd8wLPGy0/J7n+oH6KI704Vvy06MTMjwgmrORn1fGShDWvNnOjnANOgwJ
         J3yurNFx+pp75DRw0JIqFq+NbbGHUtN3mYL7SdtRqv8L0FO1njyVbZfq7toXIDXB4u0a
         1VkO4WiVDeAmWCgWA3NtLflHeCTqmj6RCP4qVGmb2P4kjmxZM+mFa18oWrOZ5jfYbhrU
         1Wdw==
X-Received: by 10.180.87.105 with SMTP id w9mr44447337wiz.32.1432149802527;
        Wed, 20 May 2015 12:23:22 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id bm9sm28320276wjc.21.2015.05.20.12.23.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 May 2015 12:23:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269498>

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
 command-list.txt | 50 ++++++++++++++++++++++++++++++------------------=
--
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index 609b344..c2bbdc1 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,3 +1,13 @@
+# common commands are grouped by themes output by 'git help'
+# map each common command in the command list to one of these groups.
+### common groups
+init         start a working area (see also: git help tutorial)
+worktree     work on the current change (see also: git help everyday)
+info         examine the history and state (see also: git help revisio=
ns)
+history      grow, mark and tweak your common history
+remote       collaborate (see also: git help workflows)
+
+# List of known git commands.
 # do not molest the next line
 ### command list
 # command name                          category [deprecated] [common]
@@ -7,24 +17,24 @@ git-annotate                            ancillaryint=
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
@@ -36,14 +46,14 @@ git-cvsimport                           foreignscmi=
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
@@ -52,7 +62,7 @@ git-format-patch                        mainporcelain
 git-fsck                                ancillaryinterrogators
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
-git-grep                                mainporcelain common
+git-grep                                mainporcelain           common=
 info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators
@@ -61,17 +71,17 @@ git-http-fetch                          synchelpers
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
@@ -80,7 +90,7 @@ git-mergetool                           ancillarymani=
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
@@ -91,11 +101,11 @@ git-parse-remote                        synchelper=
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
@@ -104,28 +114,28 @@ git-repack                              ancillary=
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
