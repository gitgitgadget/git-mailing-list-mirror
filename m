Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36CC31FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 16:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbcFWQ3d (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:29:33 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36434 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbcFWQ3b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:29:31 -0400
Received: by mail-lf0-f67.google.com with SMTP id a2so18847990lfe.3
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 09:29:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nnF3/468w+LKGWnY/9dO3CkZgt0JHTFmRUEOo1bPvp8=;
        b=vH+GbSCiDwR0SH/Tv4VHjax/P19BL+2SYSVsFQmxqcd2kZqDkN1vzbmake0h6k8MsF
         tTXOuqyZun8MqvOLTD8a8b4/RTjCLSAqiVc2Qef4bA1+6HUCmO9xy44/wubfgqe5xCmw
         6WEreE4/0C5UqLcfFfSY45Z1UE5zQp1pCNbNRF0RZRTLjdBZkK0WED5acwdoR8+7XLff
         EV7vSBz0mk3JMdUOhwpWKsFN5BDCOTtwP8swSQnsM8qnxc3cJERIm6oNOBefomkNjkaw
         dJ2J5OriAIDeN5NN4eX5ODs6xKfLdnj2n7O3c7mTgopqmEMiPgKEe9q8kH6lUJF7vYmw
         Z54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nnF3/468w+LKGWnY/9dO3CkZgt0JHTFmRUEOo1bPvp8=;
        b=fbY29KXNHF0al65OySaLgO+tiALiTufsW8kQ+bDZT77gfmfieenbE9OvJdF0Cvc2ft
         RF4F9AOaiKU7lv9r+T61pD+689HsDUI5Y0RmNKC/cj8ZrlxBBrw05dS4eQsTkRmyzjq8
         Xyy6piSw6oq6aHWsjp30cnw16DfM7mcqk9sdgL/klSXuq2eAdXo0o/DmUIyB6NTUXmsQ
         KFnzAslHKupHdyx8UExDSN6z/JyNDdDnpXZC69U6DRTBOZjpjFbbPzLNdMULIgDFHsBN
         rWohZ/gzlzbLbhRbPxGOj6SVzkrzfAT88h+bqpNtLntydyelOpmwonNtOT8RGLS+M/L+
         MI4w==
X-Gm-Message-State: ALyK8tITeeVzWkMDcPrN/BNEh6t+ZCwRzVgfCCv2PV6pBquE/ydpqiAbM5E4+F6ZmcF2ZQ==
X-Received: by 10.25.27.206 with SMTP id b197mr9772667lfb.218.1466699369883;
        Thu, 23 Jun 2016 09:29:29 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u21sm157948lja.16.2016.06.23.09.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 09:29:28 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/11] grep: break down an "if" stmt in preparation for next changes
Date:	Thu, 23 Jun 2016 18:28:57 +0200
Message-Id: <20160623162907.23295-2-pclouds@gmail.com>
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
 grep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 7b2b96a..609f218 100644
--- a/grep.c
+++ b/grep.c
@@ -403,7 +403,9 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
 
-	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
+	if (opt->fixed) {
+		p->fixed = 1;
+	} else if (is_fixed(p->pattern, p->patternlen))
 		p->fixed = 1;
 	else
 		p->fixed = 0;
-- 
2.8.2.526.g02eed6d

