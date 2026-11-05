Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918139;
	b=MDt2MYPM8IsBdTGN3AmSaMZl2LSepAoduyegHRB1q4KknfNM5J3gpcK+13EK6LAISyMB
	 l/RUHbH6JVCffoRBa9WYguvCM7asfaZOYBw6GSNIE93eJesxKJQqSWDPg8fUCNi10mKzS
	 xGQmZLYGlwpjxboZ0Lw59h9zTv9OX4JmPEd8guVSCkPLkYddSaG7PHUWqWt9TYqHZRlAZ
	 a8OLdWzphQmZT0DGOCs8jNwCXwxX+JiGYocTVOZFmmada5MdqOw+WlthpPQmmDhCu/ScV
	 CTcVdn4N9CqAVQd+ihMH5My6XL1IYRAMYZzt11FtpPhhgh+GH6QWyYik+IZaXriBZLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918139;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tzrW+Tc3mhkgZcFp8N6z2Aa8JEg1kjoYe5MswEW2ETA=;
	b=UdrwkU1W/E6ZLTFCi4nRGqPqgJ5Xe1vRzKJv65ih4O4rhwWLybhqzXFZdzyjh/8VUn/z
	 zYepS4oYa3iHjx1VbDlT5yVqoZAzM4tX5UljYCEcufH62M+Ee5FsEJyntU+QuefLPT3mp
	 OF1xQ8tRDo1DaY34zzeKuPUTyoyroAZrv4MGMD/v98nKMO9m0Dhku5KXCaMCGl6qlJwAY
	 pqYdJhRthUJexmYj7TGr1ov+4MoS+1kz5jtiMUayFN3sb+sYcE4uPmrjld1+QdctzBg/g
	 wNyAqoc7mjQwTV8oLXFJLP+aZjLpsaa3fTiUN1nEuRC4v0ua2kZ4O7+4FaSFnMIo9Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V55Sp9yL;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243A606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 22:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3243A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V55Sp9yL
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4ceaee6770so3722466b.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 14:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793918137; x=1794522937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tzrW+Tc3mhkgZcFp8N6z2Aa8JEg1kjoYe5MswEW2ETA=;
        b=V55Sp9yL0Ek/NoFwOetNKwjnvMwEwOo3lRRqosvMQxgPjWbsxCHTQcCmjjihPbMObB
         zhwpKfLjQPWC2yreOIE4YVoK+wbMZ2q6ApIH+KUSFlkXtqImjRloVa+VNr+LDrh8SNLV
         HaUi7ack9eL6ZjBo07w4+jdR2aNz3dgUaULxRStTzQ44Qlf25cb7daK/TgBzMRG+tELE
         LddSdvk6ImTDs5ve8AlegcVtlcvOJjgwDL//nNsFGw5tKADIZRcYmBV2LqTZgT00yKeM
         4b3Mr5t0K5QvYES1+08/3VP8i25cAlQuTVnMglHfPk79MMYV8R/C9xMLqI5fCX+lmB2U
         QQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793918137; x=1794522937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tzrW+Tc3mhkgZcFp8N6z2Aa8JEg1kjoYe5MswEW2ETA=;
        b=Aklp2DXdScgzeEgYUETw33h+JAvEY/pty+zgWfFV86ixQQM9nu/GFKskavFw5acn1Z
         v1d+GhT2o9XvQsRNnezbu5vsRwA/BECbYAB347UKW3T29PEjc+FzPX+y9PfATbb6C1DA
         YzARsFcyEB70jwz7cubBUWaPq+WJZBPqYWvKl2d/u02MhKFXpMsPei1hBJqRHT/Pe9+D
         d+XmWdGq0XD0j0bUqWwTpleLl1ZCyIlTJA0Majhbh8ebjlIcDzv3OGvmygixi5GxyuJv
         0+mDRnl1LOKGdA4vbKRtDQc9SOf3dXoqR4jRJg+yo/X5DMHDxf8+Vbw6E9NtpKJH+ZZ4
         l3mA==
X-Gm-Message-State: APuU4Z83aez6/umGhkakF6J4zu2BeiZofQK5bls6GcBCgnt6KvR+oTOZ
	wFs0L2C2qILGvtxznX4yZxoqLmBvXb9zLMYORSRifJo/1WtjEKLvFIguF8ErqkeI
X-Gm-Gg: AYBFou3Z33dgXBTP6zlgQt7i13Hw/a/uY+e5C1QKWkHgR3xbiVjlp0K64sYsmP+/Dul
	vVSIY+x+s1R0iSyLJ29GZBk0C/y/8HpNNmkBLeIO8Gjd5sMO+Ax9RQllVD7PxorRhyJjwXrhgT7
	ZR2Vw3KIaZVVtCfnCp3eoofq8Dz1+VUDMbA2Otp7tDGopYcaLPJEVd9PuEAue2i8VWwo5+j6gGb
	f25QCvIL3jC5oqCydPBqRybYhi45s9xQ7py0NPN3gqc0zkMWPjhOSqplbN85ifxlogKj5PduroJ
	yfk1sV3APtWoKgyz/XvXZM2k1AbU1gZkyXe8D+0E7FCK4wJFcQSCrZY3nfb1I9+6IU6X9/uc0sk
	Y8tSH10JURs5COA4cMcZgKdmgKs9BdPotOd+S1z2Ukex8cC8m49mgJ8x06f8crZDySCZH7BEqGS
	UY84DqnudqwnAXr0WgAnPxGxX7KcS9VblCbOwcMqisHxGr7Yc+kgRPcGUd8wLMxdkBVdMpbWGV7
	dDLtXIoGMZ1LOvS1oB2FQqAIInvXLildA0/g6q7QwpF6C6zEbmPkkhzE4Kvc5Tx/nIXQyCaB50T
	odTHbY2Rkj2S72Jty9wqJWgDxR0KHnwyfCDvufJKD0iQpEPfsSVvq1kVouz3VsaJiRFlZDDCHvf
	r0ITKaR5J6eeT0rja6A+GLhzGNbhd0gi/yH0D
X-Received: by 2002:a17:907:1b0b:b0:c48:1977:e1c3 with SMTP id a640c23a62f3a-c4d35459c95mr67385666b.21.1793918137318;
        Thu, 05 Nov 2026 14:35:37 -0800 (PST)
Received: from HP ([105.163.158.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3569e638sm23826666b.48.2026.11.05.14.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:35:36 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: l.s.r@web.de,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	herroyalpriestess@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v5 2/3] git.c: drop NO_PARSEOPT from builtins that use parse-options
Date: Fri,  6 Nov 2026 01:34:57 +0300
Message-ID: <20261105223458.1534785-2-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261105223458.1534785-1-tangajoris@gmail.com>
References: <20261105003914.708836-1-tangajoris@gmail.com>
 <20261105223458.1534785-1-tangajoris@gmail.com>
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

