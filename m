From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git.txt: Fix asciidoc syntax of --*-pathspecs
Date: Tue, 24 Sep 2013 00:18:38 -0400
Message-ID: <20130924041838.GC2766@sigill.intra.peff.net>
References: <1379962475-6880-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Sep 24 06:18:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOK5G-0007HV-Tz
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 06:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757Ab3IXESn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 00:18:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:52635 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab3IXESm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 00:18:42 -0400
Received: (qmail 28538 invoked by uid 102); 24 Sep 2013 04:18:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Sep 2013 23:18:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 00:18:38 -0400
Content-Disposition: inline
In-Reply-To: <1379962475-6880-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235255>

On Mon, Sep 23, 2013 at 08:54:35PM +0200, Steffen Prohaska wrote:

> Labeled lists require a double colon.

Thanks, this looks good.

While looking at the git.txt source, I noticed it is quite awkward to
read due to the size of the stalenotes section. The patch below moves
that section out to its own file.

That section used to be turned on when Junio auto-built the
documentation after pushing to kernel.org. But he does not seem to do so
for recent versions of the auto-generated docs, as of commit adaa3ca on
the 'todo' branch. I don't know if that is a bug, or if the whole
stalenotes thing can simply go away.

-- >8 --
Subject: [PATCH] docs: split stalenotes out from git.txt

The git.txt manpage contains a section indicating the
current version, and pointing to release notes for past
versions. We don't usually include this version in the built
manpages, but anyone looking at the source needs to scroll
past it. Let's make it easier on them by splitting it out
into its own file.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git.txt        | 345 +------------------------------------------
 Documentation/stalenotes.txt | 344 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 345 insertions(+), 344 deletions(-)
 create mode 100644 Documentation/stalenotes.txt

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5d68d33..3d99668 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -34,350 +34,7 @@ can be viewed at `http://git-htmldocs.googlecode.com/git/git.html`.
 Formatted and hyperlinked version of the latest Git documentation
 can be viewed at `http://git-htmldocs.googlecode.com/git/git.html`.
 
