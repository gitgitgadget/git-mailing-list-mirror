From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/4] Handle non-ASCII filenames
Date: Mon, 02 Jun 2008 23:46:10 +0200
Message-ID: <20080602214212.18768.63775.stgit@yoghurt>
References: <200806011046.51872.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 23:47:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HsA-0004o3-SD
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbYFBVq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 17:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbYFBVq3
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:46:29 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4632 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbYFBVq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:46:29 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K3Hr4-0001DE-00; Mon, 02 Jun 2008 22:46:14 +0100
In-Reply-To: <200806011046.51872.jnareb@gmail.com>
User-Agent: StGIT/0.14.2.156.gbabd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83578>

I fixed the first problem, and while doing so noticed that a nearby
block of code had exactly the same bug. So I fixed that as well.

Catalin, this should go on the stable branch, I believe. It probably
warrants a new release too, since anyone rebasing patches past the
point where the "M=C3=A4rchen" file was removed from git.git is going t=
o
hit the same bug Jakub did.

---

Karl Hasselstr=C3=B6m (4):
      Handle refresh of changed files with non-ASCII names
      Test for another filename quoting issue in tree_status()
      Handle changed files with non-ASCII names
      Add rebase test for when upstream has deleted a non-ASCII file


 stgit/git.py                   |   31 +++++++++++++++++++++----------
 t/t3200-non-ascii-filenames.sh |   38 ++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 59 insertions(+), 10 deletions(-)
 create mode 100755 t/t3200-non-ascii-filenames.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
