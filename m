From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git 1.7.0.rc1
Date: Sun, 31 Jan 2010 04:14:46 -0500
Message-ID: <20100131091446.GA25704@coredump.intra.peff.net>
References: <7vaavvi4r5.fsf@alter.siamese.dyndns.org>
 <20100131073208.GA15268@coredump.intra.peff.net>
 <7v8wbeg0qp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 10:14:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbVtP-0005If-1P
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 10:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532Ab0AaJOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 04:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484Ab0AaJOt
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 04:14:49 -0500
Received: from peff.net ([208.65.91.99]:49728 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384Ab0AaJOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 04:14:48 -0500
Received: (qmail 1836 invoked by uid 107); 31 Jan 2010 09:14:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 31 Jan 2010 04:14:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jan 2010 04:14:46 -0500
Content-Disposition: inline
In-Reply-To: <7v8wbeg0qp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138537>

On Sun, Jan 31, 2010 at 12:03:10AM -0800, Junio C Hamano wrote:

> Perhaps.  A patch with nice description, please?

How about this? We could also drop it from the "bells and whistles"
section; I don't have a preference.

-- >8 --
Subject: [PATCH] mention new shell execution behavior in release notes

This is already in the "bells and whistles" section, but it
also has a slight chance of breakage, so let's also mention
it in the "changed behaviors" section.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/RelNotes-1.7.0.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/RelNotes-1.7.0.txt b/Documentation/RelNotes-1.7.0.txt
index 997b026..f33e85d 100644
--- a/Documentation/RelNotes-1.7.0.txt
+++ b/Documentation/RelNotes-1.7.0.txt
@@ -38,6 +38,13 @@ Notes on behaviour change
    whitespaces is reported with zero exit status when run with
    --exit-code, and there is no "diff --git" header for such a change.
 
+ * external diff and textconv helpers are now executed using the shell.
+   This makes them consistent with other programs executed by git, and
+   allows you to pass command-line parameters to the helpers. Any helper
+   paths containing spaces or other metacharacters now need to be
+   shell-quoted.  The affected helpers are GIT_EXTERNAL_DIFF in the
+   environment, and diff.*.command and diff.*.textconv in the config
+   file.
 
 Updates since v1.6.6
 --------------------
-- 
1.7.0.rc1.8.g1a26
