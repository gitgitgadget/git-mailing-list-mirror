Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D88F2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 16:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbcGAQDt (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 12:03:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35401 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbcGAQDs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 12:03:48 -0400
Received: by mail-lf0-f67.google.com with SMTP id w130so11762792lfd.2
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 09:03:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9hDDyMHTtuM9UaGLMtF4fwpQHacUcKHgF9hmvf/Qkc=;
        b=IpIrOqMjOCi9p5e+XDlPcXptlMt6nWKdpPFPGg1X/qsc8KIm8knrP58zOvnIpaKgK1
         Mlsvsk9FKNtlrlNME31Yoa0HESgwvow2bssn7BBS9qUX3cqFkEtyRI/KovZ+uD8ckGpn
         nbCmB4Z5I6afqn2ss4buQeOm37Ojug2f6cdfErrHaUSqvpREzK7lNiDyCViJYJNkOtTP
         +6UI5yK1uHDw72D8ypPCwIXReWdmOOGuRMda7/6aYvLmfOmIbs7KKZzqDVwDLx11p08M
         4pyfl1jYeqKairg3JFErwedeGYYzDeVSqjP4jFUH5VQbBtu6NDc910A5by9fzxEJWsif
         N8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9hDDyMHTtuM9UaGLMtF4fwpQHacUcKHgF9hmvf/Qkc=;
        b=CHZmm/YDDFH2AF/Uc7eiHNEB52Vr3I3DGOFY85BqFeShP35eJ6TiT5rX4oE1r6Zwn/
         kfmOGtpBF0Gf0gAPhnzQ29o+hcfzSjIB/68tlUb0pV1gE9XOjP2PZD86LF/QsxY6g1vG
         myRMcOGklvImpupU5c+HhWTihT89wmIC4LARbxUzrz8fzDoPY/7JqmzGP+zKxCoGopHa
         c8y6a5BV8KM0UbvtpiP6Re4duJIlYqfUm4RVjI9H7scdO3H51rzeXFCrGte6qMO2J+RU
         AYcMe4IB8D+X4I5Sj7ACgNJMw737TChzmawamKEDHtOOSqeEwxb28cmnAYMlxksAxbdi
         A5Eg==
X-Gm-Message-State: ALyK8tIqK7k8SjiEMCwfUUCWMjeI+TVBClWyUDvDO7HDGwFThWRxNPUjpRXR0JQm+9FZFA==
X-Received: by 10.25.131.141 with SMTP id f135mr5807272lfd.42.1467389026108;
        Fri, 01 Jul 2016 09:03:46 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id k18sm884102lfg.47.2016.07.01.09.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Jul 2016 09:03:45 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 0/5] Better ref summary alignment in "git fetch"
Date:	Fri,  1 Jul 2016 18:03:26 +0200
Message-Id: <20160701160331.29252-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
In-Reply-To: <20160626055810.26960-1-pclouds@gmail.com>
References: <20160626055810.26960-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

v5 changes the substitute symbol from '$' to '*' in compact mode and
makes sure long lines in compact mode will not make the remote ref
column too big (it's far from perfect but I think it's still good to
do).

I'm not sure if we should bring back "{ -> origin/}foo" format. I can
do it if someone still wants it.

Interdiff

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 61e8885..9e42169 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -116,10 +116,10 @@ representing the status of a single ref. Each line is of the form:
 The status of up-to-date refs is shown only if the --verbose option is
 used.
 
