From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v16 0/7] config commit verbose
Date: Thu,  5 May 2016 15:19:55 +0530
Message-ID: <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, szeder@ira.uka.de, git@vger.kernel.org,
	Pranit Bauva <pranit.bauva@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 05 11:51:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayFw9-0007g7-TY
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 11:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881AbcEEJvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 05:51:09 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33502 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756493AbcEEJvH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 05:51:07 -0400
Received: by mail-pa0-f49.google.com with SMTP id xk12so34659990pac.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 02:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L9rJHyB9XPKzZLeTNMmeoKign1puTQrb+V6GbuNcbLI=;
        b=y3ONh2tEbs43LJRlszwDWgjUux5OwDxDzAAr2U9j5ygE4/FHS6xG+w0PvF+IJval3+
         Js+AxXwDXRBp7am9qozyCcM0KpRlBahZmfIc9p1AjpIZooCrrY6GjiM0ogz3yjhwopnj
         SxbA6s/NFjlaQQ4/8vPaeyiXX5ELF2MeKSI2nBEbYOu75rucscf4hBYyHv2vtu1QP7x1
         9iWydmJjZNgahmzjkPdjdCPs1aD1GdyxjOvwiI6AHenZFdzxNi0yBlz/1J7cv5UPWivv
         /ldcYKk+0TxlBHwZGgoKkFInr1itXwBd5kH0PKjV56dR5ps1Kgpl0xD8Mcr8ptZxmjKi
         tiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L9rJHyB9XPKzZLeTNMmeoKign1puTQrb+V6GbuNcbLI=;
        b=YOxlhmIe6RGhn8lgS1zlGv+DKDU2wThVLsMGEqNk2D+P9Hd77TdnGjyZ62Hdq3GYuI
         zwgj73WyRG4p4PuzWGn5SGfqRqYJ5CsCHFFOPn4H2Dd6to4lmXiHIIThduQFwxQT1kcz
         1PMtC9/FKCk7LdeY5mqRWIPvfqaUXMydQCwIix3lp24jea9m3EcHnSXG7bB8YcU/V3SQ
         mOKDUlSe6x1Y1f1kE9O9WRKRDUmFy+fEEeUDudb240pLG5ZwSHESSGRylG3tqfhafv6R
         sDgIfZxCY/CXGe/6pPocMtSwgKfVIhhyneGQdY1aaIuUglKh//twD70/3VhtPLGSihHR
         dKmA==
X-Gm-Message-State: AOPr4FXV6rWYwmfSiatS1JfTqjSNYi+FBQ8bp0ux/V4Hz0tuWUIYYzYS+cg1zUUgxl/QNA==
X-Received: by 10.66.14.198 with SMTP id r6mr19460472pac.48.1462441866528;
        Thu, 05 May 2016 02:51:06 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id zn12sm12255111pab.14.2016.05.05.02.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 May 2016 02:51:05 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293635>

This series of patches add a configuration variable for verbose in
git-commit.

Link to v15:
http://thread.gmane.org/gmane.comp.version-control.git/293127

Changes wrt v15:
 * Remove the previous patch 7/7 and split the tests. Include one in
   initial patch 6/7. The other one is introduced in a separate commit
   after 4/7.
 * Include tests in patch 3/6 for --no-quiet without -q, multiple verbose,
   --no-verbose with -v as suggested by Eric Sunshine

Pranit Bauva (7):
  t0040-test-parse-options.sh: fix style issues
  test-parse-options: print quiet as integer
  t0040-parse-options: improve test coverage
  t/t7507: improve test coverage
  parse-options.c: make OPTION_COUNTUP respect "unspecified" values
  t7507-commit-verbose: improve test coverage by testing number of diffs
  commit: add a commit.verbose config variable

 Documentation/config.txt                      |   4 +
 Documentation/git-commit.txt                  |   3 +-
 Documentation/technical/api-parse-options.txt |   8 +-
 builtin/commit.c                              |  14 +-
 parse-options.c                               |   2 +
 t/t0040-parse-options.sh                      | 238 +++++++++++++++++++-------
 t/t7507-commit-verbose.sh                     |  72 +++++++-
 test-parse-options.c                          |   5 +-
 8 files changed, 271 insertions(+), 75 deletions(-)

-- 
2.8.1
