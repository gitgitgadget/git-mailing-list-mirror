From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 01/25] refs: make is_branch public
Date: Tue,  3 Nov 2015 08:39:45 +0100
Message-ID: <39e0a2a708fb1a42b69e45bc5c0b17d565d3662e.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:40:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWCg-0007BW-Ng
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbbKCHkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:40:21 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:48275 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752671AbbKCHkS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:40:18 -0500
X-AuditID: 12074411-f797e6d000007df3-c5-563864e17851
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 2D.B5.32243.1E468365; Tue,  3 Nov 2015 02:40:17 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDcw016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:16 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqPswxSLM4P8mTov5m04wWnRd6Way
	aOi9wmxxe8V8Zot/E2ocWD3+vv/A5LFgU6nHxUvKHgue32f3+LxJLoA1itsmKbGkLDgzPU/f
	LoE7o2vJXvaCC2wVF65ZNDAeZO1i5OSQEDCRmHhwFzOELSZx4d56ti5GLg4hgcuMElP/XYZy
	jjFJrNr3HqyDTUBXYlFPMxOILSKgJjGx7RALSBGzwCJGiYdHtoMVCQuYSsx8AdHAIqAqsbR7
	GZjNKxAlMevsFxaIdXISU+63gw3iFLCQeHD3DzuILSRgLrHp3jK2CYy8CxgZVjHKJeaU5urm
	JmbmFKcm6xYnJ+blpRbpmurlZpbopaaUbmKEBJTgDsYZJ+UOMQpwMCrx8C5YYh4mxJpYVlyZ
	e4hRkoNJSZR3XYxFmBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3oJAoBxvSmJlVWpRPkxKmoNF
	SZyXb4m6n5BAemJJanZqakFqEUxWhoNDSYL3UjJQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpe
	SmpRYmlJRjwoNuKLgdEBkuIB2rsSpJ23uCAxFygK0XqKUZdjwY/ba5mEWPLy81KlxHkngxQJ
	gBRllObBrYClj1eM4kAfC/NeAKniAaYeuEmvgJYwAS0J32YKsqQkESEl1cDoIPxzptZ3f6aS
	edwnSufLNyXftHjG07391rbDa445uLpqaai4H5/PuOz0tRtzpkSvjbr+0obFTHrWH42i9yqT
	U64y9BSv+bZG6XLDrZ/7mVrTLjyXzXCW5N2vcGTr720PZ36df3jXcnb1ydyuwbv0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280756>

From: David Turner <dturner@twopensource.com>

is_branch was already non-static, but this patch declares it in the
header.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs.h b/refs.h
index 6d30c98..39b8edc 100644
--- a/refs.h
+++ b/refs.h
@@ -217,6 +217,8 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
  */
 int pack_refs(unsigned int flags);
 
+int is_branch(const char *refname);
+
 /*
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
-- 
2.6.2
