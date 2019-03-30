Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFA220248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbfC3LUm (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:20:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37012 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbfC3LUl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:20:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id q6so2224152pll.4
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNHEfU5Es+iTRROnoumQYR2DGfc6CnyeuJUutLTjvtc=;
        b=k4gC2F/pdEVY50j27ZA0dyWPBfwJoBvNMZxfD9JEv08u0dUtnzQvjcxgc01rSee1eY
         cANVVo4VYa7DkjUvg1uP9ea7s1xtyRB+sytJ0NKgSiIR2xbPq6n1XzX26ji9O2OAIRdR
         N7NjZGVmImfR0mTjD2kBnEh/X3ABkfKmLOkBQNTDqF069KwEC/E5++mam4D7qGLxEKDY
         6C/uNhFzzUgM0jnbo9sLSDOt+h4IXfs/rAo6FGouWga5ThNkaqGpjBBBuyx+V8qNV5wy
         SpNuktmvaphFL/lx2paRnB6EO5BkvsICg2tzHCwzd/9nOsA7NxT41HW+mCtDvxtCGIcG
         bElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNHEfU5Es+iTRROnoumQYR2DGfc6CnyeuJUutLTjvtc=;
        b=fP44CAHANS6N5QRZ1RmDNZNZH7zxgV35EYoblITULT9S8jFFCWWb8L9nKFjlc9nbtc
         sRcxVddBePDKscFZOFUbZkaHgrNYt5YMx0DZhye6i5uCtqpQmomyQzmV+pyfTzcY5oDw
         R8KpQj9U+PrGqMNzH88/k6X/KhpDXupY6DbF9ueUm87u/wYnbc9KdY0owlC9/vvyxxRI
         8VhBxrjhyO9nrzsRbcoBnk8C12k4cabEwvAbRbdKmhX9fI8rA10f40xFIYSr1R6IjeXZ
         VPbNTCcEqDxzfv8wBMkhggQF7962Kzhf2qG4P8u+sGmaT8ERSVjO33b/Pxpw0827NkRu
         2DjA==
X-Gm-Message-State: APjAAAXMIsKBJiuT099svxWDBbZat1iQDZiXP7kIunokfVBbC2Nv6C+P
        4QymDu32Lxg/8WQyrEY4fTDSezbP
X-Google-Smtp-Source: APXvYqwggAaXdH9+29+ziTIl+JPRugUzTYAn2PcVzbuszmQ5mqYc93IrDAj0sHP8+y/f+KFaPwUGxQ==
X-Received: by 2002:a17:902:2ec1:: with SMTP id r59mr53233220plb.171.1553944840814;
        Sat, 30 Mar 2019 04:20:40 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id e22sm6357001pfi.126.2019.03.30.04.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:20:40 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:20:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/31] refs.c: add refs_shorten_unambiguous_ref()
Date:   Sat, 30 Mar 2019 18:18:59 +0700
Message-Id: <20190330111927.18645-4-pclouds@gmail.com>
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
 refs.c | 11 +++++++++--
 refs.h |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index b869f32d8b..3dde824aab 100644
--- a/refs.c
+++ b/refs.c
@@ -1169,7 +1169,8 @@ int update_ref(const char *msg, const char *refname,
 			       old_oid, flags, onerr);
 }
 
-char *shorten_unambiguous_ref(const char *refname, int strict)
+char *refs_shorten_unambiguous_ref(struct ref_store *refs,
+				   const char *refname, int strict)
 {
 	int i;
 	static char **scanf_fmts;
@@ -1247,7 +1248,7 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 			strbuf_reset(&resolved_buf);
 			strbuf_addf(&resolved_buf, rule,
 				    short_name_len, short_name);
-			if (ref_exists(resolved_buf.buf))
+			if (refs_ref_exists(refs, resolved_buf.buf))
 				break;
 		}
 
@@ -1266,6 +1267,12 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	return xstrdup(refname);
 }
 
+char *shorten_unambiguous_ref(const char *refname, int strict)
+{
+	return refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+					    refname, strict);
+}
+
 static struct string_list *hide_refs;
 
 int parse_hide_refs_config(const char *var, const char *value, const char *section)
diff --git a/refs.h b/refs.h
index 308fa1f03b..5627570241 100644
--- a/refs.h
+++ b/refs.h
@@ -462,6 +462,8 @@ int check_refname_format(const char *refname, int flags);
 
 const char *prettify_refname(const char *refname);
 
+char *refs_shorten_unambiguous_ref(struct ref_store *refs,
+				   const char *refname, int strict);
 char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
-- 
2.21.0.479.g47ac719cd3

