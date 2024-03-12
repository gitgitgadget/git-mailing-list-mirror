Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DEE446DB
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254425; cv=none; b=mm/aUTN8l/KGRyoWlYhLSg3ZE1ZG/67DfYOgg5o7gj98Jk/+qTnCu5ov9C3MZk6BiJx7DsUirMdtDdLK7TljELbooaA0NjGqx6fYpdvrNFjeTo7UEXdy0qbiBZpAkXIYY8gM8M9ytBW1DIZd42VAfp2hgJ5YCne4VtETf+Y+BnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254425; c=relaxed/simple;
	bh=IHBRYKzl+ro9Lc2/8lkmEUXHDlWy6kJKCNu3ABV9xwM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hl2dJIGyZyblqXqUyC3ELeDQR8vrZSaafnqRRYIcckVi2l5lkH4Y8z9IhVWOxP4HLmb37NW65rg05S+o3uEoCxrQYps5OyF57NwCHrWkwTdIljge4jNz2Gih0oEkAKz2Ue17iEUg/4o6N81qrhQZfPdtoaPGKSgXGHv+MNfSFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwPPzXpl; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwPPzXpl"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513b16bb739so1688376e87.3
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710254421; x=1710859221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ULcK97+xsWYrtdBHCgqM+vrWcZFtZdT5OJIplXmyPeM=;
        b=KwPPzXpla951LVnhlKyJvucrnoMFIBcw8ab850RPkxDPc73viPTPyh95YPWJxLN61k
         egMiwonFq/JSvi6sUTcHMR1/X6sVo2MWefogod+PhzcGW8Tq/qwsBWKpRS+JilFfW3Qu
         gbhi/R2RqZv7ieGtzF/WEQnqa9m4RB8HnrqOpTWX6OesCkHYpSwhYicIRTGPilwT6t4/
         tYAUluudezART4O2czAPUsi/U/avlZnpC2ppY6FgaTPqO78YlTdfnvVyJGblBUdLc8PB
         b6lAN9pJS+aqYArE1QxEATFYFl6sSCmo943TffyGqXLTLQwmB+TyN0jurHELBlKDgzAn
         VahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710254421; x=1710859221;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULcK97+xsWYrtdBHCgqM+vrWcZFtZdT5OJIplXmyPeM=;
        b=WnADRFiKEKnu1F84hejoEXiEfPjGI0UpDw3wLbmDF3eSQHEb5A4GAU8bfEL1Dtlgok
         jtRfygfwxVhH4dG5hlKRtuIaAuXu9YQcWa+pNeR8jn6ho2obiIUVB//9uxd0ZMUNhrct
         n2UA9Ib0EM4gLclR/fCbb2QJZQO4Kd12fGkX6ETE5msWRTBkMcb3m9dnYPVNdTdoFzfV
         VXzMwZD91+bLhkoFbtgQLRZeRr0OLPZYhej6e6uunYAvFndCpI1850dPNkG5/715V+ri
         Q7JhPSe6p+IgkehBZhmsLssI4on4FAvfsBYzQnhWVX2LvC5HAtSyf9ePh3Dhec/c99uy
         NHBg==
X-Forwarded-Encrypted: i=1; AJvYcCUq2pgBel9PanOn9Vhj+d53rHtJ7ND7kUPcNyxlVB+jLF699ltvC0GTSp1ed4P3OZS8n+NrKKPTayaw+IHulLmECu77
X-Gm-Message-State: AOJu0YyaTunm/7mWIGilUUJpszl2VZ/9uo0VX62vrW7lgcnYOD6owFun
	GdsI2Z0swc8e5GE7+JWlykjSkm4HQ1A37dPsupagKoktAG36EmBr
X-Google-Smtp-Source: AGHT+IESTmUqb/owwAsbEdODRCoC5XrMHsAwy6h53Bz88HOd0SbCdS/xzYJhtk3JZhViyVxaEHmSyA==
X-Received: by 2002:a05:6512:39ce:b0:513:a833:cda2 with SMTP id k14-20020a05651239ce00b00513a833cda2mr5524558lfu.53.1710254421110;
        Tue, 12 Mar 2024 07:40:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id j27-20020a05600c1c1b00b00412f83e0c11sm19043875wms.22.2024.03.12.07.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 07:40:20 -0700 (PDT)
Message-ID: <7cc7d539-7f31-4cd8-bcc8-a98a67a5079f@gmail.com>
Date: Tue, 12 Mar 2024 14:40:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/16] allow multi-byte core.commentChar
Content-Language: en-US
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Manlio Perillo <manlio.perillo@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
 <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
 <xmqqsf1466eh.fsf@gitster.g> <52d6850914982ffaf15dda937d611ffb@manjaro.org>
 <xmqqmsrc4osm.fsf@gitster.g>
 <20240306080804.GB4099518@coredump.intra.peff.net>
 <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240312091013.GA95442@coredump.intra.peff.net>
