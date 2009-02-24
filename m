From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 1/3] Add --format that is a synonym to --pretty
Date: Tue, 24 Feb 2009 18:59:14 +0900
Message-ID: <20090224185914.6117@nanako3.lavabit.com>
References: <20090224185913.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 11:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbuAm-0005UU-QZ
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 11:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbZBXKDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 05:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753344AbZBXKDt
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 05:03:49 -0500
Received: from karen.lavabit.com ([72.249.41.33]:58796 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753133AbZBXKDs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 05:03:48 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 634BD11B900
	for <git@vger.kernel.org>; Tue, 24 Feb 2009 04:03:46 -0600 (CST)
Received: from 2293.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id DQ815NRICKO4
	for <git@vger.kernel.org>; Tue, 24 Feb 2009 04:03:46 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=hKsZ1yms/V072u+CfYIUBAUqO9g0nenQVRt6o+UoxsYgcJrtS8Drj3eaaIyLBRy3XdO10dNZzDpvFKxLBEEVTOVdNKXwtksk1+cPdvfW+zdDymuzOfcBBoWgwkAVo1/JVZEbj15DAhEn4kbCOW1v4WNpsJ4vMT5sSAVkcokK8hY=;
  h=From:To:In-Reply-To:References:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090224185913.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111279>

Some people prefer to call the pretty-print styles "format", and get
annoyed to see "git log --format=short" fail.  Introduce it as a synonym
to --pretty so that both can be used.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Documentation/pretty-options.txt |    1 +
 revision.c                       |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 5f21efe..6596019 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -1,4 +1,5 @@
 --pretty[='<format>']::
+--format[='<format>']::
 
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
diff --git a/revision.c b/revision.c
index 286e416..556c319 100644
--- a/revision.c
+++ b/revision.c
@@ -1144,7 +1144,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--pretty")) {
 		revs->verbose_header = 1;
 		get_commit_format(arg+8, revs);
-	} else if (!prefixcmp(arg, "--pretty=")) {
+	} else if (!prefixcmp(arg, "--pretty=") || !prefixcmp(arg, "--format=")) {
 		revs->verbose_header = 1;
 		get_commit_format(arg+9, revs);
 	} else if (!strcmp(arg, "--graph")) {
-- 
1.6.2.rc1


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
