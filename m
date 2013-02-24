From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 01/16] git-sh-setup: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:09 -0800
Message-ID: <1361667024-49776-2-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Po1-0006ND-WC
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759437Ab3BXAui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:50:38 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61315 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759390Ab3BXAuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:50:35 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so1134542pad.0
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=VaFzDUlkLgUzdDWFtPyFo9wjAPW5LDsKCN3J1SCGgro=;
        b=zGGDhKlXIkNiobo3pZL08sc8Sl0VeWAB1l16RjAB5rYtartUfD2qSm6Rdwwoy39VEP
         q+JvwsfAjCdzpi6vnPafxKuh5mpM0F+sspJVXR4687lfkmJ16Yvqtv85LrXTTvvWMioE
         AMazoZniVHttE1FZd9uR/LKMCMM36cpHVAhwA0wDAaLKw/0YwlZQGGyn87u4Q480vjnX
         A/kG4xppvC4FydsUxndQbAgBQlWlIOgshrPCvGKJGtzd/QXm41G37PeVY/vs9VQJeYRo
         hbA+b6OdYPupkRHNxTjtEDV5cL/PVty8MNhQWRUH3jpxaYJXp6eW+Gj+NQvO5bTc5FJK
         odOg==
X-Received: by 10.66.159.132 with SMTP id xc4mr11498247pab.145.1361667035060;
        Sat, 23 Feb 2013 16:50:35 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.50.32
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:50:34 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216959>

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
1.8.2.rc0.263.g20d9441
