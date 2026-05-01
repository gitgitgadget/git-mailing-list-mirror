Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AE53B2FF7
	for <git@vger.kernel.org>; Fri,  1 May 2026 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777648619; cv=none; b=pEvmALEmCrBGpINKIm9a8yOU38zIqfb3b75CE7LFonA+PNe+0pTjrriJBJVj77AKKW/57ckCJRo1A6Yx7ka9B8tOw3tpFtnUY6JJJfnPOp+zPSQ+lkmsZdoWyPm2Cl07e0xHe9fInmlGTXW9Ydjt4ujMI+/8KoACKm2k9Ys0GRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777648619; c=relaxed/simple;
	bh=d3CRA4pAczZCRTZEfYkAS2io2dyPT4sRYWIX+8HvmlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNUvX7bYFo1JBYvcJj870xn3/jvsAHWZaFt4oQYATnbxq/Qlyh5cTqAo3hCk2L8TAIQvfrajEKb46DGL/OrDb9pjuYtqNyN5nSK8HJ4+eCdvO8vIWe+WAS4p/D7/76d5LnYgHNJ7xbFPpGGtlc0wDkxQZM7eyVggwf4r/xXDkSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4XEJUYs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4XEJUYs"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so21116675e9.2
        for <git@vger.kernel.org>; Fri, 01 May 2026 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777648616; x=1778253416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p94OYKJWTFitcFgCE97DG3xZFDHpn+p6hpJ2297TO1c=;
        b=a4XEJUYsQFk8HHvDZVw4Sz5l037fwJwO4sklpMZ7HvDIBpZofF8Vb4b1lJKiqs2DEj
         p+bkkkQ+Ci5SmqnItyGTgtLgViznn0P7ZTVieucjRdQdiR4hHv8eYsmO+sh/U7cYxWNc
         7YQPIn/6WkEyQvb7mYjcTMwtyju2hWdTUmpqxUYE2+Us3AgWOy+lsJ+ScQ9gwcsTf0+1
         bmdrpT+NDfPnVyjS9pLprXHGBWFs3MXL6QAYAA6/biMf9CHaptI7RndacM5fNIisB3qG
         nySzqvvdQ27dGotwcQNRg8h1AiDicrUdVyW8MQmGBvC1KVk/FCPJ1Oam00H7VBD2GFES
         zZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777648616; x=1778253416;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p94OYKJWTFitcFgCE97DG3xZFDHpn+p6hpJ2297TO1c=;
        b=piUAPt0sPo4V/ycISWICzzKlgOQaN7gVjMGkNW8uIyhUo3QhLJfXp4gE6Tb4mVBV0s
         r05na0zhjNYqyNXqVL4TK9DCgkeFhih8SppdKLRVlOS7XOZom6OfJs6AHrkn+kjb0TFZ
         oxVl2fab50v09IDGy9YHBd48lqMQThjubwv9zEdNOu+rQ8Sa0gK4cl9t+uuWPP5L/ghF
         V+M8T+VKAEgKwBL6bTsWxlW/2D9CUVwtGkeLkh914ysa83pHNiOtKh+ZUM2z9UFfnwDM
         6n47a/LILO8Ynm7ov8vt6UmXtjSJYexZpbYKlivL4GVAEZ5v0v9wu+f3kggWF9Q2sf/R
         NsrQ==
X-Gm-Message-State: AOJu0YxoFDnGIg4nrb6UBzjNsLMdHEKo8FC+7Vc7NK/TDt4lI9hwtdpQ
	OBcibP5U4K2GU3UfWe3U6ESNvxQwuh243xYXkD+GFlJ3WRlMRfEBHxh1uBl9BQ==
X-Gm-Gg: AeBDieuczY95kYGY0zP/yhuLcHbORO0ftiPjdxLI3uyb0dHLEHnleDK5JyXj0aOG3/l
	P2TkLLS+BrLXcW4gDp+6FtJL6+mV2GCIathJAolEniGq/m7JrlSSUJSlH1fCaNPJySn0eFo9Smo
	LNtXdAvkAIv9O7WoEvXtEDvcf87Brn+07YxUrp5ea//V2Jss95l8vrSUUPvduvJoQCXITk37B28
	ctrNDJB4lJGWpAW4aUUzo3bulKiSKKu6y9PAGsAwvucw4INhb9zvMA9Bi11TiRf7uVAiHeoJorm
	bs/sXW6JP0G/aG4THVuVGpO0qjhB0Mp1vlNVp8sHEu97Mes2+jHXlNWjAZtKXsmk9voqkWY5U3j
	dw/VrS+Ps/5ilGwDEJF7uYMWzELvBfd8ZWU/BelHzaJUW7Cd1bO89TuRE+rFkBVbCjnMvpUM7n+
	R8d8yC1CQb0wXJIWQI++egmNJcwg2hJ2i4Og8iSsEW9KdlsuM5cA==
X-Received: by 2002:a05:600c:6995:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-48a8ebab77emr54893295e9.29.1777648616052;
        Fri, 01 May 2026 08:16:56 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1706:1a01:7ae4:ef77:45ac:8456])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fef2a67sm20837745e9.5.2026.05.01.08.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:16:55 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/2] sequencer: factor out parsing of todo commands
Date: Fri,  1 May 2026 16:16:38 +0100
Message-ID: <d27dddff93144f7b6d7fc89719bdf53b6856c9fc.1777648598.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.rc1.174.gd833f386ac5.dirty
In-Reply-To: <cover.1777648598.git.phillip.wood@dunelm.org.uk>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk> <cover.1777648598.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Move the code that parses todo commands into a separate function so
that it can be shared with "git status" in the next commit. As we
know the input is NUL terminated we do not pass a pointer to the end
of the line and instead test for a blank line by looking for NUL, CR
LF, or LF. We use starts_with() instead of starts_with_mem() for the
same reason. This results in slightly different behavior when there
a CR at the start of the line that is not followed by LF. Previously
such a line was treated as a comment rather than an invalid line.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 45 ++++++++++++++++++++++++++++++---------------
 sequencer.h |  8 ++++++++
 2 files changed, 38 insertions(+), 15 deletions(-)

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
index a6fa670c7c..28fabef926 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -262,6 +262,14 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 int write_basic_state(struct replay_opts *opts, const char *head_name,
 		      struct commit *onto, const struct object_id *orig_head);
 void sequencer_post_commit_cleanup(struct repository *r, int verbose);
+
+/*
+ * Try to parse the todo command pointed to by *p. On success sets cmd,
+ * advances p and returns true. On failure returns false, leaves p and
+ * cmd unchanged.
+ */
+bool sequencer_parse_todo_command(const char **p, enum todo_command *cmd);
+
 int sequencer_get_last_command(struct repository* r,
 			       enum replay_action *action);
 int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
-- 
2.54.0.rc1.174.gd833f386ac5.dirty

