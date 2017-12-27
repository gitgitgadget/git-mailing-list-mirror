Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A571F406
	for <e@80x24.org>; Wed, 27 Dec 2017 10:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbdL0KUK (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 05:20:10 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42070 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdL0KUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 05:20:09 -0500
Received: by mail-pg0-f67.google.com with SMTP id q67so9419013pga.9
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 02:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTs8LrCtJGYHIASkgz1w8xIqHAO+UPOtPx8W/f9cpJY=;
        b=HA5EWJ4tdfbB4JjbaFPpQi+LzqTSXjakDmUazPYoBxRLwwYMWzlOal3S/7EVZfEwYn
         o+fieq+3KdBTcuL9CyiXyojNPIoQy9N2pmSmwQjHVo+Rq6YZ5uiE78Im7V04Ooefm4cG
         eeeSQdZgmWBp4nkS39jUC6RlkbUmaA9vFNB6k2x3wqjhYb6tBYupu/jra3Qpttof0hOQ
         p3H67+NAWPoKb/RQdBpIrkA5YjrtIvUOe3aBlDnQB7cqDrJH9UhFKzKfuZkabjC0Q6O3
         8Ihi2xouO9wFg6dZnvPTkWhcg5hX7483TD8K3foO7f1IPJVcBXB99QgzH3S+F2NQCW1f
         23Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTs8LrCtJGYHIASkgz1w8xIqHAO+UPOtPx8W/f9cpJY=;
        b=eVT1SvN/unfgEVhzRLEhJbdRz25aCZHYiZR96q9FyhLvBwdLiNcP6SqQyHXxzTQD3x
         DfpUePTW3e6uMPyQ2a1YTQQT/Lc+0teo8XSIkjgmI6rULoeRjRGsazz8QW23dzay8mw/
         z1nbl2bNDodCwBp0fsddCZGRDVkn5yOFdrpoeCkCXdel+giCDYaObrNlY2hmoeooJuCv
         DJnBiSrlXfr3ANkhQbuRrW78P40Gc9zDNm3RTIEumZ2hx8CYHbbLLJUxkYiCUU2XGIV8
         Y7avCH9V0903XYBSgDmxH5gBQ4eKFnTBC7QaukMxeSHnSG3JJleHNYPEvEGq4vOcA7LP
         va0Q==
X-Gm-Message-State: AKGB3mJ50aFca8PNeOV0xuMUwRYe1A5OdQM+dT6asc7/GGzmCZaHjme1
        yrjc8eUKG+m5DcYZoa5Og+MK3w==
X-Google-Smtp-Source: ACJfBot67vR/BMnEzYIzGiqP1i9RhRoQMgiY6htM4crj3TgZJkZNjWDcKo+JE9IJBoRw5QrEaatj+Q==
X-Received: by 10.101.97.78 with SMTP id o14mr2485754pgv.272.1514370008947;
        Wed, 27 Dec 2017 02:20:08 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id p10sm67883271pfl.32.2017.12.27.02.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 02:20:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 27 Dec 2017 17:20:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 3/6] wt-status.c: coding style fix
Date:   Wed, 27 Dec 2017 17:18:36 +0700
Message-Id: <20171227101839.26427-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <20171227101839.26427-1-pclouds@gmail.com>
References: <20171226091012.24315-1-pclouds@gmail.com>
 <20171227101839.26427-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 wt-status.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 59338adb8b..db06fc7c85 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -406,7 +406,8 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 	strbuf_release(&twobuf);
 }
 
-static char short_submodule_status(struct wt_status_change_data *d) {
+static char short_submodule_status(struct wt_status_change_data *d)
+{
 	if (d->new_submodule_commits)
 		return 'M';
 	if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-- 
2.15.0.320.g0453912d77

