Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16EE612E
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg6ivft4"
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7A5D6E
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:26:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-408002b5b9fso37889945e9.3
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 17:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699320371; x=1699925171; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsHiC64m8IGSdtWMFHLXRyA/pLAVjXzAVcs7FQFTJdU=;
        b=Jg6ivft4bSB2ckCycjGaMClaoHgBUfPiZF6fd31NzV1n1/zwy2fix/mN00zNvAq8Du
         q3XWJJIdqe/EjPC26kHKIvSb/IcdcHHtvArI6KHYEgEh1r8lbF8Mx9HrKKxFYbXWZpl6
         XvTgr+kY27UiWfRlIefH9Bt8lTh44Cy1oGyJAphWrjpJqayrA8tsVsQgS1ujrLge+dig
         F8LKKPtSQON/AZgTt11INH26J5+m1nJcPZvZB42f8HpstKcErtBPi4pLV1vAY3KLoSaY
         fjv/my4lh9zxLOTvSQPjYYq8Q2bYUwj/btmzbWpWySbH9455q0BNuHu3swn0Q/Qtvl0i
         vqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699320371; x=1699925171;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsHiC64m8IGSdtWMFHLXRyA/pLAVjXzAVcs7FQFTJdU=;
        b=h9JzB36KWvBB4bKvvhCjfeJc128aatkXlAnJLp3xfZYrNZwvAUZGqw178fRpIukQD2
         tzvUW8UyOGja4jO4q0XnNgYsJ5IJ8GLVEssdY97gugXIs8LZCGWXO+R2l34ynPHdnsEz
         qTozj9VlATiO2cE3nCc7GTobgcKXv90oNqkdaXGKeqRNpEDuABWysek1RvbsOj6UFlrn
         dVzYN097s0uTeMhmJbUpTWCWFztx7TQAXidBd2MAwzfy5kRb8f43gDyqGikx0tDUK2vn
         oH7p1YaUNu8JGjdytxPgO86u8Peea4mNTp5nkTgxqHBGxLI1KXLyUGoDXdM2/oBGOj+A
         XoLA==
X-Gm-Message-State: AOJu0YxUDB7gzo/jkwPu3SW3Jbuhk7kwVY0yC/vaJYapRX+UX9iMkwpm
	7mfyj5M/ZFq/ZM39l0cfn4vGTLRE9kI=
X-Google-Smtp-Source: AGHT+IEDyPlyK+x3pvo1HPy00bC5FiZY3RZv/25fmZkPY2sxVkWdUIyHACeQDaVPuiNsB8gG6fw+Qg==
X-Received: by 2002:a05:600c:3b12:b0:406:44e6:c00d with SMTP id m18-20020a05600c3b1200b0040644e6c00dmr1274795wms.2.1699320371592;
        Mon, 06 Nov 2023 17:26:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b004064ac107cfsm13763203wmq.39.2023.11.06.17.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 17:26:11 -0800 (PST)
Message-ID: <352b5c42ac39d5d2646a1b6d47d6d707637db539.1699320362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Nov 2023 01:26:00 +0000
Subject: [PATCH 8/9] for-each-ref: add option to fully dereference tags
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Add a boolean flag '--full-deref' that, when enabled, fills '%(*fieldname)'
format fields using the fully peeled target of tag objects, rather than the
immediate target.

In other builtins ('rev-parse', 'show-ref'), "dereferencing" tags typically
means peeling them down to their non-tag target. Unlike these commands,
'for-each-ref' dereferences only one "level" of tags in '*' format fields
(like "%(*objectname)"). For most annotated tags, one level of dereferencing
is enough, since most tags point to commits or trees. However, nested tags
(annotated tags whose target is another annotated tag) dereferenced once
will point to their target tag, different a full peel to e.g. a commit.

Currently, if a user wants to filter & format refs and include information
about the fully dereferenced tag, they can do so with something like
'cat-file --batch-check':

    git for-each-ref --format="%(objectname)^{} %(refname)" <pattern> |
        git cat-file --batch-check="%(objectname) %(rest)"

But the combination of commands is inefficient. So, to improve the
efficiency of this use case, add a '--full-deref' option that causes
'for-each-ref' to fully dereference tags when formatting with '*' fields.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-for-each-ref.txt |  9 ++++++++
 builtin/for-each-ref.c             |  2 ++
 ref-filter.c                       | 26 ++++++++++++++---------
 ref-filter.h                       |  1 +
 t/t6300-for-each-ref.sh            | 34 ++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 407f624fbaa..2714a87088e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>]
 		   [ --stdin | <pattern>... ]
+		   [--full-deref]
 		   [--points-at=<object>]
 		   [--merged[=<object>]] [--no-merged[=<object>]]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
@@ -77,6 +78,14 @@ OPTIONS
 	the specified host language.  This is meant to produce
 	a scriptlet that can directly be `eval`ed.
 
