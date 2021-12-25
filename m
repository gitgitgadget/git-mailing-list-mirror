Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326F7C433EF
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 07:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhLYH7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 02:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhLYH72 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 02:59:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF20C061759
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 23:59:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r17so21362977wrc.3
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 23:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y2o292HiBmC44baKOR9qVJHUiMjmq9AnHS83j6z88PY=;
        b=HsgUTHsuc+lHw6d2ynhPRYs/uCSim1qrmzfmc+9dRk81kPp4UJt1SBRMayWpN8LaN7
         D4uqKMkGv5624AnNNB2atMkXiEnFBnHIIg0PCiwhizFyfg2Lm4SXIxpcfATErsJ5bPOD
         2pF2IxUWvmKnvkd0yDp/a0y49Hfak3YCHmijeD64fJM64bhkIrXTqUUMot8BgQq0ELqY
         TGiUj3K8akQH9FxI3/Z/K3AY4jW3PixMnF3kSOxVK3t/pxn8OPbtG/KeZy2DD0g28XDu
         LAOmjg7jmPuucCNEVQ0+JIBzEUiD7AuS+ZU/F0wsj0H+2HTOd/ZRvKwDULxr/1tuoZu+
         bYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y2o292HiBmC44baKOR9qVJHUiMjmq9AnHS83j6z88PY=;
        b=2CmItZz2vke37XTkO2np9j7biNH4DMAMHn43K0wTq8hrx1UL9PDujvqZ+5i/LSHf9K
         Z3cLdblMm4aYdZi12dktc4UtInenbyK+3duls18XCPwqgUp8irQXUHgpZYcNm5r2k9Hi
         aY/L5BPyGA/LZi9c+7q1lXVIS5avH/R0VC+6O4jeHUBjWzwxktkHlWLJ71IEQWDbi/yp
         /EfOuRhp7xcpKc+YQ+nonxt+ifkPbVVNkc9ajMoYJ/541KqDTlWE0ZJa49zUkHUV/kA4
         5O/ifFdieSFYGNhO8LErXitNAN1zXfyt9woYC+fdyumN2vVoc4N37xiEeGLayQ31HL5z
         O9hA==
X-Gm-Message-State: AOAM532KxRICtAz9ij+/SZ4M4ji6zNEeIspl5Eg+ZUcCiz2OBYgPsvRn
        9AEjck8E7uW0BIp0+Zf/P5iniksLHSY=
X-Google-Smtp-Source: ABdhPJwzrq5YTmWJDE2OUM6p4L7rYJkDKeuCrg5vAc950Lqg7irxYN43Nl5nxUAfi1i8KNlTtdIDog==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr6745400wrs.270.1640419166392;
        Fri, 24 Dec 2021 23:59:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s189sm16046542wme.0.2021.12.24.23.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 23:59:26 -0800 (PST)
Message-Id: <887e46435c0561e86f1858682fe53e9de926b69c.1640419160.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
        <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Dec 2021 07:59:17 +0000
Subject: [PATCH v2 6/8] merge-ort: format messages slightly different for use
 in headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When users run
    git show --remerge-diff $MERGE_COMMIT
or
    git log -p --remerge-diff ...
stdout is not an appropriate location to dump conflict messages, but we
do want to provide them to users.  We will include them in the diff
headers instead...but for that to work, we need for any multiline
messages to replace newlines with both a newline and a space.  Add a new
flag to signal when we want these messages modified in such a fashion,
and use it in path_msg() to modify these messages this way.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c       | 36 ++++++++++++++++++++++++++++++++++--
 merge-recursive.c |  3 +++
 merge-recursive.h |  1 +
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 998e92ec593..9142d56e0ad 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -634,17 +634,46 @@ static void path_msg(struct merge_options *opt,
 		     const char *fmt, ...)
 {
 	va_list ap;
-	struct strbuf *sb = strmap_get(&opt->priv->output, path);
+	struct strbuf *sb, *dest;
+	struct strbuf tmp = STRBUF_INIT;
+
+	if (opt->record_conflict_msgs_as_headers && omittable_hint)
+		return; /* Do not record mere hints in tree */
+	sb = strmap_get(&opt->priv->output, path);
 	if (!sb) {
 		sb = xmalloc(sizeof(*sb));
 		strbuf_init(sb, 0);
 		strmap_put(&opt->priv->output, path, sb);
 	}
 
+	dest = (opt->record_conflict_msgs_as_headers ? &tmp : sb);
+
 	va_start(ap, fmt);
-	strbuf_vaddf(sb, fmt, ap);
+	strbuf_vaddf(dest, fmt, ap);
 	va_end(ap);
 
+	if (opt->record_conflict_msgs_as_headers) {
+		int i_sb = 0, i_tmp = 0;
+
+		/* Copy tmp to sb, adding spaces after newlines */
+		strbuf_grow(sb, 2*tmp.len); /* more than sufficient */
+		for (; i_tmp < tmp.len; i_tmp++, i_sb++) {
+			/* Copy next character from tmp to sb */
+			sb->buf[sb->len + i_sb] = tmp.buf[i_tmp];
+
+			/* If we copied a newline, add a space */
+			if (tmp.buf[i_tmp] == '\n')
+				sb->buf[++i_sb] = ' ';
+		}
+		/* Update length and ensure it's NUL-terminated */
+		sb->len += i_sb;
+		sb->buf[sb->len] = '\0';
+
+		/* Clean up tmp */
+		strbuf_release(&tmp);
+	}
+
+	/* Add final newline character to sb */
 	strbuf_addch(sb, '\n');
 }
 
@@ -4246,6 +4275,9 @@ void merge_switch_to_result(struct merge_options *opt,
 		struct string_list olist = STRING_LIST_INIT_NODUP;
 		int i;
 
+		if (opt->record_conflict_msgs_as_headers)
+			BUG("Either display conflict messages or record them as headers, not both");
+
 		trace2_region_enter("merge", "display messages", opt->repo);
 
 		/* Hack to pre-allocate olist to the desired size */
diff --git a/merge-recursive.c b/merge-recursive.c
index bc73c52dd84..c9ba7e904a6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3714,6 +3714,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 
 	assert(opt->priv == NULL);
 
+	/* Not supported; option specific to merge-ort */
+	assert(!opt->record_conflict_msgs_as_headers);
+
 	/* Sanity check on repo state; index must match head */
 	if (repo_index_has_changes(opt->repo, head, &sb)) {
 		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
diff --git a/merge-recursive.h b/merge-recursive.h
index 0795a1d3ec1..ebfdb7f994e 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -46,6 +46,7 @@ struct merge_options {
 	/* miscellaneous control options */
 	const char *subtree_shift;
 	unsigned renormalize : 1;
+	unsigned record_conflict_msgs_as_headers : 1;
 
 	/* internal fields used by the implementation */
 	struct merge_options_internal *priv;
-- 
gitgitgadget

