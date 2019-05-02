Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787FE1F453
	for <e@80x24.org>; Thu,  2 May 2019 17:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfEBRQU (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 13:16:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36167 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfEBRQU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 13:16:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id w20so1331233plq.3
        for <git@vger.kernel.org>; Thu, 02 May 2019 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Dz5jmdKOpitjO+iKLv4Pb404xhUa3gD5rILOT+/938=;
        b=Mt9GDO7U2vSlRZy35ITZvnrkqZLbB+BiiEkwRLdlilaFQoBg+hD2B6d6pzP1Pkxstp
         atZ9aF1HVjF234RLJcRlUrwNvPDTgwOwdlF35WpK+71KBC9B7237RBc4zNYo9tubMYqa
         YesXgU5c+dzODUPfy0/SE1w6r8LlDQeBEnSrJ/fnjxEkJSpDjmrSrOekfv1lHWot+kTL
         A74tvkYeE59oXRf1HH3mTfC5WpB6AzjNHpscZVvOGpWsTXV2U76ycOgtqiiqgddccK7N
         AbAIqcseBseNFx/fsGyXy+5uUqVMhQAycfMMI9jGnmdl7ml/SF+frtNwLTH4uSBBxtqb
         UGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Dz5jmdKOpitjO+iKLv4Pb404xhUa3gD5rILOT+/938=;
        b=k3OyHYnU3kGJ0to0+NnNiKiEPHwXHAHx4plGu6avsX3AD2TzjgB0/qhfu1OGH/gcWL
         4z+K2+mJBTc3e+t3ZzctZHJAFoOm6OdBBB/yNfmISjrjII3vQVKBscmMtfJA+RxLuyL9
         zA2M9zt1OCbzq2utyGCFI1ztTTxe3UGzKTulStlYjC9HETGIqGxso6Bd2OOkHqz/1b9m
         P47iKOoUMEMitXw36KZITTt0Gu4arS+DB6MeqdblH0qJUNqo955PbEYU69U7SbQAfkDR
         O1lBXRjjZAprB8hFT/NJpi48S2miQs7w/AnkCmjv2Zifwy18y1KhuqmV6s8lr8J3+vqw
         lJog==
X-Gm-Message-State: APjAAAWGFct1dR+wIwdNVo2i2Q7cPzqv0WDeqPbLgCrCjlOIz3BXlX+4
        x8tintDPB4MdZ+jp+w1fiLk=
X-Google-Smtp-Source: APXvYqzO0YDFmhB3IJr/0JRLoh+3AhfmFuLL7huNhb1nw7W1F6uGfnHs2J/Nx8mKvgewGkUj6cBpPg==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr4911122ply.33.1556817378939;
        Thu, 02 May 2019 10:16:18 -0700 (PDT)
Received: from ash ([171.226.41.84])
        by smtp.gmail.com with ESMTPSA id m2sm27081735pfi.24.2019.05.02.10.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 10:16:18 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 03 May 2019 00:16:13 +0700
Date:   Fri, 3 May 2019 00:16:13 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     frank kulow <kulow.f@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: "git branch -f" corrupt other worktree
Message-ID: <20190502171612.GA13673@ash>
References: <CAA2qrhBmbSe5R0xQPBZiRcz0MGG=JcF4BjxHqmyeTFNR19FKbg@mail.gmail.com>
 <CACsJy8CJ_PB+QKp-T-yTHNPYgjEEVN39QbnAu4kKzGGcEQ0ezA@mail.gmail.com>
 <87d0l1qat5.fsf@evledraar.gmail.com>
 <CACsJy8A67x5wtbTe9Zk6URLZOqMNUFaLuNyZSVdYkZ1Z3y=6+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8A67x5wtbTe9Zk6URLZOqMNUFaLuNyZSVdYkZ1Z3y=6+A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 02, 2019 at 08:05:57PM +0700, Duy Nguyen wrote:
> The difficulty will be coming up with some sane UI that can
> handle that and not leave too many traps behind. I can't see that UI.

Well, I'm still thinking about it. And perhaps a good UI is not that
far away. The following hacky patch does three things:

1. it resolves "foo" to "refs/worktree/foo" if neither refs/heads/foo
   or refs/tags/foo exists.

2. it pretty prints refs/worktree/foo as worktree/foo

3. "git branch" has a new option --per-worktree that creates
   refs/worktree/foo instead of refs/heads/foo.

The idea here is we manage/decide per-worktree or shared refs at
branch/tag creation time. After that we use it like a normal
branch/tag. Point #1 helps the "normal" part.

Point #2 could even pretty print it to "foo" to make it even more
normal, but I feel that the distinction between per-worktree and
shared should still be more visible, hence "worktree/foo".

--per-worktree is pretty much a placeholder name. If we could find a
good name (and --worktre is already taken), then it could be added in
more places where a branch may be created.

It's far from complete. For example, refs/worktree/foo is not
considered a branch by any command, Only those inside refs/heads are
at the moment.

When I added refs/worktree/ namespace I didn't think that far ahead,
what kind of refs should be in there. But maybe we can still have
branches in refs/worktree/heads/ and tags in refs/worktree/tags/. Or
perhaps all refs/worktree/ should only contain branches, tags are
always shared (it's shared with remotes now even, at least in common
case)...

With more details worked out, perhaps we can make it work.

-- 8< --
diff --git a/branch.c b/branch.c
index 28b81a7e02..e5d738efa7 100644
--- a/branch.c
+++ b/branch.c
@@ -242,6 +242,8 @@ N_("\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push.");
 
+int create_branch_per_worktree;
+
 void create_branch(struct repository *r,
 		   const char *name, const char *start_name,
 		   int force, int clobber_head_ok, int reflog,
@@ -308,6 +310,9 @@ void create_branch(struct repository *r,
 	if (reflog)
 		log_all_ref_updates = LOG_REFS_NORMAL;
 
+	if (create_branch_per_worktree)
+		strbuf_splice(&ref, 0, 11, "refs/worktree/", 14);
+
 	if (!dont_change_ref) {
 		struct ref_transaction *transaction;
 		struct strbuf err = STRBUF_INIT;
diff --git a/builtin/branch.c b/builtin/branch.c
index d4359b33ac..8839c6f33f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -605,6 +605,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int icase = 0;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	struct ref_format format = REF_FORMAT_INIT;
+	int per_worktree = 0;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
@@ -613,6 +614,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("suppress informational messages")),
 		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
 			BRANCH_TRACK_EXPLICIT),
+		OPT_BOOL(0, "per-worktree",  &per_worktree, N_("create per-worktree branch")),
 		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
 			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
@@ -829,12 +831,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		git_config_set_multivar(buf.buf, NULL, NULL, 1);
 		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
+		extern int create_branch_per_worktree;
+
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
 
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
 
+		create_branch_per_worktree = per_worktree;
 		create_branch(the_repository,
 			      argv[0], (argc == 2) ? argv[1] : head,
 			      force, 0, reflog, quiet, track);
diff --git a/refs.c b/refs.c
index 142888a40a..8d01a80e07 100644
--- a/refs.c
+++ b/refs.c
@@ -479,7 +479,9 @@ const char *prettify_refname(const char *name)
 {
 	if (skip_prefix(name, "refs/heads/", &name) ||
 	    skip_prefix(name, "refs/tags/", &name) ||
-	    skip_prefix(name, "refs/remotes/", &name))
+	    skip_prefix(name, "refs/remotes/", &name) ||
+	    (starts_with(name, "refs/worktree/") &&
+	     skip_prefix(name, "refs/", &name)))
 		; /* nothing */
 	return name;
 }
@@ -491,6 +493,7 @@ static const char *ref_rev_parse_rules[] = {
 	"refs/heads/%.*s",
 	"refs/remotes/%.*s",
 	"refs/remotes/%.*s/HEAD",
+	"refs/worktree/%.*s",
 	NULL
 };
 
-- 8< --
