From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] Documentation: Document diff.<tool>.* and filter.<driver>.* in config
Date: Fri,  1 Apr 2011 16:13:20 +0530
Message-ID: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
References: <m3ipuy49fg.fsf@localhost.localdomain>
Cc: Jakub Narebski <jnareb@gmail.com>
To: Git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 12:44:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5bqN-00050n-Ez
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 12:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579Ab1DAKoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 06:44:38 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33114 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755507Ab1DAKoh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 06:44:37 -0400
Received: by iyb14 with SMTP id 14so3351314iyb.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=BkRILB6+pizyNvMjDIMqCLJCAmRfl7tPiXnt+4aKfKw=;
        b=OzYu46hVHkUBFUoH/XeooSunNXVNEQzuiouDefcQ1ixfFJlx3jtcLofyMPrz77Or8T
         zlurcEdHJXeaOOhm6wSsECdi+pRezSDvOWr/XHCZWjzuMSbqkN2KQ+HK/pxDkGaniZNq
         I0UvrKFLqyu4SFG8a9PBWw7KqUJ2Iz8aNVOwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QO8zLP8/5qGz8O9lLFlTwdK9HjtbxzmIlkfU+8ah/vwW8y5Bhl4TE5jr+Ti7spbSWk
         OAMa1i0r/btbrfDIFZKtsySX3r10WOVbdJXIygdYe71PcKnViKE/3VApbvomjAgpVSIq
         C7IwahIDnK2DeVDVsZMJKJo9oKyWEZ+2r1GHA=
Received: by 10.231.117.36 with SMTP id o36mr3828743ibq.64.1301654676951;
        Fri, 01 Apr 2011 03:44:36 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id g16sm1390190ibb.20.2011.04.01.03.44.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Apr 2011 03:44:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <m3ipuy49fg.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170579>

Although the gitattributes page contains comprehensive information
about these configuration options, they should be included in the
config documentation for completeness.

Helped-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
The first iteration of this patch contained completely wrong
descriptions for diff.<tool>.* options. Thanks to Jakub for pointing
them out, and for pointing out that I left out a a few options
undocumented (found in userdiff.c).

 Documentation/config.txt |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8ea55d4..b2ec4e1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -875,6 +875,42 @@ diff.tool::
 	the same valid values as `merge.tool` minus "tortoisemerge"
 	and plus "kompare".
 
+diff.<tool>.command::
+	Defines command to be called to generate diff for files with
+	`diff=<tool>` gitattribute.  See linkgit:gitattributes[5] for
+	details.
+
+diff.<tool>.funcname::
+	Specifies a regular expression that matches a line to use as
+	the hunk header for files with `diff=<tool>` gitattribute. A
+	built-in pattern may also be used.  See
+	linkgit:gitattributes[5] for details.
+
+diff.<tool>.xfuncname::
+	Same as 'diff.<tool>.funcname', except that an extended
+	regular expression can be specified in this case.
+
+diff.<tool>.binary::
+	Set to true to treat files files with `diff=<tool>`
+	gitattribute as binary for the purposes of diff.  See
+	linkgit:gitattributes[5] for details.
+
+diff.<tool>.textconv::
+	Defines command to be called to generate text-converted version
+	of a binary file with `diff=<tool>` gitattribute.  The result of
+	the conversion is used to generate human-readable diff.  See
+	linkgit:gitattributes[5] for details.
+
+diff.<tool>.wordregex::
+	Specifies the regular expression to use to customize the rules
+	that `git diff --word-diff` uses to split words in a line.
+	See linkgit:gitattributes[5] for details.
+
+diff.<tool>.cachetextconv::
+	Set to true to enable caching of text conversion outputs for
+	files with `diff=<tool>` gitattribute.  See
+	linkgit:gitattributes[5] for details.
+
 difftool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
@@ -973,6 +1009,16 @@ format.signoff::
     the rights to submit this work under the same open source license.
     Please see the 'SubmittingPatches' document for further discussion.
 
+filter.<driver>.clean::
+	Defines the command to be used to convert the contents of
+	worktree file upon checkin.  See linkgit:gitattributes[5] for
+	details.
+
+filter.<driver>.smudge::
+	Defines the command to be used to convert the blob object to
+	worktree file upon checkout.  See linkgit:gitattributes[5] for
+	details.
+
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
-- 
1.7.4.rc1.7.g2cf08.dirty
