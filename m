Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237476;
	b=oicGtmZiLIohX9qtllmnCHRIPCS43lFQGjPTuFdtXnZLXO7IddHSqAbITNCANvnEKop0
	 2WPQ9ZRF1lfUwzTou6Np6BUBoSast7/dKkYlLP55dGWGaWKPAfkwif7xAZP9lC9hbdivG
	 MTMDPEi0N10VHS0btqdtGKQAlbESI1fu0fJDiyWVqVKXEXbkwqfWtt49KEZy6vnPMmgB1
	 LcaviGkkFJicvQMRrDbVRjcOK+5x33zzKPWmsKZ283BBaiCiCZNpLo1IBUj0bH6zcI6wy
	 lTNkczDRpB1Y06a1Dh/R5IfKRx67fpznQ0VgSgXQ7Es73WRXGXrX6hPWhA4YUFHuueA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9ftuGIRKzzkmt1b8QU2o4xko0Ss/flu0wHfLBm0KAJY=;
	b=L5AlgQZhmfOqGDijK1i9im1HGIWg7hjn5OtoyKeARxIkX362XS9w7cjSKx/A15JMh+Qh
	 eBZBP1jImJ+1jazFnwHjVeMu/v6/j3jMMD6qnfEEgJ7PBK8ZllynKOuhOSHquRXPeOxsP
	 vaTO6IPBNKaWRuSnVDnSZtCXekmLruwwQ2eX1DbiJCdjMLgEFBrDqxVgfCcLHxaCMreoo
	 0mTJauWhT9dFox/0gkYuMp7A4ZROEdoZDD2o7wA5a0O15hXmGFdl9bd0VZYJTdpSSe5NJ
	 ItqWJFXShaaWm84JDh97YmplcwX6TBo3R3m4lEYL/9m8LWkidBViL5rywRR14Rqautg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tYsXKBy+;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA7606A31F
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 01:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ACA7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tYsXKBy+
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e09aa5264so815470f8f.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 18:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793237475; x=1793842275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ftuGIRKzzkmt1b8QU2o4xko0Ss/flu0wHfLBm0KAJY=;
        b=tYsXKBy+uImHGR/+lTYaITmV04zgBFNvsoenmdNjDYOGvbQG6l3/UvYoqmXntItsG1
         MqnX2nl5SwpbZtYE0vIL6/L+g2kHdqPAeBTtXuOgaZMZU4rvFrJ8v514D8l8nwjpxLoW
         WYmh5QIWXT8RFHhbAfOpMpAPRoX7HqQPldedANqP3XaB+1YY248ooVPAh+MdREC+jpaJ
         0z46IjbwsQ3YbSHCwz79w4BF0VBhN0W9M27V0wTmiSBUuecC9ESSE+Njb/ykVL5Nbp4k
         MhsCK0AZ+YQHU4Wzh00lvAF6nXKeym+Rk9j4aASux8tP4mdhMlf0MUGg5eFtM+5HzsYj
         gPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793237475; x=1793842275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ftuGIRKzzkmt1b8QU2o4xko0Ss/flu0wHfLBm0KAJY=;
        b=jWvcFX0Kzbmoa0A83REpB+pKzFYD6d3Xh2OoVQ6ePiRmme4rD6+viBM737oYUGFCBF
         wmG6xCVxt8YKt4KYQS7hHyvAdb/ipTMa++Y2M14Lu32opNpymcEiLOBZM6u6bBFYV+61
         aqVg7M8P6heYMAWUrFe/7tCJp+FjiZ7zbxgxrEkO+HYweVdtTkVJ4ux6+/hqusuJJHVJ
         kON05fURhBofqGl70mx6QKnIwxaZY+y1v/MQHbhzXegSpLxd9iD7jTiFsAEI7+GJpQQR
         lxdGPapzRMDtkW0XHVxw24WPGui8wSObkQycUXKbBxXZB6Q2IMp/jZQqfHZ6jAsjMJGH
         tWXw==
X-Gm-Message-State: AFq9FYKw3EDwqMqk8GPHYz8VVTE2tkiYPWUqrFCBmf5YLLeCid3PVg/u
	o5f8N59R2zhTIDOF+004bQyKi47ynNnzh2tcaQ1bUi7cmY8zPOuKPL0G2fDM+PLt
X-Gm-Gg: AYBFou2otpsa6Yjv3wsfO2DC4Ki0jJJ3eCrsOgfq57iVkI8W6DRH+GmDknXY/DTmjzh
	WHGPOjlf4AE8YE8DrnkeAYdi+Zb6Ct9ZnNBPv8RR8DTp67VSlb9qSth9Y9f1nWxdKKPSXkAI6mU
	phzOayEoDbDbS9w+xXFiJN0PTUMngRi2DYkKwyJZZWQyTG+hd3+PJG3PUxl5vRB2t/nwJpfiQWP
	KBNnPWAWj0jCVsZ+Ig5DPrI8DaGTHhf909AC4kClxB8ZkUxa5uM/ACIuAdLdqGv61KLT/edcVdD
	IP8Pu8KNzGC4f8pisvs2wYywJNiXH7eFjl01mdfDL4maayZvq3bbO+WM7fY3xZFX76jf+mVtj3h
	WuOYx/enbAnd4JSrz/t5hIFcnAPvKHsQz8N+jTblVZF9NGK2ILIQYaAJcL82u+8bYlIHVqW2u9k
	OLhCSVsKOJPlg+HstPLYb86OxDlDhD3ser7KLMCNaQGUlv6KYLJOuFeA4ieN3xtv80YTThixrXa
	km/G0U+qMWKH8knB8xwioe9XtYo68J0hIo6I84sgI+YVaaRWQwHFqtpDIbc5Vli6dur6fuxs8yb
	7IoRkJTdnZb5CJeOGV02ffU7VRP5jluwZdDVkbchIFpfM660g37hagsinEQCnONlmij1lnCAKx2
	m1S4bG5lcpKnmz5llaHjdnizPHp0zYKk=
X-Received: by 2002:a5d:4b4f:0:b0:48e:e2a:40e1 with SMTP id ffacd0b85a97d-48e5d5b56c5mr7027851f8f.15.1793237474877;
        Wed, 28 Oct 2026 18:31:14 -0700 (PDT)
Received: from HP ([105.163.2.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39b3sm32311325f8f.10.2026.10.28.18.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:31:14 -0700 (PDT)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: l.s.r@web.de,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v2 2/2] git.c: drop NO_PARSEOPT from builtins that use parse-options
Date: Thu, 29 Oct 2026 04:26:16 +0300
Message-ID: <20261029012616.139783-2-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.291.g0b48760bf4
In-Reply-To: <20261029012616.139783-1-tangajoris@gmail.com>
References: <20261024052449.95869-1-tangajoris@gmail.com>
 <20261029012616.139783-1-tangajoris@gmail.com>
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
2.56.0.291.g0b48760bf4

