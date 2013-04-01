From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] remote-helpers: fix the run of all tests
Date: Mon,  1 Apr 2013 15:14:30 -0600
Message-ID: <1364850872-21135-2-git-send-email-felipe.contreras@gmail.com>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 23:15:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMm58-0004Kl-5f
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 23:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746Ab3DAVP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 17:15:29 -0400
Received: from mail-gh0-f169.google.com ([209.85.160.169]:64605 "EHLO
	mail-gh0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972Ab3DAVP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 17:15:29 -0400
Received: by mail-gh0-f169.google.com with SMTP id r18so469519ghr.14
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=cOBEyK9MpiEzVnQTPrExnVuOXHmiC+0KIY9m2YdYWok=;
        b=T+xkm1k7xR6AH2LCMrU8fv5MB5vfG2IKSVCYxoaW9PcDiA6hl/i60tYE63EYwjBter
         VH7JhWyHYEY272Hkd8xUUYXdfsmmE8SmsHmQhzNhxBLCBj7Fm7JMfuwltmWtJoD0Ghah
         hUlR69TwZS4irlBsZOgVpdjJrmPvtsRU7oVov5KLfGcDs9c8x7RYCYQelfqTHe+h1CgW
         6BwC6AOcVJdEqNJ+vSSZeNma1mmStUZNjoeQ5I2IJfCsYRtliMRyJR9qKlNI6SRbSad9
         6+lksMmTkqJAaY8XBe7x/tsgKg0KU2ERS2tx+u4s5pPqKZXdPQmlZXRA3T50uWcyJL09
         rY0A==
X-Received: by 10.236.16.202 with SMTP id h50mr11987738yhh.39.1364850928528;
        Mon, 01 Apr 2013 14:15:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id v60sm29903171yhh.23.2013.04.01.14.15.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Apr 2013 14:15:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219707>

Since test-lint doesn't seem to work here, lets disable it. It wouldn't
help either way.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
index 9a76575..9c18ed8 100644
--- a/contrib/remote-helpers/Makefile
+++ b/contrib/remote-helpers/Makefile
@@ -3,6 +3,7 @@ TESTS := $(wildcard test*.sh)
 export T := $(addprefix $(CURDIR)/,$(TESTS))
 export MAKE := $(MAKE) -e
 export PATH := $(CURDIR):$(PATH)
+export TEST_LINT :=
 
 test:
 	$(MAKE) -C ../../t $@
-- 
1.8.2
