From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] diff: add missing static declaration
Date: Thu, 23 Oct 2008 22:48:59 -0400
Message-ID: <20081024024859.GA2831@coredump.intra.peff.net>
References: <20081024024631.GA20365@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 04:50:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtCkj-0003hs-J3
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 04:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbYJXCtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 22:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755262AbYJXCtE
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 22:49:04 -0400
Received: from peff.net ([208.65.91.99]:1611 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933AbYJXCtD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 22:49:03 -0400
Received: (qmail 12800 invoked by uid 111); 24 Oct 2008 02:49:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 23 Oct 2008 22:49:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Oct 2008 22:48:59 -0400
Content-Disposition: inline
In-Reply-To: <20081024024631.GA20365@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99000>

This function isn't used outside of diff.c; the 'static' was
simply overlooked in the original writing.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a cleanup.

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
1.6.0.3.518.gdb328.dirty
