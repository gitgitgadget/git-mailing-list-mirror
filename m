From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] t4200: remove two unnecessary lines
Date: Wed,  6 May 2009 17:56:17 -0500
Message-ID: <Lle9L7vlL2vfnqjU75q2MR6WXGGP9aOKv8J97cnRHcQgyJeGbOMDDB2xJugZ0LoonfCRYmzXx9E@cipher.nrlssc.navy.mil>
References: <7vpreluckk.fsf@alter.siamese.dyndns.org>
Cc: pclouds@gmail.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 07 00:56:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1q2c-0006J8-OX
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 00:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbZEFW4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 18:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbZEFW4a
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 18:56:30 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52941 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbZEFW42 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 18:56:28 -0400
Received: by mail.nrlssc.navy.mil id n46MuQXA030239; Wed, 6 May 2009 17:56:26 -0500
In-Reply-To: <7vpreluckk.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 06 May 2009 22:56:25.0757 (UTC) FILETIME=[E23C74D0:01C9CE9D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118401>

These two lines appear to be unnecessary.  They set variables which are not
used afterwards.  The primary motivation to remove them is that the sed
invocation exits non-zero for seds which require newline termination of
input files.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t4200-rerere.sh |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index b68ab11..504802c 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -190,8 +190,6 @@ test_expect_success 'file2 added differently in two branches' '
 	git add file2 &&
 	git commit -m version2 &&
 	test_must_fail git merge fourth &&
-	sha1=$(sed -e "s/	.*//" .git/MERGE_RR) &&
-	rr=.git/rr-cache/$sha1 &&
 	echo Cello > file2 &&
 	git add file2 &&
 	git commit -m resolution
-- 
1.6.2.4.24.gde59d2
