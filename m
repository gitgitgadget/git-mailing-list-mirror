From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] Test improvements
Date: Tue, 08 Jul 2008 06:03:04 +0200
Message-ID: <20080708035750.23134.75833.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG4R1-00030a-Ur
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbYGHEDN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 00:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbYGHEDM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:03:12 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4295 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbYGHEDM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:03:12 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KG4Px-0000Xm-00; Tue, 08 Jul 2008 05:03:05 +0100
User-Agent: StGIT/0.14.3.185.gb9e85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87697>

=46irst, a change across all the tests to make sure that stg always
exits with the correct exit code even when it's not zero. This lets us
detect the difference between a controlled failure and a crash.

Second, a rather comprehensive test fir "stg edit" -- we didn't test
it at all. Which can be seen in the number of failures in this test.

They are available in kha/safe. The patches in kha/experimental have
been rebased on top of these, resulting in a number of new test
failures that I've had to fix.

---

Karl Hasselstr=C3=B6m (2):
      Test for "stg edit"
      Test for specific exit code


 t/README                    |    6 +
 t/t0001-subdir-branches.sh  |   12 +--
 t/t0002-status.sh           |    2=20
 t/t1000-branch-create.sh    |    8 +-
 t/t1001-branch-rename.sh    |    2=20
 t/t1002-branch-clone.sh     |    2=20
 t/t1200-push-modified.sh    |    2=20
 t/t1202-push-undo.sh        |    4 -
 t/t1203-push-conflict.sh    |    4 -
 t/t1205-push-subdir.sh      |    4 -
 t/t1301-repair.sh           |    2=20
 t/t1302-repair-interop.sh   |    4 -
 t/t1400-patch-history.sh    |    2=20
 t/t1501-sink.sh             |    2=20
 t/t1600-delete-one.sh       |    4 -
 t/t1601-delete-many.sh      |    2=20
 t/t2000-sync.sh             |    4 -
 t/t2101-pull-policy-pull.sh |    2=20
 t/t2200-rebase.sh           |    2=20
 t/t2500-clean.sh            |    2=20
 t/t2900-rename.sh           |    8 +-
 t/t3000-dirty-merge.sh      |    2=20
 t/t3300-edit.sh             |  205 +++++++++++++++++++++++++++++++++++=
++++++++
 t/t4000-upgrade.sh          |    2=20
 t/test-lib.sh               |   24 +++++
 25 files changed, 271 insertions(+), 42 deletions(-)
 create mode 100755 t/t3300-edit.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
