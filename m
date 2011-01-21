From: Libor Pechacek <lpechacek@suse.cz>
Subject: [PATCH v2] Documentation fixes in git-config
Date: Fri, 21 Jan 2011 11:25:37 +0100
Message-ID: <20110121102537.GH19715@fm.suse.cz>
References: <20110108144644.GA11019@localhost.suse.cz> <20110111055922.GD10094@sigill.intra.peff.net> <20110119100105.GB8034@fm.suse.cz> <20110119141401.GE8034@fm.suse.cz> <20110121002716.GC9442@sigill.intra.peff.net> <20110121102048.GF19715@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 21 11:25:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgEBc-0000nw-G2
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 11:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab1AUKZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 05:25:39 -0500
Received: from cantor2.suse.de ([195.135.220.15]:50217 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab1AUKZi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 05:25:38 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id EE8C487104;
	Fri, 21 Jan 2011 11:25:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110121102048.GF19715@fm.suse.cz>
User-Agent: Mutt/1.5.18-muttng (2008-05-17-r1399)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165363>

Variable names must start with an alphabetic character, regexp config key
matching has its limits.

Signed-off-by: Libor Pechacek <lpechacek@suse.cz>
Cc: Jeff King <peff@peff.net>
---
 Documentation/config.txt     |   12 +++++++-----
 Documentation/git-config.txt |    9 +++++++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ff7c225..928ceda 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -12,8 +12,9 @@ The configuration variables are used by both the git plumbing
 and the porcelains. The variables are divided into sections, wherein
 the fully qualified variable name of the variable itself is the last
 dot-separated segment and the section name is everything before the last
-dot. The variable names are case-insensitive and only alphanumeric
-characters are allowed. Some variables may appear multiple times.
+dot. The variable names are case-insensitive, allow only alphanumeric
+characters and '-', and must start with an alphabetic character.  Some
+variables may appear multiple times.
 
 Syntax
 ~~~~~~
@@ -53,9 +54,10 @@ All the other lines (and the remainder of the line after the section
 header) are recognized as setting variables, in the form
 'name = value'.  If there is no equal sign on the line, the entire line
 is taken as 'name' and the variable is recognized as boolean "true".
-The variable names are case-insensitive and only alphanumeric
-characters and `-` are allowed.  There can be more than one value
-for a given variable; we say then that variable is multivalued.
+The variable names are case-insensitive, allow only alphanumeric characters
+and `-`, and must start with an alphabetic character.  There can be more
+than one value for a given variable; we say then that variable is
+multivalued.
 
 Leading and trailing whitespace in a variable value is discarded.
 Internal whitespace within a variable value is retained verbatim.
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 543dd64..31f4658 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -83,8 +83,13 @@ OPTIONS
 	is not exactly one.
 
 --get-regexp::
-	Like --get-all, but interprets the name as a regular expression.
-	Also outputs the key names.
+	Like --get-all, but interprets the name as a regular expression and
+	writes out the key names.  Regular expression matching is currently
+	case-sensitive and done against a canonicalized version of the key
+	in which section and variable names are lowercased, but subsection
+	names are not.  Regular expressions are partially lower-cased
+	before matching (everything before the first dot and after the last
+	dot), which makes things like "Core.*' work.
 
 --global::
 	For writing options: write to global ~/.gitconfig file rather than
-- 
1.7.4.rc2.20.gdb1b81
