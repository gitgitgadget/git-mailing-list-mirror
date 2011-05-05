From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH] builtin/checkout.c: show usage with options on missing argument 'branch'
Date: Thu,  5 May 2011 18:58:10 +0200
Message-ID: <1304614690-12493-1-git-send-email-ralf.thielow@googlemail.com>
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 18:58:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI1sk-0008Sj-21
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 18:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507Ab1EEQ6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 12:58:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50701 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab1EEQ6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 12:58:24 -0400
Received: by fxm17 with SMTP id 17so1663047fxm.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 09:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Ch94bYKHZzTG24ixpy2zxaIfNyyNYDtoeIeZhy8YuTs=;
        b=ws2Gq5oMzqhB4FKSDOwbVAj70u1WqfHNMbfhyfsy3ATmITZVql71vOtMdtFHI0XmcJ
         szKC7EwupPohmuA+GvMnbpbso5NcE4px3d+Nmz4F5eCkunU+hooM+LafbMcUdVePQRi2
         0YLCkaQU13A94Dx1onDGd2ynchRdGGXl4Jn/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EJ5O+l2VNXBAonX+9dHMSNGZDtzePlE71mJsw/aEDZPbZejufA4Mks9WJpMG9n3KVU
         Kj1eYPr0gmE19ucrqV289oZ71X6EIt/IuijJ6mRU1Y0hjtuf5Db4A97zZ0OmSD7nXvbz
         dro5cKu0JowdUpDfhYvEf/bZX4hZSpyy1a0fg=
Received: by 10.223.159.14 with SMTP id h14mr1507432fax.20.1304614703038;
        Thu, 05 May 2011 09:58:23 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-128-235.pools.arcor-ip.net [94.222.128.235])
        by mx.google.com with ESMTPS id e17sm820062fak.0.2011.05.05.09.58.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2011 09:58:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172849>

Show the usage with options for 'checkout' command on missing argument 'branch'.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 builtin/checkout.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 38632fc..4aa613a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1086,5 +1086,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.writeout_stage)
 		die(_("--ours/--theirs is incompatible with switching branches."));
 
+	if (new.name == NULL) {
+		usage_with_options(checkout_usage, options);
+		return;
+	}
+
 	return switch_branches(&opts, &new);
 }
-- 
1.7.5.1
