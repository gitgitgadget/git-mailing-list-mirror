Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD36221DAD
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766258201; cv=none; b=K1kAZYI5YRUDucyn4o3dhbzMohy7w7waF/BCB9CcnYcQPNj1J1LhhxucGqdG7GKAxElKJJL+4tzYIFC5k/mb52hUv1wAsYd2J+xgWTMzW+GmzN43UDU3Adr680oEmJs82XhBWCMdCFtadJK6pskBApB0TeidnWnvc/CgQ5nc6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766258201; c=relaxed/simple;
	bh=/X+zx9woOwdSVtSY2zE67zA/8m69MzZ/l7RPnF/MJFE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=C03DTLWIOPVkC6kjpeqJnk1O48czB6Jy65eoAwGCoMf1G6aQ98YLatDym10kkVCRuL27M5MxFEgZmqEN9cOz9Frsv3mhWbc2F0Mc5to6CXKiIIBi/IHqxGXVlGRH/KHcGFAuNYsB+kr/8MxDQlI/yjK7KipMwv1011jy8/eEyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvK/O+gV; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvK/O+gV"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a22eb38edso18416936d6.2
        for <git@vger.kernel.org>; Sat, 20 Dec 2025 11:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766258198; x=1766862998; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfKIFjoK90a2sVkAlDAZcUSTRDv7jx0IaeMLQZ5WEZU=;
        b=VvK/O+gVWYOOEINAPHBKojYyTsql8QYZr21iLkGB/meYP5XFa4b4ByCJFjJEE+7UR1
         EhFntQEp0yB5M1jbZwIkpbnXcJ7q7uadn5HLapsbMTa7VwvDJqVJ8b8QGrjV+wN+noxM
         kknvMO6h22njHggWGebZrKrIOrfVT7vLxAHDQoHzy11/iLbP51afFmU+XURGmo0gyExi
         /5cuqloKoUiqE6ke1CC43YLNV5Cypqy27ZIk3M0EHrlIRU7lZ4EcEqDz9Uhxh2Jt9ydl
         Uhj00ZUo6O7OvQe0PujO+0CTw18cjjyxRBRfRcpbCaAbn4WGY4kw9zivu/i96DUNIDvI
         /BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766258198; x=1766862998;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfKIFjoK90a2sVkAlDAZcUSTRDv7jx0IaeMLQZ5WEZU=;
        b=mQvnGTXsdekN7PiqspWtq5/nUHbTGAWG9I+3z3XqjdzYEPoGbBNctEbgsZ5bxiR60u
         dP5H0P8JhW5kPiXo/PcZKJfWaILua14xKCd5/qOFGiDq+F0X9tEV3NH6yHPRqPnhynCm
         a0zdHk3opI65Jyi8e6+arfWA6nXmHXnNyvWr7Dgi218bz7yTmEoe/yGW4+CzHowV+HGL
         KqO6WDBvmNMno+4CnHjYSYvvythkuih92l/RGiW51rm1opOAfffoVLJEQ7qLjbzjaZm1
         7SAEZsWuZvWOkl+dV0r7rrN/oJ0KEY1+/PqYLqjUUpuxf1+w2oI0unQAr+s5mdJJqLSn
         dW+A==
X-Gm-Message-State: AOJu0YzNh9mexL76Z8iDqpK00Yy1sqWQdlNEg1uG+gyQljJa11Shy84w
	1IJENpZZeZ7uTpoII6Kos8fowSD8q/1B/JUoacA68PUBjdSW9Dng6qG7KVj7pA==
X-Gm-Gg: AY/fxX7gbTUX134LImkoIR2lAYC/kKmxuZ6RSAjwpTlC7k/JDVUDomAVCeRmqvnGx0m
	0NkprYPkZcke2Niorb8yV/likEqYGY9/UztgUvSPtjzJGMJUmaCPNa9kESFzEfagzG4r+DXP6VD
	SeKbVtFlX5Cnui2XbzSLt9A5G14UufDbD5mzWU0vligR1CnbhIhuoFX+Nu9gX9gIcbkMAFvoqAh
	bSOx/TuocRm7v1J+pbzqxTO9fggMz3dpZI/HMN+j3YqhDjJiX7Lo9OOnIKzZ4nHqSh8sd8HckSC
	XOh0dq3BtydFTZp0GrUmQR9SwatqnFchRROxt+5Hk0eUguXUT9Ftv/p+938teEwUBNLkqdEmrpW
	cC/sYO2HhA4OWP3NOmG/94EUoCfTKMs5cRVzdrxbvTUgN/NVWgdW+f3sR72AkPGXKetkjBZOxfV
	KJcqXrDLQb+sowyA==
X-Google-Smtp-Source: AGHT+IHSoW2r2G0GZoiNiz9Uhi4qggToIBurXdsP9ZF0W/rDHTcQnaUx/yHIb0pJq+HCzJ/KbxUBfQ==
X-Received: by 2002:ad4:4ba7:0:b0:880:88fa:d742 with SMTP id 6a1803df08f44-88d8481d39cmr81291626d6.65.1766258198219;
        Sat, 20 Dec 2025 11:16:38 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997ae49esm49145736d6.28.2025.12.20.11.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 11:16:37 -0800 (PST)
