From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] git config: clarify bool types
Date: Sat, 24 Oct 2009 11:39:05 +0300
Message-ID: <1256373545-15588-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 10:39:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1c9g-0001As-H0
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 10:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbZJXIjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 04:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbZJXIjJ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 04:39:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:13098 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbZJXIjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 04:39:08 -0400
Received: by fg-out-1718.google.com with SMTP id 16so4311375fgg.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=mBv67SABPeL7hGNBuyXtKq+H3MKoVLW8OBRsacyYQdg=;
        b=vy+8T8JfJAZ8LXkLeWmp4MqQtwM4Mo7caeQtGntJJeDZuUz/Xc71mRnT4nrpdD584S
         BmwkvkJ9o7SXoyWHSgRx66VYWCc54FXmCrtLt2K9/xLqln7BV+Np52Hc+0XSEOqAPdaH
         NNGwf3EAu0FKxXz3dxIkGoUz78+QoVL/q2DOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fAWSBSMHAYEd2NG1AvoS/4wNA/7e/8LCM7OrK5+flalb5E3QGQ04xdVB6hrGMEn/HN
         p1LR/ucN+OTkIYlR9aFa4IfSqAspYJY557I16hK0nQPjkK+SwvuohDt5lBJzjKravmCD
         c6cBjjtT1YXZYHdCK0w0i+hIpEctlBhVqSbcg=
Received: by 10.86.184.35 with SMTP id h35mr1584245fgf.18.1256373552344;
        Sat, 24 Oct 2009 01:39:12 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id d4sm5474677fga.16.2009.10.24.01.39.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Oct 2009 01:39:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131148>

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
1.6.5.1
