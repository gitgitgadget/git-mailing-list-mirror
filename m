From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/3] patch-id: document new behaviour
Date: Thu, 27 Mar 2014 11:25:14 +0200
Message-ID: <1395912239-29663-2-git-send-email-mst@redhat.com>
References: <1395912239-29663-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, peff@peff.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 10:25:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WT6ZD-00023e-BP
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 10:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbaC0JZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 05:25:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35673 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbaC0JZA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 05:25:00 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2R9Ov0F025865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 27 Mar 2014 05:24:57 -0400
Received: from redhat.com (vpn1-6-224.ams2.redhat.com [10.36.6.224])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s2R9Ottb001377;
	Thu, 27 Mar 2014 05:24:55 -0400
Content-Disposition: inline
In-Reply-To: <1395912239-29663-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245266>

Clarify that patch ID is now a sum of hashes, not a hash.
Document --stable and --unstable flags.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
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
