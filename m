Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315827;
	b=DQUM99JmLuWvVrBCEruQKsIS9fwz2s0rM+FzjpOSktsdoRzdbWEqL6oZFIEXnvYVm1lB
	 bGR7hebRYusQisvz9h1Brsih+PuH7zfuEd5AyE1H+rNRv6LAaL8POm2tElJsVH4nZM5fk
	 xBw25VKZclxJ4neq/GRzjgfRbKkp+pU996cm4eN+eUeA7vs0nY/4fa/EtTVzsY95rZC6D
	 6HksCkZVC1X48KBqs/xtqY3rIevdUC+jV0vfavolWsYaHY7s0Idkx8LS2z5F/R3WCUJ/n
	 z/3Tew1a9/Pgeq68xbITgmg6V9NrcFXzMMoRdacsrIH0hWpe6cg9yP8cqxveJACkimw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tzrW+Tc3mhkgZcFp8N6z2Aa8JEg1kjoYe5MswEW2ETA=;
	b=4CsoUQ47yFb74HjcoVkyeIcm34/MxTB9MwbbQR4pFxQVDM9dR/5ADUr1GPgtpa0aVKZ2
	 p26yux0s8dOEExxleQJaY+KUb4lytQfLwtNm/mYnsGyR59wayimZg5gVr3bx8rMhA+a90
	 gEOiF5NI58/r/Pmtu0nWnoR5KVR7elpKHJ2LuNW8wgyfFo0akTPrvh7Ec/a1cMsvisdhs
	 nez+c931NVicparnNowSvbLI8cocWi8ESkRuio7dlYfxJR15eBnmxSnLYNutv32kV/phW
	 7ufTfSrfifHaTSQrmh8OCvfddp29IxXK7d/pIR0XIqDsy5cVbjFHXNfXxAvhQw1p7Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZPdecUTP;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF8606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 23:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3EF8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZPdecUTP
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e20edd106so101276f8f.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793315825; x=1793920625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tzrW+Tc3mhkgZcFp8N6z2Aa8JEg1kjoYe5MswEW2ETA=;
        b=ZPdecUTPXT3TAN9UvHEZMXMHBlan7B+B79urCyEGZEfqP6KnjUrcUrwmPhpIgRHv87
         AwywjPAMZdusnKv2bXTw9l4ra2i6N4g5fGWv8ZjBawr6dkCJ2uQ/H6BhRDx6lLGYQ8ET
         SaIzYjfc6KO+O47s7gFUsthlZAE8VogoMxsT3XAmvqhPF4OKJ7qKqaysjGJdu24G3dR9
         QBBIXXbNZIS7GYOZGJJD1TaM02LV0hiX13bUYxOKcFdGQW7tfG4ZTeYDrMxiZ4JSLm7+
         fXurkws+1xkFfoMIP9q6OlQHMFJ/kBK3/YM7r92Nn4FNhSZlWPreFgGu60zdYy3e+Ris
         CHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793315825; x=1793920625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tzrW+Tc3mhkgZcFp8N6z2Aa8JEg1kjoYe5MswEW2ETA=;
        b=niQkZtHcG42Xt2bTi4E66kOwxBK2ylJrqQ7+QTE/jDQWAi15V3C1gQ3TmoTGxGlPKr
         QR8zhZv6tfbib3qkrH7ImL3CUzOFjqBw0l2CU6REMG7Dy54z0FFWLB5tdxUkH9ztUM2x
         BFbMXx8AAZmvZVnwkuGvT4f6+qq/6XVpHJ8P/4qp6dUgGFL357Zu2+qVn5FLzryToFbl
         5F5Zsr44dcc3DppKgCdpA7d0xKoVadFaCJFn5gaRIyxjFCgJUIodluAo7YGX/ZmNGdBi
         +uYv3hI3PslSo07yEfh2FGWTk+22KcAJy9/rWEUjFTweVqmi4jUmA8v8Jv4eXaYd+I1X
         6p5Q==
X-Gm-Message-State: AFq9FYLL4lu/bxRY6x1c1AbWChA8+Yy9YXEFmQYTgZEIlFW9y1WLMwae
	cDoBdjxlFqLwfUp+qmm7SBV5bp7hcxvMqwfzCwXQkwerq4ayN/a84CfHZJ/FocmW
X-Gm-Gg: AYBFou0X9SAyVvHa/J0HloouxDbPkPXX1onKJO7q0MJmrw7k6h47gyIaeZvzst2W6gX
	9Kk/j9ToHVzcYo6ojnCCInPmvA225mnv9JmZqJ3QJeK/L9qJjBwg2fS0wgUACGKf4dJn4r90qON
	4IJWxsHKD74vNCCq9mFYqR1UaODmtQ5vloLhtSbzMOAvjZv+3mQbwjZcV9pikLPONvNiugKmGyF
	nEzIXNhesX3pWiz3WvtxZXvuFngi8Xi1mvPHaoVBpWog2jKtmydvDXRh38fpkgpJNhAkekOgHcb
	QVREQ0VG1/HsfiPjkaQGyaVJkfAzxRurR/qyDh4UXhgvU3NbFCH/UoU6gS2Kt3DjBX2QX2rShYJ
	PSCh5dQ0VHzkiszja8ceGcFDr7BAqkE/moLEFvqA633zJpQnUksECDzM549dN0UIQUltphsAo3C
	XPcWPyQQpyE0EQ0XXPQR9q+KW8y3hQvimH7CCj84O+Jh+RznHBx47wIJ6PJ/DQaS16t1ErggWrA
	L+Ggeo+VdfnMBxEuhjSXnmYMtotYF6XHqKGwOE8i/YGKjTZh4LQkW88Q+R31AzqWwz2u+7RZaX8
	nIIv+t2+niYJ5zoz80tYQasTz+UOURNkDSuYC4W27QNE0oyIaW4rVaNfIPyPVbFLH7siurjlmc0
	ICVeO24jZtZuzAOZrSVsf+VYWa9cPY6ErdTan
X-Received: by 2002:a05:6000:288b:b0:48e:1421:ed49 with SMTP id ffacd0b85a97d-48e6e2e76b1mr1685008f8f.18.1793315824853;
        Thu, 29 Oct 2026 16:17:04 -0700 (PDT)
Received: from HP ([105.163.1.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e712c2692sm234861f8f.22.2026.10.29.16.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:17:04 -0700 (PDT)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: l.s.r@web.de,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v3 2/2] git.c: drop NO_PARSEOPT from builtins that use parse-options
Date: Fri, 30 Oct 2026 02:16:21 +0300
Message-ID: <20261029231621.48958-2-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.298.g27111c8f60
In-Reply-To: <20261029231621.48958-1-tangajoris@gmail.com>
References: <20261029012616.139783-1-tangajoris@gmail.com>
 <20261029231621.48958-1-tangajoris@gmail.com>
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

