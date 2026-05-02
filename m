Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C210923BCE3
	for <git@vger.kernel.org>; Sat,  2 May 2026 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777699727; cv=none; b=JiUBDB68CAgblx7y7dkWaAuZddrhIBMNwISSEM7mN2tYZu7hBsGZ89bUe8zbh8ndrm5SJkKYdIDt8HLDwLuoYs+mHTu1hQg0HtAYFA2tDbA7l6lo+ViTtf9jFMyRgfJSy3TPNxdc+nkQe/yPlco0yILsc72i8iQLb2Mk1Ayrkow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777699727; c=relaxed/simple;
	bh=Tzja57LRKf4mi3MabAtc8c+IV0vZz/94b6UzYvzdfLg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=GdutqHrvVR7jjzd0N5T27uJeGv1DMTY4f82m3n2HvVUCDUXRI9gN8cOjIoF9Bx9tIgDoNtedMd6iHmEUTx9hj6VXgh0fyxIn+sjYHlk2qe1Zx5mUMDJeuCVu9rzvdekaFCpZpgj8nGPeWz3m+TbjmNrYsLy6085kSJr+JsPiJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF9LDK36; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF9LDK36"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ef5776530bso289662385a.0
        for <git@vger.kernel.org>; Fri, 01 May 2026 22:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777699724; x=1778304524; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ItD6LhiDuhFOET450oiILLJS8hoW0chl4sixDnelAQ=;
        b=fF9LDK36h4O5/n5xdtCdJhULbRM5AGmZ+Ny4Bv4BRh5XY/ki64cYhCNLhqVhjVFO7l
         qKFHkzOVqOuYR9fh0PKnI4QtBtAbqt+hB9FgT4/mkfmFI67ElrxkrUrW85ewyckQwgVS
         f+yZ0HUX6MzLzHNFvevdHhbajJbh9TDfcmLWWiEgO7ShnMSONGExm3c6NQ00Cc7l/Ah5
         ZV1f40yAUTPgRCo2lCoV8nzKRNJgbhGrMIB51+T21ht8tGzI+K+A8roXoHRbIeHBEkeO
         6s2/2l6kyA20vZfdCx/PzZADC0SbgE5LUdl89jhE7YI3a5DRfeWx/Uw9HOuu+j99szh8
         AWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777699724; x=1778304524;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ItD6LhiDuhFOET450oiILLJS8hoW0chl4sixDnelAQ=;
        b=YDh2H9ReporPBOWISj4i2ECtRIJ8u3tckUQNnV4p9hMbbuHw+MowEdSYWcjnY6mTRl
         O2c9QTFfc6KiPMBV2LfQXz7wYiOWorNQPQfhmRyoiNsjhsezUvlEVWC3Rbs0CZmyQ5mR
         6OsIVHds331gMMDM2+JyxHl2qygCG1vcZT/fqWFkbhZBw9xI1HEpjQucusL6HQSis+Uz
         YbiODe/zxF5un7DIw64vux5uYv5agTmXh09IJdlGdtNiUMhTnxluxrBYRFtMGydPl90c
         57VBoH+CF70xpiGz9PZXkPfan/411IAWoKgZl6YKSnSRhnzBGMjnrcOsHdVhvUmGTuOA
         eL7g==
X-Gm-Message-State: AOJu0Yxov06HAIvwNQ0xrkYxgrJ04O/8lAxO4mlTetXFJopy877KkP/v
	RsT4Nf3yuRoztUhGz9pfeYwSmYgKO1/5fVAcmit+TaAFudBkQq5ydmMqFVUv/A==
X-Gm-Gg: AeBDievaMM0rHzJ0XW6R/zYRoMGwE/oTiynBwphTKTtdwuHwqr7WtGqoTatpgoGati2
	9r//a3qVYi+6EooWIQAdnyv6XUj9GaTUQyPPx0rht4kTYvBrx90ZtLyb5MUOTicq6EYKFKrABLE
	LCtnRF/bApYfm2GlvbVjWT2cGcpYdOIk/4IT997DxGzUfxN4tPDAyL4l3FZVJ+guzQCitVqFZEq
	IjSfYDZmOT7Fi08GdxCAXLRfiSkB15GrICY6YquDc1Z0bHb/SswiIEVMPtMCek0APdYVMc/FpB+
	YmGc0MAf4hM4HBszH2tonGtRgM/tYgxqWQbZYHaPPH8RF7bn0SGfMTRj4EEI80QJWEmoVR8AMSM
	FyaDT5i6S3EfZQHJ1tk8anwpcRh73Hkr1+gQW+GENdxjFq9Q5zNNI4JaWuRpO0WSBQYXpbJnHNX
	OHVl34Zu1iwkflqJVTzgyopoPlFMznJDjp4rHL1Ds=
