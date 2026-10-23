Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785801;
	b=uWapB0i3h0Gd5bgRjsgZt2hcydr3ckMac3sYPZ/SSrmruMQzB1fE5R7heh+V/5G7kVBp
	 ztpPF5DsFTTP+9S/0VlvTRl6VmGIvRZcNWCEx/5nmI2aWl7EXCSp8JGj+egxm8RZGYvQL
	 uKmKWQIW+pkK6LWbe9Eo88FWS/AIfmoutN7B/zpCPem5aru9c2Om3NWmMiU0I3+TUm4Dx
	 RbUsU0Ep/apyRV1dIDN7ctOyzrYksq+GGnd9/jqFJzKFWxK7ws3Puuswk7cUrRqNewsRf
	 q+mVwQP5x9NPF1kVz9+O9FYD/3Ci1W43v94FsmTOWPQaAkZ0LzdiR2PThrZhmXw7sPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=nZ3I1zCnTptxS1LjKRnAu3qsqBqFZeSDro+C9av3ktw=;
	b=0MhWfhFvO1gpp0v117lADkDsunSqX85rdYwwRNqskWI2eplQDKhZLeegLU/tN2ol4jBg
	 AzOfUAiyGi1EGz7S5/gKG5fVQ4B81RWuFuqw8At6ZRfEfmokOiuHSASb6GRm5P9gUuxnP
	 V/UqKqPW9U5InX2Pxi3G4PKVNujIOB/eudWi1PDqKgraawCpv+aEuBO3IZ92ek/WL+x05
	 rj2sjYE55Pdit0SUm6NctbhKjshA0oof+wLvwYZqs7i2EbO3T6CNfPP6hx9kaKhtYrtYo
	 EgDrmke2Me9g0qPVRD2kddwJxjQDm+bCKqa4ZFwu6bKMFx8PdLdrHYEZxwlX0beBHCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S+hjv6Dt;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A1606A33D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 20:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 707A1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S+hjv6Dt
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f30660e69so94888385a.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785800; x=1793390600; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nZ3I1zCnTptxS1LjKRnAu3qsqBqFZeSDro+C9av3ktw=;
        b=S+hjv6DtmUFw7QcEtDaZQOACyolsD1ctCI3ZrRJKEg1aHpgpzQ0REqm4AlM/RQ8aiQ
         WcMSQdXzoXpcVZZoc05Ues/wb4wlJ87R9mAsKn1IygI9iSIx4HyXdk2PRJffMy87xOqb
         a4LdxejZ1nc7w5dx3cagpj4l2rZReul1O0rLKQwnu6lui32MNt1q2ZJZE/n+TWp9I3by
         p4/PxsoX8wb73v6ImzzerX8OQeQuyR0mqmU9n25hNdaK3X1jkvnsT6tEY3XNeYpGE3gl
         xFjCM9o7LUO8ZF0oABF/q5kBbxZDcm6TgKHTPSBrgzaaZKg/kecOBbhYAIRVWnxj/hcG
         2cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785800; x=1793390600;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZ3I1zCnTptxS1LjKRnAu3qsqBqFZeSDro+C9av3ktw=;
        b=2nchPwMU9GaAXaDvI6eG/Mz46ScVAkADiOR9ZccUr23geVjFMVWsVO3YYHK4bG552F
         SB8eR82ZR7EYXHiVStWHnNBhLX353uSyecpLHGh5i9bq11sY0PIz0QdHOSbXCgsiG+pD
         gv5jnw/ju202JSndvDiwB0Uzjdnyvot+y69xd5siZkIUwyb/kHa/U6LvJiLrYm26Y1Kf
         3BUOciIimQmYn4rMNbFh4HvO24AsMk74Kaar7CJ0IX7AKJXKU5JkE0gYpRUu3V5ayf9L
         W6sSmVUqFQpZbFH0ENg4ykjtV2BoP3QKkENTs2CHJcjR6lvLQmw+makjGrzj3wXv9QCd
         wLOg==
X-Gm-Message-State: AFq9FYKIeyey9jAIar2wZJaeIQ32RObZ/00mbicZtF9XNbDZfcsiDmHD
	/fxrvMUY16dASAEvkqGEXGQgXfkIAJz/YTJ4iT9HNJYBjurZGPpsp11N3tCkSA==
