From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 1/4] completion: prioritize ./git-completion.bash
Date: Fri,  3 Jan 2014 13:30:28 +0530
Message-ID: <1388736031-6068-2-git-send-email-artagnon@gmail.com>
References: <1388736031-6068-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 03 09:00:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyzgW-0005Md-PT
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 09:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbaACIAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 03:00:42 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:40502 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbaACIAj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 03:00:39 -0500
Received: by mail-pa0-f44.google.com with SMTP id fa1so15583736pad.3
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 00:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+K1WDwncbCl1yl0jCGCC0F+1oq3zTGKgL0H9iaqhbKw=;
        b=ZHU6l2BAZueIn86RBn3g6WNB1TZb1wD7qPGqmkCQ8McaUPgyT/+J54Nj9dthA8M+zv
         jfMIlbvZsfQZyf8WNC5ykXciXe1P4yue5FJLBpucvi3tmXymugB0ck8wp2ql2zjdVUao
         i4FMJL36dK5esyOsHt4NPWDehF6vtgvJ4cdHrHjJ8j0NOE0rVOFfJInslosltwlIAb03
         LCc/q3masS/fzo02qpA+i+JJy7wstYe9RJy68R3EQ1gRz1AKooBYIwZYPzN0JIIO67mv
         iPY2Pk9nRwX8dRGS1RhpB6uenBmpU4dceoKu3jjWrfDSnPzLCWTB+8eHXcP0hTvow5xq
         ltXg==
X-Received: by 10.68.244.103 with SMTP id xf7mr47589492pbc.50.1388736039106;
        Fri, 03 Jan 2014 00:00:39 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id gf5sm106943913pbc.22.2014.01.03.00.00.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jan 2014 00:00:38 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388736031-6068-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239907>

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
