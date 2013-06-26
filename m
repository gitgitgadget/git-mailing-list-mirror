From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v7 2/5] t7102 (reset): don't hardcode SHA-1 in expected outputs
Date: Wed, 26 Jun 2013 14:19:47 +0400
Message-ID: <db67c6cd80278257b925f5824d1d96d5036d2d24.1372240999.git.Alex.Crezoff@gmail.com>
References: <cover.1372240998.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 26 12:20:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urmpn-0002sT-CE
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 12:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab3FZKUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 06:20:13 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:47579 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab3FZKUK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 06:20:10 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so13196555lab.23
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=aNF1APMswt8u4YvtN6n1fDwsXzbD/mfzfIJtmjJ+U6A=;
        b=X2XZJzNJJKC1XqqNXBsBbaRuLcpN6CB2AA0JaRQhRXyte6AauVSJSEOv7AxsuWRnjO
         KVBpg45WlKRy+44W/GTDlnb7OftPz70EOPiZxlTmORuWDaaiHHo7sekPyh8hF0lxSelP
         OvojG1G3fLjQT8ZdZ/yEM35flIlduuPpSilYQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=aNF1APMswt8u4YvtN6n1fDwsXzbD/mfzfIJtmjJ+U6A=;
        b=iyqbjKhx554hNJQ3NFk/7sCM01e8Pl1gzTJ9gHjvbCCNUWxOCI+zUEdbRa2Xd2TB5x
         yguU4SGBuyvJM6j0LLaIsKPFCKmnsink5OBRijV2qVyzU5cXjZBJjWqqgLRsem31dzo3
         O446yxHZY6WyNQM3oyg42oCeZEgp5RGdpWNmNYmAFBHeweXql8qELaiigTM5uZjIDJZk
         6jUjPHMb3uACvs5W8J5rOcrhlIrqLi/XSWz9+ckm2yL4fBS+wghMckCo0O1zPs40F5PO
         GX3tvximPsz7WKpL5PTWDdsaSSyklghpP8bvHmXU6X+2KXBxCzqPzk5u/FwD6c1qsq++
         CFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=aNF1APMswt8u4YvtN6n1fDwsXzbD/mfzfIJtmjJ+U6A=;
        b=Un2t0uO9lZEWLIjs0CBShZIYYm3cZ0Xj1qZITHnDiv95cm/2K67SgczoZnlAvQ0DO0
         NX4XyVKQcdQT6EIAGS0JvxnBvy9R6HTNoNW5bHDwrF6oYElxWdFWT66U3ZdDl6cDKRRR
         p8TES6qeYAKwUQJFsPYB7pI8k3/8wAJ4YbaLzLlzin/MnbU/9U71BJTWcyNnDz3cw7Ur
         SRPDbU0DijjfmsFcL/CilrbEHGH8sSMupE4tMBG/n5cPjT7jhr8t0dlfLjQoDl0dX35W
         gnZUGDPAlULJkvgpPN4w6EVizOo5exY/bbjRFtjk6ZoFzDuyELyQ5DJVgGq6dhOKtNi8
         fy1A==
X-Received: by 10.152.170.197 with SMTP id ao5mr1591407lac.35.1372242008586;
        Wed, 26 Jun 2013 03:20:08 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id am8sm10511258lac.1.2013.06.26.03.20.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Jun 2013 03:20:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372240998.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372240998.git.Alex.Crezoff@gmail.com>
References: <cover.1372149305.git.Alex.Crezoff@gmail.com> <cover.1372240998.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQmsgeP9HHInW40jvy2HZoIfMnTUhvc9izauokSDfxPiUi0xPuAGJqI8BNkR51/A7sQ07InE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229035>

The expected SHA-1 digests are always available in variables. Use
them instead of hardcoding.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t7102-reset.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index df82ec9..05dfb27 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -192,7 +192,8 @@ test_expect_success \
 	'changing files and redo the last commit should succeed' '
 	echo "3rd line 2nd file" >>secondfile &&
 	git commit -a -C ORIG_HEAD &&
-	check_changes 3d3b7be011a58ca0c179ae45d94e6c83c0b0cd0d &&
+	head4=$(git rev-parse --verify HEAD) &&
+	check_changes $head4 &&
 	test "$(git rev-parse ORIG_HEAD)" = \
 			$head5
 '
@@ -211,7 +212,7 @@ test_expect_success \
 	git reset --hard HEAD~2 &&
 	check_changes ddaefe00f1da16864591c61fdc7adb5d7cd6b74e &&
 	test "$(git rev-parse ORIG_HEAD)" = \
-			3d3b7be011a58ca0c179ae45d94e6c83c0b0cd0d
+			$head4
 '
 
 >.diff_expect
@@ -326,10 +327,11 @@ test_expect_success '--hard reset to HEAD should clear a failed merge' '
 	git checkout branch2 &&
 	echo "3rd line in branch2" >>secondfile &&
 	git commit -a -m "change in branch2" &&
+	head3=$(git rev-parse --verify HEAD) &&
 
 	test_must_fail git pull . branch1 &&
 	git reset --hard &&
-	check_changes 77abb337073fb4369a7ad69ff6f5ec0e4d6b54bb
+	check_changes $head3
 '
 
 >.diff_expect
-- 
1.8.3.1.15.g5c23c1e
