Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 906061F404
	for <e@80x24.org>; Mon, 29 Jan 2018 20:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932536AbeA2UTY (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 15:19:24 -0500
Received: from mout.web.de ([212.227.15.3]:65384 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754740AbeA2UTT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 15:19:19 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3jsn-1exVd81G6L-00rGac; Mon, 29
 Jan 2018 21:19:11 +0100
From:   tboegi@web.de
To:     lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        --to=larsxschneider@gmail.com
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 6/7] convert: add tracing for 'working-tree-encoding' attribute
Date:   Mon, 29 Jan 2018 21:19:09 +0100
Message-Id: <20180129201909.9441-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.2.g64d3e4d0cc.dirty
In-Reply-To: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:YvvVkCkhbLELQZq9vPb5QB+F+J7vbWZmnfavyLSgDFPAhOD6Bva
 pwPZ3qsiSAaYVU53aGb3aB3704FFOGDh9ZgrbkcHhGTOugSOvH+oi9k/QUyG817Gx0uPxFa
 yKGK1glOZWmOZwO2Bl55kn8pn9il0EjWdjDGSg2a7A45vYSlHOM5J5VckdyWX5vKndPENMD
 7UHApzFEww2bHSn+MQOrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YlywbgWvgp8=:hXskoQTbiwov8XIvYz0PuU
 8W63csTbnUnsGvqSTfbr0pOA33YUOgiTa9hJ4I2dG0VElWf+xYyiwXjtw9o8pqoSZk4g1HWN2
 uPsFXHF6tNuVvb3CCsPP/n1Jjsii8ypdUiDgE7cTvLlreytf0HKDXnM9MpfGwy+PN1B3jdVKS
 EDLWuPDu3RGI/5CO0p2gOw+ZjSv58veJ4ZPS2tmr9k1xAjWs9Rbfx92WUXZ/OgLgk2sEb98lr
 +Ztl90xYNoIh/E99GzLKZIkA9PtKqUb4aQoHkpraCq+e7dGGC6hzbu/UqLD594Kq5Ubq2vlcV
 HSz+eCpcF9KSO6bDAuUWwAVSrBaQpFR/srcS7pLp/jvDyT1Myu5TYQgCfqEFFQLCw61j78PQy
 NFjSUmGNYNWC4bwK0JIL3U8tkzHuogbHPTDZDSn9tgre+20drednSVw+XVwi4SNJuto64bxfR
 0vqVG71wkb5vRWc5h1yA6dAVW4pAa1bTU3wABh4aCQHzHPqmHJalbk8vReSVpA9w0ezCysv61
 ImZ50VlrfEMN+QMHmlwuyK0gKIEMsHL7mW9KJtnbyPRk+S3xJrQxqbo32LsnwxkrLGNFmIJ8R
 YWx4M7DI0LKgT7r2368OERpKOXK0JxZXn0yOHxygEbznZXBsUWNefDWHv5Ys9NCDXkeQj78mh
 3FHIQvW3tJauLUDFWesVVK3viPpcWEZI6cjkJdQKZFGo1UMVUOzEjUBYqKaztSGZwWjmJ/vI6
 xKPExjEfbdB8IJnbLC6dH+I2cH9cKdgcegNpi5q9XjjK7zZ8ZTDP+KuMXVYh9I1KQTSKtDNRl
 2EQuhodHr8aivU1PgkBvpFPRGhipKOhOMkXmeTo46fuYsIbreY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Add the GIT_TRACE_CHECKOUT_ENCODING environment variable to enable
tracing for content that is reencoded with the 'working-tree-encoding'
attribute. This is useful to debug encoding issues.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 convert.c                        | 28 ++++++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/convert.c b/convert.c
index 0c372069b..13fad490c 100644
--- a/convert.c
+++ b/convert.c
@@ -266,6 +266,29 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static void trace_encoding(const char *context, const char *path,
+			   const char *encoding, const char *buf, size_t len)
+{
+	static struct trace_key coe = TRACE_KEY_INIT(CHECKOUT_ENCODING);
+	struct strbuf trace = STRBUF_INIT;
+	int i;
+
+	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
+	for (i = 0; i < len && buf; ++i) {
+		strbuf_addf(
+			&trace,"| \e[2m%2i:\e[0m %2x \e[2m%c\e[0m%c",
+			i,
+			(unsigned char) buf[i],
+			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
+			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
+		);
+	}
+	strbuf_addchars(&trace, '\n', 1);
+
+	trace_strbuf(&coe, &trace);
+	strbuf_release(&trace);
+}
+
 static struct encoding {
 	const char *name;
 	struct encoding *next;
@@ -325,6 +348,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 			error(error_msg, path, enc->name);
 	}
 
+	trace_encoding("source", path, enc->name, src, src_len);
 	dst = reencode_string_len(src, src_len, default_encoding, enc->name,
 				  &dst_len);
 	if (!dst) {
@@ -340,6 +364,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 		else
 			error(msg, path, enc->name, default_encoding);
 	}
+	trace_encoding("destination", path, default_encoding, dst, dst_len);
 
 	/*
 	 * UTF supports lossless round tripping [1]. UTF to other encoding are
@@ -365,6 +390,9 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 					     enc->name, default_encoding,
 					     &re_src_len);
 
+		trace_encoding("reencoded source", path, enc->name,
+			       re_src, re_src_len);
+
 		if (!re_src || src_len != re_src_len ||
 		    memcmp(src, re_src, src_len)) {
 			const char* msg = _("encoding '%s' from %s to %s and "
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 4d85b4277..0f36d4990 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -4,6 +4,8 @@ test_description='working-tree-encoding conversion via gitattributes'
 
 . ./test-lib.sh
 
+GIT_TRACE_CHECKOUT_ENCODING=1 && export GIT_TRACE_CHECKOUT_ENCODING
+
 test_expect_success 'setup test repo' '
 	git config core.eol lf &&
 
-- 
2.16.0.rc0.2.g64d3e4d0cc.dirty

