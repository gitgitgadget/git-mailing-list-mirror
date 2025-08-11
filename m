Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4671B2D6608
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945612; cv=none; b=p2otra4YTXfF/nfw89FcQ159hlPYD0i2Lau1Qx8q8yMrA965YfGYkVtmSdg4wReuqT6LAE+DR8d9CGLQmK8vBd/5CcKq22FT7WKAH1CmWmlie4lL5HD+Zdx4u25+HsI1IAq4iOECs9vbvyCe4Ixq6q4Hxe07jaexAyOK8BwNup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945612; c=relaxed/simple;
	bh=QavCqvhngUQnF3G/rfjYX+kmK42BubOJ2zR/5jRroEc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=iH9hbL0+0u/KJg2lzbkq2ezcVsqgn8BfmNpqy2duhqmVH77rOmplaIqBEXRmms8k2lxQ0VIoppQQ/j5SA9q4kkQytpagfpsOL5HIP/Y7lJ7tDNYNW9cQdgS9olQU+XE3saApVpCqdbWv7s5W73jzSSxb4jEghnqKxM0bclwdPqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1mjZnyF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1mjZnyF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b7920354f9so3940394f8f.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754945608; x=1755550408; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NevRsbVTojlxZyO/3TAGEItN3HiLP1v/6AkORZn+rM=;
        b=I1mjZnyFfY29koaWjOIkWIs1IcDBE+LJm7e66YfQvqxelWM7iUFkisA4+DjCGXVnj+
         aN9/WBF/tqaS4Aa77qzdcWjut3V+OKYTBaPlTG+kKBmYCtsypp+YpLU30QBseZ0PciOr
         XEUrhjmHCBdPZYzHwmWWdPyeT8hUcmviCn4eRB7ytDKO/9uloWVh+Xp6qWHJhZReuzrY
         nMYo7CkPTyPPxleeq1DlTYtVGZmKpujtBR/xVEhlUrWXfg3kkpVuTw7VxkJ87ZCuBmEb
         wy1IMXhW8YqQb6PG/M1bC2ex0LaLgZgLoT1DYzBc3onNFpp2qxKuZnx6LODDuvJUM63f
         /QJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754945608; x=1755550408;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NevRsbVTojlxZyO/3TAGEItN3HiLP1v/6AkORZn+rM=;
        b=kUZDmnzlwyqwn3sw14P5vQjC97wqql9+VWYA//N5QKNda+6IxRWL9yGkYiPzK8tPoq
         AW/PsfTUVvwCBTs8i5HRz3+RIH0vXHdnH0O11nX+xFw66DFajGjQqHjBY+6rTW9WX5t8
         udx5VwppU1x/JF6K4U7UowVm7vcPbeCtmpv3Mf0UsXoNT3YGFR4Cb/ChPyI7h6Lz9Ykg
         YrzE4k+EmlwpvTbV3qz/+h12yiETnJUVscPahdH2bypGx+iFNLf4W2ra+mlMVTXfhqOd
         EZots8eMle7T1AdFu3XST4bkZq0fJC57MXvs6at/JQEFQnvbKsm8pdA1NF+JL+6hECXK
         +pSA==
X-Gm-Message-State: AOJu0YzA4dVXX6nmGdGdhUOeHtC5mYSuQyOdXLXLjPyHMC+QADeD2/T0
	jyoZtC24ed+utcMv19rQkLKAn095V7+909HTNcttys65crz/xclcdy2UQVa6Ng==
X-Gm-Gg: ASbGncvePbBuof0Tv4kn3UsW42ZKSRNbvGPVEJVEXoykOTrzxC3za60205tRxMdIgj+
	62ENg45jnVo8ApAJl/1YSKJkK6maS1QNM3w82DLM8swrfHpcYG7dTuA71moWj8ojavRSUO6S3uF
	rE5lA3gX/8cj6nsmC/0W0jdYrYVIm+am4fs+u6wicVDgcShDSXwF13zEq5U4X1oc4jJOp1jCdGF
	+QiFY/uxQVb9HowQCrPT4WMCAtZgPMWAHt3p481r65cZCzcBXkiqR9hCComKh+Qx/c5mrwvlBV+
	LVklmkeya+rh04ad2NAzJX0EVnV+NpbcAuP1ru8RLVWnlQzZLljKTR9HnLu9G16ysLkgsrhitQS
	C/LH7adnBYKCE820ZcpyWEqwukDzmcQsjHw==
