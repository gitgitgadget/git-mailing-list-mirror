From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 1/4] completion: prioritize ./git-completion.bash
Date: Sat,  4 Jan 2014 01:26:59 +0530
Message-ID: <1388779022-14536-2-git-send-email-artagnon@gmail.com>
References: <1388779022-14536-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 03 20:57:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzArv-0003At-Ro
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 20:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbaACT5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 14:57:10 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:57906 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbaACT5I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 14:57:08 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so16004737pbc.25
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 11:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+K1WDwncbCl1yl0jCGCC0F+1oq3zTGKgL0H9iaqhbKw=;
        b=y3N+O8xc4/6mBXIQJMGk4AkvGlbAzr/R1aP0I25TO6gRUCJQ/N2Ff5iTwHrZf6U8a0
         i+q0JARIE0OYMbOkWYUePbUH/j35hdKbhzv6dM0DRel7FKj8oMpXbT7J+shYlmmVEeXv
         YfmDRDVG1JokKrEQCNC3JXQZ5bGi0cWaAPw/ZBgi868KOIo9Jz2cE99RTw6Br5KuGSni
         RS2zR46oxDuFZMnGGoNep3uZZuNFiW1kPSzXxLHL0LlCVxBZPTTXicEX8EsDbuntUddi
         r28sB0abIorkpQogF6tTn0kugtOcYsKlIcsCzGdmhJ7/VIul3bNouw0pDWv0g0N6J59e
         Jijg==
X-Received: by 10.66.27.177 with SMTP id u17mr95882019pag.25.1388779028335;
        Fri, 03 Jan 2014 11:57:08 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id e6sm110782903pbg.4.2014.01.03.11.57.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jan 2014 11:57:07 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388779022-14536-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239930>

To ease development, prioritize ./git-completion.bash over other
standard system paths.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index fac5e71..6fca145 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -30,10 +30,10 @@ if [ -z "$script" ]; then
 	local -a locations
 	local e
 	locations=(
+		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
 		'/etc/bash_completion.d/git' # fedora, old debian
 		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
 		'/usr/share/bash-completion/git' # gentoo
-		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
 		)
 	for e in $locations; do
 		test -f $e && script="$e" && break
-- 
1.8.5.2.227.g53f3478
