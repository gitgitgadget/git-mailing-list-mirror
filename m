Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E1F3126D6
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245851; cv=none; b=NXPEwOZnYFg8+RkKNWMnYPofq86Q/yaDSmVwWLvMHboS5QW1MHtQOwoIXSMytitGP1h9OcO5eIoE7l9wuIK2TC8/yoKknXGOKDcYPMTjuztPRDaoJq2niA0cAlwYt+xb00k7kkmSTvOFCjdbnkX5Ypr8D5xcUc1lMVOu0zbtgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245851; c=relaxed/simple;
	bh=hON18flbwanYA3nnwqo9s/BESkOwymUX7/VA1wWgdqo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=NbpSgobISsKS8ntXJCoOG3PQ7u3M80LCljUfyi/vZOaqPpxpHpPo9/CQHrFdnu3K7I0Mry0RTLtHkqfYQVHD8KGN4hmTBTaMa7vQgFRMryd/dsXPxw1WpA1O/jO8rl4sj9t6peQUMUbMsf3XWDy3Y9jFrJoVzfxRvWnXxByNng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu2e39Le; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu2e39Le"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47758595eecso1116145e9.0
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 00:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762245847; x=1762850647; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vIjns7o8rD60w0u6jwU4pN1/YPTv3+fZhUHrX08QIk=;
        b=Cu2e39LeRHU+oHuyOdfXxIWYefNSJxs6gt/ba06QwGNcj2YLD25s0s06t4R8iJrR57
         /tr7lcpyFnN4zN6rZPS2FDKvMUpRjesRsyellBt5uz2SUaa8BM5Zld/Cdabaw0idPs6A
         nL4yam03+edOufxvWS4WbxgODGiYtPnuhd3ewPM9hQ07GALXHMq+LIhVg5hLKttnfia2
         cZ0XNPdc8tn3rH/UjJnDf7MqVdk+Iuocl656glgF5JYZavDbPEBMElOzQyov9O1pJgKi
         lb+iVe/98Rfy1IiGvokUj2pXFt0tJGr4Wfa4S2siAKb15vvAw/htL2jjD+/woU4tr+Wi
         uTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245847; x=1762850647;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3vIjns7o8rD60w0u6jwU4pN1/YPTv3+fZhUHrX08QIk=;
        b=YmLv+eS5rxLpnt3p+H7FvRbSBbiOycmtQynsKOieZd22hoD28M0QZ6Eh8DutR32lM5
         GTWyIbEcWgXaOMIt42qCXDrD3t0dSDyKFuRJ5DRtqCy9cXflW9d5fBzf54ajcR4sXsgs
         +4/Ldwpe4vACaQyUEtp3S+GJ343Dcw3vRKzbDVF1eYVytMJU202G63WiMzCb+SDyHpXh
         LjEDg2vBTa/RXNAJWjSDleqrNVP3oTO3P1RyQIudYck5Y+GZquXwwuc2ISBfDIV29Ed2
         aKz1eAEk3ucUiEiPGZcgC9GRsRc6ActXMRr5Ucho1aef5fJvUcw0rtxB0Su4bcdcN6v5
         mLnw==
X-Gm-Message-State: AOJu0Yz3L6EREZz51Cy3Fxj69vcosg78NOBrg+DmYTU6AEWX5ax+bKnZ
	as2QJKITxJCcK16t8vMByAvQtXZAen3V+sHEDnkLX46md+V054Eid0LOWkUXcloY
