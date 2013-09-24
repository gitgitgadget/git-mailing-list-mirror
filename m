From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] doc: don't claim that cherry-pick calls patch-id
Date: Wed, 25 Sep 2013 01:05:40 +0300
Message-ID: <1380060333-2226-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 25 00:03:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOahe-000415-BW
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 00:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab3IXWDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 18:03:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44240 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753836Ab3IXWDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 18:03:25 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8OM3MPi017515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 24 Sep 2013 18:03:22 -0400
Received: from redhat.com (vpn1-6-23.ams2.redhat.com [10.36.6.23])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r8OM3LrR007412;
	Tue, 24 Sep 2013 18:03:21 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235320>

The id is already different for binary files.
Let's document that they are similar, not identical.

Cc: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/git-cherry.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index f6c19c7..66ff52f 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -13,12 +13,13 @@ SYNOPSIS
 DESCRIPTION
 -----------
 The changeset (or "diff") of each commit between the fork-point and <head>
-is compared against each commit between the fork-point and <upstream>.
-The commits are compared with their 'patch id', obtained from
-the 'git patch-id' program.
+is compared against diff of each commit between the fork-point and <upstream>.
+The diffs are compared with their diff id (sha1) calculated after removing
+any whitespace and line numbers (similar but not necessarily identical
+to 'patch id', obtained from the 'git patch-id' program).
 
 Every commit that doesn't exist in the <upstream> branch
-has its id (sha1) reported, prefixed by a symbol.  The ones that have
+has its diff id (sha1) reported, prefixed by a symbol.  The ones that have
 equivalent change already
 in the <upstream> branch are prefixed with a minus (-) sign, and those
 that only exist in the <head> branch are prefixed with a plus (+) symbol:
-- 
MST
