Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA48632B
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710898; cv=none; b=DZnugg86Y/dIK/9ur5pJVXDlJft3RduZ1J3GIo1Q3puPhmRlB80Cuqb9ZefisTkZs96PsDHeHKMf/KVdKEbWjLjh25ZTI+FXcidv6xpC5J6xkWmcTS7bzuUpd+tzFUh3v4oO+4iJIvdvkts+4+EOCUb/N6XbTJ0pMRcmc58pXio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710898; c=relaxed/simple;
	bh=A9VIOz9UNd0SmVrhAcHombEmBcoUTgHjYyE05dNFwnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyt5Xl8Sicrj5Sry058EvKKA7AePHZQ9kjbgkv+Cn1YMQRmexSS7Q9oJiNY9YC7SQ0+4hyTeG6TIcCH8HM9qFzBb6gp5E4PlKbgw9BcM9b54M37iIVo/5iiz3HMFRk3a4sSm1QEotYftcuVE5YOLt90cW1ENW/kH+RgfQp6C/8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6rikwHI; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6rikwHI"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-836cda225c1so13706387b3.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 05:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786710895; x=1787315695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rF8VpgzNs+Kxfq0Bsb+d0X9ggbcCKmaK3XI1j39Si0Q=;
        b=H6rikwHIX/Z+TDiJNBqVzFJrTFVGMr19Yy1+IHBuPTnfJfIxUY+ZTNrdmdH0ylIYC9
         YANvAIYSRsezQB219m1kciNquQEy7XZpvh1/CIyzWB4HD7CEtQN/lMvtFh62rkDl9Z2g
         m6t+i178nkW/kg5IDQ5jw5WgR8ZT2r4RDzsN8kAiwjb743J+5W7hexCX3V+NLLQT2QV7
         YGUJPAs+aFmlzHdvAGW9bK+qTuUKmSm0TS0DyRoFhqvvOSWe3s0APX+G8slhrpofEVBj
         RDgit3mi7Ogqzp1BwRZH5RWXsES76KUSY2OEwakp6aYCH+2UgjOziKeYBvVmtXi2EVZ/
         XVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786710895; x=1787315695;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rF8VpgzNs+Kxfq0Bsb+d0X9ggbcCKmaK3XI1j39Si0Q=;
        b=AIxy7419ng232EYUGD8j2JvXd0HIpzPhOCl6I33xIFVpEsWaqu8lVjKHPUqinHRY02
         JaFslDnHwjCUoqbIhb7k6ScT2iMeVimNPoOYtgt4+0fNZKiW+rtfLMfvgcMXOetKBiBc
         p2HX/oBf63J6ZNxpKThoD2vD838ukaUGPDRIZmiKavxtHk3WlTD3yvn13XKhm8XjtR3Q
         Vrw3DFNV9jB8GWXMbWXJJeCrNlcn3i2VM9w4z4KgLRUOcCWZiajf4SOf7BFTEZCuU+Fp
         MToNCKCqaDi12qFQyOTcV0xsTtEBvIBEZz8uhCnLjAOdjA53sJXKtdzHeWnxtT5keAK8
         k4Gg==
X-Gm-Message-State: AOJu0YwzHkN/6FwPRDZncO46nypDeL4aQTKattqizdJs6bJqSHFpvkGz
	MIax9RmEqai+oc6u/L0oxvyQiioDzu5BCGR/adaKbY7Y190l+olER66rDC/X9RHSUEs=
X-Gm-Gg: AR+sD12Wm4lCHdV2hSEj5S3YJXjGF96FFI0dMTXjx2BFmaNNhPA/Kw6zIy3ZHSjnuAr
	xglP8aBOBkM31ONwUdA0+P0DUAvqLN1RDXLYR7dAFhF0pIUalXBjzkEzkLpy6iFPKYGfBzRBBRP
	xgmxSUpGXIn9n7m3KDA46jOhV4HB9pC9oCr4T3JmwtoeW3JJuInzNGfj2KyMeY+vmHtgdbTp27A
	9x23A/n/iEBTF2hDIyXqQecj3LwGEJoBDH0XV5r8h6mTIJUVIjDd5TiRiA/DF3gP7jXFpC9lGzj
	nc7GwGWDP2s8wAheoeMp6Pq884KhczHahltt6aB5mQtfLddqdOZ1/1+f2E/qxcK6YPZS2t3UzmH
	UG5GjXNLCNOyC/2kutwaJFhe4lp1LvWaj24YI1MmBxdpJzN995iQqSk9bdZNjo1IYKxStp3syw1
	ToFrMCQp3qg3Egg2U7E7OFyiRbp64mCmCeQR1xoTkPSGSicruV8UOWdQtjqzmC+94uKzc/hjhis
	KqK3TB2fm4YiEB8XkcY1HvdSNTQSGW/SwPZTGLkRQQh8iQm9NoSMpPJZ25q449vtcfiGe1AcnDJ
	5epyx0QUzww=
X-Received: by 2002:a05:690c:7103:b0:81e:f1e3:52ad with SMTP id 00721157ae682-83712cacf7dmr24610287b3.30.1786710895418;
        Fri, 14 Aug 2026 05:34:55 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c21409eesm12428357b3.33.2026.08.14.05.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:34:55 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/3] meson: expose knob for xmlto relative links in manuals
Date: Fri, 14 Aug 2026 08:34:00 -0400
Message-ID: <d612de6c2de615f368b5985f200c5ea8e3116c08.1786710807.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f.dirty
In-Reply-To: <cover.1786710807.git.ben.knoble@gmail.com>
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1786710807.git.ben.knoble@gmail.com>
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
2.55.0.699.gb54405d56f.dirty

