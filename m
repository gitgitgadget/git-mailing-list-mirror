From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/2] Document date formats accepted by parse_date()
Date: Wed,  2 Dec 2009 23:16:19 +0100
Message-ID: <831fc8f48429d5a21e29d04760b46b2ddfcb7d80.1259791789.git.vmiklos@frugalware.org>
References: <3d547f4e32c026efc76a7dfe1572da617714f8c9.1259791789.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 23:14:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFxT1-0001e3-1c
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 23:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbZLBWOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 17:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755105AbZLBWOX
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 17:14:23 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:47650 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbZLBWOX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 17:14:23 -0500
Received: from vmobile.example.net (dsl5401C01C.pool.t-online.hu [84.1.192.28])
	by yugo.frugalware.org (Postfix) with ESMTPA id 4AFE61A49F;
	Wed,  2 Dec 2009 23:14:28 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 49206181BCE; Wed,  2 Dec 2009 23:16:20 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <3d547f4e32c026efc76a7dfe1572da617714f8c9.1259791789.git.vmiklos@frugalware.org>
In-Reply-To: <3d547f4e32c026efc76a7dfe1572da617714f8c9.1259791789.git.vmiklos@frugalware.org>
References: <3d547f4e32c026efc76a7dfe1572da617714f8c9.1259791789.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134407>

---
 Documentation/date-formats.txt    |   23 +++++++++++++++++++++++
 Documentation/git-commit-tree.txt |    1 +
 Documentation/git-commit.txt      |    2 ++
 3 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/date-formats.txt

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
new file mode 100644
index 0000000..626c887
--- /dev/null
+++ b/Documentation/date-formats.txt
@@ -0,0 +1,23 @@
+DATE FORMATS
+------------
+
+The GIT_AUTHOR_DATE, GIT_COMMITTER_DATE environment variables
+ifdef::git-commit[]
+and the `--date` option
+endif::git-commit[]
+support the following date formats:
+
+Git native format::
+	It is `<unix timestamp> <timezone offset>`, where `<unix
+	timestamp>` is the number of seconds since the UNIX epoch.
+	`<timezone offset>` is a positive or negative offset from UTC.
+	For example CET (which is 2 hours ahead UTC) is `+0200`.
+
+RFC 2822::
+	The standard email format as described by RFC 2822, for example
+	`Thu, 07 Apr 2005 22:13:13 +0200`.
+
+ISO 8601::
+	Time and date specified by the ISO 8601 standard, for example
+	`2005-04-07T22:13:13`. The parser accepts a space instead of the
+	`T` character as well.
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index b8834ba..4fec5d5 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -73,6 +73,7 @@ A commit comment is read from stdin. If a changelog
 entry is not provided via "<" redirection, 'git-commit-tree' will just wait
 for one to be entered and terminated with ^D.
 
+include::date-formats.txt[]
 
 Diagnostics
 -----------
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index cbbbeeb..17783b4 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -220,6 +220,8 @@ specified.
 	these files are also staged for the next commit on top
 	of what have been staged before.
 
+:git-commit: 1
+include::date-formats.txt[]
 
 EXAMPLES
 --------
-- 
1.6.5.2
