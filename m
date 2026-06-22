Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C211238159
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117389; cv=none; b=sjXsCjzye66pmstGfmiAbCKAcinKQ1ZrXsN+/PFiS/RSTWWTgkTfeG+7l7DLx8KNLNSKCsc6B10FCMyN82Tbdf9yXBM/3LuATrirrFziNWHS2U/3LF2ejvmFBTxpJan1PkjteHfj4gDg8FaCFnmAbH9CSdNjTgF89XXTo1XXelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117389; c=relaxed/simple;
	bh=KSeaNb8grm2uCdlFv72X+AoXugmWo770u/o6okclCHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPvZ2oMQp7KBipewVaTkv3DmjbNGvT0KTluYn33NWCfIlYeXjiq64Y8IaSK3UL8x5u7O+n7O62XXagXyTc/Z72XN6mejvO/+MeoWeWOlnlgnZN4yGsIJ8xP65WFXk3SjLjqbmnH848IJmPJ9K7AsKKe8TijknCBBSDjkPhq3BYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SglKGIcE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SglKGIcE"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4924593f45dso23630715e9.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782117386; x=1782722186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r+v9JcRiYhkI1ZEhp6z6yzBUJZNmpPrPfAUjOrUvmGo=;
        b=SglKGIcEZjuTxjrygc2mJCyHw+fjm7rw+/q94ML3BOaAQ9LlllLtreRObaUpdp/KrN
         Nm3PYmOmaLGafOPbJzanTdogHxjx9USKqd/xk9+6x87pEPbmz2+UlcdeQ3ypAd4SeTc4
         tQCbGYPRK1gqH9r8qE3TXkUNF5Rozez8qkZaqxHQbo/+ZvNmOJGrmraOB+ThIEB3UjAX
         0gAyWMcyDTIZEVRiVNH7qm2qEMvu78RAFrcliTVpoFMQ3TD10ibAGdRDysV2x42SreAz
         8GWZyklUSOlS1IGq1/42qQYsYQKWtn6U92m445g806bcE+6R3qERGwZ62KglJoqP/0hr
         0S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782117386; x=1782722186;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+v9JcRiYhkI1ZEhp6z6yzBUJZNmpPrPfAUjOrUvmGo=;
        b=cuUgu2nEDiuZvDLvmN8Ot1qHWnJoSpN5RuaPh41uUvpRShqURxcXi2GrdHDUCAzlNb
         wiGnbYWLpxMu1lQ2v5ZjkRJ/J4dsC/PQVhQ9xvKWCYoLqCA/V0offoJ5HbTzJya9Nv9s
         rFCbjpRJ2X2qdVNgtR/UirPi9l4U9IMx5QmnaJRam4bPbmwr/RNrJ1475Pwv/jqSqV1I
         48ke7WnZXgWelDg9ES3GH2jv1WUobBFI3jRusApViclUQglWbYwESqmL2vR6ldv/dU5E
         E0FyCqpWUY0aigZFPQYfLVmu10rn0vyjBabQhdrmCmampbqS9b10OybnVq5FlYUpMzoI
         6qvw==
X-Gm-Message-State: AOJu0YxG00HBmc+M9+DroJtdTom+kmCmPf1qNKCLUG9PerUr3GFiIZ7y
	mbeZaewOLD8tleb5pcbOCeHWDNR+D/QTbcrZDaltloJaeS7u2JXD4b/DePh/Tw==
X-Gm-Gg: AfdE7clitsv8lAomhK4tR7SrFU5FZ9Fv8+vCcwO9gEJUUm1LDKZYM182/xIlqaEyMqn
	gnHIqKAFte3SqcXJhQtt+NuyUJ3wrdX0Pv5EOk1YZiSlkt/NJ1ktpmWMMnGswJgG1KNfbcYm8JD
	fZ3Fg/yPDMKJa9ArUzHzyKJTSHLLVKlz7X9/NWc8F4KCAFo9CfJHPLEfLBhUgVxaKgvO58tJy78
	djTgmuMcJ4iFJIPvxisL7jylNA/ZYBtG99t4zM83G6l9q6x+wkVjDlBQwxeIbinEBC8R4HjLW21
	b5DzTs6O04LzCDQOKdsNHy4D8fDV7Ww6nS0up+iKhmIZHavbJb6NLMtKaksovGMt9n4Vgs3X1rz
	HgrJqasfVMIFn+HTmLkFAZsYrWh58dMwfaywzUXbMQeghSKvKby22VzGZ6hFN1H15uRm74tsrpO
	sh8sU7Oabd+uyHcYo9
