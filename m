From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH] gitweb: Fix shortlog only showing HEAD revision.
Date: Wed, 3 Jan 2007 20:25:55 +0000
Message-ID: <20070103202555.GA25768@localhost>
References: <459C0232.3090804@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Michael Krufky <mkrufky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 03 21:27:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2ChI-0008O6-BV
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 21:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbXACU0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 15:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbXACU0s
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 15:26:48 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:49813 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbXACU0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 15:26:45 -0500
Received: from 213-202-144-210.bas502.dsl.esat.net ([213.202.144.210] helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1H2CgF-0001Cf-LN; Wed, 03 Jan 2007 20:25:47 +0000
To: Michael Krufky <mkrufky@linuxtv.org>,
	"J.H." <warthog19@eaglescrag.net>
Content-Disposition: inline
In-Reply-To: <459C0232.3090804@linuxtv.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35888>

My change in 190d7fdcf325bb444fa806f09ebbb403a4ae4ee6 had a small bug
found by Michael Krufky which caused the passed in hash value to be
ignored, so shortlog would only show the HEAD revision.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---

Thanks for finding this Michael.  It' just a small bug introducted by a
recent change I made.  Including John 'Warthog9' so hopefully he can add
this to the version of gitweb which is hosted on kernel.org.

Robert


 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d845e91..2e94c2c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4423,7 +4423,7 @@ sub git_shortlog {
 	}
 	my $refs = git_get_references();
 
-	my @commitlist = parse_commits($head, 101, (100 * $page));
+	my @commitlist = parse_commits($hash, 101, (100 * $page));
 
 	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, (100 * ($page+1)));
 	my $next_link = '';
-- 
t1.gaaaa
