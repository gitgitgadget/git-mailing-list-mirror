Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213915;
	b=wAzKJip3akTspGmuSxlHKnAncBu25oOzdmdZn2Xs5ICx2o5NtpHrP3IXghc+rRZTpkl7
	 IcmrECg7dMuKF+QcZTPAQVLwTSI1/84rDOCG8lqbfRvl8lAnlAHj5midR2Oxkfg9i7FKO
	 Gl5FxM0XpYPt2tf8UrQnv3nsoODqPuGSoj8sclrTTOd2k/ddpE0Z3mLByyIUE60GxYaXJ
	 4cSoqU2neXNnpv4OZ7nR539zXUHiIsI+7n3riP8Eo8EQ6zvgZazUEvHyRcU7y7K+V4cbT
	 zNDdHrkRU09TTh5nRIIuQqdPXx6ddz93ep4IPMlj+M1sb/Jt3L3IbhDDmWhyQPKy19A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eZRefbLEKwWVgCOzhOrkKX5EHcluRJM+5Z1BmZjEZgA=;
	b=Vf0t76MTW12eTOTjqOQMFi9T1XSnTa9Wh+pm/rED5q6858azym59PDm+kpHPaormubIa
	 n2ob0VZAfzvA54ciEZkTWUjKGi+D82nghq6kMwFjJ3JqDh5wmTf0mjhStYB7XUVtmYTcm
	 fwbb2xjaVcDDfpjdFE+ZgWuMc3o+vGSJff+dYa55rSQNTpv1+SKE1ZgS9/aG6jMZDL+Qx
	 3h8XES6+RoKVZuK6HN5GR4qe+laJejNcSR0nQCLk2rku7zgmY+gVtaQrU60Tn8hkDZ8oh
	 08Iy9Fe8PIi7RnADsAk4HnTQi8GHBZXAKzw6UL98ahuDj4v0gUfzCqsYSAFmlvN7rzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MdmjVA5Z;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2740F606D813
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2740F606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MdmjVA5Z
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dee593f18so305577f8f.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 00:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794213913; x=1794818713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZRefbLEKwWVgCOzhOrkKX5EHcluRJM+5Z1BmZjEZgA=;
        b=MdmjVA5Z8OQaijJqGboHCQ6A9z/vaxrK1hcKdzoLfri0ernLTzUYykBsHIZeLIZ9Ux
         pU20MZWYSlaVXANT5ogpnXmrdSnnfE8r/aNaTKwWSO8GZtIbmswWXjD7LQ3NrQHnKgOo
         V6WehapIkr+NYDd+qYQeUNbxHC8CxuX8a3n6+ePHSl/FfSLV3wgEaZZ2kTZtcT5TPuGM
         1klJ/3llFk3VV6ULF9z1doC6Il1+1b1PyHGAeQlwebpRvMjE4IDDO/eW8+Toiy3LhmCr
         mWp9WkReBEOeFtnFwG3A0WLJQsb1gzTaO6WCfa4EOwr63MnNrRjxGe0sYGrPsXwFzOyg
         4UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794213913; x=1794818713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eZRefbLEKwWVgCOzhOrkKX5EHcluRJM+5Z1BmZjEZgA=;
        b=C30G6JPPxbdDGhQ+cIbHJ82MIFRGtRvrXbW/nolQH/dmMTGcEnlGXbZZjk820Px9gR
         mmRUg8+oQZSvOGRND87cxWA+O8pWrXfH9LnsBfs8kEhfjrbT8vTccQjEouPcMH33lpBu
         omHxxH1oHWJwUYHTAA3uoP+bqPQSSsgluH42YyCA5X86qKoU8mZyDwSF9HPmCw+YtwXn
         GJNoLYRGsgwHKbsiTEWrQPUz3oGyQJ8VpVxXnxqQKZB+gB4XMumFv7VzWjLy5e+QgMTl
         re0ixJGKye0qx+2A7RPjLO2wgnwqXk6t+fPDhBQDRiRSo09Gf/fHatJmN77qQObhRhU2
         uhSQ==
X-Gm-Message-State: APuU4Z88K/kaP7bgNAXodHGF7ZZHLMHzvPDIly5ARnD+JF7EaQwe7fE5
	lm11ueY1kZ9P321bwFr+Zmb+yfQ2t98cOrmV6Ddikr7uaqXJENWZqEBdjDeGH/g=
