From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v5 2/5] t7102 (reset): don't hardcode SHA-1 in expected outputs
Date: Thu, 20 Jun 2013 13:26:18 +0400
Message-ID: <acdabc3dc47f543d519ab598ffef8df1fd91be7f.1371720245.git.Alex.Crezoff@gmail.com>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 20 11:27:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upb8t-0002zW-3N
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 11:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233Ab3FTJ0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 05:26:55 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36031 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935353Ab3FTJ0x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 05:26:53 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so5524051lbh.37
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 02:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=aNF1APMswt8u4YvtN6n1fDwsXzbD/mfzfIJtmjJ+U6A=;
        b=Gb1zz3+NITcUKLadFHhCIpJ6/KVTEVzFrmoODkTM7OvGPb2qI7jZjrClWYsPOlz9ZN
         nv7yulw+MWVQa2M2p7Avu1kfNJeBWaOb/PUlihW6+z1uPGyiCqL1OH6RxHsoCmMdAJnY
         Af0vvxfbSQSTi8HXH0ftaljqPHcw/7nLvIvDQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=aNF1APMswt8u4YvtN6n1fDwsXzbD/mfzfIJtmjJ+U6A=;
        b=rnXOoP51VY91y5/gxTUXT5PajYLh+tuIEdC0iUhnn/T0SdKM9j2qZPImL4ED7trpXl
         WvzpICMEjK2V7QjJoRwNdSHkL+uoyjriyj4N7TED/eEIbDYvDB0VuQGdnt+wM6poPWKH
         JsNXe2dQTCuEaqgypXv0mKHm0JbUYbToMKfNAcVPjLIksZeTbzgdT0XYwzyK8kKzuU3d
         WRrynyeBO6+IzXko5Gi+fDi73YPE5Z5yuGMtsS04pbikJddTlfOzc+jO7QoGmWmUD+Ez
         ed/qGCTz8xiQThXKR4y1rOmEx2TXvln8QrHdaLq6VJaHxU57ubjJFSJ4M/LMrom2uVhW
         6T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=aNF1APMswt8u4YvtN6n1fDwsXzbD/mfzfIJtmjJ+U6A=;
        b=QvEBgfj3/1lwyBRfkJbjtHAtsPrelpKH4XDDqQRFh1VY8pT4ecbf5DjvII5Mqit7fi
         voZU3dz0m0lNzJ92EiUIlapXG+sDj/vmTBriF6riTpHARQOzNq+h3la3ZQAtPI0p59NJ
         8n8Bj3bbueBag+unZNqzO8BSEUQV8pUCohESanfNZTpjtMjZzflRr4+wFKTna2cgcQMU
         4I2irhGbU2T7tIAQz69snFehMhfYuFEa1YJTxocFZLsB7/iugathuvp5mlXthy4yaeta
         S2xQ/3m6VHimF6ajQ8+NXklUmuMbrs8WlUvmqDbuPjb1bFzQFOt3VQ1BA5+ZWoZvkLww
         D3cg==
X-Received: by 10.152.8.103 with SMTP id q7mr3259096laa.64.1371720411540;
        Thu, 20 Jun 2013 02:26:51 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id p10sm2996660lap.8.2013.06.20.02.26.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 02:26:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1371720245.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1371720245.git.Alex.Crezoff@gmail.com>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com> <cover.1371720245.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQncKYtIFCYtBChigtvesf4ct36F80wcbHmhObz8WMnc/9mIe3iEQJqGLz9u2rrhlJsKm+kA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228470>

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
