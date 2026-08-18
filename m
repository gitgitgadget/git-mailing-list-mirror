Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFC61DA60D
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065230; cv=none; b=RnFoluYw3dcRPMwFzYAEr2m2vqiojbfVsNZto25l/CP4jzDWeHz8rcutZym22og1iWqXnybtyHT8sq+MLt8L64elJy3uSb/wHiBOexvFUsHSljb8qSTwq126gXmVosN1wkOHAYV0ClT2Mto+IwuVmUWjd9B+fxSeNLJizGEZT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065230; c=relaxed/simple;
	bh=qO3CU+W7z5AIzPx4uaDJ7XBT4wsqKQFTRqorFsMGnVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I19V+atrTZrUpIKWqy1uiToya4kIUfO0W+8yHMaVn/NjTqrw95MtnCIscSwjmMMLHOqrFh2zEIoIf+dFJQJc/eK3ghKpmxMWZQLAQcjGmg8b2MPcwVvmOqgcV3+E24XjzZQ6RLf58luW46r6t939fO3+M7v2mBT0ky/ARALuZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8mKKhwG; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8mKKhwG"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-836c91bd782so66658957b3.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 08:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787065228; x=1787670028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pfWbbitrrFpkECN1lc190K5Biv61gMTnFAHWSnlT+DM=;
        b=c8mKKhwGnIIMBG5d8WeZm2pzgbVh++KLpRmqrbfPh3xhUPQfHLSWHrOpOVok1OpmoA
         v5Oyfl3pi7+8CEQXTdOm6BOwJJ0Om0s1gfPmwfvYPYeUX6T5talTEGWp1fHFdcOH2s0f
         8DOMnrfik8fIZQe6wUw63OHR44giBnaIGgSYIf9hxWEwDnQ5FA7RZfCcjjLu1ebeoodK
         C7XM3qffXxgyHiZZuu5ERquPKCsrVXX2SlBi7vNaE/wXs+OytE2jFTYhhWh5z56sS2xN
         3+sDPyyKCwsR3nzwYJp7ufQryTidjYPqouQ1eKeEdd/atzZmO1yr6LWkK8N9TxrE6TVc
         0n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065228; x=1787670028;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfWbbitrrFpkECN1lc190K5Biv61gMTnFAHWSnlT+DM=;
        b=F6lph4ar5ZIb+gVfiJYfnI3fMMs0pFgpLpIWN3lWkK6kUvl+dzTZBT5WiyB7tHzX3B
         IBGGS+l18xjiRANPfhJW09mgZ2gCQ6/m+MwCs0QfHh5ulddAAjVhfwahf3ZtC/D6h+iZ
         xwEHPp1bv5KcpiNYh8M+e0ZYuJ069at3oEV2C1HgIZ04MexT7/PKftVHlfil4GkZ3lH7
         P2UmK4gZdhJhtZxx3uceKNRLNKT4td30pEvN3tzWcOgNS7C07okEM2DPY3C6xi9cj17k
         HwjZPb0NW3qtMo3W6w+taapJoNVuM3u7FSw3GLALPhl4U0I8iwaZ43krVEj8Ylio3GJ0
         M31A==
X-Gm-Message-State: AOJu0Yzi12eOAIVW5iazxire50BAtblmiAIUHwq5bp5i2mR1OWZjH5vI
	OatbcDWEwEW1HvcW7lr42ssQQOfgvMTgXkboQ5AIYt/f8qX5QuNPPVL02dSvo6dt
X-Gm-Gg: AR+sD11tPMIk+dTWwjuGmN3gL8yVsCvvJJRXJP+zD3Ue1fUpgtYQehy1Sqh6jyx01Uc
	gMA6fDc3uavaO3dqZ49jD4QYdOSKi3zL0k/DgJWgFXfAtUMJtfl5giYBDGUPoryUjhNhA+wO4Ph
	kISqrGGGC0s4mN4kvuQi3W9INZw8Fum0k5PKzlEEx5sY/xQ8X03KpHMe6LJ1Yjh32DfanQ7p1vn
	n5q+tMdxCu29xEcLrjPDTAp0EAirgcAHT7ee4M7XX9sno3DjqmiaHeXnLs9jDmbpqv/owautaLk
	hD8op3oV8KFfBZzhdEARuWP+GfDVWO/0VqiWz9KbQK5jkyju03fd1cO3t04R2h++YxbKagmWXEy
	nGor2Hg5kAHciEZs86WIgDKI2FHKLlM1uYwyG8MjfYv0WgXg3Ql30LBtbozjPppNuj1kf9jUEwx
	NXkoLOXmWG9fKrIiWxHCfi9EnjJ1RKwin8bYd09DrPHoU1SIwLa1dUdAcPvG2iiPOE5vKMzoKch
	Lris/jnxlsIRilOl4cQbzTLiGWrrv5Yff1b/VppY3sVPIKCPK4ztcPkRyShOZnspYyUW3Eu7DDq
	jq7lpjuVPxhUNw25V9ni8w==
X-Received: by 2002:a05:690c:6013:b0:81f:d3e6:82ea with SMTP id 00721157ae682-8370dfb3914mr135335897b3.5.1787065227959;
        Tue, 18 Aug 2026 08:00:27 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-840f3d1fb12sm20201097b3.48.2026.08.18.08.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:00:27 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 1/3] meson: expose knob for xmlto relative links in manuals
Date: Tue, 18 Aug 2026 10:59:45 -0400
Message-ID: <d612de6c2de615f368b5985f200c5ea8e3116c08.1787065125.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed.dirty
In-Reply-To: <cover.1787065125.git.ben.knoble@gmail.com>
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1787065125.git.ben.knoble@gmail.com>
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
2.55.0.860.g4b6b3295ed.dirty

