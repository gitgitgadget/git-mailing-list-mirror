Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E5449B17
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231916; cv=none; b=Bs+b9YFc8Fe88cf2vZn+6I9ujCQ8aGhd6TVRsD59/ib0hasl1hXgSZdsPLbwmdiXHds+cwDMiiV6D/BsGq+hbmk0eAx+55Zz5XrjsOtPO7O6TiAjvPLlDUPUyPl/UoDs+56z/TDLM92XeX5MjVY+OuP9J3OIWAl2w2x0vQFcBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231916; c=relaxed/simple;
	bh=qO3CU+W7z5AIzPx4uaDJ7XBT4wsqKQFTRqorFsMGnVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYYkhvP40KFNNX0CFMDd6imNnG7MqCehQ6GOC3/PwiX1WQZfgBqyCVVkBYxjc/XthTqFEHgUiP3xlhv6tkXR6PoeY91UTyT683iZyONPfu0uMqOGaDGlDXgTos14g01vZrCRbIPfvrfWN/BMi4TOX3bqIXn7wgW8fBQOcYMbnaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2gSR67H; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2gSR67H"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81e6f0b4610so25539277b3.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787231914; x=1787836714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pfWbbitrrFpkECN1lc190K5Biv61gMTnFAHWSnlT+DM=;
        b=H2gSR67HBTXXQ3DQ+5PuLsdho4pyaDIuPcKsjvsOsN9GboFzzyr++mn/wffC5H69Gq
         YNcZwohBL0yljbFnWC5ZBM0vb7oC7SwelcU5woLfJvmxcVLf/P/SVrKAFNsVnSkxkkTI
         KyY56WbI3InnZcz8L1jpkDxyMiCEOn7wSS0Xcxp85FYSBZGCrosmppCZg4jeebtLWbpf
         tb3vatUQiHYVIf2isDsNwxzIk6FSf+nbWX4ailDp/XSzp0hxrpWZELmrobh93wADNG0j
         2osZXqCYDt9zZhg2B13sJ9MV0+2KKHDEtkFG/TE3XDJ1sc2ZPFYLlEQngzqzpTyEAUer
         QAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787231914; x=1787836714;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfWbbitrrFpkECN1lc190K5Biv61gMTnFAHWSnlT+DM=;
        b=E0V1lBXJlsQpfWmJDDaz497/rbHyhREqBn3bPHRtmW7/EYD6k7LH1DVEbUa9XIqf+p
         3nsVW1ke7PMMZUDdMYziTi3Dm4sd7uV2qV8mnN3kiPFCz75272sW7GbcFs9/lCpFfVbQ
         oZ/mPfxVZ9msv2n2caq5t/MH/MuIucqKPWOwk2///wnlfQHokF/Xs7Ti3gnpS8+SdGt+
         3kct9J4Z/R5ogXEQpWdMW6+Bpns9F3yrijXYp86hCV0Ru5AkTt5ATf2u6Mpve0FLGbyy
         VRBlI8R00Rr6kiquxXYfZ8vpqulxBn4b+7f0/JtT83hmn6NahUJlALoCmIIzmj4zysTQ
         25Ew==
X-Gm-Message-State: AFuF++nzBPfGPSUSKvZTLoTdnji2dPlPRTW298mOtxjRZzDaa471ahAZ
	Nw2jAYTXRZRxuBWUQgf94FGYe3nfymtbTbAIFgVYdKao1EuFLLR/Nh1pKvvlDPyI0m0=
X-Gm-Gg: AR+sD13lNBLUEWuHTEosmwsbqicpEqGUo+j5iipzTcFxjVvAq9/3oOP8ERQC9WtllYj
	tmemrCQtYC/kRZUtMtohl6BtOVI4LCu3394bsvHuqPxyHtcIdE//jiEDtaozU8qeFGtAQF7HWVh
	J0nD3hTaiRMOBE7RxMn1WGQq/RSASbHLByxl20aljY3TiXcAujF1KKuX4vGxfVH4xxxdq8bfpGI
	C+CupTF5a40+FeLOEAdtJxrGsNCY1UsYl2rfkpQJw3uBwSrmoSQMs246wXFM5watjbYN5+QPUbC
	NBsdE1x28X30wdD+cg/sTY2WERiIK1iBOh1VPgKVxnNLZ5cyhH7ON3YmpwBFskVogghVK+ha7iJ
	Ain9+Y4CQegN7mNUsLCvRxAgh3gXbac4DaTQRM1iGeqjSHENzwXmEsbUCe+KIgIsjvBvr0rbuy/
	fc5dSt1/Hn0o9Rx+VLXR+xIL0Q/Bb2WZDEcyGqHcmdrH3cglxN63zkTrnkzoF0MROdbHK4izFbS
	fmuBb94O4GxrSmgQRRrjEMiJhi7esbZzXITzlkHZp16cFOmgv1Y9L20zM1BhkhmDQ9ggPM7jGd/
	mN0LJEhq1uE=
X-Received: by 2002:a05:690c:5881:b0:7f5:87d3:c38c with SMTP id 00721157ae682-844e11a53b4mr41625587b3.21.1787231913664;
        Thu, 20 Aug 2026 06:18:33 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-847ccd8b6cbsm8021807b3.27.2026.08.20.06.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 06:18:32 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/3] meson: expose knob for xmlto relative links in manuals
Date: Thu, 20 Aug 2026 09:18:07 -0400
Message-ID: <d612de6c2de615f368b5985f200c5ea8e3116c08.1787231825.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed.dirty
In-Reply-To: <cover.1787231825.git.ben.knoble@gmail.com>
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1787231825.git.ben.knoble@gmail.com>
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

