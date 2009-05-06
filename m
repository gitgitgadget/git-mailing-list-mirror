From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RESEND/PATCH] git config: clarify bool types
Date: Thu,  7 May 2009 02:07:55 +0300
Message-ID: <1241651275-12966-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 01:08:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1qDm-0001vb-5e
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 01:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756694AbZEFXIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 19:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbZEFXIE
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 19:08:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:17562 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbZEFXIB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 19:08:01 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1168990fga.17
        for <git@vger.kernel.org>; Wed, 06 May 2009 16:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=pVlv1KWFn/TCwOGbV6jP7S932IQakmglz0sT8tpisEw=;
        b=T5Cs9rjLFKUNnZq5Q01IHdutx/ZjRq+zLpWx6ISW2JzSvW2wWhckH0i+QbgA4T8jHO
         Lj3ffG8st7JrY4CQSOYAT25yKJ+Yzu4xaFrio/11tuJ9qk21UxpnvsBbDCViyOW3WF8Z
         pzL6Tx/mpitSB634BLcKGvjajtpUZ2ef6IsW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wD59pm0Rtj4C7epxLKz+Z7xcASC2ZKaj2gzYRwtk4kOOTOs6uhdCyW4rAlxgBL5ejm
         HxmKMwMITc+kPk/BSPwEABpAlkFYVHlA6eRb9MsdbcLzDrOnVsLR/XqQ0tQ1bO6CsTOA
         mjsyD4yY6t3zJSbyhH7naHH8Smjs+0sDxvo/s=
Received: by 10.86.59.18 with SMTP id h18mr1880069fga.14.1241651280810;
        Wed, 06 May 2009 16:08:00 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id d4sm16152483fga.14.2009.05.06.16.08.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 16:08:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc4.14.g96da.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118406>

The value is what it is, the --bool and --bool-or-int options don't
specify the value type, just how it is interpreted. For example: a value
of '1' can be interpreted as 'true'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index a81bc8b..127ae14 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -66,9 +66,9 @@ static struct option builtin_config_options[] = {
 	OPT_STRING(0, "get-color", &get_color_slot, "slot", "find the color configured: [default]"),
 	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, "slot", "find the color setting: [stdout-is-tty]"),
 	OPT_GROUP("Type"),
-	OPT_BIT(0, "bool", &types, "value is \"true\" or \"false\"", TYPE_BOOL),
+	OPT_BIT(0, "bool", &types, "value is intepreted as bool (\"true\" or \"false\")", TYPE_BOOL),
 	OPT_BIT(0, "int", &types, "value is decimal number", TYPE_INT),
-	OPT_BIT(0, "bool-or-int", &types, "value is --bool or --int", TYPE_BOOL_OR_INT),
+	OPT_BIT(0, "bool-or-int", &types, "value is interpreted either as bool or int", TYPE_BOOL_OR_INT),
 	OPT_GROUP("Other"),
 	OPT_BOOLEAN('z', "null", &end_null, "terminate values with NUL byte"),
 	OPT_END(),
-- 
1.6.3.rc4.14.g96da.dirty