+--full-deref::
+	Populate dereferenced format fields (indicated with an asterisk (`*`)
+	prefix before the fieldname) with information about the fully-peeled
+	target object of a tag ref, rather than its immediate target object.
+	This only affects the output for nested annotated tags, where the tag's
+	immediate target is another tag but its fully-peeled target is another
+	object type (e.g. a commit).
+
 --points-at=<object>::
 	Only list refs which points at the given object.
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 1c19cd5bd34..7a2127a3bc4 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -43,6 +43,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
+		OPT_BOOL(0, "full-deref", &format.full_deref,
+			 N_("fully dereference tags to populate '*' format fields")),
 		OPT_REF_FILTER_EXCLUDE(&filter),
 		OPT_REF_SORT(&sorting_options),
 		OPT_CALLBACK(0, "points-at", &filter.points_at,
diff --git a/ref-filter.c b/ref-filter.c
index 384cf1595ff..a66ac7921b1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -237,7 +237,14 @@ static struct used_atom {
 		char *head;
 	} u;
 } *used_atom;
-static int used_atom_cnt, need_tagged, need_symref;
+static int used_atom_cnt, need_symref;
+
+enum tag_dereference_mode {
+	NO_DEREF = 0,
+	DEREF_ONE,
+	DEREF_ALL
+};
+static enum tag_dereference_mode need_tagged;
 
 /*
  * Expand string, append it to strbuf *sb, then return error code ret.
@@ -1066,8 +1073,8 @@ static int parse_ref_filter_atom(struct ref_format *format,
 	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
 	if (valid_atom[i].parser && valid_atom[i].parser(format, &used_atom[at], arg, err))
 		return -1;
-	if (*atom == '*')
-		need_tagged = 1;
+	if (*atom == '*' && !need_tagged)
+		need_tagged = format->full_deref ? DEREF_ALL : DEREF_ONE;
 	if (i == ATOM_SYMREF)
 		need_symref = 1;
 	return at;
@@ -2511,14 +2518,13 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	 * If it is a tag object, see if we use a value that derefs
 	 * the object, and if we do grab the object it refers to.
 	 */
-	oi_deref.oid = *get_tagged_oid((struct tag *)obj);
+	if (need_tagged == DEREF_ALL) {
+		if (peel_iterated_oid(&obj->oid, &oi_deref.oid))
+			die("bad tag");
+	} else {
+		oi_deref.oid = *get_tagged_oid((struct tag *)obj);
+	}
 
-	/*
-	 * NEEDSWORK: This derefs tag only once, which
-	 * is good to deal with chains of trust, but
-	 * is not consistent with what deref_tag() does
-	 * which peels the onion to the core.
-	 */
 	return get_object(ref, 1, &obj, &oi_deref, err);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 0ce5af58ab3..0caa39ecee5 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -92,6 +92,7 @@ struct ref_format {
 	const char *rest;
 	int quote_style;
 	int use_color;
+	int full_deref;
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 0613e5e3623..3c2af785cdb 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1839,6 +1839,40 @@ test_expect_success 'git for-each-ref with non-existing refs' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'git for-each-ref with nested tags' '
+	git tag -am "Normal tag" nested/base HEAD &&
+	git tag -am "Nested tag" nested/nest1 refs/tags/nested/base &&
+	git tag -am "Double nested tag" nested/nest2 refs/tags/nested/nest1 &&
+
+	head_oid="$(git rev-parse HEAD)" &&
+	base_tag_oid="$(git rev-parse refs/tags/nested/base)" &&
+	nest1_tag_oid="$(git rev-parse refs/tags/nested/nest1)" &&
+	nest2_tag_oid="$(git rev-parse refs/tags/nested/nest2)" &&
+
+	# Without full dereference
+	cat >expect <<-EOF &&
+	refs/tags/nested/base $base_tag_oid tag $head_oid commit
+	refs/tags/nested/nest1 $nest1_tag_oid tag $base_tag_oid tag
+	refs/tags/nested/nest2 $nest2_tag_oid tag $nest1_tag_oid tag
+	EOF
+
+	git for-each-ref --format="%(refname) %(objectname) %(objecttype) %(*objectname) %(*objecttype)" \
+		refs/tags/nested/ >actual &&
+	test_cmp expect actual &&
+
+	# With full dereference
+	cat >expect <<-EOF &&
+	refs/tags/nested/base $base_tag_oid tag $head_oid commit
+	refs/tags/nested/nest1 $nest1_tag_oid tag $head_oid commit
+	refs/tags/nested/nest2 $nest2_tag_oid tag $head_oid commit
+	EOF
+
+	git for-each-ref --full-deref \
+		--format="%(refname) %(objectname) %(objecttype) %(*objectname) %(*objecttype)" \
+		refs/tags/nested/ >actual &&
+	test_cmp expect actual
+'
+
 GRADE_FORMAT="%(signature:grade)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
 TRUSTLEVEL_FORMAT="%(signature:trustlevel)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
 
-- 
gitgitgadget

