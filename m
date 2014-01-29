From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] Makefile: add cppcheck target
Date: Wed, 29 Jan 2014 03:02:51 -0800
Message-ID: <1390993371-2431-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 29 12:03:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8SvC-0003fT-4B
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 12:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbaA2LC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 06:02:59 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:61149 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaA2LC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 06:02:57 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so1603159pbc.24
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 03:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QzmuVGktTD1tPvm5JBIq7Gjk9SrIHLFVjN3kOUan/uc=;
        b=bFYGHrB5n4JYig6BXQgZx05d2Mns9iekwBwBolW8zkNdKoWwGK2VWHbfN3WxrqurKc
         0WIN4NSJYriNncnFc3EmNARpF2rS+EIBc9922/HM4+xUrPVtj59N6xstcUKxzKR3r7OT
         ebP9dkAIonBIuNpYUjShDU7WOnFqPXP2H9lH1fP+b24h4bKCWvXwnYrNdMpwZyW242v3
         VmZoNMr/db4/Qy4+EveML9yWTlq2UU6YvThvU01M6GFdYbyrG4A6wvrl8+Y5YGqzWGV9
         VUxUiwkDoBRfXVW5JoajJ2hEnlPpjHv9bz2Zr8er5Z96F3b+OXGeRgABW4o1bc+Tk5DV
         jqww==
X-Received: by 10.68.245.162 with SMTP id xp2mr7234485pbc.69.1390993376681;
        Wed, 29 Jan 2014 03:02:56 -0800 (PST)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id qf7sm14021431pac.14.2014.01.29.03.02.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Jan 2014 03:02:56 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241204>

Add cppcheck target to Makefile. Cppcheck is a static
analysis tool for C/C++ code. Cppcheck primarily detects
the types of bugs that the compilers normally do not detect.
It is an useful target for doing QA analysis.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Makefile      |    6 ++++++
 config.mak.in |    1 +
 2 files changed, 7 insertions(+)

diff --git a/Makefile b/Makefile
index dddaf4f..1d25a70 100644
--- a/Makefile
+++ b/Makefile
@@ -2602,3 +2602,9 @@ cover_db: coverage-report
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
 
+### cppcheck static coverage analysis
+#
+.PHONY: cppcheck
+
+cppcheck:
+	cppcheck --enable=all -q $(top_srcdir)
diff --git a/config.mak.in b/config.mak.in
index e6a6d0f..86b95fb 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -22,3 +22,4 @@ docdir = @docdir@
 
 mandir = @mandir@
 htmldir = @htmldir@
+top_srcdir = @top_srcdir@
-- 
1.7.10.4