X-Gm-Gg: ASbGncv1OpjAi7df+W1xcefzwYVsewZvhfVUMYlVqPA83XqdVNXSI+Fvx8M+Cq9mvNL
	7Vtb1Eb5LI/hxgGA2j2g0hfc2SI9GPvYgmaRb6spTegCOFUmoEd9nHkYLFWykUqx20NXvAIohbq
	3I9hMUPOghWtxbM0dUe6kGR9qW3uDM3b6sn/uyQU19rWPY+VI9qI+lFb3F4BAo6+3sdn+GLTcAZ
	fRBL7uFJQju31XofGoakb/9KevI9SHCbDellRKADc1aMkXkBuGJYsVcOAcoU417jN56SUmz69/v
	O6e6BrFYSg4WjT614XLpoOoX0bg3HoEb8Q6p37aWKRtggtXwy4Wie/w9qNms8wPlNFhPh+ONBn5
	lWn25mz1xcEBMQOvmSKjc8wOnnWv3o6UqXJwc0lZE1Y9Y97Y6MTEBQ0r80BIXPDl/YEiHCz2tMs
	WfjAin
X-Google-Smtp-Source: AGHT+IEdOPBUJO2uBOBEg/ueIt3K1TOzQOKw01LGU9JJ1bIfZMDpE0oZZ8jiJnkTsMtXblJ/aZ1qUQ==
X-Received: by 2002:a05:600c:4e05:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-477308a8f1amr164411385e9.34.1762245846221;
        Tue, 04 Nov 2025 00:44:06 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:b03:96aa:b9b4:f746:b8e9:7f4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773d81cb03sm193379035e9.13.2025.11.04.00.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:44:05 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/5] maintenance: add an 'is-needed' subcommand
Date: Tue, 04 Nov 2025 09:43:55 +0100
Message-Id: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMu8CWkC/52OQQ6CMBBFr0K6dsy0CDGuvIdhUToDTJSWtEg0h
 LtbiSdw+SZ//vurShyFk7oUq4q8SJLgM5hDodxgfc8glFkZNJVGo6GqDVgiSM8WXBhH6wnmAG5
 gdwfpYLTiZ/bWu/yawDMTE6B2llG3pxprlbunyJ28du+tyTxImkN87zMW/b3+jOW/xkUDgsWSq
 pLNmZCvfQ4+jrlBNdu2fQCZ6thB+gAAAA==
X-Change-ID: 20251021-562-add-sub-command-to-check-if-maintenance-is-needed-01cae01b4606
In-Reply-To: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8464; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=hON18flbwanYA3nnwqo9s/BESkOwymUX7/VA1wWgdqo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkJvNRboV2bKOHbRthZH6j1aD1idiJxvsOS6
 25YJYgB4bANiYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpCbzUAAoJED7VnySO
 Rox/h1gL/AnSwpR6eYaCCycEWLZC1dA4x2nbgFsswDJ8f68PfgtX26mDpaqlXdlnz+TmPJFpvit
 XChTwRx2prxU+oMzQjR46lFIUXcRqHI7zOoM8T+LvGR+3JhZ9DMVf8bG1fB9qkn6iWX8Uat0JL2
 1guzt/w9rxKFyJ96HcLizH+EGSIMjrYslOMING7g8W6dxkkkJ6/RJSkMkFqls4EgYwGy/jPbUqq
 sYji3or1xexl4DMsuitUpXLvsVA/7URoiMySeS87GMKF06nBBtCcJjXpqni2bjI96cMzf1SlVxM
 f8bf2vd7cME4S41YI3NGuRYtC9j1HtyhhFKePgbf7fQGZbihWJRWbppuHMyhN6VS+BLh+y3x7kQ
 OBlTFKkRZsXsfnqRIlII4MCtecPGyojyFQeCUuYfGtinj+u9kPsrbhzGeNUzmb+kijjY9Z18YWb
 t3HWWgIJ1+q/3VTQcKfBKWoI6e6aHzyY3h4sj5nxBndrzElKxMfX+lOjW0tOR29wImlkSvtTpJ6
 Ow=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Hello,

I recently raised a patch series [1] to add 'git refs optimize --required'
which checks if the reference backend can be optimized, without actually
performing the optimization.