-ifdef::stalenotes[]
-[NOTE]
-============
-
-You are reading the documentation for the latest (possibly
-unreleased) version of Git, that is available from 'master'
-branch of the `git.git` repository.
-Documentation for older releases are available here:
-
-* link:v1.8.4/git.html[documentation for release 1.8.4]
-
-* release notes for
-  link:RelNotes/1.8.4.txt[1.8.4].
-
-* link:v1.8.3.4/git.html[documentation for release 1.8.3.4]
-
-* release notes for
-  link:RelNotes/1.8.3.4.txt[1.8.3.4],
-  link:RelNotes/1.8.3.3.txt[1.8.3.3],
-  link:RelNotes/1.8.3.2.txt[1.8.3.2],
-  link:RelNotes/1.8.3.1.txt[1.8.3.1],
-  link:RelNotes/1.8.3.txt[1.8.3].
-
-* link:v1.8.2.3/git.html[documentation for release 1.8.2.3]
-
-* release notes for
-  link:RelNotes/1.8.2.3.txt[1.8.2.3],
-  link:RelNotes/1.8.2.2.txt[1.8.2.2],
-  link:RelNotes/1.8.2.1.txt[1.8.2.1],
-  link:RelNotes/1.8.2.txt[1.8.2].
-
-* link:v1.8.1.6/git.html[documentation for release 1.8.1.6]
-
-* release notes for
-  link:RelNotes/1.8.1.6.txt[1.8.1.6],
-  link:RelNotes/1.8.1.5.txt[1.8.1.5],
-  link:RelNotes/1.8.1.4.txt[1.8.1.4],
-  link:RelNotes/1.8.1.3.txt[1.8.1.3],
-  link:RelNotes/1.8.1.2.txt[1.8.1.2],
-  link:RelNotes/1.8.1.1.txt[1.8.1.1],
-  link:RelNotes/1.8.1.txt[1.8.1].
-
-* link:v1.8.0.3/git.html[documentation for release 1.8.0.3]
-
-* release notes for
-  link:RelNotes/1.8.0.3.txt[1.8.0.3],
-  link:RelNotes/1.8.0.2.txt[1.8.0.2],
-  link:RelNotes/1.8.0.1.txt[1.8.0.1],
-  link:RelNotes/1.8.0.txt[1.8.0].
-
-* link:v1.7.12.4/git.html[documentation for release 1.7.12.4]
-
-* release notes for
-  link:RelNotes/1.7.12.4.txt[1.7.12.4],
-  link:RelNotes/1.7.12.3.txt[1.7.12.3],
-  link:RelNotes/1.7.12.2.txt[1.7.12.2],
-  link:RelNotes/1.7.12.1.txt[1.7.12.1],
-  link:RelNotes/1.7.12.txt[1.7.12].
-
-* link:v1.7.11.7/git.html[documentation for release 1.7.11.7]
-
-* release notes for
-  link:RelNotes/1.7.11.7.txt[1.7.11.7],
-  link:RelNotes/1.7.11.6.txt[1.7.11.6],
-  link:RelNotes/1.7.11.5.txt[1.7.11.5],
-  link:RelNotes/1.7.11.4.txt[1.7.11.4],
-  link:RelNotes/1.7.11.3.txt[1.7.11.3],
-  link:RelNotes/1.7.11.2.txt[1.7.11.2],
-  link:RelNotes/1.7.11.1.txt[1.7.11.1],
-  link:RelNotes/1.7.11.txt[1.7.11].
-
-* link:v1.7.10.5/git.html[documentation for release 1.7.10.5]
-
-* release notes for
-  link:RelNotes/1.7.10.5.txt[1.7.10.5],
-  link:RelNotes/1.7.10.4.txt[1.7.10.4],
-  link:RelNotes/1.7.10.3.txt[1.7.10.3],
-  link:RelNotes/1.7.10.2.txt[1.7.10.2],
-  link:RelNotes/1.7.10.1.txt[1.7.10.1],
-  link:RelNotes/1.7.10.txt[1.7.10].
-
-* link:v1.7.9.7/git.html[documentation for release 1.7.9.7]
-
-* release notes for
-  link:RelNotes/1.7.9.7.txt[1.7.9.7],
-  link:RelNotes/1.7.9.6.txt[1.7.9.6],
-  link:RelNotes/1.7.9.5.txt[1.7.9.5],
-  link:RelNotes/1.7.9.4.txt[1.7.9.4],
-  link:RelNotes/1.7.9.3.txt[1.7.9.3],
-  link:RelNotes/1.7.9.2.txt[1.7.9.2],
-  link:RelNotes/1.7.9.1.txt[1.7.9.1],
-  link:RelNotes/1.7.9.txt[1.7.9].
-
-* link:v1.7.8.6/git.html[documentation for release 1.7.8.6]
-
-* release notes for
-  link:RelNotes/1.7.8.6.txt[1.7.8.6],
-  link:RelNotes/1.7.8.5.txt[1.7.8.5],
-  link:RelNotes/1.7.8.4.txt[1.7.8.4],
-  link:RelNotes/1.7.8.3.txt[1.7.8.3],
-  link:RelNotes/1.7.8.2.txt[1.7.8.2],
-  link:RelNotes/1.7.8.1.txt[1.7.8.1],
-  link:RelNotes/1.7.8.txt[1.7.8].
-
-* link:v1.7.7.7/git.html[documentation for release 1.7.7.7]
-
-* release notes for
-  link:RelNotes/1.7.7.7.txt[1.7.7.7],
-  link:RelNotes/1.7.7.6.txt[1.7.7.6],
-  link:RelNotes/1.7.7.5.txt[1.7.7.5],
-  link:RelNotes/1.7.7.4.txt[1.7.7.4],
-  link:RelNotes/1.7.7.3.txt[1.7.7.3],
-  link:RelNotes/1.7.7.2.txt[1.7.7.2],
-  link:RelNotes/1.7.7.1.txt[1.7.7.1],
-  link:RelNotes/1.7.7.txt[1.7.7].
-
-* link:v1.7.6.6/git.html[documentation for release 1.7.6.6]
-
-* release notes for
-  link:RelNotes/1.7.6.6.txt[1.7.6.6],
-  link:RelNotes/1.7.6.5.txt[1.7.6.5],
-  link:RelNotes/1.7.6.4.txt[1.7.6.4],
-  link:RelNotes/1.7.6.3.txt[1.7.6.3],
-  link:RelNotes/1.7.6.2.txt[1.7.6.2],
-  link:RelNotes/1.7.6.1.txt[1.7.6.1],
-  link:RelNotes/1.7.6.txt[1.7.6].
-
-* link:v1.7.5.4/git.html[documentation for release 1.7.5.4]
-
-* release notes for
-  link:RelNotes/1.7.5.4.txt[1.7.5.4],
-  link:RelNotes/1.7.5.3.txt[1.7.5.3],
-  link:RelNotes/1.7.5.2.txt[1.7.5.2],
-  link:RelNotes/1.7.5.1.txt[1.7.5.1],
-  link:RelNotes/1.7.5.txt[1.7.5].
-
-* link:v1.7.4.5/git.html[documentation for release 1.7.4.5]
-
-* release notes for
-  link:RelNotes/1.7.4.5.txt[1.7.4.5],
-  link:RelNotes/1.7.4.4.txt[1.7.4.4],
-  link:RelNotes/1.7.4.3.txt[1.7.4.3],
-  link:RelNotes/1.7.4.2.txt[1.7.4.2],
-  link:RelNotes/1.7.4.1.txt[1.7.4.1],
-  link:RelNotes/1.7.4.txt[1.7.4].
-
-* link:v1.7.3.5/git.html[documentation for release 1.7.3.5]
-
-* release notes for
-  link:RelNotes/1.7.3.5.txt[1.7.3.5],
-  link:RelNotes/1.7.3.4.txt[1.7.3.4],
-  link:RelNotes/1.7.3.3.txt[1.7.3.3],
-  link:RelNotes/1.7.3.2.txt[1.7.3.2],
-  link:RelNotes/1.7.3.1.txt[1.7.3.1],
-  link:RelNotes/1.7.3.txt[1.7.3].
-
-* link:v1.7.2.5/git.html[documentation for release 1.7.2.5]
-
-* release notes for
-  link:RelNotes/1.7.2.5.txt[1.7.2.5],
-  link:RelNotes/1.7.2.4.txt[1.7.2.4],
-  link:RelNotes/1.7.2.3.txt[1.7.2.3],
-  link:RelNotes/1.7.2.2.txt[1.7.2.2],
-  link:RelNotes/1.7.2.1.txt[1.7.2.1],
-  link:RelNotes/1.7.2.txt[1.7.2].
-
-* link:v1.7.1.4/git.html[documentation for release 1.7.1.4]
-
-* release notes for
-  link:RelNotes/1.7.1.4.txt[1.7.1.4],
-  link:RelNotes/1.7.1.3.txt[1.7.1.3],
-  link:RelNotes/1.7.1.2.txt[1.7.1.2],
-  link:RelNotes/1.7.1.1.txt[1.7.1.1],
-  link:RelNotes/1.7.1.txt[1.7.1].
-
-* link:v1.7.0.9/git.html[documentation for release 1.7.0.9]
-
-* release notes for
-  link:RelNotes/1.7.0.9.txt[1.7.0.9],
-  link:RelNotes/1.7.0.8.txt[1.7.0.8],
-  link:RelNotes/1.7.0.7.txt[1.7.0.7],
-  link:RelNotes/1.7.0.6.txt[1.7.0.6],
-  link:RelNotes/1.7.0.5.txt[1.7.0.5],
-  link:RelNotes/1.7.0.4.txt[1.7.0.4],
-  link:RelNotes/1.7.0.3.txt[1.7.0.3],
-  link:RelNotes/1.7.0.2.txt[1.7.0.2],
-  link:RelNotes/1.7.0.1.txt[1.7.0.1],
-  link:RelNotes/1.7.0.txt[1.7.0].
-
-* link:v1.6.6.3/git.html[documentation for release 1.6.6.3]
-
-* release notes for
-  link:RelNotes/1.6.6.3.txt[1.6.6.3],
-  link:RelNotes/1.6.6.2.txt[1.6.6.2],
-  link:RelNotes/1.6.6.1.txt[1.6.6.1],
-  link:RelNotes/1.6.6.txt[1.6.6].
-
-* link:v1.6.5.9/git.html[documentation for release 1.6.5.9]
-
-* release notes for
-  link:RelNotes/1.6.5.9.txt[1.6.5.9],
-  link:RelNotes/1.6.5.8.txt[1.6.5.8],
-  link:RelNotes/1.6.5.7.txt[1.6.5.7],
-  link:RelNotes/1.6.5.6.txt[1.6.5.6],
-  link:RelNotes/1.6.5.5.txt[1.6.5.5],
-  link:RelNotes/1.6.5.4.txt[1.6.5.4],
-  link:RelNotes/1.6.5.3.txt[1.6.5.3],
-  link:RelNotes/1.6.5.2.txt[1.6.5.2],
-  link:RelNotes/1.6.5.1.txt[1.6.5.1],
-  link:RelNotes/1.6.5.txt[1.6.5].
-
-* link:v1.6.4.5/git.html[documentation for release 1.6.4.5]
-
-* release notes for
-  link:RelNotes/1.6.4.5.txt[1.6.4.5],
-  link:RelNotes/1.6.4.4.txt[1.6.4.4],
-  link:RelNotes/1.6.4.3.txt[1.6.4.3],
-  link:RelNotes/1.6.4.2.txt[1.6.4.2],
-  link:RelNotes/1.6.4.1.txt[1.6.4.1],
-  link:RelNotes/1.6.4.txt[1.6.4].
-
-* link:v1.6.3.4/git.html[documentation for release 1.6.3.4]
-
-* release notes for
-  link:RelNotes/1.6.3.4.txt[1.6.3.4],
-  link:RelNotes/1.6.3.3.txt[1.6.3.3],
-  link:RelNotes/1.6.3.2.txt[1.6.3.2],
-  link:RelNotes/1.6.3.1.txt[1.6.3.1],
-  link:RelNotes/1.6.3.txt[1.6.3].
-
-* release notes for
-  link:RelNotes/1.6.2.5.txt[1.6.2.5],
-  link:RelNotes/1.6.2.4.txt[1.6.2.4],
-  link:RelNotes/1.6.2.3.txt[1.6.2.3],
-  link:RelNotes/1.6.2.2.txt[1.6.2.2],
-  link:RelNotes/1.6.2.1.txt[1.6.2.1],
-  link:RelNotes/1.6.2.txt[1.6.2].
-
-* link:v1.6.1.3/git.html[documentation for release 1.6.1.3]
-
-* release notes for
-  link:RelNotes/1.6.1.3.txt[1.6.1.3],
-  link:RelNotes/1.6.1.2.txt[1.6.1.2],
-  link:RelNotes/1.6.1.1.txt[1.6.1.1],
-  link:RelNotes/1.6.1.txt[1.6.1].
-
-* link:v1.6.0.6/git.html[documentation for release 1.6.0.6]
-
-* release notes for
-  link:RelNotes/1.6.0.6.txt[1.6.0.6],
-  link:RelNotes/1.6.0.5.txt[1.6.0.5],
-  link:RelNotes/1.6.0.4.txt[1.6.0.4],
-  link:RelNotes/1.6.0.3.txt[1.6.0.3],
-  link:RelNotes/1.6.0.2.txt[1.6.0.2],
-  link:RelNotes/1.6.0.1.txt[1.6.0.1],
-  link:RelNotes/1.6.0.txt[1.6.0].
-
-* link:v1.5.6.6/git.html[documentation for release 1.5.6.6]
-
-* release notes for
-  link:RelNotes/1.5.6.6.txt[1.5.6.6],
-  link:RelNotes/1.5.6.5.txt[1.5.6.5],
-  link:RelNotes/1.5.6.4.txt[1.5.6.4],
-  link:RelNotes/1.5.6.3.txt[1.5.6.3],
-  link:RelNotes/1.5.6.2.txt[1.5.6.2],
-  link:RelNotes/1.5.6.1.txt[1.5.6.1],
-  link:RelNotes/1.5.6.txt[1.5.6].
-
-* link:v1.5.5.6/git.html[documentation for release 1.5.5.6]
-
-* release notes for
-  link:RelNotes/1.5.5.6.txt[1.5.5.6],
-  link:RelNotes/1.5.5.5.txt[1.5.5.5],
-  link:RelNotes/1.5.5.4.txt[1.5.5.4],
-  link:RelNotes/1.5.5.3.txt[1.5.5.3],
-  link:RelNotes/1.5.5.2.txt[1.5.5.2],
-  link:RelNotes/1.5.5.1.txt[1.5.5.1],
-  link:RelNotes/1.5.5.txt[1.5.5].
-
-* link:v1.5.4.7/git.html[documentation for release 1.5.4.7]
-
-* release notes for
-  link:RelNotes/1.5.4.7.txt[1.5.4.7],
-  link:RelNotes/1.5.4.6.txt[1.5.4.6],
-  link:RelNotes/1.5.4.5.txt[1.5.4.5],
-  link:RelNotes/1.5.4.4.txt[1.5.4.4],
-  link:RelNotes/1.5.4.3.txt[1.5.4.3],
-  link:RelNotes/1.5.4.2.txt[1.5.4.2],
-  link:RelNotes/1.5.4.1.txt[1.5.4.1],
-  link:RelNotes/1.5.4.txt[1.5.4].
-
-* link:v1.5.3.8/git.html[documentation for release 1.5.3.8]
-
-* release notes for
-  link:RelNotes/1.5.3.8.txt[1.5.3.8],
-  link:RelNotes/1.5.3.7.txt[1.5.3.7],
-  link:RelNotes/1.5.3.6.txt[1.5.3.6],
-  link:RelNotes/1.5.3.5.txt[1.5.3.5],
-  link:RelNotes/1.5.3.4.txt[1.5.3.4],
-  link:RelNotes/1.5.3.3.txt[1.5.3.3],
-  link:RelNotes/1.5.3.2.txt[1.5.3.2],
-  link:RelNotes/1.5.3.1.txt[1.5.3.1],
-  link:RelNotes/1.5.3.txt[1.5.3].
-
-* link:v1.5.2.5/git.html[documentation for release 1.5.2.5]
-
-* release notes for
-  link:RelNotes/1.5.2.5.txt[1.5.2.5],
-  link:RelNotes/1.5.2.4.txt[1.5.2.4],
-  link:RelNotes/1.5.2.3.txt[1.5.2.3],
-  link:RelNotes/1.5.2.2.txt[1.5.2.2],
-  link:RelNotes/1.5.2.1.txt[1.5.2.1],
-  link:RelNotes/1.5.2.txt[1.5.2].
-
-* link:v1.5.1.6/git.html[documentation for release 1.5.1.6]
-
-* release notes for
-  link:RelNotes/1.5.1.6.txt[1.5.1.6],
-  link:RelNotes/1.5.1.5.txt[1.5.1.5],
-  link:RelNotes/1.5.1.4.txt[1.5.1.4],
-  link:RelNotes/1.5.1.3.txt[1.5.1.3],
-  link:RelNotes/1.5.1.2.txt[1.5.1.2],
-  link:RelNotes/1.5.1.1.txt[1.5.1.1],
-  link:RelNotes/1.5.1.txt[1.5.1].
-
-* link:v1.5.0.7/git.html[documentation for release 1.5.0.7]
-
-* release notes for
-  link:RelNotes/1.5.0.7.txt[1.5.0.7],
-  link:RelNotes/1.5.0.6.txt[1.5.0.6],
-  link:RelNotes/1.5.0.5.txt[1.5.0.5],
-  link:RelNotes/1.5.0.3.txt[1.5.0.3],
-  link:RelNotes/1.5.0.2.txt[1.5.0.2],
-  link:RelNotes/1.5.0.1.txt[1.5.0.1],
-  link:RelNotes/1.5.0.txt[1.5.0].
-
-* documentation for release link:v1.4.4.4/git.html[1.4.4.4],
-  link:v1.3.3/git.html[1.3.3],
-  link:v1.2.6/git.html[1.2.6],
-  link:v1.0.13/git.html[1.0.13].
-
-============
-
-endif::stalenotes[]
+include::stalenotes.txt[]
 
 OPTIONS
 -------
