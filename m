Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327333;
	b=qV6WaZ8/OO4tsxNrRUuxMoHnvy5JLw5jEJjJtb+OmfSbcndLDTK8lauFHjHXclCfryVb
	 34z4HaCHWVZHYU3V5K4Gaxoc+dGtq4uu8Lmn027jayGQsjsnT/+pZWxU1zuINp4GvV5rN
	 0YTcGXvTKNoJx0xgKH9LPJnMVIMYLNDlu7ppHtUayAtn/r4CFU93VKdDyHaNUVwPE/tcP
	 Zd0pPedCdigTBNtSJ5tOOMbxvjDyURbmJpELyLmarsKBbxDZkbYqAxGVsVOKbtjWXlJj4
	 McOZ/SI5H6lqQUel90uEHpOGKq+J9Jk+4I7VUjqrCCH+oTCN0TJ/vUiFNEo0rWSZQKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MNq204rDBwytakwTvUhGVDmcy7KdWGHlgWMeN7IbViU=;
	b=PYoOKYz3AVagmD41d9IaqJQAlLaX3iS5al4RDbCe/Ky8o8Oi8rvq+8Yibx8wcrd7dt1H
	 p/qccNCOPwAuZ5IyH9sIcgykrog0d7f2pfBtQo3h1DORiiBgt4O9pYZJBDE7oedGIB0kv
	 3yrz05u0jBkNStyxNGcplZXP1JVSh0NpLNK9y4QBYv65xth2Rb5TzWQRQ+WgSuaJWazxX
	 /cZ08GW5ZbZFDR8mRfehdY+H9NxiHdfUMhjkUtRVRCkUK/nEwlIIUdzcznJh82MwaMSqO
	 WByHZZaM134/5sYBUlZxS47USIJBMDjFWikyqpdmISJXD9Hp4PhtZI4lcE3EXyCxzaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J47jIa1y;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97773606A323
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97773606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J47jIa1y
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso3300403a12.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794327331; x=1794932131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNq204rDBwytakwTvUhGVDmcy7KdWGHlgWMeN7IbViU=;
        b=J47jIa1y5pVldV4gYdyBCIUYK+xTk5aIpiEWNxttFjMx1FUKBqqRBOfjSy2OP7mVaB
         NZFnUQ/7uMK3XBIQtyYQa16hOp7HlB5vVmRTXEQrPSEzgiLIuHMN6nAVPtWcKcTG0J33
         I+tcLD8hIHEMAIpL/2prTIqtc0jN07bQc5+D0PRgw6nl1E1zlnx9jxOurJuywNjCgNjV
         i+C0R9N7zXI8LXXu8QnoHsdPJ1LI1oahvceZHzln/H4epPSiGz0C9xQkpi8sqSQFseNs
         GGP01yXxLTK58IShmU1qh+OLzTnRerUcQZmvdA9nK3/DYipdp0+oaTx1LrkmREsZQFEL
         BnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327331; x=1794932131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MNq204rDBwytakwTvUhGVDmcy7KdWGHlgWMeN7IbViU=;
        b=jYldbx3i3pnet1pWY4EAamE4EOLj0Ws86nB6vR0oowkCtuxXgKQrH4f6+qvRaazzuS
         wiwYbEiaetnC8RLBvd0afFZuV7EP350XxcyqDiSIN7zMh1/Stfs2Y/dWvLXCQrmcuZyr
         TgUsMXhJAuANWnWBWzqQTI/Nu5CH1Oxjrk6zEvmulcATlguc1ncU6XJwzFlqc6sa0MFb
         uIFxGm0UNLvyDbbnZDt+djZTM+794hLsKdGf10QfQ6A/NIMTGAhqJ/5HgJcR9zf/ESDZ
         E2Xk4ZNd/a3oVFNGthe+7shFxrrx424hJGj11z240x40nBYtzZd7f0RyjvTY4Q6MUU0H
         bQBA==
X-Gm-Message-State: APuU4Z/hE4X9bQsbR30116Vts/rRDiXLHz+beRLIKeuclhfpuatNBfW8
	YOcML7kQYSvABB9fLI7iHJgRnfY24aKveRZN9u20MbeRCaNE4QA+z4X+74LOU7dYxLs=
X-Gm-Gg: AYBFou2R7qK8eGJFuJSrUBewgXoaaHkh7J7+PFur8vmPzzLhEiEWitSDCMAj1gpo+WS
	OP1qsF+pPRWFPlToXGulGLhbmA7/qSt11ag9H/rnjz2Nvi981brZNak9WCBp4e0T3vrQA4qtFkF
	6vYwHc7DW852mRi725jelRuOYYp/MZxSLgY/wmnigXUI46a2u3P9MPk9mmbin9/1J8Sq+f7sX5N
	bMS9ewU0FtLmiXGszWjOu/uBC78w9bmm4tqM9hCZMAVYSWlXR2X1kl6X3bE8nMOsa26OfJIm1B5
	2jWu4pkbKyY7KedGP7X3HCFDAvr7Fd5A27ZsvlGTEamWy0EBtszs551TSSn7H7eGkOOVoGHu4BP
	PlvByolfA0/4FLI3uK5gHwJZyOTDQRkL0Q2pwogmS+zIRwcIXUEkHbHXTSrOl3CsS+uz483kPgf
	pLR3YBojNOEONrP4hwvCwr8p8xHqq050c77Zu8hKHHXAqgHCgXn0+CDMrpfoWPBOsWFVN+ablqn
	ZMVwv7xkbnJI6us5uBfcVHdcytRFI4Guh7h6s+6a++q9CnB9r+bxs1t9H65CgrkR1ewp0ootQFX
	CU3MLH7Xl9t9Hc9mUPwhyn2pR6DQH1dmk2VyqIPVxCtxqgzXmatOmtCxravojf17
