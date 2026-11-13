Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586749;
	b=JBbwEgqvKKc57Rog/k15JRFf6A/VAXUO1t6X3jj9tMKsphoSA2WZDjSPUYj+OBovl2RM
	 0o3MNau8ecpXdw94FUpCZYyRX/JjYMfMyWaAMusdnfb7yz+gj4jPzqD1igcnfA61lO4H8
	 n2z2l2pMZnWWMY3l66GmBxamAA3lJ0y9aWmnUTi2i2aFIMTq15hu9g1QDE293/k0Yc67X
	 s03j30bGR1GLZBUbTQ4xKOfrwMKlG7isWefU+NFxHI6ZryLH993s2cI5sA71ccUZmJXTN
	 pLa8T/0OhULE3oA6AyM7LbmP5K3G34q7cPoSwXCXl/qoXhTOOxYuK9BY7hDsSVi8V8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=EZY+9WsrKcd2iFF6RoyEx9weEs1VrBOmMp5k6S7lWNc=;
	b=1cXUQxnJuJxXrfk+G86QVHajb8WKz010WV712s14G/bEADq0Y5caFoU1bNG/3bPd7wia
	 Exiz5GXCgnaPnCEG/VJn+PO9PDYrme8kTnXmXKB70v3BndZJe1QUVSzUDWOiTKkTI51zH
	 k4svWdNSE8i+7fEatwOPxtVB2F+CdaWjUK5sNGUVcVOyAYpNLcF2bLGfaq88u7/+Pft9n
	 wZa1BsV3Jis2ocaEXZSCVXDRjy8MGqD2l/VU+I+H4mewDBzDgvfE6eEDwStioFh2eMRUG
	 v9D+JWYlkcfumw+9c/cqNnz3yyfw+5G6dcX2TBExdGd4/EebSAxppwcdsIrMdrvUIIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rxf7DyHY;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CAE607CD0F
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 16:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88CAE607CD0F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rxf7DyHY
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso523515b3a.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 08:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794586749; x=1795191549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZY+9WsrKcd2iFF6RoyEx9weEs1VrBOmMp5k6S7lWNc=;
        b=rxf7DyHYPca3vdi2ZAMaNveN3PhXx7jVY9GYxBddHPve7e6daLPmV7/R2cPrnD6jT6
         E3gYD3xyzt8Jpx/qjCqx8032hX4/wW4MX+3FqMqmdhhv/mMD4yADc4eEi1YbpToHFBUw
         DxsBcgoLD1FsOinVAh8xmQX4exCh8coYhL8gghFca9+yJxamQYGoJmCOx3Ipf0/GtWQK
         nuj6sIQ3vq7tPlznRwgO2B2BCt3z4OjvsfENe6VGuBSBKPviYs0N14Hy9oJISlq9Tso/
         aBS2+zwseUPrsU9De3DbZ6xvnTMbl5ZyAKEc1nHX0a95jJyev7yyRw9daS/73dJwoOvP
         RwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794586749; x=1795191549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZY+9WsrKcd2iFF6RoyEx9weEs1VrBOmMp5k6S7lWNc=;
        b=zt3Wo/ct/tcxazpr+3JPw76Jk5MD8DGZssqQ4BRP0FfTleXB9BoU7zxoGvKjEkPykK
         yJjBfg7oY48mrEcwKvgB3C3xG9vcKz0oPp4iYTzC3z2ygjHWWV72v1pz0cbTkLeUmR8V
         +xjQ7JuE4rodKottkPeTuiU1lVdyS6PRROlNB3FvD/X/1ntPlu7Ei/X0GXJ3l/14koPj
         Z9E0Zhoy/gJ/ICdiuXCuJJjtY+7aZjfo9IvtQWEYVAOSVU5LYvlXHRCFVAdPGo2SwFRs
         rQRkpvyb0jsDjI68sj4e1ZsQEU0et/Eyqx+dI28OFmEIaGoj4uF7bGCZN4GL9S4tokGf
         b6SQ==
X-Gm-Message-State: APuU4Z/gOGFcyNIjulfWGvM3CxxGr0q7J81lGMBcOMAx/4ilpjO1zfdJ
	GFDODe1r7cEx/DqnEnTm64LF4F4OBefR+v4hrFh8LgsqV86s/pr8X0IDZDuMqwz7
