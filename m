Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90D371877
	for <git@vger.kernel.org>; Fri,  1 May 2026 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677317; cv=none; b=IunjQWeF/sEOWCf057jKBPbEG2hJcJhbTU2r5Px8mMB+pq9s13UTchTuBvwOkg3HhXZCONIh0IwBnQnVj8k9/8KXxPHuhXKcFrTt2cu1hTY7D6GlVrR/by9X48pev25zeIL6cxA7wHy/eZPZsEgFaLPjS2+JbAjzvqTY2lIiPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677317; c=relaxed/simple;
	bh=mN+3u0CyV9pPhYtTYXom6nsgDWhYyMDuJ13uLW4diGw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=c/BRMcCVQn3aZGGKdvarawM9/LGdZc+QELlxP2bM7LKEtDjIrNMqlPpEGI1DkXz2YWGfRTxlyB3E6j/Jt2BvUwSOgK+UNNXHbobQNuT+xO3WnTjhzjixC2F6RGwCN82zYP4WCTtahfyPH/PVcji2IspCAvOER1TLgIqFCmcMfSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0q/z3wF; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0q/z3wF"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2d868d014a5so2495222eec.1
        for <git@vger.kernel.org>; Fri, 01 May 2026 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777677313; x=1778282113; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RS3dyEVDqYPN6KCcl99Vw2LStnhDu9VX7PJ2sgRvk8U=;
        b=H0q/z3wFaQ7szu716T+LPygS3U9vYVF69boDIPIP2pJJgRHplmV0thhivnZpK+XBhh
         4LsOqb+4Yn4c5zQCzFc46MWTjuMsXPsxBJK6DY+bDKGPHhg5rJR1/PCqqBhLBwVDPaef
         NMFf6ektc2+Dv6KrwsyHHwt7dbgGTUCtRIgoXAhGdhk5fcgvP4UF12y82VLPlGK0zibw
         Sbu/oJZgszv10KlM5aI1OJqBkb/sScfjzJEUMdkUOWkPNHKqlAcDLh/PQ6X3ronYPKXF
         x3UZIV4U8FfVlfjKkcll8QcZ5vTC/xQAv8wZxIFz1+5Ev/G/UjzieSnB/IdXeLLtmYST
         XYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777677313; x=1778282113;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RS3dyEVDqYPN6KCcl99Vw2LStnhDu9VX7PJ2sgRvk8U=;
        b=Ih5wXaHvPot2fWXZpTffvre2NWuQL8QU9WXqNveJTySZQUF3aC7np/BGqavADmegUo
         r5q0p4iVlaWvHfDvQFvgrbHWUgq/XwJKSQ9eYB9nNSkVite3iLqa10I8KAMiGes/y/1e
         nE/GWwOxgMN4Hq3ve89vGp2f0oxE13SxvHYC03Yfi67FJRSpZZSmHUyHSwkdkc5cxrzD
         LLc3tN+hHknZzYh1b0SwgP6oe2pHHtMUk9LDGR4A/cTX++oOXlt4smsul7bb3Y3lmza5
         Ebuk6k+jov1cefXsyBtL4LxAD/QiJUFCd+9TD3pdUQrSlyNyca3kF4w12dZYAdAaWzfx
         4zxw==
X-Gm-Message-State: AOJu0YwDOLEjdmk+ok7tWAhXvNkVGFJq2MLairmGUE2Pstticr+FScf+
	F7eLKMcU+qWzhrUwC5D2TVHdX9m5nq2dm19T9sF+g/OP8a6wRbaGg8J2KYEzeg==
X-Gm-Gg: AeBDiesOuPi4mOPiz3Zi3IsOujVlaVMUGSMe9xW5tGxxV61Do146zadwPsscl0iTej1
	5RW5brmDFFY9f+tuF/0x1qEOr96Hj4o3cFUJo2Gi+0/+yHYbjWYdtWNW7u3cNEN0UnLhc2b4uR5
	+kOylxJN3CtHk4FpW8iPPWxAkFjooqNajIMKTwKFvS5i4DCa4KHpY/GvutBmxGSPoHGmj4N/u1K
	+6vHhwmtC3msZgWj9I3Q5wsX8BrIJcVDk8Lha9gNqQ6xDyjw2snG17Qxs+VgOe9Zz/hKnEnlrWD
	Qsmmd/w5AmWbe/IIah5ieVar5bjA53uU7qypxgrEdj9iUR8Hzo4IMel4Skvsrz94HdSu3Qokjk/
	QMOFdE9Zp33nPhq3MjLNcbzVXG2qOCG/DMUP9G3qIVqiJdLNGXegO+3FxUAJS9dObLwbqWqeXG4
	WKuOSDVD5rmqzBnnyDuQwQlzr68bk8JFY1C/BqiNs=
X-Received: by 2002:a05:7300:550:b0:2dd:5641:f01 with SMTP id 5a478bee46e88-2efba3aa1e9mr706114eec.28.1777677312603;
        Fri, 01 May 2026 16:15:12 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.231.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b11fsm6167412eec.19.2026.05.01.16.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:15:11 -0700 (PDT)
Message-Id: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 May 2026 23:15:02 +0000
Subject: [PATCH v2 0/8] builtin: implement, document and test url-parse
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>

This series adds git url-parse, a plumbing builtin for inspecting git URLs.
Git accepts a wider variety of URL forms than any standard parser handles.
The supported forms include RFC URLs, file:// URLs, scp-style
[user@]host:path for SSH, and IPv6 in brackets. Tools wanting to reason
about them have historically had to reimplement git's parsing or shell out
indirectly. With git url-parse, scripts can ask git directly: validate a
URL, extract a component (scheme, user, host, port, path, password), or
both.

The series consists of eight commits.

The first four are preparatory. They rename enum protocol to enum url_scheme
for RFC alignment, move url_is_local_not_ssh and the scheme-detection
routines from connect.c to url.h/url.c, and stop url_get_scheme from dying
on unknown schemes so other parsers can handle unknowns gracefully.

