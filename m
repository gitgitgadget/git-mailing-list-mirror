From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git add -e documentation: rephrase note
Date: Mon, 19 Oct 2009 02:09:00 +0200
Message-ID: <20091019000900.GV6115@genesis.frugalware.org>
References: <20091014222628.GK6115@genesis.frugalware.org>
 <20091014230434.GB29664@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 02:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzfoL-00077P-HZ
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 02:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbZJSAI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 20:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbZJSAI5
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 20:08:57 -0400
Received: from virgo.iok.hu ([212.40.97.103]:40801 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbZJSAI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 20:08:56 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F36CE5808B;
	Mon, 19 Oct 2009 02:09:00 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A8B5B44906;
	Mon, 19 Oct 2009 02:09:00 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B280311F002B; Mon, 19 Oct 2009 02:09:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20091014230434.GB29664@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130630>

Add a quick overview about what is OK and what is not to cover all
cases.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Jeff King <peff@peff.net>
---

On Wed, Oct 14, 2009 at 07:04:34PM -0400, Jeff King <peff@peff.net> wrote:
> Maybe it makes sense instead to do a quick overview of what is OK and
> what is not (like the list above).

Here it is.

 Documentation/git-add.txt |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 45ebf87..1ea074c 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -86,9 +86,21 @@ OPTIONS
 	edit it.  After the editor was closed, adjust the hunk headers
 	and apply the patch to the index.
 +
-*NOTE*: Obviously, if you change anything else than the first character
-on lines beginning with a space or a minus, the patch will no longer
-apply.
+The intent of this option is to pick and choose lines of the diff to
+apply, or even to munge the lines. So it is safe to:
++
+* remove lines with a "+" (don't stage the addition)
+* munge any lines with a "+" (stage modified contents)
+* add lines with a "+" (stage an addition)
+* convert lines with a " " to "-" (stage removal)
+* convert lines with a "-" to " " (don't stage removal)
++
+It is a bad idea to:
++
+* delete "-" lines
+* delete " " lines
+* add " " or "-" lines
+* munge the contents of " " or "-" lines
 
 -u::
 --update::
-- 
1.6.5
