Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 085EF1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 13:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbcFPNS5 (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 09:18:57 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33474 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbcFPNS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 09:18:56 -0400
Received: by mail-pf0-f177.google.com with SMTP id i123so16320276pfg.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 06:18:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXtCASdFggdBeQldYTWWZ4I7rIqhzONHZoVasRzfOzs=;
        b=Ts0Hy1kko8PT0vtUibzZZHAtKPymlc0EVsK/nohgXBubz+bSsZRpKwi8mXoTrkXQU+
         iUtB+BZOFSvilh14PpLnxx3drtPhR/sla5q7z73IAwiLfikOLFVm9nPBV/iQJld8u1s1
         QEEUgOGALNNztMPXHIF1/jSoJpn7U73HXtD1F3CFJa+YCCdOUFket2z0bXSHR5iykx/B
         X+XQ3GQvKe8RA/KcQSAzGhvNi0GT7joBIdyq5vXTb+ZshLw5mFF2D8+dbDL6kk8hn0Y1
         0Oqigl4vQpZtYONAlxYQ6NTpsBypLNR0Ss9zbdpYSVC8wp8wUEi73IsLh4iGev1GQSQ4
         Coaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXtCASdFggdBeQldYTWWZ4I7rIqhzONHZoVasRzfOzs=;
        b=DmvDwDlNzyRPMcBrKbAhyfUhWcxqP+zfqz8mIsxNC8rkC59zzAXIu+4QCmHm946uNh
         8JAf/4EywdRXep1ecFMelBaAC6ijXeT1Zbm2EBdyzn4zpgU1tOjffLhPO7XMCeyWkRyf
         GM52/lMfH7qFwSmIB1oqm2UVQ6hsyE5UJWlDdfVd4Z+3c8TgBiAaMlOgFn37eIH1AHQX
         RM2spG2nk0weiV2jmgyDaqmQfJOnlm49z6XVL5YKM0s5Wbn48PqMi8ED66RZxJugTTc8
         M9di9RL3LCIA7qC1X3cA/wv8V+hki63zlWv4+QzO2L/R61ngP2zZZDrm16j91U1e0UDE
         7xNQ==
X-Gm-Message-State: ALyK8tKwx0UE1dxD5XAIPuvl8eln54eMAbUXfrwpNV+KO4OLI389rO12PJw/HJXSVHbeDg==
X-Received: by 10.98.2.74 with SMTP id 71mr5086057pfc.49.1466083135402;
        Thu, 16 Jun 2016 06:18:55 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id k74sm48625404pfk.78.2016.06.16.06.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2016 06:18:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Jun 2016 20:18:49 +0700
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, josef@kufner.cz,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/2] Log pretty format alignment improvements
Date:	Thu, 16 Jun 2016 20:18:36 +0700
Message-Id: <20160616131838.14440-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The first patch was from a long time ago. The concern was it may be
breaking existing user expectation [1]. I still maintain that it's a good
thing to do and should not break anything. Hence the resubmission.

The second patch adds negative column specifier to >|() and friends.
A positive number 'n' specifies the n-th column from the left border
of the screen, '-n' specifies the n-th column from the _right_ border.

I have been happy with 2/2 improving my "git l1" (fancy --oneline)
printout for many months. It's definitely a good thing to do in my
opinion.

[1] http://thread.gmane.org/gmane.comp.version-control.git/277710/focus=278326

Josef Kufner (1):
  pretty: pass graph width to pretty formatting for use in '%>|(N)'

Nguyễn Thái Ngọc Duy (1):
  pretty.c: support <direction>|(<negative number>) forms

 commit.h                      |  1 +
 graph.c                       |  7 ++++++
 graph.h                       |  5 ++++
 log-tree.c                    |  2 ++
 pretty.c                      |  9 ++++++-
 t/t4205-log-pretty-formats.sh | 57 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+), 1 deletion(-)

-- 
2.8.2.524.g6ff3d78

