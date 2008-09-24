From: Chris Frey <cdfrey@foursquare.net>
Subject: [PATCH] Documentation: clarify the details of overriding LESS via core.pager
Date: Wed, 24 Sep 2008 19:21:28 -0400
Message-ID: <20080924232128.GA29929@foursquare.net>
References: <20080918232207.GA31193@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 25 01:23:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KidhW-00054K-7d
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 01:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbYIXXWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 19:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbYIXXWF
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 19:22:05 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:39815 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbYIXXWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 19:22:04 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m8ONLSoY030499;
	Wed, 24 Sep 2008 19:21:29 -0400
Content-Disposition: inline
In-Reply-To: <20080918232207.GA31193@foursquare.net>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96710>

The process of overriding the default LESS options using only
git-specific methods is rather obscure.  Show the end user how
to do it in a step-by-step manner.

Signed-off-by: Chris Frey <cdfrey@foursquare.net>
---

No comments on this patch last week, so sending again, to be
applied.

Thanks,
- Chris

 Documentation/config.txt |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 922ac7b..9493621 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -363,8 +363,17 @@ core.pager::
 	variable.  Note that git sets the `LESS` environment
 	variable to `FRSX` if it is unset when it runs the
 	pager.  One can change these settings by setting the
-	`LESS` variable to some other value or by giving the
-	`core.pager` option a value such as "`less -+FRSX`".
+	`LESS` variable to some other value.  Alternately,
+	these settings can be overridden on a project or
+	global basis by setting the `core.pager` option.
+	Setting `core.pager` has no affect on the `LESS`
+	environment variable behaviour above, so if you want
+	to override git's default settings this way, you need
+	to be explicit.  For example, to disable the S option
+	in a backward compatible manner, set `core.pager`
+	to "`less -+$LESS -FRX`".  This will be passed to the
+	shell by git, which will translate the final command to
+	"`LESS=FRSX less -+FRSX -FRX`".
 
 core.whitespace::
 	A comma separated list of common whitespace problems to
-- 
1.6.0.2
