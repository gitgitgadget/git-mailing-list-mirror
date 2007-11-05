From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/5] Start the refactoring
Date: Mon, 05 Nov 2007 04:14:28 +0100
Message-ID: <20071105030847.6108.44653.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 04:14:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IosQM-0002ez-Bn
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 04:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451AbXKEDOf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 22:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487AbXKEDOe
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 22:14:34 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2127 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbXKEDOe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 22:14:34 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IosQ0-0003Fl-00; Mon, 05 Nov 2007 03:14:28 +0000
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63472>

This series introduces parts of the proposed new infrastructure, and
uses it to implement "stg clean" and the new "stg coalesce".

There are undoubtedly more bugs to be found, but I'm pushing it to

  git://repo.or.cz/stgit/kha.git experimental

to make it easy for people to try it out. It does pass the test suite
after all.

---

Karl Hasselstr=C3=B6m (5):
      Add "stg coalesce"
      Let "stg clean" use the new infrastructure
      Simple test for "stg clean"
      Write metadata files used by the old infrastructure
      New StGit core infrastructure: repository operations


 stgit/commands/clean.py    |   68 ++++++------
 stgit/commands/coalesce.py |   87 ++++++++++++++++
 stgit/commands/common.py   |   10 ++
 stgit/lib/__init__.py      |   18 +++
 stgit/lib/git.py           |  245 ++++++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py         |  156 ++++++++++++++++++++++++++++
 stgit/lib/transaction.py   |   79 ++++++++++++++
 stgit/main.py              |    2=20
 stgit/utils.py             |   24 ++++
 t/t2500-clean.sh           |   27 +++++
 t/t2600-coalesce.sh        |   31 ++++++
 11 files changed, 713 insertions(+), 34 deletions(-)
 create mode 100644 stgit/commands/coalesce.py
 create mode 100644 stgit/lib/__init__.py
 create mode 100644 stgit/lib/git.py
 create mode 100644 stgit/lib/stack.py
 create mode 100644 stgit/lib/transaction.py
 create mode 100755 t/t2500-clean.sh
 create mode 100755 t/t2600-coalesce.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
