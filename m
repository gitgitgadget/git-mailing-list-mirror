Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3191F404
	for <e@80x24.org>; Mon, 29 Jan 2018 20:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbeA2UTW (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 15:19:22 -0500
Received: from mout.web.de ([212.227.15.4]:50217 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754133AbeA2UTT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 15:19:19 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmxtE-1fGReL28tw-00h8kW; Mon, 29
 Jan 2018 21:19:09 +0100
From:   tboegi@web.de
To:     lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        --to=larsxschneider@gmail.com
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 5/7] convert: add 'working-tree-encoding' attribute
Date:   Mon, 29 Jan 2018 21:19:08 +0100
Message-Id: <20180129201908.9398-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.2.g64d3e4d0cc.dirty
In-Reply-To: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:3qX46qJDEDnt9gVbERl+sh23G+SiOr7335hK3SfKHgkBN+6TGgk
 fzidaiwTWj94FfdtNhqvL607L7DW8C0rcIPi0VgPoLb7OCC92o1fi13ksy4ydJ+S7fbJEmX
 uQIjuNk6ZU/UXT1YpY8IoJHdWRle+LCPisCDYd30+u4nT8xBHzo0PlVka/ZEDOQJXhjJV2u
 h6wSttmzL+D0DdyOU6Cdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/La2pDWi6n0=:wsndL58vwK0WhQzgAERS72
 hL/cYLdShGVzvRbZYgtm97UwJxcs+wJH9YU4cvVNr776ALGyavSY3liObJ7PoQo+eZg/dxlzp
 M8kOrLkl94uDMiHP5EYjpoTc3E+j9ejbciNplasgB66j0XSRuIxuqOrCf3we9VkROFNh9tve5
 0EUSuDOW36EPDMNtojEizr5T8rzunJBMhv633J0oAg4+sfdiShz8THEaeVXwwABWPTY833i9d
 z99azML4zfPgVJva0PgfDDFKcpSOZWgh9UmTYhM1e3FaOqz8woL+NTELfyi4UbGQxl3LjCrSw
 rTj/Zk9WQNdQ/KnnqwdsLU9Swsn5qpDxPtcJk46fu8dSmfKKXwKfh0ztSUjtDwsDJsnowgkHC
 uL0ghMqVtiyVobpwzSvgNBA/3S2uIdIAlpffE3D6ab8DF28PvWAQk17zoyjLl2qXh+NOoIZa6
 YI9NJ3Nq9DXzl7CAbI38UAjOumGr/JQLID1pRn/E6JT+65IBe4aa3oXBt9UHvJ2wObdWWIaQR
 1bK4X5AsF6JFO8yPNLx9tIDsBDU04LPfupzNpTbq1owbPrVplW2q/jVPo+QkKc1BaU+Fu+fnC
 u83Az2g60QVxgow+UP3O10LfFrLIO/TyI4f/IyEA31STSxUMi6qWt66cRIdayLuUrSPJkSRYv
 tQQ6x2UkvHzmOu4gzC+mPV9ZZXca3zrRaqvjtFiRs1tbf4KGz6JBK2jCUQwAgtIFSjApYutUQ
 DK/DXzs2nL8/EloF7CBZEA+6aVIkUTM6qP/91+C/v0Cn8N2p1tMPFamrQokCy/7tW+MMNQRBt
 A6V6yMPFoINuFus6pSriKBvlmAoMX8gBgPbqlcxMWGITpq7J0I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git recognizes files encoded with ASCII or one of its supersets (e.g.
UTF-8 or ISO-8859-1) as text files. All other encodings are usually
interpreted as binary and consequently built-in Git text processing
tools (e.g. 'git diff') as well as most Git web front ends do not
visualize the content.

Add an attribute to tell Git what encoding the user has defined for a
given file. If the content is added to the index, then Git converts the
content to a canonical UTF-8 representation. On checkout Git will
reverse the conversion.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 Documentation/gitattributes.txt  |  60 ++++++++++++
 convert.c                        | 190 ++++++++++++++++++++++++++++++++++++-
 convert.h                        |   1 +
 sha1_file.c                      |   2 +-
 t/t0028-working-tree-encoding.sh | 196 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 447 insertions(+), 2 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 30687de81..a8dbf4be3 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -272,6 +272,66 @@ few exceptions.  Even though...
   catch potential problems early, safety triggers.
 
 
+`working-tree-encoding`
+^^^^^^^^^^^^^^^^^^^^^^^
+
+Git recognizes files encoded with ASCII or one of its supersets (e.g.
+UTF-8 or ISO-8859-1) as text files.  All other encodings are usually
+interpreted as binary and consequently built-in Git text processing
+tools (e.g. 'git diff') as well as most Git web front ends do not
+visualize the content.
+
+In these cases you can tell Git the encoding of a file in the working
+directory with the `working-tree-encoding` attribute. If a file with this
+attributes is added to Git, then Git reencodes the content from the
+specified encoding to UTF-8 and stores the result in its internal data
+structure (called "the index"). On checkout the content is encoded
+back to the specified encoding.
+
+Please note that using the `working-tree-encoding` attribute may have a
+number of pitfalls:
+
+- Git clients that do not support the `working-tree-encoding` attribute
+  will checkout the respective files UTF-8 encoded and not in the
+  expected encoding. Consequently, these files will appear different
+  which typically causes trouble. This is in particular the case for
+  older Git versions and alternative Git implementations such as JGit
+  or libgit2 (as of January 2018).
+
+- Reencoding content to non-UTF encodings (e.g. SHIFT-JIS) can cause
+  errors as the conversion might not be round trip safe.
+
+- Reencoding content requires resources that might slow down certain
+  Git operations (e.g 'git checkout' or 'git add').
+
+Use the `working-tree-encoding` attribute only if you cannot store a file in
+UTF-8 encoding and if you want Git to be able to process the content as
+text.
+
+Use the following attributes if your '*.txt' files are UTF-16 encoded
+with byte order mark (BOM) and you want Git to perform automatic line
+ending conversion based on your platform.
+
+------------------------
+*.txt		text working-tree-encoding=UTF-16
+------------------------
+
+Use the following attributes if your '*.txt' files are UTF-16 little
+endian encoded without BOM and you want Git to use Windows line endings
+in the working directory.
+
+------------------------
+*.txt 		working-tree-encoding=UTF-16LE text eol=CRLF
+------------------------
+
+You can get a list of all available encodings on your platform with the
+following command:
+
+------------------------
+iconv --list
+------------------------
+
+
 `ident`
 ^^^^^^^
 
diff --git a/convert.c b/convert.c
index b976eb968..0c372069b 100644
--- a/convert.c
+++ b/convert.c
@@ -7,6 +7,7 @@
 #include "sigchain.h"
 #include "pkt-line.h"
 #include "sub-process.h"
+#include "utf8.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -265,6 +266,147 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static struct encoding {
+	const char *name;
+	struct encoding *next;
+} *encoding, **encoding_tail;
+static const char *default_encoding = "UTF-8";
+
+static int encode_to_git(const char *path, const char *src, size_t src_len,
+			 struct strbuf *buf, struct encoding *enc, int conv_flags)
+{
+	char *dst;
+	int dst_len;
+
+	/*
+	 * No encoding is specified or there is nothing to encode.
+	 * Tell the caller that the content was not modified.
+	 */
+	if (!enc || (src && !src_len))
+		return 0;
+
+	/*
+	 * Looks like we got called from "would_convert_to_git()".
+	 * This means Git wants to know if it would encode (= modify!)
+	 * the content. Let's answer with "yes", since an encoding was
+	 * specified.
+	 */
+	if (!buf && !src)
+		return 1;
+
+	if (has_prohibited_utf_bom(enc->name, src, src_len)) {
+		const char *error_msg = _(
+			"BOM is prohibited for '%s' if encoded as %s");
+		const char *advise_msg = _(
+			"You told Git to treat '%s' as %s. A byte order mark "
+			"(BOM) is prohibited with this encoding. Either use "
+			"%.6s as working tree encoding or remove the BOM from the "
+			"file.");
+
+		advise(advise_msg, path, enc->name, enc->name, enc->name);
+		if (conv_flags & CONV_WRITE_OBJECT)
+			die(error_msg, path, enc->name);
+		else
+			error(error_msg, path, enc->name);
+
+
+	} else if (has_missing_utf_bom(enc->name, src, src_len)) {
+		const char *error_msg = _(
+			"BOM is required for '%s' if encoded as %s");
+		const char *advise_msg = _(
+			"You told Git to treat '%s' as %s. A byte order mark "
+			"(BOM) is required with this encoding. Either use "
+			"%sBE/%sLE as working tree encoding or add a BOM to the "
+			"file.");
+		advise(advise_msg, path, enc->name, enc->name, enc->name);
+		if (conv_flags & CONV_WRITE_OBJECT)
+			die(error_msg, path, enc->name);
+		else
+			error(error_msg, path, enc->name);
+	}
+
+	dst = reencode_string_len(src, src_len, default_encoding, enc->name,
+				  &dst_len);
+	if (!dst) {
+		/*
+		 * We could add the blob "as-is" to Git. However, on checkout
+		 * we would try to reencode to the original encoding. This
+		 * would fail and we would leave the user with a messed-up
+		 * working tree. Let's try to avoid this by screaming loud.
+		 */
+		const char* msg = _("failed to encode '%s' from %s to %s");
+		if (conv_flags & CONV_WRITE_OBJECT)
+			die(msg, path, enc->name, default_encoding);
+		else
+			error(msg, path, enc->name, default_encoding);
+	}
+
+	/*
+	 * UTF supports lossless round tripping [1]. UTF to other encoding are
+	 * mostly round trip safe as Unicode aims to be a superset of all other
+	 * character encodings. However, the SHIFT-JIS (Japanese character set)
+	 * is an exception as some codes are not round trip safe [2].
+	 *
+	 * Reverse the transformation of 'dst' and check the result with 'src'
+	 * if content is written to Git. This ensures no information is lost
+	 * during conversion to/from UTF-8.
+	 *
+	 * Please note, the code below is not tested because I was not able to
+	 * generate a faulty round trip without iconv error.
+	 *
+	 * [1] http://unicode.org/faq/utf_bom.html#gen2
+	 * [2] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
+	 */
+	if ((conv_flags & CONV_WRITE_OBJECT) && !strcmp(enc->name, "SHIFT-JIS")) {
+		char *re_src;
+		int re_src_len;
+
+		re_src = reencode_string_len(dst, dst_len,
+					     enc->name, default_encoding,
+					     &re_src_len);
+
+		if (!re_src || src_len != re_src_len ||
+		    memcmp(src, re_src, src_len)) {
+			const char* msg = _("encoding '%s' from %s to %s and "
+					    "back is not the same");
+			if (conv_flags & CONV_WRITE_OBJECT)
+				die(msg, path, enc->name, default_encoding);
+			else
+				error(msg, path, enc->name, default_encoding);
+		}
+
+		free(re_src);
+	}
+
+	strbuf_attach(buf, dst, dst_len, dst_len + 1);
+	return 1;
+}
+
+static int encode_to_worktree(const char *path, const char *src, size_t src_len,
+			      struct strbuf *buf, struct encoding *enc)
+{
+	char *dst;
+	int dst_len;
+
+	/*
+	 * No encoding is specified or there is nothing to encode.
+	 * Tell the caller that the content was not modified.
+	 */
+	if (!enc || (src && !src_len))
+		return 0;
+
+	dst = reencode_string_len(src, src_len, enc->name, default_encoding,
+				  &dst_len);
+	if (!dst) {
+		error("failed to encode '%s' from %s to %s",
+			path, enc->name, default_encoding);
+		return 0;
+	}
+
+	strbuf_attach(buf, dst, dst_len, dst_len + 1);
+	return 1;
+}
+
 static int crlf_to_git(const struct index_state *istate,
 		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
@@ -978,6 +1120,31 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
+static struct encoding *git_path_check_encoding(struct attr_check_item *check)
+{
+	const char *value = check->value;
+	struct encoding *enc;
+
+	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value) ||
+	    !strlen(value))
+		return NULL;
+
+	for (enc = encoding; enc; enc = enc->next)
+		if (!strcasecmp(value, enc->name))
+			return enc;
+
+	/* Don't encode to the default encoding */
+	if (!strcasecmp(value, default_encoding))
+		return NULL;
+
+	enc = xcalloc(1, sizeof(struct convert_driver));
+	enc->name = xstrdup_toupper(value);  /* aways use upper case names! */
+	*encoding_tail = enc;
+	encoding_tail = &(enc->next);
+
+	return enc;
+}
+
 static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
 {
 	const char *value = check->value;
@@ -1033,6 +1200,7 @@ struct conv_attrs {
 	enum crlf_action attr_action; /* What attr says */
 	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
 	int ident;
+	struct encoding *checkout_encoding; /* Supported encoding or default encoding if NULL */
 };
 
 static void convert_attrs(struct conv_attrs *ca, const char *path)
@@ -1041,8 +1209,10 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 
 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
-					 "eol", "text", NULL);
+					 "eol", "text", "working-tree-encoding",
+					 NULL);
 		user_convert_tail = &user_convert;
