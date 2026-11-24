Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543561;
	b=19UTJ/4WdTfL1aDpNySCoQdXer1/e6NFGfA8fDqw2CvcKRPzr1ZD73Gt/1NyrpHtD7SM
	 7tU3Ukvd59c7OzLUSSbv/XADGBNxlI7QlihlIB9tdLLinxUYMCu9pgJ/eK3km/VSJQ7lB
	 p4y2zghqMwBjF5YDao/hYgUheBypuVXOizK8OFqYpJiaujn0uKh1D2ovIMq9l0AixIDNO
	 yY1X8oU0AtaFCiQ2+vDX5ZOez48LiRVHwb1tayuu0kM+uM9TLij/s2WdxYXglJwUsmrTt
	 3WB5AjYdkAKapyJgNrCHHzbr8RSt4EKP0rdunCAlH5F1ywGod8XmsNo48a4dyH3fgYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=9Z35jXvciXrurj3K6EI8MVj4sAFvISgfO7AYIfJtaq4=;
	b=BfUaXj1LlLdxYetGFB9l65vaMQdLN7WniJ4D13Lyu9L+/PpN9Jm6P1IWyADSjT/OmznB
	 udc9O+VNpxTzqXQd6Dh703qKyc95ugpmPdS93+9n4ILLPs5ibt3VnydD3Sssr1OIeV3lb
	 k+wc+SOvFDBtpNLWWFb8YhLPpQ9XwVgzGbfSo/A+gXGD5im34GPoC+clu8ekxAFuP4Pej
	 9yZXTA3V6JbH2lbd2H587JqX6/sS3BLIME9OWr3Kpf1De1TTxUqE7kYOgVi4N+UgB7syz
	 ed4dx8MLq1qmEEIGKEQ0uLaZ38hRvvTPnGF4Y8fWJDio4Obf9VKC550WiEQHKOxtm9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JUlByrfI;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332A8606A326
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 18:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 332A8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JUlByrfI
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4ba078f26f4so34911645e9.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795543553; x=1796148353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9Z35jXvciXrurj3K6EI8MVj4sAFvISgfO7AYIfJtaq4=;
        b=JUlByrfIQ5VtgBfsOxthSTjBQgQtS4nPGYmP70VUem3vhQ99OkeLvcg9sXxVsKCgYk
         340+scw8CiSZ+SBgXnyOWdgrobtq0g6Y5v02YXNTB/iFpbmz2fNv/XH3AGiaoviHD3X7
         sjLSImGbLinxr4+1gOvUpjQ5YYRFdTwPikiSEZ9QW5Scadiz2cUCzd5Teerp8KxWUf54
         HUI5JGLXzhgd0nvY5NU8fxpS3V9YzkK9fjdajqCOPJjJuLRaKFXuCVo1ifO1+oPOKrNP
         aG5ewjHITskK47URoQjfusaerOOHJ6s7sOigaBmsyHIY8sGkW2eKqNacL6r+y6KNeGel
         PGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543553; x=1796148353;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Z35jXvciXrurj3K6EI8MVj4sAFvISgfO7AYIfJtaq4=;
        b=p6X+d0or7m6jJ6+foCJUO/1gxvG8imBYyDvmJg/KPd3P0h484GOp28xKqq7XQ9l5Oe
         e3y9w+Gj+fSZs1rIKoxgaQazDetor1O5mv3Ll5GANYLtBmysYUFpTrFsGPqm2+XmlIPW
         jQb204LCPocwpUvS+BKnS5t1JKHktuejwHRr1CrLx/RcTEh07G6UjIT/+8hYZnd/soZm
         fOfzxvqR7jqA5mumGIRqXOf727tn7nCJcJtUsPTFR7pP2jA8dczM5fdu7bS5FAC2Zh3m
         XiTsUA5bndy9sIe2Eg4XQVzSk5/6CZnchE5vgAcKS9sTu4FNk8Erhavi8cLCHB4MgzLg
         iR8A==
X-Gm-Message-State: APuU4Z9WSBDKdRkpu7h6BxPo0pYSTuG01SERf+FeUsMNDIanHZp+VsY4
	047w5XU6vIYSJ7/+X2VeoFTYv+IPkBizhmkqTL0eA8EYkS/M//rzrsrehZDMVb0jJRH5tSDNKiB
	CxKWTT2uWeOeTSu4AZPVqSN0vuSILQNQzBFansAeS6Qvt9xa8/PrqHRaXRS3gl+CxyV+Woc8KE2
	uHAh882RAmlKekXD2EozFRxQ==
X-Received: from wmfq8.prod.google.com ([2002:a05:600c:2e48:b0:4bb:5bb3:d156])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:46d3:b0:4bb:5c92:ce12
 with SMTP id 5b1f17b1804b1-4bb88812200mr334057115e9.17.1795543553219; Tue, 24
 Nov 2026 10:05:53 -0800 (PST)
