Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6A33ADA0
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206260; cv=none; b=dbYxoeZ8kjpI2dx2oAPJHqY+/SG/Wl2AIceVv0N355cKuT5KCjZI5vstpj7D4ls4UFX0Vw+dTabcF4813CQqWcIDLIv87wUZAlvnszVfvbxBwB9tn7IA9MMrUG/wlLtQMd1ZOmyOsPxp1WoPF4veXzrRT1Nr1usHdGeKX5MnIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206260; c=relaxed/simple;
	bh=7a2YcsmdFhpdlgCk6AF/K0clPg5eV98jNrxWWbgMA+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLEwLecBtDe/q+fSJFUN4ljUWsr0dmHaM0kA2VtNABh07j1SCgPIxUkrisIsE6PbZTNuHuvJgxIXhvLD+le+EXOXgomgb3ZGY2OD0PzJSZ8KKkq9wEiubUG5YaHGM3Dx8YiiucDF5/glE3lH+Eoyed7gLSgjdUia4ukd5zLRp8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FTF7KM1u; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FTF7KM1u"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so33988707b3.2
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206258; x=1779811058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/O0Fhgo5ram5aCXgnYMzljhUfgjfEHHiJbPPcso3CfA=;
        b=FTF7KM1uzAW8p0pXBrwkcQ+rKiWFJLM6F5lJGtK6Psqve3VOM92gVt++m369mazE5U
         1K+zMGPnnTGyorZ6nBy+h2ItdhmV5VYB1ZIls9al8fSUbxpMxhmZWmNjYaXdOr0bc3R6
         8sten86TuCAi0PqwdjktD1P2GyHwgCgMQUV5OOyEOyTyIIDObxUH045PR3IsUm3afo+T
         rAvMXZRd9H/oEMhkX2ccAGt88hS/Zc3Jys5wA+re7cRW8TLvqsFtd7z43cbtPIxIkcMU
         B4HP4koeX8lvKJFm1BZSKJA8pP4v9cLRTYqLiRRW8Y+JMHCUvkjCyjsQEQn+YQTTd2G3
         fvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206258; x=1779811058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O0Fhgo5ram5aCXgnYMzljhUfgjfEHHiJbPPcso3CfA=;
        b=DtAxeQJFK9Kz3mjZVCBZBpjKoV3fwpdUlodz2IfA6gtUrH/fcSlMhlog8QgHvs9LeN
         IVdTpm7m34cccoaw7UX96Md7m87/4EsV+0bE8jV0O6+myk1v7BIcgA41xrV7PKRDsBa9
         H4MLeAUkth12LUWPK+paCX79NaBcVyijm/GKsbxIg+CsZtCpUrU7Ee8RgC/KDy6f6GND
         PZ1iS86NFkWX0rOE/i+1TeiwhvFXsJgca0g93peB7mxVarzez4QL4y3+zeozSGZSdbMZ
         6kvPF8k0yeADDd6uHFD7P7OOY0FEIsmvBjoNIHRCuQZQKkmEu8Ql30qFX0KcoUvXnT73
         7pcQ==
X-Gm-Message-State: AOJu0Yz117BOjExBGbSdq4f5/E2cqt6J/g6X8UIW1Z+vBFx5utkR+tvR
	9eMaG6csvw8ShwILt3WlM1aJ3ilZf8odAlanRcrsaR+qLLe63SfChD2SU6e4QhmH32mnKPj/qXn
	wfPVoqczfS6ru
X-Gm-Gg: Acq92OHajR1kk9Eg7R+iL/ZZs2xnjlq1Tmx/uP/02SbwNdfdMbyr3oWs7w3iHm5vY/W
	23dtBXvnZgUn3adiANQb3pjmGmrf0+RyUWYoF5/YbFqLurTsFq+ZiX/P1pQqkZ/t+PAhs/BqSgv
	efgRQeuiBp7w6iMvSFdVazUAFPIPSBf5Hf8w4+aVCF04Nz1fqCLzExpLue4LaV5idlHu+TRA+UU
	/fmGnFBag70UThP5dNH3PbLgo8tVzPBP29R+P51Lv+4TYDg6TIiooPyyP02VNKeuFu7OMLYwvrJ
	ix6+aFZLWUIZcOacp7HhAhJ0pLZb+Q/AO4RratODu4kaZVgsC9qhZPHcw3PmNJBJIB+bAFToVHS
	ellEZUtq5fxePUksbiZuQ8ULbhsHx4lQX9vajdmM9+QebPRpFHGarKxOCj0WucUWi85aM4W7F/6
	tcdTJRIhmEuFNG08ogGLcgqgyJWnhLAC4xk9Lp9mDDqmKWO7k5zBqpojMxC1diDOwf3XD69aTil
	1xtQR4AGj+WUx/mAz/InCYv2eMHdEgyYQhsJWygE3C2p2foIfNhK5x53OfSvg73p3yBSumeh4VS
	3yEDEH5q+qryo5QLNCHvgMKXLf4=
