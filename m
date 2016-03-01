From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv21 08/10] submodule helper: remove double 'fatal: ' prefix
Date: Mon, 29 Feb 2016 18:07:18 -0800
Message-ID: <1456798040-30129-9-git-send-email-sbeller@google.com>
References: <1456798040-30129-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 03:07:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZj6-00034x-6s
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 03:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbcCACHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 21:07:40 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36022 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbcCACHh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 21:07:37 -0500
Received: by mail-pf0-f178.google.com with SMTP id l6so5431530pfl.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dqxBslUY9rHxLlIMKB7NcS9GiWd+/C+VaRE9+Loj95Y=;
        b=itUXTQz1FY0QuoWKxXFfxwXULpg6Rk42mdufQTQB1kSMBeK+tZgz0W+mOdbknqxLjg
         tY6iQe7M1vq9zSQtJsnBzkt0b5tK81QZMhhH8BCy6jD+B8pFsIFgvH6ELbDe0ShZ6ApL
         YZ4II/a/KWBNTJRPHcoyBMgFzORMbG+ZIzHkjckgK47nmVZqI+I8TpL+QesCXQGDFAWa
         tyFBYua5CRyF9kMfse9X5cwMWilttOPjk9oJEgEcVimpqnEjTERhds8vh9VsQ0HmH3YD
         Qlx/1uLQkRhOXRUSPmX/pvwDUo0cji0iUultB1tIqYMtvF/cydmyQB+Pd9o4BCbVJrif
         UHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dqxBslUY9rHxLlIMKB7NcS9GiWd+/C+VaRE9+Loj95Y=;
        b=Kxc4ZHL61Cn24d8+RFk5folMNst1sJAI95qC0RNNeHKg57/D3Ds8Q8GckNGqAGkTGx
         S+8XCltDrTXGktAFdlY33XXBJckgyQ7xQSmaIzE7VAb14frhhb5KCV8phla/FVPwJ4hK
         24vpmjvFCwOF3M+Bf5KqDW3N1TsnuzE8+jhh/PXpaiSbbgpvFlqEzF8PcnvsbD8fUjjn
         +wR7psxJv06r97jpu+ZkdsG39pYlymeyH6+6SW21DV5RFzyM6EaowyJgDjcvMWIEx6be
         CHBevb+7rnZva24U4bLdBuuIfMZD/dR2z6WnkdfbkNZHvmVz78ZjIvqiDcgOhQTbiDMt
         FlDw==
X-Gm-Message-State: AD7BkJIjRGK0RSmp9Wrd6YfCUekMucWlrFaKuPMkyCj9kw9Nxy9CTr8V/oxTZyi4kc7G2gy2
X-Received: by 10.98.19.215 with SMTP id 84mr26676068pft.22.1456798056287;
        Mon, 29 Feb 2016 18:07:36 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id ql1sm642339pac.24.2016.02.29.18.07.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 18:07:35 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.1.g68b4e3f
In-Reply-To: <1456798040-30129-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287991>

The prefix is added by die(...), so we don't have to do it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fd2b168..9e8109e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -516,13 +516,13 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
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
2.8.0.rc0.1.g68b4e3f
