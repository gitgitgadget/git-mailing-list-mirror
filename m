From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 01/16] git-sh-setup: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:39 -0800
Message-ID: <1361665254-42866-2-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PLU-0000io-Ku
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759310Ab3BXAVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:05 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:61550 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759307Ab3BXAVD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:03 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so1047348pbc.21
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=zYJacMLbXysUf2hUnfxoFN5JbCT04kKEVDJ8WX7/NfE=;
        b=c6l1kAdl1RXYGL5qlKgm2eWoeiM1YqrOLBu+xJEUE5DJzFf4imw+k20Dk8CF7LymQR
         80CWUm6asdo8FuBxaH31rcmLrt2sj0OCRQAvwyT2jP12C3Z/5bgoCTgOnuNNfqBbL0yc
         3IsQUsdWUkVw6vGUQZGxZZIaJ26HLX8x9KCrDbQ1vrMc6wIuaOaVVtT1U7cFkpo0zpNx
         SdrEnk3bCLoi+W/aOVyyppxrcBjM+tOq1FdVRbWoS8T4D2kAzBe9vnZjwTtPQugulgzp
         dqT1H6hqtdoFRJrV9TeCyXxZUMAJa5VRXuJHTZ61qsgKXHn7ej18TybJuZ9jp93trXKF
         sG4A==
X-Received: by 10.68.189.99 with SMTP id gh3mr10572284pbc.203.1361665263094;
        Sat, 23 Feb 2013 16:21:03 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.01
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:02 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216940>

mergetool, bisect, and other commands that use
git-sh-setup print a usage string that is inconsistent
with the rest of Git when they are invoked as "git $cmd -h".

The compiled builtins use the lowercase "usage:" string
but these commands say "Usage:".  Adjust the shell library
to make these consistent.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-sh-setup.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 795edd2..9cfbe7f 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -84,14 +84,14 @@ if test -n "$OPTIONS_SPEC"; then
 else
 	dashless=$(basename "$0" | sed -e 's/-/ /')
 	usage() {
-		die "Usage: $dashless $USAGE"
+		die "usage: $dashless $USAGE"
 	}
 
 	if [ -z "$LONG_USAGE" ]
 	then
-		LONG_USAGE="Usage: $dashless $USAGE"
+		LONG_USAGE="usage: $dashless $USAGE"
 	else
-		LONG_USAGE="Usage: $dashless $USAGE
+		LONG_USAGE="usage: $dashless $USAGE
 
 $LONG_USAGE"
 	fi
-- 
1.8.2.rc0.247.g811e0c0