Message-Id: <e6012ebf102861b97b3219adf79391898ae3e4fa.1766258187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2020.git.1766258187.gitgitgadget@gmail.com>
References: <pull.2020.git.1766258187.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Dec 2025 19:16:27 +0000
Subject: [PATCH 5/5] doc: convert git-remote to synopsis style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.
- also convert first sentences to imperative mood where applicable

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-remote.adoc | 106 +++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index 932a5c3ea4..eaae30aa88 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -8,20 +8,20 @@ git-remote - Manage set of tracked repositories
 
 SYNOPSIS
 --------
-[verse]
-'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
-'git remote rename' [--[no-]progress] <old> <new>
-'git remote remove' <name>
-'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
-'git remote set-branches' [--add] <name> <branch>...
-'git remote get-url' [--push] [--all] <name>
-'git remote set-url' [--push] <name> <newurl> [<oldurl>]
-'git remote set-url --add' [--push] <name> <newurl>
-'git remote set-url --delete' [--push] <name> <URL>
-'git remote' [-v | --verbose] 'show' [-n] <name>...
-'git remote prune' [-n | --dry-run] <name>...
-'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
+[synopsis]
+git remote [-v | --verbose]
+git remote add [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
+git remote rename [--[no-]progress] <old> <new>
+git remote remove <name>
+git remote set-head <name> (-a | --auto | -d | --delete | <branch>)
+git remote set-branches [--add] <name> <branch>...
+git remote get-url [--push] [--all] <name>
+git remote set-url [--push] <name> <newurl> [<oldurl>]
+git remote set-url --add [--push] <name> <newurl>
+git remote set-url --delete [--push] <name> <URL>
+git remote [-v | --verbose] show [-n] <name>...
+git remote prune [-n | --dry-run] <name>...
+git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]
 
 DESCRIPTION
 -----------
@@ -32,8 +32,8 @@ Manage the set of repositories ("remotes") whose branches you track.
 OPTIONS
 -------
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Be a little more verbose and show remote url after name.
 	For promisor remotes, also show which filters (`blob:none` etc.)
 	are configured.
@@ -43,14 +43,14 @@ OPTIONS
 COMMANDS
 --------
 
-With no arguments, shows a list of existing remotes.  Several
+With no arguments, show a list of existing remotes.  Several
 subcommands are available to perform operations on the remotes.
 
-'add'::
+`add`::
 
-Add a remote named <name> for the repository at
-<URL>.  The command `git fetch <name>` can then be used to create and
-update remote-tracking branches <name>/<branch>.
+Add a remote named _<name>_ for the repository at
+_<URL>_.  The command `git fetch <name>` can then be used to create and
+update remote-tracking branches `<name>/<branch>`.
 +
 With `-f` option, `git fetch <name>` is run immediately after
 the remote information is set up.
@@ -66,40 +66,40 @@ By default, only tags on fetched branches are imported
 +
 With `-t <branch>` option, instead of the default glob
 refspec for the remote to track all branches under
-the `refs/remotes/<name>/` namespace, a refspec to track only `<branch>`
+the `refs/remotes/<name>/` namespace, a refspec to track only _<branch>_
 is created.  You can give more than one `-t <branch>` to track
 multiple branches without grabbing all branches.
 +
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
-up to point at remote's `<master>` branch. See also the set-head command.
+up to point at remote's _<master>_ branch. See also the set-head command.
 +
 When a fetch mirror is created with `--mirror=fetch`, the refs will not
-be stored in the 'refs/remotes/' namespace, but rather everything in
-'refs/' on the remote will be directly mirrored into 'refs/' in the
+be stored in the `refs/remotes/` namespace, but rather everything in
+`refs/` on the remote will be directly mirrored into `refs/` in the
 local repository. This option only makes sense in bare repositories,
 because a fetch would overwrite any local commits.
 +
 When a push mirror is created with `--mirror=push`, then `git push`
 will always behave as if `--mirror` was passed.
 
-'rename'::
+`rename`::
 
-Rename the remote named <old> to <new>. All remote-tracking branches and
+Rename the remote named _<old>_ to _<new>_. All remote-tracking branches and
 configuration settings for the remote are updated.
 +
-In case <old> and <new> are the same, and <old> is a file under
+In case _<old>_ and _<new>_ are the same, and _<old>_ is a file under
 `$GIT_DIR/remotes` or `$GIT_DIR/branches`, the remote is converted to
 the configuration file format.
 
-'remove'::
-'rm'::
+`remove`::
+`rm`::
 
-Remove the remote named <name>. All remote-tracking branches and
+Remove the remote named _<name>_. All remote-tracking branches and
 configuration settings for the remote are removed.
 
