From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/13] entry_resolves_to_object(): rename function from ref_resolves_to_object()
Date: Mon, 30 May 2016 09:55:28 +0200
Message-ID: <1d91b1d9f970184ac2d117c9d92379725f468d8d.1464537050.git.mhagger@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 30 09:56:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7I3b-0001Iq-1Z
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 09:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbcE3Hz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 03:55:59 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50408 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932360AbcE3Hz6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 03:55:58 -0400
X-AuditID: 1207440e-f07ff700000008c5-d3-574bf20d0478
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 56.F7.02245.D02FB475; Mon, 30 May 2016 03:55:57 -0400 (EDT)
Received: from michael.fritz.box (p508EADDB.dip0.t-ipconnect.de [80.142.173.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4U7tgRw032144
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2016 03:55:56 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464537050.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqMv7yTvc4MNFFYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHs969zB6XLyk7LHg+X12j8+b5ALY
	orhtkhJLyoIz0/P07RK4M2at/M1c0Mhd0TNtNUsD4yeOLkZODgkBE4m+75+Yuhi5OIQEtjJK
	tCzdyQzhnGSS6Jx1lwWkik1AV2JRTzMTiC0iECHR8KqFEaSIWWAfo8TJdfPBioQFEiQ2LD/N
	2sXIwcEioCpxdU80iMkrECWxeYI4xDI5icvTH7CB2JwCFhITZ70DGykkYC6xbOZJ5gmMPAsY
	GVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrr5WaW6KWmlG5ihIQT3w7G9vUyhxgFOBiVeHgL
	NL3DhVgTy4orcw8xSnIwKYnyunEAhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwvn0MlONNSays
	Si3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfA2fQBqFCxKTU+tSMvMKUFIM3Fw
	ggznkhIpTs1LSS1KLC3JiAdFQHwxMAZAUjxAe/eDtPMWFyTmAkUhWk8x6nIc2X9vLZMQS15+
	XqqUOK89SJEASFFGaR7cCljyeMUoDvSxMO8JkCoeYOKBm/QKaAkT0BKzc14gS0oSEVJSDYwe
	V40yT8qfZS5YovLm+kSOM7YNnZtmCuiG/fz6i3+txcrTxurfnUvLb76a/n9Hbv2/E9LMjtqP
	NY+sM3bsu3jzEf/iju1nZDOK0rRXtMV96Gq4lurW12jyXV/qwJFwwVevrRq5YgTj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295864>

Free up the old name for a more general purpose.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 142c977..1a46f32 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -517,7 +517,7 @@ static void sort_ref_dir(struct ref_dir *dir)
  * an object in the database.  Emit a warning if the referred-to
  * object does not exist.
  */
-static int ref_resolves_to_object(struct ref_entry *entry)
+static int entry_resolves_to_object(struct ref_entry *entry)
 {
 	if (entry->flag & REF_ISBROKEN)
 		return 0;
@@ -563,7 +563,7 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 		return 0;
 
 	if (!(data->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-	      !ref_resolves_to_object(entry))
+	      !entry_resolves_to_object(entry))
 		return 0;
 
 	/* Store the old value, in case this is a recursive call: */
@@ -2228,7 +2228,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 		return 0;
 
 	/* Do not pack symbolic or broken refs: */
-	if ((entry->flag & REF_ISSYMREF) || !ref_resolves_to_object(entry))
+	if ((entry->flag & REF_ISSYMREF) || !entry_resolves_to_object(entry))
 		return 0;
 
 	/* Add a packed ref cache entry equivalent to the loose entry. */
-- 
2.8.1
