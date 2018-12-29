Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ECC81F405
	for <e@80x24.org>; Sat, 29 Dec 2018 11:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeL2LJ3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 06:09:29 -0500
Received: from mout.web.de ([212.227.17.11]:44971 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbeL2LJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 06:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1546081766;
        bh=H7rrC1TnanoMwgzrecEJ9ZrzmVVGOH1xLXljMSBH1XM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TYSxtp6BhMN1tNUD2AYFWWYjrnZKIdTKONtYeAFnxPgYX8pZxzGoWflSHLO9RaVot
         7sGpIZbTblyGA7qkfKIfKsLOhixqsH0jinZRgzVLJyPr6VfKwmvTZKc7OQkd3NWeDI
         pOw3jPPAL4dQ9cMw4v4m0rk4kvAcQgIAUNpnqtOc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M41Bm-1hTW8C1qra-00rXFN; Sat, 29
 Dec 2018 12:09:26 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, adrigibal@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC v1 1/1] Support working-tree-encoding "UTF-16LE-BOM"
Date:   Sat, 29 Dec 2018 12:09:24 +0100
Message-Id: <20181229110924.26598-1-tboegi@web.de>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671b
In-Reply-To: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ldoJC5uOULeIAP41qOUVasXjGGpKAFk6ujFiEfU9BNj8v+bzB/I
 cCSPH/eWb2rKdrQMNkWPPj7/9EX6eUvvp3nCiaiXcIrPQ6dzXDjrVLOmwb5DbTKDme/h7qs
 0oN/ZxuHSH5+/cMWRfHnKIcschD4o0pN+0Zuww+ZqqMklQxqVycofbGlC6v8sIsgpj8lm9/
 72gbb8LGlzfe2odrfEROw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UTbC++mKLvo=:3fF2Vu6qdH0Np4/UX3o7BO
 bUkLQb19qcYpY0iJQNYnPXCPArJmDyDGoe0W4k0D3Ki0PQDlitQLk+67FQrhBqgXpOt+Bk6uG
 IBn5rWZ7aos1xklNWPjiOZGxzFLMmzhflYUuZ9Qz77UGXhRdO47GN15TwmrcSrbcIFXCip4Zk
 c4wbMxXriKWjf3Ht4WqXx9FsDQEDTnuqDnmhOoW2E8zwKRl16AvfKV6qe6eMdQ1abjfKLNauH
 n3OlDkYqA4n6luYtmDfqLWI19mwpLDMWM+BbekQgaBlIpvEvbLX2pEEHLPbMEv5eT663/9MtT
 XL+nt4lBq4KIAh77tKaHJ99kLURczAn4iS+OD4wkwonj6we7m+t+FYeFYUB1v3x1YJTBFvmIN
 9XFIl1CzI+Fxyu+OJmasdf6655kAKpq1CLOFvQA0paomS8iTm8mj8du0CQ0E0OsQ8q4XI7cCD
 whcirME/IsUiv6vIT7KkNK78HuAwavWoITGHMzH7IscMxhBkxBRFPWyiLNuLeyg9l7a1yp5oG
 2FU53QLNm7VK7qq3ew+1iiglZZlYGoot++D5qWd1H+FpAxbJ2Dy/etQfunv3o8PffOvX1gtX2
 2Kr2+BdHiTXMpG+5CyfLFNLGNdXmqdySNZb8hSjJGcNSE5isXJd86++Hdx8LcWqp2r8U4KFUv
 QYYx/2YFraguXxwK3hdJ4FCw98DtCh4HuCsRcVuKnpM5OcTxhBEnOgCDCWVCpbjgzSjjxffcD
 9F0UPp+J187ucc3xkWcR/pCELgWEg2dhk5d9mGp8+GbAdEIONUWQE4Q57GgVkoCcRufBmsWsd
 iC/r8PtN/PCBr/5d6ZyajbqZjx8C6iJgl1R1XDGQS0kTVQYf4qd+3UJ30joe6DKW3zYjBEdkm
 2dre8naOquRtbCcWkxC6w6J35LsbMCE7fwBVAu43/V3I2MhXTba425OEro0rMc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Users who want UTF-16 files in the working tree set the .gitattributes
like this:
test.txt working-tree-encoding=UTF-16