+		encoding_tail = &encoding;
 		git_config(read_convert_config, NULL);
 	}
 
@@ -1064,6 +1234,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 			else if (eol_attr == EOL_CRLF)
 				ca->crlf_action = CRLF_TEXT_CRLF;
 		}
+		ca->checkout_encoding = git_path_check_encoding(ccheck + 5);
 	} else {
 		ca->drv = NULL;
 		ca->crlf_action = CRLF_UNDEFINED;
@@ -1144,6 +1315,13 @@ int convert_to_git(const struct index_state *istate,
 		src = dst->buf;
 		len = dst->len;
 	}
+
+	ret |= encode_to_git(path, src, len, dst, ca.checkout_encoding, conv_flags);
+	if (ret && dst) {
+		src = dst->buf;
+		len = dst->len;
+	}
+
 	if (!(conv_flags & CONV_EOL_KEEP_CRLF)) {
 		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, conv_flags);
 		if (ret && dst) {
@@ -1167,6 +1345,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
+	encode_to_git(path, dst->buf, dst->len, dst, ca.checkout_encoding, conv_flags);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
@@ -1198,6 +1377,12 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}
 
+	ret |= encode_to_worktree(path, src, len, dst, ca.checkout_encoding);
+	if (ret) {
+		src = dst->buf;
+		len = dst->len;
+	}
+
 	ret_filter = apply_filter(
 		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, dco);
 	if (!ret_filter && ca.drv && ca.drv->required)
@@ -1664,6 +1849,9 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
 		return NULL;
 
+	if (ca.checkout_encoding)
+		return NULL;
+
 	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
 		return NULL;
 
diff --git a/convert.h b/convert.h
index 65ab3e516..1d9539ed0 100644
--- a/convert.h
+++ b/convert.h
@@ -12,6 +12,7 @@ struct index_state;
 #define CONV_EOL_RNDTRP_WARN  (1<<1) /* Warn if CRLF to LF to CRLF is different */
 #define CONV_EOL_RENORMALIZE  (1<<2) /* Convert CRLF to LF */
 #define CONV_EOL_KEEP_CRLF    (1<<3) /* Keep CRLF line endings as is */
+#define CONV_WRITE_OBJECT     (1<<4) /* Content is written to the index */
 
 extern int global_conv_flags_eol;
 
diff --git a/sha1_file.c b/sha1_file.c
index 6bc7c6ada..e2f319d67 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -138,7 +138,7 @@ static int get_conv_flags(unsigned flags)
 	if (flags & HASH_RENORMALIZE)
 		return CONV_EOL_RENORMALIZE;
 	else if (flags & HASH_WRITE_OBJECT)
-	  return global_conv_flags_eol;
+		return global_conv_flags_eol | CONV_WRITE_OBJECT;
 	else
 		return 0;
 }
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
new file mode 100755
index 000000000..4d85b4277
--- /dev/null
+++ b/t/t0028-working-tree-encoding.sh
@@ -0,0 +1,196 @@
+#!/bin/sh
+
+test_description='working-tree-encoding conversion via gitattributes'
+
+. ./test-lib.sh
+
+test_expect_success 'setup test repo' '
+	git config core.eol lf &&
+
+	text="hallo there!\ncan you read me?" &&
+	echo "*.utf16 text working-tree-encoding=utf-16" >.gitattributes &&
+	printf "$text" >test.utf8.raw &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
+	cp test.utf16.raw test.utf16 &&
+
+	git add .gitattributes test.utf16 &&
+	git commit -m initial
+'
+
+test_expect_success 'ensure UTF-8 is stored in Git' '
+	git cat-file -p :test.utf16 >test.utf16.git &&
+	test_cmp_bin test.utf8.raw test.utf16.git &&
+	rm test.utf8.raw test.utf16.git
+'
+
+test_expect_success 're-encode to UTF-16 on checkout' '
+	rm test.utf16 &&
+	git checkout test.utf16 &&
+	test_cmp_bin test.utf16.raw test.utf16 &&
+
+	# cleanup
+	rm test.utf16.raw
+'
+
+test_expect_success 'check prohibited UTF BOM' '
+	printf "\0a\0b\0c"                         >nobom.utf16be.raw &&
+	printf "a\0b\0c\0"                         >nobom.utf16le.raw &&
+	printf "\376\777\0a\0b\0c"                 >bebom.utf16be.raw &&
+	printf "\777\376a\0b\0c\0"                 >lebom.utf16le.raw &&
+
+	printf "\0\0\0a\0\0\0b\0\0\0c"             >nobom.utf32be.raw &&
+	printf "a\0\0\0b\0\0\0c\0\0\0"             >nobom.utf32le.raw &&
+	printf "\0\0\376\777\0\0\0a\0\0\0b\0\0\0c" >bebom.utf32be.raw &&
+	printf "\777\376\0\0a\0\0\0b\0\0\0c\0\0\0" >lebom.utf32le.raw &&
+
+	echo "*.utf16be text working-tree-encoding=utf-16be" >>.gitattributes &&
+	echo "*.utf16le text working-tree-encoding=utf-16le" >>.gitattributes &&
+	echo "*.utf32be text working-tree-encoding=utf-32be" >>.gitattributes &&
+	echo "*.utf32le text working-tree-encoding=utf-32le" >>.gitattributes &&
+
+	# Here we add a UTF-16 files with BOM (big-endian and little-endian)
+	# but we tell Git to treat it as UTF-16BE/UTF-16LE. In these cases
+	# the BOM is prohibited.
+	cp bebom.utf16be.raw bebom.utf16be &&
+	test_must_fail git add bebom.utf16be 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out &&
+
+	cp lebom.utf16le.raw lebom.utf16be &&
+	test_must_fail git add lebom.utf16be 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out &&
+
+	cp bebom.utf16be.raw bebom.utf16le &&
+	test_must_fail git add bebom.utf16le 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out &&
+
+	cp lebom.utf16le.raw lebom.utf16le &&
+	test_must_fail git add lebom.utf16le 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out &&
+
+	# ... and the same for UTF-32
+	cp bebom.utf32be.raw bebom.utf32be &&
+	test_must_fail git add bebom.utf32be 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out &&
+
+	cp lebom.utf32le.raw lebom.utf32be &&
+	test_must_fail git add lebom.utf32be 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out &&
+
+	cp bebom.utf32be.raw bebom.utf32le &&
+	test_must_fail git add bebom.utf32le 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out &&
+
+	cp lebom.utf32le.raw lebom.utf32le &&
+	test_must_fail git add lebom.utf32le 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out &&
+
+	# cleanup
+	git reset --hard HEAD
+'
+
+test_expect_success 'check required UTF BOM' '
+	echo "*.utf32 text working-tree-encoding=utf-32" >>.gitattributes &&
+
+	cp nobom.utf16be.raw nobom.utf16 &&
+	test_must_fail git add nobom.utf16 2>err.out &&
+	test_i18ngrep "fatal: BOM is required .* UTF-16" err.out &&
+
+	cp nobom.utf16le.raw nobom.utf16 &&
+	test_must_fail git add nobom.utf16 2>err.out &&
+	test_i18ngrep "fatal: BOM is required .* UTF-16" err.out &&
+
+	cp nobom.utf32be.raw nobom.utf32 &&
+	test_must_fail git add nobom.utf32 2>err.out &&
+	test_i18ngrep "fatal: BOM is required .* UTF-32" err.out &&
+
+	cp nobom.utf32le.raw nobom.utf32 &&
+	test_must_fail git add nobom.utf32 2>err.out &&
+	test_i18ngrep "fatal: BOM is required .* UTF-32" err.out &&
+
+	# cleanup
+	rm nobom.utf16 nobom.utf32 &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'eol conversion for UTF-16 encoded files on checkout' '
+	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
+	printf "one\r\ntwo\r\nthree\r\n" >crlf.utf8.raw &&
+
+	cat lf.utf8.raw | iconv -f UTF-8 -t UTF-16 >lf.utf16.raw &&
+	cat crlf.utf8.raw | iconv -f UTF-8 -t UTF-16 >crlf.utf16.raw &&
+	cp crlf.utf16.raw eol.utf16 &&
+
+	git add eol.utf16 &&
+	git commit -m eol &&
+
+	# UTF-16 with CRLF (Windows line endings)
+	rm eol.utf16 &&
+	git -c core.eol=crlf checkout eol.utf16 &&
+	test_cmp_bin crlf.utf16.raw eol.utf16 &&
+
+	# UTF-16 with LF (Unix line endings)
+	rm eol.utf16 &&
+	git -c core.eol=lf checkout eol.utf16 &&
+	test_cmp_bin lf.utf16.raw eol.utf16 &&
+
+	rm crlf.utf16.raw crlf.utf8.raw lf.utf16.raw lf.utf8.raw &&
+
+	# cleanup
+	git reset --hard HEAD^
+'
+
+test_expect_success 'check unsupported encodings' '
+
+	echo "*.nothing text working-tree-encoding=" >>.gitattributes &&
+	printf "nothing" >t.nothing &&
+	git add t.nothing &&
+
+	echo "*.garbage text working-tree-encoding=garbage" >>.gitattributes &&
+	printf "garbage" >t.garbage &&
+	test_must_fail git add t.garbage 2>err.out &&
+	test_i18ngrep "fatal: failed to encode" err.out &&
+
+	# cleanup
+	rm err.out &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'error if encoding round trip is not the same during refresh' '
+	BEFORE_STATE=$(git rev-parse HEAD) &&
+
+	# Skip the UTF-16 filter for the added file
+	# This simulates a Git version that has no working tree encoding support
+	echo "hallo" >nonsense.utf16 &&
+	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
+	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
+	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
+	git update-ref refs/heads/master $COMMIT &&
+
+	test_must_fail git checkout HEAD^ 2>err.out &&
+	test_i18ngrep "error: .* overwritten by checkout:" err.out &&
+
+	# cleanup
+	rm err.out &&
+	git reset --hard $BEFORE_STATE
+'
+
+test_expect_success 'error if encoding garbage is already in Git' '
+	BEFORE_STATE=$(git rev-parse HEAD) &&
+
+	# Skip the UTF-16 filter for the added file
+	# This simulates a Git version that has no checkoutEncoding support
+	cp nobom.utf16be.raw nonsense.utf16 &&
+	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
+	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
+	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
+	git update-ref refs/heads/master $COMMIT &&
+
+	git diff 2>err.out &&
+	test_i18ngrep "error: BOM is required" err.out &&
+
+	# cleanup
+	rm err.out &&
+	git reset --hard $BEFORE_STATE
+'
+
+test_done
-- 
2.16.0.rc0.2.g64d3e4d0cc.dirty

