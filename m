From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 00/25] contrib: cleanup
Date: Thu,  8 May 2014 19:58:11 -0500
Message-ID: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:09:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZJe-0007bs-1X
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbaEIBJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:09:28 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:47643 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbaEIBJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:09:26 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so3125143yha.38
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=VmJYbp5LpthDHERuT34kdU7qVzvmcDi2g1MOBIoEr+o=;
        b=lHF1ap9XkKsxM/kBnUpvw2sHCBd8/mVp2OgdiuVJr8XxLKXI9PS+dovaEZsFokU0YR
         SZKXEWZuyRn+i5TH5AyCWVY5p6O5fiHTa5TjuTY6Bj1nX4RZECcrVvgbXr9qAfBTYq4C
         UBHJUzQ+cKz3NC5LNEVYiYxmboN3mRm7gcqryj2e/TBTU87gyQuxcCfcW2GSzgmFQgxt
         +3iK856DJfr9p4yPAlPZlIczXi/QqWpyYWENAOwsblFw3ZBBcStkF2t1tBdbyLk5kqHb
         XsYqf72KY1n49CZowSJ4ZM/7lMv56zyF1x7XCrdZiXMDmYKnTbYHHWrXBo0iLYa6PM/1
         x9cg==
X-Received: by 10.236.108.176 with SMTP id q36mr10513231yhg.18.1399597765844;
        Thu, 08 May 2014 18:09:25 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r23sm3906703yhb.46.2014.05.08.18.09.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:09:24 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248469>

Let us be honest, the vast majority of tools in 'contrib/' have no chance of
ever graduating, so let's remove them.

The vast majority of tools don't have documentation or tests, and aren't even
maintained.

A few, like 'remote-helpers', won't graduate even if they are perfect. These
tools apparently should live out-of-tree.

After the cleanup, the only tools that remain are 'completion',
'credential' and 'subtree', which might eventually graduate.


