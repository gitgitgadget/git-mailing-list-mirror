Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA11221B9C0
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770673877; cv=none; b=aq8o+XQ88OICEH/JgbGQnl75Pxn33gp946SLYaPsGlCU3q6SSJB/KgPBo3CM5dCbqjdnUw5Q4HDEIdzaAZeBoTUibl0k4Ciz9czs5XpoKNdNgLSc2YFNJqwXxuKzFJ1sJdUhkvFPN8mxHOqcNJO31DNzFIE3cBOFEJnzoLHJ8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770673877; c=relaxed/simple;
	bh=gj078jq0vWGO2ag9KAn50jvBmwnjpvqh7s9gmB4tzoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4IwfMXXXJxfeWrVyimPMXuNgLmJW90KVfL7bocpfMdRng5mfNxDylGs9iHPRgayHEQ8UipKfOtfPv0fkuTJlGIkrAoNsXzWlmRP3PARsAzhvMDQviKrLqoHvCz/Id7JfpUm2NzhZqiq3RyNojYB8Ugxx5EcVAIJYLgmVHXIP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzH/bQcK; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzH/bQcK"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-64ad019bb5eso3195965d50.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 13:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770673875; x=1771278675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T90Uc+Iex9Dwz4pi3fr6wE+otLtnEvZ96eZ2prVlWrY=;
        b=fzH/bQcKwiyMC19cjtTkL2nnwCB041ZlGdq5+CZiXqVj4fTXkZwgpvD3kv9iTbjdZV
         pQEtM3+m+TZnDt5wYaVtDftXHzG5YocMdb3ZzL03mjUKTWJ5cKI1v0y/902PwJnZb8CL
         73PnHxqCIW7FtXh0+q66pciL69uVju49rCc/ZodlZhrrDqtr8U++zUTSiKg6tkbeh/hd
         jekJh77WOk9sZJ8Ep3KvYcKZc3PCbh2Xp7SM5U+qwHcWPRXtgcL0rRlAnEXMMqRRQzI1
         L85RtkSY2Quoc5pTRLzHuCCYPNaXYZ7ql1fCpvHoAjHcFi8tw0TrRr7rPB8g6PxzTWyV
         2hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770673875; x=1771278675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T90Uc+Iex9Dwz4pi3fr6wE+otLtnEvZ96eZ2prVlWrY=;
        b=hzcIyiFIRHvhkDZEhZJfzck+/q9AfwgyU9MXeVgxEVlJuCKX6kVhmkQCmKFiL8mbAe
         kO8zTH4t6i8s/TikFVx6K0vOJ/XBLry9S8yNxYYXj78gG1M0wPA2SYQgUoJ/wz/HvXcH
         cb02srKW9Zofdh0mR6nRpVv3iCnM3Ti5jFIQG1VebHc2eT9wCDRSlsztFKhT6N0yxveW
         DhiuQZSnaqK9Pdc+sOcWFHNABKf/tFczp1vqneioEEEsw/ayYsaJbPU239hUxQS9VuDf
         rfIXBTsK0aL1AdSr5V6JJrlLAtlXJFPv3yL5tTQLtNjHMJFUWpy2C+e7rpGspUY/CIzE
         KGMw==
X-Gm-Message-State: AOJu0YzEnDjX1Q0K+fjUDIoSs63gibiuwA86vGa7P3r2z7p+3NCpGM5G
	QlmEupWNctnkkEu0nDKOEbphrI+ekUmJsBKtLA8vc3Y+4iMaDiq/sqgfQvJjjsyM
X-Gm-Gg: AZuq6aIzOqbWv30D8yCBmtxDnW2E/hq+LXgFBEl6bX0/5VES80PKEY3PLq+rg3/vSWb
	i8So8gXUHLz4agsDBRbpIG2iWR1uP7HfFEKH59gEg1QevwAbokg4Ponp2CYKJ5ydTR9xqACcr7a
	lfqcLT4J235M5JDkRDeeB3oVRJU3X9LfKTCKzsT2zv2vTib/+SxwqIGZrW8/R4dWlzCeQ64Bejq
	MRWyOQ99SDwB+U8iej/nrb2ijcrdeIJQSFMjX9s2IpgGdp79zSzu5nZr4WZFRQ0NUt8Z9dHkAxf
	22bf8DaXAlSzKEqW4EJnWlWlH8hVmn9KLZ+XBf2QTfGOAi9jYAN/Y6LxHabKtAOpP4n7nCSBSPt
	c7q9Hcj1nHc6OW3qyRmjBorpx/7s9a2AV9xZrn0JU60KVREw3D73lyN7N6PlYkQBzo0r/vBRAz2
	lUWp7O5rbXWDQHyfpui6yPGj9lxd8jxEXQMaMtP/1frQa8YSDz3p/tIMW57deIj8I4owwrwLOGJ
	5WSIevsYYl2gwo=
X-Received: by 2002:a05:690e:1502:b0:649:b4cd:b53e with SMTP id 956f58d0204a3-64af211bd9bmr52874d50.41.1770673874441;
        Mon, 09 Feb 2026 13:51:14 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90eb:5600::9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7964e371479sm28110187b3.15.2026.02.09.13.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 13:51:14 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Martin <evan.martin@gmail.com>
