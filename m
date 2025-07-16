Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C95286D46
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694229; cv=none; b=dcX1Vx90Bax8Ggd0Pc5EigHBxozMDBQmQ8sFAqupnN7uumB9tuiC8VE5I4Sz9EHlLSG7gtNc/1EjsO3OQtbXg9FoehzP34PM/PpN+mjV8iVcSj4F3phg1OvhhqpYgj2zmUvR64wzRd9aV4zXTaC7+Y8FxsBo1Soav7D04qZXwzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694229; c=relaxed/simple;
	bh=6SLThi5O+R0p0ttY2c0PqPdMtipM2GOzbLk9a32ujc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deE8a79deQjneLPLBMSa/KciqZObaG6sEcYqN/UzkCRQneq1KcfErmFkyIkPckdQ2kAKU49yx6NNdwMEO3kvMidw3WzziQJVfEV5iuEXu3lHlxAripr25X1wRitSavHCuT+SVdqsrYm7Je6JS8oiD/Jw1H/a2XaLbm0y/Z+nKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHeDe07p; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHeDe07p"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23636167b30so1711565ad.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752694226; x=1753299026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jkp1USAjU2raH2qOmUh+W+nv+ErV/e31drBOcCcv2wk=;
        b=UHeDe07pr5w6Ii24aA7aIcxQEqLgJhkRHit0zFGnNVLSMqagVUZjq4aY1zLyPRiLKB
         oB72jAiIHwjYIk+Ej8ussGbdBsDTHMAVTwaOS3Pmi7Fr44UsPRY4RCHOcmpGZ9LwM46O
         TPehmaKb0UdnPsarJkkVYdurxgOLKX3HuckJetd+73LpgQDo+iLjky7BqynjHshTUUDB
         AC8PDrOIfXwVgQby6vKEETzpNX+tyZamowYresofG8aIaXkFdMHFBGpFfK3dEFmCBKBD
         POoFqVG8/TOqr6Xham5Dm1ciEFyZJ7ykNJDoIfHMrV9AR6++uc9gqeY53hCaDbLFVfms
         dCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752694226; x=1753299026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkp1USAjU2raH2qOmUh+W+nv+ErV/e31drBOcCcv2wk=;
        b=AuGT965i6PxMm7Zqv+mW7O8V6uNyk8AwY7Jp9iNJnyJQhGaH0lxWXAFzSXmH19FCcV
         eyL6J+B4c4LmA7ITmA2zcjNd8ob0JSJxLaB99Ua1GzQHtjlQlmD79nRRioN3o7I4gM8h
         v9jjsBsqTjsFFeoXSLSaovyM65oeNZOPzP4jZ0ZBcGg/rFf6cX10eMvLxqLuSC094ioH
         sa9Un5Ul10NRJ8DMPPs9EjkI9/tTr+HqCvREvsOhskWH8Td/Ay27d2Ij8NUM5KegeIt6
         pLZTRlVDbG9H3RlHmRm4J8jncMjOXURVRO97qfdB0MxJZqFxfSAGr8LmE16DY1hvd9NQ
         yocQ==
X-Gm-Message-State: AOJu0Yzdc25PWK5XUnYEIesnfnx4XwhPtAILRtSBDGYwCmrgh1KjyRLU
	jxzaF9mHZF5WJgpchaqy27eM0YwTlovuftm4OY8L7o4iDunitMlyCy6Wl9gkkw==
X-Gm-Gg: ASbGncuDqxhwncktp0XXH3ThUmpAwO7QIsFDjXpzcEiaFhzlLniSje6OxHmx8Qn+b9P
	vRyXnrgJyUIImMzJFEGfgu82o6wyUs+ghXOtYJ0inF14N2rY+2yNIJD49ajUUf3zJ0DXK9CV3Mx
	l1gxcFOLXWl73RzPQ9Wia8kUaWrZag3dPOGN9EVfKgLZRTPQiBRokIKVNupMOjMqKLZgcteIPjh
	mHVI7wE1/ITIJnaSm179FecVLRTDeiYbPqy/ffHl3Lwi1dBqTwhva8686uRYTfThTapUbA82X3/
	05JyS1GF4qDKejmk78yIygfX/9hLUErvzfV63pboAG53bkzh4EMmVFQA/NAFgr5zFmfaTEvwilq
	qCc3YZ6fHnCvm6UjqvDk3SCjqoLKV8aSUBM/+8FsxCDA6l2KzVdkJTYcopqIpbkWS97PMab9L
