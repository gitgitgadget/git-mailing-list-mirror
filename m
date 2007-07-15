From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix whitespace in "Format of STDIN stream" of fast-import
Date: Sun, 15 Jul 2007 10:57:40 +0200
Message-ID: <20070715085740.GB2568@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 15 10:57:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9zvH-0000Xi-AV
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 10:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbXGOI5o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 04:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbXGOI5n
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 04:57:43 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:56147 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbXGOI5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 04:57:42 -0400
Received: from tigra.home (Fca5f.f.strato-dslnet.de [195.4.202.95])
	by post.webmailer.de (klopstock mo22) (RZmta 8.3)
	with ESMTP id R01b83j6F760kR ; Sun, 15 Jul 2007 10:57:41 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id DE7CA277BD;
	Sun, 15 Jul 2007 10:57:40 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BA623C164; Sun, 15 Jul 2007 10:57:40 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTNzsQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52535>

Something probably assumed that HT indentation is 4 characters.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---
 fast-import.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 99a19d8..25877e8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -11,7 +11,7 @@ Format of STDIN stream:
         ;
 
   new_blob ::= 'blob' lf
-	mark?
+    mark?
     file_content;
   file_content ::= data;
 
@@ -42,7 +42,7 @@ Format of STDIN stream:
 
   new_tag ::= 'tag' sp tag_str lf
     'from' sp (ref_str | hexsha1 | sha1exp_str | idnum) lf
-	'tagger' sp name '<' email '>' when lf
+    'tagger' sp name '<' email '>' when lf
     tag_msg;
   tag_msg ::= data;
 
@@ -56,9 +56,9 @@ Format of STDIN stream:
      # note: the first idnum in a stream should be 1 and subsequent
      # idnums should not have gaps between values as this will cause
      # the stream parser to reserve space for the gapped values.  An
-	 # idnum can be updated in the future to a new object by issuing
+     # idnum can be updated in the future to a new object by issuing
      # a new mark directive with the old idnum.
-	 #
+     #
   mark ::= 'mark' sp idnum lf;
   data ::= (delimited_data | exact_data)
     lf;
@@ -68,7 +68,7 @@ Format of STDIN stream:
     # delim.
   delimited_data ::= 'data' sp '<<' delim lf
     (data_line lf)*
-	delim lf;
+    delim lf;
 
      # note: declen indicates the length of binary_data in bytes.
      # declen does not include the lf preceeding the binary data.
@@ -78,10 +78,10 @@ Format of STDIN stream:
 
      # note: quoted strings are C-style quoting supporting \c for
      # common escapes of 'c' (e..g \n, \t, \\, \") or \nnn where nnn
-	 # is the signed byte value in octal.  Note that the only
+     # is the signed byte value in octal.  Note that the only
      # characters which must actually be escaped to protect the
      # stream formatting is: \, " and LF.  Otherwise these values
-	 # are UTF8.
+     # are UTF8.
      #
   ref_str     ::= ref;
   sha1exp_str ::= sha1exp;
@@ -104,9 +104,9 @@ Format of STDIN stream:
   lf ::= # ASCII newline (LF) character;
 
      # note: a colon (':') must precede the numerical value assigned to
-	 # an idnum.  This is to distinguish it from a ref or tag name as
+     # an idnum.  This is to distinguish it from a ref or tag name as
      # GIT does not permit ':' in ref or tag strings.
-	 #
+     #
   idnum   ::= ':' bigint;
   path    ::= # GIT style file path, e.g. "a/b/c";
   ref     ::= # GIT ref name, e.g. "refs/heads/MOZ_GECKO_EXPERIMENT";
@@ -115,9 +115,9 @@ Format of STDIN stream:
   hexsha1 ::= # SHA1 in hexadecimal format;
 
      # note: name and email are UTF8 strings, however name must not
-	 # contain '<' or lf and email must not contain any of the
+     # contain '<' or lf and email must not contain any of the
      # following: '<', '>', lf.
-	 #
+     #
   name  ::= # valid GIT author/committer name;
   email ::= # valid GIT author/committer email;
   ts    ::= # time since the epoch in seconds, ascii base10 notation;
-- 
1.5.3.rc1.36.ga297