X-Received: by 2002:a05:620a:6cc5:b0:8d0:3add:30d8 with SMTP id af79cd13be357-8fd1833605cmr353479985a.52.1777699723742;
        Fri, 01 May 2026 22:28:43 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253e04sm383692585a.31.2026.05.01.22.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 22:28:43 -0700 (PDT)
Message-Id: <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
From: "Matheus Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 05:28:34 +0000
Subject: [PATCH v3 0/8] builtin: implement, document and test url-parse
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

Changes since v2:

 * Fix Windows CI failure: handle DOS drive prefix in the helpful local-path
   error. With this, the message for a drive-letter input like C:/repo (or
   an MSYS-mangled /abs/path that bash rewrites to D:/.../abs/path before
   git sees it) gets the specific file:///<input> suggestion rather than the
   generic fallback. No effect on Linux or macOS, since has_dos_drive_prefix
   is a no-op on non-Windows builds.

 * t9904: relax the grep on the absolute-path test from the literal
   file:///abs/path to the structural file:/// (three slashes). The original
   assertion depended on the input being preserved verbatim, which MSYS does
   not do. The relaxed grep verifies the structurally meaningful property
   (specific URL suggestion was produced, not the generic fallback) and runs
   cross-platform.

Range-diff against v2:

1: 38f797362d = 1: 38f797362d connect: rename enum protocol to url_scheme 2:
a4153e1d24 = 2: a4153e1d24 url: move url_is_local_not_ssh to url.h 3:
e584fb03f3 = 3: e584fb03f3 url: move scheme detection to URL header/source
4: 7381704c38 = 4: 7381704c38 url: return URL_SCHEME_UNKNOWN instead of
dying 5: 89932a70f3 = 5: 89932a70f3 urlmatch: define url_parse function 6:
886a7d659e ! 6: af6c71227b builtin: create url-parse command @@
builtin/url-parse.c (new) + if (*url == '/') + die("'%s' is not a URL; if
you meant a local " + "repository, use 'file://%s'", url, url); ++ if
(has_dos_drive_prefix(url)) ++ die("'%s' is not a URL; if you meant a local
" ++ "repository, use 'file:///%s'", url, url); + die("'%s' is not a URL; if
you meant a local repository, " + "use a 'file://' URL with an absolute
path", url); + } 7: 3c44e0f478 = 7: 2b32cb71a3 doc: describe the url-parse
builtin 8: cf2ae409e6 ! 8: ce41d2ec50 t9904: add tests for the new url-parse
builtin @@ t/t9904-url-parse.sh (new) +test_expect_success 'git url-parse
helpful error for absolute local path' ' + test_must_fail git url-parse
"/abs/path" 2>err && + test_grep "is not a URL" err && -+ test_grep
"file:///abs/path" err ++ test_grep "file:///" err +' + +test_expect_success
'git url-parse helpful error for relative local path' '

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
 builtin/url-parse.c                     | 135 ++++++++++
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
 19 files changed, 780 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/git-url-parse.adoc
 create mode 100644 builtin/url-parse.c
 create mode 100755 t/t9904-url-parse.sh


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1715%2Fmatheusmoreira%2Furl-parse-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1715/matheusmoreira/url-parse-v3
Pull-Request: https://github.com/git/git/pull/1715

Range-diff vs v2:

 1:  38f797362d = 1:  38f797362d connect: rename enum protocol to url_scheme
 2:  a4153e1d24 = 2:  a4153e1d24 url: move url_is_local_not_ssh to url.h
 3:  e584fb03f3 = 3:  e584fb03f3 url: move scheme detection to URL header/source
 4:  7381704c38 = 4:  7381704c38 url: return URL_SCHEME_UNKNOWN instead of dying
 5:  89932a70f3 = 5:  89932a70f3 urlmatch: define url_parse function
 6:  886a7d659e ! 6:  af6c71227b builtin: create url-parse command
     @@ builtin/url-parse.c (new)
      +		if (*url == '/')
      +			die("'%s' is not a URL; if you meant a local "
      +			    "repository, use 'file://%s'", url, url);
     ++		if (has_dos_drive_prefix(url))
     ++			die("'%s' is not a URL; if you meant a local "
     ++			    "repository, use 'file:///%s'", url, url);
      +		die("'%s' is not a URL; if you meant a local repository, "
      +		    "use a 'file://' URL with an absolute path", url);
      +	}
 7:  3c44e0f478 = 7:  2b32cb71a3 doc: describe the url-parse builtin
 8:  cf2ae409e6 ! 8:  ce41d2ec50 t9904: add tests for the new url-parse builtin
     @@ t/t9904-url-parse.sh (new)
      +test_expect_success 'git url-parse helpful error for absolute local path' '
      +	test_must_fail git url-parse "/abs/path" 2>err &&
      +	test_grep "is not a URL" err &&
     -+	test_grep "file:///abs/path" err
     ++	test_grep "file:///" err
      +'
      +
      +test_expect_success 'git url-parse helpful error for relative local path' '

-- 
gitgitgadget
