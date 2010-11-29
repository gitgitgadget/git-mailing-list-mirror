From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 6/6] web--browse: special-case chromium path
Date: Mon, 29 Nov 2010 15:47:55 +0100
Message-ID: <1291042075-19983-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 15:48:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN51r-00088I-6r
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 15:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560Ab0K2Os2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 09:48:28 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39547 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab0K2Os1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 09:48:27 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so1954069eye.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 06:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=usWQAUuv2Vabpk2fSFSKwFHYJP/PgY8Ap/4LpxJqoUM=;
        b=gyFZKKvXt8sXkJon/396nMZL3nBqBP7blJ/S5c/4lmVCd1u7z4Pe4msBHxgqwEwRar
         Fef/Z+ZM5VlJ228MWULkao9wVMjEnE36C0vyh6XaVor/Wk0jCWiozxHApJzQNSOEkoCX
         +8F8LOYVFkfqkSvXXjhjX96c5Cx28pqISwvz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pmntREZYY04VcG3ISMB9ahvY0geTT5Gk97oPE0S66MliCuWxXRBuosHcHhcwv/gX/p
         2o8PU19+5pjuWjq06WxHt3I39ax7KZdVNWgA5zuN95pHv/ZMN3HgcYO+jQ9/a/DAcCmX
         kzNfjBnUtAkTXHNCu6Ics8aeFrJRb3QKoNoDA=
Received: by 10.216.0.79 with SMTP id 57mr5715915wea.39.1291042106754;
        Mon, 29 Nov 2010 06:48:26 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id w84sm2426569weq.20.2010.11.29.06.48.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 06:48:25 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.624.gec6c7.dirty
In-Reply-To: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162392>

On Debian-based distributions, Chromium the browser is available under
the name chromium-browser rather than chromium, to prevent conflicts
with the Chromium B.S.U. game.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-web--browse.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index f991dd0..9cd66e4 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -42,6 +42,9 @@ valid_tool() {
 
 init_browser_path() {
 	browser_path=$(git config "browser.$1.path")
+	if test "$1" = chromium ; then
+		type chromium-browser > /dev/null 2>&1 && browser_path=chromium-browser
+	fi
 	test -z "$browser_path" && browser_path="$1"
 }
 
-- 
1.7.3.2.624.gec6c7.dirty