-'set-head'::
+`set-head`::
 
-Sets or deletes the default branch (i.e. the target of the
+Set or delete the default branch (i.e. the target of the
 symbolic-ref `refs/remotes/<name>/HEAD`) for
 the named remote. Having a default branch for a remote is not required,
 but allows the name of the remote to be specified in lieu of a specific
@@ -116,15 +116,15 @@ the symbolic-ref `refs/remotes/origin/HEAD` to `refs/remotes/origin/next`. This
 only work if `refs/remotes/origin/next` already exists; if not it must be
 fetched first.
 +
-Use `<branch>` to set the symbolic-ref `refs/remotes/<name>/HEAD` explicitly. e.g., `git
+Use _<branch>_ to set the symbolic-ref `refs/remotes/<name>/HEAD` explicitly. e.g., `git
 remote set-head origin master` will set the symbolic-ref `refs/remotes/origin/HEAD` to
 `refs/remotes/origin/master`. This will only work if
 `refs/remotes/origin/master` already exists; if not it must be fetched first.
 +
 
-'set-branches'::
+`set-branches`::
 
-Changes the list of branches tracked by the named remote.
+Change the list of branches tracked by the named remote.
 This can be used to track a subset of the available remote branches
 after the initial setup for a remote.
 +
@@ -134,7 +134,7 @@ The named branches will be interpreted as if specified with the
 With `--add`, instead of replacing the list of currently tracked
 branches, adds to that list.
 
-'get-url'::
+`get-url`::
 
 Retrieves the URLs for a remote. Configurations for `insteadOf` and
 `pushInsteadOf` are expanded here. By default, only the first URL is listed.
@@ -143,18 +143,18 @@ With `--push`, push URLs are queried rather than fetch URLs.
 +
 With `--all`, all URLs for the remote will be listed.
 
-'set-url'::
+`set-url`::
 
-Changes URLs for the remote. Sets first URL for remote <name> that matches
-regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If
-<oldurl> doesn't match any URL, an error occurs and nothing is changed.
+Change URLs for the remote. Sets first URL for remote _<name>_ that matches
+regex _<oldurl>_ (first URL if no _<oldurl>_ is given) to _<newurl>_. If
+_<oldurl>_ doesn't match any URL, an error occurs and nothing is changed.
 +
 With `--push`, push URLs are manipulated instead of fetch URLs.
 +
 With `--add`, instead of changing existing URLs, new URL is added.
 +
 With `--delete`, instead of changing existing URLs, all URLs matching
-regex <URL> are deleted for remote <name>.  Trying to delete all
+regex _<URL>_ are deleted for remote _<name>_.  Trying to delete all
 non-push URLs is an error.
 +
 Note that the push URL and the fetch URL, even though they can
@@ -165,17 +165,17 @@ fetch from one place (e.g. your upstream) and push to another (e.g.
 your publishing repository), use two separate remotes.
 
 
-'show'::
+`show`::
 
-Gives some information about the remote <name>.
+Give some information about the remote _<name>_.
 +
 With `-n` option, the remote heads are not queried first with
 `git ls-remote <name>`; cached information is used instead.
 
-'prune'::
+`prune`::
 
-Deletes stale references associated with <name>. By default, stale
-remote-tracking branches under <name> are deleted, but depending on
+Delete stale references associated with _<name>_. By default, stale
+remote-tracking branches under _<name>_ are deleted, but depending on
 global configuration and the configuration of the remote we might even
 prune local tags that haven't been pushed there. Equivalent to `git
 fetch --prune <name>`, except that no new references will be fetched.
@@ -186,13 +186,13 @@ depending on various configuration.
 With `--dry-run` option, report what branches would be pruned, but do not
 actually prune them.
 
-'update'::
+`update`::
 
 Fetch updates for remotes or remote groups in the repository as defined by
 `remotes.<group>`. If neither group nor remote is specified on the command line,
-the configuration parameter remotes.default will be used; if
-remotes.default is not defined, all remotes which do not have the
-configuration parameter `remote.<name>.skipDefaultUpdate` set to true will
+the configuration parameter `remotes.default` will be used; if
+`remotes.default` is not defined, all remotes which do not have the
+configuration parameter `remote.<name>.skipDefaultUpdate` set to `true` will
 be updated.  (See linkgit:git-config[1]).
 +
 With `--prune` option, run pruning against all the remotes that are updated.
@@ -210,7 +210,7 @@ EXIT STATUS
 
 On success, the exit status is `0`.
 
-When subcommands such as 'add', 'rename', and 'remove' can't find the
+When subcommands such as `add`, `rename`, and `remove` can't find the
 remote in question, the exit status is `2`. When the remote already
 exists, the exit status is `3`.
 
@@ -247,7 +247,7 @@ $ git switch -c staging staging/master
 ...
 ------------
 
-* Imitate 'git clone' but track only selected branches
+* Imitate `git clone` but track only selected branches
 +
 ------------
 $ mkdir project.git
-- 
gitgitgadget
