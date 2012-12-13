From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] mailmap: support reading mailmap from blobs
Date: Thu, 13 Dec 2012 08:08:12 -0500
Message-ID: <20121213130812.GA4900@sigill.intra.peff.net>
References: <20121212105822.GA15842@sigill.intra.peff.net>
 <20121212110404.GB19653@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 14:08:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tj8Wd-0005SF-Sc
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 14:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab2LMNIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 08:08:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48577 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754792Ab2LMNIO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 08:08:14 -0500
Received: (qmail 3846 invoked by uid 107); 13 Dec 2012 13:09:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Dec 2012 08:09:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Dec 2012 08:08:12 -0500
Content-Disposition: inline
In-Reply-To: <20121212110404.GB19653@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211451>

On Wed, Dec 12, 2012 at 06:04:04AM -0500, Jeff King wrote:

> In a bare repository, there isn't a simple way to respect an
> in-tree mailmap without extracting it to a temporary file.
> This patch provides a config variable, similar to
> mailmap.file, which reads the mailmap from a blob in the
> repository.

While preparing the "default mailmap.blob" patch, I noticed a few loose
ends in the documentation. They can be squashed into this 2/2
(jk/mailmap-from-blob~1), or can go on top of the series:

-- >8 --
Subject: [PATCH] fix some documentation loose-ends for mailmap.blob

Anywhere we mention mailmap.file, it is probably worth
mentioning mailmap.blob, as well.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-log.txt | 2 +-
 Documentation/mailmap.txt | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 585dac4..08a185d 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -167,7 +167,7 @@ log.showroot::
 	`git log -p` output would be shown without a diff attached.
 	The default is `true`.
 
-mailmap.file::
+mailmap.*::
 	See linkgit:git-shortlog[1].
 
 notes.displayRef::
diff --git a/Documentation/mailmap.txt b/Documentation/mailmap.txt
index 288f04e..bb349c2 100644
--- a/Documentation/mailmap.txt
+++ b/Documentation/mailmap.txt
@@ -1,5 +1,6 @@ If the file `.mailmap` exists at the toplevel of the repository, or at
 If the file `.mailmap` exists at the toplevel of the repository, or at
-the location pointed to by the mailmap.file configuration option, it
+the location pointed to by the mailmap.file or mailmap.blob
+configuration options, it
 is used to map author and committer names and email addresses to
 canonical real names and email addresses.
 
-- 
1.8.0.2.4.g59402aa
