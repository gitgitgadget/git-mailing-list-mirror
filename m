From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 2/3] patch-id: document new behaviour
Date: Fri, 28 Mar 2014 14:30:15 +0200
Message-ID: <1396009159-2078-2-git-send-email-mst@redhat.com>
References: <1396009159-2078-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 13:30:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTVvU-0007Nl-Ge
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 13:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbaC1MaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 08:30:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37500 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbaC1M36 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 08:29:58 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2SCTrea009389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 28 Mar 2014 08:29:53 -0400
Received: from redhat.com (vpn1-7-130.ams2.redhat.com [10.36.7.130])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s2SCToac009445;
	Fri, 28 Mar 2014 08:29:51 -0400
Content-Disposition: inline
In-Reply-To: <1396009159-2078-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245385>

Clarify that patch ID is now a sum of hashes, not a hash.
Document --stable and --unstable flags.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

No change from v1.

 Documentation/git-patch-id.txt | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 312c3b1..1bc6d52 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -8,14 +8,14 @@ git-patch-id - Compute unique ID for a patch
 SYNOPSIS
 --------
 [verse]
-'git patch-id' < <patch>
+'git patch-id' [--stable | --unstable] < <patch>
 
 DESCRIPTION
 -----------
-A "patch ID" is nothing but a SHA-1 of the diff associated with a patch, with
-whitespace and line numbers ignored.  As such, it's "reasonably stable", but at
-the same time also reasonably unique, i.e., two patches that have the same "patch
-ID" are almost guaranteed to be the same thing.
+A "patch ID" is nothing but a sum of SHA-1 of the diff hunks associated with a
+patch, with whitespace and line numbers ignored.  As such, it's "reasonably
+stable", but at the same time also reasonably unique, i.e., two patches that
+have the same "patch ID" are almost guaranteed to be the same thing.
 
 IOW, you can use this thing to look for likely duplicate commits.
 
@@ -27,6 +27,17 @@ This can be used to make a mapping from patch ID to commit ID.
 
 OPTIONS
 -------
+
+--stable::
+	Use a symmetrical sum of hashes, such that order of
+	hunks in the diff does not affect the ID.
+	This is the default.
+
+--unstable::
+	Use a non-symmetrical sum of hashes, such that order of
+	hunks in the diff affects the ID.
+	This was the default value for git 1.9 and older.
+
 <patch>::
 	The diff to create the ID of.
 
-- 
MST
