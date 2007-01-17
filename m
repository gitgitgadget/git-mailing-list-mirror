From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] sanitize content of README file
Date: Wed, 17 Jan 2007 11:39:55 -0800
Message-ID: <7vtzypqw6s.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701171255150.2577@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 20:40:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Gdb-0004aH-LM
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 20:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbXAQTj5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 14:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbXAQTj5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 14:39:57 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:47360 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600AbXAQTj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 14:39:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070117193955.THSR18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 14:39:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CKgC1W00m1kojtg0000000; Wed, 17 Jan 2007 14:40:13 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0701171255150.2577@xanadu.home> (Nicolas Pitre's
	message of "Wed, 17 Jan 2007 13:04:39 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37031>

I do not think it is a bad idea to make the top-level README
concise and sweet, but this has fallout in Documentation/git.txt
which includes README and makes it into the Discussion section.

The attached patch on top of yours would resurrect it.

---

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 93c7024..9f2d242 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -71,14 +71,11 @@ doc.dep : $(wildcard *.txt) build-docdep.perl
 
 -include doc.dep
 
-git.7: README
-
-README: ../README
-	cp $< $@
+git.7 git.html: git.txt core-intro.txt
 
 
 clean:
-	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep README
+	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep
 
 %.html : %.txt
 	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
@@ -89,8 +86,6 @@ clean:
 %.xml : %.txt
 	asciidoc -b docbook -d manpage -f asciidoc.conf $<
 
-git.html: git.txt README
-
 glossary.html : glossary.txt sort_glossary.pl
 	cat $< | \
 	perl sort_glossary.pl | \
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6a82803..a0bcef7 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -699,7 +699,7 @@ other
 
 Discussion[[Discussion]]
 ------------------------
-include::README[]
+include::core-intro.txt[]
 
 Authors
 -------
