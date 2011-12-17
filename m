From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 00/11] git-p4: asciidoc documentation and fixes
Date: Sat, 17 Dec 2011 13:52:11 -0500
Message-ID: <1324147942-21558-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 19:54:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbzOT-0002e8-C9
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 19:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638Ab1LQSxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 13:53:43 -0500
Received: from honk.padd.com ([74.3.171.149]:48975 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782Ab1LQSxl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 13:53:41 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id B72F2339C;
	Sat, 17 Dec 2011 10:53:38 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0003C314A8; Sat, 17 Dec 2011 13:52:22 -0500 (EST)
X-Mailer: git-send-email 1.7.8.283.g3bcee.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187389>

This series starts with a revamp of the documentation for git-p4,
moving it into Documentation/ with the rest of the docs.  Changes
from v1 of this patch address:
    - review comments by Frans Klaver <fransklaver@gmail.com>
    - review comments by Luke Diamand <luke@diamand.org>
    - spellcheck

The other ten patches clarify the documentation, adding tests to
verify the current behavior of various git-p4 options.  Three of
these also modify git-p4 itself.

Patch 6 adds code to catch two conflicting options.

Patch 10 fixes an obvious bug where both an option and a
variable existed, but were honored inconsistently.

Patch 11 catches an invocation problem and exits early with
an error message instead of waiting for an exception later.

Suggestions on how to rearrange these patches would be
welcome.  I think the series is otherwise ready for testing
in next.

		-- Pete

Pete Wyckoff (11):
  git-p4: introduce asciidoc documentation
  git-p4: test debug macro
  git-p4: clone does not use --git-dir
  git-p4: test cloning with two dirs, clarify doc
  git-p4: document and test clone --branch
  git-p4: honor --changesfile option and test
  git-p4: document and test --import-local
  git-p4: test --max-changes
  git-p4: test --keep-path
  git-p4: test and document --use-client-spec
  git-p4: document and test submit options

 Documentation/git-p4.txt       |  480 ++++++++++++++++++++++++++++++++++++++++
 contrib/fast-import/git-p4     |   32 +++-
 contrib/fast-import/git-p4.txt |  302 -------------------------
 t/lib-git-p4.sh                |   27 +++
 t/t9800-git-p4.sh              |   60 +++++
 t/t9806-options.sh             |  170 ++++++++++++++
 t/t9807-submit.sh              |   54 +++++
 7 files changed, 820 insertions(+), 305 deletions(-)
 create mode 100644 Documentation/git-p4.txt
 delete mode 100644 contrib/fast-import/git-p4.txt
 create mode 100755 t/t9806-options.sh

-- 
1.7.8.258.g45cc3c
