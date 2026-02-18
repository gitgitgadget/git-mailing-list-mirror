Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF533B6E5
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771458153; cv=none; b=kEj/57DpE7Oj8wF+vd4B5MiqqhbhS7Ac1OMOVUlPSs8MpxiW6PPljuiFEjIxx7h6K4ydb+suB9yOGbPa9H0nLABW46NK/70DaFpOSzz5UVXGi/iE4kFsmhiPmNiR9XwBD1FzbavMP89uLr/qb6Eo4Rd22V7qlvtBNpV4rDm0Zho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771458153; c=relaxed/simple;
	bh=2XiUR5wYDNNdG1TCUkrSW/jmNiQHlxIXED+XBTT7wYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/rcOZUUAfbjoevRxes9zSNeYrHhwSwt9cYVdeloP+kZg1pzsHQuBAifo8+EyAU3pvKfCqeYF6Hd+3IXJiAX3e441QKYYoaHdjMeqxb9/7HRC+Rfed48Mc0JZYRmiF0e8BAsSg6/KYvExBartha+DvLc12/8WA3FsnIJknDuuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDiRRhfV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDiRRhfV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a9296b3926so2240855ad.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 15:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771458151; x=1772062951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=829zjxiO0xS5edZjbMtOxxJjuoo/DsfznO49Ky7PG5M=;
        b=EDiRRhfVPHViQp3jnWnA0jbf+5EbZlC05+Ck8x5wfWSLDkWUZYE1cHxfFGLYJ5LEH3
         I4Dg2XlvngB81Oh0XvJ0Mabix/xM6x6qCdsKIN76C59L03MjH7S33Ygv+QvJ4XyloSkJ
         GQGnadYTg1LcFGLZqPkVb9XSA9roWibfq5vNrA91HFbULMQ23wEGg/IoY7evaUOTO03m
         XyFW83eWa5uJGto2KGYmUO4iDoUdkmhR8bmL5DQhdd9KYMCB4Nui0tDXcytwFlGz4isa
         3lLeblC/HnxkJKgOyz+SlpgpqwtJYlK/TiYs49WiTlEPiUyFd9e2c5AN9FTmSMbSELv2
         tDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771458151; x=1772062951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=829zjxiO0xS5edZjbMtOxxJjuoo/DsfznO49Ky7PG5M=;
        b=KUeQVL9/4MtlrmJsf68owPW1D9BV8XhiN/DCWT+txoxP9npJIH/mOuGOCzM7xKZX+l
         rbIpCoYJEHZqsXgdkgJ5njhfRfrMTWA0oUYbMfYmp8QezGq8i3jM20zy4lBnf3uKtuvF
         612FVXt9WA9JnEs16rQbwKLKPd2HJQLKVe6NBj4MDu2ATPynJpNqrbEZt9TuplsYOlWQ
         neVNZFARha18dkH+Lwn9Fa9KzEn/+8Sx/msItmwhvTFo5h0rr6YK+Mevtlk/7R70AqyM
         e+iqUYX+OMUtkDLhpDmvp/Yey6dEzt0F/GqG9pFCGU2Scp80UB2rwt0HFPzrUEUgVS7a
         uWVw==
X-Gm-Message-State: AOJu0YyqunDkmOVJ35d3MinrT+eHnh0l0UA0SK2hgUwxy+AoERtDcF88
	hitS5tGndHfKAFplJk0m+XHRSS2q2IMpliZpowhCNIFUeRejBBJYMQr8ZXO0zIEq
X-Gm-Gg: AZuq6aL8MAg3J6dVELKRw/eCEZ6+y+t76nYTSawmKjMz12jMdkJqOYUageH4xNOQ3Eq
	7wPXHCFxdJKGH8c6e6yPSoy281ADD2UrriqCaeRYmn+DIEl0wKiPrntp97w/UIV0lYBPETZc81s
	KBqIE3ikbS+nyxlJgwsm/qptzx0NpwlbsErF15sX2SIhNxffx1DeWRhqXQ3k2pxgp1Ajxj13cQV
	BKTqjbsge4BNCWFt49+HohnHOIprYHkH3DYAz3U5ZediE6R4C10bg6AA9m756L4vGWrUllkNQ2V
	B5kdYaKfObMBJYMUNEfmbdd1BuEg/NqjxCX81yy4mnPhGkSr9p0Nvb5Q6QtdTUNkYGQ2dCR/Jz/
	YulUOvF08erx1I5Ts1jHdGDy20L2xEJ55O3iJB4gvTubFcqjsxjVazatvWBlL7DmhCAJwXfJ6Ra
	TcKU5FBp2b1tLmtnorPdQP+l2SJbsZZAsmKn/nk/cpMFHxgS9pzHgZB+Wa
