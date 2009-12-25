From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/4] clone: set transport->verbose when -v/--verbose is used
Date: Sat, 26 Dec 2009 01:12:05 +0800
Message-ID: <1261761126-5784-4-git-send-email-rctay89@gmail.com>
References: <1261761126-5784-1-git-send-email-rctay89@gmail.com>
 <1261761126-5784-2-git-send-email-rctay89@gmail.com>
 <1261761126-5784-3-git-send-email-rctay89@gmail.com>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 25 18:12:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NODie-0002ZR-EB
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 18:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523AbZLYRMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 12:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756522AbZLYRMg
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 12:12:36 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:34685 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756476AbZLYRMe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 12:12:34 -0500
Received: by mail-yw0-f176.google.com with SMTP id 6so9018585ywh.4
        for <git@vger.kernel.org>; Fri, 25 Dec 2009 09:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Lb2zziIKfFbbMUMQcWVBjcaXr6aWwh8u4WsQ1W3+aU8=;
        b=EUtcMPVP/Zc65Uh0eXDTyqrmekhckn5tEM3U/FywgKX+McVe6hQmbOWY4tNCwpD3lk
         Bs0jWvceUQWWm/osKuDHd5YSQBrVZLuwdjZnXCqzG0ha0na1EH+yGm9hP1V3/H9vLjbT
         9Qpm3fJK1tcq0GC39LOtr9O5iUGYBZbEyWbTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Qh4uguTySavS7E61V1Ls7NM8On4REiA+1HCc2hAqpg35+HTbmACxnJoLQsriHpC7Jn
         Dcn3d6SeiX8pN5xWiFw37+BQphKYFl9Y8VKRPncQa2g017z2UQZz+pGzAcHLwBlpeNMu
         On5sSHTkhei1wOuC7Sm5LVgjWs32KcYTwE7dw=
Received: by 10.101.197.37 with SMTP id z37mr13208069anp.154.1261761154557;
        Fri, 25 Dec 2009 09:12:34 -0800 (PST)
Received: from localhost.localdomain (cm133.zeta152.maxonline.com.sg [116.87.152.133])
        by mx.google.com with ESMTPS id 14sm4629570gxk.2.2009.12.25.09.12.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Dec 2009 09:12:34 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1261761126-5784-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135679>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin-clone.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 5df8b0f..463fbe4 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -525,8 +525,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		if (option_quiet)
 			transport->verbose = -1;
-		else if (option_verbose)
+		else if (option_verbose) {
+			transport->verbose = 1;
 			transport->progress = 1;
+		}
 
 		if (option_upload_pack)
 			transport_set_option(transport, TRANS_OPT_UPLOADPACK,
-- 
1.6.6.278.g3f5f
