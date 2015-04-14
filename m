From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
Date: Tue, 14 Apr 2015 15:25:07 -0700
Message-ID: <1429050308-9617-3-git-send-email-sbeller@google.com>
References: <1429050308-9617-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Apr 15 00:25:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi9Gt-0003zF-4A
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 00:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbbDNWZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 18:25:28 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34069 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215AbbDNWZW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 18:25:22 -0400
Received: by iget9 with SMTP id t9so84629413ige.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uv8WGq2clvJExErTad2rflNgRnLGa/XUYDrxY6P4o/o=;
        b=WE1UHQsTHOTjp6IeAYN/gOX3meNQllgPhVBJNdSaiFN/FzBoMHdcI3o/GlLtNdYwUM
         xa6cHKhYkvsfnTePhfvc0mhpfbU9deH16z3GTiLCmd3Nns+8i8GiAmnn4yWTU8vGObqv
         5AzWrQR5gthH9uxYm3ieGEoTf4P1wqZRbfFutRrEc7a7vRBPXL3MD5Rac5H4Kdx2jNFa
         F9pERVza+JvOIS3NCABpe87anQWCfo1mHCnY1uIO42+n/W+c91cV+nGrOJITZLmU4y90
         or489iymNjT0Ur60F23Lbv65qfwpRNjtkE9nhdzDWPGg/k7s6oQ+17jNvlSuLE4b4oy8
         ix8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uv8WGq2clvJExErTad2rflNgRnLGa/XUYDrxY6P4o/o=;
        b=isdsqw2sKWIydDns4jFoA99GraTf+INSZgAk4MjR6Ig4Tvhawg8m/sakzE83HE0sWQ
         vO8S5p8YopP5P4ohKSbvR93CAT4J5fuDofDNK9Cf9aVVfJx8zoRzkuL11SOX3pNlCLRn
         eD0W3TTQwtorGiTzDlFfqaSZWc9gT023d7wV7gQbH1UG1ujbOJo7K9vnppCJr9mLeGOQ
         QzMrgRn77pO+W6GOAWMJm0AuY6hTK2J4FTLsvXP/folsteJF6wla2/0KiDqdsumJ8agB
         TOzNqA7XxqKF3zzuTVyiKNvTSDGDe0m7QA02kfnJlzatui59OknxTQqnpiw+nM3OTSDc
         kX5Q==
X-Gm-Message-State: ALoCoQkdZ7NHTfobE9S/Xe62gOOCM0lRaZiCHbCiOjB83MGbGS7Ue/f1CtCkg07skecOkxBx63JG
X-Received: by 10.42.188.19 with SMTP id cy19mr28767744icb.92.1429050321889;
        Tue, 14 Apr 2015 15:25:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:f14f:277:5d87:2236])
        by mx.google.com with ESMTPSA id j4sm8185467igm.21.2015.04.14.15.25.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Apr 2015 15:25:20 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1429050308-9617-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267168>

During creation of the patch series our discussion we could have a
more descriptive name for the prerequisite for the test so it stays
unique when other limits of ulimit are introduced.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7004-tag.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 796e9f7..06b8e0d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1463,10 +1463,10 @@ run_with_limited_stack () {
 	(ulimit -s 128 && "$@")
 }
 
-test_lazy_prereq ULIMIT 'run_with_limited_stack true'
+test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
 
 # we require ulimit, this excludes Windows
-test_expect_success ULIMIT '--contains works in a deep repo' '
+test_expect_success ULIMIT_STACK_SIZE '--contains works in a deep repo' '
 	>expect &&
 	i=1 &&
 	while test $i -lt 8000
-- 
2.3.0.81.gc37f363
