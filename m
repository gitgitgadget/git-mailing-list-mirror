From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] show-branch: use DATE_RELATIVE instead of magic number
Date: Thu, 25 Jun 2015 12:54:31 -0400
Message-ID: <20150625165430.GA23503@peff.net>
References: <20150625165341.GA21949@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:54:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8AQG-0002Bc-FZ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 18:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbbFYQyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 12:54:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:51763 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751978AbbFYQye (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 12:54:34 -0400
Received: (qmail 19845 invoked by uid 102); 25 Jun 2015 16:54:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 11:54:33 -0500
Received: (qmail 8171 invoked by uid 107); 25 Jun 2015 16:54:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 12:54:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jun 2015 12:54:31 -0400
Content-Disposition: inline
In-Reply-To: <20150625165341.GA21949@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272696>

This is more readable, and won't break if we ever change the
order of the date_mode enum.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/show-branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 323f857..d784613 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -784,7 +784,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			else
 				msg++;
 			reflog_msg[i] = xstrfmt("(%s) %s",
-						show_date(timestamp, tz, 1),
+						show_date(timestamp, tz, DATE_RELATIVE),
 						msg);
 			free(logmsg);
 			sprintf(nth_desc, "%s@{%d}", *av, base+i);
-- 
2.4.4.742.g862750c
