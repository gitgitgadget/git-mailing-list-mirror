Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE5D1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 15:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeCWP4A (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 11:56:00 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34086 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeCWPz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 11:55:59 -0400
Received: by mail-lf0-f53.google.com with SMTP id c78-v6so14327987lfh.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uiVuAFfUBUIe6KyEsyKqHINQhfVPNjhGB3c1E2xzOM=;
        b=IxvGatwTBS3DKqmXAze45+lRuVmiwZS0bNbQ6KmY5tDaEyiilG5GtfCAKWFnth2u2e
         /P2GhCcLhVGCmX3XODNVujSbALRNpH9mHAKZx6TeaJYNhgERNTjbSFAqzX78CIzebDxm
         hjPvuXv+KtphW5xCRRYG/pP4TaMzNvUEeX4bwQiXOlh0Rb9DshDGiYhV9IVr4ExF7ofr
         sdio+Whz015YfC466THsqV83dy3bYPUsawAGXknrXWOglx3I1YTDS7hYGZzOC63s5WzD
         C3fpmj/38zV0k3CWelUIcPRoBC7o/aegmJohNoCB2l1fELup99eQg0xaHL42C8Uzrnur
         4JuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uiVuAFfUBUIe6KyEsyKqHINQhfVPNjhGB3c1E2xzOM=;
        b=tqyTSzLUjzWkqqfNB5JGgPmZkrFsy5ehoobqfSY0+b9ZhSEPlGf3FIKtQ8fi87m5bD
         yG4+P+y25iIg5abzM87UrprIt9a0se5uEtj2kc3n+CsZttie2ADlE1VL/yQfYD0KfUGz
         /stwE50EAopmr+NwIyr/71Xo2CydJ16iMirXQMahvnAOhl7+CrqQ7fA16gMjwprKUZqm
         ItdI4nutdbQFy1ZxoTWf/083RAfvl5cBvZQP6DfS6p1HPPApVlbKpORZA6N40VBNBWS3
         KhTqEsZLz83MIPHG6Zqyve+yIavl5U6oJElbm2G4i91Yn6AYaa6TkcYTUBV/FSuGT5UI
         gu5w==
X-Gm-Message-State: AElRT7EmYhFbTJLkpbUR60elk2ALIcVVNLBxxBKLw0Ew8PtjsXoES/RQ
        eVoeHGtg/FAEumAWz32jjiA=
X-Google-Smtp-Source: AG47ELuDAJ9Kabh50Am+Bp14PbYlT/BkxjiUAOlxYAHGJtGS6ffOQrVaUrRMCYVXvi7ujNGwqQOoig==
X-Received: by 2002:a19:9904:: with SMTP id b4-v6mr19084494lfe.51.1521820558002;
        Fri, 23 Mar 2018 08:55:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g192-v6sm2248963lfg.86.2018.03.23.08.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 08:55:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 0/1] nd/remove-ignore-env-field updates
Date:   Fri, 23 Mar 2018 16:55:22 +0100
Message-Id: <20180323155523.22269-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a very small, non-functional update. On top of 'next'

Nguyễn Thái Ngọc Duy (1):
  repository.h: add comment and clarify repo_set_gitdir

 repository.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.17.0.rc0.348.gd5a49e0b6f

