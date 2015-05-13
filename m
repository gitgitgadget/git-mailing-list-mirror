From: Jeff King <peff@peff.net>
Subject: [PATCH 2/8] doc: fix unquoted use of "{type}"
Date: Wed, 13 May 2015 00:58:06 -0400
Message-ID: <20150513045805.GB6821@peff.net>
References: <20150513045650.GA6070@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 06:58:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsOkH-0007RO-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 06:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbbEME6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 00:58:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:57600 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750787AbbEME6I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 00:58:08 -0400
Received: (qmail 1813 invoked by uid 102); 13 May 2015 04:58:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 23:58:08 -0500
Received: (qmail 6902 invoked by uid 107); 13 May 2015 04:58:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 00:58:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 00:58:06 -0400
Content-Disposition: inline
In-Reply-To: <20150513045650.GA6070@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268928>

Curly braces open an "attribute" in AsciiDoc; if there's no
such attribute, strange things may happen. In this case, the
unquoted "{type}" causes AsciiDoc to omit an entire line of
text from the output. We can fix it by putting the whole
phrase inside literal backticks (which also lets us get rid
of ugly backslash escaping).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-rev-parse.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 97fc703..52e6826 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -102,7 +102,7 @@ eval "set -- $(git rev-parse --sq --prefix "$prefix" "$@")"
 +
 If you want to make sure that the output actually names an object in
 your object database and/or can be used as a specific type of object
-you require, you can add "\^{type}" peeling operator to the parameter.
+you require, you can add the `^{type}` peeling operator to the parameter.
 For example, `git rev-parse "$VAR^{commit}"` will make sure `$VAR`
 names an existing object that is a commit-ish (i.e. a commit, or an
 annotated tag that points at a commit).  To make sure that `$VAR`
-- 
2.4.0.192.g5f8138b
