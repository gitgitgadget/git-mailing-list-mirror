Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685017C8D
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721679958; cv=none; b=f4wPiVNvJdUi6aLvM4OipIewpxVH1EhbJqtJoOPYmDIdD6OU2gVT8kseApTSuN8spWQg4kklSEEDbVHAVm19UcsirDzYDzXqR7m5zQsD1SSAB2AgcX4jRvv1V+qgyUfXDgzb9wD4vJSQTjUBMXmiWukDWSOq5E2HhYyej70Hpjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721679958; c=relaxed/simple;
	bh=YL+m+MAPYdEOEQ+BYpHyYioPPakYUDb90VNgjKI7w90=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M5lBG6J+0ZjvVs2MrLEdYYqXZ2gvICBCvnk+hm5i/hJ8LS0OdlohxmtGrR0wD4nJ01+WnVfvPeTmEPWSQ7XESvSZNQy9JM3nR1tcsBDfaIezFFE8rhVI0J9j/6caMZ/LnzyHVMWzLjFR+EfKukThUAAQ1QRu3wc+xljfCp0wf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fty3hxMo; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fty3hxMo"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so2677773e87.0
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 13:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721679954; x=1722284754; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjZfSApDIJXKCeUF8Y3b8Io8pzk8DvQNryfh3RZmLzQ=;
        b=Fty3hxMooKF0Nxr/9RxdXYjUfvBvKBXwzsT3Poqw6eOv/hHsPe+KO5JYmzD77sedAv
         ODLJpN37gslGPu2CfF5JSXLDEJ52bNRYUo04HRswLH0h/op4F2Re0Rj8n87Shb/CtfmC
         IzxGp0QtohtpewSIFNGgKazNBlRwhzLS2msjWz5rWrqyg83CdVLU0fqxr5q5zx+XWXyv
         Reup2M+k9tpdj96diYLkt8L9Aox/+67amqPIAggpPfAFsa3rd59c8d7z/crs0NEzi+AA
         sG3gRmUMn0z25qryQrEP4t/TgdgCqfDpUaXHx1nsTDDTgnDw4eOk74Oo9EcTNSaXMlhO
         Qbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721679954; x=1722284754;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjZfSApDIJXKCeUF8Y3b8Io8pzk8DvQNryfh3RZmLzQ=;
        b=tBv3uDVrVu6o1gr7L+9hzMPihOTUgCbNdIbBvzvTF8RNtaHlOQ/K3+izSI2JfwOkPL
         eMjkY6+2/CaEt+x6bZvALZ5oVZutDzBHGDP+XtYZxyC+sk88NORYvWjGSRM/mL5wlC01
         JH3AqmlYpSj+ujTbX6oi2gmeIelxvXqW8TSXGQ0CyB5VwASHmXBq8HtPuqGbjLOdskSK
         ulA0yrvm7WkXw4/LiZQvVLVOmaQXOy73UzdA7oQs9BMprtRF1p5zyktZevZlyjQGAY0s
         rtgMpI2IyhMlH0NuGmR3yCD/jHh38k1ELGCJxBtFUowWKWFXo4QggiawKa5zp5vfOyzj
         A9IQ==
X-Gm-Message-State: AOJu0YzbSW3XI2oVlayC6zJSqhKj9g5A/BVJkdqCT/sjpkx2+zzn3mSO
	Vr8eUDdVZa46WqX5Jmsiea8XMo0BiF77rWGdcFj3kf+LmQCIKvN5kOMFHg==
X-Google-Smtp-Source: AGHT+IFya3WQTu0KiAPuxl3wWUB1e9E58lSY4/QHgZ0E78L0MGRwn3eEWTgoYI2suFQY/mh2VT8W1w==
X-Received: by 2002:a05:6512:683:b0:52c:cc2e:1c45 with SMTP id 2adb3069b0e04-52ef8d95dbfmr5327510e87.15.1721679954157;
        Mon, 22 Jul 2024 13:25:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a77d8be58csm2563132a12.4.2024.07.22.13.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 13:25:52 -0700 (PDT)
Message-Id: <pull.1749.v2.git.git.1721679949618.gitgitgadget@gmail.com>
In-Reply-To: <pull.1749.git.git.1721507416683.gitgitgadget@gmail.com>
References: <pull.1749.git.git.1721507416683.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Jul 2024 20:25:49 +0000
Subject: [PATCH v2] asciidoctor: fix `synopsis` rendering
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since 76880f0510c (doc: git-clone: apply new documentation formatting
guidelines, 2024-03-29), the synopsis of `git clone`'s manual page is
rendered differently than before; Its parent commit did the same for
`git init`.

The result looks quite nice. When rendered with AsciiDoc, that is. When
rendered using AsciiDoctor and displayed in a graphical web browser such
as Firefox, Chrome, Edge, etc, the result is quite unpleasant to my eye,
reading something like this:

	SYNOPSIS

	 git clone
	  [
	 --template=
	 <template-directory>]
		  [
	 -l
	 ] [
	 -s
	 ] [
	 --no-hardlinks
	 ] [
	 -q
	 ] [
	[... continuing like this ...]

The reason is that AsciiDoctor's default style sheet contains this (see
https://github.com/asciidoctor/asciidoctor/blob/854923b15533/src/stylesheets/asciidoctor.css#L519-L521
for context):

	pre > code {
	  display: block;
	}

It is this `display: block` that forces the parts that are enclosed in
`<code>` tags (such as the `git clone` or the `--template=` part) to be
rendered on their own line.

