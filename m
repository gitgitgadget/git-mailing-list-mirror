Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC6195
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910504; cv=none; b=nOeWlI/EtTnaLtEpRg5MreFAnKtRZBiPA9lBhuEufbB6dd4yNuLoW+IfUvnJ5pnOlKROcQre10WqbVrdvQoQJ+ZTZynrsPUhlcrMIeWM1r+XsMPaMD5cH8Lkt5bY7fcqb8/I8ntj7yPpJquo0jCbhunSoXy9hlOdc8CqlwFTn7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910504; c=relaxed/simple;
	bh=8cR+kJ4rxyN1mSvD+xcE8Y0zXqPsir61xOVrcc6IddQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSEUXb03XDFfAV1FJMRaYALqYWZ6TyuBx21ShcwuUrVM0FZ4MLqHbmRRz34c9SJS4+fuXrBinU33RHeYWR6/P46FkTfzBrKDBn6vRYou4zltfGqdy84pfql8K8V21A1mVWUpPNP7es96d3/a1Xph2nF+UhL8O/Y0fO3aokCKeXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxAor6GO; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxAor6GO"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7275bc6638bso380399a34.2
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741910499; x=1742515299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFv204xuuSA58W1QGFLhdthEetjGhEcAiyp0e8MwyP0=;
        b=WxAor6GOf5pKphjSUBQMiprxrhww8bvAU8oOdz1sh3ll4jhyv1D3y6Y+/UHrprBe0S
         FOVNaNEC+5uuaKqB2Osfq6aKpPUfxPUOkfaxg9W+UU7E5/T5hhNkUviFQLOHTbmlaKHD
         lc106hx3S60OSa6QoFbueZlhc6+I1RppGMjERIqI4kKpjCRLZqB8r5UUr8XYA9x/Lyqc
         xQGUCy9ZHVS21uP0OZitwsrpVBd6Fene6+wiZ06J3wN9Gji4OGJVIjfqOIkVMNGQYLm6
         mvhbWpyMb5m3Bc/vMwpoazvaGycbaQMpDdD5tKYO5dBdosTPRH5Cn/94KJnQt2Nux0qv
         MzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741910499; x=1742515299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFv204xuuSA58W1QGFLhdthEetjGhEcAiyp0e8MwyP0=;
        b=C8W10xrrOqadOnxCeGvUNiMaRE7x9kMUyS7EHnoLZ9sPhjatbz7qR8UrMwp/JifIcd
         UR51e+xepAdNLT+4SfSpb6FsqUOSedoWOlZhNtFzfzZSmiZ69YOjNiS8nwY1FPSIa0WB
         RO9fVJv55ZbXlgL4A16BZfY3O3FOWkmc6pnRA5S3isuXnsbMfjo+AxtCeKC1smys7fKd
         bFDf+1iVDiaTk9WGoeDFpM1IlZKoyRwlAruD12e5Cu5Pp+nPkfqLHXDQ/5ftH/dro0hz
         xpqID5Qrw2WO3c0qJPQNRL7xsiGVWTe7Y/s25IHXu0dpY2HAvHozUvYigKkOe9Murrdj
         BGpw==
X-Gm-Message-State: AOJu0YxWWLRdE4g7PK1VXuhofIt1AYDzazVEESw5DlNxAsiYCecRQHTz
	UnDdzzPxE8koNYgJz8CuyX6drHz3zIgbhoM4awhOY/Q2gnKGlA5PD3pTPQ==
X-Gm-Gg: ASbGncvspkVdbd9hgzKp4XjCgjMInM6pYdv4EDx6UoV5UDml4fXLhXIsKsuLIViwl1+
	YsbFS/ngFinFxFRxhIObQpgoNB/V7Rd+S36i8kzGRWkxp7v0I2NatxF6C5F86OU+3026TkpESto
	1eGt37udtJZqogOe9RNWryEqeaLQ7zw1Xk9Or5vX1YpwI5iZ1t3zS8qGKWFKhThekG2i5oac1jK
	Yn5z7HbgLuY/ApDTDaXLjIBwNeRPX6s6XORVHm/bdkAuzFr8bwrO9GLounzJrjn4wuJSK3Aev91
	1cdCdS2T3Yv+wK/qjuG8GU0nUn8UyR2aRTs7nY7+1jTDIjr4yQAf
X-Google-Smtp-Source: AGHT+IF2PX4ivr3G6q7PgpFsNyTrscSyEi6tiy3igCOxJITHKihf2mzP/qQ70rYyk7cwNwrQxhallA==
X-Received: by 2002:a05:6830:6483:b0:72b:99eb:7ce3 with SMTP id 46e09a7af769-72bbc5136afmr206851a34.18.1741910498717;
        Thu, 13 Mar 2025 17:01:38 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e973sm423485a34.43.2025.03.13.17.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:01:37 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	peff@peff.net,
	ben.knoble@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/6] rev-list: introduce NUL-delimited output mode
