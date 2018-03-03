Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8191F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeCCLjm (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:39:42 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42479 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbeCCLjk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:39:40 -0500
Received: by mail-pg0-f67.google.com with SMTP id y8so4863185pgr.9
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atq3oFIJQNMNhlIsjZy0yOV4Jyyi7AWlRA+3PpfhXps=;
        b=Cs57qGk31KEa3J0N9OKhv5+zHPsDAx6UYT/yFPjBNFsFFhEUkqD/PEXoYpibbyHucE
         XF/QJnaczuLjc7RlaMgWMnfSAQaA5XuWufly4+q9B/Yp9m8JXKdFEbcckU/y86SBU8Zt
         r3gJU1ruvfQ+inuH3bLpeWlkflLY/L1dBYMPVeNEO3M1YBDRWq9ASCpnkxlVEvVM9fFD
         B9sGiPvPpaMfQl2FGF85jLkgi7LRQ6Pk7aaHAbxip3Klz52ZWNo6npuKasjy90EKfKZ6
         OkjP/dHXm05k1QnAF/+yWsIUuqF9uhhfrdj6SppFrDrRRmZoIbfcrqLGbY+o0hG47C+Y
         EGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atq3oFIJQNMNhlIsjZy0yOV4Jyyi7AWlRA+3PpfhXps=;
        b=g6wfeBu0S+SgaJ6Sz9oonSIDm1CP7zE2LCDG1dgGW3lzrG1Z3B3uDlZz5FyoSrmCub
         SZCVG7QNs+pqTpEUB9J02CsE4hLY/dlGVEoGg4Ud88mEhwZcRzShR/jyJV+Ri+NG3SHY
         60At0SmZDuAsGmEQnmtptI9uDPBcpOlnikRtAW0p/+CzN9JYnRmXpFKLhwznlNF6Xslq
         fvT3mNRyxBsY9insTKiU4EUKMHgKPoHcjoJINaAa1ZDS4KXeZMoJ2F1Aymxz5Cnt9780
         bs5QW8Z5vtxncZJNFnnJR1xJwM7AHXvJwyBVIPv7TVeZYbPHOfnxRKDbV2wWvGJkwKNd
         xdZA==
X-Gm-Message-State: APf1xPBfBFWJwIYMTGs7at9tdLwIX/C3H0Gwh6qsoEoeSQVjiI7ZlSLW
        A5bKvyjOnw7LrritSqpYjkOhdA==
X-Google-Smtp-Source: AG47ELsBMXUQh2g5NtCLN7m0QUlX+/m92QOZdtI+dAnlSA4BgWhzEb1YOvb6fZizHZYrRu2iZtuIVA==
X-Received: by 10.101.86.73 with SMTP id m9mr7169908pgs.70.1520077180082;
        Sat, 03 Mar 2018 03:39:40 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id h67sm21058416pfk.184.2018.03.03.03.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:39:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:39:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 35/44] packfile: allow install_packed_git to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:28 +0700
Message-Id: <20180303113637.26518-36-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

This conversion was done without the #define trick used in the earlier
series refactoring to have better repository access, because this function
is easy to review, as it only has one caller and all lines but the first
two are converted.

We must not convert 'pack_open_fds' to be a repository specific variable,
as it is used to monitor resource usage of the machine that Git executes
on.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 fast-import.c | 2 +-
 http.c        | 2 +-
 packfile.c    | 8 ++++----
 packfile.h    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 0dba555478..ec78e8ff47 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1037,7 +1037,7 @@ static void end_packfile(void)
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
 		all_packs[pack_id] = new_p;
-		install_packed_git(new_p);
+		install_packed_git(the_repository, new_p);
 		free(idx_name);
 
 		/* Print the boundary */
diff --git a/http.c b/http.c
index df9dbea59c..649656b87c 100644
--- a/http.c
+++ b/http.c
@@ -2133,7 +2133,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		return -1;
 	}
 
-	install_packed_git(p);
+	install_packed_git(the_repository, p);
 	free(tmp_idx);
 	return 0;
 }
diff --git a/packfile.c b/packfile.c
index 5356712717..ba185daec2 100644
--- a/packfile.c
+++ b/packfile.c
@@ -679,13 +679,13 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	return p;
 }
 
-void install_packed_git(struct packed_git *pack)
+void install_packed_git(struct repository *r, struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
 
-	pack->next = the_repository->objects.packed_git;
-	the_repository->objects.packed_git = pack;
+	pack->next = r->objects.packed_git;
+	r->objects.packed_git = pack;
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);
@@ -781,7 +781,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 			     * corresponding .pack file that we can map.
 			     */
 			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
-				install_packed_git(p);
+				install_packed_git(the_repository, p);
 		}
 
 		if (!report_garbage)
diff --git a/packfile.h b/packfile.h
index 5b1ce00f84..77442172f0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -36,7 +36,7 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
-extern void install_packed_git(struct packed_git *pack);
+extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
-- 
2.16.1.435.g8f24da2e1a