Date: Tue, 24 Nov 2026 18:05:48 +0000
In-Reply-To: <20261119192311.2685319-1-dmnk@google.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192311.2685319-1-dmnk@google.com>
X-Mailer: git-send-email 2.56.1.663.g77904e546d
Message-ID: <cover.1795543448.git.dmnk@google.com>
Subject: [PATCH v2 0/2] archive: defer --add-file stat() and fix zip
 extra-file prefix handling
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: "=?utf-8?q?Ren=C3=A9_Scharfe?=" <l.s.r@web.de>, Junio C Hamano <gitster@pobox.com>, dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Following Ren=C3=A9's suggestion on v1, patch 2/2 moves the --add-file
stat() check into parse_archive_args() after parse_options() so
--no-add-file can cancel an earlier --add-file and --add-virtual-file
works over --remote.

Testing --remote --add-virtual-file with --format=3Dzip turned up an
out-of-bounds pointer advance in write_zip_entry() when --prefix is
longer than an extra or virtual file's path (path + args->baselen), so
patch 1/2 fixes that first.

Dominik Maier (2):
  archive-zip: fix prefix stripping for extra and virtual files
  archive: defer --add-file stat() until after option parsing

 archive-zip.c          |  5 +++--
 archive.c              | 28 +++++++++++++++++++++-------
 t/t5000-tar-tree.sh    | 24 ++++++++++++++++++++++++
 t/t5003-archive-zip.sh |  5 +++++
 4 files changed, 53 insertions(+), 9 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  72c0d0c0a4 archive-zip: fix prefix stripping for extra=
 and virtual files
1:  c51e62800c ! 2:  543109b748 archive: reject remote --add-file in callba=
ck
    @@ Metadata
     Author: Dominik Maier <dmnk@google.com>
    =20
      ## Commit message ##
    -    archive: reject remote --add-file in callback
    +    archive: defer --add-file stat() until after option parsing
    =20
    -    parse_archive_args() only checks "is_remote && args->extra_files.n=
r"
    -    after parse_options() returns. When git-upload-archive parses clie=
nt
    -    arguments, add_file_cb() runs first and calls stat() on the reques=
ted
    -    path on the server filesystem, reporting "File not found" or "Not =
a
    -    regular file" before the "--remote" incompatibility check is reach=
ed
    -    (and succeeding altogether if "--no-add-file" follows).
    +    add_file_cb() calls stat() on each --add-file argument while
    +    parse_options() is still running, before parse_archive_args() chec=
ks
    +    is_remote. When git-upload-archive parses client arguments, it pro=
bes
    +    the requested path on the server filesystem and reports "File not =
found"
    +    or "Not a regular file" instead of rejecting --add-file with --rem=
ote.
    =20
    -    Pass is_remote into add_file_cb() and reject "--add-file" and
    -    "--add-virtual-file" immediately before touching the filesystem.
    +    Move the stat() and regular-file checks into parse_archive_args() =
after
    +    parse_options() finishes, refusing entries with a NULL content poi=
nter
    +    when is_remote is set. This rejects remote --add-file before touch=
ing
    +    the filesystem, allows a later --no-add-file to cancel an earlier
    +    --add-file, and lets --add-virtual-file work with --remote since i=
