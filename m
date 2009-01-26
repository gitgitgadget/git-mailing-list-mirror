From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: ensure the default stylesheet is accessible
Date: Mon, 26 Jan 2009 02:28:42 +0100
Message-ID: <1232933322-9186-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 02:30:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRGIY-0006T6-Tw
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 02:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbZAZB22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 20:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbZAZB22
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 20:28:28 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:4481 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZAZB21 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 20:28:27 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3332683fgg.17
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 17:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fWxI/96H3btFPLEv4Z2uoC67HaIv/j+0g8+OzzUNgtU=;
        b=ec+VCaqkdSGPs9HXuxlDjNZzZoRUgJsX0eFWTjFwGCHVb28kmK5lidD/mBjIzGN7S1
         gT3vD2xxD5+6R5pYBSnrreI/c4MYllMsOvibTkAk1wYtpYLUiuaaAKXJjPRgR4RKXR8D
         8ihwY2ZlxsHuC9NGU5YDadr+ZHt7BGYhS1et0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Ak2m5iBbDOfrvTBJVj/R0bcsRu1GobxzaNKpMoXRq8GL0oT6UT2JXOt5Rv/oGIfFRA
         X3KrDvs+eNoCFHVQ35SNhSvwWF+hdi0wrpgxG8Y0iqdQOgyyRx/WXlmyavEn+5K+giJ1
         h7MM7Gfg1SUTVA++BHRgwBa4fLuB9lQ32oW80=
Received: by 10.86.33.10 with SMTP id g10mr621791fgg.75.1232933304934;
        Sun, 25 Jan 2009 17:28:24 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id l19sm3738558fgb.42.2009.01.25.17.28.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jan 2009 17:28:24 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107154>

On some installations the CSS fails to be linked correctly when
path_info is enabled, since the link refers to "gitweb.css", whereas it
should be "${my_uri}/gitweb.css". Fix by setting the appropriate default
in the Makefile.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 4ef8234..4f60de9 100644
--- a/Makefile
+++ b/Makefile
@@ -215,7 +215,7 @@ GITWEB_STRICT_EXPORT =
 GITWEB_BASE_URL =
 GITWEB_LIST =
 GITWEB_HOMETEXT = indextext.html
-GITWEB_CSS = gitweb.css
+GITWEB_CSS = $${my_uri}/gitweb.css
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
 GITWEB_SITE_HEADER =
-- 
1.5.6.5
