Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053435BDAD
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697515; cv=none; b=QaUhngah7L8tkbsJ7LLRbAxzEd54p9B+hGwfYUIOqLsG5kUp2RqaGadQfTZjmDFKLN84DIrgoKg2+o9LhqzTFo/2JwNKn37kjyRLZ1b9kQXahQ+jWsbZ24B0QSPt6xErf/IZX2vEy9T648Zwo8pIKTF75detUmkBgVQ6mFlwvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697515; c=relaxed/simple;
	bh=EwVJoVttJ2i3GWmnSN6VtWcVGssvnrXPXMmrhh7JjA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xj8bAIbAft462xLIzDjcT1Q3jMYcYCpWBmYjnB46mhhDWVbz8OfoWLN3X5AFtFRC/DX8Hv6bx1BaDl+2VzBHC1i0TykOI3+z72iV0AC3wG2MouryTprCeUJd6aK5rouN83qvJC9BHGL9HD08Ac2jnR2lhmwFMT8svN9W4o7L6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIo4AoZ+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIo4AoZ+"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso1932778f8f.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776697512; x=1777302312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yWWgr3H0xEueCxQ1iV3aH3jbCqkMxwfRHZm6VOt5fyU=;
        b=sIo4AoZ+qClfEeXgwYRuekWg6SuWOkXrXz3G4E1Gq5k8PEaNrRvt2mffrBp+JTlxVV
         mGeynAf5UYnenuqHD/GlJeRSF+KX+CBVtD+cV9thFeXenckgVzqj+YVYtC8+BImeVXBd
         irobC6DLoEK98rqI2I4OTU3KbvKPV8L4pnKaV6rgYDuGeLBT1B2dWGeKqmblzmO8Vybn
         7MrqrPgBetOCc3SY3xf0K+kdR/qQrIzP/x6MOc3PfMhH+/Jhl0Ok57h3phN+BrN90MXw
         3cEOytgXU7zfrmdWMc0FwgrulTkTBk+lSVSm+aUSWu3ro9AEphJdmnntoAy4zSD0TskR
         g9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776697512; x=1777302312;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWWgr3H0xEueCxQ1iV3aH3jbCqkMxwfRHZm6VOt5fyU=;
        b=Bm5MYVLtSHfp5vGD/wNN2c9zoSo1kHC3Ip/fBHHEcSn9nZr2Ay1ZV6GVjDuygO+NJB
         X0sJqjOO4zUjE+asmQnjOhNP6C6w7ADISZKHtClLFNaF1Ic9atdQwuZ8KYOwnQ/0RenS
         F9U57rUGuq/+yQxka1gAICmd5RMqMyYr4tTkKui3ZpunEH4ponunTm46oN5PC4HAeVYo
         UmEldQXFc4SOxe6KjJAxQY8KAaXNpPPH22obSC8k61yd3f7OOlvwm5LlxCji18fkyXnt
         gpgX3sZ11ppRWJMwuQZsz2aUDWNrJAnNtqNz5qE4fjMaUjIWeJg7qimGPm3HYi34+vSa
         RDbA==
X-Gm-Message-State: AOJu0Yw9+EQ0j/fz+MJKXNh9D+g/lBhc079yy6vay6Q9B7822WePT6ND
	evZCFp/bhOdrkjWXbVNL9DsqSV3QiCUvdibt25/HAl8HM73aAJTsXQTvKmrpqg==
X-Gm-Gg: AeBDieuEGteqY1fchajdWblKE5FTYEjJaKF6gGc3gbOtgHNnkJJhreZ3tgdD3sdUB06
	0oV/NjQrW2kXRSQWJGMRNqho6OpaFEPHxBFqgK0svfLBABt3ak5fprjct5LHKwWZW1NVDZy5hle
	wGAFNEX77jHQB60p+aGDjPJokBFA7zOSlatqKkqyYjxABVG4aUGFHpX47sEax/bMcjDbFjO/JMy
	f3ifpUm7RF17qKAx3lHXmUNGFReVZu3eqD9txqeGfazd/XJ94tpbUxdLHj4NPE9yZ8HUI4xDfh0
	zkl7JyhpgnCllu+b+P6BB6VA/j2+AdzTlc6rPaUgn91xNkgFvICs3m2xCgHwbAKsj1kYIJNRBu5
	xk37GVfS+ldD6s8RGi8Q6yOvEPrY2rSWN5/BCcUKMl7ltglh4y7B02dr2FIVg4cMJWetlJysIcC
	MF6QIZIpiFzCck/aYY2QfpBTg2mciduEktd4B5
