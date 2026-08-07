Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9696246AEE4
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104075; cv=none; b=jmdy/AySi0/Ct9iskPrGt9WM1vlwX4g8HG7fqvFYscwn4M6Gaa/fT/qL697WOnLcpgNOJzHh//x0kr4T4zSSdXHhcDMtR2K+Am3odyGTTXDEJBhYCsS+KSYJAeGOzqhvasos6Z9XaFL91+CCImDNQAegGVJmqyy98vwMDK5dTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104075; c=relaxed/simple;
	bh=HLaxFWSTAUu7ytIZKrH3O2GINo8RpzENeKuEnWyWRSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQb89RYgOp4GymdbyubGimavW8fyOOmTSN5PJVQxecI64JhhnYojr1B05viy8VIILimQ40So8ugL51Qf3ESklAFcdgkwjAC6T3kgUZN5ZdCoMYSH30x14g7McKSXoi0yhY9VbR6ymWziVYx7TNGDzzc6RuoXZoHGepqo/HSPO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn6zcB/N; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn6zcB/N"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6688a2dceb8so2134565d50.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 05:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786104060; x=1786708860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ehEifZloepXlzSEUv9Mq8F3HdcFRZw1yI10LLJf21l0=;
        b=Cn6zcB/Neo24K4gdZ9+KW434mIAI9EfMgXb7npWB51Ei1HJr1n+RUoP153LcuuURD6
         HngoTX2872MN6hQQcm9S3dQZUNvgCaFu447dhc+LcvRlW63wuOgkm/tPlVYiaq0CDxTr
         cbjRw6EJ8ItVOAEAJVWgM2NvuqhuWpnwasdNULD19HL3XfbSYvqRGD5L11CCjFJh2ePW
         vRA/QJEvehslUR/iPHdrHVSEjufAGaWmNzKwgcwv4qDlS5fchtElTYtjT0AOU/PtW14A
         3YKHwEZCac2SVV1lEic73Juu0ObX3viZYUwKJhENcv+MKJx3IaZiWLIHUmXgL8J2lC8w
         oBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104060; x=1786708860;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ehEifZloepXlzSEUv9Mq8F3HdcFRZw1yI10LLJf21l0=;
        b=Yq+WRjgEkJ4NEtL3rrPWeOlajjScUggeqjBiLMkCc1Vl2/KDgzvexyj125sDtMrW6g
         Dt3/kpZRmfkA78QVVOXAJrKD170r44DOpZC7HPyo9A0UgVa9kV4h+UV7nxU+zgWuehdv
         T514dsTdmutD5zZO2FjyVv28fUc1C6MiklXkY/OV6i6pgTm82cd6QKhTvGnlpGtR3hV4
         30WlNLIRdtBS+pSbeY6PXeXScA1mf0LAWusOxuTFsir4ds2L90SybVtAcZnUw3Wrq5/P
         H77u4wUtBIbEgBtK+53bI71Pq9RGl77AqvJ9e+WyHEv/JqfixRI7nE3NY+Yp6Cboktgu
         zlBQ==
X-Gm-Message-State: AOJu0Yzmf7KQymkPnuTDHtD9KgHkRjg+e2lzcJE+34du8Iki9MFfZkAQ
	rYXU2I6AhO3omyNfL/LTuBsImKz91/QIhLB55wgXY5ssi/otYpo2gICPI2wbxx4jri0=
X-Gm-Gg: AR+sD10YsDp1WD2v1FTBQ22X/1bT7ufPBP7XQnz8+/zgvV/nY3MsE1XCbWxTkhKVnzn
	mMXl4Ug0DoLi4d69M1spVr7yEvKOAPgXYhMDO2ewCuTuWl6jNUtwsuikLIhOsLwf+O5p+vIW1L2
	4MJfOWEEUsw/ACVbdCX807JGmOqQXUVYMA2xolnx5s8P8zZoZH1iErDy47mKvgOWfreQqHvZc6B
	bKBCvPLAuTQKkzWBc8cW1NnDaDV7Q4AqwIk5evfe9fMpShSfSp4tXfZCfam1QKqF2m9gnM5HwYR
	NT0NCwjeJmwwlluKQ8+5Q+VXrivGG9pTEcvLUnYYFo1NrfcBd3B4X7mhDlI2mmgqR0kVbvTJQ30
	rkTVr2jHIq6h0i5wQV9+gIAnoAvC+eiviqK3+YNVH+AraEtmzT/+v5cndLdxnfismnHjHRXQ0AB
	u0udakKrLMkMMFHdJqD1uWk3SfvzzKaz+aVpeshS8nXujXMOOSh04ErrTbnRbgreyph+eSYiyqA
	D8rCOPfV+t7D2Y0y3+ODcUJ1FFHItVGMvB2eU72wd1DlaOVdIkXYY3yorlsxJlrApO6bsLemmdN
	gdTzlkGfSJE=