X-Gm-Gg: AYBFou030MZUVTRKzCzL7lLTqUv0Avhv4/BlHEQbNXSBMqaxj/IFOJstDGfLlzeB7Xl
	y5R7xjM+TNhAfaFZE1i/8o7ScAftLjWwaEX3pdf/fs5/6V/DDto2sQ+qSgwi4GdaLakr6ZP47Ru
	bbYpCqzqMfrnzkq4d5FS8rlXvvufJ6EfrdcfUBU27c97gqsLoYmuxM7hbM8fkgBy0vMOLUG59hX
	RPU5nFRzyS4L/MnsJ4jATYnyUBh7rqlO4XGuZ/B2I5r9EwhSEf8sokVHbG0HkORDCQtcEPdx26B
	Dn7ZAiUQYdMn9jlC8OdppEN/3DTtkdH6QI97uHZ0S7sYjAmZl/4kTgs4FHb9fgMNlx2uMKZOeR0
	7PaFux1U+iJPhGmGgL9pOHdaZaw6TWZPWAWq7OgP13Zwz8zIr8YXt73mn0WICwiI6FPsL3YlV37
	JZEDbCh3TUGe0Ve2rp693q6ys75uukmPBxASKnoJOLa6e4MLZLfQISk2uYx3roePHcYGQZaD3Up
	TUAN+O5fq9XnbJ0bMaSChKy+z/q/04DgH7nIo6Gl4Qyk3VLaq3bcviajvr+o4jC+hmWQo6T0dm4
	mYcYGqZyzGk+JEXY6QEUo3eEOvbprjU=
X-Received: by 2002:a05:6a00:1746:b0:8a3:23c1:c0e3 with SMTP id d2e1a72fcca58-8beb84e28dfmr2871187b3a.59.1794586748757;
        Fri, 13 Nov 2026 08:19:08 -0800 (PST)
Received: from aeron-host ([2401:4900:883d:dce5:aeb5:d73b:40b4:bbdc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8becbad7de3sm1335932b3a.0.2026.11.13.08.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:19:08 -0800 (PST)
From: aeron-gh <agab0323@gmail.com>
To: git@vger.kernel.org
Cc: aeron-gh <agab0323@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [PATCH] for-each-ref: avoid segfault on --no-format
Date: Fri, 13 Nov 2026 21:44:10 +0530
Message-ID: <20261113161413.15688-1-agab0323@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "--format" option is declared with OPT_STRING(), so the
parse-options machinery also accepts "--no-format" and sets the
format string to NULL. The default format is assigned before the
command line is parsed, so nothing puts it back, and the NULL is
dereferenced in verify_ref_format():

    $ git for-each-ref --no-format
    Segmentation fault

"git refs list" shares the code and crashes the same way. The
problem dates back to c3428da87f (Make builtin-for-each-ref.c use
parse-opts., 2007-10-13).

"git branch" and "git tag" have the same option and fall back to
their default format when it is NULL. Do the same here, and assign
the default after parsing the command line when no format is left.
"--no-format" then cancels an earlier "--format" and gives the
default output.

Marking the option with PARSE_OPT_NONEG would also stop the crash,
but then "--no-format" would work for "git branch" and "git tag"
and be an error here.

Signed-off-by: aeron-gh <agab0323@gmail.com>
---
 builtin/for-each-ref.c  | 4 ++--
 t/for-each-ref-tests.sh | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 4a2fc421db..4390f3f5e9 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -52,14 +52,14 @@ int for_each_ref_core(int argc, const char **argv, const char *prefix, struct re
 		OPT_END(),
 	};
 
-	format.format = "%(objectname) %(objecttype)\t%(refname)";
-
 	repo_config(repo, git_default_config, NULL);
 
 	/* Set default (refname) sorting */
 	string_list_append(&sorting_options, "refname");
 
 	parse_options(argc, argv, prefix, opts, usage, 0);
+	if (!format.format)
+		format.format = "%(objectname) %(objecttype)\t%(refname)";
 	if (format.array_opts.max_count < 0) {
 		error("invalid --count argument: `%d'", format.array_opts.max_count);
 		usage_with_options(usage, opts);
diff --git a/t/for-each-ref-tests.sh b/t/for-each-ref-tests.sh
index 4991a82b91..3e0108a7db 100644
--- a/t/for-each-ref-tests.sh
+++ b/t/for-each-ref-tests.sh
@@ -285,6 +285,12 @@ test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail ${git_for_each_ref} --format="%(INVALID)" refs/heads
 '
 
+test_expect_success '--no-format restores the default format' '
+	${git_for_each_ref} refs/heads >expect &&
+	${git_for_each_ref} --format="%(refname)" --no-format refs/heads >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
 	${git_for_each_ref} --format="%(authordate)" refs/heads &&
 	${git_for_each_ref} --format="%(authordate:default) %(authordate)" refs/heads &&
-- 
2.56.0

