Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AE4C1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbeB1Bhx (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:37:53 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38757 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeB1Bhv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:37:51 -0500
Received: by mail-pf0-f195.google.com with SMTP id d26so364410pfn.5
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRxlQqsOmZiucLWNBnCtyOFfLG9+dJ+gOlRQ7VlP0rM=;
        b=P18cmfrlJFOP0DApbL+xrlbsMwBMFePqH2XBa6aTfD2RitRFDpDZY+490OnFSHxM4B
         JGv0SgAZGiGIqq0osRf5d9O9zus5KgM6/MYLzqrtWPjv/4of8E6VoUvd4eyeOSAdQK/d
         d6BI0GUx3AtPW9lmQUhHsDG17oL0yaYdrrKT0bW8wAsjW/6PKPYYTj4hGzK5zsEQBNds
         9f2pcfCOZuA0xQ9XgEusSVhslr023YPFSgN3cexgrP+U3FfGZy+OBll7FoDyJ8g9bCaM
         oUBTGx1X3Q5UDezKj+GGRIWyAkQnNhRoLQirvSbuCb/FqYiTn+8ttNVXArFguHBt7owv
         +ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRxlQqsOmZiucLWNBnCtyOFfLG9+dJ+gOlRQ7VlP0rM=;
        b=djsQLbBeSss0o2AC6ahAbNtAvzMZb/6Gd64P0Tf7J0NZeQf4xaXkXkdc1r5CEQClXv
         lUQ1hjGm+AYb7Jy+RM76ysjR4yoSikmqn3nWUW5/C3bUwp/9Nh42dHGvu2MRIxduONoI
         r022xYTtaLWmdi4X+LgLJpsbTpD1SWm8t3H0/wAmsheeevA/0ftSjgx7+r9c83z5HNl9
         4M+A/rKBE3RJmlfg5GCzqdwpttBolvqu30wYgWH3tuaWxAhJAS2laKCE7F9i5iLVKgEx
         b4CcaMCBNdomdFdTMxli3m+M1NZLrwU00Y+vcXPJBf5pZdX0mEQcNAWd3i+4E/6JWRQ8
         1AZg==
X-Gm-Message-State: APf1xPBmQIEcECKMZb1MpozVqBHh9MkKFGSdNCumCpbOQHUVdeW76/sZ
        Kq/U5FTbfpuneUiWe7DRYq0=
X-Google-Smtp-Source: AH8x225q3kf/04RE4rXfUEDVSp9++9TR8P2kW8/ggMTBMQAo5mA3oUxMYp6Oom9GTtg9eL+ItchTMA==
X-Received: by 10.99.125.8 with SMTP id y8mr12789333pgc.241.1519781871465;
        Tue, 27 Feb 2018 17:37:51 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id n13sm573588pfg.45.2018.02.27.17.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 17:37:50 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sbeller@google.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 2/4] repository.c: delete dead functions
Date:   Wed, 28 Feb 2018 08:37:25 +0700
Message-Id: <20180228013727.13815-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180228013727.13815-1-pclouds@gmail.com>
References: <20180227095846.9238-1-pclouds@gmail.com>
 <20180228013727.13815-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 repository.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/repository.c b/repository.c
index ae117efbf0..89e76173a3 100644
--- a/repository.c
+++ b/repository.c
@@ -16,31 +16,6 @@ static struct repository the_repo = {
 };
 struct repository *the_repository = &the_repo;
 
-static char *git_path_from_env(const char *envvar, const char *git_dir,
-			       const char *path, int fromenv)
-{
-	if (fromenv) {
-		const char *value = getenv(envvar);
-		if (value)
-			return xstrdup(value);
-	}
-
-	return xstrfmt("%s/%s", git_dir, path);
-}
-
-static int find_common_dir(struct strbuf *sb, const char *gitdir, int fromenv)
-{
-	if (fromenv) {
-		const char *value = getenv(GIT_COMMON_DIR_ENVIRONMENT);
-		if (value) {
-			strbuf_addstr(sb, value);
-			return 1;
-		}
-	}
-
-	return get_common_dir_noenv(sb, gitdir);
-}
-
 static void expand_base_dir(char **out, const char *in,
 			    const char *base_dir, const char *def_in)
 {
-- 
2.16.1.399.g632f88eed1