X-Received: by 2002:a05:690c:c50f:b0:7d0:6660:1602 with SMTP id 00721157ae682-7d066602963mr1361167b3.43.1779206258087;
        Tue, 19 May 2026 08:57:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0ccc4sm38670957b3.31.2026.05.19.08.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:57:37 -0700 (PDT)
Date: Tue, 19 May 2026 11:57:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/16] repack: incremental MIDX/bitmap-based repacking
Message-ID: <cover.1779206239.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774820449.git.me@ttaylorr.com>

Here is another small reroll of my series to implement the last
remaining component of the incremental MIDX/bitmap-based repacking
strategy [1].

The changes since v3 are fairly small:

 - `repack_prepare_midx_command()` now calls its third parameter
   "subcommand" instead of "verb".

 - `clear_incremental_midx_files()` now avoids a redundant conditional
   around `r->objects` and reuses a local `struct odb_source *` when
   closing any open incremental MIDX handles.

As usual, a range-diff is included below for convenience. Thanks in
advance for reviewing!

[1]: https://lore.kernel.org/git/cover.1777507303.git.me@ttaylorr.com/

Taylor Blau (16):
  midx-write: handle noop writes when converting incremental chains
  midx: use `strset` for retained MIDX files
  midx: build `keep_hashes` array in order
  midx: use `strvec` for `keep_hashes`
  midx: introduce `--no-write-chain-file` for incremental MIDX writes
  midx: support custom `--base` for incremental MIDX writes
  repack: track the ODB source via existing_packs
  midx: expose `midx_layer_contains_pack()`
  repack-midx: factor out `repack_prepare_midx_command()`
  repack-midx: extract `repack_fill_midx_stdin_packs()`
  repack-geometry: prepare for incremental MIDX repacking
  builtin/repack.c: convert `--write-midx` to an `OPT_CALLBACK`
  packfile: ensure `close_pack_revindex()` frees in-memory revindex
  repack: implement incremental MIDX repacking
  repack: introduce `--write-midx=incremental`
  repack: allow `--write-midx=incremental` without `--geometric`

 Documentation/config/repack.adoc        |  18 +
 Documentation/git-multi-pack-index.adoc |  32 +-
 Documentation/git-repack.adoc           |  44 +-
 builtin/multi-pack-index.c              |  48 +-
 builtin/repack.c                        | 102 +++-
 midx-write.c                            | 206 ++++---
 midx.c                                  | 102 ++--
 midx.h                                  |  11 +-
 packfile.c                              |   2 +
 repack-geometry.c                       |  48 +-
 repack-midx.c                           | 710 +++++++++++++++++++++++-
 repack.c                                |  58 +-
 repack.h                                |  26 +-
 t/meson.build                           |   1 +
 t/t5334-incremental-multi-pack-index.sh |  63 +++
 t/t5335-compact-multi-pack-index.sh     | 113 ++++
 t/t7705-repack-incremental-midx.sh      | 525 ++++++++++++++++++
 17 files changed, 1909 insertions(+), 200 deletions(-)
 create mode 100755 t/t7705-repack-incremental-midx.sh

