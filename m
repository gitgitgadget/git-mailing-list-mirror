Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69EBE2018A
	for <e@80x24.org>; Thu, 23 Jun 2016 16:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbcFWQ3o (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:29:44 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34304 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbcFWQ3m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:29:42 -0400
Received: by mail-lf0-f66.google.com with SMTP id l184so18868816lfl.1
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 09:29:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGbP3hNOxVhem/OfgGkD4zBMcVZio30/mEcRJ07hRSs=;
        b=XVbBkCKiYXcWOk0WOUB4RL3a7AOr2i9aOLYmcjDl7Fxrq6+Fnv0C1VQ5m03vZk/zIm
         GNytbba+k2eep8CnlYvGAHGl3JvhH9B0mMDlLi49rFZVceeH/amtyJweamRXWUoh/F/m
         dPARXCzAd623p8bepMOhP3lU7HxqoSPwiIgzR0wdQlKPzZsnT5W/m+zltVM1bL0Tp+Wn
         sLY62/TI39DxK7Q5QtvGHHHmWrMn7fA6gMs7Zj4Vamb4Nl7PrrvzZPecMd4eQJC/GDmL
         VaZqbVA+kwd+o/5Xu/VMwYltGarWLYlTyJDnFT8MueiFRhCNzeransGwXFxJr3XDIDWo
         QvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGbP3hNOxVhem/OfgGkD4zBMcVZio30/mEcRJ07hRSs=;
        b=Lm8u4Oa+uOj+uV9bRHqxvj7hneRCPoMDiHtHpCd8IWv9GAW7PpjcODYRU/lSyvHbMB
         JBajABTaUVxAzzejwp9QqqSufI9Ah9yGxiV+GZ3+AWSgpEkQvory9SFwPEYCJFi2ia4B
         VaPSYeaWxfDHU3AVco6DPWmyJU4+ARSs4SEry+cqtIAnDRCt3LwQ9bb4dZlJHvh50IAe
         0gGdqHnSstmq5OnQTR/q7Dydkot/32YEJlC9Brn+dxUoZY8YPprvDq6Mu2T2p+F138kM
         uU1SUwByJHxESM8DAlITaN3QmpymwLEgWnX+gDzc0dHoGpkKXQlOG3OML98aGLXuTiCN
         5i+g==
X-Gm-Message-State: ALyK8tJxXzpDTn0C0D6IJNTLdNw1gnNYG14+HgUtx/+nwgUUPzyWZXLFOX372ARHnhtu1Q==
X-Received: by 10.25.214.143 with SMTP id p15mr9668978lfi.95.1466699380840;
        Thu, 23 Jun 2016 09:29:40 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u21sm157948lja.16.2016.06.23.09.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 09:29:40 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/11] grep.c: reuse "icase" variable
Date:	Thu, 23 Jun 2016 18:29:07 +0200
Message-Id: <20160623162907.23295-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160623162907.23295-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 6e99b01..cb058a5 100644
--- a/grep.c
+++ b/grep.c
@@ -445,10 +445,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		p->fixed = 0;
 
 	if (p->fixed) {
-		if (opt->regflags & REG_ICASE || p->ignore_case)
-			p->kws = kwsalloc(tolower_trans_tbl);
-		else
-			p->kws = kwsalloc(NULL);
+		p->kws = kwsalloc(icase ? tolower_trans_tbl : NULL);
 		kwsincr(p->kws, p->pattern, p->patternlen);
 		kwsprep(p->kws);
 		return;
-- 
2.8.2.526.g02eed6d