X-Received: by 2002:a17:903:3c2e:b0:2aa:e574:d7e8 with SMTP id d9443c01a7336-2ad50d3ab18mr28120465ad.0.1771458151231;
        Wed, 18 Feb 2026 15:42:31 -0800 (PST)
Received: from localhost ([2409:40e3:308b:f961:2424:da5b:f01:e777])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a73c6easm192224565ad.39.2026.02.18.15.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 15:42:30 -0800 (PST)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	karthik.188@gmail.com,
	johannes.schindelin@gmx.de,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 1/2] sequencer: extract revert message formatting into shared function
Date: Thu, 19 Feb 2026 05:12:14 +0530
Message-ID: <20260218234215.89326-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218234215.89326-1-siddharthasthana31@gmail.com>
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic for formatting revert commit messages (handling "Revert" and
"Reapply" cases) is currently duplicated between sequencer.c and will be
needed by builtin/replay.c.

Extract this logic into a new sequencer_format_revert_header() function
that can be shared. The function handles both regular reverts ("Revert
"<subject>"") and revert-of-revert cases ("Reapply "<subject>"").
When an oid is provided, the function appends the full commit hash and
period; otherwise the caller should append the commit reference.

Update do_pick_commit() to use the new helper, eliminating code
duplication while preserving the special handling for commit_use_reference.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 sequencer.c | 47 +++++++++++++++++++++++++++++++----------------
 sequencer.h | 11 +++++++++++
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1f492f8460..b32347c853 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2356,8 +2356,6 @@ static int do_pick_commit(struct repository *r,
 	 */
 
 	if (command == TODO_REVERT) {
-		const char *orig_subject;
-
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -2365,22 +2363,10 @@ static int do_pick_commit(struct repository *r,
 		if (opts->commit_use_reference) {
 			strbuf_commented_addf(&ctx->message, comment_line_str,
 				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
-		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
-			   /*
-			    * We don't touch pre-existing repeated reverts, because
-			    * theoretically these can be nested arbitrarily deeply,
-			    * thus requiring excessive complexity to deal with.
-			    */
-			   !starts_with(orig_subject, "Revert \"")) {
-			strbuf_addstr(&ctx->message, "Reapply \"");
-			strbuf_addstr(&ctx->message, orig_subject);
-			strbuf_addstr(&ctx->message, "\n");
+			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
 		} else {
-			strbuf_addstr(&ctx->message, "Revert \"");
-			strbuf_addstr(&ctx->message, msg.subject);
-			strbuf_addstr(&ctx->message, "\"\n");
+			sequencer_format_revert_header(&ctx->message, msg.subject, NULL);
 		}
-		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
 		refer_to_commit(opts, &ctx->message, commit);
 
 		if (commit->parents && commit->parents->next) {
@@ -5572,6 +5558,35 @@ int sequencer_pick_revisions(struct repository *r,
 	return res;
 }
 
+void sequencer_format_revert_header(struct strbuf *out,
+				    const char *orig_subject,
+				    const struct object_id *oid)
+{
+	const char *revert_subject;
+
+	if (skip_prefix(orig_subject, "Revert \"", &revert_subject) &&
+	    /*
+	     * We don't touch pre-existing repeated reverts, because
+	     * theoretically these can be nested arbitrarily deeply,
+	     * thus requiring excessive complexity to deal with.
+	     */
+	    !starts_with(revert_subject, "Revert \"")) {
+		strbuf_addstr(out, "Reapply \"");
+		strbuf_addstr(out, revert_subject);
+		strbuf_addch(out, '\n');
+	} else {
+		strbuf_addstr(out, "Revert \"");
+		strbuf_addstr(out, orig_subject);
+		strbuf_addstr(out, "\"\n");
+	}
+
+	strbuf_addstr(out, "\nThis reverts commit ");
+	if (oid) {
+		strbuf_addstr(out, oid_to_hex(oid));
+		strbuf_addstr(out, ".\n");
+	}
+}
+
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 {
 	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
diff --git a/sequencer.h b/sequencer.h
index 719684c8a9..b7291cc52d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -271,4 +271,15 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
  */
 int sequencer_get_update_refs_state(const char *wt_dir, struct string_list *refs);
 
+/*
+ * Formats a revert commit message following standard Git conventions.
+ * Handles both regular reverts ("Revert \"<subject>\"") and revert of revert
+ * cases ("Reapply \"<subject>\""). Adds "This reverts commit <oid>." if oid
+ * is provided, otherwise just adds "This reverts commit " and the caller
+ * should append the commit reference.
+ */
+void sequencer_format_revert_header(struct strbuf *out,
+				    const char *orig_subject,
+				    const struct object_id *oid);
+
 #endif /* SEQUENCER_H */
-- 
2.51.0

