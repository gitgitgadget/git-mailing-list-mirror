Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E741F453
	for <e@80x24.org>; Sat, 29 Sep 2018 19:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeI3BkT (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 21:40:19 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:36232 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbeI3BkT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 21:40:19 -0400
Received: by mail-lf1-f48.google.com with SMTP id v17-v6so7233747lfe.3
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sa+c0EW8tO9MABBq3n/w1rFPMAMz61LAna+tCvyQNp4=;
        b=pYOKHp/EP4nMHmmgxwwyid6AQlhJOIDbNiZhmy5I607ZgUyc60zQHL6I3OFxbzA1aj
         2HheOY3oZmCZTOZShgORfcA8VapIwLmnXR1WrpiTyhxEEqp0JLEXco81/ZR9zkGwjFQI
         gtceZjVYmkb6DKTKA6fIKh0Aihkknvt2BTVHYZP38HL/ychuXce4vl4dHe3HGFHz27Pp
         Mn6ouan3KMTmznzS8RTu8Owd/Lsz0em4Y4ctYSOe09WNYI+h68Bo/n7kegM27UgXfTrU
         /cw1F5lBeuK6YxwQ3U7PKasYQ3BKp/uDgQPLSuQCrUQOkzB77OotlFcQw0/pV94lFEC3
         Og2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sa+c0EW8tO9MABBq3n/w1rFPMAMz61LAna+tCvyQNp4=;
        b=mP3GNAEAYZY0PeSbctrhO/fMJ30HwXsHfKVcDHUfKmmC9EaTYUTfV4UbNxsLXOxk7g
         DIq9hXMcPPoz67ArqPaTTW692/8et66D7E79Y8/dDOj4v1PUPPHiz4MQDof4YwLqaoF9
         OHsRGXz+qzJKWQEuyHJrrkOxWt7uxKaie3rhtUzYLiF8iSpvemU5Nt0AWgPxn7cWqDD4
         sATP0Ww6Zaw2ZKjUfwX4AEGlJrDysB7p5D9LU1PY8/KwCoo1g9h4yI3J2wRe8JhbwvWv
         pltos9uRO9XqsxorhqkOutw3f8P9UZeWWpkOk9HwHvjlPt+w+dUgaF/+SyrdNlqEfIO5
         egiA==
X-Gm-Message-State: ABuFfogSq8vVpH8/hHtwP4wYmyuzmt+H5yr9wCzemx18vFgcJjonS+Af
        tD1S/0G3xeVBD2CB9BAySrk=
X-Google-Smtp-Source: ACcGV61jE+mHKGKw+GESxTl375JH8SCKY6Mp7GpEyiDhBHdTv5oZikABVhsezNgIybCKLwQJBTfc8Q==
X-Received: by 2002:a19:e495:: with SMTP id x21-v6mr1924391lfi.29.1538248243279;
        Sat, 29 Sep 2018 12:10:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c14-v6sm1638494lfi.23.2018.09.29.12.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:10:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 1/8] refs.c: indent with tabs, not spaces
Date:   Sat, 29 Sep 2018 21:10:22 +0200
Message-Id: <20180929191029.13994-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.341.g3acb95d729
In-Reply-To: <20180929191029.13994-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
 <20180929191029.13994-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index a7a75b4cc0..9f7268d5fe 100644
--- a/refs.c
+++ b/refs.c
@@ -646,7 +646,7 @@ enum ref_type ref_type(const char *refname)
 		return REF_TYPE_PER_WORKTREE;
 	if (is_pseudoref_syntax(refname))
 		return REF_TYPE_PSEUDOREF;
-       return REF_TYPE_NORMAL;
+	return REF_TYPE_NORMAL;
 }
 
 long get_files_ref_lock_timeout_ms(void)
-- 
2.19.0.341.g3acb95d729

