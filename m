Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7DDC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbhLUSGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240843AbhLUSF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:05:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8147C061751
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:56 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q16so28594235wrg.7
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QCeuIUWG/mTK4FgLws1WBcsISG+R3tnkdkUxD7ZYhHM=;
        b=Gqtift7zndHCZPaWQbV9L7IwVpNiyAJWGm97xuDHdN8MMXlbA9M4vxWoQRUOfjY0IC
         ASIWN/HIn7qr0TBmB7Apcg60ezFLrKOk9WJH70IHXb2FeuMef/+fAMQ3YdmciY4WmxnM
         ydRh7HO5nW0/v2Z9eMktbvx9nVod/uiv9TwEpMyrNmwKN8onnJPmWyoyjXp3NHfML7xD
         2d3YaPF2MaDK8bciRBRU+w4fbjWcG/6eFuLlvLqBafse+d00X5k4vHRHzIIADVwfFX7l
         6Fk1ExHGJnDjRpHGuefib27WpCwmu0N04RDd21ex2bdyCQhsKbjHilzcEKKJ1GladV3g
         M8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QCeuIUWG/mTK4FgLws1WBcsISG+R3tnkdkUxD7ZYhHM=;
        b=VNDW9/Hmq4Lz2LjGZD0tlQ55R9BPsO/Ox4WCJFnaJhBTUCQpXR9jGu0xLCn95payt7
         of4PySlxl1AmH7ydFbKvuLqEKPpTFXI6C+pTbqNInMi3GuMlrlSR/qmVwKNEZRU8v9Tb
         sQGEFY04CXqyICRRJeJ0nw/H+DQ7aTePdn6Un9cKFKsXxxsFocFMcD4VH4IuMX2l1bmY
         ZHRNrQlO5htmmvLddtNSUui6TiuGmNh+fdoifEjx3Gt6eBg0B3uheaEPIpGfMrKZmM+/
         F16MYdoAnCy0r4gX3TEuypLmqWyDQTbFmmn54yORUYgJ6faiVWESLhJZXh4yq4mponmF
         3kug==
X-Gm-Message-State: AOAM533sSt2a8DMaN4teaz5xbSw1gsPOFKXwkXuA+DyuP8eSp3vMst7G
        3vy4V3wi42sFC/FsQPxNnJD0B2WOOiM=
X-Google-Smtp-Source: ABdhPJxn6vB25CkRNbcG9vncgQgrsH9r5HznKfRy+YiIrUOB8lKM9HplSNKNadjFcEirbzlvNmS+TQ==
X-Received: by 2002:adf:a10f:: with SMTP id o15mr3580575wro.592.1640109955051;
        Tue, 21 Dec 2021 10:05:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm2991306wml.12.2021.12.21.10.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:05:54 -0800 (PST)
Message-Id: <b307f63569fdd8a546012aef8dd34ed0e5a5fb38.1640109948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 18:05:46 +0000
Subject: [PATCH 7/9] merge-ort: format messages slightly different for use in
 headers
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

We want to add an ability for users to run
    git show --remerge-diff $MERGE_COMMIT
or even
    git log -p --remerge-diff ...
and have git show the differences between where the merge machinery
would stop and what is recorded in merge commits.  However, in such
cases, stdout is not an appropriate location to dump conflict messages.
We instead want these messages to appear as headers in the subsequent
diff.  For them to work as headers, though, we need for any multiline
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
index c4d6c5c81cc..0ae3e4ffa75 100644
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

