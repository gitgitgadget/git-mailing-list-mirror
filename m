Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 609872035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966207AbcJ1Sza (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:55:30 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33299 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966136AbcJ1Sz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:27 -0400
Received: by mail-pf0-f179.google.com with SMTP id 197so41752458pfu.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=blz27g+UBLYSu+6iKgoi5G82S/FqHiHU/Tg+G8GMZ+o=;
        b=GR/NKjaSGc6D80krP3Y8mfX7QAPqNpAM54pTtJQBxjBj3knReo7erOxed17o0lYLbr
         z6Tb7HbghryX/nhfLeo9YFU+Zv6ltqVUWO25pbo77YtvVwdUnJ1O97G3ceDQ6dvsOTkg
         OLnMjFQPf88BYEf1TOzZMpclfUixAAMb6Bim8jzaHvdCG0mbAmfJu+ja3D4yMpZLmeiq
         qDidTJWWLCzlgTAE4O7VbO+I0Fsj5nJeNQ0A6bO1kvI8eZLTptD9t6emoqfiHs6CtoPJ
         89rIyEV1+pMDuzkbozJZgyH4+xxIE97+IGhIeqi1AEplI0JQUmO9+RjKA7RczDKvh2q3
         d9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=blz27g+UBLYSu+6iKgoi5G82S/FqHiHU/Tg+G8GMZ+o=;
        b=Kh4FyVTwcepBdeZDR+j25MtUCb9YfSFuiv1y0wd+e3Mir/ISvuMkRCoUIFv+RiTU6g
         nTBfDgK17nhUqjcBiuXlnfPI6s1HZallhxugI+rMORQ7Gd5l0eqfbRHfhQGW0Ng3zdQg
         JhujYFtvRis/CwE5fretAGgo/RHA8kjNCxhxUJ1GUf+3ecs+rtHOi9KB4ZWhFhgi71+F
         yEGrAQNeaT4xHy/kgNNUNzTp0OZjjHhMp7bYC9jG1yJc6yu57vSinSUrRgBoIXd2v7Gk
         OHz/mZQP4ut9aaU2b35BCJvYNnaFgn19AIsxpCQtbHe355JjGFC9A118dtZNIQMB8z3u
         +8zQ==
X-Gm-Message-State: ABUngvepElkZVGEfAWwum5ruEfIRj3kwwx4KQqkkThpJqPbJHUMv6tsUfZuxpenXRx3BcVYd
X-Received: by 10.98.77.1 with SMTP id a1mr27524845pfb.160.1477680926138;
        Fri, 28 Oct 2016 11:55:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id o184sm20549884pfg.73.2016.10.28.11.55.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 04/36] attr.c: explain the lack of attr-name syntax check in parse_attr()
Date:   Fri, 28 Oct 2016 11:54:30 -0700
Message-Id: <20161028185502.8789-5-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/attr.c b/attr.c
index 007f1a2995..6b55a57ef7 100644
--- a/attr.c
+++ b/attr.c
@@ -183,6 +183,12 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 			return NULL;
 		}
 	} else {
+		/*
+		 * As this function is always called twice, once with
+		 * e == NULL in the first pass and then e != NULL in
+		 * the second pass, no need for invalid_attr_name()
+		 * check here.
+		 */
 		if (*cp == '-' || *cp == '!') {
 			e->setto = (*cp == '-') ? ATTR__FALSE : ATTR__UNSET;
 			cp++;
-- 
2.10.1.714.ge3da0db

