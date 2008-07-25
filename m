From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/3] Test for exit code with command_error()
Date: Fri, 25 Jul 2008 02:52:55 +0200
Message-ID: <20080725005254.13006.49490.stgit@yoghurt>
References: <20080725005154.13006.8908.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 02:54:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMBZP-0006Hr-C1
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbYGYAxA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 20:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbYGYAw7
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:52:59 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3151 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbYGYAw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:52:59 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KMBtm-0005Vu-00; Fri, 25 Jul 2008 02:15:10 +0100
In-Reply-To: <20080725005154.13006.8908.stgit@yoghurt>
User-Agent: StGIT/0.14.3.197.gba718
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89989>

The helper function was made for occasions such as this, so use it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t1300-uncommit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/t/t1300-uncommit.sh b/t/t1300-uncommit.sh
index a906d13..a657ead 100755
--- a/t/t1300-uncommit.sh
+++ b/t/t1300-uncommit.sh
@@ -79,7 +79,7 @@ test_expect_success \
 '
=20
 test_expect_success 'Uncommit a commit with not precisely one parent' =
'
-    stg uncommit -n 5 ; [ $? =3D 2 ] &&
+    command_error stg uncommit -n 5  &&
     [ "$(echo $(stg series))" =3D "" ]
 '
=20
