Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2027A1F576
	for <e@80x24.org>; Fri,  2 Feb 2018 09:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeBBJZY (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 04:25:24 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36898 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbeBBJZT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 04:25:19 -0500
Received: by mail-pl0-f66.google.com with SMTP id ay8so5738415plb.4
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 01:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DLS85HTA3ADJb5E57SDNQL1xyfLnJNtP5ucTOH0cqhU=;
        b=We0cvfE9u4GzBNYKiDOJpSNsDe7T6NT+ABudP7hwXlCRZJ/uogTmmq5rnCwQu2/kJT
         7p9pjHp3Oq5Qe/gRzKAJp/A48jW3xieTxQjjty2MWYCoggBl2gukw0INSe2IVJfRmAG2
         bqt/hYvEbgLIoSIqScoRef7k514uzEKX8Yg31eXZbmnjcEFrqWQktYuEZam8QUDmxP+f
         Tfxah99sr+jRPOsgptvS+S5n5GiCGnrdYF8aYqje+297e6OknFlsdu2hzEYs6F/hxsDb
         NXCPNdR3W7GvG+Rx/Q7fOPJ6O96/ewLzoEvN1SZnoPgaOmUTI7EfjZNEVs53lN7YdeON
         Y9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DLS85HTA3ADJb5E57SDNQL1xyfLnJNtP5ucTOH0cqhU=;
        b=VFm7ojxIp8LIIVlvW+tM5PeAhHXrfBgiIwUhxEqJZeJj1SFN/mX2DWEzoDOB5nyPKB
         ZDsirnIo3hMPnzSh5K40GETDEKhyqjEotbTZVvDPwMcZToGlYoP0PCZfBz16kY8HpO39
         ZvII6lD/RpQ9X5J/lWIPHwpm5fJJGGCNKjBx3xxIat2fauDVWuzuBuMq7Z5xzr+i8P3h
         BAW/m0YK1ODEJWJqIS1xeJ1aR0qOvYne0oHaloEZbBlWLDVv3fwoQu09jUPdOr1hyp2U
         WTU29QFE+uCfjjvBatusszMjywbGWJw0x+15vYbGtkPoOecYaFxkBTk4lpfVER9MnBh4
         rM2Q==
X-Gm-Message-State: AKwxytfiVnHqONdbZaTw5LxsENFZS4KW5sa+BdnDRoLbaoa99ioCQg2R
        72z1kyoaAgtB0P6Ttpzl50Y=
X-Google-Smtp-Source: AH8x2268WpKfYJiVHGlrlvytmRyApZLOtb1mHu9EQSTOeJe09IDkAbMCmfemDM8TsHt5H/aJhKWDxw==
X-Received: by 2002:a17:902:8487:: with SMTP id c7-v6mr25124234plo.7.1517563519173;
        Fri, 02 Feb 2018 01:25:19 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id o7sm2166707pgp.18.2018.02.02.01.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2018 01:25:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 02 Feb 2018 16:25:11 +0700
Date:   Fri, 2 Feb 2018 16:25:11 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        tim@tim-landscheidt.de
Subject: Re: [PATCH v2 1/3] am: add --show-current-patch
Message-ID: <20180202092511.GA28946@ash>
References: <20180126095520.919-1-pclouds@gmail.com>
 <20180131093051.15525-1-pclouds@gmail.com>
 <20180131093051.15525-2-pclouds@gmail.com>
 <CAPig+cR24=0_NPekYaF+oG9OovDkv1Et-RpNvAHqE7Qd7g7QQA@mail.gmail.com>
 <xmqqpo5pr5wr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpo5pr5wr.fsf@gitster-ct.c.googlers.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 02:59:32PM -0800, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Wed, Jan 31, 2018 at 4:30 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> >> Pointing the user to $GIT_DIR/rebase-apply may encourage them to mess
> >> around in there, which is not a good thing. With this, the user does
> >> not have to keep the path around somewhere (because after a couple of
> >> commands, the path may be out of scrollback buffer) when they need to
> >> look at the patch.
> >>
> >> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> >> ---
> >> diff --git a/builtin/am.c b/builtin/am.c
> >> @@ -2121,6 +2120,22 @@ static void am_abort(struct am_state *state)
> >> +static int show_patch(struct am_state *state)
> >> +{
> >> +       struct strbuf sb = STRBUF_INIT;
> >> +       int len;
> >> +
> >> +       len = strbuf_read_file(&sb, am_path(state, msgnum(state)), 0);
> >> +       if (len < 0)
> >> +               die_errno(_("failed to read '%s'"),
> >> +                         am_path(state, msgnum(state)));
> >
> > Isn't this am_path() invocation inside die_errno() likely to clobber
> > the 'errno' from strbuf_read_file() which you want to be reporting?
> 
> True.

Thanks both. Good catch. Of course I will fix this in the re-roll, but
should we also do something for the current code base with the
following patch?

I think this is something coccinelle can help catch, but my
coccinelle-foo is way too low to come up with something like
"die_errno() must not take any arguments as function calls, except _()
and N_()".

-- 8< --
Subject: [PATCH] Preserve errno in case case before calling sth_errno()

All these locations do something like this

    sth_errno(..., somefunc(...));

where somefunc() can potentially change errno, which will be read by
sth_errno(). Call somefunc separately with errno preserved to avoid
this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/am.c      |  8 +++++++-
 builtin/commit.c  |  8 ++++++--
 builtin/init-db.c |  9 ++++++---
 rerere.c          |  9 ++++++---
 shallow.c         | 27 ++++++++++++++++++---------
 5 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index acfe9d3c8c..ba67e187a4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -244,6 +244,9 @@ static int am_in_progress(const struct am_state *state)
 static int read_state_file(struct strbuf *sb, const struct am_state *state,
 			const char *file, int trim)
 {
+	int saved_errno;
+	const char *path;
+
 	strbuf_reset(sb);
 
 	if (strbuf_read_file(sb, am_path(state, file), 0) >= 0) {
@@ -256,7 +259,10 @@ static int read_state_file(struct strbuf *sb, const struct am_state *state,
 	if (errno == ENOENT)
 		return -1;
 
-	die_errno(_("could not read '%s'"), am_path(state, file));
+	saved_errno = errno;
+	path = am_path(state, file);
+	errno = saved_errno;
+	die_errno(_("could not read '%s'"), path);
 }
 
 /**
diff --git a/builtin/commit.c b/builtin/commit.c
index 4610e3d8e3..39836b3734 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -780,8 +780,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	s->fp = fopen_for_writing(git_path_commit_editmsg());
-	if (s->fp == NULL)
-		die_errno(_("could not open '%s'"), git_path_commit_editmsg());
+	if (s->fp == NULL) {
+		int saved_errno = errno;
+		const char *path = git_path_commit_editmsg();
+		errno = saved_errno;
+		die_errno(_("could not open '%s'"), path);
+	}
 
 	/* Ignore status.displayCommentPrefix: we do need comments in COMMIT_EDITMSG. */
 	old_display_comment_prefix = s->display_comment_prefix;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index c9b7946bad..e384749f73 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -570,9 +570,12 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			set_git_work_tree(work_tree);
 		else
 			set_git_work_tree(git_work_tree_cfg);
-		if (access(get_git_work_tree(), X_OK))
-			die_errno (_("Cannot access work tree '%s'"),
-				   get_git_work_tree());
+		if (access(get_git_work_tree(), X_OK)) {
+			int saved_errno = errno;
+			const char *path = get_git_work_tree();
+			errno = saved_errno;
+			die_errno(_("Cannot access work tree '%s'"), path);
+		}
 	}
 	else {
 		if (work_tree)
diff --git a/rerere.c b/rerere.c
index 1ce440f4bb..f19a53ff2c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -683,9 +683,12 @@ static int merge(const struct rerere_id *id, const char *path)
 	 * A successful replay of recorded resolution.
 	 * Mark that "postimage" was used to help gc.
 	 */
-	if (utime(rerere_path(id, "postimage"), NULL) < 0)
-		warning_errno("failed utime() on %s",
-			      rerere_path(id, "postimage"));
+	if (utime(rerere_path(id, "postimage"), NULL) < 0) {
+		int saved_errno = errno;
+		const char *path = rerere_path(id, "postimage");
+		errno = saved_errno;
+		warning_errno("failed utime() on %s", path);
+	}
 
 	/* Update "path" with the resolution */
 	f = fopen(path, "w");
diff --git a/shallow.c b/shallow.c
index df4d44ea7a..9da82f5292 100644
--- a/shallow.c
+++ b/shallow.c
@@ -295,9 +295,12 @@ const char *setup_temporary_shallow(const struct oid_array *extra)
 		temp = xmks_tempfile(git_path("shallow_XXXXXX"));
 
 		if (write_in_full(temp->fd, sb.buf, sb.len) < 0 ||
-		    close_tempfile_gently(temp) < 0)
-			die_errno("failed to write to %s",
-				  get_tempfile_path(temp));
+		    close_tempfile_gently(temp) < 0) {
+			int saved_errno = errno;
+			const char *path = get_tempfile_path(temp);
+			errno = saved_errno;
+			die_errno("failed to write to %s", path);
+		}
 		strbuf_release(&sb);
 		return get_tempfile_path(temp);
 	}
@@ -319,9 +322,12 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update();
 	if (write_shallow_commits(&sb, 0, extra)) {
-		if (write_in_full(fd, sb.buf, sb.len) < 0)
-			die_errno("failed to write to %s",
-				  get_lock_file_path(shallow_lock));
+		if (write_in_full(fd, sb.buf, sb.len) < 0) {
+			int saved_errno = errno;
+			const char *path = get_lock_file_path(shallow_lock);
+			errno = saved_errno;
+			die_errno("failed to write to %s", path);
+		}
 		*alternate_shallow_file = get_lock_file_path(shallow_lock);
 	} else
 		/*
@@ -366,9 +372,12 @@ void prune_shallow(int show_only)
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update();
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
-		if (write_in_full(fd, sb.buf, sb.len) < 0)
-			die_errno("failed to write to %s",
-				  get_lock_file_path(&shallow_lock));
+		if (write_in_full(fd, sb.buf, sb.len) < 0) {
+			int saved_errno = errno;
+			const char *path = get_lock_file_path(&shallow_lock);
+			errno = saved_errno;
+			die_errno("failed to write to %s", path);
+		}
 		commit_lock_file(&shallow_lock);
 	} else {
 		unlink(git_path_shallow());
-- 
2.16.1.205.g271f633410

-- 8< --
