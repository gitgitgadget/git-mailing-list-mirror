Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4E620248
	for <e@80x24.org>; Sat, 23 Mar 2019 03:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfCWDpq (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 23:45:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45862 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCWDpq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 23:45:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so2757895pgk.12
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 20:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/IkhLOTIIFgkix+Abr3ezU98zJMAN5EA3c1FeijEbp0=;
        b=jL41dJRZ2B6cU+JkMbP09zU9VYbiQL86gSdpbyUifzMJBVgbEbIGLkcQIy1LtjlehB
         xgShGx4063J4WhJOVJbSn1v7n+Y0g3h/UT/Umu8xwtL32q2bVu4v0JLddY975fTOaCJu
         9Dzhf4eGrPjlKMgcc5Hx3pW6Z9MGjBg54vqtUscK0cCx4Av9xMjRAPelwZ54BSWKKfMj
         vHtaNLA24VgIiYAFYO7TdKmiSLdtCrjyDlLiCMU4aYmOBRFbnx0O+GZDYmrnJG8ZnaPJ
         MMGKbckX9CkEv1SdntDLNFmNLr/8xy3+Xx12KmRjlZYlwOXvubm8KjPpQeL0HA9Hal9Q
         zqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/IkhLOTIIFgkix+Abr3ezU98zJMAN5EA3c1FeijEbp0=;
        b=KIhwkX2rJbIprYEocFwVwV4rwIZDbRwYsretjkd+3QcE7EXnw3YkbM846xU4nNREzC
         YYf6+Jw7S0m1XJnlzlisjrNZIjp8yRQ0mLrMDU6MDYoa6rhqOK9G5miVnfkkvfikf/Rd
         hldzKajmnUrr47k3jvzAkpWGPpOeZQdHyNTdS6qIlTsR5n27Vbwb5baXep+TJNSrGxz5
         C5xGZHm2vtllsyO3QKGErFeeKmNnljvkANh96ekJ0CikJUQJK66Hjyy9Rpmn8xtGcsiV
         d9P6Cb+UyYKvUoBrko3Fu+4Am4i/bnVnr5Y3ZlPAN2eSPE0oniHby3NMIfgxWOXo1I2r
         SuPw==
X-Gm-Message-State: APjAAAWNDinghvHutdqzkWBaBgWfTTfrqoLEKsOxWu+zX8n3Yv3GfPRO
        UfAZ7NkU0FbpK/hpzQwE2tM=
X-Google-Smtp-Source: APXvYqwdzu8XggPcmwSn6jPF+YucfZBwoIu/zWrjC7fwYvKuYr86x/Pmt1A8ntpFbKG2Yugy+ZSqsQ==
X-Received: by 2002:a65:4542:: with SMTP id x2mr12110246pgr.65.1553312745767;
        Fri, 22 Mar 2019 20:45:45 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id h3sm17422550pfb.31.2019.03.22.20.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 20:45:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 23 Mar 2019 10:45:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     jason.karns@gmail.com
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] config: correct '**' matching in includeIf patterns
Date:   Sat, 23 Mar 2019 10:45:35 +0700
Message-Id: <20190323034535.23364-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <CAKNmmv26G05GO7hG9bNvMsjpuUMHZRA+2f94TuG2wDNUwNhHkw@mail.gmail.com>
References: <CAKNmmv26G05GO7hG9bNvMsjpuUMHZRA+2f94TuG2wDNUwNhHkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current wildmatch() call for includeIf's gitdir pattern does not
pass the WM_PATHNAME flag. Without this flag, '*' is treated _almost_
the same as '**' (because '*' also matches slashes) with one exception:

'/**/' can match a single slash. The pattern 'foo/**/bar' matches
'foo/bar'.

But '/*/', which is essentially what wildmatch engine sees without
WM_PATHNAME, has to match two slashes (and '*' matches nothing). Which
means 'foo/*/bar' cannot match 'foo/bar'. It can only match 'foo//bar'.

The result of this is the current wildmatch() call works most of the
time until the user depends on '/**/' matching no path component. The
fix is straightforward.

Reported-by: Jason Karns <jason.karns@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Sorry I didn't notice this until Taylor's reply. Not sure how to
 explain git-lfs behavior though.

 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 0f0cdd8c0f..c2846df3f1 100644
--- a/config.c
+++ b/config.c
@@ -242,7 +242,7 @@ static int include_by_gitdir(const struct config_options *opts,
 	}
 
 	ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
-			 icase ? WM_CASEFOLD : 0);
+			 WM_PATHNAME | (icase ? WM_CASEFOLD : 0));
 
 	if (!ret && !already_tried_absolute) {
 		/*
-- 
2.21.0.548.gd3c7d92dc2

