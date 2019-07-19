Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53BF11F461
	for <e@80x24.org>; Fri, 19 Jul 2019 23:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbfGSXJ1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 19:09:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43702 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbfGSXJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 19:09:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id m14so24434773qka.10
        for <git@vger.kernel.org>; Fri, 19 Jul 2019 16:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JyZ2cI6wgRNSkeIu9CJtg1CAoXxY2w1uMLweLnF5fp8=;
        b=WCFK7BjBWzj+sxkFxPITg4QkNmsAUmqbch4e9PGZn7uxwGKkYVDA8CbDVN3PmFP/4D
         q9IoFhjL1/sA5SCOXPI2IoI46t7Z+yHw3tbf6an3vS1QdLGqEX091gX2a87pAKCXC2jh
         U1XFga1FPHYmydu4Tn07/E7mVrsJy6atsY3VycIVQf0kI9+Jt7LSflonFQ3ufvoXtzSv
         ZslxplHY0x36F31lKPYsmaG4eMBReb0fh9X3K90Yw66IH7hfxHy34VMD6wBaJnl1H3FI
         Ymq3I4NJ0uhYN+yKgjPDDbDX4Wl6ghlZOi0XCsUpR+0MganTheJgJsTCFwjNh2Gn1IAz
         rQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JyZ2cI6wgRNSkeIu9CJtg1CAoXxY2w1uMLweLnF5fp8=;
        b=uRDz7hGIef3z02pH0oZkrdn8OeyfqRyM9+0FOuPSTp+2YHuSnTHDVXofXUB+Mh+IuE
         InInLciv828OJaHCayoANGkjoboLOMIIbCR6XVaoilSjyMgxFDvZF4CKl6lmTYHEfPF/
         M/o9k44xwjGmpl6LK6yuof4CPV3a7aH2j5BDnOuDZ5aA7WFTeBm/Xg81zh7xYP5oeCfL
         RrGOdL1QLQnfwq4pocVRPeiproNsBi61ML/w+9cbdQEqNkwHPVN+btYEStiieJ3s9Fg4
         ccuGAfuabinc4Apwhf5Uk3iRPo3Gvy1PhE0F+Qh1tACdM2P3BkFHon3+CuPHmo+NoddG
         0mjg==
X-Gm-Message-State: APjAAAUYCFT1QOTpHJTunXn8oe5SSYRfH7an7o4t1T9gzg0Y6c4LVU5w
        VZ/JXv51YjzaKenE3SXFHV+j38Vr+rU=
X-Google-Smtp-Source: APXvYqxL5FzCp7iI89v04uo9Gy6NP6vjXNPoP3wAl2Qk5ecpya7CpSre2MAdH3Q5/QKX4s3JncE0XA==
X-Received: by 2002:a37:a94:: with SMTP id 142mr34659143qkk.89.1563577766160;
        Fri, 19 Jul 2019 16:09:26 -0700 (PDT)
Received: from localhost.localdomain ([170.82.202.216])
        by smtp.gmail.com with ESMTPSA id s127sm14469035qkd.107.2019.07.19.16.09.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 16:09:25 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, kernel-usp@googlegroups.com,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>
Subject: [GSoC][RFC WIP PATCH 3/3] grep: re-enable threads in non-worktree case
Date:   Fri, 19 Jul 2019 20:08:54 -0300
Message-Id: <e72330c6747218545cce1b6b1edfd1e448141a8f.1563570204.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563570204.git.matheus.bernardino@usp.br>
References: <cover.1563570204.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They were disabled at 53b8d93 ("grep: disable threading in non-worktree
case", 12-12-2011), due to observable perfomance drops. But now that
zlib inflation can be performed in parallel, we can regain the speedup.

Grep'ing 'abcd[02]' ("Regex 1") and '(static|extern) (int|double) \*'
("Regex 2") at chromium's repository[1] I got:

 Threads |   Regex 1  |  Regex 2
---------|------------|-----------
    1    |  17.5815s  | 21.7217s
    2    |   9.7983s  | 11.3965s
    8    |   6.3097s  |  6.9667s

These are all means of 30 executions after 2 warmup runs. All tests were
executed on a i7-7700HQ with 16GB of RAM and SSD.

[1]: chromium’s repo at commit 03ae96f (“Add filters testing at DSF=2”,
     04-06-2019), after a 'git gc' execution.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 682e2461d0..9309dea833 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1046,7 +1046,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.recursive = 1;
 	pathspec.recurse_submodules = !!recurse_submodules;
 
-	if (list.nr || cached || show_in_pager) {
+	if (show_in_pager) {
 		if (num_threads > 1)
 			warning(_("invalid option combination, ignoring --threads"));
 		num_threads = 1;
-- 
2.22.0