ts
    +    content is supplied inline.
    =20
    +    Suggested-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
         Signed-off-by: Dominik Maier <dmnk@google.com>
    =20
      ## archive.c ##
    -@@ archive.c: static void extra_file_info_clear(void *util, const char=
 *str UNUSED)
    - 	free(info);
    - }
    +@@ archive.c: static int add_file_cb(const struct option *opt, const c=
har *arg, int unset)
     =20
    -+struct add_file_data {
    -+	struct archiver_args *args;
    -+	const char **basep;
    -+	int is_remote;
    -+};
    -+
    - static int add_file_cb(const struct option *opt, const char *arg, int=
 unset)
    - {
    --	struct archiver_args *args =3D opt->value;
    --	const char **basep =3D (const char **)opt->defval;
    --	const char *base =3D *basep;
    -+	struct add_file_data *data =3D opt->value;
    -+	struct archiver_args *args =3D data->args;
    -+	const char *base =3D *data->basep;
    - 	char *path;
    - 	struct string_list_item *item;
    - 	struct extra_file_info *info;
    -=20
    -+	if (data->is_remote)
    -+		die(_("options '%s' and '%s' cannot be used together"),
    -+		    !strcmp(opt->long_name, "add-virtual-file") ?
    -+		    "--add-virtual-file" : "--add-file",
    -+		    "--remote");
    -+
    - 	if (unset) {
    - 		string_list_clear_func(&args->extra_files,
    - 				       extra_file_info_clear);
    + 	if (!strcmp(opt->long_name, "add-file")) {
    + 		path =3D prefix_filename(args->prefix, arg);
    +-		if (stat(path, &info->stat))
    +-			die(_("File not found: %s"), path);
    +-		if (!S_ISREG(info->stat.st_mode))
    +-			die(_("Not a regular file: %s"), path);
    +-		info->content =3D NULL; /* read the file later */
    ++		memset(&info->stat, 0, sizeof(info->stat));
    ++		info->content =3D NULL; /* stat and read the file later */
    + 	} else if (!strcmp(opt->long_name, "add-virtual-file")) {
    + 		struct strbuf buf =3D STRBUF_INIT;
    + 		const char *p =3D arg;
     @@ archive.c: static int parse_archive_args(int argc, const char **arg=
v,
    + 	const char *mtime_option =3D NULL;
    + 	int compression_level =3D -1;
    + 	int verbose =3D 0;
    ++	struct string_list_item *item;
      	int i;
      	int list =3D 0;
      	int worktree_attributes =3D 0;
    -+	struct add_file_data add_file_data =3D {
    -+		.args =3D args,
    -+		.basep =3D &base,
    -+		.is_remote =3D is_remote,
    -+	};
    - 	struct option opts[] =3D {
    - 		OPT_GROUP(""),
    - 		OPT_STRING(0, "format", &format, N_("fmt"), N_("archive format")),
    -@@ archive.c: static int parse_archive_args(int argc, const char **arg=
v,
    - 		{
    - 			.type =3D OPTION_CALLBACK,
    - 			.long_name =3D "add-file",
    --			.value =3D args,
    -+			.value =3D &add_file_data,
    - 			.argh =3D N_("file"),
    - 			.help =3D N_("add untracked file to archive"),
    - 			.callback =3D add_file_cb,
    --			.defval =3D (intptr_t) &base,
    - 		},
    - 		{
    - 			.type =3D OPTION_CALLBACK,
    - 			.long_name =3D "add-virtual-file",
    --			.value =3D args,
    -+			.value =3D &add_file_data,
    - 			.argh =3D N_("path:content"),
    - 			.help =3D N_("add untracked file to archive"),
    - 			.callback =3D add_file_cb,
    --			.defval =3D (intptr_t) &base,
    - 		},
    - 		OPT_STRING('o', "output", &output, N_("file"),
    - 			N_("write the archive to this file")),
     @@ archive.c: static int parse_archive_args(int argc, const char **arg=
v,
      		die(_("the option '%s' requires '%s'"), "--exec", "--remote");
      	if (output)
      		die(_("Unexpected option --output"));
     -	if (is_remote && args->extra_files.nr)
     -		die(_("options '%s' and '%s' cannot be used together"), "--add-file=
", "--remote");
    ++	for_each_string_list_item(item, &args->extra_files) {
    ++		const char *path =3D item->string;
    ++		struct extra_file_info *info =3D item->util;
    ++
    ++		if (info->content)
    ++			continue;
    ++		if (is_remote)
    ++			die(_("options '%s' and '%s' cannot be used together"),
    ++			    "--add-file", "--remote");
    ++		if (stat(path, &info->stat))
    ++			die(_("File not found: %s"), path);
    ++		if (!S_ISREG(info->stat.st_mode))
    ++			die(_("Not a regular file: %s"), path);
    ++	}
     =20
      	if (!base)
      		base =3D "";
    @@ t/t5000-tar-tree.sh: check_tar with_untracked2
      check_added with_untracked2 untracked one/untracked
      check_added with_untracked2 untracked two/untracked
     =20
    -+test_expect_success 'git archive --remote rejects --add-file before s=
tat' '
    ++test_expect_success 'git archive --remote rejects --add-file without =
stat' '
     +	test_must_fail git archive --remote=3D. --add-file=3Dno-such-file HE=
AD 2>err &&
     +	test_grep "cannot be used together" err &&
     +	test_grep ! "File not found" err &&
    -+	echo untracked >untracked &&
    -+	test_must_fail git archive --remote=3D. --add-file=3Duntracked --no-=
add-file HEAD 2>err &&
    -+	test_grep "cannot be used together" err
    ++	test_must_fail git archive --remote=3D. --add-file=3D. HEAD 2>err &&
    ++	test_grep "cannot be used together" err &&
    ++	test_grep ! "Not a regular file" err
     +'
    ++
    ++test_expect_success 'git archive allows --no-add-file after missing -=
-add-file' '
    ++	git archive --add-file=3Dno-such-file --no-add-file HEAD >canceled.t=
ar &&
    ++	test_cmp_bin b.tar canceled.tar &&
    ++	git archive --remote=3D. --add-file=3Dno-such-file --no-add-file HEA=
D >remote-canceled.tar &&
    ++	test_cmp_bin b.tar remote-canceled.tar
    ++'
    ++
    ++test_expect_success 'git archive --remote with --add-virtual-file' '
    ++	printf virtual >expected-virtual &&
    ++	git archive --remote=3D. --add-virtual-file=3Dvirtual:virtual HEAD >=
remote_virtual.tar
    ++'
    ++
    ++check_tar remote_virtual
    ++check_added remote_virtual expected-virtual virtual
     +
      test_expect_success 'git archive on large files' '
      	test_config core.bigfilethreshold 1 &&
--=20
2.56.1.831.g720f3f5937-goog

