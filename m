From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] update-index: allow "-h" to also display options
Date: Sat, 23 Feb 2013 19:10:41 +0100
Message-ID: <1361643041-19036-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 19:11:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9JZI-0006uD-0R
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 19:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758240Ab3BWSKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 13:10:55 -0500
Received: from mail-wi0-f181.google.com ([209.85.212.181]:45542 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758225Ab3BWSKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 13:10:54 -0500
Received: by mail-wi0-f181.google.com with SMTP id hm6so1863479wib.8
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 10:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=23DzhZADWREq9Tyhyegu8fkdvLe9aUVlhvXmcOXN5w4=;
        b=yu1FVbSjJvJ3kJD8Hm595l24yLfRD78PXS1096jvkS9DkyIFHkJ3OC5focD8RNGLIJ
         h5gfzy4a+aa7FaVIhFXBAf8H29wBaVoY1X/+IftFRcxBd8JPtlHAUUk55Bkn2G7MqAjl
         4YdJMkd4bozoUkOq1ZQPwk2vhccgzGPhwr0RWup5vjNX+1bo4VbSYsqqMRfEp0oyYIO/
         ntgi6JnXBrLtWMcgqRCjxMeQI+FVlC/offHr8cERIqkxkkFaZgxO8N0GrL8S2ih3z75b
         JllZJ308V4lsNPIu7ASKg9P24mAGJWKo5Fcqo148TcwPKjlEqM/TcYG9NN70A9tXpq+s
         TIJg==
X-Received: by 10.180.87.170 with SMTP id az10mr3703774wib.3.1361643053376;
        Sat, 23 Feb 2013 10:10:53 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id cf8sm5414978wib.1.2013.02.23.10.10.51
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 10:10:52 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216904>

Currently, when running "git update-index -h", you only have usage
displayed, but no options. That is not consistent with the behavior of
other commands. It also means that the only way to display options is to
use an unknown argument (or use the man page).

Display usage with options when "git update-index -h" is invoked.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 builtin/update-index.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ada1dff..3071ee6 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -796,7 +796,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	};
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(update_index_usage[0]);
+		usage_with_options(&update_index_usage[0], options);
 
 	git_config(git_default_config, NULL);
 
-- 
1.7.9.5
