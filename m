From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] diff format documentation: describe raw combined diff format
Date: Sat,  5 May 2007 00:48:35 +0200
Message-ID: <1178318915945-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 00:44:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk6Vk-0008Td-Hc
	for gcvg-git@gmane.org; Sat, 05 May 2007 00:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031717AbXEDWoV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 18:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031720AbXEDWoU
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 18:44:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:5682 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031717AbXEDWoT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 18:44:19 -0400
Received: by ug-out-1314.google.com with SMTP id 44so732265uga
        for <git@vger.kernel.org>; Fri, 04 May 2007 15:44:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=PoMUb2+K+aGL8g9CWfxrGBfQDHCtTh6KVJt51+IHnX1sNYgEMul+3S4SNGuu0exVoJ0gn+j9tiJTb53ExyjyJVynL6riFfC9VH4XN9c+S8diWWj2ExuPJ0wGnAyjurD9E8KOqtjltWLueNes7fX7nReFyFaQnXbDZ9swbR28BBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=UW/WA+tZQqbrPKgjR7sNVgkHFcnP7mt0Umrth+pYeUKFmBEaHPBrWBIsnXQxf34D7LDmacxwhvgWTE0nW8SaFWnU9snbOa1YqQa2oV6D5OyZE40fXO4mclprfc9lCIn6fZEdNwpSO0FRHtCMdtgOppR4JinYd+/wGyVLQwfK4YA=
Received: by 10.66.232.9 with SMTP id e9mr1525466ugh.1178318658150;
        Fri, 04 May 2007 15:44:18 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id i39sm6374973ugd.2007.05.04.15.44.14;
        Fri, 04 May 2007 15:44:16 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l44MmbDI020776;
	Sat, 5 May 2007 00:48:37 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l44MmaHS020775;
	Sat, 5 May 2007 00:48:36 +0200
X-Mailer: git-send-email 1.5.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46224>

Add description of raw combined diff format to diff-formats.txt,
as "diff format for merges" section, before "Generating patches..."
section.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The description of raw combined diff format is based testing the output,
and on what I remember on discussion regarding raw format: the lack of
"score" number (although it should be fairly easy to add it), and path
only for "dst". See for example:

 $ git diff-tree -M -c --raw c182ec90d824168cfb70494bb920c0a2fb590d98

I need documentation of raw combined diff format to allow gitweb to show
diff with any parent and diff --cc (or diff -c), not just diff with the
first parent for a merge.


SIDENOTE: in man pages generated using asciidoc 7.1.2 the literal
block used for examples lacks vertical whitespace after block. For
example the following asciidoc code

  Example:
  
  ------------------------------------------------
  ::100644 100644 100644 fabadb8... cc95eb0... 4866510... MM	describe.c
  ------------------------------------------------
  
  Note that 'combined diff' lists only files which were modified from
 
renders as (make doc; man Documentation/git-diff-tree.1)

  Example:

  ::100644 100644 100644 fabadb8... cc95eb0... 4866510... MM      describe.c
  Note  that combined diff lists only files which were modified from

Note no space after example.

Similar formatting is used very common in the git documentation.
I'd try to upgrade asciidoc and see if the problem persists.


 Documentation/diff-format.txt |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 378e72f..e38a1f1 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -59,6 +59,28 @@ When `-z` option is not used, TAB, LF, and backslash characters
 in pathnames are represented as `\t`, `\n`, and `\\`,
 respectively.
 
+diff format for merges
+----------------------
+
+"git-diff-tree" and "git-diff-files" can take '-c' or '--cc' option
+to generate diff output also for merge commits.  The output differs
+from the format described above in the following way:
+
+. there is a colon for each parent
+. there are more "src" modes and "src" sha1
+. status is concatenated status characters for each parent
+. no optional "score" number
+. single path, only for "dst"
+
+Example:
+
+------------------------------------------------
+::100644 100644 100644 fabadb8... cc95eb0... 4866510... MM	describe.c
+------------------------------------------------
+
+Note that 'combined diff' lists only files which were modified from
+all parents.
+
 
 Generating patches with -p
 --------------------------
-- 
1.5.1.3
