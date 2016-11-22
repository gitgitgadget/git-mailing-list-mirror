Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583EB2021E
	for <e@80x24.org>; Tue, 22 Nov 2016 10:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755830AbcKVKBA (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 05:01:00 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35256 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755570AbcKVKA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 05:00:59 -0500
Received: by mail-pg0-f68.google.com with SMTP id p66so1701464pga.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 02:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i7WjuddRcSANWUb0WPXLv+ywIGyE7sSgWcCv5XvZVOk=;
        b=AzGI+Ht5zb/Xqng+kRvHSkB/+0MVJNF3ie3+lE2WqquPbCRW8m+zCbH9/GL4CSuwlI
         jqiEGLaigRdnM4wgja9ryiod6KX+caR9aQguHE6OTu+SaS6SO4jTsjmGy9G8NiK0Yonm
         1G7sTYl2B15/wpk0dhzClYBxYtwge5gXUmetQtRJlplHwqChNuQmaicLXDjQRbRiFte7
         fEhvXTNSFcDk4UIi9ENpMCm2rE8XUYeACFR8IaMh6IyaWz6lr+zUfYzFipfkhu8Q+8c8
         wzS9BF4Z61fBOa7QG1coROpMWZ9oDUu+7KUO/Z08pDujJW/e+9BbQEHxaW230vQLtlCl
         +7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i7WjuddRcSANWUb0WPXLv+ywIGyE7sSgWcCv5XvZVOk=;
        b=LgDrxP7iOkmJUzFDghinU5bqUJrmBHSC1K7+3cm4jvP1XOBySIpNRsBUMqCwwfnmQR
         DkdeoZfPRwevjtswDhsfqXlCK05YJUKV8UQRLBs4DOcMUH1EdleqEqvecl0nBcJmfTFu
         hBBk1Bc+fC6YnnXZ2e73/ybcMcy4uUKbkASe3IK/XZivSJ8lPA+XIv4WbqFGLHMHht6P
         lUx3JuZKXgq3eaMZKywS6QT5UHHthTtlfbVM3j6EO2gJSlj15EgEoi4hxHYuI/Qdh8qW
         HUyem5OAmancDpXV0O++P+An0CpjwwcVC9IBHQQYbP6ZE+/qS75WV2cDP8ZC9hmxvYgL
         kEEA==
X-Gm-Message-State: AKaTC00g6Ay3V39AM1UAaQi28kH0Ndlpq+/mCU9gUMEXP9mAWXgw4rVowCU+2rjrh4zhOw==
X-Received: by 10.99.124.20 with SMTP id x20mr42173935pgc.60.1479808858579;
        Tue, 22 Nov 2016 02:00:58 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id n8sm17394356pgd.29.2016.11.22.02.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Nov 2016 02:00:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 22 Nov 2016 17:00:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rappazzo@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/3] Minor fixes on 'git worktree'
Date:   Tue, 22 Nov 2016 17:00:43 +0700
Message-Id: <20161122100046.8341-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes two things:

 - make sure the first item is always the main worktree even if we
   fail to retrieve some info

 - keep 'worktree list' order stable (which in turn fixes the random
   failure on my 'worktree-move' series

Nguyễn Thái Ngọc Duy (3):
  worktree.c: zero new 'struct worktree' on allocation
  get_worktrees() must return main worktree as first item even on error
  worktree list: keep the list sorted

 builtin/worktree.c | 26 ++++++++++++++++++++++----
 worktree.c         | 20 ++++----------------
 2 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.8.2.524.g6ff3d78

