Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930017C226
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471310; cv=none; b=j/kiQMpV75q3TJlOty5R5aWqRTh9HBI/yLXZs1aJg/gRy2YdeD3XgyBPFe1MscB/37y6V73A5ZVnPhNlBGb0pvLM1Hi4AUY0gPcY333lDdLioWZt+vD+pjTRWFJfrGgY8nOJT8TOyqDdH+a3gM3/IEbtGYEocbc56GqBIUUyEO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471310; c=relaxed/simple;
	bh=DP1MndW0ziW5lCce8rboW0oDPJGV+AK5IJwjn4/yfQs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RJ2CbPhWIkqu89GsxOya2pqb6gPj/HZ6r9irjJ/FxwZCNBJh1l5SCEbO6DSkgW9KCQygHNb+8/IrXJs5Aa+aRL88urPqzpWW+/EYFCHkolDG2bL4ZncKktei80dSgRwbmeSsxbCIMjez8cV3jbQ8BbdwiEh17r0ck9VurHrdl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWijnlBO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWijnlBO"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428e3129851so32478935e9.3
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723471306; x=1724076106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UGcazRML8wY7a/dUYW7if6mi0VjmVh7FZv3lC6kQCC0=;
        b=nWijnlBO39GVk7oHYpLp85seufQ70l8DPcR4uefFdywmegzAGc3svkIqFMnuhgGpUB
         GuaUS3Yz8VdZ2jEMx2Lvhj2k1XivfnyI448rbiironxLoLVcw+vSoB3VmvzvbGdmSZPq
         bMZ8xzSiCbQoxtT2fQBPGN9DvuycWk3j+CxOZZzRInYZ4GwbyFN3/ovhHDvqAUplEb8a
         mh9mUAP8noj+MYqBe1zwcEdTqtPh3lJ0qufN1o75r8OXOaMeD2wydM+ksInxR4KK1u9g
         lWndvLtTt5HaXYqMquuIbko7Z1IHq7IXXh5OiwmZBcZ6TTJxFEJp0KK/auTkZINbtUYK
         I9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723471306; x=1724076106;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGcazRML8wY7a/dUYW7if6mi0VjmVh7FZv3lC6kQCC0=;
        b=B92kv00gZxjjH9kVsP9uCO7+zr/XmOtsJ119r/fqKQ2HBK/CGY/DZUiOEUB37iVgcB
         00aG1WYeGJETHwt8Ivhhy5kBL9R8zEei3N3kg8D5G0FHgpxa/egpAKLqOHbzjGDk4xmc
         w7yAr76TC97itwIVZSKa1EN8zaHNU6SN6XaNKhwicBwbyklxH1GtYih1u7rNbQkaNwCK
         eB0FI98eAluzpBGj7genFGzJe4HVmAk5SZo4MOMfw0OD+c+EmJErsjldvmrw4eHag0ub
         Ck1nzTImOcSuSZWgCQqQNSEo8f77Eca22ucwUO0Ew4+7eLe/THKhCylGcMOkRnUmfFnx
         wKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH80uvX+xTz9kCnibroijJ6zgDVW64LHbnBsCtCW20Ygudz5kEWvDdTgubXkwzC3QyX7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tp4tWEO7ctbkoqlQLCRD57aYWCSqXq8Y3LzS+6Q27Gwqd27B
	F3FZh1JZ9q+HG0wvIL7rClnhJZbUgNn9tx9SnJZtLt8jKOM3MeU1
X-Google-Smtp-Source: AGHT+IGk5CsLdDUTKocgytAuto1XV13MCLh3sWyiaxTITgQ3PSoAJhJ36AFRpOqSHGR+N6X8gC/6sQ==
X-Received: by 2002:a05:600c:450d:b0:428:640:c1b1 with SMTP id 5b1f17b1804b1-429d481a198mr4073155e9.17.1723471305798;
        Mon, 12 Aug 2024 07:01:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c77372b9sm103589885e9.35.2024.08.12.07.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 07:01:45 -0700 (PDT)
