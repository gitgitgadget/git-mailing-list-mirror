From: Jeff King <peff@peff.net>
Subject: [PATCH] fix cat-file usage message and documentation
Date: Mon, 25 May 2009 06:33:15 -0400
Message-ID: <20090525103315.GA26263@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 12:33:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8XUj-0001xY-Lt
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 12:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbZEYKdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 06:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbZEYKdR
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 06:33:17 -0400
Received: from peff.net ([208.65.91.99]:46229 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbZEYKdR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 06:33:17 -0400
Received: (qmail 3660 invoked by uid 107); 25 May 2009 10:33:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 May 2009 06:33:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2009 06:33:15 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119914>

cat-file with an object on the command line requires an
option to tell it what to output (type, size, pretty-print,
etc). However, the square brackets in the usage imply that
those options are not required. This patch switches them to
parentheses to indicate "required but grouped-OR" (curly
braces might also work, but this follows the convention used
already by "git stash").

While we're at it, let's change the <sha1> specifier in the
usage to <object>. That's what the documentation uses, and
it does actually use the regular object lookup.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a followup to:

  http://thread.gmane.org/gmane.comp.version-control.git/116627

 Documentation/git-cat-file.txt |    4 ++--
 builtin-cat-file.c             |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index b191276..58c8d65 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,8 +9,8 @@ git-cat-file - Provide content or type and size information for repository objec
 SYNOPSIS
 --------
 [verse]
-'git cat-file' [-t | -s | -e | -p | <type>] <object>
-'git cat-file' [--batch | --batch-check] < <list-of-objects>
+'git cat-file' (-t | -s | -e | -p | <type>) <object>
+'git cat-file' (--batch | --batch-check) < <list-of-objects>
 
 DESCRIPTION
 -----------
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 8fad19d..43ffe7f 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -201,8 +201,8 @@ static int batch_objects(int print_contents)
 }
 
 static const char * const cat_file_usage[] = {
-	"git cat-file [-t|-s|-e|-p|<type>] <sha1>",
-	"git cat-file [--batch|--batch-check] < <list_of_sha1s>",
+	"git cat-file (-t|-s|-e|-p|<type>) <object>",
+	"git cat-file (--batch|--batch-check) < <list_of_objects>",
 	NULL
 };
 
-- 
1.6.3.1.250.g01b8b.dirty