The fifth commit defines the new parser, url_parse, in urlmatch.c. It is
adapted from parse_connect_url and uses the same data structures as
url_normalize. The parser returns NULL on failure with err populated, and
exposes URL components as offset/length pairs into the normalized URL
buffer.

The sixth commit adds the user-facing command, with a helpful error when the
input looks like a local path rather than a URL.

The last two commits are documentation (a manpage) and 53 tests covering URL
form, scp form, IPv6 in URL and scp forms, bracket forms, username
expansion, query/fragment stripping, the local-path error, and
validation-only mode.

Several choices in this series are judgment calls. Happy to amend or follow
up on any of them.

The component name is scheme, not protocol. RFC 1738/3986 calls them
schemes. The series renames enum protocol to enum url_scheme internally, and
the user-facing component name follows the same direction. I considered
accepting both as aliases but decided against the precedent for a new
command. If you would rather see protocol, or both protocol and scheme, that
is easy to change.

Local paths are deliberately not URLs. parse_connect_url accepts bare paths
like /abs/path or ./rel as URL_SCHEME_LOCAL. url_parse rejects them, since
url_normalize requires a scheme://host form, and silent conversion to
file:// has no good answer for relative or tilde forms. The builtin emits a
helpful error suggesting the explicit file:// form. If full git clone parity
is preferred (bare paths accepted via auto-conversion or a new flag), that
could be added.

Absent and empty components are conflated in output. --component user
http://host/ and --component user http://@host/ both produce empty lines.
The underlying struct url_info preserves the distinction: *_off == 0 vs
*_off != 0 with *_len == 0. A future option can expose it without breaking
change. Can amend this patch set if necessary.

Changes since v1:

 * Bug fix: ~user paths with a query string or fragment were leaking the ?
   or # into the path output. The ~user-skip logic in url_parse previously
   ran only for file://. It now runs for git/ssh/scp URLs as well, matching
   what parse_connect_url does and what users expect.

 * Helpful error for local paths instead of the cryptic "invalid URL scheme
   name or missing '://' suffix".

 * -c protocol renamed to -c scheme for consistency with the internal rename
   and the RFC.

 * Documented the deliberate divergence from parse_connect_url (local paths
   and unknown schemes) in the urlmatch commit message.

 * Doc and command-list polish: purehelpers category, asciidoc placeholder
   convention, [synopsis] form.

 * Original micro commit style staged buildup of the builtin collapsed to a
   single self-contained commit. The rest of the series is unchanged in
   shape.

Matheus Afonso Martins Moreira (8):
  connect: rename enum protocol to url_scheme
  url: move url_is_local_not_ssh to url.h
  url: move scheme detection to URL header/source
  url: return URL_SCHEME_UNKNOWN instead of dying
  urlmatch: define url_parse function
  builtin: create url-parse command
  doc: describe the url-parse builtin
  t9904: add tests for the new url-parse builtin

 .gitignore                              |   1 +
 Documentation/git-url-parse.adoc        |  80 ++++++
 Documentation/meson.build               |   1 +
 Makefile                                |   1 +
 builtin.h                               |   1 +
 builtin/url-parse.c                     | 132 ++++++++++
 command-list.txt                        |   1 +
 connect.c                               |  78 ++----
 connect.h                               |   1 -
 git.c                                   |   1 +
 meson.build                             |   1 +
 remote.c                                |   1 +
 t/meson.build                           |   1 +
 t/t9904-url-parse.sh                    | 319 ++++++++++++++++++++++++
 t/unit-tests/u-urlmatch-normalization.c |  45 ++++
 url.c                                   |  23 ++
 url.h                                   |  16 ++
 urlmatch.c                              | 127 ++++++++++
 urlmatch.h                              |   1 +
 19 files changed, 777 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/git-url-parse.adoc
 create mode 100644 builtin/url-parse.c
 create mode 100755 t/t9904-url-parse.sh


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1715%2Fmatheusmoreira%2Furl-parse-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1715/matheusmoreira/url-parse-v2
Pull-Request: https://github.com/git/git/pull/1715

