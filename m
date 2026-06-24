Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DDA31DDBF
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338118; cv=none; b=gTxEZl3rrbGTILRKUfds9N45kcjxbdnjvizZLg21otqC3ED+QLmC1mYLoooXtn7EyCFHtwCCygglAomOO1u+kDU8yPlZmF5733MNa/Aaj/Pm8vJGiIb0wJ3tgMOqP3WCZI38KSP1oZ9hsypYzL6cq9MCv6/gq0WtOaEfnuzUyfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338118; c=relaxed/simple;
	bh=B042EPes6woXUxLM7p7TMHZG8FfP4bjW62WwRm7fxNQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rp5+4Jd4BdzxJQU1gRjK+rR3T0ywunviDK5J7TiornWr8XEMdoIDHpidi/Hkx7+QTpSxzoLWqNaoM1OH5IyzicehG0D3D6fFQV3sBEezBCb/SCgC4Z+9fiuEq8IwKSEumTN1ke+eTFbiBPqiRVzvDglPE1ap2ny8QpfLSmNeifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvyUTbIV; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvyUTbIV"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51788280e71so15004251cf.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338116; x=1782942916; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cklhLQ82YmP3pTWNWJAXugKfL5RE/g/ZaAAJLnfbyzc=;
        b=CvyUTbIVHDl2h3uHBzLID1f+EtmDdnV0DbJ+vEcODHfeY4vbI4INq+uPPdURir6AsN
         PHy4GvpjjC8T+sXAaKgpTMCP0MfcRP8IbKRpkVlqRTzz0FcZ0YkCBZUJvRfDtyKGZe1l
         oDfdaTFRUgQoZeQLVngeGdNNT3Yrqeqo/Zbt8h8aBhco78c6IOSG7U3YY52ykLmMrIt0
         dcy/DY7vDKWd1QaEW7gJG2yozppvtH2b3kzDwElim4ub+fb18/kxLLvp0xZW5MqczC7T
         5VcRF3eiNvkQo4W6eWESLlLHXbSD1dMECTCt2dbJegVfgWuiW4nR2UO1+MRyTOwpt25c
         3LYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338116; x=1782942916;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cklhLQ82YmP3pTWNWJAXugKfL5RE/g/ZaAAJLnfbyzc=;
        b=M0xXxF8EvxCH4XFkCyZjAMu2EHuape/MAJzL958WrDddN9CzNH6pZRhTBxZoKzBThT
         oaJd3itnzzQg4XpsUt3iuUoCzyM6EctD/STjs/HaJyvsVo2fCFqBmElGJ0/7GGn0ub2I
         k9B0Oa0/aMdTBtiz9AQLY0NkcgHFZfsZYQpupHcfH4fBMyY6RacvGiXsW3BKMOOwQKmZ
         nV+aCpZa8uzL/Re9s6Vlx5gPST196jor1ono1Bn/J91Cnx6utYIXC6zNj4jIDFBAuhie
         zUMi+Ub3Mlhqt+BytTzI19Tbe+Yh20iWj8JX+vVQgTlPQEe/9pAsKiUnT0HTShdL9X+U
         lFRw==
X-Gm-Message-State: AOJu0YwpH526oQPYQmuEVFTybyK1v2e1SwnSY6DQg8Sb2yGtHMU+hz9z
	we9I2IikUCKRuv/VhP/LKwL+xDXBPNfZHSKGHu2SbhPsl0i5k7eCMKQJaD8qjQ==
X-Gm-Gg: AfdE7ckJo6UR0BhlRHkUnXytLLykUGvtzjkDO5dzjx05kEIphQMlwzpT10er81tNXV4
	oN3bPoQKIb7q46RKXFhuKvxGTcPllqsbSjulqX3d5USmNPR1VQ4TqmfNFBc/fAON9L3JCdceORt
	Z9bPrbHQj4RSdIkFGT6iOUVr6wPkNAknGeUVAVorrLqEtvoMrqt4SN1+vJFByFrD/HdsWVaOgcz
	UmTZUrqLp6/DedyCrw3lzP+zu40j03aeRcD95yjPO2S2SsH7RJ81NM+B1uJSb15gsw5dIKP+u3G
	xWeOQSBVbex7IZOcBqKTP6cONI8IY9Xl04h4RbhN8XdDBqV2OniUYIHxIuoqMMZ9TBiV0oFvffg
	R/SXtOTIgoiOELNJpSmJ1s/M/vxrsyedN4lCmWJyUgLax7E/A8TXxbbJ/whjMVcIdgftZLj5Lfb
	E0rtrEX68exyYXfVc=
X-Received: by 2002:a05:622a:20e:b0:516:e00e:6868 with SMTP id d75a77b69052e-51a06aeeac5mr308116021cf.46.1782338116055;
        Wed, 24 Jun 2026 14:55:16 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.160.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8e231613af9sm104061676d6.38.2026.06.24.14.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:15 -0700 (PDT)
