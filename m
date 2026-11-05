Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880767;
	b=3bMYgrc3k1rF1799IJi4BPmPms9LNWz7XPwaGGGgWioj0ATlnH37vbcCbSzDiigjbJ/T
	 1+0j/84+6VmmraiLyvhmFdaUO1sIFaneacijn2wAWALCbctIKpPg5RavMdSYmaQ59YKAX
	 FGmDccSTZSWIVOn4jK841cVsE7B+zJIuqCjskU8jzo9AD4LX3h/9hhYWjipL5wmn41HKc
	 T1P/iSsZYFIil/FY//bfJUIlrYWOv0NJKWOiiHNdy/mADUXXk3UR1QqFJLVLSHHooIqQ9
	 rcVL6Hu2h21etEzo2/yRZdmPwBOadQ1Nvc7k9jVhlwULYxTWe1KmGy5rWhDVk5wQe5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Kcp8xYGvNE4AVoa1wDnPvXpQlN4wTuSNOwToRerlyxU=;
	b=Fk2jNBxn8xRgy84EBZApZMeqSzTWOMl9a7jpna8vnv3sMtAYQv1QIOyPJfryUVrg+nUH
	 K7KDehIAB0Y2kjVZAwcazUy5jJeDQqPOz4fD03iDxZN0Gckow0t1rtujGCfcgoHHMF7Of
	 PV07A+U/I7C0gT3DpIU6tC3CWXG88MB9TghTPsiVMZ8mmljfi4nHnkkkdld0VK40Rorpb
	 An1Vw6Ly5VH3h+9eSvz57JcJFct3iZK3aoFP95vogX3aVWyQFLDwkf2CNf15vGxGLHfLr
	 3E/NmTjQOaeGTY3KbS7aNt0qg0EcpGJxAYsqPztX4yQtHjsw7Op/9u6EA7iqt1qFIlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yrJMakrQ;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA04606D819
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 12:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CA04606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yrJMakrQ
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so16183735e9.3
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 04:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793880766; x=1794485566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kcp8xYGvNE4AVoa1wDnPvXpQlN4wTuSNOwToRerlyxU=;
        b=yrJMakrQSLWaS3hpGZtgf9MNV5rzUoy6yk32n2ffJFBbVmgjK9WM4Na4AsDSo2I5gI
         6RbLbmENmoHjxorbGfNCUF+u6iLA8ICUSoQlnFxoKSsvikog6PBUl6z140w8IzGFcZej
         EvISiJXFHvOeyyPIFGkKwx7wDgiQlgRRfljTpHnexEeBM4VznU59caDQiBaT+/LTTIe1
         FM0s/TRH60yXT6yb59fE/HVkltqg0m4J9RjtdAGHZ0PM1bSxpVGXkFRqYH6HxJDvAAWs
         frpLJ23tbSgtSZFJtdqE6FOT0Bnr0nf9GX1Zp6Ps3H4o6jB5Mit/KCgD8YPCs33HHBQg
         xQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793880766; x=1794485566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kcp8xYGvNE4AVoa1wDnPvXpQlN4wTuSNOwToRerlyxU=;
        b=WrH6pcueKAUgo8VGyciISFMSamsH4/46M796WmeitDXHJkpCK87IDJdbWFxEWo11mc
         m6tQO8sBbfWpoLfs/zj32CXM5LOZDqw8fped+m9fGelBrHFYny7DVBHgbXxG/p9eS9XP
         UuPTlFOlnla/XmI41S5UfI3PUV2dYp4tTlU/T/5cvTBXJdLXw70AQzpcUcmd3EU0u5sz
         vLxTlMhTULWblA2rUvrUxGG/1rowOYV2pplDcTDqKZV39FJrDbxt4443QtwDseahpEEw
         LmQJcs3a0XufnNJylaQtFVgxFo/XU9TlZlqMVsUX31Bi0Z6jmbO3FBTHVIdnn+x0Aobm
         HvzQ==
X-Gm-Message-State: APuU4Z+cNwJso7kbDRryLrhmRrrny8IdKSl/YAzOWxnqxs4O16NwcThr
	R+Ppd/QEZSBEzmJL7wxhJfTWtK7dr6N56trl0xu+Qs5/bE5MnVBLUtto+4fuX1YWuBE=
X-Gm-Gg: AYBFou0O3/xHUcqQIQKzvkzfE47srckG9bMAHdboICpPhF34hob1j3jMQ/EnHuVu/Xi
	WxnnvSDW8QwfS+BoGyHyg0DTLKcdGvpHP+DtetonVEotz25iwg5WMuovgvAiFMkAoIO9MbDAeIS
	2mS3lnd20GlutW/IdQ0qjCsHw8RU2Me+JnvXCHCJtl2Gtzfuy2Yn+lxaYZFHnJEEBcqwxMaPjwc
	tA2QOJppXf+9U8AXHEhdmiPvsWpVaNvj0AOdTRAEdgoFPjV5Vxw0qA1P+m5GTP3Sws6ZtQOhuwB
	d4UXRKA+f7WjZMONOxbrqGvIuUev2gj7v1kFcFN3FeHOAyz+qeS6mPae11rk/Of+v57LKNYwQp0
	xWJCmJ7DMHTeUr1GZpjyd9d03ov0z4RIlXeRWihc0wm7wu+mA7Oaiu3rmj9M2oLJEJ9X/Y3KhH/
	h7QF1sIwV9eZxcpkaYEdBH33TKWM8h+oP2w+7+R5GmCVlMfIDuNp65DZIceDUC3B3BSAIfWRpwI
	/+iVPnJQkiAeTJ9u5dnRoNoasF+B7/LfsBeUusaSHqEMYZiTL3ytoz4LMsjz72acSMiUxyJfF6t
	2rpMzlwMX9q8mpxRV17O9Dm6EaTFg/+hfoi9mEaf/mXlwZh3SIBrwmH/kmjRC7dT
X-Received: by 2002:a05:600c:c171:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-4ad739eb30fmr331240325e9.20.1793880765575;
        Thu, 05 Nov 2026 04:12:45 -0800 (PST)
Received: from zito.localdomain ([102.88.166.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57317cae5sm95818775e9.12.2026.11.05.04.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:12:45 -0800 (PST)
From: Azuama Odinaka Maximus <azuama69@gmail.com>
To: git@vger.kernel.org
Cc: tangajoris@gmail.com,
	pushkarkumarsingh1970@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	Azuama Odinaka Maximus <azuama69@gmail.com>
Subject: [PATCH v4] rev-list: handle arguments in early option scan
Date: Thu,  5 Nov 2026 13:09:36 +0100
Message-ID: <20261105120937.10269-1-azuama69@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAKrRMNrnd2+HxTxadKaha+K9ASWi_oN4h7gdjVYAGmyODwmi=w@mail.gmail.com>
References: <CAKrRMNrnd2+HxTxadKaha+K9ASWi_oN4h7gdjVYAGmyODwmi=w@mail.gmail.com>
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
2.56.0.386.g979eb7e29a

