Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FDB620179
	for <e@80x24.org>; Sun, 26 Jun 2016 17:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbcFZRQZ (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 13:16:25 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33948 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbcFZRQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 13:16:25 -0400
Received: by mail-lf0-f41.google.com with SMTP id h129so143362055lfh.1
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 10:16:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SuBcP9iuZRdqpqd974UCtYRQtEQO+m8nk6mM9YlSgDo=;
        b=YbFPva83vntdTUFV+ckb4IodR26Gik73sO58CA0SOeH/NFIIHYxGluZaUth6kdbxCp
         8uu6VIL1ZyOCqaOtwZIJh3ZCxvFPW3uo5ZFVuR5bsX6ETxZLl1pU4A3mX/wiEIuf0Jcw
         3DF62FVq55J0D20Gwe3tXS4aGCDIbSl78OlpVGtbe4IDhw60SwxiO0woTTqsp2J71wXw
         zn1G66yxKtuXKxa+frMnOU7hWysSRAMcqBrh5oYbJaoKxlg8Gq2FtOzAiDvYZTdq6ggn
         8hh43NgYH9GCpasV8IrgYiVsKpwYfujzvVC2XkZXkpJY4vJNv1c4K6zVXwm+cSMrtE7t
         Gebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SuBcP9iuZRdqpqd974UCtYRQtEQO+m8nk6mM9YlSgDo=;
        b=VU9zf5GTVAfrk8z8wuQQLaoEZXqqGjytt9EAEAzCSDGTM67rcKfVMpJJuI9xqI+2dX
         9Mr6CfcMV67H6a/R41oDtJZPR3GUyhMoluKdzPC+Dcb8Stm3+V0Vqv+lfJefdRNgxmnh
         g2+15jDT4zq46+56E/x5NedtM9xBR5UZYJJFtzbFkz3mifOl1RkA7lXs0hwcp/tHa0Hh
         /itkhzNB9qAmCBBn29329X3PQ+pIRz1SkF36SopXKY0wzyABxO7S9QaIZO+VbKvn3FmJ
         kcgzF3/WhjStOWGNW5JiGbjfTh/P1L7N0jDA/hpVvX/wPkyjywelq8lnpxh4Znth4gqj
         k0kA==
X-Gm-Message-State: ALyK8tLi+1Nv2HKglINjeFI8p+A/smeCcqf/eB2zrKSl57n4VW760Xhovx3ajac3ismTiQ==
X-Received: by 10.25.157.77 with SMTP id g74mr4300293lfe.10.1466961382960;
        Sun, 26 Jun 2016 10:16:22 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 76sm2624773lfu.26.2016.06.26.10.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 10:16:22 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] diff: add --relative-names
Date:	Sun, 26 Jun 2016 19:16:13 +0200
Message-Id: <20160626171616.27948-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

For more explanation head straight to 3/3. The first two patches are
preparation.

Nguyễn Thái Ngọc Duy (3):
  diff.c: refactor strip_prefix()
  diff.c: separate "prefix" from RELATIVE_NAME (aka --relative)
  diff.c: add --relative-names to be used with --name-only

 Documentation/diff-options.txt |  4 ++++
 diff.c                         | 54 +++++++++++++++++++++++++++++-------------
 diff.h                         |  1 +
 3 files changed, 42 insertions(+), 17 deletions(-)

-- 
2.8.2.531.gd073806

