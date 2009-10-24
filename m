From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/2] user-manual: add global config section
Date: Sat, 24 Oct 2009 12:44:48 +0300
Message-ID: <1256377489-16719-2-git-send-email-felipe.contreras@gmail.com>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 11:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1dBb-0004ka-Sl
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 11:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbZJXJpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 05:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbZJXJpH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 05:45:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:64087 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbZJXJpC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 05:45:02 -0400
Received: by fg-out-1718.google.com with SMTP id d23so532718fga.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=z7g/wQNo5HxMxmqSPzUOBYMfsaAg6QUTV8PAr8mWJLY=;
        b=wRIq86OWA0/kKFgi2TUJrXilNtv5NjR3ZFnR+tx/3mua4bvHe1ddQ9io5hwfaEpsrQ
         yPUXU63AQB2v6omUMsy2ftdnYHkq83cHUyLvB5sQVuz5udSeE9AQKloPr9u87nbFm/WM
         +MP5LyFTktmJQF08jbDekUlmcNDDl+7oRF/2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=upwb0D/HZIrkGuKkiMPcz3jJ2bGzlw2SrSQa7vik2BafWQ+e0ae/vPiYSs1NmOk3FF
         5h3gudhsysVkjDanAt9ppn4KsamKMMeHgi8ci1qiy1bjF4lXCC3cjPEhbUixntVAIy+l
         uPJiFfDVMFvAdxO0wRQ5wWrZxXtd8Mj9jZQxI=
Received: by 10.86.187.10 with SMTP id k10mr772812fgf.49.1256377507065;
        Sat, 24 Oct 2009 02:45:07 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id e20sm5569936fga.10.2009.10.24.02.45.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Oct 2009 02:45:06 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1
In-Reply-To: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131151>

Comments from Michael J Gruber, Jonathan Nieder and Junio C Hamano.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 67ebffa..3fcbc36 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -40,6 +40,35 @@ without any explanation.
 Finally, see <<todo>> for ways that you can help make this manual more
 complete.
 
+[[getting-started]]
+Getting started
+=============
+
+Various configuration options affect how git operates. Some are specific to
+the user (e.g. if you prefer to see the output in colour), while some are
+specific to a repository (e.g. what other repositories it interacts with).
+
+For example, you can tell git to use color in the output of commands such as
+`git diff` by setting the `color.ui` option:
+------------------------------------------------
+$ git config --global color.ui auto
+------------------------------------------------
+
+Note that in this case the option is stored in the 'global' configuration. If
+you don't specify `--global`, then the option will be stored on the local
+(repository) configuration, which is probably not what you want.
+
+The options are stored in plain text files that you can view, or edit manually
+using the `--edit` option, and the format is very simple:
+------------------------------------------------
+$ git config --global --edit
+[color]
+        ui = auto
+------------------------------------------------
+
+This manual covers many configuration options (such as `color.ui`). For
+more details on the `git config` command, as well as all configuration
+options see linkgit:git-config[1].
 
 [[repositories-and-branches]]
 Repositories and Branches
-- 
1.6.5.1
