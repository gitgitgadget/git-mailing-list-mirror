Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124337EFF1
	for <git@vger.kernel.org>; Fri,  1 May 2026 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677324; cv=none; b=lJJmbRY5GnmeyfSltMmOwkEoz4AW9RxckfhWvp4PltO0sT2FA5allZctMTjtnMy4O31rkQwd+HP6em6LsYR2JC6V5hUws4HUTKwNVQ5o3ydxQ/22gcqQm3IWyNWOJ6Z8tHaxq67Cdxwl8BxkOchhx+yEBi+eDW8QRh4VYO2jPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677324; c=relaxed/simple;
	bh=xOc3ixtvifsRbiNTpqbKOasQvxiq6AL0C/ruih0HFT0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HvLC9MsFD3MvJZnInhlIgLipzDnv2c+9QiPSpDIH8QBaaLVNqtGVoRypPpcS4I3bE3w+vk/xWak3oinpmY0h6Z7iqCP4RAIvN9wEJxvB7dejbPo28zvXS24g1p3ikHV7gC8B0sGSVRH5OHLrVVR7q7cdSvsYVVVLd8rdeeRkGlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnLiqG5O; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnLiqG5O"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ee1054627bso1361898eec.1
        for <git@vger.kernel.org>; Fri, 01 May 2026 16:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777677321; x=1778282121; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1FcgKCPtp8aMtVy2VuU03D6lZFtPAQ/96elesR+jbo=;
        b=RnLiqG5OfgjBH4HU6AsxBL2bXMJWSbAP4dunOTDxyxnK4LbCXVY0+lgr3bZyiH60qd
         GGucWyfEHVSN5ujwZVZ/yOXnFxpMi34UzPEuNiCsQ2bgvTbVIRojeNO1/Hw3C58X+J7Q
         6+8iptAh59hM8vQPZ0bMwVUAynCPYneO4AHVEJn/KfgwB061O8Ar82Zi3rWQP5lHbcRy
         2izwemRGLl1OOqkQaZXiVrOR+gOQn9wtdxp8B/koNpbUXXiTAeowt7rSJjQcWLlmVuhx
         w0TpzvqFwR/DTRQ71RmAqDV5KIZdGjdvAcSjamdIdZ8HrhwI12gdIGa4Cvx+y7gRWv02
         BdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777677321; x=1778282121;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l1FcgKCPtp8aMtVy2VuU03D6lZFtPAQ/96elesR+jbo=;
        b=sSmYp/+DOdlClxl7xwUSOdsAxSQbDGbpidibz6xTlrz72/yDIDLZ6Zqwxs8/6z9gis
         ZcpldrPg6wWUeN4lgClGxrH6kyLpDLaQRvoWQUeaYhxwHP3LTwyCRxrOLQhbyXxksNfD
         j4SiiI/gbEkKmk6XR3ZnSt7B0DWsnLKG3/2By51X/NVKfCN1ve/fIN7quEk1dTBwi1pu
         +hWD4GSFtgOqCeRSOuF3HxE9XyVVu8OTn/iY+23KjMflTjh6CzRgJU6HgaZWddZ+lXyW
         bj2nl/SPeWQvzaRVv2raNf7j90+MR7VcMFTla28v6xa15UXiQ4G5P5Kr3jhpJuaiPtHP
         Zgsw==
X-Gm-Message-State: AOJu0YzOspNv0m3+P+G0LnshW/5FojaKE5bgobarm2GGqnB4EnAdZdJT
	CobLo91xbCE8Ee81XlboxOXhgkLrgVDi77r5GCVem0i4lydPx+CFKH7RepQM4Ugt
X-Gm-Gg: AeBDies1oCU/H8K2uBdeGuGlTOzbHnbL8LnfEdytAmUhu0j3ZU7ggcZnR4CtD6Jo/PA
	hBOG9gXhiLvaKUFVnfNc/k356iIWweiWFzxEq2639zUkuJCerfTgRnR5NNUEQ6bpzuNTxh17Vq5
	9SUkqTCDipF8ViCGKf7JhmZuNT9JIi7Wjce8BAZ3f8Z6LFv9BWEKFMxbI3Wkgxfn6fYmTFz5qRz
	VTmDc8mYbJGPpAxTdz5cY82Al28CW7itB5noadTyd8QpdlWv46Kt6Qf90uQm+J/+QkSQyI/6v0K
	UY0achMRFGESGIgXV6tLmrmKDwT4BqOs1A2zFQooh3vyJjDrejrAQ5c8IexazmsCN4ExfJGqdQY
	5bUxEkMBlwZq73iyObFJEDAAj0cNaZS28v2dX4a/hb7AVe3sjmJj8dB2eX8atJHe5chue1AjHi0
	lU3hsNQ9S/kO5dabydTkKfIGcpEHqgUlAR9omRx4E=