X-Gm-Gg: AYBFou37cnMZWmdmnHuenUhTHYEMNE1fN57fd5gdUY4TelWX6qzcXkSVpJIrmJvKXJc
	LYBPeAOda+ZO7IhfKHtFopGUoFg8oWCTVxtx8U/p84kbSX/9GvWdzEdW7e898mz7GINLyTh4bK0
	QdzZSG8tInCoKQY72ThZe9YeUuWuxuEws7dMbia4qd1Guuf9GCin8vrLDDfsV8+rhxUY/nunal/
	1gU1y18Lveyj0My2MqrYwMLdFNmiSh2ycUSr6QFsGeQqkoE1Y8xhcl55sEOXo9GyBAC80vJDCOJ
	7PA8Yvcb15MiggTcY/vtSdxudzCKEXQty/oD2GDAOnL5ozNRP4gRJRIqamQ4w4RUL6c+f3ua3F9
	o91z5inPuVNlpkutnRxFxXIgGXeDklPlpoMT0dtdJUu6DSIZ8tSBQTlQUwUSNydts25EDGxOIng
	tX7A6r+7m/RiTAarCa3SXW4GrVLf11SwgHywgctUUFTWry0DSxBMTEWdSkfvoEtuMP1n0eNY/NY
	+Ogn5zutg2hcOgdOsDZUpaztWk9zP42Gowz8P0gR7bojx6cxsRx2RmBFhsjtfeBaDDC/scbHcCn
	dQj0XksGryqa2yLUo2XhwPijmvwWbBBKhmWj5TYj791mDXalneqbSYk4vQlADhTTsO9epK4LljX
	GpKs4si9GIM+kPeVOpMMv7iJ04advShT5OuQe1tQk5Nw8+JL8fU4/3M9DRF1l3bd+HkmjcJwoPV
	hi4qGeHa2fyRaleICxe2NVSsgZg1l8mIPPkEQj
X-Received: by 2002:a05:620a:4542:b0:93b:d7a3:45cc with SMTP id af79cd13be357-940ef96b7eemr13252985a.53.1792785800305;
        Fri, 23 Oct 2026 13:03:20 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-eastus-03.tradc-corp.com. [40.76.104.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9402ee2cbffsm104288785a.2.2026.10.23.13.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 13:03:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v3 0/3] ls-files: reuse and update the untracked cache
Date: Fri, 23 Oct 2026 16:03:03 -0400
Message-Id: <20261023-ls-files-untracked-cache-v3-0-292260e95f53@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NyQ6CMBRFf4V07TOlZXTlfxgXHR5QZTAtNBrCv
 9vixiXLk9x7zkocWoOOXJKVWPTGmWkMwE8JUZ0YWwSjAxNGWUFrxqF30JgeHSzjbIV6ogYlVIf
 A87yWqGkqOJJwf1lszHtX3+4/dot8oJqjLy464+bJfva2T+PuQManQIFWWmZKpdhoeW0HYfqzm
 gYSM54dFbEg0iUi51lZoKz+Rdu2fQHyvBjCGwEAAA==
X-Change-ID: 20260923-ls-files-untracked-cache-3559bed01a3e
In-Reply-To: <20260923-ls-files-untracked-cache-v2-0-d7ee33476eb8@gmail.com>
References: <20260923-ls-files-untracked-cache-v2-0-d7ee33476eb8@gmail.com>
To: git@vger.kernel.org
Cc: Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>, 
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1792785791; l=9023;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=DMxUGReasMJc0IgCsvdngNrzTm7UM2vJXgUtvoVjCbQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMQmlPtRIVlWLn2mj50dAckBX3KaWZwRjBp64FEo+jZLQICz3YzoFp++OAcT3+TYQJ7hdLi76z9
 U44KKlBm2vAE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Repeated queries such as

  git ls-files --cached --others --exclude-standard -z -- "**/pyproject.toml"

walk the working tree even when status has populated an untracked cache.
This series lets ls-files reuse those listings and save the work for later
commands through Git's existing optional index writes.

The first patch fixes inconsistent ignore-file hashes that invalidate an
unchanged cache. The second lets 'git status -unormal' and
'git status -uall' reuse the same cache. 'git status -unormal' still stops
scanning an untracked directory after finding an untracked file; a later
command requesting all untracked files completes the listing as needed.
The third lets ls-files use the cache and write pending untracked cache
and fsmonitor updates back to the index. --no-optional-locks suppresses
those writes.

