Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D81E7C23
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357343; cv=none; b=ZKCQFQTS4DhpVH0oEDKBqCuXEXSzRvWMtK0cvgP5Kyn3jtPbvMY5udcdniGj/Iecc3AqI85qU2sS4Q5NTvpHM8ejpZbPu8W/UF9v32yuN+3qBc0y2eh02tjhJSVOx/hc30/avtzG2DljLm022pI5F5mXWMbRAGiqneqvYgWu8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357343; c=relaxed/simple;
	bh=M7OsSuDonCadmpGxLhpHqCy3jODomgAYATxEA8EtNoQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nEbZVzoMDcW1/XFmk5n0z2y1uovkgwmOI4LrigkzcwcJnjHmoK9BJT7fZVWd5jd1wTWRF+YsokAn8rkdfhNmvXVM1AcmvsoYJSTOLYQU62HmdDEQm0ZM/hbmC0vPcDGiAJ15y+ZQcHKVZ7wzSal0XHnlIgY6gnfjSOFibJZvWqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bbrs43gE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bbrs43gE"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso8299705e9.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357339; x=1776962139; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OI2869QO3xZK85/t6XRkFrerhTht9WrC0dlJ4hLrSGY=;
        b=Bbrs43gEZzsl74Ed6wyZ1zMeXUc6ZjPMuaTM1ne+hyOfIudrDRsQpKPJyyKX6On/fd
         C+hOKZT/hQq7PDZmzKSm7Es8QMkfw+kzz8JkKncQBQACrZasCpgcUWUqYNrk5EvrVm0C
         CGBiHpowhmOI6z4BUascb7k+FoHNP+0wNt8yXtdrUs4NpSfaelwSLHuM4SmoV9Dr+hxZ
         hZinim2Eg/f3NThf2ZBk9DmQVEgGfkgWPks10Wz7dCg/rywo3tPiDWlxrAhDDEu9yBHg
         oii3f2OEqpsEN9A7sDNlbvbxAN+zhmekyas1qu7SFazaMPTGEGs0VcD+Nnqw4uX750Ay
         EGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357339; x=1776962139;
        h=content-disposition:mime-version:reply-to:message-id:subject:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI2869QO3xZK85/t6XRkFrerhTht9WrC0dlJ4hLrSGY=;
        b=L4w2Tn2cjc8p5vdSO387B8Xg4xZ0i6Rr0XF/rxAJJEu4pzy0aJlqCTTRYn6viJ7Zol
         sDJD8RYwwFgqFZ9mhPjdOTTYgXVcM/dYRgbLvrHdHQMGrdoz+Xp6BX1EMq5q1Vw8BajS
         /1sJqL0bPeafIHD/6qxqU+0L5EGNr0wKIOn9CvV5kMEn6jJqcOw9UnNBIkNZSfQ9ot0k
         BFOJ3LPtan8gV7Y4w5O9nceQSHasRvIOezYxdQMMmSpBwQR3sQVyX08HWeOATSo/EhZ5
         UuYjPvoRuYsBz1JTo+aM0QAg7+EolRH8rhDN1ql3ukpVNSJ26Tr4wcSk7baUsEPSd0G+
         jiyg==
X-Gm-Message-State: AOJu0Yy4tP7YTTnvJpUsWmbpOYZcXOWh5rUFri5QumyCcI/0bFy/gTwL
	GVGGGSie/A2jSKbqj6J+oOfwPbklHzVPagn939hkvg4mtn/SY0q26YUYN2qR7Q==
X-Gm-Gg: AeBDieuyy7P9o0aJ5gj0RhCgFkkATJbbFD1x0ixR1tPxAEyQV1vOIz2dAoXJHERxPnW
	uU6I+vOZn2hoavnO1ORvX5Rx52evd846uXdxJekXpWVezXucYM6SbOTPPCNufW2usaIeFy8w7/+
	maRuj5kMQirEbjnvFk1EE+Rsf7pELIbNxxWfU5ow+tvPiU9WET4Hwak2IvolG75cci7jn1m0DBx
	PgdNOUaP2OxqKdZp3mh2/FlpGBc5IHkHYY2To9qHZieJACV6ZBCIOxOSIf5Xkz9+DrJvzq1otXI
	IXWKQY1jW48Ljnk9+JUEHS+vki/W4c4p0W/3lav0eyOTYXqJoyrW0ZxFXBp2GXI3JcMKjImOqju
	NWJq1pHMANB2w704yRw8BkrvaavdVMBZzqrskvB4bdgG//8u+mWYgsu3Zzd9KmrbBZvpZMkCB3V
	n7yNOe4yQa1qrgeweZ5szMEZ7Wd3YbI+VUzqez9WAucEpv09TMT9SiftagapbbezaOg3gEkqy+u
	4vd2M05JM+23E2I
X-Received: by 2002:a05:600c:4a1a:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488f480c640mr36242325e9.12.1776357338541;
        Thu, 16 Apr 2026 09:35:38 -0700 (PDT)
