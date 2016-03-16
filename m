From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH/RFC/GSoC 2/3] git-credential-cache: put socket to xdg-compatible path
Date: Wed, 16 Mar 2016 18:07:44 +0800
Message-ID: <1458122865-29447-2-git-send-email-huiyiqun@gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
 <1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
Cc: gitster@pobox.com, pickfire@riseup.net, peff@peff.net,
	Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 11:08:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag8NV-0007Ey-TD
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 11:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935039AbcCPKIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 06:08:30 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34393 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966040AbcCPKI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 06:08:28 -0400
Received: by mail-pf0-f172.google.com with SMTP id x3so69266049pfb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 03:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pZchU5rK7wVIlLsXMFkS0Q9/v4ylhrmx+sWXlvT6ZzQ=;
        b=djaJl4WHYcEvHcSaSV6B5pect5irM9dhtTP+B2L7AN2o/H2/d3tLnbRYZFVvRDYV60
         Z3jYvJ3pNEacEhAxYZ/aCO/bosubJxe78Vmnp6qvnr2YDhteqrbIMBtZaI6W4Gt1akAY
         q2J3tO0xBerMWc/vwT9Z1nxmcPFrjZd8j6XDuvDt6eWUPMdLHjwU3/iLOJR9mKQc52mN
         sfyTWDJ5bTNTHfJ7gsev/c6bguBo3VX0hNlAJ3wWJOt1xTRzulc3GAN9eI5acwGZ51bP
         rwR85lfy7UgR2CHGNANstMD+u5D93JR2Cdr4fkB95d3RH3MnB4Z0I1Hz3pYo3iT9z3tm
         qIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pZchU5rK7wVIlLsXMFkS0Q9/v4ylhrmx+sWXlvT6ZzQ=;
        b=TjZwtAIQudTbxFKva1Ef3G6Naa7BGTg3duSDLiIPLAYisk7PK2zq7nv9fu+g442r3k
         6CbimGohunnxa4HoBT0GqWvpUwScWoe9dlqNxSuQjgEVHFKguFY3fijUE9lMX08mk2Ua
         S40eK/8D/tANcWRpmeWURmnqLL8ztpB9DYlEDM+yhMFbiWcTEqTwhu+SuyOoft7h347J
         VZZYeH3K4qaQuF5KUjzlttKE3scW9YT1r2ka+rVIfIoFtB8IobYlMLNyPe5FoYvjsAhv
         TI7voTTmuaqtdXiUNVd+zSrL3h36MfEkFpBh0Efs9Y4dlHYJ9U7EO01agqSUArLZ2kTI
         Wm+g==
X-Gm-Message-State: AD7BkJJDco1TxFkEUJvq1RTHsYfv7tp40E9dqhL/v3XsjnmDt9GefDlxDr5v2FfxVbVAiA==
X-Received: by 10.98.64.4 with SMTP id n4mr4559010pfa.58.1458122907751;
        Wed, 16 Mar 2016 03:08:27 -0700 (PDT)
Received: from Saturn.localdomain ([128.199.68.97])
        by smtp.gmail.com with ESMTPSA id n68sm4275755pfj.46.2016.03.16.03.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 03:08:27 -0700 (PDT)
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288953>

move .git-credential-cache/socket to xdg_runtime_dir("credential-cache.sock")

Signed-off-by: Hui Yiqun <huiyiqun@gmail.com>
---
 credential-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential-cache.c b/credential-cache.c
index f4afdc6..40d838b 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -105,7 +105,7 @@ int main(int argc, const char **argv)
 	op = argv[0];
 
 	if (!socket_path)
-		socket_path = expand_user_path("~/.git-credential-cache/socket");
+		socket_path = xdg_runtime_dir("credential-cache.sock");
 	if (!socket_path)
 		die("unable to find a suitable socket path; use --socket");
 
-- 
2.7.2