Felipe Contreras (25):
  Remove remote-helpers
  contrib: remove 'hg-to-git'
  contrib: remove 'stats'
  contrib: remove 'buildsystems'
  contrib: remove 'convert-objects'
  contrib: remove 'diffall'
  contrib: remove 'git-jump'
  contrib: remove 'git-shell-commands'
  contrib: remove 'gitview'
  contrib: reomve 'thunderbird-patch-inline'
  contrib: remove 'workdir'
  contrib: remove 'vim'
  contrib: remove 'svn-fe'
  contrib: remove 'rerere-train'
  contrib: remove 'remotes2config'
  contrib: remove 'persistent-https'
  contrib: remove 'git-resurrect'
  contrib: remove 'emacs'
  contrib: remove 'diff-highlight'
  contrib: remove 'contacts'
  contrib: remove 'examples'
  contrib: remove 'fast-import'
  contrib: remove 'hooks/multimail'
  contrib: remove 'hooks'
  contrib: remove 'mw-to-git'

 contrib/buildsystems/Generators.pm                 |   42 -
 contrib/buildsystems/Generators/QMake.pm           |  189 --
 contrib/buildsystems/Generators/Vcproj.pm          |  626 -----
 contrib/buildsystems/engine.pl                     |  359 ---
 contrib/buildsystems/generate                      |   29 -
 contrib/buildsystems/parse.pl                      |  228 --
 contrib/contacts/git-contacts                      |  203 --
 contrib/contacts/git-contacts.txt                  |   94 -
 contrib/convert-objects/convert-objects.c          |  329 ---
 contrib/convert-objects/git-convert-objects.txt    |   29 -
 contrib/diff-highlight/README                      |  152 --
 contrib/diff-highlight/diff-highlight              |  173 --
 contrib/diffall/README                             |   31 -
 contrib/diffall/git-diffall                        |  257 --
 contrib/emacs/.gitignore                           |    1 -
 contrib/emacs/Makefile                             |   21 -
 contrib/emacs/README                               |   39 -
 contrib/emacs/git-blame.el                         |  484 ----
 contrib/emacs/git.el                               | 1705 -------------
 contrib/examples/README                            |    3 -
 contrib/examples/builtin-fetch--tool.c             |  575 -----
 contrib/examples/git-checkout.sh                   |  302 ---
 contrib/examples/git-clean.sh                      |  118 -
 contrib/examples/git-clone.sh                      |  525 ----
 contrib/examples/git-commit.sh                     |  639 -----
 contrib/examples/git-fetch.sh                      |  379 ---
 contrib/examples/git-gc.sh                         |   37 -
 contrib/examples/git-log.sh                        |   15 -
 contrib/examples/git-ls-remote.sh                  |  142 --
 contrib/examples/git-merge-ours.sh                 |   14 -
 contrib/examples/git-merge.sh                      |  620 -----
 contrib/examples/git-notes.sh                      |  121 -
 contrib/examples/git-remote.perl                   |  474 ----
 contrib/examples/git-repack.sh                     |  194 --
 contrib/examples/git-rerere.perl                   |  284 ---
 contrib/examples/git-reset.sh                      |  106 -
 contrib/examples/git-resolve.sh                    |  112 -
 contrib/examples/git-revert.sh                     |  207 --
 contrib/examples/git-svnimport.perl                |  976 --------
 contrib/examples/git-svnimport.txt                 |  179 --
 contrib/examples/git-tag.sh                        |  205 --
 contrib/examples/git-verify-tag.sh                 |   45 -
 contrib/examples/git-whatchanged.sh                |   28 -
 contrib/fast-import/git-import.perl                |   64 -
 contrib/fast-import/git-import.sh                  |   38 -
 contrib/fast-import/git-p4.README                  |   12 -
 contrib/fast-import/import-directories.perl        |  417 ----
 contrib/fast-import/import-tars.perl               |  189 --
 contrib/fast-import/import-zips.py                 |   78 -
 contrib/git-jump/README                            |   92 -
 contrib/git-jump/git-jump                          |   69 -
 contrib/git-resurrect.sh                           |  182 --
 contrib/git-shell-commands/README                  |   18 -
 contrib/git-shell-commands/help                    |   18 -
 contrib/git-shell-commands/list                    |   10 -
 contrib/gitview/gitview                            | 1305 ----------
 contrib/gitview/gitview.txt                        |   57 -
 contrib/hg-to-git/hg-to-git.py                     |  255 --
 contrib/hg-to-git/hg-to-git.txt                    |   21 -
 contrib/hooks/multimail/CHANGES                    |   33 -
 contrib/hooks/multimail/README                     |  500 ----
 contrib/hooks/multimail/README.Git                 |   15 -
 .../README.migrate-from-post-receive-email         |  145 --
 contrib/hooks/multimail/git_multimail.py           | 2539 --------------------
 contrib/hooks/multimail/migrate-mailhook-config    |  269 ---
 contrib/hooks/multimail/post-receive               |   90 -
 contrib/hooks/post-receive-email                   |  759 ------
 contrib/hooks/pre-auto-gc-battery                  |   42 -
 contrib/hooks/setgitperms.perl                     |  214 --
 contrib/hooks/update-paranoid                      |  421 ----
 contrib/mw-to-git/.gitignore                       |    2 -
 contrib/mw-to-git/.perlcriticrc                    |   28 -
 contrib/mw-to-git/Git/Mediawiki.pm                 |  100 -
 contrib/mw-to-git/Makefile                         |   57 -
 contrib/mw-to-git/bin-wrapper/git                  |   14 -
 contrib/mw-to-git/git-mw.perl                      |  368 ---
 contrib/mw-to-git/git-remote-mediawiki.perl        | 1338 -----------
 contrib/mw-to-git/git-remote-mediawiki.txt         |    7 -
 contrib/mw-to-git/t/.gitignore                     |    4 -
 contrib/mw-to-git/t/Makefile                       |   31 -
 contrib/mw-to-git/t/README                         |  124 -
 contrib/mw-to-git/t/install-wiki.sh                |   55 -
 contrib/mw-to-git/t/install-wiki/.gitignore        |    1 -
 contrib/mw-to-git/t/install-wiki/LocalSettings.php |  129 -
 contrib/mw-to-git/t/install-wiki/db_install.php    |  120 -
 contrib/mw-to-git/t/push-pull-tests.sh             |  144 --
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh       |  257 --
 contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh   |   24 -
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh        |  347 ---
 .../mw-to-git/t/t9363-mw-to-git-export-import.sh   |  217 --
 contrib/mw-to-git/t/t9364-pull-by-rev.sh           |   17 -
 contrib/mw-to-git/t/t9365-continuing-queries.sh    |   23 -
 contrib/mw-to-git/t/test-gitmw-lib.sh              |  432 ----
 contrib/mw-to-git/t/test-gitmw.pl                  |  225 --
 contrib/mw-to-git/t/test.config                    |   37 -
 contrib/persistent-https/LICENSE                   |  202 --
 contrib/persistent-https/Makefile                  |   38 -
 contrib/persistent-https/README                    |   62 -
 contrib/persistent-https/client.go                 |  189 --
 contrib/persistent-https/main.go                   |   82 -
 contrib/persistent-https/proxy.go                  |  190 --
 contrib/persistent-https/socket.go                 |   97 -
 contrib/remotes2config.sh                          |   33 -
 contrib/rerere-train.sh                            |   52 -
 contrib/stats/git-common-hash                      |   26 -
 contrib/stats/mailmap.pl                           |   70 -
 contrib/stats/packinfo.pl                          |  212 --
 contrib/svn-fe/.gitignore                          |    4 -
 contrib/svn-fe/Makefile                            |   63 -
 contrib/svn-fe/svn-fe.c                            |   18 -
 contrib/svn-fe/svn-fe.txt                          |   71 -
 contrib/svn-fe/svnrdump_sim.py                     |   57 -
 contrib/thunderbird-patch-inline/README            |   20 -
 contrib/thunderbird-patch-inline/appp.sh           |   55 -
 contrib/vim/README                                 |   22 -
 contrib/workdir/git-new-workdir                    |   82 -
 git-remote-bzr.py                                  |  983 --------
 git-remote-hg.py                                   | 1258 ----------
 t/t5810-remote-hg.sh                               |  847 -------
 t/t5811-remote-hg-bidi.sh                          |  242 --
 t/t5812-remote-hg-hg-git.sh                        |  541 -----
 t/t5820-remote-bzr.sh                              |  437 ----
 122 files changed, 29197 deletions(-)
 delete mode 100644 contrib/buildsystems/Generators.pm
 delete mode 100644 contrib/buildsystems/Generators/QMake.pm
 delete mode 100644 contrib/buildsystems/Generators/Vcproj.pm
 delete mode 100755 contrib/buildsystems/engine.pl
 delete mode 100755 contrib/buildsystems/generate
 delete mode 100755 contrib/buildsystems/parse.pl
 delete mode 100755 contrib/contacts/git-contacts
 delete mode 100644 contrib/contacts/git-contacts.txt
 delete mode 100644 contrib/convert-objects/convert-objects.c
 delete mode 100644 contrib/convert-objects/git-convert-objects.txt
 delete mode 100644 contrib/diff-highlight/README
 delete mode 100755 contrib/diff-highlight/diff-highlight
 delete mode 100644 contrib/diffall/README
 delete mode 100755 contrib/diffall/git-diffall
 delete mode 100644 contrib/emacs/.gitignore
 delete mode 100644 contrib/emacs/Makefile
 delete mode 100644 contrib/emacs/README
 delete mode 100644 contrib/emacs/git-blame.el
 delete mode 100644 contrib/emacs/git.el
 delete mode 100644 contrib/examples/README
 delete mode 100644 contrib/examples/builtin-fetch--tool.c
 delete mode 100755 contrib/examples/git-checkout.sh
 delete mode 100755 contrib/examples/git-clean.sh
 delete mode 100755 contrib/examples/git-clone.sh
 delete mode 100755 contrib/examples/git-commit.sh
 delete mode 100755 contrib/examples/git-fetch.sh
 delete mode 100755 contrib/examples/git-gc.sh
 delete mode 100755 contrib/examples/git-log.sh
 delete mode 100755 contrib/examples/git-ls-remote.sh
 delete mode 100755 contrib/examples/git-merge-ours.sh
 delete mode 100755 contrib/examples/git-merge.sh
 delete mode 100755 contrib/examples/git-notes.sh
 delete mode 100755 contrib/examples/git-remote.perl
 delete mode 100755 contrib/examples/git-repack.sh
 delete mode 100755 contrib/examples/git-rerere.perl
 delete mode 100755 contrib/examples/git-reset.sh
 delete mode 100755 contrib/examples/git-resolve.sh
 delete mode 100755 contrib/examples/git-revert.sh
 delete mode 100755 contrib/examples/git-svnimport.perl
 delete mode 100644 contrib/examples/git-svnimport.txt
 delete mode 100755 contrib/examples/git-tag.sh
 delete mode 100755 contrib/examples/git-verify-tag.sh
 delete mode 100755 contrib/examples/git-whatchanged.sh
 delete mode 100755 contrib/fast-import/git-import.perl
 delete mode 100755 contrib/fast-import/git-import.sh
 delete mode 100644 contrib/fast-import/git-p4.README
 delete mode 100755 contrib/fast-import/import-directories.perl
 delete mode 100755 contrib/fast-import/import-tars.perl
 delete mode 100755 contrib/fast-import/import-zips.py
 delete mode 100644 contrib/git-jump/README
 delete mode 100755 contrib/git-jump/git-jump
 delete mode 100755 contrib/git-resurrect.sh
 delete mode 100644 contrib/git-shell-commands/README
 delete mode 100755 contrib/git-shell-commands/help
 delete mode 100755 contrib/git-shell-commands/list
 delete mode 100755 contrib/gitview/gitview
 delete mode 100644 contrib/gitview/gitview.txt
 delete mode 100755 contrib/hg-to-git/hg-to-git.py
 delete mode 100644 contrib/hg-to-git/hg-to-git.txt
 delete mode 100644 contrib/hooks/multimail/CHANGES
 delete mode 100644 contrib/hooks/multimail/README
 delete mode 100644 contrib/hooks/multimail/README.Git
 delete mode 100644 contrib/hooks/multimail/README.migrate-from-post-receive-email
 delete mode 100755 contrib/hooks/multimail/git_multimail.py
 delete mode 100755 contrib/hooks/multimail/migrate-mailhook-config
 delete mode 100755 contrib/hooks/multimail/post-receive
 delete mode 100755 contrib/hooks/post-receive-email
 delete mode 100755 contrib/hooks/pre-auto-gc-battery
 delete mode 100755 contrib/hooks/setgitperms.perl
 delete mode 100755 contrib/hooks/update-paranoid
 delete mode 100644 contrib/mw-to-git/.gitignore
 delete mode 100644 contrib/mw-to-git/.perlcriticrc
 delete mode 100644 contrib/mw-to-git/Git/Mediawiki.pm
 delete mode 100644 contrib/mw-to-git/Makefile
 delete mode 100755 contrib/mw-to-git/bin-wrapper/git
 delete mode 100755 contrib/mw-to-git/git-mw.perl
 delete mode 100755 contrib/mw-to-git/git-remote-mediawiki.perl
 delete mode 100644 contrib/mw-to-git/git-remote-mediawiki.txt
 delete mode 100644 contrib/mw-to-git/t/.gitignore
 delete mode 100644 contrib/mw-to-git/t/Makefile
 delete mode 100644 contrib/mw-to-git/t/README
 delete mode 100755 contrib/mw-to-git/t/install-wiki.sh
 delete mode 100644 contrib/mw-to-git/t/install-wiki/.gitignore
 delete mode 100644 contrib/mw-to-git/t/install-wiki/LocalSettings.php
 delete mode 100644 contrib/mw-to-git/t/install-wiki/db_install.php
 delete mode 100644 contrib/mw-to-git/t/push-pull-tests.sh
 delete mode 100755 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
 delete mode 100755 contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh
 delete mode 100755 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
 delete mode 100755 contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
 delete mode 100755 contrib/mw-to-git/t/t9364-pull-by-rev.sh
 delete mode 100755 contrib/mw-to-git/t/t9365-continuing-queries.sh
 delete mode 100755 contrib/mw-to-git/t/test-gitmw-lib.sh
 delete mode 100755 contrib/mw-to-git/t/test-gitmw.pl
 delete mode 100644 contrib/mw-to-git/t/test.config
 delete mode 100644 contrib/persistent-https/LICENSE
 delete mode 100644 contrib/persistent-https/Makefile
 delete mode 100644 contrib/persistent-https/README
 delete mode 100644 contrib/persistent-https/client.go
 delete mode 100644 contrib/persistent-https/main.go
 delete mode 100644 contrib/persistent-https/proxy.go
 delete mode 100644 contrib/persistent-https/socket.go
 delete mode 100755 contrib/remotes2config.sh
 delete mode 100755 contrib/rerere-train.sh
 delete mode 100755 contrib/stats/git-common-hash
 delete mode 100755 contrib/stats/mailmap.pl
 delete mode 100755 contrib/stats/packinfo.pl
 delete mode 100644 contrib/svn-fe/.gitignore
 delete mode 100644 contrib/svn-fe/Makefile
 delete mode 100644 contrib/svn-fe/svn-fe.c
 delete mode 100644 contrib/svn-fe/svn-fe.txt
 delete mode 100755 contrib/svn-fe/svnrdump_sim.py
 delete mode 100644 contrib/thunderbird-patch-inline/README
 delete mode 100755 contrib/thunderbird-patch-inline/appp.sh
 delete mode 100644 contrib/vim/README
 delete mode 100755 contrib/workdir/git-new-workdir
 delete mode 100755 git-remote-bzr.py
 delete mode 100755 git-remote-hg.py
 delete mode 100755 t/t5810-remote-hg.sh
 delete mode 100755 t/t5811-remote-hg-bidi.sh
 delete mode 100755 t/t5812-remote-hg-hg-git.sh
 delete mode 100755 t/t5820-remote-bzr.sh

-- 
1.9.2+fc1.27.gbce2056
