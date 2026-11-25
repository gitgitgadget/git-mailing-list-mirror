Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795571093;
	b=NaDEnbvo+e8BpLiHLp3Kvu8l7yjdx9iW/vfIQEnAf4yZ66MItWdUExtcd5SEqEevjw+C
	 +5e6KYFnUBiVIRftPCKPDH/x/zoJQmxXbgbFVRHJKRyuBOLhrv0l8XarHJrUkAJo0ViOL
	 Z3jMMF3VIFQDpsR/K4CFqxWcbPwygCiOMrjrnGuMYzWmVwmzAeC6U3yGUi9lSL4vD+em2
	 KOKUhknyaFJQPdedjyskptSRvh0L9vGn3TWaJoZfjDhWOKtgCmamKH3QZP4mebv2b+rST
	 NKV9IrSAM/UHfwZtW/1uc1SmIY/WoJwA0+WELsoH2exaDwMRiz9bikzSsAzqHbsriLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795571093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=7luoQz0pDdGZo79OSfGf3c6AxrxcPCO3z5laJsQgbG4=;
	b=evbl08NDHSXio1if9u6ia5GTcC3Z/v9SPTW4n5PGlhgqkRbFxIknPM60YnSNXBMYK/lY
	 faTGeK0NnGCGElorUeViyclZVCslaljMyfP4pONZS4PupbICSZnMVorcvcUNXXr5epbiE
	 CoAacfLYhFtVwkpIMQ/DZ7/AtomzknmlH6X1or0qnu4/3pgGCbUmxDjgjncklj4CZu3NU
	 LzWnge97ct514EXGM6V3A4RcA3gLhjDpbnN7M/UAgC6R7MuUzGQaeT+L75oPAPB+fGAwL
	 Nk7URrDhw4B8Hn3I0XUKte/rKQHOF/NgFH7EjGmzgLP1nMTWeBoGfdn0jls6qDHpaTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yle90DGf;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29560606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 01:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29560606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yle90DGf
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f0213202fdso27211705ad.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795571092; x=1796175892; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7luoQz0pDdGZo79OSfGf3c6AxrxcPCO3z5laJsQgbG4=;
        b=Yle90DGfv5rZoUeVRBCfiSBxD2Yp8JAYV3611llGQJHXz7AhPtUBBfs4J5jGbsKoSl
         st/K0ImPrBn3rMUDXW1zznIaVM9bkg+7QAlkWWkVBfge7mXIfQeitC9vrXvTIsoBd5VH
         DDbh+ZMMNzJoDr5y1BY1TatqGRdWlcuD0Wzv1y5U+0SQxYoQxlaHC5QyttcJtFRerUmr
         K8uz44WJNuFy0o+z3tR271eDXLlD74pVgbTUFF/Gxp7oFl7D9gXMEw0qx7ndLE+lbum/
         T2RZ7f1yzgOjKK4NFkqp0yU5f/fxG+u7zUICO0iBV4YdR9WhQz4gkkaoJP9C3+S8q7UG
         eCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795571092; x=1796175892;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7luoQz0pDdGZo79OSfGf3c6AxrxcPCO3z5laJsQgbG4=;
        b=BncT9GIF4FxiRRd7t9cyq5AhSYMyeVfjPOBOTkbgyIq4Qt4YwO5aaujA/pN9ba1/eF
         SQQ2m5xzkqZJlQJV8OVutWONwgL2yf0LjWUt/HaS/+2NrIzXWInFeqIzMVYLrRSARpPC
         ld/nhz7G20MWkJWSSua++EQk6ZuLzoFUCIWB5W0+KfJ9eC+DpBqTgdeQdFB41oUjhTaO
         yktD/MpD/gUbPkQyD54o3YAeRHJwOvHslRTva/W0yNUu8R6hNXasgSmdA2elnSuSiMBo
         QsMBZX+81DuVwQUbi6RWPTDCKqi7nqXRzcMLvPDmGIB4T0iZ6YSg0hk71le2qOzeyB5V
         LOFQ==
X-Gm-Message-State: APuU4Z+TobiyovkLpygsdJ0pSsQQyrSc+pGd4WjkLpQn7sM8oM2ag1ZS
	gE6s4qjlyX4Yp3zIUnN8Hvy4xX618IYoSmPdlkPLHpEmUHwMsdv7ICF81tTPVQ==
