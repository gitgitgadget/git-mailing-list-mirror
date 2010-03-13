From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH/RFC 04/12] docs: use <sha1> to mean unabbreviated ID
Date: Fri, 12 Mar 2010 23:52:56 -0500
Message-ID: <1268455984-19061-5-git-send-email-lodatom@gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:53:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJM0-0007Xi-Jl
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837Ab0CMExd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 23:53:33 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:38262 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388Ab0CMExR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 23:53:17 -0500
Received: by qyk9 with SMTP id 9so1844181qyk.5
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Z7akHlFQJs11BbdGHoLsEuM7wnIU5WysfgwGzjkbclA=;
        b=rKPLtc/AgT92wTb0GBaYCMbcvStEs/UMnLHl8Rvh6YzvW7xBq1f0XYoCO6que+Y/LC
         kqsa0lMCJVAf93z+lw1upaa7yTlUNFhU20txDgI2uNGA9Hq4LLC+OUBoS8WSWQNFGrou
         LOq12YiOMnGEH1uIwaKmYIAUdGT6fxp21AQrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=n7YhXNYaJ2VqbLCCehRcwPHy5WQgSdvOYbs6u0YOl5oVF/pR/3e1C89NmPmiEm1cxL
         zhWWniqKVcjNQf8vSlvmGdVzghCybxdHwfnT/et8U6YjxWkfB1zzl3S9+4+9bXl15//U
         5hH6nvni9tE7myhFGxp5NIDmuLc2RqeTNgmvw=
Received: by 10.229.250.149 with SMTP id mo21mr3242342qcb.65.1268455996758;
        Fri, 12 Mar 2010 20:53:16 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1694110qyk.10.2010.03.12.20.53.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:53:16 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142075>

There are some places that literally require a full, 40-character SHA-1
ID, rather than a generic revision specifier.  Introduce in git(1) the
<sha1> terminology to mean this.  Use <sha1> in git-diff-tree(1) to note
that --stdin only takes <sha1>'s, not generic <tree>'s or <commit>'s.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-diff-tree.txt |    4 ++--
 Documentation/git.txt           |    5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index a7e37b8..5d0310b 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -49,8 +49,8 @@ include::diff-options.txt[]
 --stdin::
 	When '--stdin' is specified, the command does not take
 	<tree-ish> arguments from the command line.  Instead, it
-	reads lines containing either two <tree>, one <commit>, or a
-	list of <commit> from its standard input.  (Use a single space
+	reads lines containing <sha1>'s: either two trees, one commit, or
+	multiple commits from its standard input.  (Use a single space
 	as separator.)
 +
 When two trees are given, it compares the first tree with the second.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 35c0c79..a635281 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -412,6 +412,11 @@ list.
 
 Identifier Terminology
 ----------------------
+<sha1>::
+	Indicates a full, 40-character SHA-1 identifier of an object.
+	The type of the referenced object is unspecified.
+	Abbreviated or symbolic identifiers cannot be used.
+
 <object>::
 	Indicates the object name for any type of object.
 
-- 
1.7.0.2