X-Received: by 2002:a05:600c:a51:b0:490:c2a2:b1d4 with SMTP id 5b1f17b1804b1-4923f6a748fmr237772945e9.35.1782117386207;
        Mon, 22 Jun 2026 01:36:26 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494497ffsm201186945e9.11.2026.06.22.01.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:36:25 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 0/2] status: improve rebase todo list parsing
Date: Mon, 22 Jun 2026 09:36:02 +0100
Message-ID: <cover.1782117361.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
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

Thanks to Junio for his comments on V2.

Changes since V2:

Patch 2 - Check if the object name is a label before trying to
          abbreviate it.

Note that a number of the CI jobs fail[1] due to the rather old base,
but a test merge of this branch with "master" passes[2]

[1] https://github.com/phillipwood/git/actions/runs/27906115900
[2] https://github.com/phillipwood/git/actions/runs/27908204055

Changes since V1:

Patch 1 - Expanded commit message and added a code comment.

Patch 2 - Fixed some typos, added a code comment and clarified that -Wswitch
          is included by -Wall.

Base-Commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fimprove-status-todo-list-parsing%2Fv3
View-Changes-At: https://github.com/phillipwood/git/compare/8c9303b1f...b3514e9b1
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/improve-status-todo-list-parsing/v3


Phillip Wood (2):
  sequencer: factor out parsing of todo commands
  status: improve rebase todo list parsing

 sequencer.c            |  45 ++++++++----
 sequencer.h            |   8 +++
 t/t7512-status-help.sh |  74 +++++++++++++-------
 wt-status.c            | 154 +++++++++++++++++++++++++++++++++--------
 4 files changed, 213 insertions(+), 68 deletions(-)

