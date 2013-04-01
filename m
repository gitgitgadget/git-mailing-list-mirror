From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] remote-hg: fix hg-git test-case
Date: Mon,  1 Apr 2013 15:14:32 -0600
Message-ID: <1364850872-21135-4-git-send-email-felipe.contreras@gmail.com>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 23:23:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMmCB-00082q-NZ
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 23:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758378Ab3DAVWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 17:22:47 -0400
Received: from mail-gg0-f172.google.com ([209.85.161.172]:49073 "EHLO
	mail-gg0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758022Ab3DAVWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 17:22:46 -0400
Received: by mail-gg0-f172.google.com with SMTP id f4so464035ggn.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=c6gEiEQnhj1kxPntiOSjOo+R+3vgpKubcj3VHEnYT1c=;
        b=w5oqUTaxTYrVmcTMmvk+R60Ha9r0yr7tTQ1WwtBp8cTf6kipD4YSDNiavgj5WyHjhA
         P1T9F0MeFoJc43R1Wc2MgJjoSHqlSBkYny4eACs01unqPHUKNhMZsSVho+N+kEGHLEqk
         Ab01bPIvSZR1Q8kR5wuAvBksTMBLhruWzXBY13loegcnSHe9F6dxtGAA1JCgzpXJl9IE
         8lHlvYjI3YHNifJTLQrF/HAkFrrxISbQbd2Xye3A1eYQm5HBVt4Oww+XRIQYWSqPN3bZ
         ROJ35nFjnX5ss7dbdwOZcQxBFI15vDbdVKEOc5PDDXvXXZg0xPlpwmMG4Wz6R3HgtjCQ
         aNRQ==
X-Received: by 10.236.142.171 with SMTP id i31mr11385367yhj.85.1364850934923;
        Mon, 01 Apr 2013 14:15:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id f70sm29864785yhi.12.2013.04.01.14.15.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Apr 2013 14:15:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219709>

There was some lingering code that shouldn't have been there in the
first place.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg-hg-git.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 7e3967f..3f253b7 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -140,7 +140,6 @@ test_expect_success 'executable bit' '
 		git_clone_$x hgrepo-$x gitrepo2-$x &&
 		git_log gitrepo2-$x > log-$x
 	done &&
-	cp -r log-* output-* /tmp/foo/ &&
 
 	test_cmp output-hg output-git &&
 	test_cmp log-hg log-git
-- 
1.8.2