After a checkout, the resulting file has a BOM and is encoded in "UTF-16".
The unicode standard allows both little- and big-endianess (LE/BE) for
those files, the BOM will tell which one is used inside the file.
iconv seems to prefer the BE version.
Not all users under Windows are happy with this when tools are not fully
unicode aware and don't digest the BE version at all.

Today there is no name for "UTF-16 with BOM, little endian please".
Introduce "UTF-16LE-BOM".

Rported-by: Adrián Gimeno Balaguer <adrigibal@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

This feels like an RFC at the moment - please comment.
Using UTF-16 in the way "UTF-16LE-BOM" is used in this patch
could be an alternative - simply produce UTF-16 in LE version
under Git - this could make people using Git happy as well.

Documentation/gitattributes.txt  |  4 +--
 compat/precompose_utf8.c         |  2 +-
 t/t0028-working-tree-encoding.sh | 12 ++++++++-
 utf8.c                           | 42 ++++++++++++++++++++++++--------
 utf8.h                           |  2 +-
 5 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b8392fc330..4a88ab8be7 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -343,13 +343,13 @@ automatic line ending conversion based on your platform.
 ------------------------
 
 Use the following attributes if your '*.ps1' files are UTF-16 little
-endian encoded without BOM and you want Git to use Windows line endings
+endian encoded with BOM and you want Git to use Windows line endings
 in the working directory. Please note, it is highly recommended to
 explicitly define the line endings with `eol` if the `working-tree-encoding`
 attribute is used to avoid ambiguity.
 
 ------------------------
-*.ps1		text working-tree-encoding=UTF-16LE eol=CRLF
+*.ps1		text working-tree-encoding=UTF-16LE-BOM eol=CRLF
 ------------------------
 
 You can get a list of all available encodings on your platform with the
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index de61c15d34..136250fbf6 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -79,7 +79,7 @@ void precompose_argv(int argc, const char **argv)
 		size_t namelen;
 		oldarg = argv[i];
 		if (has_non_ascii(oldarg, (size_t)-1, &namelen)) {
-			newarg = reencode_string_iconv(oldarg, namelen, ic_precompose, NULL);
+			newarg = reencode_string_iconv(oldarg, namelen, ic_precompose, 0, NULL);
 			if (newarg)
 				argv[i] = newarg;
 		}
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 7e87b5a200..e58ecbfc44 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -11,9 +11,12 @@ test_expect_success 'setup test files' '
 
 	text="hallo there!\ncan you read me?" &&
 	echo "*.utf16 text working-tree-encoding=utf-16" >.gitattributes &&
+	echo "*.utf16lebom text working-tree-encoding=UTF-16LE-BOM" >>.gitattributes &&
 	printf "$text" >test.utf8.raw &&
 	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
 	printf "$text" | iconv -f UTF-8 -t UTF-32 >test.utf32.raw &&
+	printf "\377\376"                         >test.utf16lebom.raw &&
+	printf "$text" | iconv -f UTF-8 -t UTF-32LE >>test.utf16lebom.raw &&
 
 	# Line ending tests
 	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
@@ -32,7 +35,8 @@ test_expect_success 'setup test files' '
 	# Add only UTF-16 file, we will add the UTF-32 file later
 	cp test.utf16.raw test.utf16 &&
 	cp test.utf32.raw test.utf32 &&
-	git add .gitattributes test.utf16 &&
+	cp test.utf16lebom.raw test.utf16lebom &&
+	git add .gitattributes test.utf16 test.utf16lebom &&
 	git commit -m initial
 '
 
@@ -51,6 +55,12 @@ test_expect_success 're-encode to UTF-16 on checkout' '
 	test_cmp_bin test.utf16.raw test.utf16
 '
 
+test_expect_success 're-encode to UTF-16-LE-BOM on checkout' '
+	rm test.utf16lebom &&
+	git checkout test.utf16lebom &&
+	test_cmp_bin test.utf16lebom.raw test.utf16lebom
+'
+
 test_expect_success 'check $GIT_DIR/info/attributes support' '
 	test_when_finished "rm -f test.utf32.git" &&
 	test_when_finished "git reset --hard HEAD" &&
diff --git a/utf8.c b/utf8.c
index eb78587504..83824dc2f4 100644
--- a/utf8.c
+++ b/utf8.c
@@ -4,6 +4,11 @@
 
 /* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */
 
