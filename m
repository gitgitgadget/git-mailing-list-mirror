Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F881F404
	for <e@80x24.org>; Thu, 30 Aug 2018 22:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeHaCYP (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 22:24:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42099 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeHaCYP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 22:24:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id l5so5022226edw.9
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Ak23HfWlB8RcIiXU7qWpOaxn7iZx3Sh10B4D/+ueLgo=;
        b=LuMVDWN73ZnSiX10l5wedR3s2+Fqj1CHqsX2niUM2mdXhd2rMY4EnVBk9N+RuuW/tt
         Z7P9d/EqGV7lRkV8rW6GJRLH7KrMpDB+zAMOE8galkL5U6Acnr3jyxGTNSIdNPha3exE
         sLosh3ZSaXYDL+d8XsWErbKJIeWi2+DY2g6q1EOsrvGggjGo1l+cwMRGbiUW6qq2E5ub
         rIz0wSq31GqohaCdCyABfT365zPUkUCKqBNmV3ohWpvFEi0LRaIIHynlZuDvjn3i4URi
         XMH+bDfJsvGssIEDXKtPGwpCe+GER29Qx+eZVDCZkTY6jZ0Oq2d22ATtHlE86/6/lcLe
         W7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Ak23HfWlB8RcIiXU7qWpOaxn7iZx3Sh10B4D/+ueLgo=;
        b=SrviXwoUnWMO+XcwE/DvUKgMiFwFpAWUuJo3vrFsYx4Aj/DZ97CqD0vhtQ/jLVNOba
         WlhRukN1OlYAuWvtChdihQZW8xUByb4S4srxrQpz3JtYex9xrn/aEjsYIQKdl8MuSqF1
         5R6Hh9OtCfxsske61i4l5etOTc2XkLeY4BA+xdW4lUUnAner1ZE0i9mXJyDW12tULUBv
         7OVVzr0nl5s5A8npeRQCoeAf7Ab74Y10IybwwpCT4PDo5a9O8yHYJSbzJXxDl6qlrXwd
         muC3HHOmJC7+HoCthH2adbjBTa6KXgwROVxUKWjD8W/dM68k/a+Ff6ko5RUUPVAFFBdc
         T1lA==
X-Gm-Message-State: APzg51BTeEyCkEXidxNewvaoqRwcuVAzSXdkC4jRr+RbfWvB+p3dsxtC
        HVRM+ksuCCSQzULqLuxfejM=
X-Google-Smtp-Source: ANB0VdZ2DMerLPDs9KrRKGR04auG/2RgnV0OqGqHEMstZJONAjJelrXUqXYApcX+zJa65ynGHdx+fw==
X-Received: by 2002:a50:b8a6:: with SMTP id l35-v6mr15148659ede.273.1535667591885;
        Thu, 30 Aug 2018 15:19:51 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id x44-v6sm3306969edd.1.2018.08.30.15.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 15:19:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 00/20] Convert "git stash" to C builtin
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com> <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
Date:   Fri, 31 Aug 2018 00:19:50 +0200
Message-ID: <87ftyvcxa1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 30 2018, Paul-Sebastian Ungureanu wrote:

> Hello,
>
> This a new iteration of `stash.c`. What is new?
>
>  * Some commits got squashed. The commit related to replacing
>  `git apply` child process was dropped since it wasn't the best
>  idea.
>
>  * In v7, there was a bug [1] related to config `git stash show`
>  The bug was fixed and a test file was added for this.
>
>  * Fixed `git stash [push]` [2]. In v7, `git stash -q drop` would
>  act like `git stash push -q drop`.
>
>  * Fixed coding-style nits. Verified that messages are marked
>  for translation and are going to the correct output stream.
>
>  * Fixed one memory leak (related to `strbuf_detach`).
>
>  * Simplified the code a little bit.

This looks good, I read this and a previous version. I'e tested this on
Linux, FreeBSD & AIX. All tests pass on all of them.

One style nit: These patches consistently indent wrapped lines not to
align with the opening "(" (as is our usual style), but just with
"\n\t". I.e. this patch on top would make it like what we usually do
(but should be squashed as appropriate):

    diff --git a/builtin/stash.c b/builtin/stash.c
    index dd1084afd4..6d849ed811 100644
    --- a/builtin/stash.c
    +++ b/builtin/stash.c
    @@ -389,3 +389,3 @@ static int restore_untracked(struct object_id *u_tree)
     static int do_apply_stash(const char *prefix, struct stash_info *info,
    -	int index)
    +			  int index)
     {
    @@ -408,3 +408,3 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
     		if (!oidcmp(&info->b_tree, &info->i_tree) || !oidcmp(&c_tree,
    -			&info->i_tree)) {
    +								     &info->i_tree)) {
     			has_index = 0;
    @@ -514,3 +514,3 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
     		OPT_BOOL(0, "index", &index,
    -			N_("attempt to recreate the index")),
    +			 N_("attempt to recreate the index")),
     		OPT_END()
    @@ -610,3 +610,3 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
     		OPT_BOOL(0, "index", &index,
    -			N_("attempt to recreate the index")),
    +			 N_("attempt to recreate the index")),
     		OPT_END()
    @@ -971,3 +971,3 @@ static int stash_patch(struct stash_info *info, struct pathspec ps, int quiet)
     	argv_array_pushl(&cp_add_i.args, "add--interactive", "--patch=stash",
    -			"--", NULL);
    +			 "--", NULL);
     	for (i = 0; i < ps.nr; ++i)
    @@ -1279,3 +1279,3 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
     		printf_ln(_("Saved working directory and index state %s"),
    -			stash_msg);
    +			  stash_msg);

    @@ -1413,5 +1413,5 @@ static int push_stash(int argc, const char **argv, const char *prefix)
     		OPT_SET_INT('k', "keep-index", &keep_index,
    -			N_("keep index"), 1),
    +			    N_("keep index"), 1),
     		OPT_BOOL('p', "patch", &patch_mode,
    -			N_("stash in patch mode")),
    +			 N_("stash in patch mode")),
     		OPT__QUIET(&quiet, N_("quiet mode")),
    @@ -1422,3 +1422,3 @@ static int push_stash(int argc, const char **argv, const char *prefix)
     		OPT_STRING('m', "message", &stash_msg, N_("message"),
    -			 N_("stash message")),
    +			   N_("stash message")),
     		OPT_END()
    @@ -1450,5 +1450,5 @@ static int save_stash(int argc, const char **argv, const char *prefix)
     		OPT_SET_INT('k', "keep-index", &keep_index,
    -			N_("keep index"), 1),
    +			    N_("keep index"), 1),
     		OPT_BOOL('p', "patch", &patch_mode,
    -			N_("stash in patch mode")),
    +			 N_("stash in patch mode")),
     		OPT__QUIET(&quiet, N_("quiet mode")),

Tip: It's also better to get feedback by CC-ing people who've had
feedback on previous versions.
