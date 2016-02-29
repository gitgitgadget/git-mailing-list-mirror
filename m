From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv20 10/12] submodule helper: remove double 'fatal: ' prefix
Date: Mon, 29 Feb 2016 11:14:08 -0800
Message-ID: <1456773250-5510-11-git-send-email-sbeller@google.com>
References: <1456773250-5510-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 29 20:14:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTHL-0005nN-Se
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbcB2TOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:14:40 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33657 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbcB2TOb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:14:31 -0500
Received: by mail-pa0-f41.google.com with SMTP id fl4so96789585pad.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uydZBib9IwpRSjqOZOXvs1lyQFfCKqmjDqPiRjAUu4s=;
        b=hoJzrUUH1BSQjZ5nvaX76/bGc32aeTnAMwQoqj5+PnCV++NzZedPISkx4f0JuaiAyQ
         Gff3IpIDHwFy2EGBETnScJjWuN+DrELYP4K1nEid2SiENegydFwBuX24DIDjbPyq8Gqw
         we4R7SnL+o1eUZf1eP7xq5eeQa0gBlqPGAxH9rBq8dOu7gfSo0Cl0ZKgKukIUy6Sgasi
         ajejJyA/kcdtyVkGMkL+5ydf6rosbhPGMtvvtJpJjrqsgSWgITfrPGoY/ZZtgf6O1Hl0
         ygf6IFpFjtFej0J42hYuft6Vp4zV+XmPk/4afp8VdrZ2HkRcAT2TW7nk0zzVNpVq9617
         wqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uydZBib9IwpRSjqOZOXvs1lyQFfCKqmjDqPiRjAUu4s=;
        b=nBxsmpX22QfEvN8oBJPBASekAMlnf//cbvGzxQK9uyxNneOSK2VcEkupJkwd02jaH0
         LhxwvtKaGHkrzJCd9l1udRV2lEtsTXxfCfnIuBxHX79hawQAzCNmFeMoxHWglcnkXD43
         BDrSQlS7mJp+XlPZShrePq003YeSyPoU2C+uCEf7iR+D5lT0PyNOb1DP4lqhWh58G/gL
         4EVzdjbjheNDMAtA96RAUwWWVdb8coGJHMBlkFWwm9PbRreGKE8VlsrkCPEcpzB7Uuuz
         4q3OjLDMaGnDbt337DC+LsuCBS7zZusf8dU+bFy5O06eKf/iVuTrDspFmJiupGbRGVTC
         IsRw==
X-Gm-Message-State: AD7BkJKlIqc8luzH8wqoqG+1Uh1lGj1BG2KockdZ4sfvF+DhMEbw1Xs7nBTL2lJ2DC2u+qsY
X-Received: by 10.67.6.72 with SMTP id cs8mr24455699pad.138.1456773270830;
        Mon, 29 Feb 2016 11:14:30 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id 27sm39858994pfh.48.2016.02.29.11.14.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 11:14:30 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.37.gb7b9e8e
In-Reply-To: <1456773250-5510-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287882>

The prefix is added by die(...), so we don't have to do it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e1b60ff..a111fd2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -519,13 +519,13 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	if (argc < 2)
-		die(_("fatal: submodule--helper subcommand must be "
+		die(_("submodule--helper subcommand must be "
 		      "called with a subcommand"));
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++)
 		if (!strcmp(argv[1], commands[i].cmd))
 			return commands[i].fn(argc - 1, argv + 1, prefix);
 
-	die(_("fatal: '%s' is not a valid submodule--helper "
+	die(_("'%s' is not a valid submodule--helper "
 	      "subcommand"), argv[1]);
 }
-- 
2.7.0.rc0.37.gb7b9e8e