In-Reply-To: <20240312091013.GA95442@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 12/03/2024 09:10, Jeff King wrote:
> Here's a revised version of my series. It incorporates the fixups I sent
> (which I think Junio had applied already), and incorporates a new patch
> at the beginning to forbid newlines.
> 
> I _didn't_ convert any of the starts_with_mem() call to starts_with().
> I'm on the fence on whether that is simplifying things or creating
> potential confusion/bugs later.
> 
> If we don't like the new patch 1 (or if we prefer to do it on top; there
> is really not much reason to prefer one or the other), then this should
> otherwise be the same as what Junio has already queued as
> jk/core-comment-char.

Looking through the range-diff it addresses all of my (sequencer 
focused) comments on v1.

Best Wishes

Phillip

> Range diff (from v1, without my fixups) is below.
> 
>   -:  ---------- >  1:  86efec435d config: forbid newline as core.commentChar
>   1:  be18aa04e3 =  2:  7c016e5dc3 strbuf: simplify comment-handling in add_lines() helper
>   2:  0f8ea2a86d =  3:  2b4170b5f0 strbuf: avoid static variables in strbuf_add_commented_lines()
>   3:  9b56d9f4f0 =  4:  24ca214986 commit: refactor base-case of adjust_comment_line_char()
>   4:  0a191e5588 =  5:  9f6433dbe6 strbuf: avoid shadowing global comment_line_char name
>   5:  f41e196138 !  6:  d0f32f10f9 environment: store comment_line_char as a string
>      @@ builtin/commit.c: static void adjust_comment_line_char(const struct strbuf *sb)
>       
>        ## config.c ##
>       @@ config.c: static int git_default_core_config(const char *var, const char *value,
>      - 		else if (!strcasecmp(value, "auto"))
>      - 			auto_comment_line_char = 1;
>        		else if (value[0] && !value[1]) {
>      + 			if (value[0] == '\n')
>      + 				return error(_("core.commentChar cannot be newline"));
>       -			comment_line_char = value[0];
>       +			comment_line_str = xstrfmt("%c", value[0]);
>        			auto_comment_line_char = 0;
>   6:  84261af2ed !  7:  2c91628564 strbuf: accept a comment string for strbuf_stripspace()
>      @@ Commit message
>       
>           Signed-off-by: Jeff King <peff@peff.net>
>       
>      + ## builtin/am.c ##
>      +@@ builtin/am.c: static int parse_mail(struct am_state *state, const char *mail)
>      +
>      + 	strbuf_addstr(&msg, "\n\n");
>      + 	strbuf_addbuf(&msg, &mi.log_message);
>      +-	strbuf_stripspace(&msg, '\0');
>      ++	strbuf_stripspace(&msg, NULL);
>      +
>      + 	assert(!state->author_name);
>      + 	state->author_name = strbuf_detach(&author_name, NULL);
>      +
>        ## builtin/branch.c ##
>       @@ builtin/branch.c: static int edit_branch_description(const char *branch_name)
>        		strbuf_release(&buf);
>      @@ builtin/branch.c: static int edit_branch_description(const char *branch_name)
>        	strbuf_addf(&name, "branch.%s.description", branch_name);
>        	if (buf.len || exists)
>       
>      + ## builtin/commit.c ##
>      +@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
>      + 	s->hints = 0;
>      +
>      + 	if (clean_message_contents)
>      +-		strbuf_stripspace(&sb, '\0');
>      ++		strbuf_stripspace(&sb, NULL);
>      +
>      + 	if (signoff)
>      + 		append_signoff(&sb, ignored_log_message_bytes(sb.buf, sb.len), 0);
>      +
>        ## builtin/notes.c ##
>       @@ builtin/notes.c: static void prepare_note_data(const struct object_id *object, struct note_data *
>        			die(_("please supply the note contents using either -m or -F option"));
>      @@ builtin/notes.c: static void prepare_note_data(const struct object_id *object, s
>        	}
>        }
>        
>      +@@ builtin/notes.c: static void concat_messages(struct note_data *d)
>      + 		if ((d->stripspace == UNSPECIFIED &&
>      + 		     d->messages[i]->stripspace == STRIPSPACE) ||
>      + 		    d->stripspace == STRIPSPACE)
>      +-			strbuf_stripspace(&d->buf, 0);
>      ++			strbuf_stripspace(&d->buf, NULL);
>      + 		strbuf_reset(&msg);
>      + 	}
>      + 	strbuf_release(&msg);
>       
>        ## builtin/rebase.c ##
>       @@ builtin/rebase.c: static int edit_todo_file(unsigned flags)
>      @@ builtin/tag.c: static void create_tag(const struct object_id *object, const char
>        	if (!opt->message_given && !buf->len)
>        		die(_("no tag message?"));
>       
>      + ## builtin/worktree.c ##
>      +@@ builtin/worktree.c: static int can_use_local_refs(const struct add_opts *opts)
>      + 			strbuf_add_real_path(&path, get_worktree_git_dir(NULL));
>      + 			strbuf_addstr(&path, "/HEAD");
>      + 			strbuf_read_file(&contents, path.buf, 64);
>      +-			strbuf_stripspace(&contents, 0);
>      ++			strbuf_stripspace(&contents, NULL);
>      + 			strbuf_strip_suffix(&contents, "\n");
>      +
>      + 			warning(_("HEAD points to an invalid (or orphaned) reference.\n"
>      +
>      + ## gpg-interface.c ##
>      +@@ gpg-interface.c: static int verify_ssh_signed_buffer(struct signature_check *sigc,
>      + 		}
>      + 	}
>      +
>      +-	strbuf_stripspace(&ssh_keygen_out, '\0');
>      +-	strbuf_stripspace(&ssh_keygen_err, '\0');
>      ++	strbuf_stripspace(&ssh_keygen_out, NULL);
>      ++	strbuf_stripspace(&ssh_keygen_err, NULL);
>      + 	/* Add stderr outputs to show the user actual ssh-keygen errors */
>      + 	strbuf_add(&ssh_keygen_out, ssh_principals_err.buf, ssh_principals_err.len);
>      + 	strbuf_add(&ssh_keygen_out, ssh_keygen_err.buf, ssh_keygen_err.len);
>      +
>        ## rebase-interactive.c ##
>       @@ rebase-interactive.c: int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>        	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
>   7:  bb22f9c9c5 =  8:  a271207e48 strbuf: accept a comment string for strbuf_commented_addf()
>   8:  8d20688e87 =  9:  c1831453d8 strbuf: accept a comment string for strbuf_add_commented_lines()
>   9:  4b22efb941 = 10:  523eb9e534 prefer comment_line_str to comment_line_char for printing
> 10:  cd03310902 = 11:  85428eadaa find multi-byte comment chars in NUL-terminated strings
> 11:  13a346480e ! 12:  b9e2e2302d find multi-byte comment chars in unterminated buffers
>      @@ trailer.c: static size_t find_trailer_block_start(const char *buf, size_t len)
>        		ssize_t separator_pos;
>        
>       -		if (bol[0] == comment_line_char) {
>      -+		if (starts_with_mem(bol, buf + end_of_title - bol, comment_line_str)) {
>      ++		if (starts_with_mem(bol, buf + len - bol, comment_line_str)) {
>        			non_trailer_lines += possible_continuation_lines;
>        			possible_continuation_lines = 0;
>        			continue;
> 12:  fb3c6659fc ! 13:  7661ca6306 sequencer: handle multi-byte comment characters when writing todo list
>      @@ Commit message
>           We can't just return comment_line_char anymore, since it may require
>           multiple bytes. Instead, we'll return "0" for this case, which is the
>           same thing we'd return for a command which does not have a single-letter
>      -    abbreviation (e.g., "revert" or "noop"). In that case the caller then
>      -    falls back to outputting the full name via command_to_string(). So we
>      -    can handle TODO_COMMENT there, returning the full string.
>      +    abbreviation (e.g., "revert" or "noop"). There is only a single caller
>      +    of command_to_char(), and upon seeing "0" it falls back to outputting
>      +    the full name via command_to_string(). So we can handle TODO_COMMENT
>      +    there, returning the full string.
>       
>           Note that there are many other callers of command_to_string(), which
>           will now behave differently if they pass TODO_COMMENT. But we would not
> 13:  94524b8817 = 14:  8ddab67432 wt-status: drop custom comment-char stringification
> 14:  d754e86f7b = 15:  16d65f9179 environment: drop comment_line_char compatibility macro
> 15:  a6ffe08469 ! 16:  461cc720a0 config: allow multi-byte core.commentChar
>      @@ Commit message
>           how each site behaves. In the interim let's forbid it and we can loosen
>           things later.
>       
>      +    Likewise, the "commentChar cannot be a newline" rule is now extended to
>      +    "it cannot contain a newline" (for the same reason: it can confuse our
>      +    parsing loops).
>      +
>           Since comment_line_str is used in many parts of the code, it's hard to
>           cover all possibilities with tests. We can convert the existing
>           double-semicolon prefix test to show that "git status" works. And we'll
>      @@ config.c: static int git_default_core_config(const char *var, const char *value,
>        		else if (!strcasecmp(value, "auto"))
>        			auto_comment_line_char = 1;
>       -		else if (value[0] && !value[1]) {
>      +-			if (value[0] == '\n')
>      +-				return error(_("core.commentChar cannot be newline"));
>       -			comment_line_str = xstrfmt("%c", value[0]);
>       +		else if (value[0]) {
>      ++			if (strchr(value, '\n'))
>      ++				return error(_("core.commentChar cannot contain newline"));
>       +			comment_line_str = xstrdup(value);
>        			auto_comment_line_char = 0;
>        		} else
>      @@ config.c: static int git_default_core_config(const char *var, const char *value,
>       
>        ## t/t0030-stripspace.sh ##
>       @@ t/t0030-stripspace.sh: test_expect_success 'strip comments with changed comment char' '
>      - 	test -z "$(echo "; comment" | git -c core.commentchar=";" stripspace -s)"
>      - '
>        
>      + test_expect_success 'newline as commentchar is forbidden' '
>      + 	test_must_fail git -c core.commentChar="$LF" stripspace -s 2>err &&
>      +-	grep "core.commentChar cannot be newline" err
>      ++	grep "core.commentChar cannot contain newline" err
>      ++'
>      ++
>       +test_expect_success 'empty commentchar is forbidden' '
>       +	test_must_fail git -c core.commentchar= stripspace -s 2>err &&
>       +	grep "core.commentChar must have at least one character" err
>      -+'
>      -+
>      + '
>      +
>        test_expect_success '-c with single line' '
>      - 	printf "# foo\n" >expect &&
>      - 	printf "foo" | git stripspace -c >actual &&
>       
>        ## t/t7507-commit-verbose.sh ##
>       @@ t/t7507-commit-verbose.sh: test_expect_success 'verbose diff is stripped out with set core.commentChar' '
> 
>    [01/16]: config: forbid newline as core.commentChar
>    [02/16]: strbuf: simplify comment-handling in add_lines() helper
>    [03/16]: strbuf: avoid static variables in strbuf_add_commented_lines()
>    [04/16]: commit: refactor base-case of adjust_comment_line_char()
>    [05/16]: strbuf: avoid shadowing global comment_line_char name
>    [06/16]: environment: store comment_line_char as a string
>    [07/16]: strbuf: accept a comment string for strbuf_stripspace()
>    [08/16]: strbuf: accept a comment string for strbuf_commented_addf()
>    [09/16]: strbuf: accept a comment string for strbuf_add_commented_lines()
>    [10/16]: prefer comment_line_str to comment_line_char for printing
>    [11/16]: find multi-byte comment chars in NUL-terminated strings
>    [12/16]: find multi-byte comment chars in unterminated buffers
>    [13/16]: sequencer: handle multi-byte comment characters when writing todo list
>    [14/16]: wt-status: drop custom comment-char stringification
>    [15/16]: environment: drop comment_line_char compatibility macro
>    [16/16]: config: allow multi-byte core.commentChar
> 
>   Documentation/config/core.txt |  4 ++-
>   add-patch.c                   | 14 +++++-----
>   builtin/am.c                  |  2 +-
>   builtin/branch.c              |  8 +++---
>   builtin/commit.c              | 21 +++++++--------
>   builtin/merge.c               | 12 ++++-----
>   builtin/notes.c               | 12 ++++-----
>   builtin/rebase.c              |  2 +-
>   builtin/stripspace.c          |  4 +--
>   builtin/tag.c                 | 14 +++++-----
>   builtin/worktree.c            |  2 +-
>   commit.c                      |  3 ++-
>   config.c                      |  8 +++---
>   environment.c                 |  2 +-
>   environment.h                 |  2 +-
>   fmt-merge-msg.c               |  8 +++---
>   gpg-interface.c               |  4 +--
>   rebase-interactive.c          | 10 ++++----
>   sequencer.c                   | 48 ++++++++++++++++++-----------------
>   strbuf.c                      | 47 ++++++++++++++++++----------------
>   strbuf.h                      |  9 ++++---
>   t/t0030-stripspace.sh         | 10 ++++++++
>   t/t7507-commit-verbose.sh     | 10 ++++++++
>   t/t7508-status.sh             |  4 ++-
>   trailer.c                     |  6 ++---
>   wt-status.c                   | 31 +++++++++-------------
>   26 files changed, 162 insertions(+), 135 deletions(-)
> 
> -Peff
