From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/33] safe_create_leading_directories(): improve docstring
Date: Fri,  6 May 2016 18:13:45 +0200
Message-ID: <e95792e532bde75fd4a1e91aecfcf9a28ba23955.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:14:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiOk-0007yb-Uy
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758557AbcEFQOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:31 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63349 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758498AbcEFQOa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:30 -0400
X-AuditID: 1207440c-c53ff70000000b85-bb-572cc2e434c2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id DA.64.02949.4E2CC275; Fri,  6 May 2016 12:14:28 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUk031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:27 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqPvkkE64wZ11uhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxfr/6wFDxlq5hy9yJ7A+Nh1i5GTg4JAROJmzf+
	sXcxcnEICWxllGi4eIsNwjnOJPHy9BImkCo2AV2JRT3NYLaIQIREw6sWxi5GDg5mgc+MEiu5
	QcLCAn4SC099YAYJswioSmw4IwMS5hWIkrjU2Ay1S07i8vQHbCA2p4CFxKHe42AThQTMJTrW
	3mCfwMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuoV5uZoleakrpJkZIePHsYPy2TuYQ
	owAHoxIP74HT2uFCrIllxZW5hxglOZiURHm/F+iEC/El5adUZiQWZ8QXleakFh9ilOBgVhLh
	vbIPKMebklhZlVqUD5OS5mBREudVXaLuJySQnliSmp2aWpBaBJOV4eBQkuANOgjUKFiUmp5a
	kZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ8K//hiYASApHiA9sqDtPMWFyTmAkUhWk8xGnMs
	+HF7LRPHkf331jIJseTl56VKifMagJQKgJRmlObBLYIllleM4kB/C/NOAqniASYluHmvgFYx
	Aa16P1cTZFVJIkJKqoHRxpD198xNUk93y7WyKbIIWJ4zvnsz1y74vWho/pbFlfPsmGW2br1X
	1XQmK3Aiz4R13iH2pxf1l3tq7rkjUPDcYu6Fjntu55UdAk+5WHtkSTrHfm0JfeRf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293799>

Document the difference between this function and
safe_create_leading_directories_const(), and that the former restores
path before returning.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/cache.h b/cache.h
index 2711048..4134f64 100644
--- a/cache.h
+++ b/cache.h
@@ -993,6 +993,11 @@ int adjust_shared_perm(const char *path);
  * directory while we were working.  To be robust against this kind of
  * race, callers might want to try invoking the function again when it
  * returns SCLD_VANISHED.
+ *
+ * safe_create_leading_directories() temporarily changes path while it
+ * is working but restores it before returning.
+ * safe_create_leading_directories_const() doesn't modify path, even
+ * temporarily.
  */
 enum scld_error {
 	SCLD_OK = 0,
-- 
2.8.1
