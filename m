Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78CD3C685
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdB+xfIy"
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EC5CA
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:51 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9b0f27dea5so88578276.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697744390; x=1698349190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fubabbserzgwdw6jgqIHKJr9vN5zVCzKfzC5+UUHhk=;
        b=BdB+xfIyHvI5pMFC53PJ/phJK22AEd1EY0liuKqnRlj+IhGnuovNSG0FDZ8zPeLiPc
         vWa4M78hMe7bklIE9ZoKdoiBg6CWMhXHZr1n+Wz5yqWz+/FlZkLjdSe3mT8bTLDR2ITn
         fQWUzYaTSi4bLn2+oyNeuFdsy3Q9w3LBvy6Ga5kklxW4C+OxucEEW0VaqTJWqeULoAsp
         n5qjaSXqHiKJW0+v8jakhL7NBGqmweJfOedfQS1Zxv9tgE4srVyopUpcVcdA6aqsAdNG
         AO3OMioLHVGzmFu02mIuUO5LQI3jNxGRyc+Tw3udnIHr3Qz751FvPUYUGMcCb1f6wS9X
         3e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697744390; x=1698349190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Fubabbserzgwdw6jgqIHKJr9vN5zVCzKfzC5+UUHhk=;
        b=UMKiDF4z2ShuYId/qrZrcDxmqZMwLQo6pq/AIn/XDMz4CywCFG4lPEm8+Po1eud2nI
         kNpAZ1sDCa0dEZQ64LVJDD49yTGd2KZt3oXdzjr4r3yl0LJlWE4Ueb/MWI5LI2Nh7gtg
         MW1hlxz3BB5fHHC36MyB0x8+/768zDyo+ifySXIGMk7HEKl6xwyN3TTxDuxFoMxFP/hl
         CG2+fFwH2alrftW4tSaasWZtJ2VPHfCueiAeT6iYodVifQirY83969TTLLhdxCst1DqW
         cafjRN944Q/LmrXXsbA7bW3uGR+ZuLc+cB6Qp0RfLxfzaTUUxZgph5i/K1/bDAXxv5JS
         rD0Q==
X-Gm-Message-State: AOJu0YyjuUDEzbCgwJFEUSf0tbstpjLWSHqC9S873kIJqb5FUSv0dVEv
	kNm2LY9J+wYqRQubK/GSAw2zN+D34+k=
X-Google-Smtp-Source: AGHT+IGcnP6Qgk2rBmlkTyLN0H4doC73vk32GLLbrkXuOzlGFO91EEJktqM/Az5l2DQomuqhT8tdNQ==
X-Received: by 2002:a25:8041:0:b0:d9a:d894:7b51 with SMTP id a1-20020a258041000000b00d9ad8947b51mr3462235ybn.57.1697744390531;
        Thu, 19 Oct 2023 12:39:50 -0700 (PDT)
Received: from u.ad.analog.com (cpc99472-lich12-2-0-cust1752.3-2.cable.virginm.net. [80.2.214.217])
        by smtp.gmail.com with ESMTPSA id ph5-20020a0562144a4500b0066d0ab215b5sm99940qvb.13.2023.10.19.12.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:39:50 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH 5/7] log: add color.decorate.ref option for other refs
Date: Thu, 19 Oct 2023 20:39:09 +0100
Message-ID: <20231019193911.1669705-6-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231003205442.22963-1-andy.koppe@gmail.com>
References: <20231003205442.22963-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refs other than those with builtin special meaning do not appear in log
decorations by default, but they can be made to appear using the
decoration filter options. However, they would do so without coloring.

Add config option color.decorate.ref to address this, defaulting to bold
magenta, which is the same as refs/stash.

To implement this, add NAMESPACE_REF with pattern "refs/", but do not
set its .include bit, so as to leave it out of the default decoration
filter.

Document the color.decorate slot on the git-config page and amend
t4207-log-decoration-colors.sh to test it.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/color.txt   | 3 +++
 commit.h                         | 1 +
 log-tree.c                       | 2 ++
 refs.c                           | 7 +++++++
 refs.h                           | 1 +
 t/t4207-log-decoration-colors.sh | 9 +++++++--
 6 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index ba9f56885e3..086efebbe5d 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -92,6 +92,9 @@ color.decorate.<slot>::
 	the stash ref
 `grafted`;;
 	grafted commits (used to implement shallow clones)
+`ref`;;
+	any other refs (not shown unless enabled with one of the decoration
+	filter options such as `--decorate-refs=<pattern>`)
 `symbol`;;
 	punctuation surrounding the other elements
 --
