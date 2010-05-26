From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 086/104] gitweb: Use @diff_opts while using format-patch
Date: Wed, 26 May 2010 18:00:56 +1200
Message-ID: <1274853674-18521-86-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9lf-0004ff-Pg
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934006Ab0EZGGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:34 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49309 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933894Ab0EZGG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 98294338E0;
	Wed, 26 May 2010 18:02:05 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cD99VAWsAOa7; Wed, 26 May 2010 18:01:58 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id E4331338C7;
	Wed, 26 May 2010 18:01:35 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147757>

From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

Make git-format-patch (used by 'patch' and 'patches' views) use the
same rename detection options that git-diff and git-diff-tree (used
by 'commitdiff', 'blobdiff', etc.) use.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Acked-by: Jakub Narebski <jnareb@gmail.com>
Acked-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c356e95..77e5f79 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6117,8 +6117,8 @@ sub git_commitdiff {
 			}
 			push @commit_spec, '--root', $hash;
 		}
-		open $fd, "-|", git_cmd(), "format-patch", '--encoding=utf8',
-			'--stdout', @commit_spec
+		open $fd, "-|", git_cmd(), "format-patch", @diff_opts,
+			'--encoding=utf8', '--stdout', @commit_spec
 			or die_error(500, "Open git-format-patch failed");
 	} else {
 		die_error(400, "Unknown commitdiff format");
-- 
1.7.1.rc2.333.gb2668
