Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B951F424
	for <e@80x24.org>; Thu, 26 Apr 2018 18:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeDZSoS (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 14:44:18 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43049 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeDZSoR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 14:44:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id g12-v6so16142581lfb.10
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aTllOeJfhaVziGwBeX/Rc70U80t0u+0WEAydVV8p0e0=;
        b=VedKSAdtHVTXHI29+PvhWMsSN80h4O3CIK73jZFbiN9Kri1MZRDhbGLn0dfFJtLdAz
         1fuGqDjp15ETMkZ3ogHjNAZXv41Rx7VpD3yCDuMrruwTu/lBQ0qFSivxcVJXPe1wHqRy
         9eewlUfXatqCIk5NpZSUTC5YPo6j9rQR6sfQ8SIZMitVPt4WSzRyMR92EhncXOnLeGsu
         D/PkvImazzc6uO5+relI4HDAYjlewtd5WgMolix1efkyR2tbdfWJFd2waptViBc3AnEk
         cbvEyYSmP6cJ/W+nz7m2S4BaSpxxtrCgOR/p2EoX63rXljWjByw23LR4QZ6xUMSF7CjQ
         Vabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aTllOeJfhaVziGwBeX/Rc70U80t0u+0WEAydVV8p0e0=;
        b=nd9Jguss/q1qUS1VFybqtDOw59RseFtqS8sjB+nX3IumiU7uWoPVAFsLOfHlcpw36Z
         T29SD6J/FolsY4r1wcZqaO9jup0fMjw6LSdnvA9eNNyfdFacvyb87SlWQNuNk6XerTOI
         vySP69U8B367RAh1rV0Br48NAzAzy3eSg88TvjTwS47Vuyfc4K0nmVhnZf2sw10XzUaw
         ijA/0amNOBZ93lDO0QeHj02Pt5VqO60j6LR6f9Nwl23K1KXPotxX1jBKzXqxS4o7Jeh3
         cpfLXxw0+MIeadkjYkT10wR29XtyjwbChpFQ0bvGaB2JUO89aBzyAK2IaT69lNupGGrt
         FTAg==
X-Gm-Message-State: ALQs6tBsqxXj8GL+ebQEquCXWV+CBRrQjqKKbunaEaDWAlE1eKwFCtBK
        wQ2tj1RirW9KuxjrHl0cEZU=
X-Google-Smtp-Source: AB8JxZqGiYWP0ZanoYoM98kT/u4DCR+KmviRYJTW8R4acDrOMFzEBpGKn9RNhysft3y1z8CvlGpCnw==
X-Received: by 10.46.16.130 with SMTP id 2mr6353279ljq.9.1524768255733;
        Thu, 26 Apr 2018 11:44:15 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w64-v6sm3284516lff.13.2018.04.26.11.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 11:44:14 -0700 (PDT)
Date:   Thu, 26 Apr 2018 20:44:11 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Marc Branchaud <marcnarc@xiplink.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
Message-ID: <20180426184411.GA6844@duynguyen.home>
References: <20180413170129.15310-1-mgorny@gentoo.org>
 <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
 <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
 <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
 <CACsJy8ATwEPiCDpOr7e=wJxhZAr1R4OpSdOvb6EgpnyYonQYWg@mail.gmail.com>
 <robbat2-20180426T165501-471483273Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <robbat2-20180426T165501-471483273Z@orbis-terrarum.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 05:48:35PM +0000, Robin H. Johnson wrote:
> On Thu, Apr 26, 2018 at 06:43:56PM +0200, Duy Nguyen wrote:
> > On Wed, Apr 25, 2018 at 5:18 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> > > Are we all that sure that the performance hit is that drastic?  After all,
> > > we've just done write_entry().  Calling utime() at that point should just
> > > hit the filesystem cache.
> > I have a feeling this has "this is linux" assumption. Anybody knows
> > how freebsd, mac os x and windows behave?
> I don't know sorry. futimens might be better here if it can be used
> before the fd is closed.
> 
> > > * In a "file checkout" ("git checkout -- path/to/file"), $1 and $2 are
> > > identical so the above loop does nothing.  Offhand I'm not even sure how a
> > > hook might get the right files in this case.
> > Would a hook that gives you the list of updated files (in the exact
> > same order that git updates) help?
> Yes, that, along with the target revision I think would allow most or
> all of the desired behaviors mentioned in this thread *.

Target revision should be available in the index. But this gives me an
idea to another thing that bugs me: sending the list to the hook means
I have to deal with separator (\n or NUL?) or escaping. This mentions
of index makes me take a different direction. I could produce a small
index that contains just what is modified, then you can retrieve
whatever info you want with `git ls-files` or even `git show` after
pointing $GIT_INDEX_FILE to it.

So it's basically what the following (hacky) patch does. It adds
support for a new hook named post-checkout-modified. This hook will
prepares $GIT_DIR/index.modified which contains just the files
git-checkout has touched and deletes it after the hook finishes.

My test hook is pretty simple just to dump out what in there

    #!/bin/sh
    GIT_INDEX_FILE=`git rev-parse --git-path index.modified` git ls-files --stage

and it seems to work.

Of course, this does not give you the checkout order. But checkout
order has always been sorted order by path if I remember correctly and
it's unlikely to change (and I don't think you really need that exact
order anyway)

