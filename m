From: Jeff King <peff@peff.net>
Subject: Re: [REQUEST 1/1] docs: update http.<url>.* options documentation
Date: Fri, 26 Jul 2013 22:43:53 -0400
Message-ID: <20130727024353.GA19853@sigill.intra.peff.net>
References: <4b44f95a1b574b5d92a15254e4e8523@f74d39fa044aa309eaea14b9f57fe79>
 <ec5ecd4fe44af87e83778ce8e297afe@f74d39fa044aa309eaea14b9f57fe79>
 <20130726043748.GA20286@sigill.intra.peff.net>
 <0A68F4A5-22B0-4629-8693-73258566E218@gmail.com>
 <20130726222732.GA3444@sigill.intra.peff.net>
 <251106F7-56FA-4503-A4C9-267A5EF04A2C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 04:44:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2uUY-000496-2S
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 04:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230Ab3G0Cn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 22:43:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:34630 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983Ab3G0Cn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 22:43:56 -0400
Received: (qmail 32046 invoked by uid 102); 27 Jul 2013 02:43:55 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 21:43:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 22:43:53 -0400
Content-Disposition: inline
In-Reply-To: <251106F7-56FA-4503-A4C9-267A5EF04A2C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231223>

On Fri, Jul 26, 2013 at 07:15:07PM -0700, Kyle J. McKay wrote:

> So there's a version of this in next as cea9928 and I think that
> version is fine.  If the documentation gets updated in the future, or
> perhaps moved to a separate urls-matching.txt for some reason at some
> point (git config --url, git config --url-parse), I'll make a point
> of inserting the ", but at lower precedence than a config key with a
> user name" text.

Unless you are planning to do that immediately, we are very likely to
forget. Either it is worth adding or not, and if it is, we should not
let having to add one more commit stop us.

Here it is in patch form, so the amount of effort does not influence our
decision. :)

I'd lean towards including it, but don't feel strongly.

-- >8 --
Subject: [PATCH] docs: mention precedence of empty username matching in URLs

The documentation makes it clear that a URL with a username
will match a config entry with or without a username, but is
not clear that in the presence of both, the one with
username would be preferred.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0dd5566..f2ed9ef 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1568,7 +1568,8 @@ http.<url>.*::
 . User name (e.g., `user` in `https://user@example.com/repo.git`). If
   the config key has a user name it must match the user name in the
   URL exactly. If the config key does not have a user name, that
-  config key will match a URL with any user name (including none).
+  config key will match a URL with any user name (including none),
+  but at a lower precedence than a config key with a user name.
 --
 +
 The list above is ordered by decreasing precedence; a URL that matches
-- 
1.8.3.rc1.30.gff0fb75