diff --git a/Documentation/stalenotes.txt b/Documentation/stalenotes.txt
new file mode 100644
index 0000000..d242950
--- /dev/null
+++ b/Documentation/stalenotes.txt
@@ -0,0 +1,344 @@
+ifdef::stalenotes[]
+[NOTE]
+============
+
+You are reading the documentation for the latest (possibly
+unreleased) version of Git, that is available from 'master'
+branch of the `git.git` repository.
+Documentation for older releases are available here:
+
+* link:v1.8.4/git.html[documentation for release 1.8.4]
+
+* release notes for
+  link:RelNotes/1.8.4.txt[1.8.4].
+
+* link:v1.8.3.4/git.html[documentation for release 1.8.3.4]
+
+* release notes for
+  link:RelNotes/1.8.3.4.txt[1.8.3.4],
+  link:RelNotes/1.8.3.3.txt[1.8.3.3],
+  link:RelNotes/1.8.3.2.txt[1.8.3.2],
+  link:RelNotes/1.8.3.1.txt[1.8.3.1],
+  link:RelNotes/1.8.3.txt[1.8.3].
+
+* link:v1.8.2.3/git.html[documentation for release 1.8.2.3]
+
+* release notes for
+  link:RelNotes/1.8.2.3.txt[1.8.2.3],
+  link:RelNotes/1.8.2.2.txt[1.8.2.2],
+  link:RelNotes/1.8.2.1.txt[1.8.2.1],
+  link:RelNotes/1.8.2.txt[1.8.2].
+
+* link:v1.8.1.6/git.html[documentation for release 1.8.1.6]
+
+* release notes for
+  link:RelNotes/1.8.1.6.txt[1.8.1.6],
+  link:RelNotes/1.8.1.5.txt[1.8.1.5],
+  link:RelNotes/1.8.1.4.txt[1.8.1.4],
+  link:RelNotes/1.8.1.3.txt[1.8.1.3],
+  link:RelNotes/1.8.1.2.txt[1.8.1.2],
+  link:RelNotes/1.8.1.1.txt[1.8.1.1],
+  link:RelNotes/1.8.1.txt[1.8.1].
+
+* link:v1.8.0.3/git.html[documentation for release 1.8.0.3]
+
+* release notes for
+  link:RelNotes/1.8.0.3.txt[1.8.0.3],
+  link:RelNotes/1.8.0.2.txt[1.8.0.2],
+  link:RelNotes/1.8.0.1.txt[1.8.0.1],
+  link:RelNotes/1.8.0.txt[1.8.0].
+
+* link:v1.7.12.4/git.html[documentation for release 1.7.12.4]
+
+* release notes for
+  link:RelNotes/1.7.12.4.txt[1.7.12.4],
+  link:RelNotes/1.7.12.3.txt[1.7.12.3],
+  link:RelNotes/1.7.12.2.txt[1.7.12.2],
+  link:RelNotes/1.7.12.1.txt[1.7.12.1],
+  link:RelNotes/1.7.12.txt[1.7.12].
+
+* link:v1.7.11.7/git.html[documentation for release 1.7.11.7]
+
+* release notes for
+  link:RelNotes/1.7.11.7.txt[1.7.11.7],
+  link:RelNotes/1.7.11.6.txt[1.7.11.6],
+  link:RelNotes/1.7.11.5.txt[1.7.11.5],
+  link:RelNotes/1.7.11.4.txt[1.7.11.4],
+  link:RelNotes/1.7.11.3.txt[1.7.11.3],
+  link:RelNotes/1.7.11.2.txt[1.7.11.2],
+  link:RelNotes/1.7.11.1.txt[1.7.11.1],
+  link:RelNotes/1.7.11.txt[1.7.11].
+
+* link:v1.7.10.5/git.html[documentation for release 1.7.10.5]
+
+* release notes for
+  link:RelNotes/1.7.10.5.txt[1.7.10.5],
+  link:RelNotes/1.7.10.4.txt[1.7.10.4],
+  link:RelNotes/1.7.10.3.txt[1.7.10.3],
+  link:RelNotes/1.7.10.2.txt[1.7.10.2],
+  link:RelNotes/1.7.10.1.txt[1.7.10.1],
+  link:RelNotes/1.7.10.txt[1.7.10].
+
+* link:v1.7.9.7/git.html[documentation for release 1.7.9.7]
+
+* release notes for
+  link:RelNotes/1.7.9.7.txt[1.7.9.7],
+  link:RelNotes/1.7.9.6.txt[1.7.9.6],
+  link:RelNotes/1.7.9.5.txt[1.7.9.5],
+  link:RelNotes/1.7.9.4.txt[1.7.9.4],
+  link:RelNotes/1.7.9.3.txt[1.7.9.3],
+  link:RelNotes/1.7.9.2.txt[1.7.9.2],
+  link:RelNotes/1.7.9.1.txt[1.7.9.1],
+  link:RelNotes/1.7.9.txt[1.7.9].
+
+* link:v1.7.8.6/git.html[documentation for release 1.7.8.6]
+
+* release notes for
+  link:RelNotes/1.7.8.6.txt[1.7.8.6],
+  link:RelNotes/1.7.8.5.txt[1.7.8.5],
+  link:RelNotes/1.7.8.4.txt[1.7.8.4],
+  link:RelNotes/1.7.8.3.txt[1.7.8.3],
+  link:RelNotes/1.7.8.2.txt[1.7.8.2],
+  link:RelNotes/1.7.8.1.txt[1.7.8.1],
+  link:RelNotes/1.7.8.txt[1.7.8].
+
+* link:v1.7.7.7/git.html[documentation for release 1.7.7.7]
+
+* release notes for
+  link:RelNotes/1.7.7.7.txt[1.7.7.7],
+  link:RelNotes/1.7.7.6.txt[1.7.7.6],
+  link:RelNotes/1.7.7.5.txt[1.7.7.5],
+  link:RelNotes/1.7.7.4.txt[1.7.7.4],
+  link:RelNotes/1.7.7.3.txt[1.7.7.3],
+  link:RelNotes/1.7.7.2.txt[1.7.7.2],
+  link:RelNotes/1.7.7.1.txt[1.7.7.1],
+  link:RelNotes/1.7.7.txt[1.7.7].
+
+* link:v1.7.6.6/git.html[documentation for release 1.7.6.6]
+
+* release notes for
+  link:RelNotes/1.7.6.6.txt[1.7.6.6],
+  link:RelNotes/1.7.6.5.txt[1.7.6.5],
+  link:RelNotes/1.7.6.4.txt[1.7.6.4],
+  link:RelNotes/1.7.6.3.txt[1.7.6.3],
+  link:RelNotes/1.7.6.2.txt[1.7.6.2],
+  link:RelNotes/1.7.6.1.txt[1.7.6.1],
+  link:RelNotes/1.7.6.txt[1.7.6].
+
+* link:v1.7.5.4/git.html[documentation for release 1.7.5.4]
+
+* release notes for
+  link:RelNotes/1.7.5.4.txt[1.7.5.4],
+  link:RelNotes/1.7.5.3.txt[1.7.5.3],
+  link:RelNotes/1.7.5.2.txt[1.7.5.2],
+  link:RelNotes/1.7.5.1.txt[1.7.5.1],
+  link:RelNotes/1.7.5.txt[1.7.5].
+
+* link:v1.7.4.5/git.html[documentation for release 1.7.4.5]
+
+* release notes for
+  link:RelNotes/1.7.4.5.txt[1.7.4.5],
+  link:RelNotes/1.7.4.4.txt[1.7.4.4],
+  link:RelNotes/1.7.4.3.txt[1.7.4.3],
+  link:RelNotes/1.7.4.2.txt[1.7.4.2],
+  link:RelNotes/1.7.4.1.txt[1.7.4.1],
+  link:RelNotes/1.7.4.txt[1.7.4].
+
+* link:v1.7.3.5/git.html[documentation for release 1.7.3.5]
+
+* release notes for
+  link:RelNotes/1.7.3.5.txt[1.7.3.5],
+  link:RelNotes/1.7.3.4.txt[1.7.3.4],
+  link:RelNotes/1.7.3.3.txt[1.7.3.3],
+  link:RelNotes/1.7.3.2.txt[1.7.3.2],
+  link:RelNotes/1.7.3.1.txt[1.7.3.1],
+  link:RelNotes/1.7.3.txt[1.7.3].
+
+* link:v1.7.2.5/git.html[documentation for release 1.7.2.5]
+
+* release notes for
+  link:RelNotes/1.7.2.5.txt[1.7.2.5],
+  link:RelNotes/1.7.2.4.txt[1.7.2.4],
+  link:RelNotes/1.7.2.3.txt[1.7.2.3],
+  link:RelNotes/1.7.2.2.txt[1.7.2.2],
+  link:RelNotes/1.7.2.1.txt[1.7.2.1],
+  link:RelNotes/1.7.2.txt[1.7.2].
+
+* link:v1.7.1.4/git.html[documentation for release 1.7.1.4]
+
+* release notes for
+  link:RelNotes/1.7.1.4.txt[1.7.1.4],
+  link:RelNotes/1.7.1.3.txt[1.7.1.3],
+  link:RelNotes/1.7.1.2.txt[1.7.1.2],
+  link:RelNotes/1.7.1.1.txt[1.7.1.1],
+  link:RelNotes/1.7.1.txt[1.7.1].
+
+* link:v1.7.0.9/git.html[documentation for release 1.7.0.9]
+
+* release notes for
+  link:RelNotes/1.7.0.9.txt[1.7.0.9],
+  link:RelNotes/1.7.0.8.txt[1.7.0.8],
+  link:RelNotes/1.7.0.7.txt[1.7.0.7],
+  link:RelNotes/1.7.0.6.txt[1.7.0.6],
+  link:RelNotes/1.7.0.5.txt[1.7.0.5],
+  link:RelNotes/1.7.0.4.txt[1.7.0.4],
+  link:RelNotes/1.7.0.3.txt[1.7.0.3],
+  link:RelNotes/1.7.0.2.txt[1.7.0.2],
+  link:RelNotes/1.7.0.1.txt[1.7.0.1],
+  link:RelNotes/1.7.0.txt[1.7.0].
+
+* link:v1.6.6.3/git.html[documentation for release 1.6.6.3]
+
+* release notes for
+  link:RelNotes/1.6.6.3.txt[1.6.6.3],
+  link:RelNotes/1.6.6.2.txt[1.6.6.2],
+  link:RelNotes/1.6.6.1.txt[1.6.6.1],
+  link:RelNotes/1.6.6.txt[1.6.6].
+
+* link:v1.6.5.9/git.html[documentation for release 1.6.5.9]
+
+* release notes for
+  link:RelNotes/1.6.5.9.txt[1.6.5.9],
+  link:RelNotes/1.6.5.8.txt[1.6.5.8],
+  link:RelNotes/1.6.5.7.txt[1.6.5.7],
+  link:RelNotes/1.6.5.6.txt[1.6.5.6],
+  link:RelNotes/1.6.5.5.txt[1.6.5.5],
+  link:RelNotes/1.6.5.4.txt[1.6.5.4],
+  link:RelNotes/1.6.5.3.txt[1.6.5.3],
+  link:RelNotes/1.6.5.2.txt[1.6.5.2],
+  link:RelNotes/1.6.5.1.txt[1.6.5.1],
+  link:RelNotes/1.6.5.txt[1.6.5].
+
+* link:v1.6.4.5/git.html[documentation for release 1.6.4.5]
+
+* release notes for
+  link:RelNotes/1.6.4.5.txt[1.6.4.5],
+  link:RelNotes/1.6.4.4.txt[1.6.4.4],
+  link:RelNotes/1.6.4.3.txt[1.6.4.3],
+  link:RelNotes/1.6.4.2.txt[1.6.4.2],
+  link:RelNotes/1.6.4.1.txt[1.6.4.1],
+  link:RelNotes/1.6.4.txt[1.6.4].
+
+* link:v1.6.3.4/git.html[documentation for release 1.6.3.4]
+
+* release notes for
+  link:RelNotes/1.6.3.4.txt[1.6.3.4],
+  link:RelNotes/1.6.3.3.txt[1.6.3.3],
+  link:RelNotes/1.6.3.2.txt[1.6.3.2],
+  link:RelNotes/1.6.3.1.txt[1.6.3.1],
+  link:RelNotes/1.6.3.txt[1.6.3].
+
+* release notes for
+  link:RelNotes/1.6.2.5.txt[1.6.2.5],
+  link:RelNotes/1.6.2.4.txt[1.6.2.4],
+  link:RelNotes/1.6.2.3.txt[1.6.2.3],
+  link:RelNotes/1.6.2.2.txt[1.6.2.2],
+  link:RelNotes/1.6.2.1.txt[1.6.2.1],
+  link:RelNotes/1.6.2.txt[1.6.2].
+
+* link:v1.6.1.3/git.html[documentation for release 1.6.1.3]
+
+* release notes for
+  link:RelNotes/1.6.1.3.txt[1.6.1.3],
+  link:RelNotes/1.6.1.2.txt[1.6.1.2],
+  link:RelNotes/1.6.1.1.txt[1.6.1.1],
+  link:RelNotes/1.6.1.txt[1.6.1].
+
+* link:v1.6.0.6/git.html[documentation for release 1.6.0.6]
+
+* release notes for
+  link:RelNotes/1.6.0.6.txt[1.6.0.6],
+  link:RelNotes/1.6.0.5.txt[1.6.0.5],
+  link:RelNotes/1.6.0.4.txt[1.6.0.4],
+  link:RelNotes/1.6.0.3.txt[1.6.0.3],
+  link:RelNotes/1.6.0.2.txt[1.6.0.2],
+  link:RelNotes/1.6.0.1.txt[1.6.0.1],
+  link:RelNotes/1.6.0.txt[1.6.0].
+
+* link:v1.5.6.6/git.html[documentation for release 1.5.6.6]
+
+* release notes for
+  link:RelNotes/1.5.6.6.txt[1.5.6.6],
+  link:RelNotes/1.5.6.5.txt[1.5.6.5],
+  link:RelNotes/1.5.6.4.txt[1.5.6.4],
+  link:RelNotes/1.5.6.3.txt[1.5.6.3],
+  link:RelNotes/1.5.6.2.txt[1.5.6.2],
+  link:RelNotes/1.5.6.1.txt[1.5.6.1],
+  link:RelNotes/1.5.6.txt[1.5.6].
+
+* link:v1.5.5.6/git.html[documentation for release 1.5.5.6]
+
+* release notes for
+  link:RelNotes/1.5.5.6.txt[1.5.5.6],
+  link:RelNotes/1.5.5.5.txt[1.5.5.5],
+  link:RelNotes/1.5.5.4.txt[1.5.5.4],
+  link:RelNotes/1.5.5.3.txt[1.5.5.3],
+  link:RelNotes/1.5.5.2.txt[1.5.5.2],
+  link:RelNotes/1.5.5.1.txt[1.5.5.1],
+  link:RelNotes/1.5.5.txt[1.5.5].
+
+* link:v1.5.4.7/git.html[documentation for release 1.5.4.7]
+
+* release notes for
+  link:RelNotes/1.5.4.7.txt[1.5.4.7],
+  link:RelNotes/1.5.4.6.txt[1.5.4.6],
+  link:RelNotes/1.5.4.5.txt[1.5.4.5],
+  link:RelNotes/1.5.4.4.txt[1.5.4.4],
+  link:RelNotes/1.5.4.3.txt[1.5.4.3],
+  link:RelNotes/1.5.4.2.txt[1.5.4.2],
+  link:RelNotes/1.5.4.1.txt[1.5.4.1],
+  link:RelNotes/1.5.4.txt[1.5.4].
+
+* link:v1.5.3.8/git.html[documentation for release 1.5.3.8]
+
+* release notes for
+  link:RelNotes/1.5.3.8.txt[1.5.3.8],
+  link:RelNotes/1.5.3.7.txt[1.5.3.7],
+  link:RelNotes/1.5.3.6.txt[1.5.3.6],
+  link:RelNotes/1.5.3.5.txt[1.5.3.5],
+  link:RelNotes/1.5.3.4.txt[1.5.3.4],
+  link:RelNotes/1.5.3.3.txt[1.5.3.3],
+  link:RelNotes/1.5.3.2.txt[1.5.3.2],
+  link:RelNotes/1.5.3.1.txt[1.5.3.1],
+  link:RelNotes/1.5.3.txt[1.5.3].
+
+* link:v1.5.2.5/git.html[documentation for release 1.5.2.5]
+
+* release notes for
+  link:RelNotes/1.5.2.5.txt[1.5.2.5],
+  link:RelNotes/1.5.2.4.txt[1.5.2.4],
+  link:RelNotes/1.5.2.3.txt[1.5.2.3],
+  link:RelNotes/1.5.2.2.txt[1.5.2.2],
+  link:RelNotes/1.5.2.1.txt[1.5.2.1],
+  link:RelNotes/1.5.2.txt[1.5.2].
+
+* link:v1.5.1.6/git.html[documentation for release 1.5.1.6]
+
+* release notes for
+  link:RelNotes/1.5.1.6.txt[1.5.1.6],
+  link:RelNotes/1.5.1.5.txt[1.5.1.5],
+  link:RelNotes/1.5.1.4.txt[1.5.1.4],
+  link:RelNotes/1.5.1.3.txt[1.5.1.3],
+  link:RelNotes/1.5.1.2.txt[1.5.1.2],
+  link:RelNotes/1.5.1.1.txt[1.5.1.1],
+  link:RelNotes/1.5.1.txt[1.5.1].
+
+* link:v1.5.0.7/git.html[documentation for release 1.5.0.7]
+
+* release notes for
+  link:RelNotes/1.5.0.7.txt[1.5.0.7],
+  link:RelNotes/1.5.0.6.txt[1.5.0.6],
+  link:RelNotes/1.5.0.5.txt[1.5.0.5],
+  link:RelNotes/1.5.0.3.txt[1.5.0.3],
+  link:RelNotes/1.5.0.2.txt[1.5.0.2],
+  link:RelNotes/1.5.0.1.txt[1.5.0.1],
+  link:RelNotes/1.5.0.txt[1.5.0].
+
+* documentation for release link:v1.4.4.4/git.html[1.4.4.4],
+  link:v1.3.3/git.html[1.3.3],
+  link:v1.2.6/git.html[1.2.6],
+  link:v1.0.13/git.html[1.0.13].
+
+============
+
+endif::stalenotes[]
-- 
1.8.4.rc3.19.g9da5bf6
