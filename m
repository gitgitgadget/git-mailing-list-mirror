Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF7B1F406
	for <e@80x24.org>; Wed, 27 Dec 2017 10:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdL0K0A (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 05:26:00 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:39181 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdL0KZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 05:25:58 -0500
Received: by mail-pf0-f178.google.com with SMTP id l24so19646339pfj.6
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 02:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3xQDxfHpthOLShR2cAbIvbM1vmxblJIq09bpy0eiiJM=;
        b=ElBRKoEYyTCWpB9rOcHU5p0MClMI6CJcgz72sBn7PnOaP46nfxzri122WeWBCtF50g
         saR3HCbN40PVv3DFWHDQGYR8AWn58Q8E3TVlYQ723s4pR1DT+qloyuifd0o+GhF5r4xc
         r5IeYvNSVSCFX/QnHve7RPr31ujiNEZlJF/gkUet+8R5YXt08ft+bRL0jA16a29Ydpls
         g0KGzv5Y1vudQtgJmgDW0qw+RMwRVejM0iPp1eqM92dVlFeHNR4w3qmFPMf3zI9eCybC
         1kz9vxOe5j+M405LwcrLpPYu9qCOXSaukW8tAeTxCmzeZfZ8ujAjnOIiJnF9UmWE3DPS
         r7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3xQDxfHpthOLShR2cAbIvbM1vmxblJIq09bpy0eiiJM=;
        b=JynOfpOtvF7NXRyekjzsmunfej5boS/vPz1wQKg1H1VV4F/VpE5K+tPmJRgB8ERwEl
         pPDztHBMZiIYPyQ5u2cnN602SLWOOhuon6WHDv7vPO5l+/Iw+ymyE6HHuzaFX8bNTyDf
         BRtCIBZ/ugq6blm47IIiiDvCPGVyMhSVu5V48EjRTMrsvy0tH4uN0MWHHMrxPNuYOvjN
         YHKfipBbNOBV4xgn1QgyP05NtzyfRqG8BWH/mLjwd8m/B7rwBrRWcf1vg990xaI0H/NB
         bzNwswdxkla6mLMY97wrMcWA2v3G4p4nLpH1k9s1MikbAvk6cYnp2VeQcT7C54innmlB
         jN1Q==
X-Gm-Message-State: AKGB3mLMdPU8V0xJk+DhypxvYX2ZWFjpxy+lwHd/c+1Zw9xSTm/Ft6MW
        S9HtaytWN5UWNftGpdgtBHc=
X-Google-Smtp-Source: ACJfBovseHbh4kg8+w5amkog/bw02Vb8rjy4YS2pGKTquvBZa8RmYujKWIMWRN4kNh1TqV0U8hQ8VQ==
X-Received: by 10.98.72.69 with SMTP id v66mr27969265pfa.135.1514370358175;
        Wed, 27 Dec 2017 02:25:58 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id v40sm3866149pgn.51.2017.12.27.02.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 02:25:56 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 27 Dec 2017 17:25:51 +0700
Date:   Wed, 27 Dec 2017 17:25:51 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH] status: add a failing test showing a core.untrackedCache
 bug
Message-ID: <20171227102551.GA26616@ash>
References: <20171222140032.21180-1-avarab@gmail.com>
 <CACsJy8B1FNpq-AYJdcs_gVOxdPSnh-kNaeVykLSSDL1+EW9YjA@mail.gmail.com>
 <87wp1ar6j1.fsf@evledraar.gmail.com>
 <CACsJy8AmbKSp0mDLRaDCWn45veeNc03B-Gq8r8PQPrDt9bM_EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8AmbKSp0mDLRaDCWn45veeNc03B-Gq8r8PQPrDt9bM_EA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 26, 2017 at 05:47:19PM +0700, Duy Nguyen wrote:
> Strangely, root dir is not cached (no valid flag). I don't know why
> but that's ok we'll roll with it.

I figured this out. Which is good because now I know how/why the bug
happens.

> An invalidate_directory() call before the "return path_none" above
> might be the solution...

Nope. This is better. I think checking out any d/f updates would cause
this, not just symlinks.

-- 8< --
Subject: [PATCH] dir.c: fix missing dir invalidation in untracked code

Let's start with how create a new directory cache after the last one
becomes invalid (e.g. because its dir mtime has changed...). In
open_cached_dir():

1. We start out with valid_cached_dir() returning false, which should
   call invalidate_directory() to put a directory state back to
   initial state, no untracked entries (untracked_nr zero), no sub
   directory traversal (dirs[].recurse zero).

2. Since the cache cannot be used, we go the slow path opendir() and
   go through items one by one via readdir(). All the directories on
   disk will be added back to the cache (if not already exist in
   dirs[]) and its flag "recurse" gets changed to one to note that
   it's part of the cached dir travesal next time.

