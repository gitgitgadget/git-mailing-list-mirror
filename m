Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6BC1F424
	for <e@80x24.org>; Tue, 26 Dec 2017 09:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbdLZJK3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 04:10:29 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33593 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdLZJK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 04:10:28 -0500
Received: by mail-pg0-f65.google.com with SMTP id g7so17603194pgs.0
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 01:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g4IoTI61MXtaFewsKbVrAUd2eLu/r3MKJQgL4Zc8+Gk=;
        b=a+0fJ32alDxVFMZOgZjxS2++3Yo86BqNwzgD2rleLsVna5tVp5vYTAcGzikOzr7x2+
         GrZYQKQQENqtGzJaq0PWJnxjfvvs83/BrMu9aLvbUHHJkZfFwhNZsirkBV4LpcA3axct
         5YvK2yllhIcI9IBdisnErMYYN+uPpJKxy3CKcA+xkZuJj9EbzAHx6BeTarXn98keC/rL
         7EdYTb8v3DvzgKrWJN7fs6dCt6BlJc2BR4SJ/78GOZVzgaHFGQqfbKOivxvuIuC8Tqh2
         UPUJhCwrt4FAn1PS9j68aRtGrjWCyUQVDtOEFVB98yRlQbHxdMBogSKnyDOMww0PMHO4
         iGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g4IoTI61MXtaFewsKbVrAUd2eLu/r3MKJQgL4Zc8+Gk=;
        b=dza9CarrShFErtiGzDxUTq5oNgjEbjj+NUmEiIAa6dk9QD6CDIyPK08JQ6OdTRflxA
         4BU1a6BuY2vqU91RJS+L7gsPoFgrqpXBPH/ivEUOsn3PLweICHWjeAALwH2WVCg+n963
         n4TKAA3sSNcT8T5AGIyLJp2dS9XVCti99x70j2t9oL7tCXtGnFwPh2NhpUmo3xpTuZGl
         nkEr8bX/kL+O3d1uzAbH5QuDUHa6hQeAQEoPC0696caQ3dFRM57w/hxrcxReUlYAhjhF
         5b3N9QRNwwz1z53c4tb5uBE0qYA26T3oq7uzuyR9kpQQ47tJpXBIqCJDxAFbQ9SfnFXt
         3Uow==
X-Gm-Message-State: AKGB3mLm9R0VQBdSmfVr/m3NdIya6ln9EGcxfHEMKbUmLrDtPJT3asOq
        sbGe65kmMwh4DdbTVVQUXrA9UQ==
X-Google-Smtp-Source: ACJfBosj7KtHpdMY2Ea6VU5TV/ECI2Cs6Z3OEiEVBOmS9f0YBGwenL3JmoOG1Ms5t65nvq7XkoVAIQ==
X-Received: by 10.101.66.66 with SMTP id d2mr21629763pgq.244.1514279428133;
        Tue, 26 Dec 2017 01:10:28 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id 21sm56813411pfk.14.2017.12.26.01.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 01:10:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 26 Dec 2017 16:10:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 0/7] Renames in git-status "changed not staged" section
Date:   Tue, 26 Dec 2017 16:10:05 +0700
Message-Id: <20171226091012.24315-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <20171225103718.24443-1-pclouds@gmail.com>
References: <20171225103718.24443-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The changes in 425a28e0a4 allow new files to show up in
"git diff-files" (aka "changed but not staged") which is a problem
because status code does not handle renaming in this case.

The main change to fix this is 6/7. The interesting corner case is in
7/7 where I decided to go with a middle ground, disabling only double
renames. We have two other options to go:

 - unconditionally disable rename in wt_status_collect_changes_worktree
   which turns this 7-patch series into one patch
 - support double renames too but this may change porcelain output
   (or we have to add new output format). This could be done in a
   follow series if we want to.

Nguyễn Thái Ngọc Duy (7):
  t2203: test status output with porcelain v2 format
  Use DIFF_DETECT_RENAME for detect_rename assignments
  wt-status.c: coding style fix
  wt-status.c: rename wt_status_change_data::score
  wt-status.c: catch unhandled diff status codes
  wt-status.c: handle worktree renames
  wt-status.c: avoid double renames in short/porcelain format

 builtin/commit.c      |   2 +-
 diff.c                |   2 +-
 t/t2203-add-intent.sh |  73 ++++++++++++++++++++++++++
 wt-status.c           | 141 ++++++++++++++++++++++++++++++++++++++++----------
 wt-status.h           |   4 +-
 5 files changed, 191 insertions(+), 31 deletions(-)

-- 
2.15.0.320.g0453912d77

