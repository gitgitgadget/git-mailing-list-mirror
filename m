Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E24AC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC6B561BE3
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbhKQOZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbhKQOXC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 09:23:02 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5ACC0611A6
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:42 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r8so5022149wra.7
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vm/dhDtJBmVuRxe+hDMgC9L6CFNXEm12z46YWE+zzbA=;
        b=TsRTQblhT8uYqBc/Q+UugXPYqDPUaWr2qdpnOuH2YaJI5da+YHJP5+snYOblDAmccI
         aPQenOrk5jAsm+utR/s3mBw14mBNUFlAErLOavLXsh37yKIQkeGUB+aKTKckxjgv4GAx
         dgk3zL5/nSqbgjyF8wpaelB1q/QNXjBvH0MVwxGSsPBnoNhDsEmqg+N7e9BcJ2Y27+bF
         ycwoLnL/RBZLRXQvDWS6zesd2pRC7qDFUt8Q28BT8+l80zt1/htTXKt9qwWYlurcYpnb
         Vgwt0ZeGUEcn1UNn4WZ5ESHynQfHsTJK1ta4emJvSVAXe5DdouKuIyHCWavsLw6f+oVO
         d5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vm/dhDtJBmVuRxe+hDMgC9L6CFNXEm12z46YWE+zzbA=;
        b=ARnSCa59eS532HBAVngAdy5gpqMxl+ABeEspj4mjeDaKv4P8Lo6sVENosaXeOySKJA
         WXKs/pz9ubKxum48XSdZ73DgbtC/9a9MygSEHeq8IEt7Qn3MZ/Dubbg/AxKCJnzhsOGm
         67oK8axR0Uvo5mulx744i405x9RfTK9fTdGY1MFbgWqid1Ffz3kh5EJKjatzRiX4eFFA
         nqwiOimJSudK9ZEa50C8Z7EgR1ojmszJCxEULffTgCZRmaViT/2ugKLAhAdNiU1ZZo0F
         PPDaDFma05UbF3Vr+QMCXv+S9zoSY7ilUv5QAYo/e1oOj9tdw8rOIUZZU9HQbGQuEDPu
         Pzhg==
X-Gm-Message-State: AOAM531mspOm709m2yn4Y+PFudoATdz22R2fWiAgLKn8EqJschsowxYJ
        QEE4Vzqf3Q9j4IDECwWJqg6KZhQ8++c=
X-Google-Smtp-Source: ABdhPJxSmAc3HMql+o4ICFLoTyjgIukRo02D3NFFzgUKXTOPHYksiO6rGHcJP2NSl+m9jmYEEZoeCg==
X-Received: by 2002:a5d:5186:: with SMTP id k6mr20966389wrv.146.1637158781195;
        Wed, 17 Nov 2021 06:19:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5sm5682187wml.20.2021.11.17.06.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:19:40 -0800 (PST)
Message-Id: <0068c18aa624166706abbbd6e7f8a0bd04372637.1637158762.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
        <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 14:19:20 +0000
Subject: [PATCH v7 15/17] scalar: teach 'reconfigure' to optionally handle all
 registered enlistments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

After a Scalar upgrade, it can come in really handy if there is an easy
way to reconfigure all Scalar enlistments. This new option offers this
functionality.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 61 ++++++++++++++++++++++++++++++--
 contrib/scalar/scalar.txt        |  9 +++--
 contrib/scalar/t/t9099-scalar.sh |  3 ++
 3 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index b799decbc2f..71ca573f3af 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -488,22 +488,77 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int get_scalar_repos(const char *key, const char *value, void *data)
+{
+	struct string_list *list = data;
+
+	if (!strcmp(key, "scalar.repo"))
+		string_list_append(list, value);
+
+	return 0;
+}
+
 static int cmd_reconfigure(int argc, const char **argv)
 {
+	int all = 0;
 	struct option options[] = {
+		OPT_BOOL('a', "all", &all,
+			 N_("reconfigure all registered enlistments")),
 		OPT_END(),
 	};
 	const char * const usage[] = {
-		N_("scalar reconfigure [<enlistment>]"),
+		N_("scalar reconfigure [--all | <enlistment>]"),
 		NULL
 	};
+	struct string_list scalar_repos = STRING_LIST_INIT_DUP;
+	int i, res = 0;
+	struct repository r = { NULL };
+	struct strbuf commondir = STRBUF_INIT, gitdir = STRBUF_INIT;
 
 	argc = parse_options(argc, argv, NULL, options,
 			     usage, 0);
 
-	setup_enlistment_directory(argc, argv, usage, options, NULL);
+	if (!all) {
+		setup_enlistment_directory(argc, argv, usage, options, NULL);
+
+		return set_recommended_config(1);
+	}
+
+	if (argc > 0)
+		usage_msg_opt(_("--all or <enlistment>, but not both"),
+			      usage, options);
+
+	git_config(get_scalar_repos, &scalar_repos);
 
-	return set_recommended_config(1);
+	for (i = 0; i < scalar_repos.nr; i++) {
+		const char *dir = scalar_repos.items[i].string;
+
+		strbuf_reset(&commondir);
+		strbuf_reset(&gitdir);
+
+		if (chdir(dir) < 0) {
+			warning_errno(_("could not switch to '%s'"), dir);
+			res = -1;
+		} else if (discover_git_directory(&commondir, &gitdir) < 0) {
+			warning_errno(_("git repository gone in '%s'"), dir);
+			res = -1;
+		} else {
+			git_config_clear();
+
+			the_repository = &r;
+			r.commondir = commondir.buf;
+			r.gitdir = gitdir.buf;
+
+			if (set_recommended_config(1) < 0)
+				res = -1;
+		}
+	}
+
+	string_list_clear(&scalar_repos, 1);
+	strbuf_release(&commondir);
+	strbuf_release(&gitdir);
+
+	return res;
 }
 
 static int cmd_run(int argc, const char **argv)
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 89fd7901585..737cf563c1a 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -13,7 +13,7 @@ scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
-scalar reconfigure <enlistment>
+scalar reconfigure [ --all | <enlistment> ]
 
 DESCRIPTION
 -----------
@@ -32,8 +32,8 @@ an existing Git worktree with Scalar whose name is not `src`, the enlistment
 will be identical to the worktree.
 
 The `scalar` command implements various subcommands, and different options
-depending on the subcommand. With the exception of `clone` and `list`, all
-subcommands expect to be run in an enlistment.
+depending on the subcommand. With the exception of `clone`, `list` and
+`reconfigure --all`, all subcommands expect to be run in an enlistment.
 
 COMMANDS
 --------
@@ -125,6 +125,9 @@ After a Scalar upgrade, or when the configuration of a Scalar enlistment
 was somehow corrupted or changed by mistake, this subcommand allows to
 reconfigure the enlistment.
 
+With the `--all` option, all enlistments currently registered with Scalar
+will be reconfigured. Use this option after each Scalar upgrade.
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index fb5e2efee0a..58af546fd84 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -70,6 +70,9 @@ test_expect_success 'scalar reconfigure' '
 	scalar register one &&
 	git -C one/src config core.preloadIndex false &&
 	scalar reconfigure one &&
+	test true = "$(git -C one/src config core.preloadIndex)" &&
+	git -C one/src config core.preloadIndex false &&
+	scalar reconfigure -a &&
 	test true = "$(git -C one/src config core.preloadIndex)"
 '
 
-- 
gitgitgadget

