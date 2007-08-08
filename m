From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/2] Test that all branch config information is renamed
Date: Thu, 09 Aug 2007 00:56:36 +0200
Message-ID: <20070808225635.17114.27216.stgit@yoghurt>
References: <20070808225522.17114.3065.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIuSX-0002qz-Io
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 00:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760866AbXHHW4i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 18:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761105AbXHHW4i
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 18:56:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1831 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964AbXHHW4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 18:56:37 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IIuSC-0006Ip-00; Wed, 08 Aug 2007 23:56:36 +0100
In-Reply-To: <20070808225522.17114.3065.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55390>

This test currently fails (which is precisely why it's needed, of
course.) This is bug 9692 in the bug tracker.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t1001-branch-rename.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t1001-branch-rename.sh b/t/t1001-branch-rename.sh
index 28da15c..28af8ae 100755
--- a/t/t1001-branch-rename.sh
+++ b/t/t1001-branch-rename.sh
@@ -26,7 +26,8 @@ test_expect_success \
     'Rename an stgit branch' \
     'stg branch -c buz &&
      stg branch -r foo bar &&
-     test -z `find .git -name foo | tee /dev/stderr`
+     test -z `find .git -name foo | tee /dev/stderr` &&
+     test -z $(git config -l | grep branch\\.foo)
 '
=20
 test_done
