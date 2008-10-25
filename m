From: Jeff King <peff@peff.net>
Subject: [PATCH 1/7] diff: add missing static declaration
Date: Fri, 24 Oct 2008 20:50:58 -0400
Message-ID: <20081025005058.GA23903@coredump.intra.peff.net>
References: <20081025004815.GA23851@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 02:52:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtXO4-0003ND-9I
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 02:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbYJYAvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 20:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbYJYAvB
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 20:51:01 -0400
Received: from peff.net ([208.65.91.99]:1772 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbYJYAvB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 20:51:01 -0400
Received: (qmail 25759 invoked by uid 111); 25 Oct 2008 00:50:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 20:50:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 20:50:58 -0400
Content-Disposition: inline
In-Reply-To: <20081025004815.GA23851@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99085>

This function isn't used outside of diff.c; the 'static' was
simply overlooked in the original writing.

Signed-off-by: Jeff King <peff@peff.net>
---
Oops, it is actually 7 patches. This one is the same as before.

 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index e368fef..d1fd594 100644
--- a/diff.c
+++ b/diff.c
@@ -1282,7 +1282,7 @@ static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two)
 	emit_binary_diff_body(file, two, one);
 }
 
-void diff_filespec_load_driver(struct diff_filespec *one)
+static void diff_filespec_load_driver(struct diff_filespec *one)
 {
 	if (!one->driver)
 		one->driver = userdiff_find_by_path(one->path);
-- 
1.6.0.3.523.g38597.dirty