Back then, we had decided [2] that it would be a better to broaden the
approach and add a 'is-needed' subcommand to 'git-maintenance(1)'. This
would allow users to check if maintenance was required for the
repository and users could also provide a task via the '--task' to check
if maintenance was needed for a particular task.

Ideally the subcommand will be used with the '--auto' flag which can
check the same heuristics as that used with 'git maintenance run
--auto'. Future patches can also add support for the '--schedule' flag
which can be used to check required schedule it met. However that flag
isn't added as part of this series.

This series implements that.

Commits 1-3 add the required functionality in the refs subsystem to
expose an 'optimize_required' field which can be used to check if
backends need to be optimized.
Commit 4 utilizes this within the 'git-maintenance(1)' code.
Commit 5 adds the 'is-needed' subcommand to 'git-maintenance(1)'.

This is based on top of master a99f379adf (The 27th batch, 2025-10-30)
and is dependent on the following series:

    - kn/refs-optim-cleanup
    - ps/ref-peeled-tags

Merges cleanly with `next`. I think those two topics are close to being
merged to `next` so hopefully this dependency tree doesn't get too
complicated. I'll rebase as needed to resolve conflicts.

[1]: https://lore.kernel.org/git/20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com/
[2]: https://lore.kernel.org/git/CAOLa=ZRdxm787nE4FSr2VUHDB+hW06Ggc6yUcKmeTKAb6B7YOA@mail.gmail.com/

---
Changes in v2:
- Added more documentation for `reftable_stack_compaction_required()`.
- Fixed some typos and grammar mistakes in commit messages.
- Clarify which tasks will be run when '--task' is not used.
- Move the call to 'usage_with_options()' to be with 'parse_options()'.
- Link to v1: https://patch.msgid.link/20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com

---
 Documentation/git-maintenance.adoc | 13 ++++++
 builtin/gc.c                       | 85 +++++++++++++++++++++++++++++++++-----
 object.h                           |  1 -
 refs.c                             |  7 ++++
 refs.h                             |  7 ++++
 refs/debug.c                       | 13 ++++++
 refs/files-backend.c               | 11 +++++
 refs/packed-backend.c              | 13 ++++++
 refs/refs-internal.h               |  6 +++
 refs/reftable-backend.c            | 25 +++++++++++
 reftable/reftable-stack.h          | 11 +++++
 reftable/stack.c                   | 48 ++++++++++++++++-----
 t/t7900-maintenance.sh             | 54 +++++++++++++++++-------
 t/unit-tests/u-reftable-stack.c    | 12 +++++-
 14 files changed, 266 insertions(+), 40 deletions(-)

Karthik Nayak (5):
      reftable/stack: return stack segments directly
      reftable/stack: add function to check if optimization is required
      refs: add a `optimize_required` field to `struct ref_storage_be`
      maintenance: add checking logic in `pack_refs_condition()`
      maintenance: add 'is-needed' subcommand

Range-diff versus v1:

