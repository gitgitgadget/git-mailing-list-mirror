From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] git-gc.txt, git-reflog.txt: document new expiry options
Date: Thu, 18 Apr 2013 09:46:34 +0200
Message-ID: <1366271195-4276-2-git-send-email-mhagger@alum.mit.edu>
References: <7vbo9ceqb3.fsf@alter.siamese.dyndns.org>
 <1366271195-4276-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 09:47:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USjYs-0001tg-3m
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 09:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966303Ab3DRHrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 03:47:12 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:45816 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966268Ab3DRHrL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Apr 2013 03:47:11 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-02-516fa4feca70
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id D6.10.02380.EF4AF615; Thu, 18 Apr 2013 03:47:10 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3I7kuV9006934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Apr 2013 03:47:07 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366271195-4276-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqPtvSX6gwYZ2YYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M54/eMlU8FzoYqe3RfYGhjX83cxcnJICJhInFj5kR3CFpO4cG89WxcjF4eQwGVGiaNf
	3zJBOGeYJDaeW80MUsUmoCuxqKeZCcQWEVCTmNh2iAWkiFmgj1Gif908sISwgI/Eyv7lYGNZ
	BFQlLn86yQZi8wo4S7zve8UKsU5B4vj2bYwgNqeAi8Tjw9fB4kIC+RLfTp1km8DIu4CRYRWj
	XGJOaa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJXmpK6SZGSFjx7WBsXy9ziFGAg1GJh/fBqrxA
	IdbEsuLK3EOMkhxMSqK8lsCgFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC+0gWKMebklhZlVqU
	D5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuANBhkqWJSanlqRlplTgpBm4uAEEVwg
	G3iANviDFPIWFyTmFmemQxSdYlSUEudNAUkIgCQySvPgBsASwCtGcaB/hHljQap4gMkDrvsV
	0GAmoMEHVmWDDC5JREhJNTCKaqycp7SgZrc1h9uNzS7qRZkPt7QzPGxe8s2z3ma37r/je+bl
	3VpW2ndv7Z6keYfvrPhu9yXC8dmsCuuFgb6R3OaSLet+C7gULT9h+GPP9E3iff5SFoVP7yq9
	27yw4qbylenVM1s3sHGrLd6aln/3Xs60Wfbsd2ffjGtu/SB3bc6ClMN1qVyOSizF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221621>

Document the new values that can be used for expiry values where their
use makes sense:

* git reflog expire --expire=[all|never]
* git reflog expire --expire-unreachable=[all|never]
* git gc --prune=all

Other combinations aren't useful and therefore no documentation is
added (even though they are allowed):

* git gc --prune=never

  is redundant with "git gc --no-prune"

* git prune --expire=all

  is equivalent to providing no --expire option

* git prune --expire=never

  is a NOP

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-gc.txt     | 5 +++--
 Documentation/git-reflog.txt | 9 +++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index b370b02..2402ed6 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -62,8 +62,9 @@ automatic consolidation of packs.
 
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
-	overridable by the config variable `gc.pruneExpire`).  This
-	option is on by default.
+	overridable by the config variable `gc.pruneExpire`).
+	--prune=all prunes loose objects regardless of their age.
+	--prune is on by default.
 
 --no-prune::
 	Do not prune any loose objects.
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index fb8697e..70791b9 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -67,14 +67,19 @@ them.
 --expire=<time>::
 	Entries older than this time are pruned.  Without the
 	option it is taken from configuration `gc.reflogExpire`,
-	which in turn defaults to 90 days.
+	which in turn defaults to 90 days.  --expire=all prunes
+	entries regardless of their age; --expire=never turns off
+	pruning of reachable entries (but see --expire-unreachable).
 
 --expire-unreachable=<time>::
 	Entries older than this time and not reachable from
 	the current tip of the branch are pruned.  Without the
 	option it is taken from configuration
 	`gc.reflogExpireUnreachable`, which in turn defaults to
-	30 days.
+	30 days.  --expire-unreachable=all prunes unreachable
+	entries regardless of their age; --expire-unreachable=never
+	turns off early pruning of unreachable entries (but see
+	--expire).
 
 --all::
 	Instead of listing <refs> explicitly, prune all refs.
-- 
1.8.2.1