-- 8< --
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b49b582071..92b30cd05f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -52,6 +52,8 @@ struct checkout_opts {
 	const char *prefix;
 	struct pathspec pathspec;
 	struct tree *source_tree;
+
+	struct index_state istate_modified;
 };
 
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
@@ -470,7 +472,7 @@ static void setup_branch_path(struct branch_info *branch)
 	branch->path = strbuf_detach(&buf, NULL);
 }
 
-static int merge_working_tree(const struct checkout_opts *opts,
+static int merge_working_tree(struct checkout_opts *opts,
 			      struct branch_info *old_branch_info,
 			      struct branch_info *new_branch_info,
 			      int *writeout_error)
@@ -595,6 +597,27 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	if (!cache_tree_fully_valid(active_cache_tree))
 		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
 
+	if (find_hook("post-checkout-modified")) {
+		int i;
+
+		for (i = 0; i < the_index.cache_nr; i++) {
+			struct cache_entry *ce = the_index.cache[i];
+			struct cache_entry *new_ce;
+
+			/*
+			 * Hack: this is an abuse of this flag, hidden
+			 * dependency with write_locked_index()
+			 */
+			if (!(ce->ce_flags & CE_UPDATE_IN_BASE))
+				continue;
+
+			new_ce = xcalloc(1, cache_entry_size(ce_namelen(ce)));
+			memcpy(new_ce, ce, cache_entry_size(ce_namelen(ce)));
+			add_index_entry(&opts->istate_modified, new_ce,
+					ADD_CACHE_JUST_APPEND);
+		}
+	}
+
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
@@ -811,7 +834,7 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	clear_commit_marks_all(ALL_REV_FLAGS);
 }
 
-static int switch_branches(const struct checkout_opts *opts,
+static int switch_branches(struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
 	int ret = 0;
@@ -848,6 +871,16 @@ static int switch_branches(const struct checkout_opts *opts,
 
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
+	if (find_hook("post-checkout-modified")) {
+		struct lock_file lock_file = LOCK_INIT;
+
+		hold_lock_file_for_update(&lock_file, git_path("index.modified"),
+					  LOCK_DIE_ON_ERROR);
+		write_locked_index(&opts->istate_modified, &lock_file, COMMIT_LOCK);
+		run_hook_le(NULL, "post-checkout-modified", NULL);
+		discard_index(&opts->istate_modified);
+		unlink(git_path("index.modified"));
+	}
 	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
 	free(path_to_free);
 	return ret || writeout_error;
-- 8< --


> It also needs to fire in cases like 'git reset --hard $REV'.
> 
> * For this case, I just need the mtimes to be consistent within a single
>   checkout, I don't need them to have specific values.

hmm.. I didn't realize that this command is also affected by mgorny's
patch and a bunch others that use unpack_trees() (git-merge comes to
mind), which may be questionable.

A "post-checkout" hook does not sound right to fire in this case. I
think you can just go with "git checkout -f $REV" and achieve the same
thing.
--
Duy