1:  e5e6eedfbe = 1:  5431fe40ef reftable/stack: return stack segments directly
2:  6fac9e5eb5 ! 2:  248882aad6 reftable/stack: add function to check if optimization is required
    @@ Metadata
      ## Commit message ##
         reftable/stack: add function to check if optimization is required
     
    -    The reftable backend, performs auto-compaction as part of its regular
    +    The reftable backend performs auto-compaction as part of its regular
         flow, which is required to keep the number of tables part of a stack at
         bay. This allows it to stay optimized.
     
    @@ reftable/reftable-stack.h: struct reftable_log_expiry_config {
      int reftable_stack_compact_all(struct reftable_stack *st,
      			       struct reftable_log_expiry_config *config);
      
    -+/* Check if compaction is required. */
    ++/*
    ++ * Check if compaction is required.
    ++ *
    ++ * When `use_heuristics` is false, check if all tables can be compacted to a
    ++ * single table. If true, use heuristics to determine if the tables need to be
    ++ * compacted to maintain geometric progression.
    ++ */
     +int reftable_stack_compaction_required(struct reftable_stack *st,
     +				       bool use_heuristics,
     +				       bool *required);
3:  2ec39102a5 = 3:  e98c2c2e3e refs: add a `optimize_required` field to `struct ref_storage_be`
4:  c246efdc4a ! 4:  9b7fa79c8c maintenance: add checking logic in `pack_refs_condition()`
    @@ Metadata
      ## Commit message ##
         maintenance: add checking logic in `pack_refs_condition()`
     
    -    The 'git-maintenance(1)' command support an '--auto' flag. Usage of the
    +    The 'git-maintenance(1)' command supports an '--auto' flag. Usage of the
         flag ensures to run maintenance tasks only if certain thresholds are
         met. The heuristic is defined on a task level, wherein each task defines
    -    a 'auto_condition', which states if the task should be run.
    +    an 'auto_condition', which states if the task should be run.
     
         The 'pack-refs' task is hard-coded to return 1 as:
         1. There was never a way to check if the reference backend needs to be
    @@ Commit message
     
         This allows us to add a 'git maintenance is-needed' subcommand which can
         notify the user if maintenance is needed without actually performing the
    -    optimization, without this change, the reference backend would always
    +    optimization. Without this change, the reference backend would always
         state that optimization is needed.
     
         Since we import 'revision.h', we need to remove the definition for
    @@ builtin/gc.c: static void maintenance_run_opts_release(struct maintenance_run_op
     +	};
     +	bool required;
     +
    -+	// Check for all refs, similar to 'git refs optimize --all'.
    ++	/* Check for all refs, similar to 'git refs optimize --all'. */
     +	string_list_append(optimize_opts.includes, "*");
     +
     +	if (refs_optimize_required(get_main_ref_store(the_repository),
    @@ builtin/gc.c: static void maintenance_run_opts_release(struct maintenance_run_op
     +	clear_ref_exclusions(&excludes);
     +	string_list_clear(&included_refs, 0);
     +
    -+	return required;
    ++	return required == true;
      }
      
      static int maintenance_task_pack_refs(struct maintenance_run_opts *opts,
5:  64c15c1319 ! 5:  ed3658528b maintenance: add 'is-needed' subcommand
    @@ Documentation/git-maintenance.adoc: The `unregister` subcommand will report an e
     +is-needed::
     +    Check whether maintenance needs to be run without actually running it.
     +    Exits with a 0 status code if maintenance needs to be run, 1 otherwise.
    -+    Can be used along with `--task`. Ideally should be used with '--auto'.
    ++    Ideally used with the '--auto' flag.
    +++
    ++If one or more `--task` options	are specified, then those tasks are checked
    ++in that order. Otherwise, the tasks are determined by which
    ++`maintenance.<task>.enabled` config options are true. By default, only
    ++`maintenance.gc.enabled` is true.
     +
      TASKS
      -----
    @@ builtin/gc.c: static int maintenance_stop(int argc, const char **argv, const cha
     +	argc = parse_options(argc, argv, prefix, options,
     +			     builtin_maintenance_is_needed_usage,
     +			     PARSE_OPT_STOP_AT_NON_OPTION);
    ++	if (argc)
    ++		usage_with_options(builtin_maintenance_is_needed_usage, options);
     +
     +	gc_config(&cfg);
     +	initialize_task_config(&opts, &selected_tasks);
     +
    -+	if (argc)
    -+		usage_with_options(builtin_maintenance_is_needed_usage, options);
    -+
     +	if (opts.auto_flag) {
     +		for (size_t i = 0; i < opts.tasks_nr; i++) {
     +			if (tasks[opts.tasks[i]].auto_condition &&


base-commit: edd2018f5db39d68d55a7a4af42375b1a06b9406
change-id: 20251021-562-add-sub-command-to-check-if-maintenance-is-needed-01cae01b4606

Thanks
- Karthik