Received: from RTX ([79.117.197.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fa67aa5fsm897315e9.23.2026.04.16.09.35.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:35:37 -0700 (PDT)
Date: Thu, 16 Apr 2026 18:35:36 +0200
From: Jimmy Aguilar Mena <kratsbinovish@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 2/3] worktree: add --recurse-submodules flag to worktree add
Message-ID: <aeEPk7m5gwPnmMUZ@RTX>
Reply-To: CAPSFGa8uu9CEEPH3XVjfN5VEOfcnb2p8YgXVuansjKc0S2S_tA@mail.gmail.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

When "git submodule update --init" is run inside a linked worktree,
submodule_name_to_gitdir() returns a per-worktree path:

   $GIT_COMMON_DIR/worktrees/<id>/modules/<name>

rather than the main worktree's:

   $GIT_COMMON_DIR/modules/<name>

If the main worktree already has the submodule cloned, the per-worktree
gitdir does not yet exist and clone_submodule() falls through to fetch
from the remote URL -- wasting bandwidth and disk space when all the
objects are already present locally.

Detect this case: when the target sm_gitdir does not exist, differs
from the common-dir path, and the common-dir path is a valid git
directory, skip the remote clone and instead run:

   git clone --local --no-checkout --separate-git-dir <sm_gitdir> \
             <common_sm_gitdir> <working_tree_path>

"--local" makes Git use hardlinks for pack files and loose objects, so
no extra disk space is consumed for data that is already present.  The
per-worktree gitdir gets its own HEAD, index, and config, just like any
other worktree, while sharing the object store with the main worktree's
submodule repository.  Mutable per-worktree files (HEAD, refs, index,
config) start out as hardlinks but become independent on the first write
via Git's atomic rename(2) approach.

Signed-off-by: Jimmy Aguilar Mena <kratsbinovish@gmail.com>
---
  builtin/submodule--helper.c | 54 +++++++++++++++++++++++++++++++++++++
  1 file changed, 54 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2f589e3b37..2da59e8c93 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1914,6 +1914,59 @@ static int clone_submodule(const struct module_clone_data *clone_data,
  		clone_data_path = to_free = xstrfmt("%s/%s", repo_get_work_tree(the_repository),
  						    clone_data->path);
  
+	/*
+	 * If we are populating a submodule in a linked worktree and the main
+	 * worktree already has this submodule cloned, reuse its objects via a
+	 * local clone (hardlinks) instead of fetching from the network.  The
+	 * common-dir path "$GIT_COMMON_DIR/modules/<name>" is where the main
+	 * worktree stores the submodule gitdir; the per-worktree path returned
+	 * by submodule_name_to_gitdir() diverges from it only in linked
+	 * worktrees.
+	 */
+	{
+		struct strbuf common_sm_gitdir = STRBUF_INIT;
+		strbuf_addf(&common_sm_gitdir, "%s/modules/%s",
+			    the_repository->commondir, clone_data->name);
+
+		if (!file_exists(sm_gitdir) &&
+		    strcmp(sm_gitdir, common_sm_gitdir.buf) &&
+		    is_git_directory(common_sm_gitdir.buf)) {
+			/*
+			 * Main worktree has the submodule; reuse it locally.
+			 * git clone --local creates hardlinks for pack files so
+			 * no extra disk space is needed for existing objects.
+			 */
+			if (clone_data->require_init && !stat(clone_data_path, &st) &&
+			    !is_empty_dir(clone_data_path))
+				die(_("directory not empty: '%s'"), clone_data_path);
+
+			if (safe_create_leading_directories_const(the_repository, sm_gitdir) < 0)
+				die(_("could not create directory '%s'"), sm_gitdir);
+
+			strvec_push(&cp.args, "clone");
+			strvec_push(&cp.args, "--local");
+			strvec_push(&cp.args, "--no-checkout");
+			if (clone_data->quiet)
+				strvec_push(&cp.args, "--quiet");
+			strvec_pushl(&cp.args, "--separate-git-dir", sm_gitdir, NULL);
+			strvec_push(&cp.args, "--");
+			strvec_push(&cp.args, common_sm_gitdir.buf);
+			strvec_push(&cp.args, clone_data_path);
+
+			cp.git_cmd = 1;
+			prepare_submodule_repo_env(&cp.env);
+			cp.no_stdin = 1;
+
+			if (run_command(&cp))
+				die(_("local clone of '%s' into submodule path '%s' failed"),
+				    common_sm_gitdir.buf, clone_data_path);
+
+			strbuf_release(&common_sm_gitdir);
+			goto connect_wt;
+		}
+		strbuf_release(&common_sm_gitdir);
+	}
+
  	if (!file_exists(sm_gitdir)) {
  		if (clone_data->require_init && !stat(clone_data_path, &st) &&
  		    !is_empty_dir(clone_data_path))
@@ -2005,6 +2058,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
  		    sm_gitdir);
  	}
  
+connect_wt:
  	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
  
  	p = repo_submodule_path(the_repository, clone_data_path, "config");