X-Google-Smtp-Source: AGHT+IEzZjcBfz9MyBigr0fhH46rEDeHt7JDPoGkrojgOO/RW+G9u5PqpHkA4tS4jYDRlH4Dctp1/Q==
X-Received: by 2002:a05:6000:25c1:b0:3b7:99a8:bd10 with SMTP id ffacd0b85a97d-3b91100eb33mr709120f8f.42.1754945608327;
        Mon, 11 Aug 2025 13:53:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e054036bsm32136307f8f.31.2025.08.11.13.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:53:27 -0700 (PDT)
Message-Id: <4e0178218e8e10a28416e4c61074154e7f697868.1754945601.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.v3.git.1754945600.gitgitgadget@gmail.com>
References: <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
	<pull.1945.v3.git.1754945600.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 20:53:17 +0000
Subject: [PATCH v3 3/6] doc: check for absence of multiple terms in each entry
 of desc list
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
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Collin Funk <collin.funk1@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

For simplifying automated translation of the documentation, it is better to
only present one term in each entry of a description list of options. This
is because most of these terms can automatically be marked as
notranslatable.

Also, due to portability issues, the script generate-configlist.sh can no
longer insert newlines in the output. However, the result is that it no
longer correctly handles multiple terms in a single entry of definition
lists.

As a result, we now check that these entries do not exist in the
documentation.

Reviewed-by: Collin Funk <collin.funk1@gmail.com>
Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/Makefile                      | 10 +++++++++
 Documentation/git-check-attr.adoc           |  3 ++-
 Documentation/git-check-ignore.adoc         |  9 +++++---
 Documentation/git-http-fetch.adoc           |  5 ++++-
 Documentation/lint-documentation-style.perl | 24 +++++++++++++++++++++
 Documentation/technical/api-path-walk.adoc  |  5 ++++-
 shared.mak                                  |  1 +
 7 files changed, 51 insertions(+), 6 deletions(-)
 create mode 100755 Documentation/lint-documentation-style.perl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 76a9e1d02b26..6fb83d0c6ebf 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -508,6 +508,15 @@ $(LINT_DOCS_DELIMITED_SECTIONS): .build/lint-docs/delimited-sections/%.ok: %.ado
 .PHONY: lint-docs-delimited-sections
 lint-docs-delimited-sections: $(LINT_DOCS_DELIMITED_SECTIONS)
 
+## Lint: Documentation style
+LINT_DOCS_DOC_STYLE = $(patsubst %.adoc,.build/lint-docs/doc-style/%.ok,$(DOC_DEP_TXT))
+$(LINT_DOCS_DOC_STYLE): lint-documentation-style.perl
+$(LINT_DOCS_DOC_STYLE): .build/lint-docs/doc-style/%.ok: %.adoc
+	$(call mkdir_p_parent_template)
+	$(QUIET_LINT_DOCSTYLE)$(PERL_PATH) lint-documentation-style.perl $< >$@
+.PHONY: lint-docs-doc-style
+lint-docs-doc-style: $(LINT_DOCS_DOC_STYLE)
+
 lint-docs-manpages:
 	$(QUIET_GEN)./lint-manpages.sh
 
@@ -537,6 +546,7 @@ lint-docs: lint-docs-gitlink
 lint-docs: lint-docs-man-end-blurb
 lint-docs: lint-docs-man-section-order
 lint-docs: lint-docs-delimited-sections
+lint-docs: lint-docs-doc-style
 lint-docs: lint-docs-manpages
 lint-docs: lint-docs-meson
 
diff --git a/Documentation/git-check-attr.adoc b/Documentation/git-check-attr.adoc
index 503b6446574d..15a37a38e3f7 100644
--- a/Documentation/git-check-attr.adoc
+++ b/Documentation/git-check-attr.adoc
@@ -19,7 +19,8 @@ For every pathname, this command will list if each attribute is 'unspecified',
 
 OPTIONS
 -------