Subject: Re: [PATCH] meson: regenerate config-list.h when Documentation changes
Date: Mon,  9 Feb 2026 16:50:06 -0500
Message-ID: <20260209215015.25867-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.1018.g3ad6585c12.dirty
In-Reply-To: <aYn8XKv2hH2HX2xO@pks.im>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Patrick,

> On Sat, Feb 07, 2026 at 04:59:17PM -0500, D. Ben Knoble wrote:
> > The Meson-based build doesn't know when to rebuild config-list.h, so the
> > header is sometimes stale.
> >
> > For example, an old build directory might have config-list.h from before
> > 4173df5187 (submodule: introduce extensions.submodulePathConfig,
> > 2026-01-12), which added submodule.<name>.gitdir to the list. Without
> > it, t9902-completion.sh fails. Regenerating the config-list.h artifact
> > from sources fixes the artifact and the test.
> >
> > Teach the meson build to depend on the Documentation files that
> > generate-configlist.sh reads by having it use the output of
> > generate-configlist-deps.sh as a list of dependency files, since Meson
> > does not have (or want) builtin support for globbing like Make.
> >
> > Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> > ---
> >
> > Notes (benknoble/commits):
> >     I considered having generate-configlist.sh write its own dependency
> >     list, which Meson also supports… idk though. Input welcome :)
>
> I think that would actually be the better approach, also because the
> list of files with `run_command()` would only be computed at setup time.

Oh, interesting. I didn't consider that, but it seems that adding a new file
doesn't cause the dependency list to get updated in my version. Good catch

> I guess it could look something like the below patch -- please feel free
> to reuse it at will.
>
> Thanks!
>
> Patrick

[snip patch]

I've applied this locally as so (tinkering since I saw the same symptoms below
with your version):

---- 8< ----
diff --git c/generate-configlist.sh w/generate-configlist.sh
index 75c39ade20..2c93ffc58a 100755
--- c/generate-configlist.sh
+++ w/generate-configlist.sh
@@ -2,10 +2,11 @@
 
 SOURCE_DIR="$1"
 OUTPUT="$2"
+DEPFILE="$3"
 
 if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
 then
-	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
+	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT> [<DEPFILE>]"
 	exit 1
 fi
 
@@ -36,3 +37,9 @@ print_config_list () {
 	echo
 	print_config_list
 } >"$OUTPUT"
+
+if test -n "$DEPFILE"
+then
+	printf "$OUTPUT: %s\n" "$SOURCE_DIR"/Documentation/*config.adoc \
+	    "$SOURCE_DIR"/Documentation/config/*.adoc >"$DEPFILE"
+fi
diff --git c/meson.build w/meson.build
index 3a1d12caa4..fb5d7367f5 100644
--- c/meson.build
+++ w/meson.build
@@ -720,11 +720,13 @@ endif
 
 builtin_sources += custom_target(
   output: 'config-list.h',
+  depfile: 'config-list.h.d',
   command: [
     shell,
-    meson.current_source_dir() + '/generate-configlist.sh',
+    meson.current_source_dir() / 'generate-configlist.sh',
     meson.current_source_dir(),
     '@OUTPUT@',
+    '@DEPFILE@',
   ],
   env: script_environment,
 )
---- 8< ----

Only, things are behaving oddly. For example:

    λ meson setup build2
    λ ninja -C build2

works fine, but

    λ ls -l build2/config*
    -rw-r--r-- 1 benknoble benknoble 17169  9 févr. 16:39 build2/config-list.h

I don't see the dependency file. Further, re-building seems to get stuck (I get
similar symptoms if I add or remove a relevant config.adoc file, but let's keep
it simple for now):

    λ ninja -C build2
    ninja: Entering directory `build2'
    [1/28] Generating GIT-VERSION-FILE with a custom command (wrapped by meson to set env)

Of course, if I invoke the command myself, I can fix the build:

    λ grep generate-config build2/build.ninja
     COMMAND = /usr/bin/sh /home/benknoble/code/git/generate-configlist.sh /home/benknoble/code/git config-list.h config-list.h.d
    λ (cd build2 && ../generate-configlist.sh .. config-list.h config-list.h.d)
    λ ninja -C build2
    ninja: Entering directory `build2'
    [7/7] Linking target git-upload-pack

but I certainly wouldn't have expected to have to do that!

Interestingly, after the "setup" step, build2/meson-info/intro-targets.json has
this block

  {
    "name": "config-list.h",
    "id": "config-list.h@cus",
    "type": "custom",
    "defined_in": "/home/benknoble/code/git/meson.build",
    "filename": [
      "/home/benknoble/code/git/build2/config-list.h"
    ],
    "build_by_default": false,
    "target_sources": [
      {
        "language": "unknown",
        "compiler": [
          "/usr/bin/sh",
          "/home/benknoble/code/git/generate-configlist.sh",
          "/home/benknoble/code/git",
          "@OUTPUT@",
          "@DEPFILE@"
        ],
        "parameters": [],
        "sources": [],
        "generated_sources": []
      }
    ],
    "extra_files": [],
    "subproject": null,
    "dependencies": [],
    "depends": [],
    "installed": false
  },

which doesn't mention the .d file anywhere. The _only_ reference to it is
build2/build.ninja. This doesn't change (nor are there more references to the
generate-config script) that I can find inside build2/ after any of these steps,
which is odd.

I can't think of any good next debugging steps, so I'm open to ideas on this
oddity.
