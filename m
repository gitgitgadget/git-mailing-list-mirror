From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 2/2] simplify digit_in_number
Date: Sun, 25 Jul 2010 19:36:21 +0200
Message-ID: <1280079381-4548-2-git-send-email-ralf.thielow@googlemail.com>
References: <1280079381-4548-1-git-send-email-ralf.thielow@googlemail.com>
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 19:36:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od57u-0003zr-Cq
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 19:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869Ab0GYRgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 13:36:31 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51111 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab0GYRgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 13:36:31 -0400
Received: by ewy23 with SMTP id 23so627381ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IQWmnsdyp7NIq+BSDImHI7xf7GYonitqxOnp2BKLrTA=;
        b=viVycpXa3CZPb71lNKinWMGgYbxkjs6kDONGqNXl83stdwUGPngicfS9AHvR3LnBiG
         GKqwP6LDsi45RDXojE5JuuAB8mXvpE2O5LbFgtHTJSq8C67tKRVj/TGpqxA+dvJ7L5Wg
         79e7z0qxLbG46PKFnwWakglMciAHxX1y5GhwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VlJn6YaQ4PyCL8Nb8UehWb5nOW/Ecvrs07xzTnGN70Fv1umPhJu2xjnm3Kx6bTwofK
         Z+3ypBRzRCvQsjDyWnJm8vio6spD6kt1KEDiUWfGmC1zHYVwBriGXKytI3ys+lUtpqt7
         VW4rb796Y09HSQ2JWwmeHm2OU4ABFF5huJhCo=
Received: by 10.213.16.140 with SMTP id o12mr5506377eba.20.1280079388576;
        Sun, 25 Jul 2010 10:36:28 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-159-075.pools.arcor-ip.net [94.222.159.75])
        by mx.google.com with ESMTPS id v59sm4202286eeh.10.2010.07.25.10.36.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 10:36:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280079381-4548-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151766>

---
 log-tree.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 95a00a4..c2af716 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -254,10 +254,10 @@ static void append_signoff(struct strbuf *sb, const char *signoff)
 
 static unsigned int digits_in_number(unsigned int number)
 {
-	int digits = 0;
+	int digits = 1;
 	while (number /= 10) 
 		digits++;
-	return digits++;
+	return digits;
 }
 
 void get_patch_filename(struct commit *commit, int nr, const char *suffix,
-- 
1.7.0.4
