From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v16 4/7] t/t7507: improve test coverage
Date: Thu,  5 May 2016 15:19:59 +0530
Message-ID: <1462441802-4768-5-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
 <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, szeder@ira.uka.de, git@vger.kernel.org,
	Pranit Bauva <pranit.bauva@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 05 11:51:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayFwO-0007oe-5A
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 11:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757203AbcEEJvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 05:51:22 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36020 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756808AbcEEJvV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 05:51:21 -0400
Received: by mail-pf0-f182.google.com with SMTP id c189so37265558pfb.3
        for <git@vger.kernel.org>; Thu, 05 May 2016 02:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=77yVPhcYi/U5TT8h+A8jBU6ZcR2+tlLTIpQT8x33dbY=;
        b=l/sikS5U0EKRzPf+4DfJjdWWXmpfPO5U5ilaVfYUGZ6LHDPssLNmTewA+wswVAJwkO
         VbXtefobTMzFdDYjpU7FsW2Y61mgJmF3PAHjtd0LWN7jOVKLry5aShS8FnvThyjphs7l
         v8A+B7UOwNjj5tnyLxJqtTnOGBY6d0/rHEcLDwZzmDVyqIDpNDwn7dhcMDbDgluE3OyR
         bO6TbBvX401gq6zAeSk3qY0fYH54RbDRGtaaMISPQdJ3QlOMe6EN2h1MdrpaIzuzXlot
         oSHWJnuBvul9KGSsAMMia3Nzu7er0roMnS/LBtcdT5lgNHBIDSlomB7LgSJiPZB3kVHV
         /yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=77yVPhcYi/U5TT8h+A8jBU6ZcR2+tlLTIpQT8x33dbY=;
        b=VrQD4ZhheTD6Io7kYEUJRj6z+TW4dsPDJrDeKGnvNAd9HE/PKZzdljvfp6P3yqFa3C
         NyMYjIwDXWLMmpjiEDuaQ6c+9SjsZ96QrGon89p6kVveCDuMiN9uemdHPiceamJyYH9P
         0gwQ9v3yv6FT2Le9Fn6BHbf5nacj+EJbDEbO4fhSP7TQOfD8JivO1eFX94OHlt/GASME
         jWTqAXycPmsfV32u5uQFi2NYg2qpIzc0c+ubP5hTCST6kSrKlCG19Ajv40RoZLjVcNWb
         mGUOfKLuov8mvJvSzHa0W7wxviNQPA9ogQ43Hbcv2+94kQ+bm1yfyEpOixzwVAQv746Y
         pwxw==
X-Gm-Message-State: AOPr4FUvle3LFXBImI4VpXSUULbpFS2dei+kscKjf0tRbE3GgqeiYiAE/2vsvLmbIxGO1g==
X-Received: by 10.98.27.129 with SMTP id b123mr19168467pfb.111.1462441880480;
        Thu, 05 May 2016 02:51:20 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id zn12sm12255111pab.14.2016.05.05.02.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 May 2016 02:51:20 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293640>

git-commit and git-status share the same implementation thus it is
necessary to ensure that changes specific to git-commit don't
accidentally impact git-status.

This test verifies that changes made to verbose in git-commit does not
impact git-status.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t7507-commit-verbose.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2ddf28c..a3c8582 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -96,4 +96,9 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
 	test_i18ngrep "Aborting commit due to empty commit message." err
 '
 
+test_expect_success 'status does not verbose without --verbose' '
+	git status >actual &&
+	! grep "^diff --git" actual
+'
+
 test_done
-- 
2.8.1
