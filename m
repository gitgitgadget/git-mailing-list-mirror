Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C4249E6
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbyRKbVE"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84303F4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:28:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7c97d5d5aso73537427b3.3
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698791323; x=1699396123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9v1lTJ6NFAvI1XXmHsVjYLk3AmaHfm3B6E6Cgepk4o=;
        b=tbyRKbVE0jEeSgl1udXI5uCm64ncGPOVdH4Ys9qTn9gjX+lBQ9PKb/zZRJ+rriKtzP
         Zp1t1zTqiiZjYVKHkkSrqbYgfmL5uY0jjziMvPFkVin3XK+yqjf/oDeEIUlyo7/q9d3k
         4wrjPUUgnZkC6H4SGDUQbMQZt4Rky3KQpagxqVkc/xHGZXiyPb2+0vZY9mPIEB2W61mZ
         8UZEOtuyMiBqxfGK+wE9fTqQSXMz07FZwkvu5CCEqA3/VED0o2XgzVi6kBoaH3e4Qud0
         h3JWw26n64jjeTIXu2/kgjCeV7f/wK4RwKabR6xxId9bNT/3qHCoMqV69HZUSylgjgjg
         gncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698791323; x=1699396123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9v1lTJ6NFAvI1XXmHsVjYLk3AmaHfm3B6E6Cgepk4o=;
        b=cLyVA2lz71nZOuONCpFsL329/XQvJ7+Z26U73yMYk2/QLx93Xc8XCPAeNALMTRfmKc
         woN+4+jjXX7NPCw6+JO7xxYwU9ggG8EZHm0pj/PSkU+ItgWWOOzxnpB+XIYm/uH1V1h5
         TmO1E1Rpw998vSsIr7cVe/2kEE3iFCmKhOcbCyyRUuf3vBFeLXYXgYtqrDsJgpq+Itg+
         xYPunm3XRbuSpyaHyE+Uxvx8ML7B3sEgJJxlX3XzATgtGm7+ZiBs/mxU4n7plWFNkeqt
         VSc/kxKVRBtX+6N8RfooHBUMmMWPvlVx83qmYQoeABT3bveRkESUXSEZ6+aBU61oePSv
         Cglw==
X-Gm-Message-State: AOJu0YxQk0Ejf/lCsS/jeCzQe/guQswTkm4yNAF8U/pREg6F+IM69dJi
	gRJn/x79XBRlfPbUNCGBCXcHNLgM4FivnDEF5rm5LMjQ2l2QOoRFpS5XBVPQu5QaiVkyVs0KYM6
	j0Cke+AT7ZWvZjYpyR4Bg+aZJkH1vhC2vtHec5hzK5RMSo2szeR56ySdvH0YNvGCs6Txz7mazdi
	zg
X-Google-Smtp-Source: AGHT+IGGLC4P4M/RBztoO17EtwYisZU2EXiw6bhzjR2bm7QPLum91y0uEe1hoj5aST5TFiNUzlM1vweb1o+KVBIp25cf
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:70a1:f59a:2e01:c62e])
 (user=jonathantanmy job=sendgmr) by 2002:a0d:d716:0:b0:5a7:fc19:a060 with
 SMTP id z22-20020a0dd716000000b005a7fc19a060mr274923ywd.8.1698791323732; Tue,
 31 Oct 2023 15:28:43 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:28:32 -0700
In-Reply-To: <cover.1698791220.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com> <cover.1698791220.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <283f502acb68910cb43d6077eef99d6345aaea4b.1698791220.git.jonathantanmy@google.com>
Subject: [PATCH v2 3/4] strbuf: make add_lines() public
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, Dragan Simic <dsimic@manjaro.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

A subsequent patch will require the ability to add different
prefixes to different lines (depending on their contents), so make
this functionality available from outside strbuf.c. The function
name is chosen to avoid a conflict with the existing function named
strbuf_add_lines().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 strbuf.c | 22 +++++++++++-----------
 strbuf.h |  4 ++++
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 2088f7800a..d5ee8874f8 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -340,24 +340,24 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 	va_end(ap);
 }
 
-static void add_lines(struct strbuf *out,
-			const char *prefix1,
-			const char *prefix2,
-			const char *buf, size_t size)
+void strbuf_add_lines_varied_prefix(struct strbuf *sb,
+				    const char *default_prefix,
+				    const char *tab_nl_prefix,
+				    const char *buf, size_t size)
 {
 	while (size) {
 		const char *prefix;
 		const char *next = memchr(buf, '\n', size);
 		next = next ? (next + 1) : (buf + size);
 
-		prefix = ((prefix2 && (buf[0] == '\n' || buf[0] == '\t'))
-			  ? prefix2 : prefix1);
-		strbuf_addstr(out, prefix);
-		strbuf_add(out, buf, next - buf);
+		prefix = (buf[0] == '\n' || buf[0] == '\t')
+			  ? tab_nl_prefix : default_prefix;
+		strbuf_addstr(sb, prefix);
+		strbuf_add(sb, buf, next - buf);
 		size -= next - buf;
 		buf = next;
 	}
-	strbuf_complete_line(out);
+	strbuf_complete_line(sb);
 }
 
 void strbuf_add_commented_lines(struct strbuf *out,
@@ -370,7 +370,7 @@ void strbuf_add_commented_lines(struct strbuf *out,
 		xsnprintf(prefix1, sizeof(prefix1), "%c ", comment_line_char);
 		xsnprintf(prefix2, sizeof(prefix2), "%c", comment_line_char);
 	}
-	add_lines(out, prefix1, prefix2, buf, size);
+	strbuf_add_lines_varied_prefix(out, prefix1, prefix2, buf, size);
 }
 
 void strbuf_commented_addf(struct strbuf *sb,
@@ -751,7 +751,7 @@ ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 void strbuf_add_lines(struct strbuf *out, const char *prefix,
 		      const char *buf, size_t size)
 {
-	add_lines(out, prefix, NULL, buf, size);
+	strbuf_add_lines_varied_prefix(out, prefix, prefix, buf, size);
 }
 
 void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
diff --git a/strbuf.h b/strbuf.h
index 4547efa62e..a9333ac1ad 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -601,6 +601,10 @@ void strbuf_add_lines(struct strbuf *sb,
 		      const char *prefix,
 		      const char *buf,
 		      size_t size);
+void strbuf_add_lines_varied_prefix(struct strbuf *sb,
+				    const char *default_prefix,
+				    const char *tab_nl_prefix,
+				    const char *buf, size_t size);
 
 /**
  * Append s to sb, with the characters '<', '>', '&' and '"' converted
-- 
2.42.0.820.g83a721a137-goog