Range-diff against v3:
 1:  d6c27317c25 =  1:  ead11e610c8 midx-write: handle noop writes when converting incremental chains
 2:  629c8d23116 =  2:  ece55bf2957 midx: use `strset` for retained MIDX files
 3:  e303bf6a4ac =  3:  5609d1941e6 midx: build `keep_hashes` array in order
 4:  42d76c70060 =  4:  13b7c808860 midx: use `strvec` for `keep_hashes`
 5:  2c80aa34fac =  5:  cac3fd54bf0 midx: introduce `--no-write-chain-file` for incremental MIDX writes
 6:  2a05f4b86f3 =  6:  1bbb387d6b6 midx: support custom `--base` for incremental MIDX writes
 7:  92aba3d366f =  7:  4a93adb3ad3 repack: track the ODB source via existing_packs
 8:  d3ac65c1f11 =  8:  8d1b8b1d301 midx: expose `midx_layer_contains_pack()`
 9:  1bd2f194c6f !  9:  42111e5f75d repack-midx: factor out `repack_prepare_midx_command()`
    @@ Commit message
         subcommands), so extract the common portions of the command setup into a
         reusable `repack_prepare_midx_command()` helper.
     
    -    The extracted helper sets `git_cmd`, pushes the `multi-pack-index`
    -    subcommand and verb, and handles `--progress`/`--no-progress` and
    -    `--bitmap` flags. The remaining arguments that are specific to the
    -    `write` subcommand (such as `--stdin-packs`) are left to the caller.
    +    The extracted helper sets `git_cmd`, pushes `multi-pack-index` and a
    +    subcommand, and handles `--progress`/`--no-progress` and `--bitmap`
    +    flags. The remaining arguments that are specific to the `write`
    +    subcommand (such as `--stdin-packs`) are left to the caller.
     
         No functional changes are included in this patch.
     
    @@ repack-midx.c: static void remove_redundant_bitmaps(struct string_list *include,
      
     +static void repack_prepare_midx_command(struct child_process *cmd,
     +					struct repack_write_midx_opts *opts,
    -+					const char *verb)
    ++					const char *subcommand)
     +{
     +	cmd->git_cmd = 1;
     +
    -+	strvec_pushl(&cmd->args, "multi-pack-index", verb, NULL);
    ++	strvec_pushl(&cmd->args, "multi-pack-index", subcommand, NULL);
     +
     +	if (opts->show_progress)
     +		strvec_push(&cmd->args, "--progress");
10:  2a87a1e4561 = 10:  ed76e6efd1c repack-midx: extract `repack_fill_midx_stdin_packs()`
11:  3d32b9c88da = 11:  9665f1b3a64 repack-geometry: prepare for incremental MIDX repacking
12:  1f7a5479bb8 = 12:  e0db62b9f10 builtin/repack.c: convert `--write-midx` to an `OPT_CALLBACK`
13:  b155f25d53c = 13:  c8c846b1ac1 packfile: ensure `close_pack_revindex()` frees in-memory revindex
14:  ef012314930 = 14:  78f1a98c1ea repack: implement incremental MIDX repacking
15:  04cfecd5136 ! 15:  95bf8b21fff repack: introduce `--write-midx=incremental`
    @@ midx.c: void clear_midx_file(struct repository *r)
     +void clear_incremental_midx_files(struct repository *r,
     +				  const struct strvec *keep_hashes)
     +{
    ++	struct odb_source *source = r->objects->sources;
     +	struct strbuf chain = STRBUF_INIT;
     +
    -+	get_midx_chain_filename(r->objects->sources, &chain);
    ++	get_midx_chain_filename(source, &chain);
     +
    -+	if (r->objects) {
    -+		struct odb_source *source = r->objects->sources;
    -+		for (source = r->objects->sources; source; source = source->next) {
    -+			struct odb_source_files *files = odb_source_files_downcast(source);
    -+			if (files->packed->midx)
    -+				close_midx(files->packed->midx);
    -+			files->packed->midx = NULL;
    -+		}
    ++	for (; source; source = source->next) {
    ++		struct odb_source_files *files = odb_source_files_downcast(source);
    ++		if (files->packed->midx)
    ++			close_midx(files->packed->midx);
    ++		files->packed->midx = NULL;
     +	}
     +
     +	if (!keep_hashes && remove_path(chain.buf))
16:  1c05dfce579 = 16:  8bd0ec98dc3 repack: allow `--write-midx=incremental` without `--geometric`

base-commit: 7bcaabddcf68bd0702697da5904c3b68c52f94cf
-- 
2.54.0.175.g8bd0ec98dc3
