From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 5/5] builtin-remote: Make "remote -v" display push urls
Date: Sat, 13 Jun 2009 22:54:36 -0700
Message-ID: <7vprd7s6lf.fsf@alter.siamese.dyndns.org>
References: <7vtz2pmf98.fsf@alter.siamese.dyndns.org>
	<1244910551-4420-1-git-send-email-git@drmicha.warpmail.net>
	<1244910551-4420-2-git-send-email-git@drmicha.warpmail.net>
	<1244910551-4420-3-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Jun 14 07:54:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFigC-00042L-4g
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 07:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbZFNFyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 01:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbZFNFyi
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 01:54:38 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34952 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbZFNFye (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 01:54:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090614055436.GCQO17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 14 Jun 2009 01:54:36 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 3huc1c0084aMwMQ03hucup; Sun, 14 Jun 2009 01:54:36 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=nk911WzMAd0A:10 a=TKBN_dRqgKkA:10
 a=7FkD_oE4Pn_JQwgeWdoA:9 a=WVDSiSt-hT7grDG0K6EI5bwf6bcA:4
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121535>

Thanks, will replace with these two and merge to 'next'.

I'll squash this in to [5/5], which is the same fix-up as I queued the
previous round to 'pu', to avoid decl-after-statement, by the way.

 builtin-remote.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index f377722..3f6f5c2 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1311,8 +1311,10 @@ static int get_one_entry(struct remote *remote, void *priv)
 static int show_all(void)
 {
 	struct string_list list = { NULL, 0, 0 };
+	int result;
+
 	list.strdup_strings = 1;
-	int result = for_each_remote(get_one_entry, &list);
+	result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
 		int i;
