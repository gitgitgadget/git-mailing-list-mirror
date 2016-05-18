From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 00/21] i18n and tests updates
Date: Wed, 18 May 2016 15:27:33 +0000
Message-ID: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 17:29:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b33PX-0000Yi-Ly
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 17:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbcERP3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 11:29:13 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:55108 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753427AbcERP3M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 11:29:12 -0400
Received: (qmail 7896 invoked from network); 18 May 2016 15:29:10 -0000
Received: (qmail 9856 invoked from network); 18 May 2016 15:29:10 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 18 May 2016 15:29:05 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294946>

Marks several messages for translation and updates tests to pass under
GETTEXT_POISON. Some tests were updated to fit previous i18n marks, others
were updated to fit marks made by these patches. Patches that only touch
test file refer to marks done in commits previous to these ones.

Vasco Almeida (21):
  i18n: builtin/remote.c: fix mark for translation
  i18n: advice: mark string about detached head for translation
  i18n: advice: internationalize message for conflicts
  i18n: transport: mark strings for translation
  i18n: sequencer: mark entire sentences for translation
  i18n: sequencer: mark string for translation
  i18n: merge-octopus: mark messages for translation
  merge-octupus: use die shell function from git-sh-setup.sh
  i18n: rebase: fix marked string to use eval_gettext variant
  i18n: rebase: mark placeholder for translation
  i18n: bisect: simplify error message for i18n
  t6030: update to use test_i18ncmp
  i18n: git-sh-setup.sh: mark strings for translation
  i18n: rebase-interactive: mark strings for translation
  i18n: rebase-interactive: mark here-doc strings for translation
  i18n: rebase-interactive: mark comments of squash for translation
  tests: use test_i18n* functions to suppress false positives
  tests: unpack-trees: update to use test_i18n* functions
  t9003: become resilient to GETTEXT_POISON
  t4153: fix negated test_i18ngrep call
  t5523: use test_i18ngrep for negation

 Makefile                             |   5 +-
 advice.c                             |  21 ++-
 builtin/pull.c                       |   2 +-
 builtin/remote.c                     |   6 +-
 git-bisect.sh                        |   5 +-
 git-merge-octopus.sh                 |  24 ++--
 git-rebase--interactive.sh           | 270 +++++++++++++++++++++--------------
 git-rebase.sh                        |   4 +-
 git-sh-i18n.sh                       |   4 +
 git-sh-setup.sh                      |  56 ++++++--
 sequencer.c                          |  13 +-
 t/lib-rebase.sh                      |   1 +
 t/t0008-ignores.sh                   |   4 +-
 t/t1011-read-tree-sparse-checkout.sh |   2 +-
 t/t1300-repo-config.sh               |   8 +-
 t/t1307-config-blob.sh               |   2 +-
 t/t1308-config-set.sh                |   4 +-
 t/t1400-update-ref.sh                |   2 +-
 t/t2010-checkout-ambiguous.sh        |   2 +-
 t/t2018-checkout-branch.sh           |   2 +-
 t/t3200-branch.sh                    |   6 +-
 t/t3201-branch-contains.sh           |   2 +-
 t/t3320-notes-merge-worktrees.sh     |   2 +-
 t/t3400-rebase.sh                    |   4 +-
 t/t3404-rebase-interactive.sh        |  18 +--
 t/t4153-am-resume-override-opts.sh   |   2 +-
 t/t5505-remote.sh                    |   2 +-
 t/t5510-fetch.sh                     |   2 +-
 t/t5520-pull.sh                      |   2 +-
 t/t5523-push-upstream.sh             |  12 +-
 t/t5536-fetch-conflicts.sh           |   4 +-
 t/t6030-bisect-porcelain.sh          |   4 +-
 t/t6301-for-each-ref-errors.sh       |  10 +-
 t/t7063-status-untracked-cache.sh    |   2 +-
 t/t7102-reset.sh                     |   4 +-
 t/t7400-submodule-basic.sh           |   2 +-
 t/t7403-submodule-sync.sh            |   4 +-
 t/t7406-submodule-update.sh          |  10 +-
 t/t7508-status.sh                    |   4 +-
 t/t7607-merge-overwrite.sh           |   2 +-
 t/t9003-help-autocorrect.sh          |   8 +-
 transport.c                          |  20 +--
 42 files changed, 337 insertions(+), 226 deletions(-)

-- 
2.7.3