Message-ID: <4dbf731a-873b-4cab-b8ff-745bfa059060@gmail.com>
Date: Mon, 12 Aug 2024 15:01:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 00/22] Memory leak fixes (pt.4)
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
References: <cover.1722933642.git.ps@pks.im> <cover.1723121979.git.ps@pks.im>
Content-Language: en-US
In-Reply-To: <cover.1723121979.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 08/08/2024 14:04, Patrick Steinhardt wrote:
> Hi,
> 
> this is the second version of my fourth batch of patches that fix
> various memory leaks.
> 
> Changes compared to v1:
> 
>    - Adapt the memory leak fix for command characters to instead use a
>      `comment_line_str_allocated` variable.
> 
>    - Clarify some commit messages.
> 
>    - Drop the TODO comment about `rebase.gpgsign`. Turns out that this is
>      working as intended, as explained by Phillip.

The changes to the rebase and sequencer patches look good to me

Thanks

Phillip

> Thanks!
> 
> Patrick
> 
> Patrick Steinhardt (22):
>    remote: plug memory leak when aliasing URLs
>    git: fix leaking system paths
>    object-file: fix memory leak when reading corrupted headers
>    object-name: fix leaking symlink paths in object context
>    bulk-checkin: fix leaking state TODO
>    read-cache: fix leaking hashfile when writing index fails
>    submodule-config: fix leaking name enrty when traversing submodules
>    config: fix leaking comment character config
>    builtin/rebase: fix leaking `commit.gpgsign` value
>    builtin/notes: fix leaking `struct notes_tree` when merging notes
>    builtin/fast-import: plug trivial memory leaks
>    builtin/fast-export: fix leaking diff options
>    builtin/fast-export: plug leaking tag names
>    merge-ort: unconditionally release attributes index
>    sequencer: release todo list on error paths
>    unpack-trees: clear index when not propagating it
>    diff: fix leak when parsing invalid ignore regex option
>    builtin/format-patch: fix various trivial memory leaks
>    userdiff: fix leaking memory for configured diff drivers
>    builtin/log: fix leak when showing converted blob contents
>    diff: free state populated via options
>    builtin/diff: free symmetric diff members
> 
>   builtin/commit.c                      |  7 +-
>   builtin/diff.c                        | 10 ++-
>   builtin/fast-export.c                 | 19 ++++--
>   builtin/fast-import.c                 |  8 ++-
>   builtin/log.c                         | 13 +++-
>   builtin/notes.c                       |  9 ++-
>   builtin/rebase.c                      |  1 +
>   bulk-checkin.c                        |  2 +
>   config.c                              |  4 +-
>   csum-file.c                           |  2 +-
>   csum-file.h                           | 10 +++
>   diff.c                                | 16 ++++-
>   environment.c                         |  1 +
>   environment.h                         |  1 +
>   git.c                                 | 12 +++-
>   merge-ort.c                           |  3 +-
>   object-file.c                         |  1 +
>   object-name.c                         |  1 +
>   range-diff.c                          |  6 +-
>   read-cache.c                          | 97 ++++++++++++++++-----------
>   remote.c                              |  2 +
>   sequencer.c                           | 67 ++++++++++++------
>   submodule-config.c                    | 18 +++--
>   t/t0210-trace2-normal.sh              |  2 +-
>   t/t1006-cat-file.sh                   |  1 +
>   t/t1050-large.sh                      |  1 +
>   t/t1450-fsck.sh                       |  1 +
>   t/t1601-index-bogus.sh                |  2 +
>   t/t2107-update-index-basic.sh         |  1 +
>   t/t3310-notes-merge-manual-resolve.sh |  1 +
>   t/t3311-notes-merge-fanout.sh         |  1 +
>   t/t3404-rebase-interactive.sh         |  1 +
>   t/t3435-rebase-gpg-sign.sh            |  1 +
>   t/t3507-cherry-pick-conflict.sh       |  1 +
>   t/t3510-cherry-pick-sequence.sh       |  1 +
>   t/t3705-add-sparse-checkout.sh        |  1 +
>   t/t4013-diff-various.sh               |  1 +
>   t/t4014-format-patch.sh               |  1 +
>   t/t4018-diff-funcname.sh              |  1 +
>   t/t4030-diff-textconv.sh              |  2 +
>   t/t4042-diff-textconv-caching.sh      |  2 +
>   t/t4048-diff-combined-binary.sh       |  1 +
>   t/t4064-diff-oidfind.sh               |  2 +
>   t/t4065-diff-anchored.sh              |  1 +
>   t/t4068-diff-symmetric-merge-base.sh  |  1 +
>   t/t4069-remerge-diff.sh               |  1 +
>   t/t4108-apply-threeway.sh             |  1 +
>   t/t4209-log-pickaxe.sh                |  2 +
>   t/t6421-merge-partial-clone.sh        |  1 +
>   t/t6428-merge-conflicts-sparse.sh     |  1 +
>   t/t7008-filter-branch-null-sha1.sh    |  1 +
>   t/t7030-verify-tag.sh                 |  1 +
>   t/t7817-grep-sparse-checkout.sh       |  1 +
>   t/t9300-fast-import.sh                |  1 +
>   t/t9304-fast-import-marks.sh          |  2 +
>   t/t9351-fast-export-anonymize.sh      |  1 +
>   unpack-trees.c                        |  2 +
>   userdiff.c                            | 38 ++++++++---
>   userdiff.h                            |  4 ++
>   59 files changed, 288 insertions(+), 106 deletions(-)
> 
> Range-diff against v1:
>   1:  6e2fcd85c7 =  1:  2afa51f9ff remote: plug memory leak when aliasing URLs
>   2:  9574995a24 =  2:  324140e4fd git: fix leaking system paths
>   3:  f7e67d02d2 =  3:  43a38a2281 object-file: fix memory leak when reading corrupted headers
>   4:  a9caaaed55 =  4:  9d3dc145e8 object-name: fix leaking symlink paths in object context
>   5:  794af66103 =  5:  454139e7a4 bulk-checkin: fix leaking state TODO
>   6:  2810cada0a =  6:  f8b7195796 read-cache: fix leaking hashfile when writing index fails
>   7:  03f699cf39 =  7:  762fb5aa73 submodule-config: fix leaking name enrty when traversing submodules
>   8:  a34c90a552 !  8:  8fbd72a100 config: fix leaking comment character config
>      @@ Commit message
>           without free'ing the previous value. In fact, it can't easily free the
>           value in the first place because it may contain a string constant.
>       
>      -    Refactor the code so that we initialize the value with another array.
>      -    This allows us to free the value in case the string is not pointing to
>      -    that constant array anymore.
>      +    Refactor the code such that we track allocated comment character strings
>      +    via a separate non-constant variable `comment_line_str_allocated`. Adapt
>      +    sites that set `comment_line_str` to set both and free the old value
>      +    that was stored in `comment_line_str_allocated`.
>       
>           This memory leak is being hit in t3404. As there are still other memory
>           leaks in that file we cannot yet mark it as passing with leak checking
>      @@ Commit message
>       
>           Signed-off-by: Patrick Steinhardt <ps@pks.im>
>       
>      + ## builtin/commit.c ##
>      +@@ builtin/commit.c: static void adjust_comment_line_char(const struct strbuf *sb)
>      + 	const char *p;
>      +
>      + 	if (!memchr(sb->buf, candidates[0], sb->len)) {
>      +-		comment_line_str = xstrfmt("%c", candidates[0]);
>      ++		free(comment_line_str_allocated);
>      ++		comment_line_str = comment_line_str_allocated =
>      ++			xstrfmt("%c", candidates[0]);
>      + 		return;
>      + 	}
>      +
>      +@@ builtin/commit.c: static void adjust_comment_line_char(const struct strbuf *sb)
>      + 	if (!*p)
>      + 		die(_("unable to select a comment character that is not used\n"
>      + 		      "in the current commit message"));
>      +-	comment_line_str = xstrfmt("%c", *p);
>      ++	free(comment_line_str_allocated);
>      ++	comment_line_str = comment_line_str_allocated = xstrfmt("%c", *p);
>      + }
>      +
>      + static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
>      +
>        ## config.c ##
>       @@ config.c: static int git_default_core_config(const char *var, const char *value,
>        		else if (value[0]) {
>        			if (strchr(value, '\n'))
>        				return error(_("%s cannot contain newline"), var);
>      -+			if (comment_line_str != comment_line_str_default)
>      -+				free((char *) comment_line_str);
>      - 			comment_line_str = xstrdup(value);
>      +-			comment_line_str = xstrdup(value);
>      ++			free(comment_line_str_allocated);
>      ++			comment_line_str = comment_line_str_allocated =
>      ++				xstrdup(value);
>        			auto_comment_line_char = 0;
>        		} else
>      + 			return error(_("%s must have at least one character"), var);
>       
>        ## environment.c ##
>       @@ environment.c: int protect_ntfs = PROTECT_NTFS_DEFAULT;
>      -  * The character that begins a commented line in user-editable file
>         * that is subject to stripspace.
>         */
>      --const char *comment_line_str = "#";
>      -+const char comment_line_str_default[] = "#";
>      -+const char *comment_line_str = comment_line_str_default;
>      + const char *comment_line_str = "#";
>      ++char *comment_line_str_allocated;
>        int auto_comment_line_char;
>        
>        /* Parallel index stat data preload? */
>       
>        ## environment.h ##
>       @@ environment.h: struct strvec;
>      -  * The character that begins a commented line in user-editable file
>         * that is subject to stripspace.
>         */
>      -+extern const char comment_line_str_default[];
>        extern const char *comment_line_str;
>      ++extern char *comment_line_str_allocated;
>        extern int auto_comment_line_char;
>        
>      + /*
>   9:  05290fc1f1 !  9:  e497b76e9c builtin/rebase: fix leaking `commit.gpgsign` value
>      @@ Metadata
>        ## Commit message ##
>           builtin/rebase: fix leaking `commit.gpgsign` value
>       
>      -    In `get_replay_opts()`, we unconditionally override the `gpg_sign` field
>      -    that already got populated by `sequencer_init_config()` in case the user
>      -    has "commit.gpgsign" set in their config. It is kind of dubious whether
>      -    this is the correct thing to do or a bug. What is clear though is that
>      -    this creates a memory leak.
>      +    In `get_replay_opts()`, we override the `gpg_sign` field that already
>      +    got populated by `sequencer_init_config()` in case the user has
>      +    "commit.gpgsign" set in their config. This creates a memory leak because
>      +    we overwrite the previously assigned value, which may have already
>      +    pointed to an allocated string.
>       
>      -    Let's mark this assignment with a TODO comment to figure out whether
>      -    this needs to be fixed or not. Meanwhile though, let's plug the memory
>      -    leak.
>      +    Let's plug the memory leak by freeing the value before we overwrite it.
>       
>           Signed-off-by: Patrick Steinhardt <ps@pks.im>
>       
>      @@ builtin/rebase.c: static struct replay_opts get_replay_opts(const struct rebase_
>        	replay.committer_date_is_author_date =
>        					opts->committer_date_is_author_date;
>        	replay.ignore_date = opts->ignore_date;
>      -+
>      -+	/*
>      -+	 * TODO: Is it really intentional that we unconditionally override
>      -+	 * `replay.gpg_sign` even if it has already been initialized via the
>      -+	 * configuration?
>      -+	 */
>       +	free(replay.gpg_sign);
>        	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>      -+
>        	replay.reflog_action = xstrdup(opts->reflog_action);
>        	if (opts->strategy)
>      - 		replay.strategy = xstrdup_or_null(opts->strategy);
>       
>        ## sequencer.c ##
>       @@ sequencer.c: static int git_sequencer_config(const char *k, const char *v,
> 10:  4f5d490074 = 10:  c886b666f7 builtin/notes: fix leaking `struct notes_tree` when merging notes
> 11:  798b911f77 = 11:  d1c757157b builtin/fast-import: plug trivial memory leaks
> 12:  660732d29d = 12:  fa2d5c5d6b builtin/fast-export: fix leaking diff options
> 13:  64366155de = 13:  d9dd860d2a builtin/fast-export: plug leaking tag names
> 14:  b12015b3c3 = 14:  8f6860485e merge-ort: unconditionally release attributes index
> 15:  df4c21b49f ! 15:  ea6a350f31 sequencer: release todo list on error paths
>      @@ sequencer.c: int sequencer_pick_revisions(struct repository *r,
>        									&oid,
>        									NULL);
>       -				return error(_("%s: can't cherry-pick a %s"),
>      +-					name, type_name(type));
>       +				res = error(_("%s: can't cherry-pick a %s"),
>      - 					name, type_name(type));
>      ++					    name, type_name(type));
>       +				goto out;
>        			}
>       -		} else
> 16:  1f8553fd43 = 16:  2755023742 unpack-trees: clear index when not propagating it
> 17:  c6db8df324 = 17:  edf6f148cd diff: fix leak when parsing invalid ignore regex option
> 18:  bf818a8a79 = 18:  343e3bd4df builtin/format-patch: fix various trivial memory leaks
> 19:  ef780aa360 = 19:  be2c5b0bca userdiff: fix leaking memory for configured diff drivers
> 20:  f3882986a3 = 20:  7888203833 builtin/log: fix leak when showing converted blob contents
> 21:  a49bb2e0cc = 21:  245fc30afb diff: free state populated via options
> 22:  fb52599404 = 22:  343ddcd17b builtin/diff: free symmetric diff members