Range-diff against v2:
1:  d27dddff931 = 1:  d27dddff931 sequencer: factor out parsing of todo commands
2:  b80bc1e0a29 ! 2:  b3514e9b1c9 status: improve rebase todo list parsing
    @@ Commit message
         the commits to be picked. Unfortunately it does not abbreviate the
         object ids when the line starts with "fixup -C" or "merge -C". It
         also mistakenly replaces the refname in "reset main" and "update-ref
    -    refs/heads/main" with the object id that the ref points to. Use
    -    the function added in the last commit to parse the command name and
    -    only try to abbreviate the argument for commands that take an object
    -    id. When trying to abbreviate an object id, only replace the object
    -    name if it starts with the abbreviated object id so that labels or
    -    branch names that contain only hex digits are left unchanged.
    +    refs/heads/main" with the object id that the ref points to.
    +
    +    Fix this by using the function added in the last commit to parse the
    +    command name and only try to abbreviate the argument for commands that
    +    take an object id. If a command accepts a label then try to resolve the
    +    object name as a label first and only if that fails try to resolve it
    +    as an object_id. When trying to abbreviate an object id, only replace
    +    the object name if it starts with the abbreviated object id so that
    +    tag or branch names that contain only hex digits are left unchanged.
     
         Comments are now processed after stripping any leading
         whitespace from the line. This matches what the sequencer does in
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
     +}
     +
     +/*
    -+ * If the whitespace-delimited token starting at or just after *pp *
    -+ * is a hex object id that is longer than its default abbreviation, *
    ++ * If the whitespace-delimited token starting at or just after *pp
    ++ * is a hex object id that is longer than its default abbreviation,
     + * abbreviate it in-place, shrinking `line` accordingly. On return
     + * *pp points one past the (possibly abbreviated) token. Leaves both
     + * `line` and *pp-advanced-past-the-token unchanged in all other cases
    -+ * (non-hex token, unresolvable, or a refname that happens to consist
    -+ * only of hex digits).
    ++ * (non-hex token, label name, unresolvable, or a refname that happens
    ++ * to consist only of hex digits).
     + */
    -+static void abbrev_oid_in_line(struct repository *r,
    -+			       struct strbuf *line, char **pp)
    ++static void abbrev_oid_in_line(struct repository *r, struct strbuf *scratch,
    ++			       struct strbuf *line, bool maybe_label, char **pp)
     +{
     +	char *p = *pp;
     +	char *end_of_object_name, saved;
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
     +	for (const char *q = p; q < end_of_object_name; q++) {
     +		if (!isxdigit(*q))
     +			goto out;
    ++	}
    ++	if (maybe_label) {
    ++		strbuf_reset(scratch);
    ++		strbuf_addf(scratch, "refs/rewritten/%.*s",
    ++			    (int)(end_of_object_name - p), p);
    ++		if (refs_ref_exists(get_main_ref_store(r), scratch->buf))
    ++			goto out; /* object name was a label */
     +	}
     +	saved = *end_of_object_name;
     +	*end_of_object_name = '\0';
     +	have_oid = !repo_get_oid(r, p, &oid);
     +	*end_of_object_name = saved;
     +	if (!have_oid)
    -+		goto out; /* object name was a label */
    ++		goto out; /* invalid object name */
     +	abbrev = repo_find_unique_abbrev(r, &oid, DEFAULT_ABBREV);
     +	if (!starts_with(p, abbrev))
     +		goto out; /* object name was a refname containing only xdigits */
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
     +	*pp = end_of_object_name;
     +}
     +
    -+static void skip_dash_c(char **pp)
    ++/* Skip "[ \t]*(-[cC])?", returns true if "-c/-C" was skipped. */
    ++static bool skip_dash_c(char **pp)
     +{
    ++	bool ret;
     +	char *p = *pp;
     +
     +	p += strspn(p, " \t");
    -+	/* The (void) cast is required to silence -Wunused-value */
    -+	(void)(skip_prefix(p, "-C", &p) || skip_prefix(p, "-c", &p));
    ++	ret = skip_prefix(p, "-C", &p) || skip_prefix(p, "-c", &p);
     +	*pp = p;
    ++
    ++	return ret;
      }
      
      /*
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
     -		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
     -		for (size_t i = 2; i < split.nr; i++)
     -			strbuf_addf(line, " %s", split.items[i].string);
    +-	}
    +-	string_list_clear(&split, 0);
     +	enum todo_command cmd;
    ++	struct strbuf scratch = STRBUF_INIT;
     +	char *p = line->buf;
     +
     +	if (!sequencer_parse_todo_command((const char**)&p, &cmd))
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
     +	case TODO_COMMENT:
     +		return false;
     +
    -+	case TODO_MERGE:
    -+		skip_dash_c(&p);
    ++	case TODO_MERGE: {
    ++		/*
    ++		 * The argument to -C cannot be a label, but the parents
    ++		 * can be labels.
    ++		 */
    ++		bool maybe_label = !skip_dash_c(&p);
    ++
     +		while (true) {
     +			p += strspn(p, " \t");
     +			if (!p[0] || (p[0] == '#' && (!p[1] || isspace(p[1]))))
     +				break;
    -+			abbrev_oid_in_line(r, line, &p);
    ++			abbrev_oid_in_line(r, &scratch, line, maybe_label, &p);
    ++			maybe_label = true;
     +		}
     +		break;
    ++	}
     +
     +	case TODO_FIXUP:
     +		skip_dash_c(&p);
     +		/* fallthrough */
     +	case TODO_DROP:
     +	case TODO_EDIT:
     +	case TODO_PICK:
    -+	case TODO_RESET:
     +	case TODO_REVERT:
     +	case TODO_REWORD:
     +	case TODO_SQUASH:
    -+		abbrev_oid_in_line(r, line, &p);
    ++		abbrev_oid_in_line(r, &scratch, line, false, &p);
     +		break;
     +
    ++	case TODO_RESET:
    ++		abbrev_oid_in_line(r, &scratch, line, true, &p);
    ++		break;
     +	/*
     +	 * Avoid "default" and instead list all the other commands so
     +	 * that -Wswitch (which is included in -Wall) warns if a new
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
     +	case TODO_NOOP:
     +	case TODO_UPDATE_REF:
     +		break;
    - 	}
    --	string_list_clear(&split, 0);
    ++	}
     +
    ++	strbuf_release(&scratch);
     +	return true;
      }
      
-- 
2.54.0.200.gfd8d68259e3