X-Received: by 2002:a05:600c:5295:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-488fb77d12dmr193608875e9.16.1776697512159;
        Mon, 20 Apr 2026 08:05:12 -0700 (PDT)
Received: from berwick ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52583fe7sm27335685e9.13.2026.04.20.08.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:05:10 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/2] sequencer: factor out parsing of todo commands
Date: Mon, 20 Apr 2026 16:04:43 +0100
Message-ID: <3d5135a719221031e50ad8067ff42740a3bbce0c.1776697483.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.rc1.174.gd833f386ac5.dirty
In-Reply-To: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Move the code that parses todo commands into a separate function so that
it can be shared with "git status" in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 45 ++++++++++++++++++++++++++++++---------------
 sequencer.h |  1 +
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..b8e860434a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2625,6 +2625,27 @@ static int is_command(enum todo_command command, const char **bol)
 		return 1;
 	}
 	return 0;
+}
+
+bool sequencer_parse_todo_command(const char **p, enum todo_command *cmd)
+{
+	const char *s = *p;
+
+	for (int i = 0; i < TODO_COMMENT; i++)
+		if (is_command(i, p)) {
+			*cmd = i;
+			return true;
+		}
+
+	if (starts_with(s, comment_line_str)) {
+		*cmd = TODO_COMMENT;
+		return true;
+	} else if (s[0] == '\n' || (s[0] == '\r' && s[1] == '\n') || !s[0]) {
+		*cmd = TODO_COMMENT;
+		return true;
+	}
+
+	return false;
 }
 
 static int check_label_or_ref_arg(enum todo_command command, const char *arg)
@@ -2716,29 +2737,23 @@ static int parse_insn_line(struct repository *r, struct replay_opts *opts,
 {
 	struct object_id commit_oid;
 	char *end_of_object_name;
-	int i, saved, status, padding;
+	int saved, status, padding;
 
 	item->flags = 0;
 
 	/* left-trim */
 	bol += strspn(bol, " \t");
 
-	if (bol == eol || *bol == '\r' || starts_with_mem(bol, eol - bol, comment_line_str)) {
-		item->command = TODO_COMMENT;
-		item->commit = NULL;
-		item->arg_offset = bol - buf;
-		item->arg_len = eol - bol;
-		return 0;
-	}
-
-	for (i = 0; i < TODO_COMMENT; i++)
-		if (is_command(i, &bol)) {
-			item->command = i;
-			break;
-		}
-	if (i >= TODO_COMMENT)
+	if (!sequencer_parse_todo_command(&bol, &item->command))
 		return error(_("invalid command '%.*s'"),
 			     (int)strcspn(bol, " \t\r\n"), bol);
+
+	if (item->command == TODO_COMMENT) {
+		item->commit = NULL;
+		item->arg_offset = bol - buf;
+		item->arg_len = eol - bol;
+		return 0;
+	}
 
 	/* Eat up extra spaces/ tabs before object name */
 	padding = strspn(bol, " \t");
diff --git a/sequencer.h b/sequencer.h
index a6fa670c7c..20f6fac48a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -262,6 +262,7 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 int write_basic_state(struct replay_opts *opts, const char *head_name,
 		      struct commit *onto, const struct object_id *orig_head);
 void sequencer_post_commit_cleanup(struct repository *r, int verbose);
+bool sequencer_parse_todo_command(const char **p, enum todo_command *cmd);
 int sequencer_get_last_command(struct repository* r,
 			       enum replay_action *action);
 int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
-- 
2.54.0.rc1.174.gd833f386ac5.dirty

