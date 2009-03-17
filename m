From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] git config: clarify bool types
Date: Wed, 18 Mar 2009 01:13:51 +0200
Message-ID: <1237331631-29822-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 00:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjiVT-0000gt-E4
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 00:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbZCQXOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 19:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbZCQXOE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 19:14:04 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:55865 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbZCQXOD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 19:14:03 -0400
Received: by bwz17 with SMTP id 17so295068bwz.37
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 16:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Vl0UfHa3AhcHYO/K+y9GrhVPtA/DNYroWYYSwsXz8Yg=;
        b=O5xc04HP+9OF+wNdkyEpyMOkLaQko/r+yZ3bapt2kwjtsz9pCZnEcZX5fImRWR6rgQ
         Pv8EA9vrbWIAqDacCzP1FjD9303xmqEoTMPe2rlgAEyUREC5Hn181ug64o07XD2AuXlR
         G2JvWW8il+ZIUzzwU3D6dFf5q1XisPUWEUJp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=LbxnfJXoXrEyRbsBXiNOrvD6sDNAlwNkvEzIkM2JQ0f0bFOVWtT1JsNwN/PY9sBJgx
         m/d73c3s2L40Vu2/29VPhcZJdFAul3TC7wDFSK9E+KwKsxxrLsCjs0U22q381XUnsSIx
         ky52ACsQdZByfEr2RjpnB51yr2dpdZFjlwL1E=
Received: by 10.204.113.203 with SMTP id b11mr173742bkq.109.1237331639403;
        Tue, 17 Mar 2009 16:13:59 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 22sm11100579fkr.14.2009.03.17.16.13.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Mar 2009 16:13:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.287.g9a8be
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113536>

The value is what it is, the --bool and --bool-or-int options don't
specify the value type, just how it is interpreted. For example: a value
of '1' can be interpreted as 'true'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

This applies on top of the 'next' branch.

 builtin-config.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 1a3baa1..c3a0176 100644
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
1.6.2.313.g33352