Message-Id: <pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
In-Reply-To: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:55:12 +0000
Subject: [PATCH v2 0/2] branch/push: suggest intended form when remote/branch slip given
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>

When the repository or upstream argument is a slip like "origin/main" or
"origin main", suggest the intended "git push origin main" or "git branch
--set-upstream-to=origin/main" form instead of failing with an unrelated
error.

Changes in v2:

 * Rewrote both commit messages to lead with the intended command, the easy
   slip, and the resulting error, instead of the terse original.
 * Gated each suggestion on advice_enabled() up front, so a user who
   silenced the hint pays no remote/ref lookups and falls through to the
   original error. Extracted the detection logic into helpers
   (die_if_repo_looks_like_ref, die_if_upstream_looks_like_remote) so each
   call site reads as a single guarded line.

Harald Nordgren (2):
  branch: suggest <remote>/<branch> on upstream slip
  push: suggest <remote> <branch> for a slash slip

 Documentation/config/advice.adoc |  5 +++++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/branch.c                 | 26 ++++++++++++++++++++++
 builtin/push.c                   | 31 +++++++++++++++++++++++++-
 t/t3200-branch.sh                | 38 ++++++++++++++++++++++++++++++++
 t/t5529-push-errors.sh           | 31 ++++++++++++++++++++++++++
 7 files changed, 132 insertions(+), 1 deletion(-)


base-commit: ab776a62a78576513ee121424adb19597fbb7613
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2331%2FHaraldNordgren%2Fsuggest-remote-branch-slips-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2331/HaraldNordgren/suggest-remote-branch-slips-v2
Pull-Request: https://github.com/git/git/pull/2331

