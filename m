From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] post-receive-email: suppress error if description file missing
Date: Thu, 3 Feb 2011 06:30:32 +0530
Message-ID: <20110203010032.GA30329@atcmail.atc.tcs.com>
References: <20110202174242.GA12470@atcmail.atc.tcs.com> <7vbp2uxozo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Hemmecke <hemmecke@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 02:01:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PknZM-0005d4-Ec
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 02:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319Ab1BCBBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 20:01:00 -0500
Received: from atcmail.atc.tcs.co.in ([203.200.212.145]:32825 "EHLO
	atcmail.atc.tcs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab1BCBBA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 20:01:00 -0500
Received: from atcmail.atc.tcs.com (atcmail.atc.tcs.com [127.0.0.1])
	by atcmail.atc.tcs.com (8.13.8/8.13.8) with ESMTP id p1310dYC030915;
	Thu, 3 Feb 2011 06:30:39 +0530
Received: (from sitaram@localhost)
	by atcmail.atc.tcs.com (8.13.8/8.13.8/Submit) id p1310WRJ030904;
	Thu, 3 Feb 2011 06:30:32 +0530
Content-Disposition: inline
In-Reply-To: <7vbp2uxozo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.2i
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on atcmail.atc.tcs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165943>

Signed-off-by: Sitaram Chamarty <sitaramc@gmail.com>
---

On Wed, Feb 02, 2011 at 10:36:43AM -0800, Junio C Hamano wrote:

> I suspect that you would want to have the redirection outside the dq pair,
> but other than that, well spotted.

doh!  Thanks for catching the stupid error -- I shouldn't attempt even a
simple patch when half-asleep I guess :)

> You forgot to sign-off, though ;-)

done!

 contrib/hooks/post-receive-email |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index f99ea95..21989fc 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -709,7 +709,7 @@ if [ -z "$GIT_DIR" ]; then
 	exit 1
 fi
 
-projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
+projectdesc=$(sed -ne '1p' "$GIT_DIR/description" 2>/dev/null)
 # Check if the description is unchanged from it's default, and shorten it to
 # a more manageable length if it is
 if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
-- 
1.7.3.4
