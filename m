Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A44071C4
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780846867; cv=none; b=rqTDhRAVFDLsZxOiFrCA0J8fHVHd4ev6UxbXyZLOGJLZhlX0VTXYxL8Cc+8aYLl/vijtuILY1HisenfxymtFoxvzlMi50TIhjp6PpKOKgjGnmKg0pem8WdQb4853PSwZgohbINP5y3c5LeC9gpfaomG8r2D/o/q2k7DHW5Z2ugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780846867; c=relaxed/simple;
	bh=giXUPEtapXkTaoKiplxBvNn23HURdO6lMvY9lWNYdmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S2bEw9DEk3UgpqdX1AXX1Ctx6MLazRTw0hyHSsuqUKrsCyZI5MsqUaVAoP1i0dEjand3l4Ou/W9OPlqebekC91bazAeoAlSWiocP8YLJ2s2d7e+GUGpt5PAjwwrRWJcNdZ+i0udGlVDvahDHPWon6t6TZRXrnQfXIDo1psgwkJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ooAN7bKS; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooAN7bKS"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ccf6a63a45so45184056d6.3
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780846865; x=1781451665; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IjvnN1EpqB1WCXfpKvRpOynEwjQKrcUpx8EEDbjqbdQ=;
        b=ooAN7bKSXcwb5Z4qiu4Zykr2pUtpPQzNt2bl9eRsW7Fuu6sJWab2n2RME+Ez+1xFin
         JDX5oOU3W6CxInY7lJLggbVnsnwUyZbiwkqcWNv5+zuPHEkjjvbe2wbyBiT/MnRV8Cjq
         WH2vRKVFRvduvXFJqqC3LmFGLjudH4FGQg2POq973PlBId4JCHHZvVS9QKdDANQtRKSV
         0E4ENWxccmRE08YtXfiyyiPb5spEtrqTfgR6bHS5no/pi63dnnv36ECSI4w7hrGi7o/Y
         zDi3mZwFPY14mjCjMcd5mqx9nw6mWCcVcedx/NouKQsuRPhhZF+dhxkGAtkZqlIvSGJy
         wL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780846865; x=1781451665;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjvnN1EpqB1WCXfpKvRpOynEwjQKrcUpx8EEDbjqbdQ=;
        b=JicRpcVKlJBpfRAqSiAy4Ma3ULFt3mj0/bhbkxv6xinCBBGCv7pac7tMr5dy7hWxbl
         6SHwiQUVfOOI+Vr0EPiS2xotHKsfvwRyXbkdClxIIWGxztkQK2774QB0odvnYSf8YT3N
         OnWiimSpqHvCKbGJD+SB3tU054KAzwFtdOtzep6Deq/rvrq/YnPV7zIVjl+dU/4V8Kjm
         iAMxD64l8/KT4IxSE/HS/zZ9I9oQmnxqNQQuZJd7I/BShEWFsKvZBOSxE6R44gje76+j
         WYBPbVNynN2rcEN2ww+2FTZbW56sMLUTgBq+IGqhkW/Y7bqOn8UWetqOkjQv0McG+S/t
         +9vQ==
X-Gm-Message-State: AOJu0YxGDeLIvQYMFJecYToHy9mqgWE+8S1MvR1xaDDQDUhTj960iUvC
	m8c79IxCWbyS0LvPjk+oplRO/YVdbNwgqbC201cryNgUbyBSwJj0/fRm1CH/a9mK
X-Gm-Gg: Acq92OEPi9ikTYoLkMLz3eNzlUrQFnTPNiLWTn7reVftiKx7XaAUsg+EjzuZ7G8TFij
	7HsKF+9T9e4PsB5f3yopFs7uzZbukQXNGezZne9jYwk8iP4am1tUkCfFOUCB0EW2KUC/XaY0tdj
	RgQjsTkbJws8d0pL79N88iKrHN0avbDrt1LS8I8uKLCSULMySVDpHId/+X39q4TImDRJSGMEVWI
	vdetEMAl7ELaVvmwnGbkFrlt47ZYkjSaMObbjjQeCIRS01dKy4+amcaj2dmUtE5RqiTaU9lYVSX
	jNBYiDh8XCHmEYPCN2f6cR36Ree6edpPcDnp0aQKIfCtZiYq9uA3Rv3ds3erjpiFJ2bNCIE7Fn/
	cqgCxoxlA0n5V6bn6xNa60JrY80YRqQ68i6W2DNLeYsyNYzQj0b+7tQcNxXWCKWuMm0Yp92Iu7g
	UgtkmccuXQqttUa3aRszxzJn/Myl/HQCQT0ppUUWnzKpKvaJZlN/8iuN0AF9glJjYmfpiN5GA3F
	4Vrbk9GhLPzF7JPmVkSHpcTJuty7oNBcxkBLUc60p753wfqlliqMGfSfmI5YLcEf3bI4B1g4kDl
	Qcd10UTrmGwCl45qT6FJMkkxXs2D3NTITddthwy1kq8Uxi9MKTobhgtQJZBY1r7hlSp4SoaiqlU
	=
X-Received: by 2002:a0c:fde3:0:b0:8ce:ca78:409c with SMTP id 6a1803df08f44-8cee5fe4e78mr135886746d6.10.1780846865320;
        Sun, 07 Jun 2026 08:41:05 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:e0ef:ca81:71c:3b00])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06f5eesm138079536d6.37.2026.06.07.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 08:41:04 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 07 Jun 2026 11:40:56 -0400
