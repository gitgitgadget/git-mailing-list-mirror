From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 07/18] Some cleanup in get_refs_via_curl()
Date: Sun, 24 May 2009 22:19:49 +0800
Message-ID: <20090524221949.4e61f987.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:22:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Ean-0005ol-I2
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbZEXOVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753677AbZEXOVy
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:21:54 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:48930 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbZEXOVx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:21:53 -0400
Received: by mail-px0-f103.google.com with SMTP id 1so2153790pxi.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=R86on4I20cxntK2hN/J3lzz570RVq26MussRSCn95as=;
        b=ANy/LPm/Ix40o8yD/PNCOrImDCYm5FM0aMRJEtlC45aAEftI/yuwCKyrmmZqOhC03m
         Qu5ARH5V8pu/exnjcwDOBwZP2l8IsylfrQCAMpF1QivyBG9jivO87lPk5UrhqComySA0
         tduDW/QBWqefq4UD5a+c55Ov7qNGZDAfZdMy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=PVvRE7IuGcLjUNK6VGp5l0DtR2YZJWhjZP7+JBvu/BE9zvI4FHdQmPQDHwozd22qVL
         Recw/PEw7MWl+JIv/DHR9aOC+oG6RG2U4a7GyRWWM8EVfct/AOBo9V/YNPiL39VKXVMf
         ywiXiodhnWlFAGoboW/4XG0fwNdkPsu7rp48s=
Received: by 10.115.106.18 with SMTP id i18mr12521570wam.213.1243174915661;
        Sun, 24 May 2009 07:21:55 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id j39sm12515679waf.10.2009.05.24.07.21.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:21:55 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119832>

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 transport.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index 89d846e..b7c1c39 100644
--- a/transport.c
+++ b/transport.c
@@ -519,6 +519,7 @@ static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
 		free(ref);
 	}

+	free(refs_url);
 	return refs;
 }

--
1.6.3.1
