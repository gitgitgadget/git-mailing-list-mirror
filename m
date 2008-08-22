From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 3/4] Added test for RefUpdate branch deletion
Date: Fri, 22 Aug 2008 16:26:18 -0700
Message-ID: <20080822232618.GQ3483@spearce.org>
References: <1219445147-6801-1-git-send-email-charleso@charleso.org> <1219445147-6801-2-git-send-email-charleso@charleso.org> <1219445147-6801-3-git-send-email-charleso@charleso.org> <1219445147-6801-4-git-send-email-charleso@charleso.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Charles O'Farrell <charleso@charleso.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 01:27:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWg2N-00034O-2y
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 01:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbYHVX0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 19:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbYHVX0T
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 19:26:19 -0400
Received: from george.spearce.org ([209.20.77.23]:47319 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbYHVX0T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 19:26:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C8F0B38375; Fri, 22 Aug 2008 23:26:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219445147-6801-4-git-send-email-charleso@charleso.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93399>

Charles O'Farrell <charleso@charleso.org> wrote:
> +public class RefUpdateTest extends RepositoryTestCase {
> +
> +	public void testDeleteHead() throws IOException {
> +		final RefUpdate ref = updateRef(Constants.HEAD);
> +		delete(ref, Result.NOT_ATTEMPTED, true, false);
> +	}
> +}

So I see you didn't run the unit tests before emailing.  ;-)

I squashed this into the patch I am replying to:

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 62a60c3..1ade2ef 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -72,7 +72,7 @@ public void testLooseDelete() throws IOException {
 
 	public void testDeleteHead() throws IOException {
 		final RefUpdate ref = updateRef(Constants.HEAD);
-		delete(ref, Result.NOT_ATTEMPTED, true, false);
+		delete(ref, Result.REJECTED_CURRENT_BRANCH, true, false);
 	}
 
 	public void testLogDeleted() throws IOException {

Otherwise the series looks good.  Compiles.  Passes tests.
Tests look correct.  Thanks!

-- 
Shawn.
