From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: remove duplicate code and not needed break statement
Date: Sun, 18 Jul 2010 19:49:59 +0200
Message-ID: <1279475399-6081-1-git-send-email-ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 18 19:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaY0C-0007kW-2s
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 19:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756819Ab0GRRuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 13:50:07 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63428 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756789Ab0GRRuG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 13:50:06 -0400
Received: by eya25 with SMTP id 25so839887eya.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=BE3+sgc4PuOyLkCRwVU01Ae5cKbQUzpsKg4gB3qyJi8=;
        b=amyopEizzUiPJJdKTa7wXiGg9yEYQ5SBhZjecIA99FAJDEN9GrTIoCMfMm0UlsKAvZ
         dpK6Xz0OlMLp43uwF8Y5uRF/M6xGPWsh5KFteem7LsTaHdhyxkqrBswK04C0i7TbFqBK
         WvOqCdC7Ep+6UglvITpZEK9BVCVl9M6fsDKMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=hBqDDoV5CyA1ICHqUVnZ3RJ/wf+5FpTKuXc/LTtz0TCLomV7tDjZfHogJXLY24aUCY
         KcIT0L/zmlCWYpSbrk9fRrrf+UQh6piQhLA5cjGpwRTHrebo3IFOeaZKGkLFzt1stJ0u
         y1DQwdr15aYami2iVB1h5lebYuCxiIrpe59Sg=
Received: by 10.213.22.18 with SMTP id l18mr3503121ebb.85.1279475404868;
        Sun, 18 Jul 2010 10:50:04 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-159-075.pools.arcor-ip.net [94.222.159.75])
        by mx.google.com with ESMTPS id z55sm39496218eeh.21.2010.07.18.10.50.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 10:50:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151224>

Remove duplicate code and not needed break statement.

On switch statements you can use multiple cases for one
statement and on a goto statement you not need a break.

>From 5b3e7c8f8b81a295b5c58534be250f5a818ccc64 Mon Sep 17 00:00:00 2001
From: Ralf Thielow <ralf.thielow@googlemail.com>
Date: Sun, 18 Jul 2010 18:48:58 +0200
Subject: [PATCH] remove duplicate code and not needed break statement

---
 server-info.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/server-info.c b/server-info.c
index 4098ca2..9ec744e 100644
--- a/server-info.c
+++ b/server-info.c
@@ -113,11 +113,8 @@ static int read_pack_info_file(const char *infofile)
 				goto out_stale;
 			break;
 		case 'D': /* we used to emit D but that was misguided. */
-			goto out_stale;
-			break;
 		case 'T': /* we used to emit T but nobody uses it. */
 			goto out_stale;
-			break;
 		default:
 			error("unrecognized: %s", line);
 			break;
-- 
