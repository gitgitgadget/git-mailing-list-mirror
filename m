From: Jeff King <peff@peff.net>
Subject: [PATCH] git-config: better document default behavior for `--include`
Date: Mon, 19 Jan 2015 14:58:47 -0500
Message-ID: <20150119195847.GA8945@peff.net>
References: <54BD5CE6.2060309@garrison.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jim Garrison <jim@garrison.cc>
X-From: git-owner@vger.kernel.org Mon Jan 19 20:58:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDITQ-0007G0-BP
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 20:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbbAST6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 14:58:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:36143 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751473AbbAST6t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2015 14:58:49 -0500
Received: (qmail 3579 invoked by uid 102); 19 Jan 2015 19:58:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Jan 2015 13:58:49 -0600
Received: (qmail 15672 invoked by uid 107); 19 Jan 2015 19:59:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Jan 2015 14:59:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jan 2015 14:58:47 -0500
Content-Disposition: inline
In-Reply-To: <54BD5CE6.2060309@garrison.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262641>

On Mon, Jan 19, 2015 at 11:37:10AM -0800, Jim Garrison wrote:

> I have found that `git config --global` does not pick up any include
> directives in the git config file.

That's by design. You asked for the entries in a specific file, and we
do not follow any includes by default in that case. You can use
`--include` if you want to follow includes.

The documentation is quite misleading here, though. Here's a patch.

-- >8 --
Subject: git-config: better document default behavior for `--include`

As described in the commit message of 9b25a0b (config: add
include directive, 2012-02-06), the `--include` option is
only on by default in some cases. But our documentation
described it as just "defaults to on", which doesn't tell
the whole story.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-config.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 9dfa1a5..d42c062 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -215,7 +215,9 @@ See also <<FILES>>.
 
 --[no-]includes::
 	Respect `include.*` directives in config files when looking up
-	values. Defaults to on.
+	values. Defaults to `off` when a specific file is given (e.g.,
+	using `--file`, `--global`, etc) and `on` when searching all
+	config files.
 
 [[FILES]]
 FILES
-- 
2.2.1.425.g441bb3c
