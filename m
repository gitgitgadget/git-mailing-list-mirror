Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B613D53C
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788010718; cv=none; b=tJoy42Hn/gwgV2Pmu+9c4/4DeoQSPkxkQ4CxkxTXZW22/vE6mgNkGzokTC53FXMuECiYY4RsFnBTJUUjHIMkXF7kuijc68Ykl6w/2MRJp0/G2qdJpdWSs6epRb5Rgz5w91IOWA2zDwWvz8OkBIsooMH+jdJtNZEt3dqPBkfZrpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788010718; c=relaxed/simple;
	bh=qO3CU+W7z5AIzPx4uaDJ7XBT4wsqKQFTRqorFsMGnVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jh9p6ycWryx5T5qsnr5mqQEbzhslJrCNZVEEvIDsUc6FnB7pIlpmJTg4CUcoaCSEEtkjmcWcS6PBdq66eES/d++NzEIL0tF7AmGTEUojl9/dhKZO/l1BKPv0knClEv7y9Yhp9X4Jkz0XPNwPl8FOrow5ywFI9CBaZKd8MVbd3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFrxvNh/; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFrxvNh/"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-857ff9fef54so22780137b3.1
        for <git@vger.kernel.org>; Sat, 29 Aug 2026 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788010716; x=1788615516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pfWbbitrrFpkECN1lc190K5Biv61gMTnFAHWSnlT+DM=;
        b=NFrxvNh/8Y0Rc3vuEcluFysreUMBeOfK2dZNdWe50Lz9okZUpyVrTztkZ1uhMb6m9o
         PjKpLyy1886Y2/n/B19P+sJTfIqzimnW1ldOX0iL4iCrjTtTpQWm/xxLQQG58qG3N7sd
         jg4/93Kj2x+xLD2a1LqAW0hcBICudX0VvVNdeHU3ow0bEr7ZaO/nUJcY2/qzd4pNJvsZ
         16D7xCAxbpN4aUZgvSz+bAFLWvftTDAIjIxMGqcttexRWZs80g9RJ4U8kGTAtcYzf7xh
         lf4DTOaOwjh5qw858ERC2HMaaM67zKCHqAmMFlPDeA9cLDdo688YDeQSH/m/9yj25jxn
         qmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788010716; x=1788615516;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfWbbitrrFpkECN1lc190K5Biv61gMTnFAHWSnlT+DM=;
        b=kCF+Ez+7RZ+ojUJNtsYwq/vwUfUe8heWIQur73KSqFKzaGuQYSUkKIogmoinhzS1pu
         9417Si+u3mcCjZFqLmhBtrt39soibePPTly31gE31HbJAnZhCou2omjMrNL8gymlnN7A
         EhiyXCcDWwamdsP/GBcHAefU47YGG4WY4Y8f1jpZENW4VbCY1qHnh6CoYFfYg9hcRz7g
         Btt1+k2tpII3jz1IhvGvPGs9HHPzN5eqNZ76V96P92pABxMRnIjMVpMQRO5vwxm+hS35
         CaU/8hDnk2DT98OevBGNzrc2vu/Tw6+X6Lq2kBM3vfgQonzIgjN9ddml+SrTEY+TCJhM
         RVRA==
X-Gm-Message-State: AFuF++kq9lEd6zX27sFM8WMP1Vi+vezS2ljGYuxZyJhXyNT9KX8GItZi
	hXYnZ/7p3lHpZ/ocvPYYZEc9tQ+tCbABzNr4l9/7V8LJob+PsnGKQU3bv/Yq99dr
X-Gm-Gg: AYBFou1JttJ7Iay4VwSUztDX/3uwkR52MmhBS6zx0jLdaJo6pHWbACEwH0YHOT9axbz
	hJStVCH81tZGYFjI9y2/AHyS8FiWN/SkGoaH+519Kkw0Mk31yxNhhWPvMwP+UOsxoQcj7Ng3wIC
	c3AqDAGbiBS7750GoAcy/7Ao6g6V1U7rTW81uVZ+Jh8zc6hV8tcDXVBatgkUHkpeGTomAPOVfY6
	4BzQe3I84hl8ucyFuREMzt38kNdoKpdeiQaLW+ZkYhos3JoZFJfPgQy1tJqMZogp8BB9ZInf4fR
	SqriphA2wECqWTEFTYXPbLfIti+GiXWRDg8ouIGqJUceOoZchV317PU/a45BIpx9NmqAQAM48WD
	P5bVMC1XERoHuvHlQNIdo7GOz+dbZE96I5oxUKkfL+4g2FMnYG7M//vtdYbZUF3S38Vc/BCkC9w
	HgrMYLJeGYCH41VZXNay7TSkUDXqQP/AJbJKsGEGGO4/p60TZx7PJaNB2m38IKdD5M4oeaGJqve
	W8HlZ+giJMnQS4Vmsr4s0BATzP6s+IOCICeTv01VEILsroKRayOwKemEvyURe2BMeICxdpGXrGT
	KR24ApuUjVM=
X-Received: by 2002:a05:690c:e159:20b0:855:37f6:a73f with SMTP id 00721157ae682-85d69f00d89mr44210897b3.13.1788010715647;
        Sat, 29 Aug 2026 06:38:35 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e66abaf31sm21364557b3.35.2026.08.29.06.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 06:38:35 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 1/3] meson: expose knob for xmlto relative links in manuals
Date: Sat, 29 Aug 2026 09:38:18 -0400
Message-ID: <d612de6c2de615f368b5985f200c5ea8e3116c08.1788010335.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed.dirty
In-Reply-To: <cover.1788010335.git.ben.knoble@gmail.com>
References: <cover.1787231825.git.ben.knoble@gmail.com> <cover.1788010335.git.ben.knoble@gmail.com>
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

