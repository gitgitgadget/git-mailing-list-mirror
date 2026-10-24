Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792819536;
	b=SGqGEQYRCcAsIcXnOfWZ2ErUiTdcm6pYERD8EWwqjCED9VvK9xDcjdoIgoW/a2nUMYXk
	 WxrxM+Jgi2UjLow+NhuvXfTU+ZpOn6ksGL6steV0czxD3u1G3nUXRKP3q6PaoWFvaFYMw
	 1OytZUx0ZXGFvFy248e+oOXf82OesHy7Y0x1xc1xjpvCaLq1FDfl9jstuxnEjZOxTqRMj
	 CrPLXgZfl08Ts1FfulYwmCJbdwz+1d0XJNo1pHnR0ba41QSsyGvEJ98gPU//xF9fztKpV
	 0x9eZaIIy1HUeJjzcErDwxEXl060J9A5/Up4ee++IgSwuu/UHQK0b/WblWe/I64hFEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792819536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0n80RJdOUg1Wtzqvj1R1n5jnaBxw1c5QDSlslxFhsjM=;
	b=kHNcK2anR2Iva608k5D3MIOXzedYWe+7IJpZuLAVDsyPb93TXX7PC7N7K/GMLiRS34MS
	 x0Vi4v6g0r6HVOVtF8LPWWkDmse8I8ameusxZJ8DlVQTkFb+kIfgBRzBvExn+q/AFUo1O
	 b9+B+sJlg9grLn8GbWt2p+aIq+R8c7IzHbbO+vtaJwUk/GXTaN/8bRGjcqcDb0qK6MoYv
	 jTMtPDZ5kjs/z+fD79Gz7ktaZi1ElQxnGPeHOVDBoHSlWXq3FC111lmnY96+cVdPzddHO
	 KSY0ATExdDgg+IllByax5MZhIhU7dlg00d1z0PMM2/ir+ebd993kQrG7GLCWMDC9xdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kr3FLpsi;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749EE606A31E
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 05:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 749EE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kr3FLpsi
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a210470b49so11305755e9.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 22:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792819535; x=1793424335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0n80RJdOUg1Wtzqvj1R1n5jnaBxw1c5QDSlslxFhsjM=;
        b=kr3FLpsiTavDrHK5tCjFp0dhatWgFnsRLLVpicpgCsyylG2tqQ4ixddeQ2bEQNbKzH
         U0kjz2ZS20V8GSeA8egKbkR2H7mnJHVgZklPfVMw+C6SAi1kwIsAi3PljvgQt8mkH2bB
         CNtQE//9YH9bRZWjG2kjJ9iSQ89ixGBeWUo2nFF1mNy6rDkm5Gdincv5saKqVbIpVjyM
         C0lSraCBT5j6csRPO2ZbY3Qv1MSqy8ASR84342fC+K+1qfvj0zSipTPw3hVlJO75GMBi
         BZhIp4nr4d3BJQ/AvMNgoPcqAtfA8rSII+jYbATTqDV0Fel5fNzx60oD2xy1IQf+5Dcz
         BHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792819535; x=1793424335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0n80RJdOUg1Wtzqvj1R1n5jnaBxw1c5QDSlslxFhsjM=;
        b=ldybOasJUDAH8+yfmmq1cUhUXqfXShf22KyI6EGe2oXMscr1ySl1sRQ4MTckXGcI0f
         jqzhvSBnPZ5exdazqGFRikeb6EQQcCf2kh9Jv9vzaqkxQ3ftdjAUbF8Ayht2ENW7GZ3J
         iZmyCO2Y0U5uZSfS14gW1ZjyCEuhEElKv/PsAaFntrWZv5fUZ5Rr2JSiFR/ToijSLot6
         5+vBu+IniBommorlKLxDA8EjMY/zyh3gidQxkcnnAoF7hWUSRy60adrIrGJTyaL0R3Km
         m/CQ1ppfs6hkF+dRMVmDX5pz6+sWpuNXvdoFx2BmHTFquu7+sdYf89eyNfSkkd3rpJzY
         zyJw==
X-Gm-Message-State: AFq9FYKT8TRp2cFRQkh/vNWje5LhtzAIvB0FL95QYm0C0Prqn6zcad1p
	BiZSL7oFWyoDH7MHpK6QCkEcyc8WXpeVJ3x3rZsfm4/kFV96PjGjkIu1BFh1IUyw
