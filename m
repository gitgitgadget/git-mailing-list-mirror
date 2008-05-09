From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] stg undo
Date: Fri, 09 May 2008 02:44:18 +0200
Message-ID: <20080509003824.20312.17819.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 02:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuGk2-0003IH-8O
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 02:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbYEIAob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2008 20:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbYEIAob
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 20:44:31 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1851 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbYEIAoa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 20:44:30 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JuGik-0004Zb-00; Fri, 09 May 2008 01:44:22 +0100
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81580>

Here's a fully general undo command for StGit. It uses the same
machinery as the "stg reset" I posted previously, but is more
convenient to use when all you want to do is undo the last operation.

The next step would be to remove all traces of "push --undo" et al.,
but I'll save that for another day.

=46or trying this out, pull from

  git://repo.or.cz/stgit/kha.git experimental

since a few of the patches below these two have been updated as well.
(For example, the log branch in <branchname>.stgit^ is now much more
human-readable.)

---

Karl Hasselstr=C3=B6m (2):
      New command: stg undo
      Move stack reset function to a shared location


 stgit/commands/reset.py  |   70 ++++---------------------------------
 stgit/commands/undo.py   |   49 ++++++++++++++++++++++++++
 stgit/lib/log.py         |   76 ++++++++++++++++++++++++++++++++++++++=
+++
 stgit/lib/transaction.py |    1 +
 stgit/main.py            |    2 +
 t/t3102-undo.sh          |   86 ++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t3103-undo-hard.sh     |   56 ++++++++++++++++++++++++++++++
 7 files changed, 277 insertions(+), 63 deletions(-)
 create mode 100644 stgit/commands/undo.py
 create mode 100755 t/t3102-undo.sh
 create mode 100755 t/t3103-undo-hard.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
