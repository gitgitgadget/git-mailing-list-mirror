Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8733932F4
	for <git@vger.kernel.org>; Fri,  1 May 2026 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777648618; cv=none; b=HJNss8JEiN2SO02yEK1sncPXlm9pdW8fflwV6SBZnTqMlqvJowa9iZjI4WSzzq6Gf+cFsIQ9OVIUGpZr1xp8iWrk0I9M3kn74fuyog/2AsgxCNC7QOcJhEYA2Avoiej9K36MGijNjl5vTzYrVAongttIkoiQW/TOi3ATtW/6I8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777648618; c=relaxed/simple;
	bh=1N8h3AYvJYJLaaip8x5ihrlyPhiWyVixpU9861t6CnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5su58sF1Lfm3DQt8xivpu9l2X8YtRCl+9/dk74sU0c5kqnIWe9YM1yDJ7FRhOgqLOmEFpZMr3/26ajnPGRHP74fWZPg9g9Z7yDgLelAsvTQBRkyEG/57d0m+uKcaPY/CfTvCIgFNcxmtj4n/aX1F0CzvvNSAg9TTNUN6UAUZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXfKS4da; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXfKS4da"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so32463495e9.2
        for <git@vger.kernel.org>; Fri, 01 May 2026 08:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777648615; x=1778253415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qr7z7J5/+EChMSxHchEHhAn9CJzTQ7LiE811JrEtlFo=;
        b=cXfKS4dacgcv5joFotZvaidY9MOuPnFgfL+3Nxg9X5kA0oBvSBAmtli6YvGseSo2t7
         bw+KKveaCPWPtbh9CqLahhMGOrDzmbNjzgn4z/bV4n1qluwdl/LgCP0W3o+2LafsngaN
         Nk05jMSjwTZ4aCR3ZEKxxXls6q6FTWThjxaNLWxjnx8FsD2sv9Alb/E/QL9wUkGOtUHV
         H3aaawaKrKEM5rfVMsrdT4+lZC+P5TyRaCs7JCxVQwyau59RMvBdl2501uT7wAC1iiCp
         CNPLmkkKzg9vPQ3jZu9oPr/pwnIbYlOyyQRPDUHQWi4iZ0GPrnPqHs6eXcaQ30MSMi0E
         H3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777648615; x=1778253415;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qr7z7J5/+EChMSxHchEHhAn9CJzTQ7LiE811JrEtlFo=;
        b=OEeM4bRbpl627cn04CudXAUb3QtBO6MgI1D6ESnwqFfi4d1LMdjdE8HqQ1xhl7zlk1
         6NJHRUDZASvjmRX9qdb9KAc2XEtAADJe29GORCWc3VhC0K9Bxkl6rhIORh5AwxC2MS5Y
         cAg2eUjxv5pxvsCjGLp6waeBCiHtCLaYkW0l9k83dCNAkrCGLRDiaRBu92h++U1sm7bc
         B7u/jalbL9f8rtnDBh53e/lOZiexi53YOwKezaaFQfq4IwfK2uacvvp/ofSsXFHep9wj
         ElEDIy7DreMjK6D1Seb7IPZ7OLJtHRR8QQ2SoQkB3aZRV9YDrRfL6QojJ3c2hgaYWn0t
         V57A==
X-Gm-Message-State: AOJu0Ywe/P/GyORrbWeh7Vi5wwyD2N+FMjH8c9gtXXypjL/XK634zRCD
	PzlST+1YYa4JSisGxRVKu7CosV7SK6yLFgh/GFYWnTBUdaDGtlvUDlQUenh72w==
X-Gm-Gg: AeBDietq5kLeXeOaOyZZr/Nak7P+NwaNXrn+7MBMi3v87zNZA08DAHJmaTe36fDgVmf
	OWskPT3DbSqMpXTnXUhuIDiV/8oSHrB0xe4ZmSvc8SkL+cbmr+lQPvFqIRQwXGdGdWlVWCE+fcE
	E/j4NlGrb74J1p5S/WYnP+oksESQZBN3AG5JZjR4ADwHR5hLQB6M9vLXbq8NXLxchl+d70dwFzV
	wgZXiWuV/kZ7W5DPr/sjArzGgHPNLJyeoMVd9heKfEvLAu5UcsqxWPGCp1Hz9j1gLop4jqsYQMI
	nuYKNip7b+28NH54tO4xGSksfWbHnE6CYgZuxvwNt8q9zfqJ+T433Bcm1mFS4F68uCClP/QNgA3
	RmrY0FohCL10la+Abh22MHNiD0ev6gzPnxzmeihHdltgLgGfF6BeoYA3JL6iAl5gOE4pZaG6aLG
	FHaxmkzLsqzt0COCYoRg3QKg3w882x7iZrGdiMlSg=
X-Received: by 2002:a05:600c:350c:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-48a8449e51amr129775825e9.27.1777648615140;
        Fri, 01 May 2026 08:16:55 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1706:1a01:7ae4:ef77:45ac:8456])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fef2a67sm20837745e9.5.2026.05.01.08.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:16:54 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 0/2] status: improve rebase todo list parsing
Date: Fri,  1 May 2026 16:16:37 +0100
Message-ID: <cover.1777648598.git.phillip.wood@dunelm.org.uk>
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

