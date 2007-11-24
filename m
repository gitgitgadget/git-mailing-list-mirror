From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 1/3] Rename patch_update_file function to patch_update_pathspec
Date: Sat, 24 Nov 2007 13:55:20 +0100
Message-ID: <1195908922-88023-2-git-send-email-win@wincent.com>
References: <7vk5o8smaf.fsf@gitster.siamese.dyndns.org>
 <1195908922-88023-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 13:56:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvuZ2-00016b-2H
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 13:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbXKXM4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 07:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbXKXM4V
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 07:56:21 -0500
Received: from wincent.com ([72.3.236.74]:34084 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616AbXKXM4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 07:56:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAOCtOop008418;
	Sat, 24 Nov 2007 06:55:29 -0600
X-Mailer: git-send-email 1.5.3.6.1994.g315c0c
In-Reply-To: <1195908922-88023-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65949>

The patch_update_file function really works on pathspecs, not files, so
rename it to reflect its actual purpose.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-add--interactive.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index e347216..15b2c9f 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -571,11 +571,11 @@ sub patch_update_cmd {
 				       HEADER => $status_head, },
 				     @mods);
 	for (@them) {
-		patch_update_file($_->{VALUE});
+		patch_update_pathspec($_->{VALUE});
 	}
 }
 
-sub patch_update_file {
+sub patch_update_pathspec {
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
-- 
1.5.3.6.1992.gd646-dirty
