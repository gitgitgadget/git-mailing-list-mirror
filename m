From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/4] completion: prioritize ./git-completion.bash
Date: Mon, 30 Dec 2013 20:22:15 +0530
Message-ID: <1388415138-11011-2-git-send-email-artagnon@gmail.com>
References: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 30 15:52:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxeCT-0005wb-Gk
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 15:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987Ab3L3Ov6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 09:51:58 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37512 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab3L3Ov4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 09:51:56 -0500
Received: by mail-pb0-f46.google.com with SMTP id md12so11560819pbc.19
        for <git@vger.kernel.org>; Mon, 30 Dec 2013 06:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+K1WDwncbCl1yl0jCGCC0F+1oq3zTGKgL0H9iaqhbKw=;
        b=AlzaeLRf/RwwSjcKgw5rstQJKr6aX+pMAPWZUzsOChnevbYxYm/Vl6uInVnMjz6SC0
         8TQngt+G0NIgSfEhG+amRbmMHfjwlVfd2Xd+eJcmdKW23uhM+S3Q8R2OIO4oDAZsN1E1
         C4EM8oI7ZyYmhQ420GPH4SMV7o0ap0bDU3gAt62uoRGfYP3z4tKAcLDmaPFEoVoMIcSm
         MLtzIcNVPWskrlIigIbr6AcSiirQSEihw0o2mT4fUe90O55CeCDGRSqA5nyx7nnX4iYI
         eaWI7ax28zDC/RZSVvp5GZSB2bsdDwZE0w5irMrW+u3diqXialUT0M+1kckQEc77Ask0
         HpRA==
X-Received: by 10.66.2.234 with SMTP id 10mr68282901pax.39.1388415116161;
        Mon, 30 Dec 2013 06:51:56 -0800 (PST)
Received: from localhost.localdomain ([122.164.121.180])
        by mx.google.com with ESMTPSA id vn10sm82123744pbc.21.2013.12.30.06.51.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Dec 2013 06:51:55 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239802>

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
