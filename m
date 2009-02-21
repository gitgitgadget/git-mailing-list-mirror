From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A v4 2/5] git config: trivial cleanup for editor action
Date: Sat, 21 Feb 2009 02:48:54 +0200
Message-ID: <1235177337-2532-3-git-send-email-felipe.contreras@gmail.com>
References: <1235177337-2532-1-git-send-email-felipe.contreras@gmail.com>
 <1235177337-2532-2-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 01:58:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LagCF-0000Yo-Os
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 01:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559AbZBUA4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 19:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754535AbZBUA4y
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 19:56:54 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:61718 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528AbZBUA4y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 19:56:54 -0500
Received: by bwz5 with SMTP id 5so3164120bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 16:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=i9C/+5fDNE4tJa4wsUYN3fRYLPPA9l04TK9IjiDWLQw=;
        b=B+MUqQWEvjk2240+OB8WVwVLKQylAQjhVBVav5uR84jOJlaYF2pfDxGsEfbdduJII4
         hztfn+DW5OVXl1K4TO/O+/T2J8LTJtzzy4ntNuNDyTq8U6wCNOK1voEavrufzuGwNbd7
         BhU3+NG8+qLNbGf8/F/92+LTBc2yjujRQH18I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S64NawvIFnydz1wwDI3st+VMmx811hoNLvQnAMJPfLtQNIML6cI21ATPyB5LL+VOY5
         R6C/YzSMcY32uhZjAvA1dq7lM3gnRIXtKAwYfMM1hOfe3INUABSJ22lGPK4V4s8pkTaz
         yGjPQ1R2RdloLmQCPrE0S4ROz3+9FteM0zQJY=
Received: by 10.181.199.6 with SMTP id b6mr478813bkq.68.1235177344657;
        Fri, 20 Feb 2009 16:49:04 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id f31sm4798427fkf.15.2009.02.20.16.49.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 16:49:04 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1235177337-2532-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110921>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index afc4393..d52a057 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -363,15 +363,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		} else if (!strcmp(argv[1], "--get-colorbool")) {
 			return get_colorbool(argc-2, argv+2);
 		} else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
-			const char *config_filename;
 			if (argc != 2)
 				usage(git_config_set_usage);
-			if (config_exclusive_filename)
-				config_filename = config_exclusive_filename;
-			else
-				config_filename = git_path("config");
 			git_config(git_default_config, NULL);
-			launch_editor(config_filename, NULL, NULL);
+			launch_editor(config_exclusive_filename ?
+				      config_exclusive_filename : git_path("config"),
+				      NULL, NULL);
 			return 0;
 		} else
 			break;
-- 
1.6.1.3