For wildcard pathspecs without a fixed prefix, apply the pathspec after
reading complete directory listings. A first query can therefore scan
directories that its pathspec would otherwise skip. Fixed-prefix,
attribute and exclude pathspecs retain their existing traversal.

A new dir_flags value makes older versions of Git rebuild the cache before
using it to list untracked files. Changes invalidate cached entries in
parent directories as well, so updates can reopen more directories than
a cache populated with --untracked-files=all before this series.

On macOS, with 100,000 files in 5,000 leaf directories, half tracked.
Each group of 100 leaf directories has 50 tracked and 50 untracked.
Each binary populated its own cache using the indicated status mode.

hyperfine --warmup 3 --runs 7 (mean ± standard deviation, milliseconds):

  cache   fsmonitor  command          upstream        v1             v2
  normal  off        query            241.3 ± 14.8    132.7 ± 20.0   33.3 ± 2.4
  normal  off        query + status   292.7 ± 11.2    187.0 ± 10.8   92.6 ± 3.3
  all     off        query            231.3 ± 14.6    29.3 ± 1.3     34.7 ± 2.0
  normal  on         query            223.1 ± 17.8    111.0 ± 13.4   33.8 ± 1.5
  all     on         query            216.6 ± 12.0    28.0 ± 5.1     34.6 ± 0.8

"query" is the ls-files command above; "status" is
"git status -unormal --porcelain". These are repeated queries with warm
filesystem and untracked caches.

Assisted-by: LLM
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v3:
- Release the index lock after reading the directory, before printing any
  paths. A slow reader of ls-files output can no longer block index writers.
- Skip the optional write with --debug so the listing shows the stat data
  read from the index.
- Link to v2: https://patch.msgid.link/20260923-ls-files-untracked-cache-v2-0-d7ee33476eb8@gmail.com

Changes in v2:
- Share the cache between --untracked-files=normal and --untracked-files=all.
- Write ls-files untracked cache and fsmonitor updates back to the index.
- Test alternating modes, cache invalidation and optional index writes.
- Replace the v1 measurements with results for the revised implementation.
- Link to v1: https://patch.msgid.link/20260923-ls-files-untracked-cache-v1-0-08db4cc1efdb@gmail.com

---
Tamir Duberstein (3):
      dir: hash ignore files before appending newline
      dir: share untracked caches across output modes
      ls-files: use and update the untracked cache

 Documentation/git-ls-files.adoc    |   4 +
 Documentation/gitformat-index.adoc |  13 +-
 builtin/ls-files.c                 |  59 +++++---
 dir.c                              | 251 +++++++++++++++++---------------
 dir.h                              |  16 +--
 t/perf/p3010-ls-files.sh           |  15 ++
 t/t3001-ls-files-others-exclude.sh |  20 +++
 t/t7063-status-untracked-cache.sh  | 288 +++++++++++++++++++++++++++++--------
 t/t7519-status-fsmonitor.sh        |  44 ++++++
 9 files changed, 506 insertions(+), 204 deletions(-)

---
Range-diff versus v2:

1:  d45e8c7ea9 = 1:  fb0b53b2cc dir: hash ignore files before appending newline
2:  b2ea9e163c = 2:  ca78501354 dir: share untracked caches across output modes
3:  a84c08dabe ! 3:  4622b804a6 ls-files: use and update the untracked cache
    @@ Commit message
         options can be processed in the same order before reading the index.
     
         A pathspec prefix can prune the in-memory index, and --with-tree can add
    -    entries to it. Do not write the index in those cases. Respect
    -    --no-optional-locks and continue without writing when the index lock is
    -    busy.
    +    entries to it. Do not write the index in those cases or with --debug,
    +    which prints stat data that an index write can change. Respect
    +    --no-optional-locks and continue without writing when the lock is busy.
    +
    +    Finish the optional update after the directory walk and before printing
    +    paths, so a slow reader cannot block another index writer.
     
         Assisted-by: LLM
         Signed-off-by: Tamir Duberstein <tamird@gmail.com>
    @@ builtin/ls-files.c
      #include "object-name.h"
      #include "strbuf.h"
      #include "parse-options.h"
    +@@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
    + 	int i;
    + 	struct strbuf fullname = STRBUF_INIT;
    + 
    +-	/* For cached/deleted files we don't need to even do the readdir */
    +-	if (show_others || show_killed) {
    +-		if (!show_others)
    +-			dir->flags |= DIR_COLLECT_KILLED_ONLY;
    +-		fill_directory(dir, repo->index, &pathspec);
    +-		if (show_others)
    +-			show_other_files(repo->index, dir);
    +-		if (show_killed)
    +-			show_killed_files(repo->index, dir);
    +-	}
    ++	if (show_others)
    ++		show_other_files(repo->index, dir);
    ++	if (show_killed)
    ++		show_killed_files(repo->index, dir);
    + 
    + 	if (!(show_cached || show_stage || show_deleted || show_modified))
    + 		return;
     @@ builtin/ls-files.c: int cmd_ls_files(int argc,
      	struct dir_struct dir = DIR_INIT;
      	struct pattern_list *pl;
    @@ builtin/ls-files.c: int cmd_ls_files(int argc,
      
     +	/*
     +	 * Do not save an index pruned by a pathspec or changed by --with-tree.
    ++	 * --debug shows stat data that writing the index can change.
     +	 * With index.skipHash, the checksum cannot detect concurrent index
     +	 * changes. Lock the index before reading it.
     +	 */
     +	if (show_others && !dir.flags && dir.exclude_per_dir &&
    -+	    !max_prefix && !with_tree && use_optional_locks() &&
    ++	    !max_prefix && !with_tree && !debug_mode && use_optional_locks() &&
     +	    !dir.internal.unmanaged_exclude_files && !exclude_list.nr &&
     +	    repo->settings.core_untracked_cache != UNTRACKED_CACHE_REMOVE)
     +		index_fd = repo_hold_locked_index(repo, &index_lock, 0);
    @@ builtin/ls-files.c: int cmd_ls_files(int argc,
      
      	/* Treat unmatching pathspec elements as errors */
     @@ builtin/ls-files.c: int cmd_ls_files(int argc,
    - 		ret = 1;
    + 		overlay_tree_on_index(repo->index, with_tree, max_prefix);
      	}
      
    -+	if (index_fd >= 0) {
    -+		if (!ret && dir.untracked)
    -+			repo_update_index_if_able(repo, &index_lock);
    -+		else
    -+			rollback_lock_file(&index_lock);
    ++	if (show_others || show_killed) {
    ++		if (!show_others)
    ++			dir.flags |= DIR_COLLECT_KILLED_ONLY;
    ++		fill_directory(&dir, repo->index, &pathspec);
     +	}
     +
    - 	string_list_clear(&exclude_list, 0);
    - 	dir_clear(&dir);
    - 	free(max_prefix);
    ++	/* Don't hold the index lock while writing paths to stdout. */
    ++	if (index_fd >= 0 && dir.untracked)
    ++		repo_update_index_if_able(repo, &index_lock);
    ++	rollback_lock_file(&index_lock);
    ++
    + 	show_files(repo, &dir);
    + 
    + 	if (show_resolve_undo)
     
      ## dir.c ##
     @@ dir.c: static int add_patterns(const char *fname, const char *base, int baselen,
    @@ t/t7063-status-untracked-cache.sh: test_expect_success 'filtered status retains
     +		test_cmp_bin ../saved-index .git/index
     +	)
     +'
    ++
    ++test_expect_success 'ls-files --debug shows the stat data read from the index' '
    ++	(
    ++		cd persistent-cache &&
    ++		git config core.trustctime false &&
    ++		printf one >tracked/racy &&
    ++		test-tool chmtime =1000000000 tracked/racy &&
    ++		git add tracked/racy &&
    ++		printf two >tracked/racy &&
    ++		test-tool chmtime =1000000000 tracked/racy .git/index &&
    ++
    ++		git --no-optional-locks ls-files -co --exclude-standard --debug >../expect &&
    ++		git ls-files -co --exclude-standard --debug >../actual &&
    ++		test_cmp ../expect ../actual
    ++	)
    ++'
     +
      test_done
     

---
base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
change-id: 20260923-ls-files-untracked-cache-3559bed01a3e

