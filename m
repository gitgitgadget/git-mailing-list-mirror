From: Greg Price <price@MIT.EDU>
Subject: [PATCH] Fix ".git/refs" stragglers
Date: Mon, 25 Feb 2013 00:34:14 -0500
Message-ID: <20130225053414.GJ5688@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 06:34:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9qi2-0006tC-8b
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 06:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621Ab3BYFeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 00:34:18 -0500
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:53455 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750824Ab3BYFeR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 00:34:17 -0500
X-AuditID: 1209190f-b7f586d000000915-ab-512af7d8f030
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D9.5A.02325.8D7FA215; Mon, 25 Feb 2013 00:34:16 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id r1P5YGkH026153;
	Mon, 25 Feb 2013 00:34:16 -0500
Received: from localhost (BIOHAZARD-CAFE.MIT.EDU [18.9.64.18])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r1P5YFH7027433;
	Mon, 25 Feb 2013 00:34:15 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixCmqrHvju1agwavLOhZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFJdNSmpOZllqkb5dAlfGqhe7mAr+i1Y823+QsYHxj0AXIyeHhICJxI2v
	e5ggbDGJC/fWs3UxcnEICexjlPi2fSozhLORUaJz2RUmCOczo8SC06/BWlgEVCV2LJ7JDmKz
	CShI/Ji/jhnEFhEQl3h7HCLOLKAm0b5pCiuILSygLTH/6nywXl4BK4mpt6+xQ9iCEidnPmGB
	qNeSuPHvJVANB5AtLbH8HwdIWFRAReLa/na2CYz8s5B0zELSMQuhYwEj8ypG2ZTcKt3cxMyc
	4tRk3eLkxLy81CJdE73czBK91JTSTYzgUJTk38H47aDSIUYBDkYlHt6GlVqBQqyJZcWVuYcY
	JTmYlER5b38FCvEl5adUZiQWZ8QXleakFh9ilOBgVhLh1QwFyvGmJFZWpRblw6SkOViUxHmv
	ptz0FxJITyxJzU5NLUgtgsnKcHAoSfDO/wbUKFiUmp5akZaZU4KQZuLgBBnOAzR8CkgNb3FB
	Ym5xZjpE/hSjopQ4726QhABIIqM0D64XlipeMYoDvSLMuwikigeYZuC6XwENZgIa/FBHHWRw
	SSJCSqqBUUAsIjqT59i0l5WBufoKsZrJDyNzJ29s670krfL1MDejVPpknTtm616wPpnB4DNP
	NuubaGeIEtfyBeong28nPc2czmFU0aI1uc+53OR52obELartc/9uyBBsXPqHQcKfuWbNroYQ
	3p7Qr2wKM7O/Pmu3Yd61bnmWhfninc4xNwJ/xPx3FTyrxFKckWioxVxUnAgA8Ktj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217030>

A couple of references still survive to .git/refs as a tree
of all refs.  Fix one in docs, one in a -h message, one in
a -h message quoted in docs.

Signed-off-by: Greg Price <price@mit.edu>
---
 Documentation/config.txt | 2 +-
 Documentation/gitcli.txt | 9 +++++----
 builtin/describe.c       | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dbb2faf..6eb013a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -423,7 +423,7 @@ core.sharedRepository::
 
 core.warnAmbiguousRefs::
 	If true, git will warn you if the ref name you passed it is ambiguous
-	and might match multiple refs in the .git/refs/ tree. True by default.
+	and might match multiple refs in the repository. True by default.
 
 core.compression::
 	An integer -1..9, indicating a default compression level.
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 3bc1500..d59a5ad 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -107,13 +107,14 @@ couple of magic command line options:
 ---------------------------------------------
 $ git describe -h
 usage: git describe [options] <committish>*
+   or: git describe [options] --dirty
 
     --contains            find the tag that comes after the commit
     --debug               debug search strategy on stderr
-    --all                 use any ref in .git/refs
-    --tags                use any tag in .git/refs/tags
-    --abbrev [<n>]        use <n> digits to display SHA-1s
-    --candidates <n>      consider <n> most recent tags (default: 10)
+    --all                 use any ref
+    --tags                use any tag, even unannotated
+    --long                always use long format
+    --abbrev[=<n>]        use <n> digits to display SHA-1s
 ---------------------------------------------
 
 --help-all::
diff --git a/builtin/describe.c b/builtin/describe.c
index 90a72af..2ef3f10 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -402,8 +402,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOLEAN(0, "contains",   &contains, N_("find the tag that comes after the commit")),
 		OPT_BOOLEAN(0, "debug",      &debug, N_("debug search strategy on stderr")),
-		OPT_BOOLEAN(0, "all",        &all, N_("use any ref in .git/refs")),
-		OPT_BOOLEAN(0, "tags",       &tags, N_("use any tag in .git/refs/tags")),
+		OPT_BOOLEAN(0, "all",        &all, N_("use any ref")),
+		OPT_BOOLEAN(0, "tags",       &tags, N_("use any tag, even unannotated")),
 		OPT_BOOLEAN(0, "long",       &longformat, N_("always use long format")),
 		OPT__ABBREV(&abbrev),
 		OPT_SET_INT(0, "exact-match", &max_candidates,
-- 
1.7.11.3
