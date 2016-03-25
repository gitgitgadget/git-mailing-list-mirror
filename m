From: Chhatoi Pritam Baral <chhatoipritam@gmail.com>
Subject: [PATCH] t7012: Implement test for git-checkout
Date: Fri, 25 Mar 2016 23:06:20 +0530
Message-ID: <56F57714.4050708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 18:37:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajVg8-0006Hv-8V
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 18:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbcCYRhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 13:37:32 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34755 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925AbcCYRhb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 13:37:31 -0400
Received: by mail-pf0-f172.google.com with SMTP id x3so86853376pfb.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=cjon/LX1JU0JdP5hXPZh7bKetPH+IpJpJMTWWz4zrfA=;
        b=neioRoXhg9IbJO8SUG7tvxrV2tbP1mIYIKIh5Gwju3uRfOJ/JrCWwUQr1/31ShIpLd
         JnfAPPubplLrC9fKkL4cQBhnvE8NSF7Ym4px8XEkCp6+6MMs9pVaAQC4vwxdkBJYu8jr
         rK2cANFmwSpbqDRBTdjyaOayDs7+WMveClB+nUsqlNnQGv28+OYl5GEmiNU5shBvhQ0N
         udSDpItx4XPKO7VMWTxEhYApDqXg6qb6IZSf8dKpoEnpg5px4t/949h1rA4BpYchZ/m0
         XjhGUD7j56tC8mPwyfA3BhV+I9+cvmLjH8JrKGHv6PoYE75XvpsSBfcJIaStGwcxmV4O
         9ADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=cjon/LX1JU0JdP5hXPZh7bKetPH+IpJpJMTWWz4zrfA=;
        b=RXwfqSj4FDJ0U3yAyrHE7hgUNlEmFFrzjz3KbYuT28VrWJGCa2nNmrG+7WFvVyzDjD
         yeBkDpoeOf4xm4+lhlSzjHW/S4T4rMTxM5+3sF7HEKzscS/rtbJtBv59vG0bPmk/9eTL
         1W2yV5zivBNFWVQXGVm3PGLGpjxvajWZ9swB+wlKYBI7/koOojjwYmfm0iKMf6Uw3o+H
         0a7Ws9ykWOajTKDg5OONZ0JSAMEiRteH0DttcHZBrVnjWJDmvfqJnUahyVSIbLt5U9cG
         RrthI+US+CjhwELs1yMe/1q+4IvEZskNM4XbV2euoMxdKQn39ABwahoAQKdEtd/SUCWL
         5p/w==
X-Gm-Message-State: AD7BkJJPm8Kiu1oUNRrd4NhBki4/zli4Z7nPhnxkZs/a3A/CnRNpoqnnCbve00Ynp4gUJw==
X-Received: by 10.98.34.200 with SMTP id p69mr22584306pfj.114.1458927450746;
        Fri, 25 Mar 2016 10:37:30 -0700 (PDT)
Received: from [0.0.0.0] ([128.199.85.127])
        by smtp.gmail.com with ESMTPSA id f66sm17762761pff.8.2016.03.25.10.37.29
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2016 10:37:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289913>

Previously a TODO, this patch adds a test for git-checkout skipping a
file with the
skip-worktree bit set.

I'm doing this as a microproject for my GSoC '16 application.

Signed-off-by: Chhatoi Pritam Baral <chhatoipritam@gmail.com>
---
 t/t7012-skip-worktree-writing.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/t7012-skip-worktree-writing.sh
b/t/t7012-skip-worktree-writing.sh
index 9ceaa40..d5b42d6 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -141,6 +141,16 @@ test_expect_success 'git-clean, dirty case' '
 #TODO test_expect_failure 'git-apply removes file' false
 #TODO test_expect_failure 'git-mv to skip-worktree' false
 #TODO test_expect_failure 'git-mv from skip-worktree' false
-#TODO test_expect_failure 'git-checkout' false
+
+test_expect_success 'git-checkout ignores skip-worktree file' '
+	echo > 1 &&
+	git commit -m "Add files" &&
+	echo dirty > 1 &&
+	echo dirty > 2 &&
+	git update-index --skip-worktree 1 &&
+	git checkout -- . &&
+	grep -q dirty 1 &&
+	test_must_fail grep -q dirty 2
+'
  test_done
-- 
2.7.4