X-Gm-Gg: AZFdTZe3ya0WyRZ16Ft3ahtV11IZ+nTlAlxddncy4RDfgaB7+DlHuOxcvG7JM+iIShP
	owQTOPCvrFczRS6Z1Np4KmzoOdLW2k77U3cXQtzRS7+Maj5tfR2oA/ImVUv5u+/LqLhdbAOV2J9
	NvQi7L9Y+hs2FCelsMUW3XJRJZ8yMy4SybZ+II0B7gf0xre8jxDljyJa+AHHrLE2GkBP7QCpKUi
	7hKaVhVOdM36Ia8Xoo+vdjImp0mBU5AxsLaXuUM1HIpDT55vkXD3MmPw1aImFzFS2Q250D061SY
	rmnWsgJiW+eo4f/RfZX7T2endh8eDRldrlae5MsZmQrkmP2htWx0igGVTgsqqCmjY6KSOKji6pR
	iKPhBQW71/JgIdZfJgIGuXh4iCC9D8WX9jU7B/4xTN6pySpY/SV0XoWQY3TNFEc7ygVg4XtJfuY
	doKbhVGzaHKAflN2ttaQigDos0jBeTLu/TJWGj+0VMLFBR7LwD/tcAJnbY3dD3r2iRRHrgyFmjZ
	fnFLJDYbvkiojGJIXapoJ0N17WjWhQCUO83G2zvasGBzf43PzljWSV7hEHbPnD1IbLoQ3RNhhI3
	j+wQkyMSxyEgbEphVTY0i2XQwidoNUL6gBcPkb6EFjm6M1t1APg=
X-Received: by 2002:a17:903:4b04:b0:2e4:adb3:c776 with SMTP id d9443c01a7336-2f03f1a17bamr146507355ad.24.1795571092348;
        Tue, 24 Nov 2026 17:44:52 -0800 (PST)