Date: Thu, 13 Mar 2025 18:57:41 -0500
Message-ID: <20250313235747.9583-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250313001706.3390502-1-jltobler@gmail.com>
References: <20250313001706.3390502-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When walking objects, git-rev-list(1) prints each object entry on a
separate line in the form:

        <oid> LF

Some options, such as `--objects`, may print additional information
about the object on the same line:

        <oid> SP [<path>] LF

In this mode, if the object path contains a newline it is truncated at
the newline.

The `--boundary` option also modifies output by prefixing boundary
objects with `-`:

        -<oid> LF

When the `--missing={print,print-info}` option is provided, information
about any missing objects encountered during the object walk are also
printed in the form:

        ?<oid> [SP <token>=<value>]... LF

where values containing LF or SP are printed in a token specific fashion
so that the resulting encoded value does not contain either of these two
problematic bytes. For example, missing object paths are quoted in the C
style when they contain LF or SP.

To make machine parsing easier, this series introduces a NUL-delimited
output mode for git-rev-list(1) via a `-z` option. In this mode, the
output format for object records is unified such that each object and
its accompanying metadata is formatted without relying on object
metadata order. This format follows the existing `<token>=<value>` used
by the `--missing` option to represent object metadata in the form:

        <oid> NUL [<token>=<value> NUL]...

        # Examples
        <oid> LF                       -> <oid> NUL
        <oid> SP <path> LF             -> <oid> NUL path=<path> NUL
        -<oid> LF                      -> <oid> NUL boundary=yes NUL
        ?<oid> [SP <token>=<value>]... -> <oid> NUL missing=yes NUL [<token>=<value> NUL]...

Note that token value info is printed as-is without any special encoding
or truncation. Prefixes such as '-' and '?' are dropped in favor using a
token/value pair to signal the same information.

While in this mode, if the `--sdtin` option is used, revision and
pathspec arguments read from stdin are separated with a NUL byte instead
of being newline delimited.

For now this series only adds support for use with the `--objects`,
`--boundary` and `--missing` output options. Usage of `-z` with other
options is rejected, so it can potentially be added in the future.

This series is structured as follows:

        - Patches 1 and 2 do some minor preparatory refactors.

        - Patch 3 modifies stdin argument parsing handled by
          `setup_revisions()` to support NUL-delimited arguments.

        - Patch 4 adds the `-z` option to git-rev-list(1) to print
          objects in a NUL-delimited fashion. Arguments parsed on stdin
          while in the mode are also NUL-delimited.

        - Patch 5 teaches the `--boundary` option how to print info in a
          NUL-delimited fashino using the unified output format.

        - Patch 6 teaches the `--missing` option how to print info in a
          NUL-delimited fashion using the unified output format.

Changes since V2:

        - In patch 4, the documentation for the -z option now points out
          the `--stdin` behavior change earlier.

        - Minor code style and documentation changes in patch 6.

Changes since V1:

        - Use unified output format with `<token>=<value>` pairs for
          all object metadata.

        - Add support for the `--boundary` option in NUL-delimited mode.

        - Add support for NUL-delimited stdin argument parsing in
          NUL-delimited mode.

        - Instead of using two NUL bytes to delimit between object
          records, a single NUL byte is used. Now that object metadata
          is always in the form `<token>=<value>`, we know a new object
          record starts when there is an OID entry which will not
          contain '='.

Thanks for taking a look,
-Justin

Justin Tobler (6):
  rev-list: inline `show_object_with_name()` in `show_object()`
  rev-list: refactor early option parsing
  revision: support NUL-delimited --stdin mode
  rev-list: support delimiting objects with NUL bytes
  rev-list: support NUL-delimited --boundary option
  rev-list: support NUL-delimited --missing option

 Documentation/rev-list-options.adoc | 26 ++++++++
 builtin/rev-list.c                  | 94 +++++++++++++++++++++--------
 revision.c                          | 27 ++++-----
 revision.h                          |  5 +-
 t/t6000-rev-list-misc.sh            | 51 ++++++++++++++++
 t/t6017-rev-list-stdin.sh           |  9 +++
 t/t6022-rev-list-missing.sh         | 31 ++++++++++
 7 files changed, 200 insertions(+), 43 deletions(-)

Range-diff against v2:
1:  d2eded3ac7 = 1:  d2eded3ac7 rev-list: inline `show_object_with_name()` in `show_object()`
2:  03cd08c859 = 2:  03cd08c859 rev-list: refactor early option parsing
3:  803a49933a = 3:  803a49933a revision: support NUL-delimited --stdin mode
4:  d3b3c4ef89 ! 4:  8eb7669089 rev-list: support delimiting objects with NUL bytes
    @@ Documentation/rev-list-options.adoc: ifdef::git-rev-list[]
     +
     +-z::
     +	Instead of being newline-delimited, each outputted object and its
    -+	accompanying metadata is delimited using NUL bytes in the following
    -+	form:
    ++	accompanying metadata is delimited using NUL bytes. In this mode, when
    ++	the `--stdin` option is provided, revision and pathspec arguments on
    ++	stdin are also delimited using a NUL byte. Output is printed in the
    ++	following form:
     ++
     +-----------------------------------------------------------------------
     +<OID> NUL [<token>=<value> NUL]...
    @@ Documentation/rev-list-options.adoc: ifdef::git-rev-list[]
     +<OID> NUL path=<path> NUL
     +-----------------------------------------------------------------------
     ++
    -+This mode is only compatible with the `--objects` output option. Also, revision
    -+and pathspec argument parsing on stdin with the `--stdin` option is NUL byte
    -+delimited instead of using newlines while in this mode.
    ++This mode is only compatible with the `--objects` output option.
      endif::git-rev-list[]
      
      History Simplification
