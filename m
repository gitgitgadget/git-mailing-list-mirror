From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 1/6] gitweb: Allow underscore in $searchtype ('st')
Date: Fri, 29 Jul 2011 13:52:54 +0200
Message-ID: <1311940379-9608-2-git-send-email-jnareb@gmail.com>
References: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 13:53:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmldN-0005xQ-7t
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 13:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370Ab1G2Lx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 07:53:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65163 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab1G2LxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 07:53:25 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so2225343fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 04:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Pc4mj/eBU8kUdG2PsUY2Stc+BPjV6gkUcSc7A3+o9xw=;
        b=KUm1+Tkl1xbKi2FPsPSUOQDVVr2cxJVtkfBfSbegcIn19IacboT2wSeTycSRaMVJQC
         9nxWrPAk/LvoJjGe2Aw2yTTf/+tgnomXSbNqVbjabRsR7NxXI2Cd4+VODPXDZbsT6Hvf
         N8pyVcQJrDC5P3oRtS8rH32Y0ElVyiyHjc12g=
Received: by 10.223.50.131 with SMTP id z3mr1677923faf.127.1311940404633;
        Fri, 29 Jul 2011 04:53:24 -0700 (PDT)
Received: from localhost.localdomain (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id n27sm1049500faa.4.2011.07.29.04.53.22
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 04:53:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178133>

This makes searchtype containing underscore '_' to pass parameter
validation in evaluate_and_validate_params().

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is not necessary in this series, and could be left for later when
we need it.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f858d1b..7ec1621 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1057,7 +1057,7 @@ sub evaluate_and_validate_params {
 
 	our $searchtype = $input_params{'searchtype'};
 	if (defined $searchtype) {
-		if ($searchtype =~ m/[^a-z]/) {
+		if ($searchtype =~ m/[^a-z_]/) {
 			die_error(400, "Invalid searchtype parameter");
 		}
 	}
-- 
1.7.5
