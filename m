Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 839821F404
	for <e@80x24.org>; Thu, 18 Jan 2018 09:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755271AbeARJp3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 04:45:29 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42688 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755377AbeARJpW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 04:45:22 -0500
Received: by mail-pf0-f194.google.com with SMTP id b25so7745961pfd.9
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 01:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tL+XnB07aesxN5iOWKF6c2cXejnBS2qiUaz26CN6WDw=;
        b=tzYRBv5MK3QCgmjKJsKrYu/fLvEv1itFtbahx84aayGFMBWlTblJkHK9bfRe5gqn82
         c8Ry+EP1Rdq60pVW3lwudbt1ZiFaVOlvP/uOYU/QiW99gMvvaQn+M1whmZHa6eUbBXg1
         HgKcb53YhJeCvgO6bchLaC1y86ESc10YgsXHc43o09A8Y7HhLBA6AZT5F9E7Lgv9ft2l
         gPlHm22slDrrYdMdvkR4khgIacYX1Rt3yTC2za3qwJGFVqfS+9ECtoj3tVh1nxdTTMy+
         KDueahykZpl2GjKppkxa+NW0XoZK4Bf8f4fzb8wC/XO4Vnr/mwWF0abMaL5zj7QaCOO/
         NYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tL+XnB07aesxN5iOWKF6c2cXejnBS2qiUaz26CN6WDw=;
        b=nfP+kCCFutkXanOnpKUWjwEcKTQYshcXOgwMnv6+jxtwxkpPnvXNmORWGfwkqSosFf
         bUd4o+NOwrovet8igT/fg2aIyuoQu/4VRP5xTk3MmHVZViF39o0MoVQxYSPVCddfax4V
         fv6FkNlu/li+tSB6iPFdWQ7GbCejxdU5T07FUt1VDfhkCmqXjd9uequft0WYBokI4viC
         rf2EQaZ1v0VggwpNvB8g2taq5Yc/CdPoi6owT4xy9fSsUmaoHcwpxk5EnXWvvPVcaJCd
         IWdPfZJJ+E3loxRS8nAx71wcfXngE+L97eRJfGC++A2N98mH5yxyyC8VyYYW/RpQnVl/
         pdlw==
X-Gm-Message-State: AKwxyteIkeFj/Tr/qVs2C6g6JuUpuR6xk1peY7hWOzE71JM+oigy7kve
        E3ZUK0k7SxErbId12FQlmCdqjA==
X-Google-Smtp-Source: ACJfBovlieTagF22mB/rXZziZ1N96vLcXzEMmo45QkLYy+nk3kQIxlbTk6/Xvo6KTETyOB9F7F/2mQ==
X-Received: by 10.84.133.14 with SMTP id 14mr13595084plf.360.1516268721974;
        Thu, 18 Jan 2018 01:45:21 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id q67sm13156959pfi.164.2018.01.18.01.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 01:45:21 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 18 Jan 2018 16:45:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 0/7] Trace env variables in run_command()
Date:   Thu, 18 Jan 2018 16:45:05 +0700
Message-Id: <20180118094512.27849-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180115105949.18328-1-pclouds@gmail.com>
References: <20180115105949.18328-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v6 squashes Junio's changes in 6/7 and moves trace_run_command() from
trace.c to run-command.c.

Jeff King (2):
  sq_quote_argv: drop maxlen parameter
  trace: avoid unnecessary quoting

Nguyễn Thái Ngọc Duy (5):
  trace.c: move strbuf_release() out of print_trace_line()
  run-command.c: introduce trace_run_command()
  run-command.c: print program 'git' when tracing git_cmd mode
  run-command.c: print env vars in trace_run_command()
  run-command.c: print new cwd in trace_run_command()

 builtin/am.c                |  2 +-
 builtin/rev-parse.c         |  4 +--
 quote.c                     | 30 ++++++++++++++--
 quote.h                     | 10 +++++-
 run-command.c               | 88 ++++++++++++++++++++++++++++++++++++++++++++-
 t/helper/test-run-command.c |  9 +++++
 t/t0061-run-command.sh      | 37 +++++++++++++++++++
 trace.c                     |  9 +++--
 8 files changed, 178 insertions(+), 11 deletions(-)

-- 
2.15.1.600.g899a5f85c6

