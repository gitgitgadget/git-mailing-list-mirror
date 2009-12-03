From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH RESEND] git config: clarify bool types
Date: Thu,  3 Dec 2009 10:21:13 +0200
Message-ID: <1259828473-14830-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 03 09:21:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG6wT-0003nS-L7
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 09:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbZLCIVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 03:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbZLCIVT
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 03:21:19 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:34686 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbZLCIVS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 03:21:18 -0500
Received: by bwz27 with SMTP id 27so873202bwz.21
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 00:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ITpweJ4ColwzKoA3/FyT9olcBUDDS8K0fvfzfoffNeo=;
        b=TG6IONCIM929SPKC/wKRppZe2fHGKtNd/Ctop0M5PGLg6KSVk1fl4koNZ7pzOsrTVp
         QrAZrqDVnVIUYYjCkeyJpiXVGbbC4d6aRh8QuULslV/BkLe7BgNAaonMHJ7o6+xP+KhP
         0/xAIj50eQktHp3DhxsTpxIFJ+07pIlWDDPWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bdpXBp1G+wM8arCDuraztjJeMZLTDqp3tI3XxQQGOIbAQPLqUK14quoJ+pH2UcPyBv
         JB2Agw9WtrAgevPh7zvUQw1j4v97S5QVTbJ7p9ufF3mUJQhReRrUETvQf7oRzbbJNCNH
         PCQ637ODwx+YvEKrImj2S/0gxs2GhuGC89+3E=
Received: by 10.204.160.90 with SMTP id m26mr1270010bkx.63.1259828484103;
        Thu, 03 Dec 2009 00:21:24 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 13sm521259bwz.10.2009.12.03.00.21.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Dec 2009 00:21:22 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.1.ge4e9b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134441>

The value is what it is, the --bool and --bool-or-int options don't
specify the value type, just how it is interpreted. For example: a value
of '1' can be interpreted as 'true'.

Comments by Michael J Gruber.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index a2d656e..d81928c 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -66,9 +66,9 @@ static struct option builtin_config_options[] = {
 	OPT_STRING(0, "get-color", &get_color_slot, "slot", "find the color configured: [default]"),
 	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, "slot", "find the color setting: [stdout-is-tty]"),
 	OPT_GROUP("Type"),
-	OPT_BIT(0, "bool", &types, "value is \"true\" or \"false\"", TYPE_BOOL),
+	OPT_BIT(0, "bool", &types, "value is interpreted as a boolean (\"true\" or \"false\")", TYPE_BOOL),
 	OPT_BIT(0, "int", &types, "value is decimal number", TYPE_INT),
-	OPT_BIT(0, "bool-or-int", &types, "value is --bool or --int", TYPE_BOOL_OR_INT),
+	OPT_BIT(0, "bool-or-int", &types, "value is interpreted either as --bool or --int", TYPE_BOOL_OR_INT),
 	OPT_GROUP("Other"),
 	OPT_BOOLEAN('z', "null", &end_null, "terminate values with NUL byte"),
 	OPT_END(),
-- 
1.6.6.rc1.1.ge4e9b