+static const char utf16_be_bom[] = {'\xFE', '\xFF'};
+static const char utf16_le_bom[] = {'\xFF', '\xFE'};
+static const char utf32_be_bom[] = {'\0', '\0', '\xFE', '\xFF'};
+static const char utf32_le_bom[] = {'\xFF', '\xFE', '\0', '\0'};
+
 struct interval {
 	ucs_char_t first;
 	ucs_char_t last;
@@ -470,16 +475,17 @@ int utf8_fprintf(FILE *stream, const char *format, ...)
 #else
 	typedef char * iconv_ibp;
 #endif
-char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv, size_t *outsz_p)
+char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv,
+			    size_t bom_len, size_t *outsz_p)
 {
 	size_t outsz, outalloc;
 	char *out, *outpos;
 	iconv_ibp cp;
 
 	outsz = insz;
-	outalloc = st_add(outsz, 1); /* for terminating NUL */
+	outalloc = st_add(outsz, 1 + bom_len); /* for terminating NUL */
 	out = xmalloc(outalloc);
-	outpos = out;
+	outpos = out + bom_len;
 	cp = (iconv_ibp)in;
 
 	while (1) {
@@ -540,10 +546,30 @@ char *reencode_string_len(const char *in, size_t insz,
 {
 	iconv_t conv;
 	char *out;
+	const char *bom_str = NULL;
+	size_t bom_len = 0;
 
 	if (!in_encoding)
 		return NULL;
 
+	/* UTF-16LE-BOM is the same as UTF-16 for reading */
+	if (same_utf_encoding("UTF-16LE-BOM", in_encoding))
+		in_encoding = "UTF-16";
+
+	/*
+	 * For writing, UTF-16 iconv typically creates "UTF-16BE-BOM"
+	 * Some users under Windows want the little endian version
+	 */
+	if (same_utf_encoding("UTF-16LE-BOM", out_encoding)) {
+		bom_str = utf16_le_bom;
+		bom_len = sizeof(utf16_le_bom);
+		out_encoding = "UTF-16LE";
+	} else if (same_utf_encoding("UTF-16BE-BOM", out_encoding)) {
+		bom_str = utf16_be_bom;
+		bom_len = sizeof(utf16_be_bom);
+		out_encoding = "UTF-16BE";
+	}
+
 	conv = iconv_open(out_encoding, in_encoding);
 	if (conv == (iconv_t) -1) {
 		in_encoding = fallback_encoding(in_encoding);
@@ -553,9 +579,10 @@ char *reencode_string_len(const char *in, size_t insz,
 		if (conv == (iconv_t) -1)
 			return NULL;
 	}
-
-	out = reencode_string_iconv(in, insz, conv, outsz);
+	out = reencode_string_iconv(in, insz, conv, bom_len, outsz);
 	iconv_close(conv);
+	if (out && bom_str && bom_len)
+		memcpy(out, bom_str, bom_len);
 	return out;
 }
 #endif
@@ -566,11 +593,6 @@ static int has_bom_prefix(const char *data, size_t len,
 	return data && bom && (len >= bom_len) && !memcmp(data, bom, bom_len);
 }
 
-static const char utf16_be_bom[] = {'\xFE', '\xFF'};
-static const char utf16_le_bom[] = {'\xFF', '\xFE'};
-static const char utf32_be_bom[] = {'\0', '\0', '\xFE', '\xFF'};
-static const char utf32_le_bom[] = {'\xFF', '\xFE', '\0', '\0'};
-
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 {
 	return (
diff --git a/utf8.h b/utf8.h
index edea55e093..84efbfcb1f 100644
--- a/utf8.h
+++ b/utf8.h
@@ -27,7 +27,7 @@ void strbuf_utf8_replace(struct strbuf *sb, int pos, int width,
 
 #ifndef NO_ICONV
 char *reencode_string_iconv(const char *in, size_t insz,
-			    iconv_t conv, size_t *outsz);
+			    iconv_t conv, size_t bom_len, size_t *outsz);
 char *reencode_string_len(const char *in, size_t insz,
 			  const char *out_encoding,
 			  const char *in_encoding,
-- 
2.20.1.2.gb21ebb671b

