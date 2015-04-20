From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 1/2] Documentation: change -L:<regex> to -L:<funcname>
Date: Mon, 20 Apr 2015 14:09:06 +0200
Message-ID: <1429531747-15082-1-git-send-email-Matthieu.Moy@imag.fr>
References: <CAHYJk3RQwDrtox+vB7G70qu1iCDcxCNDfxWyFS7_2CZQZCAgLA@mail.gmail.com>
Cc: git@vger.kernel.org, mikachu@gmail.com, ramsay@ramsay1.demon.co.uk,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 20 14:09:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkAW4-0001Zt-Jx
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 14:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbbDTMJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 08:09:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57340 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754685AbbDTMJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 08:09:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t3KC9HOX030703
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 20 Apr 2015 14:09:18 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3KC9HNN007539;
	Mon, 20 Apr 2015 14:09:17 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YkAVp-00041l-5d; Mon, 20 Apr 2015 14:09:17 +0200
X-Mailer: git-send-email 2.4.0.rc1.42.g9642cc6
In-Reply-To: <CAHYJk3RQwDrtox+vB7G70qu1iCDcxCNDfxWyFS7_2CZQZCAgLA@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 20 Apr 2015 14:09:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3KC9HOX030703
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1430136559.39525@yxg5OldLNMIiBRfYaxv7cw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267465>

The old wording was somehow implying that <start> and <end> were not
regular expressions. Also, the common case is to use a plain function
name here so <funcname> makes sense (the fact that it is a regular
expression is documented in line-range-format.txt).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Change since v1: changed one forgotten <regex> instance to <funcname>,
and spell out "function name" completely in the text explaining it.

 Documentation/blame-options.txt     |  2 +-
 Documentation/git-log.txt           |  4 ++--
 Documentation/gitk.txt              |  4 ++--
 Documentation/line-range-format.txt | 11 ++++++-----
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 0cebc4f..23b8ff8 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -10,7 +10,7 @@
 	Include additional statistics at the end of blame output.
 
 -L <start>,<end>::
--L :<regex>::
+-L :<funcname>::
 	Annotate only the given line range. May be specified multiple times.
 	Overlapping ranges are allowed.
 +
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 1f7bc67..6e65c5a 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -62,9 +62,9 @@ produced by `--stat`, etc.
 	output by allowing them to allocate space in advance.
 
 -L <start>,<end>:<file>::
--L :<regex>:<file>::
+-L :<funcname>:<file>::
 	Trace the evolution of the line range given by "<start>,<end>"
-	(or the funcname regex <regex>) within the <file>.  You may
+	(or the function name regex <funcname>) within the <file>.  You may
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
 	give zero or one positive revision arguments.
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 7ae50aa..6ade002 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -99,10 +99,10 @@ linkgit:git-rev-list[1] for a complete list.
 	detailed explanation.)
 
 -L<start>,<end>:<file>::
--L:<regex>:<file>::
+-L:<funcname>:<file>::
 
 	Trace the evolution of the line range given by "<start>,<end>"
-	(or the funcname regex <regex>) within the <file>.  You may
+	(or the function name regex <funcname>) within the <file>.  You may
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
 	give zero or one positive revision arguments.
diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
index d7f2603..829676f 100644
--- a/Documentation/line-range-format.txt
+++ b/Documentation/line-range-format.txt
@@ -22,8 +22,9 @@ This is only valid for <end> and will specify a number
 of lines before or after the line given by <start>.
 
 +
-If ``:<regex>'' is given in place of <start> and <end>, it denotes the range
-from the first funcname line that matches <regex>, up to the next
-funcname line. ``:<regex>'' searches from the end of the previous `-L` range,
-if any, otherwise from the start of file.
-``^:<regex>'' searches from the start of file.
+If ``:<funcname>'' is given in place of <start> and <end>, it is a
+regular expression that denotes the range from the first funcname line
+that matches <funcname>, up to the next funcname line. ``:<funcname>''
+searches from the end of the previous `-L` range, if any, otherwise
+from the start of file. ``^:<funcname>'' searches from the start of
+file.
-- 
2.4.0.rc1.42.g9642cc6
