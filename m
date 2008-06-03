From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH v2 0/4] Handle non-ASCII filenames
Date: Tue, 03 Jun 2008 02:41:32 +0200
Message-ID: <20080603003846.25028.49353.stgit@yoghurt>
References: <20080602214212.18768.63775.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 02:42:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Kby-0000S3-Ba
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 02:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbYFCAln convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 20:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbYFCAln
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 20:41:43 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3955 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbYFCAlm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 20:41:42 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K3Kaj-0001m2-00; Tue, 03 Jun 2008 01:41:33 +0100
In-Reply-To: <20080602214212.18768.63775.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83602>

I fixed the first problem, and while doing so noticed that a nearby
block of code had exactly the same bug. So I fixed that as well.

Catalin, this should go on the stable branch, I believe. It probably
warrants a new release too, since anyone rebasing patches past the
point where the "M=C3=A4rchen" file was removed from git.git is going t=
o
hit the same bug Jakub did.

( This is a second version of the series, this time based on Catalin's
  stable and not stable~1. As luck would have it, that last commit was
  touching the precise same part of stgit/git.py that my series did.
  Argh. )

---

Karl Hasselstr=C3=B6m (4):
      Handle refresh of changed files with non-ASCII names
      Test for another filename quoting issue in tree_status()
      Handle changed files with non-ASCII names
      Add rebase test for when upstream has deleted a non-ASCII file


 stgit/git.py                   |   31 ++++++++++++++-------
 t/t3200-non-ascii-filenames.sh |   59 ++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 80 insertions(+), 10 deletions(-)
 create mode 100755 t/t3200-non-ascii-filenames.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
