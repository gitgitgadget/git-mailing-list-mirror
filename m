From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/5] Get rid of backticks in test-lib.sh
Date: Thu, 17 Apr 2008 23:13:04 +0200
Message-ID: <20080417211304.12809.55533.stgit@yoghurt>
References: <20080417210137.12809.88457.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:32:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmbQt-0005C6-RQ
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 23:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926AbYDQVN0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 17:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753909AbYDQVN0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 17:13:26 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4514 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848AbYDQVNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 17:13:25 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JmbPj-0003e3-00; Thu, 17 Apr 2008 22:13:03 +0100
In-Reply-To: <20080417210137.12809.88457.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79830>

The $(...) notation is just plain nicer.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/test-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/t/test-lib.sh b/t/test-lib.sh
index 87c143a..95e322e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -307,13 +307,13 @@ test_cmp() {
 test_create_repo () {
 	test "$#" =3D 1 ||
 	error "bug in the test script: not 1 parameter to test-create-repo"
-	owd=3D`pwd`
+	owd=3D$(pwd)
 	repo=3D"$1"
 	mkdir "$repo"
 	cd "$repo" || error "Cannot setup test environment"
 	git init >/dev/null 2>&1 || error "cannot run git init"
 	echo "empty start" | \
-	    git commit-tree `git write-tree` >.git/refs/heads/master 2>&4 || =
\
+	    git commit-tree $(git write-tree) >.git/refs/heads/master 2>&4 ||=
 \
 	    error "cannot run git commit"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
