From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH/RFC 02/12] grep docs: grep accepts a <tree-ish>, not a <tree>
Date: Fri, 12 Mar 2010 23:52:54 -0500
Message-ID: <1268455984-19061-3-git-send-email-lodatom@gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:53:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJM0-0007Xi-2S
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757842Ab0CMExc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 23:53:32 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:62083 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000Ab0CMExQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 23:53:16 -0500
Received: by qw-out-2122.google.com with SMTP id 9so447881qwb.37
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=O5Vo91mIS3YcH2dNVPo3wvQcKalB+mDBxlWFAz6MjUE=;
        b=QvTriADSr6zyeHASDTaCIpxjKvMMn6LDTPv6lmHry4xYEVzcGukT/zQAcERodT9X1W
         FdPVumyFcg//V4Ctsf8917IGYvvZz3BcGqEnzXJRDWrFP7L1dtDjXo2QiMDc/eC4WkOI
         LZIa5IWppVAVMPbjGTn0aMyxvZPS3Vt61GuT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ja+f+sLrFv2GCGhqQNsSJLkq2mqKpmZkSwDIWzL4f3kMY3jDgSLJyquKI+OKbf6SSG
         Oaqa7B3PMieEnNvRVMntE8czuyjOWdIUfRYPW85rXGORpZW//bf2TFaJkNL+06nGPVqB
         zNzY3lJKkRWVwTu8tuaQfKev+ifEv3BvZs3Gw=
Received: by 10.224.48.9 with SMTP id p9mr766299qaf.211.1268455995310;
        Fri, 12 Mar 2010 20:53:15 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1694110qyk.10.2010.03.12.20.53.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:53:15 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142076>

Also document that -p accepts a <commit> in the usage message.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-grep.txt |    4 ++--
 builtin/commit-tree.c      |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4b32322..02d6306 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -21,7 +21,7 @@ SYNOPSIS
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
-	   [--cached | --no-index | <tree>...]
+	   [--cached | --no-index | <tree-ish>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -168,7 +168,7 @@ OPTIONS
 	Do not output matched lines; instead, exit with status 0 when
 	there is a match and with non-zero status when there isn't.
 
-<tree>...::
+<tree-ish>...::
 	Instead of searching tracked files in the working tree, search
 	blobs in the given trees.
 
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 96a421e..770baa2 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -22,7 +22,7 @@ static void check_valid(unsigned char *sha1, enum object_type expect)
 		    typename(expect));
 }
 
-static const char commit_tree_usage[] = "git commit-tree <sha1> [-p <sha1>]* < changelog";
+static const char commit_tree_usage[] = "git commit-tree <tree-ish> [-p <commit>]* < changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
-- 
1.7.0.2
