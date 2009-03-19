From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/2] gitk: provide a 32x32 window icon based on the git logo
Date: Thu, 19 Mar 2009 01:54:18 -0700
Message-ID: <9a1d5cc34e91679beec3e82c52512f33b2ba9d7e.1237451887.git.bebarino@gmail.com>
References: <cover.1237451887.git.bebarino@gmail.com>
 <61242ff6c582f3b82b7ddf4db75bdad45f0a457e.1237451887.git.bebarino@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 09:55:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkE2e-0003sJ-9M
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 09:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbZCSIyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 04:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754390AbZCSIya
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 04:54:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:1391 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbZCSIy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 04:54:29 -0400
Received: by rv-out-0506.google.com with SMTP id f9so465786rvb.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:in-reply-to
         :references;
        bh=4foI1FLpz9ZOMC16ifoC0PoPUC0IDQ+jl9NMtABxnDk=;
        b=aznha0HNezZY6GbIyLMkHYfC4aINyMGotE9ZXReiDF5XAtJraBTnFAvAS7M27IvLeE
         2WpSR1indOLR8KF12lFwbDiaemTsLrvivzQbowSiWmOm8O7y9BHs7/Cg+V7YdcKcS5PA
         ovy2TjUFADE9ui0ZklXOyxn0J+XnpSid7McA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jaGD0A2/v4lGh0ItOjUghWMK4GAaA+xMNek1z5DScH3Y9gO2dV7kABxDUPmsi758Tt
         ohP38q5e1p5pt0QWdak0LKfbFYPCNlzxSBTLYVMfv8Wvfhqvz3KHkFKm/9csO1zz+NpQ
         /8JojVdRbBN4IrZfLuxWF7+AX2MrG8ScgW6Ak=
Received: by 10.114.184.7 with SMTP id h7mr1477044waf.151.1237452867875;
        Thu, 19 Mar 2009 01:54:27 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id n9sm917934wag.46.2009.03.19.01.54.25
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Mar 2009 01:54:27 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 19 Mar 2009 01:54:24 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <61242ff6c582f3b82b7ddf4db75bdad45f0a457e.1237451887.git.bebarino@gmail.com>
In-Reply-To: <cover.1237451887.git.bebarino@gmail.com>
References: <cover.1237451887.git.bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113737>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 gitk |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index cfbb699..5a09eca 100755
--- a/gitk
+++ b/gitk
@@ -10901,7 +10901,10 @@ catch {
 	gitlogo copy gitlogoplus  -to 11 9
 	image delete gitlogoplus
 
-	wm iconphoto . -default gitlogo
+	image create photo gitlogo32    -width 32 -height 32
+	gitlogo32 copy gitlogo -zoom 2 2
+
+	wm iconphoto . -default gitlogo gitlogo32
 }
 # wait for the window to become visible
 tkwait visibility .
-- 
1.6.2