When there is rebase in progress "git status" displays the last couple
of completed and the next couple of pending commands from the todo
list. When it does this is tries to abbreviate the object ids of
the commits to be picked. Unfortunately it does not abbreviate the
object ids when the line starts with "fixup -C" or "merge -C". It
also mistakenly replaces the refname in "reset main" and "update-ref
refs/heads/main" with the object id that the ref points to.

This series fixes that. The first patch factors out the sequencer
code that parses the command names in the todo list. The second patch
uses that function in "git status" to parse the command names so that
it knows whether the line may contain "-C" and whether there is an
object id that should be abbreviated.

Thanks to Elijah and Patrick for their comments in V1.

Changes since V1:

Patch 1 - Expanded commit message and added a code comment.

Patch 2 - Fixed some typos, added a code comment and clarified that -Wswitch
          is included by -Wall.

Base-Commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fimprove-status-todo-list-parsing%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/8c9303b1f...b80bc1e0a
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/improve-status-todo-list-parsing/v2


Phillip Wood (2):
  sequencer: factor out parsing of todo commands
  status: improve rebase todo list parsing

 sequencer.c            |  45 +++++++++-----
 sequencer.h            |   8 +++
 t/t7512-status-help.sh |  74 +++++++++++++++--------
 wt-status.c            | 131 +++++++++++++++++++++++++++++++++--------
 4 files changed, 191 insertions(+), 67 deletions(-)

Range-diff against v1:
1:  3d5135a719 ! 1:  d27dddff93 sequencer: factor out parsing of todo commands
    @@ Metadata
      ## Commit message ##
         sequencer: factor out parsing of todo commands
     
    -    Move the code that parses todo commands into a separate function so that
    -    it can be shared with "git status" in the next commit.
    +    Move the code that parses todo commands into a separate function so
    +    that it can be shared with "git status" in the next commit. As we
    +    know the input is NUL terminated we do not pass a pointer to the end
    +    of the line and instead test for a blank line by looking for NUL, CR
    +    LF, or LF. We use starts_with() instead of starts_with_mem() for the
    +    same reason. This results in slightly different behavior when there
    +    a CR at the start of the line that is not followed by LF. Previously
    +    such a line was treated as a comment rather than an invalid line.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
    @@ sequencer.h: int read_author_script(const char *path, char **name, char **email,
      int write_basic_state(struct replay_opts *opts, const char *head_name,
      		      struct commit *onto, const struct object_id *orig_head);
      void sequencer_post_commit_cleanup(struct repository *r, int verbose);
    ++
    ++/*
    ++ * Try to parse the todo command pointed to by *p. On success sets cmd,
    ++ * advances p and returns true. On failure returns false, leaves p and
    ++ * cmd unchanged.
    ++ */
     +bool sequencer_parse_todo_command(const char **p, enum todo_command *cmd);
    ++
      int sequencer_get_last_command(struct repository* r,
      			       enum replay_action *action);
      int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
2:  d20dc1f655 ! 2:  b80bc1e0a2 status: improve rebase todo list parsing
    @@ Commit message
     
         When there is rebase in progress "git status" displays the last couple
         of completed and the next couple of pending commands from the todo
    -    list. When it does this is tries to abbreviate the object ids of
    +    list. When it does this it tries to abbreviate the object ids of
         the commits to be picked. Unfortunately it does not abbreviate the
         object ids when the line starts with "fixup -C" or "merge -C". It
         also mistakenly replaces the refname in "reset main" and "update-ref
    @@ Commit message
         wider variety of commands. Only the pending commands in the tests
         are changed to avoid removing existing coverage.
     
    +    Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## t/t7512-status-help.sh ##
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
      	return split_in_progress;
     +}
     +
    ++/*
    ++ * If the whitespace-delimited token starting at or just after *pp *
    ++ * is a hex object id that is longer than its default abbreviation, *
    ++ * abbreviate it in-place, shrinking `line` accordingly. On return
    ++ * *pp points one past the (possibly abbreviated) token. Leaves both
    ++ * `line` and *pp-advanced-past-the-token unchanged in all other cases
    ++ * (non-hex token, unresolvable, or a refname that happens to consist
    ++ * only of hex digits).
    ++ */
     +static void abbrev_oid_in_line(struct repository *r,
     +			       struct strbuf *line, char **pp)
     +{
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
     +	p += strspn(p, " \t");
     +	end_of_object_name = p + strcspn(p, " \t");
     +	/*
    -+	 * The for "merge" and "reset" the object name may be a label or
    ++	 * For "merge" and "reset" the object name may be a label or
     +	 * ref rather than a hex object id. Only abbreviate the object
     +	 * name if it is a hex object id.
     +	 */
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
     +	*pp = end_of_object_name;
     +}
     +
    -+static void skip_dash_c(char **pp) {
    ++static void skip_dash_c(char **pp)
    ++{
     +	char *p = *pp;
     +
     +	p += strspn(p, " \t");
    -+	/* The (void) cast is required to silence -Wunused_value */
    ++	/* The (void) cast is required to silence -Wunused-value */
     +	(void)(skip_prefix(p, "-C", &p) || skip_prefix(p, "-c", &p));
     +	*pp = p;
      }
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
     +
     +	/*
     +	 * Avoid "default" and instead list all the other commands so
    -+	 * that -Wswitch warns if a new command is added without handling
    -+	 * it in this function.
    ++	 * that -Wswitch (which is included in -Wall) warns if a new
    ++	 * command is added without handling it in this function.
     +	 */
     +	case TODO_BREAK:
     +	case TODO_EXEC:
-- 
2.54.0.rc1.174.gd833f386ac5.dirty

