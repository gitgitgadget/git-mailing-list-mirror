From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 17/26] http-backend: reword some documentation
Date: Wed, 28 Oct 2009 17:00:39 -0700
Message-ID: <1256774448-7625-18-git-send-email-spearce@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:02:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ISp-0000kN-0P
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbZJ2ABR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755979AbZJ2ABH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:01:07 -0400
Received: from george.spearce.org ([209.20.77.23]:36252 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682AbZJ2AA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:00:56 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8FFD9381FF; Thu, 29 Oct 2009 00:01:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id F0A8338260;
	Thu, 29 Oct 2009 00:00:53 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131525>

From: Mark Lodato <lodatom@gmail.com>

Clarify some of the git-http-backend documentation, particularly:

* In the Description, state that smart/dumb HTTP fetch and smart HTTP
  push are supported, state that authenticated clients allow push, and
  remove the note that this is only suited for read-only updates.

* At the start of Examples, state explicitly what URL is mapping to what
  location on disk.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-http-backend.txt |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 99dbbfb..0b5e951 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -14,13 +14,15 @@ DESCRIPTION
 -----------
 A simple CGI program to serve the contents of a Git repository to Git
 clients accessing the repository over http:// and https:// protocols.
+The program supports clients fetching using both the smart HTTP protcol
+and the backwards-compatible dumb HTTP protocol, as well as clients
+pushing using the smart HTTP protocol.
 
 By default, only the `upload-pack` service is enabled, which serves
 'git-fetch-pack' and 'git-ls-remote' clients, which are invoked from
-'git-fetch', 'git-pull', and 'git-clone'.
-
-This is ideally suited for read-only updates, i.e., pulling from
-git repositories.
+'git-fetch', 'git-pull', and 'git-clone'.  If the client is authenticated,
+the `receive-pack` service is enabled, which serves 'git-send-pack'
+clients, which is invoked from 'git-push'.
 
 SERVICES
 --------
@@ -50,6 +52,8 @@ automatically by the web server.
 
 EXAMPLES
 --------
+All of the following examples map 'http://$hostname/git/foo/bar.git'
+to '/var/www/git/foo/bar.git'.
 
 Apache 2.x::
 	Ensure mod_cgi, mod_alias, and mod_env are enabled, set
-- 
1.6.5.2.181.gd6f41
