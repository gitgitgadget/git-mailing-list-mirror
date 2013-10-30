From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/23] git-fetch.txt: improve description of tag auto-following
Date: Wed, 30 Oct 2013 06:33:06 +0100
Message-ID: <1383111192-23780-18-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:41:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOXE-0007Q8-8a
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975Ab3J3Flf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:41:35 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:64980 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752726Ab3J3Fle (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:41:34 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2013 01:41:34 EDT
X-AuditID: 12074413-b7fc76d000002aba-55-52709a686cc4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 51.A4.10938.86A90725; Wed, 30 Oct 2013 01:34:32 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIS014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:29 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqJsxqyDIoGMRq8X0rtUsFl1Xupks
	GnqvMFvMu7uLyWLVrWXMFitn3GC0uL1iPrPF085Ki3kvXrBZ/GjpYXbg8vj7/gOTx6V1L5k8
	Dv2Zwu7x7EQ7m8ell9/ZPJ717mH0uHhJ2WNGy2sWj8+b5DwOXH7MFsAVxW2TlFhSFpyZnqdv
	l8Cd0fhnB2vBDMGKB41TWRoY+/i6GDk5JARMJK7NaWCBsMUkLtxbz9bFyMUhJHCZUeLbq81M
	EM4VJoklR2eyg1SxCehKLOppZgKxRQTUJCa2HWIBKWIWmMgscXz6IrBRwgJBErfPrmYFsVkE
	VCVmNb8Ai/MKuEpMnLeeGWKdgsSN5qlgNZxA8U+7boItEBJwkWhq/8w+gZF3ASPDKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQwBXewbjrpNwhRgEORiUeXoMH+UFCrIll
	xZW5hxglOZiURHnTphQECfEl5adUZiQWZ8QXleakFh9ilOBgVhLhnX4cqJw3JbGyKrUoHyYl
	zcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMGrPBNoqGBRanpqRVpmTglCmomDE0RwgWzg
	AdrAA1LIW1yQmFucmQ5RdIpRUUqcdy5IQgAkkVGaBzcAlmJeMYoD/SMM0c4DTE9w3a+ABjMB
	Dd7DkgcyuCQRISXVwLjJc/H50nMhncsvxbQe+az/8Q7TkYqmt1c0TyX0iTz1mxIRHy5ebvrq
	zrOL3ddUioIP/71W+aSBa8+piz/670oIW7x+IPXBv3zLG/2ACs23xtNUpyzgKHtU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236970>

Make it clearer that tags are fetched independent of which branches
were fetched from the remote in any particular fetch.  (Tags are even
fetched if they point at objects that are in the current repository
but not reachable, which is probably a bug.)

Put less emphasis on the mechanism and more on the effect of tag
auto-following.  Also mention the options and configuration settings
that can change the tag-fetching behavior.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

The "probable bug" mentioned above has been reported to the mailing
list [1] but is not addressed in the current patch series.

[1] http://article.gmane.org/gmane.comp.version-control.git/236829

 Documentation/git-fetch.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index e08a028..1065713 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -24,13 +24,13 @@ The ref names and their object names of fetched refs are stored
 in `.git/FETCH_HEAD`.  This information is left for a later merge
 operation done by 'git merge'.
 
-When <refspec> stores the fetched result in remote-tracking branches,
-the tags that point at these branches are automatically
-followed.  This is done by first fetching from the remote using
-the given <refspec>s, and if the repository has objects that are
-pointed by remote tags that it does not yet have, then fetch
-those missing tags.  If the other end has tags that point at
-branches you are not interested in, you will not get them.
+By default, tags are auto-followed.  This means that when fetching
+from a remote, any tags on the remote that point to objects that exist
+in the local repository are fetched.  The effect is to fetch tags that
+point at branches that you are interested in.  This default behavior
+can be changed by using the --tags or --no-tags options, by
+configuring remote.<name>.tagopt, or by using a refspec that fetches
+tags explicitly.
 
 'git fetch' can fetch from either a single named repository,
 or from several repositories at once if <group> is given and
-- 
1.8.4.1