X-Gm-Gg: AYBFou2pJDnibOQJYhmnyK2Cwx/5WsVDSjHHhSDV4waHn2mW3nvFUfMLU9RyOqQWPqn
	kQoGLEMFhVyeAYgPveNPNcPx1od3fmXcQ+hR1+/2nx3wQ5M9BL3D0n6Ucxh5i3Sytpl+LZsZfgI
	fQvsznxv/9kL86JVFrmXfF8sSoXdRRKcBnuJzO2Axj0+A4zW5Sbpl+NW3+tNluwSzMe7JzSTtSu
	QN6W81FK91/tsIK4APNQUM9I7Cladm03Etxr/DuWLn8vhrScIPM8333eHWe6tPycJyBZvB0KtvE
	OmW9Z3Vmi6zPMd9Q4QLfsPefWpqS+R3wdkWIGlC1gHk+j5MRU4AlsKYgpq8FBIEPFOIspZRiMKF
	5M8batHwetLkaWREOW3qa1GeCcX6MkOcPjdVq8Jo5JyzLMaIR376YrQBdCpJ0+tVotgB9OJlk9X
	SYsBn21TB6BXjemz1LNLP+0fIpgs0cIGSK976gejD4SIrzBvcVvDyTtmv49gkwcHsmEY9ZhLwId
	X734sdG8BWlmab4DqBTQeQQ0zI7p3eJDrr9/X3X3dw+46laFXhzR7FWBYVlwzqldzXtW2drX8ed
	oUEQAKSA0oqBZgBVin5vaaPVOMZvUsTVrEatpQJoGfH28ePSHgikiewLKj1r+RM=
X-Received: by 2002:a05:600d:82e5:b0:4a1:cd83:b23e with SMTP id 5b1f17b1804b1-4a35aae3e29mr18437925e9.0.1792819534608;
        Fri, 23 Oct 2026 22:25:34 -0700 (PDT)
Received: from HP ([105.163.158.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ae28sm30945405e9.2.2026.10.23.22.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:25:34 -0700 (PDT)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH] git.c: drop NO_PARSEOPT from builtins that use parse-options
Date: Sat, 24 Oct 2026 08:24:49 +0300
Message-ID: <20261024052449.95869-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.236.g7e34d8174d.dirty
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

The NO_PARSEOPT flag in the commands[] table marks builtins that
parse their options by hand. Builtins marked with it are left out
of "git --list-cmds=parseopt", which bash completion uses to
decide whether it can ask a command for its options with
"--git-completion-helper".

Four builtins have since been converted to parse-options, but are
still marked NO_PARSEOPT:

 - patch-id, in 2871f4d447 (builtin: patch-id: add --verbatim as a
   command mode, 2022-10-24)
 - diff-pairs, which has used parse-options since it was introduced
   in 5bd10b2adc (builtin: introduce diff-pairs command, 2025-02-28)
 - fast-import, in 863937696e (fast-import: use parse_options() for
   command line options, 2026-08-11)
 - var, in e19f0779c6 (var: add "-z" output mode, 2026-09-26)

This causes "git fast-import --<TAB>", "git patch-id --<TAB>" and
"git diff-pairs --<TAB>" to offer no options, even though they are
listed by "--git-completion-helper".

Remove the flag from these four builtins, like 66fa6e8ed8 (git.c:
update NO_PARSEOPT markings, 2022-08-19) did for others.

Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
Removing the flag from var does not change its completion, since
it only has short options: -l and -z. rev-parse also calls
parse_options(), but unlike the four above, parse_options() is
called only in its --parseopt mode. Its normal options are parsed
by hand, so it keeps the flag.

 git.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index d7b5f88e52..2d27ad4175 100644
--- a/git.c
+++ b/git.c
@@ -571,11 +571,11 @@ static struct cmd_struct commands[] = {
 	{ "diff", cmd_diff, NO_PARSEOPT },
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
-	{ "diff-pairs", cmd_diff_pairs, RUN_SETUP | NO_PARSEOPT },
+	{ "diff-pairs", cmd_diff_pairs, RUN_SETUP },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
-	{ "fast-import", cmd_fast_import, RUN_SETUP | NO_PARSEOPT },
+	{ "fast-import", cmd_fast_import, RUN_SETUP },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
 	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
@@ -626,7 +626,7 @@ static struct cmd_struct commands[] = {
 	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT | DEPRECATED },
 #endif
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
-	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY | NO_PARSEOPT },
+	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY },
 	{ "pickaxe", cmd_blame, RUN_SETUP },
 	{ "prune", cmd_prune, RUN_SETUP },
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
@@ -676,7 +676,7 @@ static struct cmd_struct commands[] = {
 	{ "upload-archive--writer", cmd_upload_archive_writer, NO_PARSEOPT },
 	{ "upload-pack", cmd_upload_pack },
 	{ "url-parse", cmd_url_parse },
-	{ "var", cmd_var, RUN_SETUP_GENTLY | NO_PARSEOPT },
+	{ "var", cmd_var, RUN_SETUP_GENTLY },
 	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
 	{ "verify-pack", cmd_verify_pack },
 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
-- 
2.43.0

