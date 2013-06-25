From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v6 2/5] t7102 (reset): don't hardcode SHA-1 in expected outputs
Date: Tue, 25 Jun 2013 12:55:29 +0400
Message-ID: <db67c6cd80278257b925f5824d1d96d5036d2d24.1372149305.git.Alex.Crezoff@gmail.com>
References: <cover.1372149305.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 10:56:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrP2j-0007zp-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 10:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859Ab3FYIzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 04:55:53 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:46840 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab3FYIzs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 04:55:48 -0400
Received: by mail-lb0-f177.google.com with SMTP id 10so793576lbf.22
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 01:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=aNF1APMswt8u4YvtN6n1fDwsXzbD/mfzfIJtmjJ+U6A=;
        b=pmy/Og0DSQoAFbxXsrvF7Iew/ckwBer2UgNvHlpGFVpACXJF+ehj5VumxehV51iisg
         FUZulw6FURiFaK1yj5EIEQdiJ0/k79HXABAYB+O3SHEQ17c2abuBfvnARGRnMzBZWc/j
         nQJuCzxL5Chmn0+TLFOiIzxyNA2ypnpVGYkfg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=aNF1APMswt8u4YvtN6n1fDwsXzbD/mfzfIJtmjJ+U6A=;
        b=m5Fs3tfkpz25w/piPAM8XoX2rQFVLZ80Q8t8By0A3NCP2ifctNoa8VEUn5LAV+kbuI
         QEx56q8zzyCvXQlW6OpOIyh9dTKm5Sscbx8o8pJ5HgKEK1Tnm7vXZXIsC7V1My5yawsN
         O3eopGOKGnsmvaON9dDJ4FtgQx2tSraG38UQMEIuhb3peRajoppqcsSQ+zL4r3oLNXFb
         KzZCLJsdCg3+vFfcs9o2znJCAkh0Y0S6Y2o52RRIuS1nD7XRbK7xYgtofedyNbRcqjdM
         xuwUzUnP7X2GokUJlDySDLWuo2K8jqnkf5ZUbx8ryYJGkRhARcs9bwffOOxgV/qASq2d
         4FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=aNF1APMswt8u4YvtN6n1fDwsXzbD/mfzfIJtmjJ+U6A=;
        b=efn7o23MZcvPqPuOMmvlqGXr5S4qZqrmkzcV1SnS2y9qKDGdsNWrSs8AZkyKlf5Qx4
         Kiq82TXturNl+1vE8gzm2TVZt5gfYQMTwKHlmwyjN3MEHd/JHvwwNsEs2oTvUeCnuIOb
         Xzk82gbEjs8h2c0CZIsLOGLY4TGFCOJVYIxlQ62ktz5siGGCH5jhQUGU5tRtPVRE524B
         jW34fWHssAkoRqMtyuXGGszevRXOl4c/OPTBDS4FBAKrxBCoW7Cxd9rhbBgX0ZqUs83s
         bvBVn2iJbpVdfdwh6gv6pLa5EMMqbEqxmROM7g2VES3TwA1Ft1SzMHDAZ1Mrk+0UByNV
         a77Q==
X-Received: by 10.152.6.228 with SMTP id e4mr13079850laa.61.1372150545518;
        Tue, 25 Jun 2013 01:55:45 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id a9sm4017058lbj.9.2013.06.25.01.55.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 01:55:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372149305.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372149305.git.Alex.Crezoff@gmail.com>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com> <cover.1372149305.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQnw9sL55b2F5PXt9DacbvxFEcwyXWzNUOr8xQLAy44nURN0aGhUB0KObc/8ASbvtXLmGEfN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228949>

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