X-Received: by 2002:a05:7022:4189:b0:12c:91ef:6e63 with SMTP id a92af1059eb24-12dec6108a2mr3559886c88.7.1777677321044;
        Fri, 01 May 2026 16:15:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.231.147])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df82a141asm5997928c88.8.2026.05.01.16.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:15:20 -0700 (PDT)
Message-Id: <89932a70f3ace6ff1198628873df702f40f1442a.1777677310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
	<pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 May 2026 23:15:07 +0000
Subject: [PATCH v2 5/8] urlmatch: define url_parse function
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Define url_parse, a general parsing function that supports all Git URLs
including scp style URLs such as hostname:~user/repo.

It is adapted from the algorithm in connect.c's parse_connect_url
and reuses the shared enum url_scheme and url_get_scheme function
that previous commits made available in url.h. The new parser and
the connect path agree on scheme classification. url_parse has the
same interface as url_normalize and uses the same data structures.

Both functions accept the same URL forms with one deliberate
exception. Bare local paths such as "/abs/path", "./rel"
or "repo" are accepted by parse_connect_url as URL_SCHEME_LOCAL,
but rejected by url_parse because url_normalize requires a URL
with a scheme://host form. A consumer that wants to handle both
URLs and local paths needs to dispatch on url_is_local_not_ssh
before calling url_parse, just as the connect path does internally.

The duplication with parse_connect_url is intentional.
The two functions have different contracts:

  - parse_connect_url

    Calls die() on an unknown scheme
    and returns NUL-terminated host/path
    strings for the connect path

  - url_parse

    Returns NULL on failure while populating
    out_info->err, and exposes components
    as offset/length pairs into the normalized
    URL buffer, matching url_normalize.

Reconciling both is possible, but not in the scope
of the current patch set.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 t/unit-tests/u-urlmatch-normalization.c |  45 +++++++++
 urlmatch.c                              | 127 ++++++++++++++++++++++++
 urlmatch.h                              |   1 +
 3 files changed, 173 insertions(+)

diff --git a/t/unit-tests/u-urlmatch-normalization.c b/t/unit-tests/u-urlmatch-normalization.c
index 39f6e1ba26..3595d893a2 100644
--- a/t/unit-tests/u-urlmatch-normalization.c
+++ b/t/unit-tests/u-urlmatch-normalization.c
@@ -245,3 +245,48 @@ void test_urlmatch_normalization__equivalents(void)
 	compare_normalized_urls("https://@x.y/^/../abc", "httpS://@x.y:0443/abc", 1);
 	compare_normalized_urls("https://@x.y/^/..", "httpS://@x.y:0443/", 1);
 }
+
+static void check_parsed_path(const char *url, const char *expected_path)
+{
+	struct url_info info;
+	char *parsed = url_parse(url, &info);
+	char *path;
+
+	cl_assert(parsed != NULL);
+	path = xstrndup(parsed + info.path_off, info.path_len);
+	cl_assert_equal_s(path, expected_path);
+	free(path);
+	free(parsed);
+}
+
+void test_urlmatch_normalization__parse_scp(void)
+{
+	check_parsed_path("host:path", "/path");
+	check_parsed_path("user@host:path", "/path");
+	check_parsed_path("host:~user/repo", "~user/repo");
+	check_parsed_path("user@host:~user/repo", "~user/repo");
+	check_parsed_path("[host]:src", "/src");
+	check_parsed_path("[host:123]:src", "/src");
+	check_parsed_path("[::1]:repo", "/repo");
+	check_parsed_path("user@[::1]:repo", "/repo");
+}
+
+void test_urlmatch_normalization__parse_url_form(void)
+{
+	check_parsed_path("ssh://host/repo", "/repo");
+	check_parsed_path("ssh://host/~user/repo", "~user/repo");
+	check_parsed_path("git://host:9418/repo", "/repo");
+	check_parsed_path("git://host/~user/repo", "~user/repo");
+	check_parsed_path("ssh://[::1]:1234/repo", "/repo");
+	check_parsed_path("http://[2001:db8::1]/repo", "/repo");
+}
+
+void test_urlmatch_normalization__parse_strips_query_and_fragment(void)
+{
+	check_parsed_path("ssh://host/~user/repo?q", "~user/repo");
+	check_parsed_path("ssh://host/~user/repo#frag", "~user/repo");
+	check_parsed_path("git://host/~user/repo?q", "~user/repo");
+	check_parsed_path("user@host:~user/repo?q", "~user/repo");
+	check_parsed_path("https://host/repo?q", "/repo");
+	check_parsed_path("https://host/repo#frag", "/repo");
+}
diff --git a/urlmatch.c b/urlmatch.c
index eea8300489..bf8cce6de9 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -5,6 +5,7 @@
 #include "hex-ll.h"
 #include "strbuf.h"
 #include "urlmatch.h"
+#include "url.h"
 
 #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
 #define URL_DIGIT "0123456789"
