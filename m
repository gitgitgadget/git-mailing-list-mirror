Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9612874E6
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206524; cv=none; b=Uw9hnbj8H93jnhWM3QnrtuBSktIEUH7/GFPjTLXUtiYxl2wj7ZVopC3lilqpa5tZcbeoWhyqru+98I1A2o8AeEbJpETjDhizOD4OzseS8dWfLa7/6kMKSVGq3GUz99SM9xGCyQ79QLM5R2/nFmdlSJUNFv1b5jDgv1FiJZ2ycjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206524; c=relaxed/simple;
	bh=qO3CU+W7z5AIzPx4uaDJ7XBT4wsqKQFTRqorFsMGnVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzokUIYrSaiFvAxubP5QrdEP+nkMLS8wNY78pRsurftY3imk0nJZXrJy8jPjKYw10A+84hSen/nhLs1Ydk1m5Dy2hFu9rjrDQo1dZols7RHdwogybThJKIoDfGve1HmgIkeZU/FautuwgsC9Cb6ZVO/RrzHCYLVUbFH5fFt0H84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRO4O/TY; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRO4O/TY"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-86162c086f8so5366957b3.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788206522; x=1788811322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pfWbbitrrFpkECN1lc190K5Biv61gMTnFAHWSnlT+DM=;
        b=oRO4O/TYr3LIBknXq3bN23sN28DJKZcShcrP30kuWUMjFqPr2p4LNgZGX2Vv5e0O8/
         ktXzgMQjF0O28FgfUbeE7nRns05ciM5VBz6M8SCsb8kx/Zsxi/ZyIQ6X0FRUKmncI4Fa
         Rqb7L3+gAYnDNATW5fN9c7vq0nuGFefhPCXIQwvSRnkC1h21eTzNpB//bItV27a7rV3J
         EQv8A5+sLNucm0Yzhz1wjs3BMFojlNaL8BIOOwhSkfbPicJqpkJWuEWoXflOGHjtkhWo
         QyZnK92MumY0G5yy5YvvC/k9Pm6pyGavqbYIJKIWfwDsC+JlXNpo9yIxynMs0E6oED0H
         x/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788206522; x=1788811322;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfWbbitrrFpkECN1lc190K5Biv61gMTnFAHWSnlT+DM=;
        b=MH6cgv/I52niG8cAQQ3fqt2X+/PtACGBsuGyPblHuxg0n0jYGeQV+OSzO0VzIRAOH/
         dVTE7OlHpJ6EVJuT7Y33e1F0iGNepWY/Q3EZZ2veBXuURDbd+vSd04gJbNma2zYmbkhC
         kxkqXZ6LFT8qlS+ZKr20VI4vEjlUCCcdddlrWkfMOQo7lka1fldhidbRNbgPAOGNUxfP
         5UP1udGJqc7NIjKAf5YVW54HEof0eam2VXFJMaP+Em4Q0KCocy0iP2CxDB603Wr1UBuy
         ROxs40KxSb8bbXvSTN6e6bIIxMlj5iL/EULf+cXzFEVSBxp+byNzQgrBtmR0zv5ncia9
         fI/Q==
X-Gm-Message-State: AFuF++lCd4WRcVH+mnq1uwG/tShHESB4pyPmrhgy6zpLdukzv4IdKq/X
	99ZzW+aZqDkqGFcq1e1xhKZb1FyriqdnxPdpyQWbxP8dp4tgzIA0mcd3xkPgB5nm
X-Gm-Gg: AYBFou2ZE+DNbmpLVDGWzbK4t/xjB03EzGe+uwiI7biUVxmG+bBcnxEzNWb55zIIT0+
	PSejHei44bXQuXVWKh/rPPv3NVmgR31SrLigJz8sdmaOJdmFNRw3Er+mVVutSjHusRjshtMdrfT
	9GdZlqD2lItkHUYQ1j0tdU8ta2zhyGaH0M5SrEwE5qPgGlBMb2EJa3opqs3du1eqKRI84XSUsQA
	7k9jfTcWKKKZIfdKspi/jo2hIIrHTQAUs+KUequMDj7bqATVt2Vks7e6Y1LSzEgXTdSUwKjw/3t
	20okLytvYLxKnQ1i2cVDtmJg99g5gc7871HhaP0nC4zxZ049Ve/G82R/n+z8IruhbxR28rfLZM7
	FOEn38myfCkvvh3BO/WbiUB/FGZiQljwwrVVFwCeEIQTXcxIencgttSF0OQEfLzR0Uitc86zUDH
	D+mW8nyRQcZzWnJHmvqRpbtJHmZwQkAGsjMyH185pIwhNJ2QWInEbQsjPfbVZ/mEzKP8ZFQ4KLr
	c7O/N6l77uYir1bJAlLIl9+Z9V4R6Tv3NrnWxgr0ZKTE0iFo6yLhfOP4XlhujeDePLMzgROXCkB
	MXpsw/G7oxuOMi1csne36w==
X-Received: by 2002:a05:690c:e3e2:b0:854:1511:d9a4 with SMTP id 00721157ae682-86949e53dd3mr3151027b3.5.1788206521928;
        Mon, 31 Aug 2026 13:02:01 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5ed1e4fcsm60286997b3.18.2026.08.31.13.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 13:02:01 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 1/3] meson: expose knob for xmlto relative links in manuals
Date: Mon, 31 Aug 2026 16:01:35 -0400
Message-ID: <d612de6c2de615f368b5985f200c5ea8e3116c08.1788206466.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed.dirty
In-Reply-To: <cover.1788206466.git.ben.knoble@gmail.com>
References: <cover.1787231825.git.ben.knoble@gmail.com> <cover.1788206466.git.ben.knoble@gmail.com>
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