3. By the time we reach close_cached_dir() we should have a good
   subdir list in dirs[]. Those with "recurse" flag set are the ones
   present in the on-disk directory. The directory is now marked
   "valid".

Next time read_directory() is called, since the directory is marked
valid, it will skip readdir(), go fast path and traverse through
dirs[] array instead.

Steps one and two need some tight cooperation. If a subdir is removed,
readdir() will not find it and of course we cannot examine/invalidate
it. To make sure removed directories on disk are gone from the cache,
step one must make sure recurse flag of all subdirs are zero.

But that's not true. If "valid" flag is already false, there is a
chance we go straight to the end of valid_cached_dir() without calling
invalidate_directory(). Or we fail to meet the "if (untracked-valid)"
condition and skip over the invalidate_directory().

After step 3, we mark the cache valid. Any stale subdir with incorrect
recurse flagbecomes a real subdir next time we traverse the directory
using dirs[] array.

We could avoid this by making sure invalidate_directory() is always
called (therefore dirs[].recurse cleared) at the beginning of
open_cached_dir(). Which is what this patch does.

As to how we get into this situation, the key in the test is this
command

    git checkout master

where "one/file" is replaced with "one" in the index. This index
update triggers untracked_cache_invalidate_path(), which clears valid
flag of the root directory while keeping "recurse" flag on the subdir
"one" on. On the next git-status, we go through steps 1-3 above and
save an incorrect cache on disk. The second git-status blindly follows
the bad cache data and shows the problem.

This is arguably because of a bad design where "recurse" flag plays
double roles: whether a directory should be saved on disk, and whether
it is part of a directory traversal.

We need to keep recurse flag set at "checkout master" because of the
first role: we need to keep subdir caches (dir "two" for example has
not been touched at all, no reason to throw its cache away).

As long as we make sure to ignore/reset "recurse" flag at the
beginning of a directory traversal, we're good. But maybe eventually
we should separate these two roles.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 dir.c                             | 22 ++++++++++++++--------
 t/t7063-status-untracked-cache.sh |  2 +-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index 3c54366a17..cca88247d3 100644
--- a/dir.c
+++ b/dir.c
@@ -733,7 +733,16 @@ static void invalidate_directory(struct untracked_cache *uc,
 				 struct untracked_cache_dir *dir)
 {
 	int i;
-	uc->dir_invalidated++;
+
+	/*
+	 * Invalidation increment here is just roughly correct. If
+	 * untracked_nr or any of dirs[].recurse is non-zero, we
+	 * should increment dir_invalidated too. But that's more
+	 * expensive to do.
+	 */
+	if (dir->valid)
+		uc->dir_invalidated++;
+
 	dir->valid = 0;
 	dir->untracked_nr = 0;
 	for (i = 0; i < dir->dirs_nr; i++)
@@ -1740,23 +1749,18 @@ static int valid_cached_dir(struct dir_struct *dir,
 	refresh_fsmonitor(istate);
 	if (!(dir->untracked->use_fsmonitor && untracked->valid)) {
 		if (stat(path->len ? path->buf : ".", &st)) {
-			invalidate_directory(dir->untracked, untracked);
 			memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
 			return 0;
 		}
 		if (!untracked->valid ||
 			match_stat_data_racy(istate, &untracked->stat_data, &st)) {
-			if (untracked->valid)
-				invalidate_directory(dir->untracked, untracked);
 			fill_stat_data(&untracked->stat_data, &st);
 			return 0;
 		}
 	}
 
-	if (untracked->check_only != !!check_only) {
-		invalidate_directory(dir->untracked, untracked);
+	if (untracked->check_only != !!check_only)
 		return 0;
-	}
 
 	/*
 	 * prep_exclude will be called eventually on this directory,
@@ -1788,8 +1792,10 @@ static int open_cached_dir(struct cached_dir *cdir,
 	if (valid_cached_dir(dir, untracked, istate, path, check_only))
 		return 0;
 	cdir->fdir = opendir(path->len ? path->buf : ".");
-	if (dir->untracked)
+	if (dir->untracked) {
+		invalidate_directory(dir->untracked, untracked);
 		dir->untracked->dir_opened++;
+	}
 	if (!cdir->fdir)
 		return -1;
 	return 0;
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 7cf1e2c091..8f5ef32525 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -707,7 +707,7 @@ test_expect_success 'setup worktree for symlink test' '
 	git commit -m"second commit"
 '
 
-test_expect_failure '"status" after symlink replacement should be clean with UC=true' '
+test_expect_success '"status" after symlink replacement should be clean with UC=true' '
 	git checkout HEAD~ &&
 	status_is_clean &&
 	status_is_clean &&
-- 
2.15.0.320.g0453912d77

-- 8< --