-In compact output mode, if either entire `<from>` or `<to>` is found
-in the other string, it will be substituted with `$` in the other
-string. or example, `master -> origin/master` becomes
-`master -> origin/$`.
+In compact output mode, specified with configuration variable
+fetch.output, if either entire `<from>` or `<to>` is found in the
+other string, it will be substituted with `*` in the other string. For
+example, `master -> origin/master` becomes `master -> origin/*`.
 
 flag::
 	A single character indicating the status of the ref:
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9d9f4e8..0a2eed1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -455,7 +455,7 @@ static int compact_format;
 
 static void adjust_refcol_width(const struct ref *ref)
 {
-	int max, rlen, llen;
+	int max, rlen, llen, len;
 
 	/* uptodate lines are only shown on high verbosity level */
 	if (!verbosity && !oidcmp(&ref->peer_ref->old_oid, &ref->old_oid))
@@ -464,16 +464,6 @@ static void adjust_refcol_width(const struct ref *ref)
 	max    = term_columns();
 	rlen   = utf8_strwidth(prettify_refname(ref->name));
 
-	if (compact_format) {
-		/*
-		 * Not precise calculation because '$' can appear in
-		 * ref->name and reduce actual length.
-		 */
-		if (refcol_width < rlen)
-			refcol_width = rlen;
-		return;
-	}
-
 	llen   = utf8_strwidth(prettify_refname(ref->peer_ref->name));
 
 	/*
@@ -482,9 +472,19 @@ static void adjust_refcol_width(const struct ref *ref)
 	 * anyway because we don't know if the error explanation part
 	 * will be printed in update_local_ref)
 	 */
-	if (21 /* flag and summary */ + rlen + 4 /* -> */ + llen >= max)
+	if (compact_format) {
+		llen = 0;
+		max = max * 2 / 3;
+	}
+	len = 21 /* flag and summary */ + rlen + 4 /* -> */ + llen;
+	if (len >= max)
 		return;
 
+	/*
+	 * Not precise calculation for compact mode because '*' can
+	 * appear on the left hand side of '->' and shrink the column
+	 * back.
+	 */
 	if (refcol_width < rlen)
 		refcol_width = rlen;
 }
@@ -519,7 +519,9 @@ static void print_remote_to_local(struct strbuf *display,
 	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
 }
 
-static int dollarize(struct strbuf *haystack, const char *needle)
+static int find_and_replace(struct strbuf *haystack,
+			    const char *needle,
+			    const char *placeholder)
 {
 	const char *p = strstr(haystack->buf, needle);
 	int plen, nlen;
@@ -535,7 +537,8 @@ static int dollarize(struct strbuf *haystack, const char *needle)
 	if (plen > nlen && p[nlen] != '/')
 		return 0;
 
-	strbuf_splice(haystack, p - haystack->buf, nlen, "$", 1);
+	strbuf_splice(haystack, p - haystack->buf, nlen,
+		      placeholder, strlen(placeholder));
 	return 1;
 }
 
@@ -546,15 +549,15 @@ static void print_compact(struct strbuf *display,
 	struct strbuf l = STRBUF_INIT;
 
 	if (!strcmp(remote, local)) {
-		strbuf_addf(display, "%-*s -> $", refcol_width, remote);
+		strbuf_addf(display, "%-*s -> *", refcol_width, remote);
 		return;
 	}
 
 	strbuf_addstr(&r, remote);
 	strbuf_addstr(&l, local);
 
-	if (!dollarize(&r, local))
-		dollarize(&l, remote);
+	if (!find_and_replace(&r, local, "*"))
+		find_and_replace(&l, remote, "*");
 	print_remote_to_local(display, r.buf, l.buf);
 
 	strbuf_release(&r);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 3a92718..6032776 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -712,8 +712,8 @@ test_expect_success 'fetch compact output' '
 			grep -e "->" | cut -c 22- >../actual
 	) &&
 	cat >expect <<-\EOF &&
-	master     -> origin/$
-	extraaa    -> $
+	master     -> origin/*
+	extraaa    -> *
 	EOF
 	test_cmp expect actual
 '

Nguyễn Thái Ngọc Duy (5):
  git-fetch.txt: document fetch output
  fetch: refactor ref update status formatting code
  fetch: change flag code for displaying tag update and deleted ref
  fetch: align all "remote -> local" output
  fetch: reduce duplicate in ref update status lines with placeholder

 Documentation/config.txt    |   5 ++
 Documentation/git-fetch.txt |  51 ++++++++++++
 builtin/fetch.c             | 197 +++++++++++++++++++++++++++++++++++---------
 t/t5510-fetch.sh            |  30 +++++++
 4 files changed, 243 insertions(+), 40 deletions(-)

-- 
2.8.2.531.gd073806