X-Received: by 2002:a17:906:f58d:b0:c41:7e99:c6c2 with SMTP id a640c23a62f3a-c5049656cbamr333828066b.44.1794327330787;
        Tue, 10 Nov 2026 08:15:30 -0800 (PST)
Received: from zito.localdomain ([102.90.126.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a69ce38sm126209666b.84.2026.11.10.08.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:15:30 -0800 (PST)
From: Azuama Odinaka Maximus <azuama69@gmail.com>
To: git@vger.kernel.org
Cc: tangajoris@gmail.com,
	pushkarkumarsingh1970@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	Azuama Odinaka Maximus <azuama69@gmail.com>
Subject: [RFC PATCH 1/2] rev-list: handle arguments in early option scan
Date: Tue, 10 Nov 2026 17:13:12 +0100
Message-ID: <20261110161314.35213-2-azuama69@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110161314.35213-1-azuama69@gmail.com>
References: <20261110161314.35213-1-azuama69@gmail.com>
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

The early option scan in cmd_rev_list() looks for options that
affect missing-object handling before setup_revisions() parses the
command line. It must not interpret an option's separate argument
as another option.

Use parse_long_opt() to recognize revision options that take
separate arguments, and skip those arguments. Handle -n and
--default as well. Stop scanning at --, where subsequent arguments
are pathspecs.

Add tests to ensure that --grep and --author arguments beginning
with -- are not mistaken for options during the early scan.

Signed-off-by: Azuama Odinaka Maximus <azuama69@gmail.com>
---
 builtin/rev-list.c          | 55 +++++++++++++++++++++++++++++++++++--
 t/t6022-rev-list-missing.sh | 26 ++++++++++++++++++
 2 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 071a0e3cb5..4dd646050a 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -744,6 +744,47 @@ static void prepare_maximal_independent(struct rev_info *revs)
 	revs->no_walk = 1;
 }
 
+static int rev_list_option_takes_argument(const char **argv)
+{
+	static const char * const options[] = {
+		"max-count",
+		"max-count-oldest",
+		"skip",
+		"max-age",
+		"since",
+		"since-as-filter",
+		"after",
+		"min-age",
+		"before",
+		"until",
+		"date",
+		"author",
+		"committer",
+		"grep-reflog",
+		"grep",
+		"encoding",
+		"glob",
+		"exclude",
+		"exclude-hidden",
+	};
+	const char *optarg;
+	size_t i;
+
+	if (!argv[1])
+		return 0;
+
+	if (!strcmp(argv[0], "-n") ||
+	    !strcmp(argv[0], "--default"))
+		return 1;
+
+	for (i = 0; i < ARRAY_SIZE(options); i++) {
+		if (parse_long_opt(options[i], argv, &optarg) == 2)
+			return 1;
+	}
+
+	return 0;
+}
+
 int cmd_rev_list(int argc,
 		 const char **argv,
 		 const char *prefix,
@@ -789,9 +830,8 @@ int cmd_rev_list(int argc,
 	 * NEEDSWORK: The next loop is utterly broken.  It tries to
 	 * notice an option is used, but without understanding if each
 	 * option takes an argument, which fundamentally would not
-	 * work.  It would not know "--grep
-	 * --exclude-promisor-objects" is not triggering
-	 * "--exclude-promisor-objects" option, for example.
+	 * work.  It would not know that "--author --missing-only" is not
+	 * triggering "--missing-only" option, for example.
 	 *
 	 * We really need setup_revisions() to have a mechanism to
 	 * allow and disallow some sets of options for different
@@ -802,6 +842,15 @@ int cmd_rev_list(int argc,
 	 */
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
+
+		if (!strcmp(arg, "--"))
+			break;
+
+		if (rev_list_option_takes_argument(&argv[i])) {
+			i++;
+			continue;
+		}
+
 		if (!strcmp(arg, "--exclude-promisor-objects")) {
 			repo->fetch_if_missing = 0;
 			revs.exclude_promisor_objects = 1;
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 1bd2c3bc4f..9f995968fd 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -215,6 +215,32 @@ do
 	'
 done
 
+test_expect_success "--grep accepts a pattern beginning with --" '
+	test_commit --no-tag --missing-only &&
+	commit=$(git rev-parse HEAD) &&
+	echo "$commit" >expect &&
+	git rev-list --grep=--missing-only HEAD >actual &&
+	test_cmp expect actual &&
+	git rev-list --grep --missing-only HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "--grep does not trigger --exclude-promisor-objects in early scan" '
+	test_commit --no-tag --exclude-promisor-objects &&
+	commit=$(git rev-parse HEAD) &&
+	echo "$commit" >expect &&
+	git rev-list --grep=--exclude-promisor-objects --missing=print HEAD >actual &&
+	test_cmp expect actual &&
+	git rev-list --grep --exclude-promisor-objects --missing=print HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "--author argument is not treated as an option in early scan" '
+	test_commit --no-tag author-test &&
+	git rev-list --author --missing-only HEAD >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success "--missing-only requires --missing=print or --missing=print-info" '
 	test_must_fail git rev-list --missing-only --objects HEAD 2>err &&
 	test_grep "requires --missing=print" err
-- 
2.53.0

