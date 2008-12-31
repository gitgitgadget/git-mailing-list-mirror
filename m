From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] Document git-ls-tree --full-tree
Date: Wed, 31 Dec 2008 19:00:50 +0900
Message-ID: <20081231190050.6117@nanako3.lavabit.com>
References: <200812292336.37812.markus.heidelberg@web.de>
 <20081230071818.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 11:08:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHxzs-00052n-Hf
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 11:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbYLaKBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 05:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbYLaKB3
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 05:01:29 -0500
Received: from karen.lavabit.com ([72.249.41.33]:49949 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753465AbYLaKB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 05:01:28 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id E8ADBC7A73;
	Wed, 31 Dec 2008 04:01:26 -0600 (CST)
Received: from 5114.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id OW42TTFIFE1H; Wed, 31 Dec 2008 04:01:26 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=pUjqnQ6fIz0diOdAFI5w2ECgURiTRDemoHgOIRvkZpdbCdejG8dC7S0ruyuSDEdsDX3y2JDZUp4kPSEZCA8MOw5rAWgTxeThKqi1+ANb4z+y1uXu26q8Q1/SOrAnE/u8n3czZChBD2kTiwP+qLpzozTx5eUYOAL8MvaiuIGIr60=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <200812292336.37812.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104261>


Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

I added the option to ls_tree_usage[] following suggestion by Markus
Heidelberg <markus.heidelberg@web.de>

 Documentation/git-ls-tree.txt |    8 +++++++-
 builtin-ls-tree.c             |    2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 4c7262f..db6ebcc 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-	    [--name-only] [--name-status] [--full-name] [--abbrev=[<n>]]
+	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev=[<n>]]
 	    <tree-ish> [paths...]
 
 DESCRIPTION
@@ -30,6 +30,8 @@ in the current working directory.  Note that:
    'sub/dir' in 'HEAD').  You don't want to give a tree that is not at the
    root level (e.g. 'git ls-tree -r HEAD:sub dir') in this case, as that
    would result in asking for 'sub/sub/dir' in the 'HEAD' commit.
+   However, the current working directory can be ignored by passing
+   --full-tree option.
 
 OPTIONS
 -------
@@ -66,6 +68,10 @@ OPTIONS
 	Instead of showing the path names relative to the current working
 	directory, show the full path names.
 
+--full-tree::
+	Do not limit the listing to the current working directory.
+	Implies --full-name.
+
 paths::
 	When paths are given, show them (note that this isn't really raw
 	pathnames, but rather a list of patterns to match).  Otherwise
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index cb61717..4cd624c 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -23,7 +23,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
 
 static const char ls_tree_usage[] =
-	"git ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]";
+	"git ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]] <tree-ish> [path...]";
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
-- 
1.6.1

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
