From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] make copy_ref globally available
Date: Tue, 7 Jun 2011 19:03:03 -0400
Message-ID: <20110607230302.GA23753@sigill.intra.peff.net>
References: <20110607230013.GA23409@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 01:03:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU5In-0005ia-Sx
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 01:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758910Ab1FGXDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 19:03:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46800
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab1FGXDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 19:03:06 -0400
Received: (qmail 23081 invoked by uid 107); 7 Jun 2011 23:03:12 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 19:03:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 19:03:03 -0400
Content-Disposition: inline
In-Reply-To: <20110607230013.GA23409@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175279>

This is a useful function, and we have already made the
similar alloc_ref and copy_ref_list available.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c |    2 +-
 remote.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index f073b1e..b8ecfa5 100644
--- a/remote.c
+++ b/remote.c
@@ -896,7 +896,7 @@ struct ref *alloc_ref(const char *name)
 	return alloc_ref_with_prefix("", 0, name);
 }
 
-static struct ref *copy_ref(const struct ref *ref)
+struct ref *copy_ref(const struct ref *ref)
 {
 	struct ref *cpy;
 	size_t len;
diff --git a/remote.h b/remote.h
index 888d7c1..9a30a9d 100644
--- a/remote.h
+++ b/remote.h
@@ -70,7 +70,7 @@ struct refspec {
 extern const struct refspec *tag_refspec;
 
 struct ref *alloc_ref(const char *name);
-
+struct ref *copy_ref(const struct ref *ref);
 struct ref *copy_ref_list(const struct ref *ref);
 
 int check_ref_type(const struct ref *ref, int flags);
-- 
1.7.6.rc0.39.g6b091.dirty