Subject: [PATCH] ls-files: filter pathspec before lstat
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB2IwUTpVYqLGEcdERsyaRHEu
 5vq8nvw/gOEIpPAqzgg0o+FP1tGVRbgZ7dNhDxkg1baKqsaXAVHXkkwuDRLIJ+X5BK2ram0cWa
 wdQ35HSKNvN/ld/dYvv1CPv1zcJ4X1ZU5DHsAAAA=
X-Change-ID: 20260607-ls-files-pathspec-lstat-885125a5d644
To: git@vger.kernel.org
Cc: =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1780846864; l=4447;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=giXUPEtapXkTaoKiplxBvNn23HURdO6lMvY9lWNYdmo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBgoh4tYWpx+x/5t7JHsLLi5WL30eWrAdbqcjfnmRDZbBa8gN1USjaeRn1xijrim/NwSmbjIPYh
 Ubk1sQLzq6QU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

show_files() checks whether each index entry is deleted or modified
before show_ce() applies the pathspec. prune_index() avoids most of this
work for pathspecs with a common directory prefix, but a top-level name
or leading wildcard leaves every entry to be checked.

Match the pathspec before lstat() for the deleted and modified modes.
Keep the later match in show_ce() so --error-unmatch is satisfied only
by entries that are actually shown.

On a repository with 859,211 index entries, a 19,931,862-byte index, and
25,303,439 packed objects occupying 21.13 GiB, I ran the following
command with the parent and patched binaries:

    hyperfine --warmup 0 --runs 3 \
        'git -c core.fsmonitor=false ls-files --deleted -- README.md'

The results were:

             parent       this commit
  elapsed    60.742 s     1.061 s
  user        1.117 s     0.963 s
  system     10.740 s     0.042 s

Both revisions were built with -O3, -mcpu=native, and ThinLTO using
Apple clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro
(Mac16,6) with a 16-core Apple M4 Max (12 performance and four
efficiency cores) and 128 GB RAM.

Assisted-by: Codex gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 builtin/ls-files.c                  |  7 +++++++
 t/meson.build                       |  1 +
 t/perf/p3010-ls-files.sh            | 27 +++++++++++++++++++++++++++
 t/t3010-ls-files-killed-modified.sh | 18 ++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e1a22b41b9..702c607183 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -450,6 +450,13 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			continue;
 		if (ce_skip_worktree(ce))
 			continue;
+		/* Only entries shown by show_ce() satisfy --error-unmatch. */
+		if (pathspec.nr &&
+		    !match_pathspec(repo->index, &pathspec, fullname.buf,
+				    fullname.len, max_prefix_len, NULL,
+				    S_ISDIR(ce->ce_mode) ||
+				    S_ISGITLINK(ce->ce_mode)))
+			continue;
 		stat_err = lstat(fullname.buf, &st);
 		if (stat_err && (errno != ENOENT && errno != ENOTDIR))
 			error_errno("cannot lstat '%s'", fullname.buf);
diff --git a/t/meson.build b/t/meson.build
index 2af8d01279..ee8086e6ef 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1140,6 +1140,7 @@ benchmarks = [
   'perf/p1500-graph-walks.sh',
   'perf/p1501-rev-parse-oneline.sh',
   'perf/p2000-sparse-operations.sh',
+  'perf/p3010-ls-files.sh',
   'perf/p3400-rebase.sh',
   'perf/p3404-rebase-interactive.sh',
   'perf/p4000-diff-algorithms.sh',
diff --git a/t/perf/p3010-ls-files.sh b/t/perf/p3010-ls-files.sh
new file mode 100755
index 0000000000..bb80768063
--- /dev/null
+++ b/t/perf/p3010-ls-files.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='Tests ls-files worktree performance'
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+test_expect_success 'select a zero-prefix pathspec' '
+	tracked_file=$(git ls-files | sed -n 1p) &&
+	test -n "$tracked_file" &&
+	pathspec="?${tracked_file#?}" &&
+	test_export pathspec
+'
+
+test_perf 'ls-files --deleted with pathspec' '
+	git -c core.fsmonitor=false ls-files --deleted \
+		-- "$pathspec" >/dev/null
+'
+
+test_perf 'ls-files --modified with pathspec' '
+	git -c core.fsmonitor=false ls-files --modified \
+		-- "$pathspec" >/dev/null
+'
+
+test_done
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 7af4532cd1..6e38e10219 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -124,4 +124,22 @@ test_expect_success 'validate git ls-files -m output.' '
 	test_cmp .expected .output
 '
 
+test_expect_success 'worktree modes honor wildcard pathspecs' '
+	cat >.expected <<-\EOF &&
+	path2/file2
+	path3/file3
+	EOF
+	git ls-files --deleted -- "path?/file?" >.output &&
+	test_cmp .expected .output &&
+
+	cat >.expected <<-\EOF &&
+	path7
+	path8
+	EOF
+	git ls-files --modified --error-unmatch -- "path[78]" >.output &&
+	test_cmp .expected .output &&
+
+	test_must_fail git ls-files --modified --error-unmatch -- path10
+'
+
 test_done

---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260607-ls-files-pathspec-lstat-885125a5d644

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

