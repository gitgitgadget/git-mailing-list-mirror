From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] builtin/push.c: fix description of --recurse-submodules option
Date: Tue, 18 Nov 2014 18:57:46 +0100
Message-ID: <1416333466-27186-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, hvoigt@hvoigt.net, phillip.szelat@gmail.com,
	worldhello.net@gmail.com, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 18:57:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqn2I-0005a6-NG
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 18:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbaKRR5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 12:57:50 -0500
Received: from mail-wg0-f49.google.com ([74.125.82.49]:37430 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbaKRR5u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 12:57:50 -0500
Received: by mail-wg0-f49.google.com with SMTP id x12so530964wgg.36
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2zrP+9WaH1TaWBM1V0kEipiGmMVshudEZmRcZz0rxPY=;
        b=ny4LpF/T4kMTWIRdrZGFLD25b7BMD47sosHvvCpl+91U2cagQZdE1NH8zhthK21DF4
         eLVUIGZPVYoMHqcvFN9I2+CAsrLtTGOWtL3ZoqC9q4vcDWhd14RACjaIK1sbNoCSc9yf
         aAzEFFFvtofft4BZ/kwCqrib8xfqoGQ3EbW333/QZWx3q11cmxXpCo536KQDB9Xz3jPg
         oEnVCysDdHOH/k6UN9gkD5ukq1rDsPdc34GylNQsIje5jnNIs4HJ1fRpOyNupymj0L0q
         U7hElBArLTmrm1CtlPLeeuVPLoOIpURwtIc2/Vmvsk066s0Qxg53QXsAAkEFwOlPCETd
         fplg==
X-Received: by 10.180.91.49 with SMTP id cb17mr5987579wib.30.1416333469004;
        Tue, 18 Nov 2014 09:57:49 -0800 (PST)
Received: from localhost (dslb-088-073-192-130.088.073.pools.vodafone-ip.de. [88.73.192.130])
        by mx.google.com with ESMTPSA id h2sm9393913wix.5.2014.11.18.09.57.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 09:57:48 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.258.gc851c5b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of the option for argument "recurse-submodules"
is marked for translation even if it expects the untranslated
string and it's missing the option "on-demand" which was introduced
in eb21c73 (2014-03-29, push: teach --recurse-submodules the on-demand
option). Fix this by unmark the string for translation and add the
missing option.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index a076b19..cfa20c2 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -503,7 +503,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
 		  N_("require old value of ref to be at this value"),
 		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
-		{ OPTION_CALLBACK, 0, "recurse-submodules", &flags, N_("check"),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &flags, "check|on-demand",
 			N_("control recursive pushing of submodules"),
 			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOL( 0 , "thin", &thin, N_("use thin pack")),
-- 
2.2.0.rc2.258.gc851c5b
