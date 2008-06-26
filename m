From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] git-send-email: Fix warning triggered by f6bebd12 when no encryption is set
Date: Thu, 26 Jun 2008 13:36:39 -0700
Message-ID: <1214512599-88902-1-git-send-email-kevin@sb.org>
References: <DF091369-1771-4405-8705-BDBC59C7E48A@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	<trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 22:37:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KByDq-000774-P3
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 22:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078AbYFZUgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 16:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755256AbYFZUgm
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 16:36:42 -0400
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:49936 "EHLO
	randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755078AbYFZUgl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2008 16:36:41 -0400
Received: from localhost.localdomain (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id 6F49CAF952;
	Thu, 26 Jun 2008 13:36:40 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.1.182.gd6c0
In-Reply-To: <DF091369-1771-4405-8705-BDBC59C7E48A@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86482>

---
 git-send-email.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 60a6551..b93cd40 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -299,6 +299,8 @@ sub read_config {
 			$smtp_encryption = $enc;
 		} elsif (Git::config_bool(@repo, "$prefix.smtpssl")) {
 			$smtp_encryption = 'ssl';
+		} else {
+			$smtp_encryption = '';
 		}
 	}
 }
-- 
1.5.6.1.180.g7b731
