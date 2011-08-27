From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: [PATCH] checkout: be quiet if not on isatty()
Date: Sat, 27 Aug 2011 21:45:52 +0200
Message-ID: <c70a246a601bec0ce973b177bf5553d3fee47014.1314472512.git.sdaoden@gmail.com>
References: <cover.1314472512.git.sdaoden@gmail.com>
Cc: Steffen Daode Nurpmeso <sdaoden@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 21:47:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxOqo-0006pC-C6
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 21:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683Ab1H0TrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 15:47:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55066 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab1H0TrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 15:47:25 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so3376857fxh.19
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=4GpVz9dQsOD9jwYwP60Y+xXWCEB/P+c/SyHSDDtRXzQ=;
        b=FKahLRKbWGjIbLkbWaqY7ooR+IphYZmmw8n9C4yuAcMsFci4LX+ly79iyshVQnhcp6
         qahAD29HKBT/m04rql7f5ppsMUWFA3SioV46pGeeUPXp95G70GnrebZ7619kKiRnBB9U
         3jXrc85eaPyn2BTdIPsXfDYlUWlnHAnxcTyHA=
Received: by 10.223.30.142 with SMTP id u14mr307427fac.25.1314474444383;
        Sat, 27 Aug 2011 12:47:24 -0700 (PDT)
Received: from localhost.localdomain ([89.204.137.195])
        by mx.google.com with ESMTPS id 16sm2372802faw.42.2011.08.27.12.47.20
        (version=SSLv3 cipher=OTHER);
        Sat, 27 Aug 2011 12:47:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.537.ga80e5.dirty
In-Reply-To: <cover.1314472512.git.sdaoden@gmail.com>
In-Reply-To: <cover.1314472512.git.sdaoden@gmail.com>
References: <cover.1314472512.git.sdaoden@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180244>

Signed-off-by: Steffen Daode Nurpmeso <sdaoden@gmail.com>
---
 builtin/checkout.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4eaedff..6fb6d48 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -958,6 +958,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
 
+	opts.quiet = !isatty(2);
 	opts.track = BRANCH_TRACK_UNSPECIFIED;
 
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
-- 
1.7.6.537.ga80e5.dirty
