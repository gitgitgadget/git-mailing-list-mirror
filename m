From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (May 2012, #01; Wed, 2)
Date: Wed, 2 May 2012 19:43:52 -0400
Message-ID: <20120502234352.GA2163@sigill.intra.peff.net>
References: <7vipgegrl0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 03 01:44:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPjDH-0006Ny-FR
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 01:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab2EBXn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 19:43:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55984
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab2EBXn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 19:43:58 -0400
Received: (qmail 29695 invoked by uid 107); 2 May 2012 23:44:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 May 2012 19:44:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 May 2012 19:43:52 -0400
Content-Disposition: inline
In-Reply-To: <7vipgegrl0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196871>

On Wed, May 02, 2012 at 03:12:43PM -0700, Junio C Hamano wrote:

> [Graduated to "master"]
> [...]
> * jk/doc-asciidoc-inline-literal (2012-04-26) 1 commit
>   (merged to 'next' on 2012-04-30 at a52b4e6)
>  + docs: stop using asciidoc no-inline-literal
> 
> Our documentation was written for an ancient version of AsciiDoc,
> making the source not very readable.

Now that this is in master, any in-flight topics would need their
documentation updated to match this, too. I checked:

  git diff jk/doc-asciidoc-inline-literal origin/pu Documentation

and found only one case.  We may still get some submissions based on the
old style, but now we are aware of the issue and can comment and correct
it during review.

This patch is for mm/include-userpath, which is in master already. And
it's only the right thing to do after the merge of
jk/doc-asciidoc-inline-literal, so really it should just go straight
into master.

-- >8 --
Subject: [PATCH] doc/config: fix inline literals

Since commit 6cf378f, asciidoc backticks are now inline
literals; therefore quoting {tilde} inside them is wrong
(this instance was missed in 6cf378f because it happened on
a parallel line of development).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e67c8ef..d575481 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -95,8 +95,8 @@ included file is expanded immediately, as if its contents had been
 found at the location of the include directive. If the value of the
 `include.path` variable is a relative path, the path is considered to be
 relative to the configuration file in which the include directive was
-found. The value of `include.path` is subject to tilde expansion: `{tilde}/`
-is expanded to the value of `$HOME`, and `{tilde}user/` to the specified
+found. The value of `include.path` is subject to tilde expansion: `~/`
+is expanded to the value of `$HOME`, and `~user/` to the specified
 user's home directory. See below for examples.
 
 Example
-- 
1.7.10.630.g31718