Range-diff vs v1:

 1:  21684539de ! 1:  11bcecebf4 branch: suggest <remote>/<branch> on upstream slip
     @@ Metadata
       ## Commit message ##
          branch: suggest <remote>/<branch> on upstream slip
      
     -    "git branch --set-upstream-to origin main" reads the trailing word as
     -    the local branch to operate on and dies with "branch 'main' does not
     -    exist", pointing at the wrong problem.
     +    When setting the upstream of the current branch to the 'main' branch
     +    of the remote 'origin', i.e.,
      
     -    When that branch is missing and "<remote>/<branch>" names a real
     -    remote-tracking ref, suggest the intended
     -    "git branch --set-upstream-to=<remote>/<branch>" form.
     +        $ git branch --set-upstream-to origin/main
     +
     +    it is easy to mistakenly write
     +
     +        $ git branch --set-upstream-to origin main
     +
     +    That is parsed as a request to set the upstream of the local branch
     +    'main' to 'origin'. When 'main' does not exist, the command dies
     +    with:
     +
     +        fatal: branch 'main' does not exist
     +
     +    pointing at a branch the user never meant to name.
     +
     +    When the operated-on branch is missing and '<remote>/<branch>' names
     +    a real remote-tracking ref, suggest the intended form:
     +
     +        $ git branch --set-upstream-to=origin/main
     +
     +    The suggestion is gated on '<remote>/<branch>' existing so it only
     +    appears when a slipped slash is the likely explanation.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## builtin/branch.c ##
     +@@ builtin/branch.c: static int edit_branch_description(const char *branch_name)
     + 	return 0;
     + }
     + 
     ++static void die_if_upstream_looks_like_remote(const char *new_upstream, const char *branch_name)
     ++{
     ++	struct strbuf remote_ref = STRBUF_INIT;
     ++	int code;
     ++
     ++	if (strchr(new_upstream, '/') ||
     ++	    !remote_is_configured(remote_get(new_upstream), 0))
     ++		return;
     ++
     ++	strbuf_addf(&remote_ref, "refs/remotes/%s/%s", new_upstream, branch_name);
     ++	if (!refs_ref_exists(get_main_ref_store(the_repository), remote_ref.buf)) {
     ++		strbuf_release(&remote_ref);
     ++		return;
     ++	}
     ++
     ++	code = die_message(_("--set-upstream-to takes a single <remote>/<branch> argument"));
     ++	advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
     ++			  _("Did you mean to use: git branch --set-upstream-to=%s/%s?"),
     ++			  new_upstream, branch_name);
     ++	strbuf_release(&remote_ref);
     ++	exit(code);
     ++}
     ++
     + int cmd_branch(int argc,
     + 	       const char **argv,
     + 	       const char *prefix,
      @@ builtin/branch.c: int cmd_branch(int argc,
       		if (!refs_ref_exists(get_main_ref_store(the_repository), branch->refname)) {
       			if (!argc || branch_checked_out(branch->refname))
       				die(_("no commit on branch '%s' yet"), branch->name);
     -+			if (argc == 1 && !strchr(new_upstream, '/') &&
     -+			    remote_is_configured(remote_get(new_upstream), 0)) {
     -+				struct strbuf remote_ref = STRBUF_INIT;
     -+
     -+				strbuf_addf(&remote_ref, "refs/remotes/%s/%s",
     -+					    new_upstream, argv[0]);
     -+				if (refs_ref_exists(get_main_ref_store(the_repository),
     -+						    remote_ref.buf)) {
     -+					int code = die_message(_("--set-upstream-to takes a single <remote>/<branch> argument"));
     -+					advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
     -+							  _("Did you mean to use: git branch --set-upstream-to=%s/%s?"),
     -+							  new_upstream, argv[0]);
     -+					strbuf_release(&remote_ref);
     -+					exit(code);
     -+				}
     -+				strbuf_release(&remote_ref);
     -+			}
     ++			if (argc == 1 &&
     ++			    advice_enabled(ADVICE_SET_UPSTREAM_FAILURE))
     ++				die_if_upstream_looks_like_remote(new_upstream, argv[0]);
       			die(_("branch '%s' does not exist"), branch->name);
       		}
       
 2:  ea1412b110 ! 2:  49de5a925d push: suggest <remote> <branch> for a slash slip
     @@ Metadata
       ## Commit message ##
          push: suggest <remote> <branch> for a slash slip
      
     -    "git push origin/main" is treated as a repository and dies with
     -    "'origin/main' does not appear to be a git repository", with no hint
     -    that a space was meant instead of a slash.
     +    When pushing the 'main' branch to the remote 'origin', i.e.,
      
     -    When the argument is not an existing path or configured remote but its
     -    part before the first slash names one, suggest the intended
     -    "git push <remote> <branch>" form. The suggestion is shown as advice so
     -    it can be silenced with advice.pushRepoLooksLikeRef.
     +        $ git push origin main
     +
     +    it is easy to mistakenly write
     +
     +        $ git push origin/main
     +
     +    That is parsed as the repository to push to, and since 'origin/main'
     +    is neither a configured remote nor a path it dies with:
     +
     +        fatal: 'origin/main' does not appear to be a git repository
     +
     +    Often 'origin/main' does not exist as a repository, so the command
     +    fails without doing any harm, but it gives no hint that a space was
     +    meant instead of a slash and can leave the user puzzled.
     +
     +    When the argument is not an existing path or configured remote but
     +    its part before the first slash names one, suggest the intended
     +    '<remote> <branch>' form:
     +
     +        $ git push origin main
     +
     +    The suggestion is shown as advice so it can be silenced with
     +    advice.pushRepoLooksLikeRef.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ builtin/push.c
       #include "environment.h"
       #include "gettext.h"
       #include "hex.h"
     +@@ builtin/push.c: static int push_multiple(struct string_list *list,
     + 	return result;
     + }
     + 
     ++static void die_if_repo_looks_like_ref(const char *repo)
     ++{
     ++	const char *slash = strchr(repo, '/');
     ++	struct strbuf name = STRBUF_INIT;
     ++	int code;
     ++
     ++	if (!slash || !slash[1] || file_exists(repo))
     ++		return;
     ++
     ++	strbuf_add(&name, repo, slash - repo);
     ++	if (!remote_is_configured(remote_get(name.buf), 0)) {
     ++		strbuf_release(&name);
     ++		return;
     ++	}
     ++
     ++	code = die_message(_("'%s' is not a valid push target"), repo);
     ++	advise_if_enabled(ADVICE_PUSH_REPO_LOOKS_LIKE_REF,
     ++			  _("Did you mean to use: git push %s %s?"),
     ++			  name.buf, slash + 1);
     ++	strbuf_release(&name);
     ++	exit(code);
     ++}
     ++
     + int cmd_push(int argc,
     + 	     const char **argv,
     + 	     const char *prefix,
      @@ builtin/push.c: int cmd_push(int argc,
       
       	if (repo) {
       		if (!add_remote_or_group(repo, &remote_group)) {
     -+			const char *slash = strchr(repo, '/');
      +			struct remote *r;
      +
     -+			/*
     -+			 * A "<remote>/<branch>" argument that does not name
     -+			 * a path is likely a slip for the separate
     -+			 * "<remote> <branch>" form, so suggest that instead.
     -+			 */
     -+			if (slash && slash[1] && !file_exists(repo)) {
     -+				struct strbuf name = STRBUF_INIT;
     -+
     -+				strbuf_add(&name, repo, slash - repo);
     -+				if (remote_is_configured(remote_get(name.buf), 0)) {
     -+					int code = die_message(_("'%s' is not a valid push target"), repo);
     -+					advise_if_enabled(ADVICE_PUSH_REPO_LOOKS_LIKE_REF,
     -+							  _("Did you mean to use: git push %s %s?"),
     -+							  name.buf, slash + 1);
     -+					strbuf_release(&name);
     -+					exit(code);
     -+				}
     -+				strbuf_release(&name);
     -+			}
     ++			if (advice_enabled(ADVICE_PUSH_REPO_LOOKS_LIKE_REF))
     ++				die_if_repo_looks_like_ref(repo);
      +
       			/*
       			 * Not a configured remote name or group name.

-- 
gitgitgadget