Received: from [127.0.0.1] ([4.242.29.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee848c1sm76150275ad.10.2026.11.24.17.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 17:44:51 -0800 (PST)
Message-Id: <pull.2314.v2.git.1795571091.gitgitgadget@gmail.com>
In-Reply-To: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
References: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
From: "Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 01:44:49 +0000
Subject: [PATCH v2 0/2] repack: write filtered-out objects as loose objects
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Martin Fick <mfick@nvidia.com>,
    Christian Couder <christian.couder@gmail.com>,
    Adithya Chakilam <achakilam@nvidia.com>

Some key-value object stores manage and retrieve Git objects individually.
The existing --filter-to option writes filtered-out objects into packs, so
using it with such stores requires unpacking the resulting packs before
importing the objects.

This series adds --filter-to-loose=dir to git repack, allowing filtered-out
objects to be written directly as loose objects into another object
directory.

With --filter-to-loose, repack streams the filtered pack into
unpack-objects, avoiding that extra step and the intermediate pack file. For
example:

git repack -a --filter=blob=1m --filter-to-loose=/path/to/objects

The destination is treated as a Git object directory.

The first patch adds the option for objects already stored in packs. The
second extends it to include loose objects excluded by the filter, so the
destination also receives those objects. Objects already present in the
destination are not rewritten. With -d, the source copies of those loose
objects are removed after all objects have been written successfully.

Adithya Chakilam (2):
  repack: add --filter-to-loose to write filtered-out objects as loose
    objects
  repack: also copy loose objects excluded by --filter-to-loose

 Documentation/git-repack.adoc |  15 ++-
 builtin/repack.c              |  36 +++++-
 repack-filtered.c             | 152 +++++++++++++++++++++-
 repack.h                      |  14 +++
 t/t7700-repack.sh             | 231 ++++++++++++++++++++++++++++++++++
 5 files changed, 441 insertions(+), 7 deletions(-)


base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2314%2Fachakilam-nv%2Ffilter-to-loose-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2314/achakilam-nv/filter-to-loose-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2314

Range-diff vs v1:

 1:  4488a1534e ! 1:  4157ce33a1 repack: add --filter-to-loose to write filtered-out objects as loose objects
     @@ Documentation/git-repack.adoc: SYNOPSIS
       	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
       	[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]
      -	[--filter=<filter-spec>] [--drop-filtered [--dry-run]]
     -+	[--filter=<filter-spec> [--filter-to-loose=<dir>]] [--drop-filtered [--dry-run]]
     ++	[--filter=<filter-spec> [--filter-to-loose=<directory>]] [--drop-filtered [--dry-run]]
       
       DESCRIPTION
       -----------
     @@ Documentation/git-repack.adoc: depth is 4095.
       	`objects` and `objects/info/alternates` sections of
       	linkgit:gitrepository-layout[5].
       
     -+--filter-to-loose=<dir>::
     -+	Like `--filter-to`, but treat `<dir>` as an object directory
     -+	and write the filtered out objects there as loose objects
     -+	instead of as a pack. Cannot be combined with `--filter-to`
     -+	or `--max-pack-size`. Objects already present in `<dir>` are
     ++--filter-to-loose=<directory>::
     ++	Like `--filter-to`, but treat `<directory>` as an object
     ++	directory and write the filtered out objects there as loose
     ++	objects instead of as a pack. The directory must already
     ++	exist. Cannot be combined with `--filter-to` or
     ++	`--max-pack-size`. Objects already present in `<directory>` are
      +	not rewritten. All objects are written before any existing
      +	pack is removed.
      +
     @@ Documentation/git-repack.adoc: depth is 4095.
       	instead of keeping them in a separate packfile, reclaiming the
      
       ## builtin/repack.c ##
     +@@
     + #define DISABLE_SIGN_COMPARE_WARNINGS
     + 
     + #include "builtin.h"
     ++#include "abspath.h"
     + #include "config.h"
     + #include "environment.h"
     + #include "parse-options.h"
      @@ builtin/repack.c: static const char *const git_repack_usage[] = {
       	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
       	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
       	   "[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]\n"
      -	   "[--filter=<filter-spec>] [--drop-filtered [--dry-run]]"),
     -+	   "[--filter=<filter-spec> [--filter-to-loose=<dir>]] [--drop-filtered [--dry-run]]"),
     ++	   "[--filter=<filter-spec> [--filter-to-loose=<directory>]] [--drop-filtered [--dry-run]]"),
       	NULL
       };
       
     @@ builtin/repack.c: int cmd_repack(int argc,
       			   N_("pack prefix to store a pack containing pruned objects")),
       		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
       			   N_("pack prefix to store a pack containing filtered out objects")),
     -+		OPT_STRING(0, "filter-to-loose", &filter_to_loose, N_("dir"),
     ++		OPT_FILENAME(0, "filter-to-loose", &filter_to_loose,
      +			   N_("object directory to write filtered out objects into as loose objects")),
       		OPT_BOOL(0, "drop-filtered", &drop_filtered,
       				N_("delete filtered out objects (requires --filter)")),
     @@ builtin/repack.c: int cmd_repack(int argc,
      +	die_for_incompatible_opt2(!!filter_to_loose, "--filter-to-loose",
      +			!!po_args.max_pack_size, "--max-pack-size");
      +
     -+	if (filter_to_loose)
     ++	if (filter_to_loose) {
     ++		if (!is_directory(filter_to_loose))
     ++			die(_("'%s' is not a directory"), filter_to_loose);
      +		filter_to = filter_to_loose;
     ++	}
       
       	if (dry_run && !drop_filtered)
       		die(_("--dry-run only takes effect with --drop-filtered"));
     @@ repack-filtered.c: int write_filtered_pack(const struct write_pack_opts *opts,
      -	if (ret)
      +	if (ret) {
      +		if (opts->loose) {
     -+			close(unpack.in);
     ++			/* start_command() already closed cmd.out, i.e. unpack.in */
      +			finish_command(&unpack);
      +			sigchain_pop(SIGPIPE);
      +		}
     @@ t/t7700-repack.sh: test_expect_success '--filter-to stores filtered out objects'
      +	fi
      +}
      +
     -+test_expect_success '--filter-to-loose failure to write leaves the source intact' '
     ++test_expect_success '--filter-to-loose requires an existing directory' '
     ++	setup_loose_src &&
     ++
     ++	ls loose-src.git/objects/pack/*.pack >packs-before &&
     ++	test_must_fail git -C loose-src.git -c repack.writebitmaps=false \
     ++		repack -a -d --filter=blob:limit=1k \
     ++		--filter-to-loose=../no-such-dir 2>err &&
     ++	test_grep "no-such-dir.*is not a directory" err &&
     ++	test_path_is_missing no-such-dir &&
     ++
     ++	ls loose-src.git/objects/pack/*.pack >packs-after &&
     ++	test_cmp packs-before packs-after &&
     ++	git -C loose-src.git cat-file -e $big
     ++'
     ++
     ++test_expect_success POSIXPERM,SANITY '--filter-to-loose failure to write leaves the source intact' '
      +	setup_loose_src &&
     -+	>not-a-dir &&
     ++	mkdir read-only &&
     ++	chmod a-w read-only &&
     ++	test_when_finished "chmod u+w read-only" &&
      +
      +	ls loose-src.git/objects/pack/*.pack >packs-before &&
      +	test_must_fail git -C loose-src.git -c repack.writebitmaps=false \
      +		repack -a -d --filter=blob:limit=1k \
     -+		--filter-to-loose=../not-a-dir &&
     ++		--filter-to-loose=../read-only &&
      +
      +	ls loose-src.git/objects/pack/*.pack >packs-after &&
      +	test_cmp packs-before packs-after &&
     @@ t/t7700-repack.sh: test_expect_success '--filter-to stores filtered out objects'
      +	git -C loose-src.git cat-file -e $big
      +'
      +
     ++test_expect_success '--filter-to-loose resolves a relative path from a subdirectory' '
     ++	rm -rf sub-work extra-loose-objects &&
     ++	git init sub-work &&
     ++	test-tool genrandom big 2k >sub-work/big &&
     ++	git -C sub-work add big &&
     ++	test_tick &&
     ++	git -C sub-work commit -m big &&
     ++	big=$(git -C sub-work rev-parse HEAD:big) &&
     ++	# objects in the index are never filtered out
     ++	git -C sub-work update-index --force-remove big &&
     ++	git -C sub-work repack -a -d &&
     ++
     ++	mkdir extra-loose-objects &&
     ++	mkdir -p sub-work/sub/dir &&
     ++	(
     ++		cd sub-work/sub/dir &&
     ++		git -c repack.writebitmaps=false repack -a -d \
     ++			--filter=blob:limit=1k \
     ++			--filter-to-loose=../../../extra-loose-objects
     ++	) &&
     ++
     ++	test_path_is_file extra-loose-objects/$(test_oid_to_path $big)
     ++'
     ++
      +test_expect_success '--filter-to-loose does not move objects from kept packs' '
      +	setup_loose_src &&
      +
     @@ t/t7700-repack.sh: test_expect_success '--filter-to stores filtered out objects'
      +'
      +
      +test_expect_success '--filter-to-loose requires --filter, rejects --filter-to and --max-pack-size' '
     ++	mkdir -p x y &&
      +	test_must_fail git -C bare.git repack -a --filter-to-loose=../x 2>err &&
      +	test_grep "can only be used along with" err &&
      +
 2:  ba2534e3bc ! 2:  0f1f0356b4 repack: also copy loose objects excluded by --filter-to-loose
     @@ Documentation/git-repack.adoc: depth is 4095.
       	pack is removed.
       
      +	Loose objects in this repository that the filter excludes are
     -+	copied to `<dir>` as well, and with `-d` the source copies are
     ++	copied to `<directory>` as well, and with `-d` the source copies are
      +	removed once everything has been written.
      +
       --drop-filtered::
     @@ t/t7700-repack.sh: setup_loose_src () {
      +	git -C loose-dst.git fsck
      +'
      +
     - test_expect_success '--filter-to-loose failure to write leaves the source intact' '
     + test_expect_success '--filter-to-loose requires an existing directory' '
       	setup_loose_src &&
     - 	>not-a-dir &&
     -@@ t/t7700-repack.sh: test_expect_success '--filter-to-loose failure to write leaves the source intact
     - 	git -C loose-src.git cat-file -e $big
     + 
     +@@ t/t7700-repack.sh: test_expect_success '--filter-to-loose resolves a relative path from a subdirect
     + 	test_path_is_file extra-loose-objects/$(test_oid_to_path $big)
       '
       
      +test_expect_success '--filter-to-loose failure to copy a loose object leaves the source intact' '

-- 
gitgitgadget
