Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E38861F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeAaLGZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:06:25 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40869 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeAaLGY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:06:24 -0500
Received: by mail-pg0-f67.google.com with SMTP id g16so9755005pgn.7
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JunAhV99pZuL+VG6BdG4CtwcmQCP5D6W+j+GK2Gx6Sg=;
        b=tayEmaamAyR1YTr//tcoX5OshbHgw0XbHe5RRuoZe8UqcY1L4tJ4I35Xk0zxBaRmR4
         XiOTM30AFEMysjyWB2vq5RJ1aDDNZDNHXx5TlE0kC3a8DJawqP/eNDWHAXD/cHXrVb2C
         4NaqT6B345W+mTSTMKKA4L7ipNQVZD5JjHutfrQQZiW5LOJ58F4M83MIMfQTg0ZmIQ5I
         J4Qan0bSbI1UEhDklSn2NRDqtD2faQu0UxOPWqj4s4qR2EYR71Rk9f70p06Iq7BuOlvY
         RJLM1DsHx49q8xQypfsr6R2M8eWTynn2a7zfK1797BFmouf8PbacM9tdfZ9lWo9x7cBI
         d7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JunAhV99pZuL+VG6BdG4CtwcmQCP5D6W+j+GK2Gx6Sg=;
        b=MVpK8dXvT2M6Qtn7uoRFCiihXXBRYB0SWcXqaWrMcLmMbE3cq5ACCtRHP9yExE6+Oy
         U3Q+DHafpYmeK91Zk1aX9VtOAzp65RlObjhrWf3acNSvV0OKv87ngBUVYiYCRcxvwRfN
         2bKH4TcBFvl72yW3uIbTzNxQiwwsiZ9k0J5+SGL5Jujgy0CUFe5wErmtOi9HN2Ds+Uwb
         8jGRGSo0bewCqLUjM+4eWSjQoZffEvKKrCRWbsQkWY/FOpe7cgSbKbhyv0ofkp5qr4lz
         sJqXVnLuZLlv4IVF4Ct52FljpaGnOLBIZPX1HI+xrEeM36Vm/Ya+jmfxB5BjrbpB8ltD
         lKxw==
X-Gm-Message-State: AKwxytcQd87N3peOvK0YidYMWz+kNs5CMdhBhZAeW0eLd1Xq+73MiVzU
        eKuX386xh2XBpQeF4Wu+nmAH3A==
X-Google-Smtp-Source: AH8x226TPuawWNxG7lNN5Gp4as82ep+U+LYifoF+0PDdEusVbYC859DOqQ4VDAA4SLCoP3zS5NUyOA==
X-Received: by 2002:a17:902:7886:: with SMTP id q6-v6mr7617402pll.364.1517396783953;
        Wed, 31 Jan 2018 03:06:23 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id l88sm43909365pfb.149.2018.01.31.03.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:06:23 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:06:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 05/41] completion: use __gitcomp_builtin in _git_add
Date:   Wed, 31 Jan 2018 18:05:11 +0700
Message-Id: <20180131110547.20577-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are

--all
--ignore-missing
--ignore-removal
--renormalize
--verbose

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2d8d3434c6..9aa3aa241b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1144,10 +1144,7 @@ _git_add ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--interactive --refresh --patch --update --dry-run
-			--ignore-errors --intent-to-add --force --edit --chmod=
-			"
+		__gitcomp_builtin add
 		return
 	esac
 
-- 
2.16.1.205.g271f633410