X-Received: by 2002:a05:690e:4882:10b0:664:eb8c:9e3c with SMTP id 956f58d0204a3-66acd39a88fmr1182657d50.46.1786104060264;
        Fri, 07 Aug 2026 05:01:00 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acae63149sm1048042d50.11.2026.08.07.05.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:00:59 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/3] meson: expose knob for xmlto relative links in manuals
Date: Fri,  7 Aug 2026 07:56:24 -0400
Message-ID: <d612de6c2de615f368b5985f200c5ea8e3116c08.1786103607.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.340.g8e2bf96aa5.dirty
In-Reply-To: <cover.1786103607.git.ben.knoble@gmail.com>
References: <cover.1786103607.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Makefile-based builds have had this knob for most of the project's life,
since a479a564dc (Documentation/Makefile: allow
man.base.url.for.relative.link to be set from Make, 2009-12-03).

Meson, however, hard-codes the equivalent of $prefix/$mandir, which is
not really where all the HTML docs are stored in most distro builds.
Plus, this value is missing a trailing slash, so links come out broken,
like this in git.1:

        1. Git User’s Manual
           /usr/share/manuser-manual.html

Of course we can do better:

1. Change the default to match Make: use file://$(htmldir)/ (with
   trailing slash!) to form a local URL pointing at the HTML docs. This
   is safe because all current uses of link:<relative> point at HTML
   docs:

      git grep 'link:[[:alnum:]]' Documentation | grep -ve html -e http

   produces only a single result (Documentation/howto/howto-index.sh)
   which can be ignored. Since nothing else [*] in the normal build sets
   MAN_BASE_URL, this seems like the right default.

2. Provide a configurable knob, just like the Makefile, so distributions
   that build with Meson (like Gentoo) can decide where to make the
   links if they need to. Those that set htmldir probably won't need to
   tweak this any further, though.

[*]: Well, Git's todo branch has a script dodoc.sh to build and archive
     docs for kernel.org; these docs are pulled by Homebrew
     installations, for example. It sets MAN_BASE_URL to "git_htmldocs",
     so the equivalent note on macOS + Homebrew is

        1. Git User’s Manual
           git-htmldocs/user-manual.html

     which is not functional either, but that's a problem for
     downstream. In any case, users can recover the right path with
     "git --html-path".

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---

Notes (benknoble/commits):
    This patch is mostly because I noticed the link I added in a later patch
    didn't come out right.
    
    I did an internet search for "MAN_BASE_URL" and got no real hits, so I'm
    not sure if any distros today actually use it, but that's not a proper
    audit in that I didn't look at any distro _code_ besides Gentoo (which,
    as noted, uses Meson).

 Documentation/meson.build | 7 ++++++-
 meson_options.txt         | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index f4854f802d..cfa9c67609 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -379,13 +379,18 @@ foreach manpage, category : manpages
       output: fs.stem(manpage) + '.xml',
     )
 
+    man_base_url = 'file://' + htmldir + '/'
+    if get_option('man_base_url') != ''
+      man_base_url = get_option('man_base_url')
+    endif
+
     doc_targets += custom_target(
       command: [
         xmlto,
         '-m', '@INPUT0@',
         '-m', '@INPUT1@',
         '--stringparam',
-        'man.base.url.for.relative.links=' + get_option('prefix') / get_option('mandir'),
+        'man.base.url.for.relative.links=' + man_base_url,
         'man',
         manpage_xml_target,
         '-o',
diff --git a/meson_options.txt b/meson_options.txt
index dc88f130d7..d590c21648 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -111,6 +111,8 @@ option('default_help_format', type: 'combo', choices: ['man', 'html', 'platform'
   description: 'Default format used when executing git-help(1).')
 option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto'], value: 'auto',
   description: 'Which backend to use to generate documentation.')
+option('man_base_url', type: 'string', value: '',
+  description: 'The base URL to use for relative links in manuals')
 
 # Testing.
 option('benchmarks', type: 'feature', value: 'auto',
-- 
2.55.0.340.g8e2bf96aa5.dirty

