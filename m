Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89029ACC5
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230052; cv=none; b=DmEbXtASd0AjdRkv5VD+ag1aEKtGqIAf9is0aEckh2fePjI/OLucpMWdp27C9FWx5JaYCS/FytwxQ4Ey3NPQBYyU8wuHlwxea2QdYV2+XB/fHjWLN75Y908MzfLASyapA//zA3xB1DKmwLdQXYpAU3Vqp73YuXaOg+ulrGNav44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230052; c=relaxed/simple;
	bh=MSNUFxE/MgGFC4CieMZmOo1iWNF5nS38ZxGfeYmYAaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PW22r8u1S88ZzR6vpOYIAITa6v5uoDgbabNdUHL9ZeOBg1VbnRa/bXyKqn00QIZ9Il0y+MDMAayxInoWtRrukFVHyMiJ77oRDu8GMjQbREGqLWTNhTKfj9hN/gNr06fFzEB+Mezas22OfuBjqEcE7rb1oqyp9kkH+ggQeliVlKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d26Rz0cD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d26Rz0cD"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4629051c9d1so26346f8f.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782230050; x=1782834850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MA5Niqm9lYKMWCnFMXi1w84kmIeZMqnEigF9MGcguXw=;
        b=d26Rz0cDEPoAUbvofhhncfQGhE7Nxi/ag77wwtS10cifVSKr/eip8iUEyuSoIXhjcc
         Bmfh1BnRHn9FUKE7u7fRjoAv5oSj32s7V/UGFISlYbQKGO91M9NrSHLEvuGGxRIwdwR0
         2WyNGsQmJ4ldALkmz9cTRx8/TY4mPijqw+YVIG9qd3EhLSmE17+ToN+POE56m/8O35iA
         pHNjOVOj9D4Wba6PpbP6Iz/wiHUKStDGX/kVKJG7R0eAxLLGOFRc8FWLiRhTtzBbVnsz
         /RgjUic7F/QOqjn2FXQ7tHSbMQrPqoZhn5UtgluqonHIWIWqDqCmbE0IYs/9C5LJOMqZ
         WK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230050; x=1782834850;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MA5Niqm9lYKMWCnFMXi1w84kmIeZMqnEigF9MGcguXw=;
        b=CcjHoFk+NIyPLOqe0C3ZlP/Eq6lYrhl5PG2UvS6x7Tfmd+ZMXq+J8tQbf3W9U467Hv
         wqHv1JPjRwOMcQIXRmiD0ipaBRjUv5qjFSwvs8ctT4NUY/eu8XA2yyrk2LOgRRa+oXd5
         NVm0orQ+mW8RaicfBJpb98m27PQIqQMEXeAzf3LGoh3N72pCWBwcl0F4DT9ECrrAa6wo
         NeV8jVaqo7w8VYyGxU+Qltvm7RsJ/iEPIWR36RIhpM8+w64LvCfUF7ZHPepJRWUz75Zi
         m/p54eMvQcm5qBOVaT42Xl5uJiAmu05Vi6ICE0IFmnKSNi/8v+8Zn8hBn+u3qcCzGFsu
         QQCA==
X-Gm-Message-State: AOJu0YzoW0XlIr7uQ0oxndb3x4UP+Hkp4EEm7yvmf3qedTPyVr+VUQ5o
	3MnEbcV5hh7Zv0kzWckmpCcK+TVxoz/bU4j/ZgiGop9cw47ICFm2ey1eL7ghNA==
X-Gm-Gg: AfdE7cnWkJp6LozTdgq3blf56P6cWmQCpH/r5nZtroIAi8CHEWIiEwO+zEMzZQ2/Hqp
	gGcKQwpA7qz9/tQ6bkBm8FMd3BbHEg+Z3+hiw4lm7p6U/a3V+DJXcfVKXBpE2washdJGa2L2L8U
	D4iQ5nUAxoNLyDZHi/6NZ+iZwpv6IRjSXopItYThTEfc+P7uqP4zmbU/Ke9QOQMxeXLvZeemHGT
	G+89QffNOE7k0nrgHUgyvZoWviKfUEzvcsfRiFiAiM/jEaYE1lDqY2if4zQhgWoBhpc/IOSADRG
	2eHYyp/6Vv4gVB9qR9n35qoDVAgxs3atKTA4zRj6TP4EQ4yc7Zk0AnhKeLlwoRxD+1eEFLJAOQm
	uWBj1bMbE/wEIIq+KxxItdGdzqTj1mTnDn4C2HkVr0JS+68rR/PTfBs2D3R4i6eIpYfC5oSEoah
	K5Yx1lGzWfF2AsRO2Akni83HIgbms=
X-Received: by 2002:a05:600c:348f:b0:492:4636:87ae with SMTP id 5b1f17b1804b1-492463687d1mr299967875e9.17.1782230049585;
        Tue, 23 Jun 2026 08:54:09 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7b9e5sm371729505e9.10.2026.06.23.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:54:09 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 1/2] sequencer: factor out parsing of todo commands
Date: Tue, 23 Jun 2026 16:53:56 +0100
Message-ID: <d27dddff93144f7b6d7fc89719bdf53b6856c9fc.1782230024.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1782230024.git.phillip.wood@dunelm.org.uk>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk> <cover.1782230024.git.phillip.wood@dunelm.org.uk>
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
index b7d8dca47f4..b8e860434a8 100644
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
index a6fa670c7c1..28fabef926f 100644
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
2.54.0.200.gfd8d68259e3