X-Google-Smtp-Source: AGHT+IH13BBmp4TSPkYZCZr7vnBGBFRoQItvlTgIKFiXE/rdlJn8CJFrnf2+UV/X28aqhCTUWgrTcg==
X-Received: by 2002:a17:902:f602:b0:234:d2fb:2d13 with SMTP id d9443c01a7336-23e256c7a2dmr47958035ad.18.1752694226154;
        Wed, 16 Jul 2025 12:30:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322731sm131258465ad.97.2025.07.16.12.30.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Jul 2025 12:30:25 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	sandals@crustytoothpaste.net,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: [PATCH v5] meson: work around broken system PCRE2 dependency in macOS
Date: Wed, 16 Jul 2025 12:30:00 -0700
Message-Id: <20250716193000.44673-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250715114407.37955-1-carenas@gmail.com>
References: <20250715114407.37955-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

macOS provides a PCRE2 library in base that is not usable and not
configured properly, as it installs a pkgconf module that
points to a non-existent pcre2.h header in /usr/local/include.

Detect that case and allow a fallback to a wrapped submodule
if the feature is enabled and that is possible, or print a
warning and disable the feature if the feature was set to "auto",
which is the new default.

To keep consistency with the cmake build system used on Windows,
add a special rule to re-enable the pcre2 feature there.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Suggested-by: Eli Schwartz <eschwartz@gentoo.org>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 meson.build       | 25 ++++++++++++++++++++++++-
 meson_options.txt |  2 +-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 596f5ac711..c77ce82bf2 100644
--- a/meson.build
+++ b/meson.build
@@ -1055,7 +1055,30 @@ else
   build_options_config.set('NO_ICONV', '1')
 endif
 
-pcre2 = dependency('libpcre2-8', required: get_option('pcre2'), default_options: ['default_library=static', 'test=false'])
+# can't use enable_auto_if() because it is only available in meson 1.1
+if host_machine.system() == 'windows' and get_option('pcre2').allowed()
+  pcre2_feature = true
+else
+  pcre2_feature = get_option('pcre2')
+endif
+pcre2 = dependency('libpcre2-8', required: pcre2_feature, default_options: ['default_library=static', 'test=false'])
+if pcre2.found() and pcre2.type_name() != 'internal' and host_machine.system() == 'darwin'
+  # macOS installs a broken system package, double check
+  if not compiler.has_header('pcre2.h', dependencies: pcre2)
+    if pcre2_feature.enabled()
+      # Attempt to fallback, method can't be pkg-config 
+      pcre2 = dependency('libpcre2-8', method: 'builtin', default_options: ['default_library=static', 'test=false'])
+      if not pcre2.found()
+        error('only a broken pcre2 install found and pcre2 is required')
+      endif
+    else
+      # Replace with not-found-dependency
+      pcre2 = dependency('', required: false)
+      warning('broken pcre2 install found, disabling pcre2 feature')
+    endif
+  endif
+endif
+
 if pcre2.found()
   libgit_dependencies += pcre2
   libgit_c_args += '-DUSE_LIBPCRE2'
diff --git a/meson_options.txt b/meson_options.txt
index e7f768df24..1668f260a1 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -45,7 +45,7 @@ option('gitweb', type: 'feature', value: 'auto',
   description: 'Build Git web interface. Requires Perl.')
 option('iconv', type: 'feature', value: 'auto',
   description: 'Support reencoding strings with different encodings.')
-option('pcre2', type: 'feature', value: 'enabled',
+option('pcre2', type: 'feature', value: 'auto',
   description: 'Support Perl-compatible regular expressions in e.g. git-grep(1).')
 option('perl', type: 'feature', value: 'auto',
   description: 'Build tools written in Perl.')
-- 
2.39.5 (Apple Git-154)

