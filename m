Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8E411F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbeBILDv (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:03:51 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46156 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbeBILDu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:03:50 -0500
Received: by mail-pl0-f65.google.com with SMTP id 36so1308359ple.13
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjcOtqwHpnI2pZ3FI9Cd4s/uZ1hBg+U8IPDLTnXdrTA=;
        b=V1K1rbU4CBCE7q74U25AzZ9JpamD/AIgKdyhhkIlKmI0qAlCmwlc/xRvBx5qiwUQ37
         KLdR/99eWXVqN9/xXG2S+xkosurWg9j9cf9tq7aEAuh+xenmowDkQdp18j96f6jDX9X3
         2Nm/bsoN/6cUO4tsRyYjlbVIoeXQ982kNglbjCGMLrkgPP5tgL5FnztYHGsrqMeMCFT7
         Y7cHwe3q7wPq+LqFyY5rkjV/FiQKwEEZCaOcsh2a+GRlvVaGayJGarABOR8tgrD2h4KU
         dsKd7n5LFYTTjSjahrFas84UOl3wuYw+FuRa3U7C6E3m7XEnBdjG9uFWMeshr3Ti8fXR
         oXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjcOtqwHpnI2pZ3FI9Cd4s/uZ1hBg+U8IPDLTnXdrTA=;
        b=qvNLKZRfb37r9zQPqk8eYN2E7P+m6hivRdT6yaWm6YMHfGzj36aset9J6fE7Y9qX/D
         TqLXMUHPyM5RG+3Z+6VzBy0rwjA5p7R0hy2DVBg3+QOxw7YMURp55hsvyPYTOjdmCdpT
         1IjGZIWh+TM8bCC0pKzeHbBKRWyHW1wNcO628BQyxqhZhFJ2JcRp0IKut3Spshc6PuQc
         n0zkXltSXHoYqXiIxQ/q9D+poROdmU9COcA5bA1CohWm5vG4Ba+oRI6gsZpb4S6njhei
         hAY04M3gFsPC9XDAjw9TWZY7f8HHosFJGlsFaZuwGMZowlA12p5dDj35IMVucv2LhwOh
         O4mQ==
X-Gm-Message-State: APf1xPBbEZRlYHp8VDuNPWiv1Arq/XgQNn6m4iMvoDaghc81OuwpqyF4
        lgrlm7Om5M0Cz2vj1QhsGoAvHA==
X-Google-Smtp-Source: AH8x227kVcUJiMEP7DmOryk/Jbzi2XD0+oe0fnwlaD8K/j8cLL3b7qs5PmydkWP1Ok5aGuap0xS5VA==
X-Received: by 2002:a17:902:34f:: with SMTP id 73-v6mr2249115pld.122.1518174230348;
        Fri, 09 Feb 2018 03:03:50 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id l9sm614983pfj.167.2018.02.09.03.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:03:49 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:03:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 14/42] completion: use __gitcomp_builtin in _git_config
Date:   Fri,  9 Feb 2018 18:01:53 +0700
Message-Id: <20180209110221.27224-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--blob=
--bool
--bool-or-int
--edit
--expiry-date
--get-color
--get-colorbool
--get-urlmatch
--includes
--int
--null
--path
--show-origin

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0350350079..6e17caf8d7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2252,14 +2252,7 @@ _git_config ()
 	esac
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--system --global --local --file=
-			--list --replace-all
-			--get --get-all --get-regexp
-			--add --unset --unset-all
-			--remove-section --rename-section
-			--name-only
-			"
+		__gitcomp_builtin config
 		return
 		;;
 	branch.*.*)
-- 
2.16.1.207.gedba492059

