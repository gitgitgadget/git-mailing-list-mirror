From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] Fix stg breakage with nweer gits
Date: Sat, 12 Apr 2008 17:47:15 +0200
Message-ID: <20080412154427.19690.71877.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 17:48:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkhxY-0008Qk-Vq
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 17:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbYDLPrY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2008 11:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754771AbYDLPrY
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 11:47:24 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1468 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564AbYDLPrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 11:47:23 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jkhwh-0004CO-00; Sat, 12 Apr 2008 16:47:15 +0100
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79368>

The new-infrastructure commands stopped working with newer gits, due
to git merge-recursive starting to heed GIT_WORK_TREE. Patch 1/2 fixes
this issue; patch 2/2 is some debugging stuff I built while tracking
down the bug.

Erik, this fixes your bug.

---

Karl Hasselstr=C3=B6m (2):
      Log environment and cwd as well as the actual command
      Don't both change directory and set GIT_WORK_TREE


 stgit/lib/git.py |   14 +++++++++-----
 stgit/run.py     |    6 ++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
