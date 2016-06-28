Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F6D2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 17:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbcF1Rcf (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 13:32:35 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:32923 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbcF1RcL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 13:32:11 -0400
Received: by mail-lf0-f43.google.com with SMTP id f6so16445198lfg.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 10:32:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s6GzZGv9NAnsNlaDuZ4dM8nGRbpu6ZAjzpfZWxERALw=;
        b=bvnqusgEln9sej4jwSeg3dtB7XfNIUvDQLFzyHsKww9WB0QQPG0Wmxmm80IHyd3jJG
         Tu4CWs6IEARoB8s1KeVbBl2pNT3VHt3Skdwsxu3+IW7xwB2y4xRGSESMwyarkUGLTcE2
         /UL1emrIzl0J5QHAtFTgAUBu1y1dsilAvb1Gw0DyktbE3oRPEgJ6Q50ZkC5bCDijcFbA
         P/3AowzHKVwHmDEW+REkybK7+vCZ54vgVEUWwzs/Ms6IGF9WHLZvpDxxR58H2d5GPQ0G
         SiqH15JQB3QRhlaTS1ujTvcXZDP47xRs7pwL5g0RPCGsi/9cvn8DikIyGVTXhjY5LSyw
         +YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s6GzZGv9NAnsNlaDuZ4dM8nGRbpu6ZAjzpfZWxERALw=;
        b=jIgrjY5UuJ7cze0DfevWSc2P8/w/+29jcBhrZwIvptJ4h2ww5+Fx+f6p7hhuhjYnLp
         T2Govimn4ayGOtk2XZTPlw2S4K4GxqAiTQ4vaUFJM2q+mHNrwhXMXs3/R09BWJ6HukGU
         cpn9rqrFC5UyPgIMFrR8ZSYvpncBQXBLZr3nV9iAd9dDbsyI6IZ5QfPgaEpUybwATkG1
         2GMluzfH0vyzfQMGzH3zwVK8YjoN2p6uReJgUwofWhVJ47WW7zjd93io8VCkR2axTg1A
         60rBWxHwYcmO9FOqAW05CDlfRApm7jysPbS4kyc+ysOSEC9VF5fhdkZrFqOm4w1Sy0sW
         d2fw==
X-Gm-Message-State: ALyK8tIdZ5h436XCjIFF6WaKSlbWyXAHq3EEfv/FBTkuJjHyZP0KeZnRGAXd6Ia+5cRSlw==
X-Received: by 10.25.135.4 with SMTP id j4mr1464924lfd.66.1467134809563;
        Tue, 28 Jun 2016 10:26:49 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 73sm4409435ljf.8.2016.06.28.10.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 10:26:48 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	sschuberth@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/2] Config conditional include
Date:	Tue, 28 Jun 2016 19:26:39 +0200
Message-Id: <20160628172641.26381-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
In-Reply-To: <20160626070617.30211-1-pclouds@gmail.com>
References: <20160626070617.30211-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Second try. The anchoring rules now look a lot better. I cherry picked
Jeff's skip_prefix_mem() for now to avoid dependency.

There's a surprise about core.ignorecase. We are matching paths, so we
should match case-insensitively if core.ignorecase tells us so. And it
gets a bit tricky if core.ignorecase is defined in the same config
file. I don't think we have ever told the user that keys are processed
from top down. We do now.

It makes me wonder if we should allow users the option to match case
insensitively regardless of filesystem too. Something close to
pathspec magic. But that probably has little use in real world for a
lot more work.

The '/' vs '\\' battle on Windows, I'll leave it to Windows guys again.

I'm also not adding "worktree:" condition. If that happens, it
probably happens in the per-worktree config file series.

To leave room for future expansion, perhaps we should declare that ':'
can't appear in the pattern, so we can add more prefix later, and even
stack them, e.g. "regexp:gitdir:<pattern>". The prefix can't be one char
long. That should be enough for windows to specify full path
including the drive letter.

Jeff King (1):
  add skip_prefix_mem helper

Nguyễn Thái Ngọc Duy (1):
  config: add conditional include

 Documentation/config.txt  | 40 +++++++++++++++++++++
 config.c                  | 89 +++++++++++++++++++++++++++++++++++++++++++++--
 git-compat-util.h         | 17 +++++++++
 t/t1305-config-include.sh | 45 ++++++++++++++++++++++++
 4 files changed, 189 insertions(+), 2 deletions(-)

-- 
2.8.2.531.gd073806