Range-diff vs v1:

  -:  ---------- >  1:  38f797362d connect: rename enum protocol to url_scheme
  1:  42eb0cbf68 !  2:  a4153e1d24 url: move helper function to URL header and source
     @@ Metadata
      Author: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
      
       ## Commit message ##
     -    url: move helper function to URL header and source
     +    url: move url_is_local_not_ssh to url.h
      
     -    It will be used in more places so it should be placed in url.h.
     +    Move url_is_local_not_ssh from connect.c/connect.h
     +    to url.c/url.h so that the new url_parse function
     +    in urlmatch.c, and any future code that needs to
     +    distinguish a local path from an scp style SSH URL,
     +    can reuse the heuristic without depending on connect.c.
     +
     +    No behavior change.
      
          Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
      
       ## connect.c ##
     -@@ connect.c: enum protocol {
     - 	PROTO_GIT
     +@@ connect.c: enum url_scheme {
     + 	URL_SCHEME_GIT
       };
       
      -int url_is_local_not_ssh(const char *url)
     @@ connect.c: enum protocol {
      -		(has_dos_drive_prefix(url) && is_valid_path(url));
      -}
      -
     - static const char *prot_name(enum protocol protocol)
     + static const char *url_scheme_name(enum url_scheme scheme)
       {
     - 	switch (protocol) {
     + 	switch (scheme) {
      
       ## connect.h ##
      @@ connect.h: int git_connection_is_socket(struct child_process *conn);
     @@ url.h: char *url_decode_parameter_value(const char **query);
       
      +int url_is_local_not_ssh(const char *url);
      +
     - #endif /* URL_H */
     + /*
     +  * The set of unreserved characters as per STD66 (RFC3986) is
     +  * '[A-Za-z0-9-._~]'. These characters are safe to appear in URI
  -:  ---------- >  3:  e584fb03f3 url: move scheme detection to URL header/source
  -:  ---------- >  4:  7381704c38 url: return URL_SCHEME_UNKNOWN instead of dying
  2:  13b81b8aa0 !  5:  89932a70f3 urlmatch: define url_parse function
     @@ Metadata
       ## Commit message ##
          urlmatch: define url_parse function
      
     -    Define general parsing function that supports all Git URLs
     +    Define url_parse, a general parsing function that supports all Git URLs
          including scp style URLs such as hostname:~user/repo.
     -    Has the same interface as the URL normalization function
     -    and uses the same data structures, facilitating its use.
     -    It's adapted from the algorithm used to process URLs in connect.c,
     -    so it should support the same inputs.
     +
     +    It is adapted from the algorithm in connect.c's parse_connect_url
     +    and reuses the shared enum url_scheme and url_get_scheme function
     +    that previous commits made available in url.h. The new parser and
     +    the connect path agree on scheme classification. url_parse has the
     +    same interface as url_normalize and uses the same data structures.
     +
     +    Both functions accept the same URL forms with one deliberate
     +    exception. Bare local paths such as "/abs/path", "./rel"
     +    or "repo" are accepted by parse_connect_url as URL_SCHEME_LOCAL,
     +    but rejected by url_parse because url_normalize requires a URL
     +    with a scheme://host form. A consumer that wants to handle both
     +    URLs and local paths needs to dispatch on url_is_local_not_ssh
     +    before calling url_parse, just as the connect path does internally.
     +
     +    The duplication with parse_connect_url is intentional.
     +    The two functions have different contracts:
     +
     +      - parse_connect_url
     +
     +        Calls die() on an unknown scheme
     +        and returns NUL-terminated host/path
     +        strings for the connect path
     +
     +      - url_parse
     +
     +        Returns NULL on failure while populating
     +        out_info->err, and exposes components
     +        as offset/length pairs into the normalized
     +        URL buffer, matching url_normalize.
     +
     +    Reconciling both is possible, but not in the scope
     +    of the current patch set.
      
          Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
      
     + ## t/unit-tests/u-urlmatch-normalization.c ##
     +@@ t/unit-tests/u-urlmatch-normalization.c: void test_urlmatch_normalization__equivalents(void)
     + 	compare_normalized_urls("https://@x.y/^/../abc", "httpS://@x.y:0443/abc", 1);
     + 	compare_normalized_urls("https://@x.y/^/..", "httpS://@x.y:0443/", 1);
     + }
     ++
     ++static void check_parsed_path(const char *url, const char *expected_path)
     ++{
     ++	struct url_info info;
     ++	char *parsed = url_parse(url, &info);
     ++	char *path;
     ++
     ++	cl_assert(parsed != NULL);
     ++	path = xstrndup(parsed + info.path_off, info.path_len);
     ++	cl_assert_equal_s(path, expected_path);
     ++	free(path);
     ++	free(parsed);
     ++}
     ++
     ++void test_urlmatch_normalization__parse_scp(void)
     ++{
     ++	check_parsed_path("host:path", "/path");
     ++	check_parsed_path("user@host:path", "/path");
     ++	check_parsed_path("host:~user/repo", "~user/repo");
     ++	check_parsed_path("user@host:~user/repo", "~user/repo");
     ++	check_parsed_path("[host]:src", "/src");
     ++	check_parsed_path("[host:123]:src", "/src");
     ++	check_parsed_path("[::1]:repo", "/repo");
     ++	check_parsed_path("user@[::1]:repo", "/repo");
     ++}
     ++
     ++void test_urlmatch_normalization__parse_url_form(void)
     ++{
     ++	check_parsed_path("ssh://host/repo", "/repo");
     ++	check_parsed_path("ssh://host/~user/repo", "~user/repo");
     ++	check_parsed_path("git://host:9418/repo", "/repo");
     ++	check_parsed_path("git://host/~user/repo", "~user/repo");
     ++	check_parsed_path("ssh://[::1]:1234/repo", "/repo");
     ++	check_parsed_path("http://[2001:db8::1]/repo", "/repo");
     ++}
     ++
     ++void test_urlmatch_normalization__parse_strips_query_and_fragment(void)
     ++{
     ++	check_parsed_path("ssh://host/~user/repo?q", "~user/repo");
     ++	check_parsed_path("ssh://host/~user/repo#frag", "~user/repo");
     ++	check_parsed_path("git://host/~user/repo?q", "~user/repo");
     ++	check_parsed_path("user@host:~user/repo?q", "~user/repo");
     ++	check_parsed_path("https://host/repo?q", "/repo");
     ++	check_parsed_path("https://host/repo#frag", "/repo");
     ++}
     +
       ## urlmatch.c ##
      @@
       #include "hex-ll.h"
     @@ urlmatch.c: char *url_normalize(const char *url, struct url_info *out_info)
       	return url_normalize_1(url, out_info, 0);
       }
       
     -+enum protocol {
     -+	PROTO_UNKNOWN = 0,
     -+	PROTO_LOCAL,
     -+	PROTO_FILE,
     -+	PROTO_SSH,
     -+	PROTO_GIT,
     -+};
     -+
     -+static enum protocol url_get_protocol(const char *name, size_t n)
     -+{
     -+	if (!strncmp(name, "ssh", n))
     -+		return PROTO_SSH;
     -+	if (!strncmp(name, "git", n))
     -+		return PROTO_GIT;
     -+	if (!strncmp(name, "git+ssh", n)) /* deprecated - do not use */
     -+		return PROTO_SSH;
     -+	if (!strncmp(name, "ssh+git", n)) /* deprecated - do not use */
     -+		return PROTO_SSH;
     -+	if (!strncmp(name, "file", n))
     -+		return PROTO_FILE;
     -+	return PROTO_UNKNOWN;
     -+}
     -+
      +char *url_parse(const char *url_orig, struct url_info *out_info)
      +{
      +	struct strbuf url;
      +	char *host, *separator;
      +	char *detached, *normalized;
     -+	enum protocol protocol = PROTO_LOCAL;
     ++	char *url_decoded;
     ++	enum url_scheme scheme = URL_SCHEME_LOCAL;
      +	struct url_info local_info;
     -+	struct url_info *info = out_info? out_info : &local_info;
     ++	struct url_info *info = out_info ? out_info : &local_info;
      +	bool scp_syntax = false;
      +
     -+	if (is_url(url_orig)) {
     -+		url_orig = url_decode(url_orig);
     -+	} else {
     -+		url_orig = xstrdup(url_orig);
     -+	}
     ++	if (is_url(url_orig))
     ++		url_decoded = url_decode(url_orig);
     ++	else
     ++		url_decoded = xstrdup(url_orig);
      +
     -+	strbuf_init(&url, strlen(url_orig) + sizeof("ssh://"));
     -+	strbuf_addstr(&url, url_orig);
     ++	strbuf_init(&url, strlen(url_decoded) + sizeof("ssh://"));
     ++	strbuf_addstr(&url, url_decoded);
     ++	free(url_decoded);
      +
      +	host = strstr(url.buf, "://");
      +	if (host) {
     -+		protocol = url_get_protocol(url.buf, host - url.buf);
     ++		/*
     ++		 * Temporarily NUL-terminate the scheme name
     ++		 * so we can pass it to url_get_scheme(),
     ++		 * then restore the ':' so the buffer
     ++		 * is intact for url_normalize() below.
     ++		 */
     ++		char saved = *host;
     ++		*host = '\0';
     ++		scheme = url_get_scheme(url.buf);
     ++		*host = saved;
      +		host += 3;
      +	} else {
      +		if (!url_is_local_not_ssh(url.buf)) {
      +			scp_syntax = true;
     -+			protocol = PROTO_SSH;
     ++			scheme = URL_SCHEME_SSH;
      +			strbuf_insertstr(&url, 0, "ssh://");
     -+			host = url.buf + 6;
     ++			host = url.buf + strlen("ssh://");
      +		}
      +	}
      +
     -+	/* path starts after ':' in scp style SSH URLs */
     ++	/*
     ++	 * Path starts after ':' in scp style SSH URLs.
     ++	 *
     ++	 * The host portion can begin with an optional "user@",
     ++	 * and the host itself can be wrapped in '[' ']' brackets.
     ++	 * The bracket form is git's legacy way of supporting:
     ++	 *
     ++	 *   - IPv6 literals: [::1]:repo
     ++	 *   - host:port pairs in the short form: [myhost:123]:src
     ++	 *   - Plain hostnames that happen to need bracketing: [host]:path
     ++	 *
     ++	 * Treat '[' followed by 0 or 1 inner colons as the host:port
     ++	 * or plain hostname form and strip the brackets so url_normalize
     ++	 * sees host[:port] natively. Two or more inner colons mark an
     ++	 * IPv6 literal: keep the brackets for url_normalize to recognize.
     ++	 *
     ++	 * The scp path separator is the ':' that follows the host part,
     ++	 * and we must skip over user@ and any '[...]' before searching.
     ++	 */
      +	if (scp_syntax) {
     -+		separator = strchr(host, ':');
     ++		char *user_at;
     ++		char *host_start;
     ++		char *bracket_end;
     ++
     ++		user_at = strchr(host, '@');
     ++		host_start = user_at ? user_at + 1 : host;
     ++
     ++		if (*host_start == '[') {
     ++			char *p;
     ++			int inner_colons;
     ++
     ++			bracket_end = strchr(host_start, ']');
     ++			inner_colons = 0;
     ++			for (p = host_start + 1; bracket_end && p < bracket_end; p++)
     ++				if (*p == ':')
     ++					inner_colons++;
     ++
     ++			if (bracket_end && inner_colons <= 1) {
     ++				size_t close_off = bracket_end - url.buf;
     ++				size_t open_off = host_start - url.buf;
     ++				strbuf_remove(&url, close_off, 1);
     ++				strbuf_remove(&url, open_off, 1);
     ++				separator = url.buf + close_off - 1;
     ++			} else if (bracket_end) {
     ++				separator = strchr(bracket_end + 1, ':');
     ++			} else {
     ++				separator = strchr(host_start, ':');
     ++			}
     ++		} else {
     ++			separator = strchr(host_start, ':');
     ++		}
     ++
      +		if (separator) {
      +			if (separator[1] == '/')
      +				strbuf_remove(&url, separator - url.buf, 1);
     @@ urlmatch.c: char *url_normalize(const char *url, struct url_info *out_info)
      +	normalized = url_normalize(detached, info);
      +	free(detached);
      +
     -+	if (!normalized) {
     ++	if (!normalized)
      +		return NULL;
     -+	}
      +
     -+	/* point path to ~ for URL's like this:
     ++	/*
     ++	 * Point path to ~ for URLs like this:
      +	 *
      +	 *     ssh://host.xz/~user/repo
      +	 *     git://host.xz/~user/repo
      +	 *     host.xz:~user/repo
     -+	 *
      +	 */
     -+	if (protocol == PROTO_GIT || protocol == PROTO_SSH) {
     -+		if (normalized[info->path_off + 1] == '~')
     ++	if (scheme == URL_SCHEME_GIT || scheme == URL_SCHEME_SSH) {
     ++		if (normalized[info->path_off + 1] == '~') {
      +			info->path_off++;
     ++			info->path_len--;
     ++		}
      +	}
      +
      +	return normalized;
  3:  e4781b36d5 !  6:  886a7d659e builtin: create url-parse command
     @@ Commit message
      
          The url-parse builtin command is designed to solve this problem
          by exposing git's native URL parsing facilities as a plumbing command.
     -    Other programs can then call upon git itself to parse the git URLs and
     -    extract their components. This should be quite useful for scripts.
     +    Other programs can then call upon git itself to parse the git URLs
     +    and extract their components. This should be quite useful for scripts.
      
          Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
      
     @@ Makefile: BUILTIN_OBJS += builtin/update-ref.o
       BUILTIN_OBJS += builtin/verify-pack.o
      
       ## builtin.h ##
     -@@ builtin.h: int cmd_update_server_info(int argc, const char **argv, const char *prefix);
     - int cmd_upload_archive(int argc, const char **argv, const char *prefix);
     - int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
     - int cmd_upload_pack(int argc, const char **argv, const char *prefix);
     -+int cmd_url_parse(int argc, const char **argv, const char *prefix);
     - int cmd_var(int argc, const char **argv, const char *prefix);
     - int cmd_verify_commit(int argc, const char **argv, const char *prefix);
     - int cmd_verify_tag(int argc, const char **argv, const char *prefix);
     +@@ builtin.h: int cmd_update_server_info(int argc, const char **argv, const char *prefix, stru
     + int cmd_upload_archive(int argc, const char **argv, const char *prefix, struct repository *repo);
     + int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix, struct repository *repo);
     + int cmd_upload_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
     ++int cmd_url_parse(int argc, const char **argv, const char *prefix, struct repository *repo);
     + int cmd_var(int argc, const char **argv, const char *prefix, struct repository *repo);
     + int cmd_verify_commit(int argc, const char **argv, const char *prefix, struct repository *repo);
     + int cmd_verify_tag(int argc, const char **argv, const char *prefix, struct repository *repo);
      
       ## builtin/url-parse.c (new) ##
      @@
     -+/* SPDX-License-Identifier: GPL-2.0-only
     -+ *
     -+ * url-parse - parses git URLs and extracts their components
     -+ *
     -+ * Copyright © 2024 Matheus Afonso Martins Moreira
     -+ *
     -+ * This program is free software; you can redistribute it and/or modify
     -+ * it under the terms of the GNU General Public License as published by
     -+ * the Free Software Foundation; version 2.
     -+ */
     -+
      +#include "builtin.h"
      +#include "gettext.h"
     ++#include "parse-options.h"
     ++#include "url.h"
     ++#include "urlmatch.h"
     ++
     ++static const char * const builtin_url_parse_usage[] = {
     ++	N_("git url-parse [-c <component>] [--] <url>..."),
     ++	NULL
     ++};
     ++
     ++static char *component_arg;
     ++
     ++static struct option builtin_url_parse_options[] = {
     ++	OPT_STRING('c', "component", &component_arg, N_("component"),
     ++		N_("which URL component to extract")),
     ++	OPT_END(),
     ++};
     ++
     ++enum url_component {
     ++	URL_NONE = 0,
     ++	URL_SCHEME,
     ++	URL_USER,
     ++	URL_PASSWORD,
     ++	URL_HOST,
     ++	URL_PORT,
     ++	URL_PATH,
     ++};
     ++
     ++static void parse_or_die(const char *url, struct url_info *info)
     ++{
     ++	if (url_is_local_not_ssh(url)) {
     ++		if (*url == '/')
     ++			die("'%s' is not a URL; if you meant a local "
     ++			    "repository, use 'file://%s'", url, url);
     ++		die("'%s' is not a URL; if you meant a local repository, "
     ++		    "use a 'file://' URL with an absolute path", url);
     ++	}
     ++	if (!url_parse(url, info))
     ++		die("invalid git URL '%s': %s", url, info->err);
     ++}
     ++
     ++static enum url_component get_component_or_die(const char *arg)
     ++{
     ++	if (!strcmp("path", arg))
     ++		return URL_PATH;
     ++	if (!strcmp("host", arg))
     ++		return URL_HOST;
     ++	if (!strcmp("scheme", arg))
     ++		return URL_SCHEME;
     ++	if (!strcmp("user", arg))
     ++		return URL_USER;
     ++	if (!strcmp("password", arg))
     ++		return URL_PASSWORD;
     ++	if (!strcmp("port", arg))
     ++		return URL_PORT;
     ++	die("invalid git URL component '%s'", arg);
     ++}
     ++
     ++static char *extract_component(enum url_component component,
     ++			       struct url_info *info)
     ++{
     ++	size_t offset, length;
     ++
     ++	switch (component) {
     ++	case URL_SCHEME:
     ++		offset = 0;
     ++		length = info->scheme_len;
     ++		break;
     ++	case URL_USER:
     ++		offset = info->user_off;
     ++		length = info->user_len;
     ++		break;
     ++	case URL_PASSWORD:
     ++		offset = info->passwd_off;
     ++		length = info->passwd_len;
     ++		break;
     ++	case URL_HOST:
     ++		offset = info->host_off;
     ++		length = info->host_len;
     ++		break;
     ++	case URL_PORT:
     ++		offset = info->port_off;
     ++		length = info->port_len;
     ++		break;
     ++	case URL_PATH:
     ++		offset = info->path_off;
     ++		length = info->path_len;
     ++		break;
     ++	case URL_NONE:
     ++		return NULL;
     ++	}
     ++
     ++	return xstrndup(info->url + offset, length);
     ++}
      +
     -+int cmd_url_parse(int argc, const char **argv, const char *prefix)
     ++int cmd_url_parse(int argc,
     ++		  const char **argv,
     ++		  const char *prefix,
     ++		  struct repository *repo UNUSED)
      +{
     ++	struct url_info info;
     ++	enum url_component selected = URL_NONE;
     ++	char *extracted;
     ++	int i;
     ++
     ++	argc = parse_options(argc, argv, prefix, builtin_url_parse_options,
     ++			     builtin_url_parse_usage, 0);
     ++
     ++	if (argc == 0)
     ++		usage_with_options(builtin_url_parse_usage,
     ++				   builtin_url_parse_options);
     ++
     ++	if (component_arg)
     ++		selected = get_component_or_die(component_arg);
     ++
     ++	for (i = 0; i < argc; i++) {
     ++		parse_or_die(argv[i], &info);
     ++
     ++		if (selected != URL_NONE) {
     ++			extracted = extract_component(selected, &info);
     ++			if (extracted) {
     ++				puts(extracted);
     ++				free(extracted);
     ++			}
     ++		}
     ++
     ++		free(info.url);
     ++	}
     ++
      +	return 0;
      +}
      
     @@ command-list.txt: git-update-ref                          plumbingmanipulators
       git-update-server-info                  synchingrepositories
       git-upload-archive                      synchelpers
       git-upload-pack                         synchelpers
     -+git-url-parse                           plumbinginterrogators
     ++git-url-parse                           purehelpers
       git-var                                 plumbinginterrogators
       git-verify-commit                       ancillaryinterrogators
       git-verify-pack                         plumbinginterrogators
     @@ git.c: static struct cmd_struct commands[] = {
       	{ "upload-archive", cmd_upload_archive, NO_PARSEOPT },
       	{ "upload-archive--writer", cmd_upload_archive_writer, NO_PARSEOPT },
       	{ "upload-pack", cmd_upload_pack },
     -+	{ "url-parse", cmd_url_parse, NO_PARSEOPT },
     ++	{ "url-parse", cmd_url_parse },
       	{ "var", cmd_var, RUN_SETUP_GENTLY | NO_PARSEOPT },
       	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
       	{ "verify-pack", cmd_verify_pack },
     +
     + ## meson.build ##
     +@@ meson.build: builtin_sources = [
     +   'builtin/update-server-info.c',
     +   'builtin/upload-archive.c',
     +   'builtin/upload-pack.c',
     ++  'builtin/url-parse.c',
     +   'builtin/var.c',
     +   'builtin/verify-commit.c',
     +   'builtin/verify-pack.c',
  4:  1e0895651c <  -:  ---------- url-parse: add URL parsing helper function
  5:  0bf83ee122 <  -:  ---------- url-parse: enumerate possible URL components
  6:  149c476b1e <  -:  ---------- url-parse: define component extraction helper fn
  7:  eb9ef8a17b <  -:  ---------- url-parse: define string to component converter fn
  8:  a2acfdbc76 <  -:  ---------- url-parse: define usage and options
  9:  5de00324fb <  -:  ---------- url-parse: parse options given on the command line
 10:  15d355a43c <  -:  ---------- url-parse: validate all given git URLs
 11:  4e93509c80 <  -:  ---------- url-parse: output URL components selected by user
 12:  abda074aee !  7:  3c44e0f478 Documentation: describe the url-parse builtin
     @@ Metadata
      Author: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
      
       ## Commit message ##
     -    Documentation: describe the url-parse builtin
     +    doc: describe the url-parse builtin
      
          The new url-parse builtin validates git URLs
          and optionally extracts their components.
      
     +    Helped-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
          Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
      
     - ## Documentation/git-url-parse.txt (new) ##
     + ## Documentation/git-url-parse.adoc (new) ##
      @@
      +git-url-parse(1)
      +================
     @@ Documentation/git-url-parse.txt (new)
      +
      +SYNOPSIS
      +--------
     -+[verse]
     -+'git url-parse' [<options>] [--] <url>...
     ++[synopsis]
     ++git url-parse [-c <component>] [--] <url>...
      +
      +DESCRIPTION
      +-----------
     @@ Documentation/git-url-parse.txt (new)
      +This command eases interoperability with git URLs by enabling the
      +parsing and extraction of the components of all git URLs.
      +
     ++Any syntactically valid URL is parsed, even if the scheme is not one
     ++git supports for fetching or pushing.
     ++
      +OPTIONS
      +-------
      +
     -+-c <arg>::
     -+--component <arg>::
     -+	Extract the `<arg>` component from the given git URLs.
     -+	`<arg>` can be one of:
     -+	`protocol`, `user`, `password`, `host`, `port`, `path`.
     ++`-c <component>`::
     ++`--component <component>`::
     ++	Extract the _<component>_ component from the given Git URLs.
     ++	_<component>_ can be one of:
     ++	`scheme`, `user`, `password`, `host`, `port`, `path`.
     ++
     ++OUTPUT
     ++------
     ++
     ++When `--component` is given, the requested component of each URL
     ++is printed on its own line, in the order the URLs were given. If
     ++the URL has no such component (for example, a port in a URL that
     ++does not specify one), an empty line is printed in its place.
     ++
     ++When `--component` is not given, no output is produced. The exit
     ++status is zero if every URL parses successfully and non-zero
     ++otherwise, allowing the command to be used purely as a validator.
      +
      +EXAMPLES
      +--------
     @@ Documentation/git-url-parse.txt (new)
      ++
      +------------
      +$ git url-parse --component path https://example.com/user/repo
     -+/usr/repo
     ++/user/repo
      +$ git url-parse --component path example.com:~user/repo
      +~user/repo
      +$ git url-parse --component path example.com:user/repo
     @@ Documentation/git-url-parse.txt (new)
      +$ git url-parse https://example.com/user/repo example.com:~user/repo
      +------------
      +
     ++SEE ALSO
     ++--------
     ++linkgit:git-clone[1],
     ++linkgit:git-fetch[1],
     ++linkgit:git-config[1]
     ++
      +GIT
      +---
      +Part of the linkgit:git[1] suite
     +
     + ## Documentation/meson.build ##
     +@@ Documentation/meson.build: manpages = {
     +   'git-update-server-info.adoc' : 1,
     +   'git-upload-archive.adoc' : 1,
     +   'git-upload-pack.adoc' : 1,
     ++  'git-url-parse.adoc' : 1,
     +   'git-var.adoc' : 1,
     +   'git-verify-commit.adoc' : 1,
     +   'git-verify-pack.adoc' : 1,
 13:  33e128496b !  8:  cf2ae409e6 tests: add tests for the new url-parse builtin
     @@ Metadata
      Author: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
      
       ## Commit message ##
     -    tests: add tests for the new url-parse builtin
     +    t9904: add tests for the new url-parse builtin
      
          Test git URL parsing, validation and component extraction
          on all documented git URL schemes and syntaxes.
      
     +    Add IPv6 host coverage in URL form:
     +
     +        ssh://[::1]/path
     +        ssh://user@[::1]:1234/path
     +        git://[::1]:9418/path
     +        http://[2001:db8::1]/path
     +        https://[2001:db8::1]/path
     +
     +    In URL form the brackets are kept in the host component (RFC 3986
     +    syntax for IPv6 literals).
     +
     +    Also exercise the bracketed scp short forms that t5601-clone.sh
     +    covers via parse_connect_url:
     +
     +        [host]:path
     +        [host:port]:path
     +        [::1]:repo
     +        user@[::1]:repo
     +        user@[host:port]:path
     +
     +    In scp form, brackets are kept for IPv6 literals (two or more inner
     +    colons) and stripped for plain hostnames or host:port pairs.
     +
     +    Suggested-by: Torsten Bögershausen <tboegi@web.de>
          Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
      
     + ## t/meson.build ##
     +@@ t/meson.build: integration_tests = [
     +   't9901-git-web--browse.sh',
     +   't9902-completion.sh',
     +   't9903-bash-prompt.sh',
     ++  't9904-url-parse.sh',
     + ]
     + 
     + benchmarks = [
     +
       ## t/t9904-url-parse.sh (new) ##
      @@
      +#!/bin/sh
      +#
     -+# Copyright © 2024 Matheus Afonso Martins Moreira
     ++# Copyright (c) 2024 Matheus Afonso Martins Moreira
      +#
      +
      +test_description='git url-parse tests'
     @@ t/t9904-url-parse.sh (new)
      +
      +test_expect_success 'git url-parse -- file urls' '
      +	git url-parse "file:///repository/path" &&
     -+	git url-parse "file:///" &&
      +	git url-parse "file://"
      +'
      +
     -+test_expect_success 'git url-parse -c protocol -- ssh syntax' '
     -+	test ssh = "$(git url-parse -c protocol "ssh://user@example.com:1234/repository/path")" &&
     -+	test ssh = "$(git url-parse -c protocol "ssh://user@example.com/repository/path")" &&
     -+	test ssh = "$(git url-parse -c protocol "ssh://example.com:1234/repository/path")" &&
     -+	test ssh = "$(git url-parse -c protocol "ssh://example.com/repository/path")"
     ++test_expect_success 'git url-parse -c scheme -- ssh syntax' '
     ++	test ssh = "$(git url-parse -c scheme "ssh://user@example.com:1234/repository/path")" &&
     ++	test ssh = "$(git url-parse -c scheme "ssh://user@example.com/repository/path")" &&
     ++	test ssh = "$(git url-parse -c scheme "ssh://example.com:1234/repository/path")" &&
     ++	test ssh = "$(git url-parse -c scheme "ssh://example.com/repository/path")"
      +'
      +
     -+test_expect_success 'git url-parse -c protocol -- git syntax' '
     -+	test git = "$(git url-parse -c protocol "git://example.com:1234/repository/path")" &&
     -+	test git = "$(git url-parse -c protocol "git://example.com/repository/path")"
     ++test_expect_success 'git url-parse -c scheme -- git syntax' '
     ++	test git = "$(git url-parse -c scheme "git://example.com:1234/repository/path")" &&
     ++	test git = "$(git url-parse -c scheme "git://example.com/repository/path")"
      +'
      +
     -+test_expect_success 'git url-parse -c protocol -- http syntax' '
     -+	test https = "$(git url-parse -c protocol "https://example.com:1234/repository/path")" &&
     -+	test https = "$(git url-parse -c protocol "https://example.com/repository/path")" &&
     -+	test http = "$(git url-parse -c protocol "http://example.com:1234/repository/path")" &&
     -+	test http = "$(git url-parse -c protocol "http://example.com/repository/path")"
     ++test_expect_success 'git url-parse -c scheme -- http syntax' '
     ++	test https = "$(git url-parse -c scheme "https://example.com:1234/repository/path")" &&
     ++	test https = "$(git url-parse -c scheme "https://example.com/repository/path")" &&
     ++	test http = "$(git url-parse -c scheme "http://example.com:1234/repository/path")" &&
     ++	test http = "$(git url-parse -c scheme "http://example.com/repository/path")"
      +'
      +
     -+test_expect_success 'git url-parse -c protocol -- scp syntax' '
     -+	test ssh = "$(git url-parse -c protocol "user@example.com:/repository/path")" &&
     -+	test ssh = "$(git url-parse -c protocol "example.com:/repository/path")"
     ++test_expect_success 'git url-parse -c scheme -- scp syntax' '
     ++	test ssh = "$(git url-parse -c scheme "user@example.com:/repository/path")" &&
     ++	test ssh = "$(git url-parse -c scheme "example.com:/repository/path")"
      +'
      +
      +test_expect_success 'git url-parse -c user -- ssh syntax' '
     @@ t/t9904-url-parse.sh (new)
      +	test "" = "$(git url-parse -c user "example.com:/repository/path")"
      +'
      +
     ++test_expect_success 'git url-parse -c password -- http syntax' '
     ++	test secret = "$(git url-parse -c password "https://user:secret@example.com:1234/repository/path")" &&
     ++	test secret = "$(git url-parse -c password "http://user:secret@example.com/repository/path")" &&
     ++	test "" = "$(git url-parse -c password "https://user@example.com/repository/path")" &&
     ++	test "" = "$(git url-parse -c password "https://example.com/repository/path")"
     ++'
     ++
      +test_expect_success 'git url-parse -c host -- ssh syntax' '
      +	test example.com = "$(git url-parse -c host "ssh://user@example.com:1234/repository/path")" &&
      +	test example.com = "$(git url-parse -c host "ssh://user@example.com/repository/path")" &&
     @@ t/t9904-url-parse.sh (new)
      +	test "~user/repository" = "$(git url-parse -c path "example.com:~user/repository")"
      +'
      +
     ++test_expect_success 'git url-parse -c path -- username expansion strips query and fragment' '
     ++	test "~user/repository" = "$(git url-parse -c path "ssh://example.com/~user/repository?query")" &&
     ++	test "~user/repository" = "$(git url-parse -c path "ssh://example.com/~user/repository#fragment")" &&
     ++	test "~user/repository" = "$(git url-parse -c path "git://example.com/~user/repository?query")" &&
     ++	test "~user/repository" = "$(git url-parse -c path "user@example.com:~user/repository?query")"
     ++'
     ++
     ++test_expect_success 'git url-parse -- ssh syntax with IPv6' '
     ++	git url-parse "ssh://user@[::1]:1234/repository/path" &&
     ++	git url-parse "ssh://user@[::1]/repository/path" &&
     ++	git url-parse "ssh://[::1]:1234/repository/path" &&
     ++	git url-parse "ssh://[::1]/repository/path" &&
     ++	git url-parse "ssh://[2001:db8::1]/repository/path"
     ++'
     ++
     ++test_expect_success 'git url-parse -- git syntax with IPv6' '
     ++	git url-parse "git://[::1]:9418/repository/path" &&
     ++	git url-parse "git://[::1]/repository/path"
     ++'
     ++
     ++test_expect_success 'git url-parse -- http syntax with IPv6' '
     ++	git url-parse "https://[::1]:1234/repository/path" &&
     ++	git url-parse "https://[::1]/repository/path" &&
     ++	git url-parse "http://[2001:db8::1]/repository/path"
     ++'
     ++
     ++test_expect_success 'git url-parse -c host -- IPv6 in URL form' '
     ++	test "[::1]" = "$(git url-parse -c host "ssh://user@[::1]:1234/repository/path")" &&
     ++	test "[::1]" = "$(git url-parse -c host "ssh://[::1]/repository/path")" &&
     ++	test "[2001:db8::1]" = "$(git url-parse -c host "ssh://[2001:db8::1]/repository/path")" &&
     ++	test "[::1]" = "$(git url-parse -c host "git://[::1]/repository/path")" &&
     ++	test "[2001:db8::1]" = "$(git url-parse -c host "https://[2001:db8::1]/repository/path")"
     ++'
     ++
     ++test_expect_success 'git url-parse -c port -- IPv6 in URL form' '
     ++	test 1234 = "$(git url-parse -c port "ssh://user@[::1]:1234/repository/path")" &&
     ++	test "" = "$(git url-parse -c port "ssh://[::1]/repository/path")" &&
     ++	test 9418 = "$(git url-parse -c port "git://[::1]:9418/repository/path")"
     ++'
     ++
     ++test_expect_success 'git url-parse -- scp syntax with IPv6' '
     ++	git url-parse "[::1]:repository/path" &&
     ++	git url-parse "user@[::1]:repository/path" &&
     ++	git url-parse "[2001:db8::1]:repo"
     ++'
     ++
     ++test_expect_success 'git url-parse -- scp syntax with bracketed hostname' '
     ++	git url-parse "[myhost]:src" &&
     ++	git url-parse "user@[myhost]:src"
     ++'
     ++
     ++test_expect_success 'git url-parse -- scp syntax with bracketed host:port' '
     ++	git url-parse "[myhost:123]:src" &&
     ++	git url-parse "user@[myhost:123]:src"
     ++'
     ++
     ++test_expect_success 'git url-parse -c host -- scp+IPv6' '
     ++	test "[::1]" = "$(git url-parse -c host "[::1]:repository/path")" &&
     ++	test "[::1]" = "$(git url-parse -c host "user@[::1]:repository/path")" &&
     ++	test "[2001:db8::1]" = "$(git url-parse -c host "[2001:db8::1]:repo")"
     ++'
     ++
     ++test_expect_success 'git url-parse -c path -- scp+IPv6' '
     ++	test "/repository/path" = "$(git url-parse -c path "[::1]:/repository/path")" &&
     ++	test "/repository/path" = "$(git url-parse -c path "[::1]:repository/path")" &&
     ++	test "/repo" = "$(git url-parse -c path "[2001:db8::1]:repo")"
     ++'
     ++
     ++test_expect_success 'git url-parse -c host,port,path -- scp [host:port]:src' '
     ++	test myhost = "$(git url-parse -c host "[myhost:123]:src")" &&
     ++	test 123 = "$(git url-parse -c port "[myhost:123]:src")" &&
     ++	test "/src" = "$(git url-parse -c path "[myhost:123]:src")"
     ++'
     ++
     ++test_expect_success 'git url-parse -c host,path -- scp [host]:src' '
     ++	test myhost = "$(git url-parse -c host "[myhost]:src")" &&
     ++	test "/src" = "$(git url-parse -c path "[myhost]:src")"
     ++'
     ++
     ++test_expect_success 'git url-parse -c user -- scp with user@ and brackets' '
     ++	test user = "$(git url-parse -c user "user@[::1]:repo")" &&
     ++	test user = "$(git url-parse -c user "user@[myhost:123]:src")" &&
     ++	test user = "$(git url-parse -c user "user@[myhost]:src")"
     ++'
     ++
     ++test_expect_success 'git url-parse -- scp+IPv6 with username expansion' '
     ++	test "~user/repo" = "$(git url-parse -c path "[::1]:~user/repo")" &&
     ++	test "~user/repo" = "$(git url-parse -c path "user@[::1]:~user/repo")"
     ++'
     ++
     ++test_expect_success 'git url-parse fails on invalid URL' '
     ++	test_must_fail git url-parse "not a url"
     ++'
     ++
     ++test_expect_success 'git url-parse helpful error for absolute local path' '
     ++	test_must_fail git url-parse "/abs/path" 2>err &&
     ++	test_grep "is not a URL" err &&
     ++	test_grep "file:///abs/path" err
     ++'
     ++
     ++test_expect_success 'git url-parse helpful error for relative local path' '
     ++	test_must_fail git url-parse "./rel" 2>err &&
     ++	test_grep "is not a URL" err &&
     ++	test_grep "absolute path" err
     ++'
     ++
     ++test_expect_success 'git url-parse fails on unknown -c component name' '
     ++	test_must_fail git url-parse -c bogus "https://example.com/repo"
     ++'
     ++
     ++test_expect_success 'git url-parse fails on URL missing host' '
     ++	test_must_fail git url-parse "https://"
     ++'
     ++
     ++test_expect_success 'git url-parse with no URL prints usage' '
     ++	test_must_fail git url-parse 2>err &&
     ++	test_grep "usage:" err
     ++'
     ++
      +test_done

-- 
gitgitgadget