--a, --all::
+-a::
+--all::
 	List all attributes that are associated with the specified
 	paths.  If this option is used, then 'unspecified' attributes
 	will not be included in the output.
diff --git a/Documentation/git-check-ignore.adoc b/Documentation/git-check-ignore.adoc
index 3e3b4e344629..a6c6c1b6e5be 100644
--- a/Documentation/git-check-ignore.adoc
+++ b/Documentation/git-check-ignore.adoc
@@ -25,11 +25,13 @@ subject to exclude rules; but see `--no-index'.
 
 OPTIONS
 -------
--q, --quiet::
+-q::
+--quiet::
 	Don't output anything, just set exit status.  This is only
 	valid with a single pathname.
 
--v, --verbose::
+-v::
+--verbose::
 	Instead of printing the paths that are excluded, for each path
 	that matches an exclude pattern, print the exclude pattern
 	together with the path.  (Matching an exclude pattern usually
@@ -49,7 +51,8 @@ linkgit:gitignore[5].
 	below).  If `--stdin` is also given, input paths are separated
 	with a NUL character instead of a linefeed character.
 
--n, --non-matching::
+-n::
+--non-matching::
 	Show given paths which don't match any pattern.  This only
 	makes sense when `--verbose` is enabled, otherwise it would
 	not be possible to distinguish between paths which match a
diff --git a/Documentation/git-http-fetch.adoc b/Documentation/git-http-fetch.adoc
index 4ec7c68d3b9e..2200f073c471 100644
--- a/Documentation/git-http-fetch.adoc
+++ b/Documentation/git-http-fetch.adoc
@@ -25,8 +25,11 @@ commit-id::
         Either the hash or the filename under [URL]/refs/ to
         pull.
 
--a, -c, -t::
+-a::
+-c::
+-t::
 	These options are ignored for historical reasons.
+
 -v::
 	Report what is downloaded.
 
diff --git a/Documentation/lint-documentation-style.perl b/Documentation/lint-documentation-style.perl
new file mode 100755
index 000000000000..1f35a6a116da
--- /dev/null
+++ b/Documentation/lint-documentation-style.perl
@@ -0,0 +1,24 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+
+my $exit_code = 0;
+sub report {
+	my ($line, $msg) = @_;
+	chomp $line;
+	print STDERR "$ARGV:$.: '$line' $msg\n";
+	$exit_code = 1;
+}
+
+my $synopsis_style = 0;
+
+while (my $line = <>) {
+	if ($line =~ /^[ \t]*`?[-a-z0-9.]+`?(, `?[-a-z0-9.]+`?)+(::|;;)$/) {
+
+		report($line, "multiple parameters in a definition list item");
+	}
+}
+
+
+exit $exit_code;
diff --git a/Documentation/technical/api-path-walk.adoc b/Documentation/technical/api-path-walk.adoc
index 34c905eb9c31..a67de1b143ab 100644
--- a/Documentation/technical/api-path-walk.adoc
+++ b/Documentation/technical/api-path-walk.adoc
@@ -39,7 +39,10 @@ It is also important that you do not specify the `--objects` flag for the
 the objects will be walked in a separate way based on those starting
 commits.
 
-`commits`, `blobs`, `trees`, `tags`::
+`commits`::
+`blobs`::
+`trees`::
+`tags`::
 	By default, these members are enabled and signal that the path-walk
 	API should call the `path_fn` on objects of these types. Specialized
 	applications could disable some options to make it simpler to walk
diff --git a/shared.mak b/shared.mak
index 57095d6cf96c..5c7bc9478544 100644
--- a/shared.mak
+++ b/shared.mak
@@ -89,6 +89,7 @@ ifndef V
 	QUIET_LINT_GITLINK	= @echo '   ' LINT GITLINK $<;
 	QUIET_LINT_MANSEC	= @echo '   ' LINT MAN SEC $<;
 	QUIET_LINT_DELIMSEC	= @echo '   ' LINT DEL SEC $<;
+	QUIET_LINT_DOCSTYLE	= @echo '   ' LINT DOCSTYLE $<;
 	QUIET_LINT_MANEND	= @echo '   ' LINT MAN END $<;
 
 	export V
-- 
gitgitgadget

