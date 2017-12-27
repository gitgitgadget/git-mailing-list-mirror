Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40DC31F406
	for <e@80x24.org>; Wed, 27 Dec 2017 10:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbdL0KTz (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 05:19:55 -0500
Received: from mail-pl0-f42.google.com ([209.85.160.42]:37751 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdL0KTy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 05:19:54 -0500
Received: by mail-pl0-f42.google.com with SMTP id s3so19221420plp.4
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 02:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IAFZYW2Pl/1tB1o2+tKNG+jddsh29snVp95m4Ki6z+o=;
        b=FopzOa/mr8iffzGsFyDOpCy1uWYoMe9joZlh2hNPT1IahmLYlBlsy5zd/Tc6qHlAdb
         3HogoXOqr44Vm/Bv8frXKhe03OKcMwXbSxtxtyn2YK7o9FBWYKJxgzV80tmGevEWcAs4
         piEUCXi5KAt1Tp3ZwAN+I4M2QGaVz33TQoepPSqqXTlZzqUnWdyxBegGi8TrHdDshM5P
         hBddaVdtWY8Ypon5269FViApH/xgkx3zCcRYAirq8J1NjotVJB1f0GlnltOp9kVqe2Z4
         HDd9JqlT8YFleveXgSObYKta2vP3G8tJhhf85bUzEhULKTwygZ0PqHS3vShLMOQacwdW
         qnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IAFZYW2Pl/1tB1o2+tKNG+jddsh29snVp95m4Ki6z+o=;
        b=sWPcE5rUfn+jGDqIt4DVe0d3Q7hUJrnsMk1APBO+J5GIOHqefdp76pKGdtjpEWTf/9
         3pAvBYG0stGENFRWTJgefmw2mY2lFG/zXbnsDM3vqKyA5BvXwvGn7vAUGyvzEa4/NZlD
         i1g6bSPmmq2R6F/hgXuQOyDnc14hIE/GfhZivruXjOe8cxTz1bfjJyLvhS7RycUtDDZS
         XcEGSd9qkdrz8U6mQm30fdKVxCpeFdqeEjod0+Y0hnlGFraFDT5JHhS8Wk2LmyB3b2w4
         izFisHeWkzZDxO97xGH3S6Zsd4iqHl7GTY16EyERhW5ZHoVzc61yhb+uoTZvICwSQMab
         MbqA==
X-Gm-Message-State: AKGB3mJqTCAa19VqXA426zId48GEK/6nrx8hQGrWxJvKMmVCIrdn52AS
        3QjFL0lHA2sGR+VQgV7m/o3/Vg==
X-Google-Smtp-Source: ACJfBousUsYEXsJapPr7dOH04aCTGsSyPP5QSLJat6dSHyUqjcwJaryec4UYhczyB+Jpv5YkzI5b+A==
X-Received: by 10.84.128.77 with SMTP id 71mr28321902pla.67.1514369993346;
        Wed, 27 Dec 2017 02:19:53 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id d8sm25720933pgv.87.2017.12.27.02.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 02:19:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 27 Dec 2017 17:19:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 0/6] Renames in git-status "changed not staged" section
Date:   Wed, 27 Dec 2017 17:18:33 +0700
Message-Id: <20171227101839.26427-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <20171226091012.24315-1-pclouds@gmail.com>
References: <20171226091012.24315-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 more or less goes back to v1 after my discussion with Igor about
porcelain formats. So 7/7 is not needed anymore. 4/7 becomes 5/6. The
meat is still in 6/6, now with some more updates in git-status.txt and
to address the comment from Torsten.

Nguyễn Thái Ngọc Duy (6):
  t2203: test status output with porcelain v2 format
  Use DIFF_DETECT_RENAME for detect_rename assignments
  wt-status.c: coding style fix
  wt-status.c: catch unhandled diff status codes
  wt-status.c: rename rename-related fields in wt_status_change_data
  wt-status.c: handle worktree renames

 Documentation/git-status.txt | 23 ++++++------
 builtin/commit.c             |  2 +-
 diff.c                       |  2 +-
 t/t2203-add-intent.sh        | 72 ++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 83 ++++++++++++++++++++++++++++----------------
 wt-status.h                  |  5 +--
 6 files changed, 143 insertions(+), 44 deletions(-)

-- 
2.15.0.320.g0453912d77

