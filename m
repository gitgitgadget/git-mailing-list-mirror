Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 652231F404
	for <e@80x24.org>; Thu, 18 Jan 2018 09:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755394AbeARJqH (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 04:46:07 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33983 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755002AbeARJqF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 04:46:05 -0500
Received: by mail-pg0-f67.google.com with SMTP id r19so7888460pgn.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 01:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6LbjqeDS0e8T/7ai2spEIy+tICWEMxCdNZ9aAUiK/20=;
        b=N5H0d4CVbMBxv3H3GKwPwAqRoMSOQY36TX3RJG1NRewrxOqamHWwD+b9sch4BAhhfp
         e9JmONRrcdV2t5Tn4aiHbOGjSPnlhUMRLOlOp345G55yKhYdi4eFvYgq7nz5tDLtF56C
         I3IkPhg0YRrzFBKl+IDQM7qareeKFbMAM1kQ1Jw5l80K4n5o3oIHlsreU8coAbhwxtfv
         wbRL6xQhRk/VBYEw95QfWybwYksD9+2P8tpc/ehlYYcdObsBRpMuLrZRiKNotf14c7aW
         4xJlMTu8pZFLioRF/ZC0/ST9IQp5lGPaMjLnvLWlIJHMN55BiCtxNnUZaCNTYPWB2+qN
         gcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LbjqeDS0e8T/7ai2spEIy+tICWEMxCdNZ9aAUiK/20=;
        b=A9UilchKTCMUUqvo0iyVdpP1ZSAlU3EKkmhtBBEY/pUAsFf1KMbRU8a54eZ0GEi004
         1g9SJKrda4bMedM/vC4AcoJwkGETdeVRG6FowTwvNpEyBr++UUtHu54eNGxoSsSk/+sW
         3Pbr6Kxqr60YLiaaFgLfC27aadE/Vl+AkUddIpxivmAs1Jjq7Y5NuwDsIMfXw5SkuUND
         6mzxddM7P4OeKhCJBGQPLXilDGjPPBprs+8WWwInU233M3/jjDho97UcQ8c69YEVbhtq
         7tENZedMbTojLvww0Pox5Tz6Z7tZESN8F8ExcxMt14imMoFFmJ/HK4i3YgayGkNkwbn7
         Xfsg==
X-Gm-Message-State: AKwxytel1bfKDA58UWSxfm9QweIyCkIr6cjdA2mp5YbQPPDJMQ7zz7W3
        H4tytnUhGLfjwtSYghwPlr7R3A==
X-Google-Smtp-Source: ACJfBotDex64lDPmqF/5ZhlyGU0Y9PgUoMs8eMDSKQ+2bI2mJ4pBRT9y+lEpv/pBUwsTv21to/xtfA==
X-Received: by 10.101.72.143 with SMTP id n15mr20601747pgs.181.1516268764982;
        Thu, 18 Jan 2018 01:46:04 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id z19sm11737518pfh.185.2018.01.18.01.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 01:46:04 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 18 Jan 2018 16:45:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 7/7] run-command.c: print new cwd in trace_run_command()
Date:   Thu, 18 Jan 2018 16:45:12 +0700
Message-Id: <20180118094512.27849-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180118094512.27849-1-pclouds@gmail.com>
References: <20180115105949.18328-1-pclouds@gmail.com>
 <20180118094512.27849-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a command sets a new env variable GIT_DIR=.git, we need more context
to know where that '.git' is related to.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 run-command.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/run-command.c b/run-command.c
index 1301b878c7..a483d5904a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -622,6 +622,11 @@ static void trace_run_command(const struct child_process *cp)
 		return;
 
 	strbuf_addf(&buf, "trace: run_command:");
+	if (cp->dir) {
+		strbuf_addstr(&buf, " cd ");
+		sq_quote_buf_pretty(&buf, cp->dir);
+		strbuf_addch(&buf, ';');
+	}
 	/*
 	 * The caller is responsible for initializing cp->env from
 	 * cp->env_array if needed. We only check one place.
-- 
2.15.1.600.g899a5f85c6

