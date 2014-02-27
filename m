From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] Change branch.c:install_branch_config()
Date: Thu, 27 Feb 2014 20:27:41 +0800
Message-ID: <1393504061-30008-1-git-send-email-sunheehnus@gmail.com>
Cc: Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 13:29:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ05P-0004cL-Lb
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 13:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbaB0M3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 07:29:07 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:49610 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbaB0M3F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 07:29:05 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so2462840pbc.38
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 04:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/7w5Nyh9f43bAEofc0CLi71xO/jeG89VWbqpVV4+9Sk=;
        b=qy64/o2mNn6dGjBm4aHW5qo5cE1HS9T6R0I22ugZdL3DCy2b+JsSSQuok5NNpctJEu
         zPN8y33CJh0OftLgn9P/2d0ZzqA63YVisUSDJ5vzoBiB9/PZoz5e/JqETYtUFxybvG/0
         agO2cIrDq+37J24UiNIW1Uynir7r16uGI4IwbjZevGJckBvZBOefPJNM2NvN9b9zpr9J
         kdRCAt2dhTcTydUSWxiRf2V602SFa3yO+RGh+5bohcvrS9o66HQLAgaxuVURUQPNALgF
         evOwOMBvm1oq4KjsyzrYkV2l+BsfrQiXEWosHLsdcAC1bxK/NkVrWaE64nb6hUA5j8ML
         QoRQ==
X-Received: by 10.66.122.36 with SMTP id lp4mr15215063pab.82.1393504144467;
        Thu, 27 Feb 2014 04:29:04 -0800 (PST)
Received: from localhost.localdomain ([61.150.43.99])
        by mx.google.com with ESMTPSA id ha2sm13124196pbb.8.2014.02.27.04.29.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2014 04:29:03 -0800 (PST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242814>


Signed-off-by: Sun He <sunheehnus@gmail.com>
---
 branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..2fe9c05 100644
--- a/branch.c
+++ b/branch.c
@@ -50,7 +50,7 @@ static int should_setup_rebase(const char *origin)
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
 	const char *shortname = remote + 11;
-	int remote_is_branch = starts_with(remote, "refs/heads/");
+	int remote_is_branch = skip_prefix(remote,"refs/heads")!=NULL;
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
-- 
1.7.1
