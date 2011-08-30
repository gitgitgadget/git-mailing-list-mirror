From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] Documentation: clarify effects of -- <path> arguments
Date: Tue, 30 Aug 2011 11:21:07 +0200
Message-ID: <73058a4801ea2707f5ffa12150682ee0522385eb.1314695984.git.trast@student.ethz.ch>
References: <7vbov74w25.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 11:21:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyKVQ-0008H2-IE
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 11:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab1H3JVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 05:21:12 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:18812 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589Ab1H3JVK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 05:21:10 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 30 Aug
 2011 11:21:07 +0200
Received: from localhost.localdomain (129.132.153.219) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 30 Aug
 2011 11:21:07 +0200
X-Mailer: git-send-email 1.7.7.rc0.370.gdcae57
In-Reply-To: <7vbov74w25.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.153.219]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180397>

'git log -- <path>' does not "show commits that affect the specified
paths" in a literal sense unless --full-history is given (for example,
a file that only existed on a side branch will turn up no commits at
all!).

Reword it to specify the actual intent of the filtering, and point to
the "History Simplification" section.

The first new sentence was suggested by Junio.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > 'git log -- <path>' does not "show commits that affect the specified
> > paths" in a literal sense unless --full-history is given (for example,
> > a file that only existed on a side branch will turn up no commits at
> > all!).
> >
> > Point the user to the "History Simplification" section to avoid
> > surprises.
> 
> Hmm, or perhaps replace it with a brief explanation instead of redirecting
> the readers to a separate section without telling them anything here?
> 
>     Show only commits that are enough to explain how the files that match
>     the specified paths came to be.
> 
> (this is my attempt to paraphrase $gmane/90659)

Or both?  I really like your version; I tried to come up with a
concise wording and couldn't.  But the user may still want to read
about it in detail.


 Documentation/git-log.txt |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 6c93466..249fc87 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -69,10 +69,13 @@ produced by --stat etc.
 	its size is not included.
 
 [\--] <path>...::
-	Show only commits that affect any of the specified paths. To
-	prevent confusion with options and branch names, paths may need
-	to be prefixed with "\-- " to separate them from options or
-	refnames.
+	Show only commits that are enough to explain how the files
+	that match the specified paths came to be.  See "History
+	Simplification" below for details and other simplification
+	modes.
++
+To prevent confusion with options and branch names, paths may need to
+be prefixed with "\-- " to separate them from options or refnames.
 
 include::rev-list-options.txt[]
 
-- 
1.7.7.rc0.370.gdcae57