Side note: This seems not to affect console web browsers like `lynx` or
`w3m`, most likely because most style sheet directions cannot be
respected in text terminals and therefore they seem to punt on style
sheets altogether.

To fix this, let's apply the method recommended by AsciiDoctor in
https://docs.asciidoctor.org/asciidoctor/latest/html-backend/default-stylesheet/#customize-docinfo
to partially override AsciiDoctor's default style sheet so that the
`<code>` sections of the synopsis are no longer each rendered on their
own, individual lines.

This fixes https://github.com/git-for-windows/git/issues/5063.

Even on the Git home page, where AsciiDoctor's default stylesheet is
_not_ used, this change resulted in some unpleasant rendering where not
only the font is changed for the `<code>` sections of the synopsis, but
padding and a different background color make the visual impression
quite uneven. This has been addressed in the meantime, via
https://github.com/git/git-scm.com/commit/a492d0565512.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    asciidoctor: fix synopsis rendering
    
    This was reported in https://github.com/git-for-windows/git/issues/5063
    and has been fixed in Git for Windows already (in
    https://github.com/git-for-windows/git/pull/5064, because Git for
    Windows uses AsciiDoctor to render the HTML help pages).
    
    A related fix for https://git-scm.com/docs/ (where AsciiDoctor is used,
    too) was merged as part of https://github.com/git/git-scm.com/pull/1855.
    
    This patch is based on ja/doc-markup-updates, but also applies cleanly
    to the default branch.
    
    Changes since v1:
    
     * Clarified the commit message to motivate better why this patch is
       required.
     * Exempted the docinfo.html file in .gitignore from being mistaken for
       an untrackable file.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1749%2Fdscho%2Ffix-synopses-rendering-with-asciidoctor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1749/dscho/fix-synopses-rendering-with-asciidoctor-v2
Pull-Request: https://github.com/git/git/pull/1749

Range-diff vs v1:

 1:  ee3ee00a199 ! 1:  41522706456 asciidoctor: fix `synopsis` rendering
     @@ Commit message
          `git init`.
      
          The result looks quite nice. When rendered with AsciiDoc, that is. When
     -    rendered using AsciiDoctor, the result is quite unpleasant to my eye,
     +    rendered using AsciiDoctor and displayed in a graphical web browser such
     +    as Firefox, Chrome, Edge, etc, the result is quite unpleasant to my eye,
          reading something like this:
      
                  SYNOPSIS
     @@ Commit message
                   ] [
                  [... continuing like this ...]
      
     -    Even on the Git home page, where AsciiDoctor's default stylesheet is not
     -    used, this change results in some unpleasant rendering where not only
     -    the font is changed for the `<code>` sections of the synopsis, but
     -    padding and a different background color make the visual impression
     -    quite uneven: compare https://git-scm.com/docs/git-clone/2.45.0 to
     -    https://git-scm.com/docs/git-clone/2.44.0.
     +    The reason is that AsciiDoctor's default style sheet contains this (see
     +    https://github.com/asciidoctor/asciidoctor/blob/854923b15533/src/stylesheets/asciidoctor.css#L519-L521
     +    for context):
     +
     +            pre > code {
     +              display: block;
     +            }
     +
     +    It is this `display: block` that forces the parts that are enclosed in
     +    `<code>` tags (such as the `git clone` or the `--template=` part) to be
     +    rendered on their own line.
     +
     +    Side note: This seems not to affect console web browsers like `lynx` or
     +    `w3m`, most likely because most style sheet directions cannot be
     +    respected in text terminals and therefore they seem to punt on style
     +    sheets altogether.
      
          To fix this, let's apply the method recommended by AsciiDoctor in
          https://docs.asciidoctor.org/asciidoctor/latest/html-backend/default-stylesheet/#customize-docinfo
     @@ Commit message
      
          This fixes https://github.com/git-for-windows/git/issues/5063.
      
     +    Even on the Git home page, where AsciiDoctor's default stylesheet is
     +    _not_ used, this change resulted in some unpleasant rendering where not
     +    only the font is changed for the `<code>` sections of the synopsis, but
     +    padding and a different background color make the visual impression
     +    quite uneven. This has been addressed in the meantime, via
     +    https://github.com/git/git-scm.com/commit/a492d0565512.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     + ## Documentation/.gitignore ##
     +@@
     + *.xml
     + *.html
     ++!/docinfo.html
     + *.[1-8]
     + *.made
     + *.texi
     +
       ## Documentation/Makefile ##
      @@ Documentation/Makefile: ASCIIDOC_DOCBOOK = docbook5
       ASCIIDOC_EXTRA += -acompat-mode -atabsize=8


 Documentation/.gitignore   | 1 +
 Documentation/Makefile     | 1 +
 Documentation/docinfo.html | 5 +++++
 3 files changed, 7 insertions(+)
 create mode 100644 Documentation/docinfo.html

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index a48448de32f..d11567fbbe7 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -1,5 +1,6 @@
 *.xml
 *.html
+!/docinfo.html
 *.[1-8]
 *.made
 *.texi
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f2383a12c7..78e407e4bd1 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -202,6 +202,7 @@ ASCIIDOC_DOCBOOK = docbook5
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+ASCIIDOC_EXTRA += -adocinfo=shared
 ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
diff --git a/Documentation/docinfo.html b/Documentation/docinfo.html
new file mode 100644
index 00000000000..fb3560eb92b
--- /dev/null
+++ b/Documentation/docinfo.html
@@ -0,0 +1,5 @@
+<style>
+pre>code {
+   display: inline;
+}
+</style>

base-commit: 76880f0510c6be9f6385f2d43dcfcba4eca9ccbc
-- 
gitgitgadget
