From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: Quote ~(s) causing subscript
Date: Mon, 15 Sep 2008 11:19:56 +0200
Message-ID: <1221470398-8698-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 11:21:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfAGf-0006Dy-03
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 11:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbYIOJUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 05:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbYIOJUF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 05:20:05 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:47761 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbYIOJUE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 05:20:04 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 15 Sep 2008 11:20:03 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 15 Sep 2008 11:20:02 +0200
X-Mailer: git-send-email 1.6.0.2.451.ga9ffc
X-OriginalArrivalTime: 15 Sep 2008 09:20:03.0001 (UTC) FILETIME=[3BFD4A90:01C91714]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95894>

This is actually not a series, but a choice.  I noticed that
git-bundle.html has a stray subscript in the first paragraph of
'Specifying References', so here are two options:

* Documenation: git-bundle: quote tildes that cause subscript

  The minimal-impact change.  Quotes just enough tildes in that
  paragraph to avoid the subscript.

* Documentation: replace [^~] with escapes everywhere

  The global change.  Quotes all tildes and carets to avoid any future
  confusion.

I like the global change better, because any tilde or caret is a
possible future pitfall: it will trigger a sub/superscript as soon as
a matching delimiter is added within the same paragraph.  But of
course it makes the ascii non-markup less readable as plain text.

Searching through history and list archives didn't exactly help: as
early as babfaba (Fix usage of carets in git-rev-parse(1),
2005-10-05), the {caret} was established.  However, in a thread on
precisely the paragraph in git-bundle.txt I'm trying to fix,

  http://thread.gmane.org/gmane.comp.version-control.git/50761

the discussion turned to trying to figure out a consistent asciidoc
behaviour -- and from there, style guide -- but died.  The patch
apparently never made it into git.git in either the \~ or the {tilde}
form.

- Thomas
