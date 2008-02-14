From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] Patch stack logging
Date: Thu, 14 Feb 2008 02:25:08 +0100
Message-ID: <20080214012119.22365.54526.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 02:26:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPSrP-00037V-2d
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 02:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757117AbYBNBZY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 20:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756939AbYBNBZY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 20:25:24 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4684 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230AbYBNBZX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 20:25:23 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JPSqg-0003Wb-00; Thu, 14 Feb 2008 01:25:14 +0000
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73835>

So here's what I have this far. It writes a log that's close to the
format I want, but doesn't do anything with it yet.

It's not in kha/experimental yet; it seems to work OK, but it leaves a
log behind that'll have to be cleaned up manually when the format
changes, which it will.

---

Karl Hasselstr=C3=B6m (2):
      Write to a stack log when stack is modified
      Library functions for tree and blob manipulation


 stgit/commands/branch.py   |   18 ++++--
 stgit/commands/clone.py    |    3 +
 stgit/commands/float.py    |    3 +
 stgit/commands/fold.py     |    3 +
 stgit/commands/imprt.py    |    3 +
 stgit/commands/init.py     |    3 +
 stgit/commands/pick.py     |    3 +
 stgit/commands/pop.py      |    3 +
 stgit/commands/pull.py     |    3 +
 stgit/commands/push.py     |    6 +-
 stgit/commands/rebase.py   |    4 +
 stgit/commands/refresh.py  |    4 +
 stgit/commands/rename.py   |    3 +
 stgit/commands/resolved.py |    4 +
 stgit/commands/sink.py     |    3 +
 stgit/commands/sync.py     |    5 +-
 stgit/lib/git.py           |  139 ++++++++++++++++++++++++++++++++++++=
+-------
 stgit/lib/log.py           |   60 +++++++++++++++++++
 stgit/lib/transaction.py   |    3 +
 19 files changed, 229 insertions(+), 44 deletions(-)
 create mode 100644 stgit/lib/log.py

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