@@ -440,6 +441,132 @@ char *url_normalize(const char *url, struct url_info *out_info)
 	return url_normalize_1(url, out_info, 0);
 }
 
+char *url_parse(const char *url_orig, struct url_info *out_info)
+{
+	struct strbuf url;
+	char *host, *separator;
+	char *detached, *normalized;
+	char *url_decoded;
+	enum url_scheme scheme = URL_SCHEME_LOCAL;
+	struct url_info local_info;
+	struct url_info *info = out_info ? out_info : &local_info;
+	bool scp_syntax = false;
+
+	if (is_url(url_orig))
+		url_decoded = url_decode(url_orig);
+	else
+		url_decoded = xstrdup(url_orig);
+
+	strbuf_init(&url, strlen(url_decoded) + sizeof("ssh://"));
+	strbuf_addstr(&url, url_decoded);
+	free(url_decoded);
+
+	host = strstr(url.buf, "://");
+	if (host) {
+		/*
+		 * Temporarily NUL-terminate the scheme name
+		 * so we can pass it to url_get_scheme(),
+		 * then restore the ':' so the buffer
+		 * is intact for url_normalize() below.
+		 */
+		char saved = *host;
+		*host = '\0';
+		scheme = url_get_scheme(url.buf);
+		*host = saved;
+		host += 3;
+	} else {
+		if (!url_is_local_not_ssh(url.buf)) {
+			scp_syntax = true;
+			scheme = URL_SCHEME_SSH;
+			strbuf_insertstr(&url, 0, "ssh://");
+			host = url.buf + strlen("ssh://");
+		}
+	}
+
+	/*
+	 * Path starts after ':' in scp style SSH URLs.
+	 *
+	 * The host portion can begin with an optional "user@",
+	 * and the host itself can be wrapped in '[' ']' brackets.
+	 * The bracket form is git's legacy way of supporting:
+	 *
+	 *   - IPv6 literals: [::1]:repo
+	 *   - host:port pairs in the short form: [myhost:123]:src
+	 *   - Plain hostnames that happen to need bracketing: [host]:path
+	 *
+	 * Treat '[' followed by 0 or 1 inner colons as the host:port
+	 * or plain hostname form and strip the brackets so url_normalize
+	 * sees host[:port] natively. Two or more inner colons mark an
+	 * IPv6 literal: keep the brackets for url_normalize to recognize.
+	 *
+	 * The scp path separator is the ':' that follows the host part,
+	 * and we must skip over user@ and any '[...]' before searching.
+	 */
+	if (scp_syntax) {
+		char *user_at;
+		char *host_start;
+		char *bracket_end;
+
+		user_at = strchr(host, '@');
+		host_start = user_at ? user_at + 1 : host;
+
+		if (*host_start == '[') {
+			char *p;
+			int inner_colons;
+
+			bracket_end = strchr(host_start, ']');
+			inner_colons = 0;
+			for (p = host_start + 1; bracket_end && p < bracket_end; p++)
+				if (*p == ':')
+					inner_colons++;
+
+			if (bracket_end && inner_colons <= 1) {
+				size_t close_off = bracket_end - url.buf;
+				size_t open_off = host_start - url.buf;
+				strbuf_remove(&url, close_off, 1);
+				strbuf_remove(&url, open_off, 1);
+				separator = url.buf + close_off - 1;
+			} else if (bracket_end) {
+				separator = strchr(bracket_end + 1, ':');
+			} else {
+				separator = strchr(host_start, ':');
+			}
+		} else {
+			separator = strchr(host_start, ':');
+		}
+
+		if (separator) {
+			if (separator[1] == '/')
+				strbuf_remove(&url, separator - url.buf, 1);
+			else
+				*separator = '/';
+		}
+	}
+
+	detached = strbuf_detach(&url, NULL);
+	normalized = url_normalize(detached, info);
+	free(detached);
+
+	if (!normalized)
+		return NULL;
+
+	/*
+	 * Point path to ~ for URLs like this:
+	 *
+	 *     ssh://host.xz/~user/repo
+	 *     git://host.xz/~user/repo
+	 *     host.xz:~user/repo
+	 */
+	if (scheme == URL_SCHEME_GIT || scheme == URL_SCHEME_SSH) {
+		if (normalized[info->path_off + 1] == '~') {
+			info->path_off++;
+			info->path_len--;
+		}
+	}
+
+	return normalized;
+}
+
 static size_t url_match_prefix(const char *url,
 			       const char *url_prefix,
 			       size_t url_prefix_len)
diff --git a/urlmatch.h b/urlmatch.h
index 5ba85cea13..6b3ce42858 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -35,6 +35,7 @@ struct url_info {
 };
 
 char *url_normalize(const char *, struct url_info *);
+char *url_parse(const char *, struct url_info *);
 
 struct urlmatch_item {
 	size_t hostmatch_len;
-- 
gitgitgadget

