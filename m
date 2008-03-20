From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/6] Two bugfixes
Date: Thu, 20 Mar 2008 01:31:28 +0100
Message-ID: <20080320002604.13102.53757.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:32:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8iE-0006sd-Bh
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758448AbYCTAcN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 20:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935603AbYCTAcL
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:32:11 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2864 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781AbYCTAcG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:32:06 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jc8gq-0004rl-00; Thu, 20 Mar 2008 00:31:28 +0000
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77602>

This series fixes one rather benign bug (4/6) and one that caused
patches to become empty, which is rather worse (6/6). (The patch
contents could still be recovered via the patch log or reflog, but
it's still a major inconvenience.)

Both bugs were discovered by Erik Sandberg.

These patches are also available in the kha/safe branch.

---

Karl Hasselstr=C3=B6m (6):
      Handle failed pushes differently depending on cause
      New test: conflicting push in dirty worktree
      Make sure that we only uncommit commits with exactly one parent
      Try uncommitting a commit with not exactly one parent
      Make sure patches with no parents have an empty list of parents
      Use a special exit code for bugs


 stgit/commands/uncommit.py |   14 ++++++++++++--
 stgit/lib/git.py           |   23 +++++++++++++++--------
 stgit/lib/transaction.py   |    4 +++-
 stgit/main.py              |   11 +++++++----
 stgit/utils.py             |    1 +
 t/t1300-uncommit.sh        |    5 +++++
 t/t3000-dirty-merge.sh     |   35 +++++++++++++++++++++++++++++++++++
 7 files changed, 78 insertions(+), 15 deletions(-)
 create mode 100755 t/t3000-dirty-merge.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