X-Gm-Gg: AYBFou1XQTLj5yZDIitfVKAdBzzw9EuZr7zBACMfOfHz7Y/pr/SrO5osJdjTQxJN+46
	cKv9i9M0tYq1MPmaJP3tBJ2n0G2DkbaaX5mFtWc9/h+HUt2zmkXLd/CIG5vc9lDpY4s1uiofOLn
	3GmAxfJ9FTJGCE9nkC2KWbqp+nYvBTgUhZPJagpCulP28Ixhwj6gr6tCRFpzEabaRWKvdCUF+eO
	8Uxg059YykYTb27OR5+0enfBmrGBZg0pK4nmEj9GPheR1/y4dYFJyEZr/Ee6fos18XiQg55nLR8
	VUcV4iUV0a6ub9Pia1YR0hHQp86ZIziM/nd0xq4YKKZVpf0RkVtwH9RBDSh37JLG4q35TOCz253
	A26ABwcd8l9lS7qrwpy1jTOmRAL5BLJpDimxS0PhlnwEhTmVD6FnDndtiCWAW3zfJ4go/nXkj7N
	HWgjvWOEav6c3QMbGPD4Yw+8n5EhPLBlPYJHt0jAsz8B4rXvhNxGosA5YYh/VvJ2ofwRfVrowC7
	0mnk54z2myc1O4dfuNgkb2FswHx1omo4ulqePQ6BpXTCL2tSCniBiu2Bk40VDsIzvvPh67AEBeP
	5SmsjdT7K50rbjMzlIzSalofbMKBgzkkSDoYOxRxLDlJGJhyOrvDwEyJtaYDXtKZFTHyactZCZY
	gzlZjHokTUeXbH6+ZaMiAuN6pXXC7xX7FLMOqrQk0qja8ACuk8BB/lRiNo+lSnaChoqhCU7ED
X-Received: by 2002:a05:6000:2c03:b0:48e:6419:ddf2 with SMTP id ffacd0b85a97d-4958a016007mr6935648f8f.17.1794213913528;
        Mon, 09 Nov 2026 00:45:13 -0800 (PST)
Received: from DESKTOP-453HKQ1.localdomain ([102.22.168.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959011c995sm8555853f8f.0.2026.11.09.00.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:45:13 -0800 (PST)
From: bonheurngezayo4@gmail.com
To: git@vger.kernel.org
Cc: Ngezayo Bonheur <bonheurngezayo4@gmail.com>
Subject: [Outreachy PATCH] parse-options: convert check-ref-format
Date: Mon,  9 Nov 2026 10:44:55 +0200
Message-ID: <20261109084455.16915-1-bonheurngezayo4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109081244.16734-1-bonheurngezayo4@gmail.com>
References: <20261109081244.16734-1-bonheurngezayo4@gmail.com>
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

From: Ngezayo Bonheur <bonheurngezayo4@gmail.com>

Signed-off-by: Ngezayo Bonheur <bonheurngezayo4@gmail.com>
---
 builtin/check-ref-format.c | 45 ++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index fd1c9c0e0c..a7ad3c8257 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -8,11 +8,18 @@
 #include "refs.h"
 #include "setup.h"
 #include "strbuf.h"
+#include "parse-options.h"
 
 static const char builtin_check_ref_format_usage[] =
 "git check-ref-format [--normalize] [<options>] <refname>\n"
 "   or: git check-ref-format --branch <branchname-shorthand>";
 
+static const char * const builtin_check_ref_format_usage_options[] = {
+	"git check-ref-format [--normalize] [<options>] <refname>",
+	"git check-ref-format --branch <branchname-shorthand>",
+	NULL
+};
+
 /*
  * Return a copy of refname but with leading slashes removed and runs
  * of adjacent slashes replaced with single slashes.
@@ -58,12 +65,24 @@ int cmd_check_ref_format(int argc,
 			 const char *prefix,
 			 struct repository *repo UNUSED)
 {
-	int i;
 	int normalize = 0;
 	int flags = 0;
 	const char *refname;
 	char *to_free = NULL;
 	int ret = 1;
+	struct option options[] = {
+		OPT_BOOL_F(0, "normalize", &normalize,
+			   N_("normalize refname"), PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "print", &normalize,
+			   N_("synonym for --normalize"), PARSE_OPT_NONEG),
+		OPT_BIT(0, "allow-onelevel", &flags,
+			N_("allow a one-level refname"),
+			REFNAME_ALLOW_ONELEVEL),
+		OPT_BIT_F(0, "refspec-pattern", &flags,
+			  N_("allow a refspec pattern"),
+			  REFNAME_REFSPEC_PATTERN, PARSE_OPT_NONEG),
+		OPT_END()
+	};
 
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
@@ -73,22 +92,16 @@ int cmd_check_ref_format(int argc,
 	if (argc == 3 && !strcmp(argv[1], "--branch"))
 		return check_ref_format_branch(argv[2]);
 
-	for (i = 1; i < argc && argv[i][0] == '-'; i++) {
-		if (!strcmp(argv[i], "--normalize") || !strcmp(argv[i], "--print"))
-			normalize = 1;
-		else if (!strcmp(argv[i], "--allow-onelevel"))
-			flags |= REFNAME_ALLOW_ONELEVEL;
-		else if (!strcmp(argv[i], "--no-allow-onelevel"))
-			flags &= ~REFNAME_ALLOW_ONELEVEL;
-		else if (!strcmp(argv[i], "--refspec-pattern"))
-			flags |= REFNAME_REFSPEC_PATTERN;
-		else
-			usage(builtin_check_ref_format_usage);
-	}
-	if (! (i == argc - 1))
-		usage(builtin_check_ref_format_usage);
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_check_ref_format_usage_options,
+			     PARSE_OPT_STOP_AT_NON_OPTION |
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc != 1)
+		usage_with_options(builtin_check_ref_format_usage_options,
+				   options);
 
-	refname = argv[i];
+	refname = argv[0];
 	if (normalize)
 		refname = to_free = collapse_slashes(refname);
 	if (check_refname_format(refname, flags))
-- 
2.43.0

