From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH v2] builtin/checkout.c: show usage with options on missing argument 'branch'
Date: Thu,  5 May 2011 19:18:10 +0200
Message-ID: <1304615890-12840-1-git-send-email-ralf.thielow@googlemail.com>
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 19:18:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI2C3-0003Vg-J5
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 19:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab1EERSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 13:18:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42572 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309Ab1EERST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 13:18:19 -0400
Received: by fxm17 with SMTP id 17so1674262fxm.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=y9wtwBoVBob1mLKcj2YYW/A1PE8czcnpARfMEmCGalc=;
        b=LPVbQDkGWXL/FmGR4rLJku/76AxJ9xZUQiATv6Usi6GWnOfOzfMX981kK2S4FRXhzV
         ihRGKnLtl6VE69/fp+EJcklquDidap3JFUZHJfVGnEhRBaTmeahj0aOe9nq6Zo0Ko1SZ
         U4l5Ir9C6TZjeTsWG5bBIF+n8s1YbNY53X6iM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XZxKg5/4OpKYyOkGhMl1tsqZZ7N+nguqzr+Na22UUQsZps2FintUkCsZ1ooEpVQ43u
         WbpKeYzFXQiNlVaMpFBT0oidOI+yhw/O4w9HW+s4/id0d3du1jqTdMoISHqsleXiEvBj
         qlDygbPKQqzH8wlK/QPPpj2xPlUUo32+1OjOg=
Received: by 10.223.14.137 with SMTP id g9mr1598728faa.2.1304615898274;
        Thu, 05 May 2011 10:18:18 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-128-235.pools.arcor-ip.net [94.222.128.235])
        by mx.google.com with ESMTPS id j11sm822649faa.20.2011.05.05.10.18.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2011 10:18:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172853>

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
+		return 1;
+	}
+
 	return switch_branches(&opts, &new);
 }
-- 
1.7.5.1
