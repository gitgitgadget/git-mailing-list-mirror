From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Problem with git shortlog documentation
Date: Sun, 23 Dec 2007 15:16:00 +0100
Message-ID: <476E6DA0.9000908@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 23 15:16:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Rd2-0007S2-LG
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 15:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbXLWOQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 09:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbXLWOQF
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 09:16:05 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:44790 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbXLWOQE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 09:16:04 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 1E3E525A6B
	for <git@vger.kernel.org>; Sun, 23 Dec 2007 15:16:02 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 11885-03 for <git@vger.kernel.org>;
 Sun, 23 Dec 2007 15:16:01 +0100 (MET)
Received: from [192.168.1.103] (78-69-29-166-no36.tbcn.telia.com [78.69.29.166])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 2BFF625A69
	for <git@vger.kernel.org>; Sun, 23 Dec 2007 15:16:01 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69181>

Hi!

I was just looking through the documentation for git shortlog, and realized 
there is a problem with FILES section close to the bottom.  In the version I 
built of the man page (asciidoc 8.2.1, yes I used the compatibility define) the 
filename .mailmap is missing, and the text starts with "If this file exists, ...".

Looking at the webpage version of the man page 
(http://www.kernel.org/pub/software/scm/git/docs/git-shortlog.html) gives 
another version, still not what I had expected: "mailmap::  If this file exists, 
...", which is not much better.

Unfortunately, I'm completely illiterate in asciidoc/xmlto so I have no idea 
where to start to look for a fix for this without changes to the text. 
Hopefully someone else on the list is more knowledgeable.  Or is it maybe better 
to just reformulate this passage slightly to get around the problem?  Something 
like this (would we then like to reindent this?  it would make the change look 
much bigger), which seems to work with my asciidoc version:

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index e14720b..c37ab66 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -38,8 +38,7 @@ OPTIONS
  FILES
  -----

-.mailmap::
-       If this file exists, it will be used for mapping author email
+       If the file .mailmap exists, it will be used for mapping author email
         addresses to a real author name. One mapping per line, first
         the author name followed by the email address enclosed by
         '<' and '>'. Use hash '#' for comments. Example:

/Gustaf
