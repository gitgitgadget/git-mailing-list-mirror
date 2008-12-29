From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH 0/2] Fix the building of Info documents
Date: Mon, 29 Dec 2008 10:03:07 +0200
Message-ID: <1230537789-5376-1-git-send-email-tlikonen@iki.fi>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 09:04:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHD7B-0007A7-5z
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 09:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbYL2IDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 03:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYL2IDS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 03:03:18 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:43862 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbYL2IDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 03:03:16 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A88031703F1; Mon, 29 Dec 2008 10:03:15 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LHD5h-0001PB-Sk; Mon, 29 Dec 2008 10:03:09 +0200
X-Mailer: git-send-email 1.6.1.16.gd45c5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104079>

In these days Info documents are probably only used by Emacs users. I'm
one, so I wanted to fix the building of Git Info documents. And it's
even possible - to certain extent.

My real opinion is that the document conversion chain .txt - .xml -
.texi - .info. just can't work without a miracle. These patches
certainly don't do a miracle but they allow building an usable Info
version of the user manual and the man pages. As usual, there are
problems with markup conversions. For example, two dashes (--) in a
.texi file turn into one Ascii dash (-), so there are options like
"-interactive" and "-stat" in the Info documents. I wouldn't advertise
these documents very loudly to the public.

(My real real real opinion is that the GNU people should drop the Info
system and start using html instead. Html probably isn't a simple
drop-in replacement but at least it's a relevant format in 2008-2009.)


Teemu Likonen (2):
  Fix the building of user-manual.texi and gitman.texi documents
  Fix the building of gitman.info document

 Documentation/Makefile      |    9 +++++----
 Documentation/cat-texi.perl |    8 ++++++--
 2 files changed, 11 insertions(+), 6 deletions(-)