5:  5e4fc41976 ! 5:  591a2c7dac rev-list: support NUL-delimited --boundary option
    @@ Documentation/rev-list-options.adoc: ifdef::git-rev-list[]
     +<OID> NUL boundary=yes NUL
      -----------------------------------------------------------------------
      +
    --This mode is only compatible with the `--objects` output option. Also, revision
    --and pathspec argument parsing on stdin with the `--stdin` option is NUL byte
    --delimited instead of using newlines while in this mode.
    +-This mode is only compatible with the `--objects` output option.
     +This mode is only compatible with the `--objects` and `--boundary` output
    -+options. Also, revision and pathspec argument parsing on stdin with the
    -+`--stdin` option is NUL byte delimited instead of using newlines while in this
    -+mode.
    ++options.
      endif::git-rev-list[]
      
      History Simplification
6:  7744966514 ! 6:  669b3b5d9f rev-list: support NUL-delimited --missing option
    @@ Commit message
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## Documentation/rev-list-options.adoc ##
    -@@ Documentation/rev-list-options.adoc: ifdef::git-rev-list[]
    - <OID> NUL [<token>=<value> NUL]...
    - -----------------------------------------------------------------------
    - +
    --Additional object metadata, such as object paths or boundary objects, is
    --printed using the `<token>=<value>` form. Token values are printed as-is
    -+Additional object metadata, such as object paths or boundary/missing objects,
    -+is printed using the `<token>=<value>` form. Token values are printed as-is
    - without any encoding/truncation. An OID entry never contains a '=' character
    - and thus is used to signal the start of a new object record. Examples:
    - +
     @@ Documentation/rev-list-options.adoc: and thus is used to signal the start of a new object record. Examples:
      <OID> NUL
      <OID> NUL path=<path> NUL
    @@ Documentation/rev-list-options.adoc: and thus is used to signal the start of a n
      -----------------------------------------------------------------------
      +
     -This mode is only compatible with the `--objects` and `--boundary` output
    --options. Also, revision and pathspec argument parsing on stdin with the
    --`--stdin` option is NUL byte delimited instead of using newlines while in this
    --mode.
    +-options.
     +This mode is only compatible with the `--objects`, `--boundary`, and
    -+`--missing` output options. Also, revision and pathspec argument parsing on
    -+stdin with the `--stdin` option is NUL byte delimited instead of using newlines
    -+while in this mode.
    ++`--missing` output options.
      endif::git-rev-list[]
      
      History Simplification
    @@ builtin/rev-list.c: static void print_missing_object(struct missing_objects_map_
      	struct strbuf sb = STRBUF_INIT;
      
     +	if (line_term)
    -+		putchar('?');
    -+
    -+	printf("%s", oid_to_hex(&entry->entry.oid));
    -+
    -+	if (!line_term)
    -+		printf("%cmissing=yes", info_term);
    ++		printf("?%s", oid_to_hex(&entry->entry.oid));
    ++	else
    ++		printf("%s%cmissing=yes", oid_to_hex(&entry->entry.oid),
    ++		       info_term);
     +
      	if (!print_missing_info) {
     -		printf("?%s\n", oid_to_hex(&entry->entry.oid));
    @@ builtin/rev-list.c: static void print_missing_object(struct missing_objects_map_
      	}
      
      	if (entry->path && *entry->path) {
    - 		struct strbuf path = STRBUF_INIT;
    +-		struct strbuf path = STRBUF_INIT;
    ++		strbuf_addf(&sb, "%cpath=", info_term);
    ++
    ++		if (line_term) {
    ++			struct strbuf path = STRBUF_INIT;
      
     -		strbuf_addstr(&sb, " path=");
     -		quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
     -		strbuf_addbuf(&sb, &path);
    -+		strbuf_addf(&sb, "%cpath=", info_term);
    -+
    -+		if (line_term) {
     +			quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
     +			strbuf_addbuf(&sb, &path);
    + 
    +-		strbuf_release(&path);
    ++			strbuf_release(&path);
     +		} else {
     +			strbuf_addstr(&sb, entry->path);
     +		}
    - 
    - 		strbuf_release(&path);
      	}
      	if (entry->type)
     -		strbuf_addf(&sb, " type=%s", type_name(entry->type));

base-commit: 87a0bdbf0f72b7561f3cd50636eee33dcb7dbcc3
-- 
2.49.0.rc2

