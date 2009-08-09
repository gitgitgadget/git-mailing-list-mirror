From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH jp/symlink-dirs] t6035-merge-dir-to-symlink depends on SYMLINKS
 prerequisite
Date: Sun, 09 Aug 2009 17:35:02 +0200
Message-ID: <4A7EECA6.3080309@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 17:35:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaAQq-0007xM-HI
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 17:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbZHIPfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 11:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbZHIPfJ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 11:35:09 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17507 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbZHIPfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 11:35:09 -0400
Received: from [192.168.1.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EA4CA2C400D;
	Sun,  9 Aug 2009 17:35:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125347>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  t/t6035-merge-dir-to-symlink.sh |    6 ++++++
  1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
index a0ddf1e..5b96fb0 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -3,6 +3,12 @@
  test_description='merging when a directory was replaced with a symlink'
  . ./test-lib.sh

+if ! test_have_prereq SYMLINKS
+then
+	say 'Symbolic links not supported, skipping tests.'
+	test_done
+fi
+
  test_expect_success 'create a commit where dir a/b changed to symlink' '
  	mkdir -p a/b/c a/b-2/c &&
  	> a/b/c/d &&
-- 
1.6.4.1026.g2deb5
