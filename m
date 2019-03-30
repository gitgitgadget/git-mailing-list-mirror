Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013E720248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfC3LV7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:21:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44655 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbfC3LV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:21:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so2245508pfm.11
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/5XiUNgZOyJMfbfBOhs6OmmQ4I37YwDc4n2auyrKfdQ=;
        b=SomQ7f0XMyPCOd18jdBkmqrzl+Ay8EsHahyLvrXRPRGmq/9n8gD3d+83N5DdQYli7y
         zLEkRcsOCUVyeVfkEqNmSoh7zWagGFd63TPXo/HeBZnoYNKF2HnX/VNo/8jt7E1t6yP2
         IDrix8eCFmbcgTsrsa1Aym9iId9cnlCbchlwkKOrJ5qNkh9/GSqj8P977oSto8Kv0+T8
         6EwEjNftO8+AY7b7wsUo24jnU/SnDCFw6LuLMrZ3tpGZ6OqkjgH69H+z9vuVyoMFrDQ3
         geGItn+2VKAexQvMH/Suui+xD8h4bN8qRcphp97H0cUfHmRi/fNvPB3F424mOS5RGOXl
         M0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/5XiUNgZOyJMfbfBOhs6OmmQ4I37YwDc4n2auyrKfdQ=;
        b=iplvMj5ppPXPtzSM0IyftjffxstSDPsUntelWFe2WKGPyW7gH+RlJIHGvw27NNR3K1
         24ReloVl/thuD4JP65V4WzIM7gQr4mYGrIFQ32mCp7pJnpFVQOVd/UVp2WlWtf+gPF+4
         s0kGE+PxlTCg+e6Y1IorMra4D57Ix3FGMQFx20baX+IABq6fW4Rt7+LyJBpTlZjGP1nJ
         A81b2YzCHRPg8hgUlAJJK3aQC7q3S1x3r4fZ0Egu88pDBRhv3VB+0jpK73svFKH+UjNC
         O6/GKNdR4BTEI7q4MRFhm/Et1NRhNtHT19Rmodeq3+ctd9aDIKKdbf6yWcHwGvoGLnP0
         N+cw==
X-Gm-Message-State: APjAAAWVVj1zv/psMpyp7jgUUvDrHOsGvHlnNJfyq2rUeIO2V76HPom4
        Lk0+yCxnMKhjPBFqWGFQUBl3UCDp
X-Google-Smtp-Source: APXvYqyGC6oGTfKqI1VwgTTYYPHg8m1yvU8dfxhVY/lTgcpto4xy1Ek/3kPMpqwg9bptdWBlhyIexw==
X-Received: by 2002:a63:2208:: with SMTP id i8mr34615161pgi.223.1553944918131;
        Sat, 30 Mar 2019 04:21:58 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id t3sm5610044pgv.39.2019.03.30.04.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:21:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:21:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/31] sha1-name.c: add repo_interpret_branch_name()
Date:   Sat, 30 Mar 2019 18:19:14 +0700
Message-Id: <20190330111927.18645-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 7d9512ac44..49c62d5254 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1390,7 +1390,8 @@ static int interpret_empty_at(const char *name, int namelen, int len, struct str
 	return 1;
 }
 
-static int reinterpret(const char *name, int namelen, int len,
+static int reinterpret(struct repository *r,
+		       const char *name, int namelen, int len,
 		       struct strbuf *buf, unsigned allowed)
 {
 	/* we have extra data, which might need further processing */
@@ -1399,7 +1400,7 @@ static int reinterpret(const char *name, int namelen, int len,
 	int ret;
 
 	strbuf_add(buf, name + len, namelen - len);
-	ret = interpret_branch_name(buf->buf, buf->len, &tmp, allowed);
+	ret = repo_interpret_branch_name(r, buf->buf, buf->len, &tmp, allowed);
 	/* that data was not interpreted, remove our cruft */
 	if (ret < 0) {
 		strbuf_setlen(buf, used);
@@ -1482,20 +1483,18 @@ int repo_interpret_branch_name(struct repository *r,
 	const char *start;
 	int len;
 
-	if (r != the_repository)
-		BUG("interpret_branch_name() does not really use 'r' yet");
 	if (!namelen)
 		namelen = strlen(name);
 
 	if (!allowed || (allowed & INTERPRET_BRANCH_LOCAL)) {
-		len = interpret_nth_prior_checkout(the_repository, name, namelen, buf);
+		len = interpret_nth_prior_checkout(r, name, namelen, buf);
 		if (!len) {
 			return len; /* syntax Ok, not enough switches */
 		} else if (len > 0) {
 			if (len == namelen)
 				return len; /* consumed all */
 			else
-				return reinterpret(name, namelen, len, buf, allowed);
+				return reinterpret(r, name, namelen, len, buf, allowed);
 		}
 	}
 
@@ -1506,17 +1505,17 @@ int repo_interpret_branch_name(struct repository *r,
 		if (!allowed || (allowed & INTERPRET_BRANCH_HEAD)) {
 			len = interpret_empty_at(name, namelen, at - name, buf);
 			if (len > 0)
-				return reinterpret(name, namelen, len, buf,
+				return reinterpret(r, name, namelen, len, buf,
 						   allowed);
 		}
 
-		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
+		len = interpret_branch_mark(r, name, namelen, at - name, buf,
 					    upstream_mark, branch_get_upstream,
 					    allowed);
 		if (len > 0)
 			return len;
 
-		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
+		len = interpret_branch_mark(r, name, namelen, at - name, buf,
 					    push_mark, branch_get_push,
 					    allowed);
 		if (len > 0)
-- 
2.21.0.479.g47ac719cd3

