From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/11] completion: zsh: don't hide ourselves
Date: Thu, 19 May 2016 23:58:38 -0500
Message-ID: <1463720325-8853-5-git-send-email-felipe.contreras@gmail.com>
References: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 06:59:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3cWv-0001mJ-SO
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 06:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbcETE7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 00:59:15 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36017 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbcETE6u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 00:58:50 -0400
Received: by mail-oi0-f66.google.com with SMTP id g16so7294546oib.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 21:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ek168beltmD+EWNzeMak9gQ/+san3Z2DMBHH35KpzEY=;
        b=CmwIKywakkR0eaimgOzck34PRARZEI78Wi/egJPvUMnwHCLQl/TfiLekf7B0R88T3t
         uIztZ8Wp7Vzz3Xl6/ceG/9f4EPVk5ubLA/JIEy1f227iuIIwwq/to77vyNXnvCxxLTjS
         Mhd11pW0Fewzjm/yYVCuzfod2xLdiTHPykxk+i4L41xOJjpXIuV0bQJ7oNUfsbY8o/6U
         NyKSJIMmKLSC35YhHMqxXaQOgO53/ybpmvtIr/1+4GgPp0CiKI+mA2WG0JJUzfoouVYi
         erfgJCpipbDwDE8XGu3fRBPPB+cSZ85j2ceTlLZCEODtzxWMYgITGUbY8NALPgwoz8K0
         k8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ek168beltmD+EWNzeMak9gQ/+san3Z2DMBHH35KpzEY=;
        b=Tf2C9po16nDvol58bsQhlNw9NMKU40V0v4RxeahtAjk6MhU4ajDe2aMcgCytRlWM/2
         zwA8OHwuwdB+yhSYAf8GBLQyhIq8bbtNw0CQynXq2d1AxjSBT84gvno+1XYJKcbWWT0v
         MdN9rNzw7l4RHp4llcjRP49B3ppwqQecCAvIMPAoEVVbI8GiTIB80q1xx2eACmurT08I
         XNRp4gdk0RTW5DinL71h/kKAJsmdDNS5h3F4+yhuR5m5mUCcgsX4xrL1tXc5HPfcDWwZ
         9cX/pMxUhLGYRxafggQXxmp+joLJbzOZMms6wDxOvDadE8hKTOjDEWiE20KBoc4l/899
         e/qA==
X-Gm-Message-State: AOPr4FUudxaCKhc47eMupH6cKxBWF0hL9WD48gidAlTLT4eqhPv22x5dNCY2BDewBPwOXQ==
X-Received: by 10.202.225.6 with SMTP id y6mr585449oig.186.1463720330192;
        Thu, 19 May 2016 21:58:50 -0700 (PDT)
Received: from localhost ([189.208.111.205])
        by smtp.gmail.com with ESMTPSA id m2sm4804737oia.1.2016.05.19.21.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 21:58:49 -0700 (PDT)
X-Mailer: git-send-email 2.8.0+fc1
In-Reply-To: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295147>

There's no need to hide the fact that we are on zsh any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index e255413..475705a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -39,7 +39,7 @@ if [ -z "$script" ]; then
 		test -f $e && script="$e" && break
 	done
 fi
-ZSH_VERSION='' . "$script"
+. "$script"
 
 __gitcomp ()
 {
-- 
2.8.0+fc1