diff --git a/commit.h b/commit.h
index cb13e4d5baa..f6b2125fc42 100644
--- a/commit.h
+++ b/commit.h
@@ -54,6 +54,7 @@ enum decoration_type {
 	DECORATION_REF_REMOTE,
 	DECORATION_REF_TAG,
 	DECORATION_REF_STASH,
+	DECORATION_REF,
 	DECORATION_REF_HEAD,
 	DECORATION_GRAFTED,
 	DECORATION_SYMBOL,
diff --git a/log-tree.c b/log-tree.c
index 890024f205b..fd99eb88d95 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -39,6 +39,7 @@ static char decoration_colors[][COLOR_MAXLEN] = {
 	[DECORATION_REF_REMOTE]	= GIT_COLOR_BOLD_RED,
 	[DECORATION_REF_TAG]	= GIT_COLOR_BOLD_YELLOW,
 	[DECORATION_REF_STASH]	= GIT_COLOR_BOLD_MAGENTA,
+	[DECORATION_REF]	= GIT_COLOR_BOLD_MAGENTA,
 	[DECORATION_REF_HEAD]	= GIT_COLOR_BOLD_CYAN,
 	[DECORATION_GRAFTED]	= GIT_COLOR_BOLD_BLUE,
 	[DECORATION_SYMBOL]	= GIT_COLOR_NIL,
@@ -49,6 +50,7 @@ static const char *color_decorate_slots[] = {
 	[DECORATION_REF_REMOTE] = "remoteBranch",
 	[DECORATION_REF_TAG]	= "tag",
 	[DECORATION_REF_STASH]	= "stash",
+	[DECORATION_REF]	= "ref",
 	[DECORATION_REF_HEAD]	= "HEAD",
 	[DECORATION_GRAFTED]	= "grafted",
 	[DECORATION_SYMBOL]	= "symbol",
diff --git a/refs.c b/refs.c
index 416c35f0c2f..b03cccab909 100644
--- a/refs.c
+++ b/refs.c
@@ -142,6 +142,13 @@ struct ref_namespace_info ref_namespace[] = {
 		 */
 		.ref = "refs/rewritten/",
 	},
+	[NAMESPACE_REFS] = {
+		/*
+		 * Catch-all for any other refs.
+		 */
+		.ref = "refs/",
+		.decoration = DECORATION_REF,
+	},
 };
 
 void update_ref_namespace(enum ref_namespace namespace, char *ref)
diff --git a/refs.h b/refs.h
index 4b054d30fe5..82aecd37a2b 100644
--- a/refs.h
+++ b/refs.h
@@ -1008,6 +1008,7 @@ enum ref_namespace {
 	NAMESPACE_NOTES,
 	NAMESPACE_PREFETCH,
 	NAMESPACE_REWRITTEN,
+	NAMESPACE_REFS,
 
 	/* Must be last */
 	NAMESPACE__COUNT
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index f4173b61141..4b51e34f8b2 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -17,6 +17,7 @@ test_expect_success setup '
 	git config color.decorate.remoteBranch red &&
 	git config color.decorate.tag "reverse bold yellow" &&
 	git config color.decorate.stash magenta &&
+	git config color.decorate.ref blue &&
 	git config color.decorate.grafted black &&
 	git config color.decorate.symbol white &&
 	git config color.decorate.HEAD cyan &&
@@ -28,11 +29,13 @@ test_expect_success setup '
 	c_remoteBranch="<RED>" &&
 	c_tag="<BOLD;REVERSE;YELLOW>" &&
 	c_stash="<MAGENTA>" &&
+	c_ref="<BLUE>" &&
 	c_HEAD="<CYAN>" &&
 	c_grafted="<BLACK>" &&
 	c_symbol="<WHITE>" &&
 
 	test_commit A &&
+	git update-ref refs/foo A &&
 	git clone . other &&
 	(
 		cd other &&
@@ -65,10 +68,12 @@ ${c_remoteBranch}other/main${c_reset}${c_symbol})${c_reset} A1
 	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
 ${c_stash}refs/stash${c_reset}${c_symbol})${c_reset} On main: Changes to A.t
 	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbol})${c_reset} A
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbol}, ${c_reset}\
+${c_ref}refs/foo${c_reset}${c_symbol})${c_reset} A
 	EOF
 
-	git log --first-parent --no-abbrev --decorate --oneline --color=always --all >actual &&
+	git log --first-parent --no-abbrev --decorate --clear-decorations \
+		--oneline --color=always --all >actual &&
 	cmp_filtered_decorations
 '
 
-- 
2.42.GIT

