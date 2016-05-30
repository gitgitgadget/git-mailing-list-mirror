From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/13] do_for_each_ref(): move docstring to the header file
Date: Mon, 30 May 2016 09:55:23 +0200
Message-ID: <39f17243f5f85aab5eaa1f8355929027e20fcb74.1464537050.git.mhagger@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 30 09:55:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7I3H-0001Aa-Bm
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 09:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbcE3Hzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 03:55:52 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53201 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753827AbcE3Hzu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 03:55:50 -0400
X-AuditID: 1207440f-8a7ff700000008e4-e8-574bf2055b76
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id B8.0D.02276.502FB475; Mon, 30 May 2016 03:55:49 -0400 (EDT)
Received: from michael.fritz.box (p508EADDB.dip0.t-ipconnect.de [80.142.173.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4U7tgRr032144
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2016 03:55:48 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464537050.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqMv6yTvcYHqHpsX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgd2Dz+vv/A5LFz1l12j2e9exg9Ll5S9ljw/D67x+dNcgFs
	Udw2SYklZcGZ6Xn6dgncGdv2b2IteM1f8fjiM9YGxk88XYwcHBICJhLbbrJ0MXJxCAlsZZSY
	d/IEM4Rzkkli5dxFjF2MnBxsAroSi3qamUBsEYEIiYZXLYwgRcwC+xglTq6bzwKSEBbwljj8
	8zpYA4uAqsTPk4fBbF6BKInuTXtYQWwJATmJy9MfsIHYnAIWEhNnvQMbKiRgLrFs5knmCYw8
	CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmKEBBT/Dsau9TKHGAU4GJV4
	eAs0vcOFWBPLiitzDzFKcjApifK6cQCF+JLyUyozEosz4otKc1KLDzFKcDArifC+fQyU401J
	rKxKLcqHSUlzsCiJ86ovUfcTEkhPLEnNTk0tSC2CycpwcChJ8Ap/BGoULEpNT61Iy8wpQUgz
	cXCCDOeSEilOzUtJLUosLcmIB8VAfDEwCkBSPEB7938A2VtckJgLFIVoPcWoy3Fk/721TEIs
	efl5qVLivPYgRQIgRRmleXArYOnjFaM40MfCvK4gl/AAUw/cpFdAS5iAlpid8wJZUpKIkJJq
	YAz+dDI25ojnxldtR85wmqq+cjslf+HBi1vTxRZc/uKx/FVK9tEfStvmLXvwp551tQ/rrr/Z
	8zgcHnwJenBataRK7KjWjdxHHzZ1T+Gfeksu/JDOKvW8YuXKqXzrj9h/lGxPU90V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295856>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c |  9 ---------
 refs/refs-internal.h | 10 +++++++++-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1230dfb..68db3e8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1878,15 +1878,6 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
 	return retval;
 }
 
-/*
- * Call fn for each reference in the specified ref_cache for which the
- * refname begins with base.  If trim is non-zero, then trim that many
- * characters off the beginning of each refname before passing the
- * refname to fn.  flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
- * broken references in the iteration.  If fn ever returns a non-zero
- * value, stop the iteration and return that value; otherwise, return
- * 0.
- */
 int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data)
 {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 1bb3d87..b4dd545 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -249,7 +249,15 @@ int rename_ref_available(const char *oldname, const char *newname);
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
 /*
- * The common backend for the for_each_*ref* functions
+ * Call fn for each reference in the specified submodule for which the
+ * refname begins with base. If trim is non-zero, then trim that many
+ * characters off the beginning of each refname before passing the
+ * refname to fn. flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
+ * broken references in the iteration. If fn ever returns a non-zero
+ * value, stop the iteration and return that value; otherwise, return
+ * 0.
+ *
+ * This is the common backend for the for_each_*ref* functions.
  */
 int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
-- 
2.8.1
