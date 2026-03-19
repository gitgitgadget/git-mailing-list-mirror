Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AFB395255
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942337; cv=none; b=F3ldNl4nxQMdeARXTb6oWym2y/YTzZPkN67HaRK8F4/fSqvrkRa2grBIIRxfQ84eXhRTeN8PdCkTAtex8Wt4O5WEWfZe0GIsIQoOsK5Uk4dAyTg31DOI0iNeeaisEi/UZgHKngH5nBRZjiOjFZWpAaaFdAcw/Ko5l1b0trVUWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942337; c=relaxed/simple;
	bh=VxD8OK9t9lS9BnP/zNpAI6jCh+Tf9yIKj/R9hhCvyww=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=uJ1wUTRNij4/i+eLZBRXUDDRtfuiZMAnq01PtnAyen5cnEBWUaxo6kkNif4VyuNqidC2kqyzo3UaIfnk6fQK1UkPp5+gvZ0kRLGJSTRJxhdejvta5TaFHttvcVYm+SbX5v4iOplO0YsYXHzytUv7f5qEaX3/yWHug8LPnsh56mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Twu/BXpV; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=GYjbU73v; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Twu/BXpV";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="GYjbU73v"
DKIM-Signature: a=rsa-sha256; b=Twu/BXpVeZ+LINrJhhyj3O7VUk7H6R/vwCnFqbiapr+qMRnPDRIO1vXXWGbCUDF0VtlWYb9oFt3u0iijbffXZtCA3Iws6BIR9rkUQiQW2iMdqnH7OGmnoaG+C302rurK8a/+Zdb36PqFxF3mpdclgsU6gE/dzpTaUo2RWCBsj33fSD1R/URZ82PZ65IgBRNTkwFs4kPjUxL+50RPhHg/JQ8y2aPJ3YSmF6MXME05EduX7Ol7zWdBRCIog1Upti5Y3B6pbh3jUKp1GWweiSj8djjQCISaIFp6oiKdKSqOz0zKLz4yFdOXhNquupJ/VO+G/CQ0+RvBCXoMgtjaTwAP0g==; s=purelymail3; d=malon.dev; v=1; bh=VxD8OK9t9lS9BnP/zNpAI6jCh+Tf9yIKj/R9hhCvyww=; h=Received:Date:To:From:Subject;
DKIM-Signature: a=rsa-sha256; b=GYjbU73vLBVdxGcodVmiOMTkshhfavqHTk7WPU7Ph0gqc2qldvYM6TW1gKXl+YUD5ibzLJKm8/amYuesOkQeERBii37y4RRc99Cb9cDbkrMwXBjbxBK+Mg1SlX33LhcY+EVG8BxTQGi4GGq2xBeMxnbyAPqOeJ2TE/6nWw2BJvWTV4cO/YgZHbXyS6qIadcTMtmH2bU7KYZCXBTAmvzqCyqcL3uj69wPGNRfy5CA7umtc+TCBVf0uyWx/LjWBOpfGjJjGscmVCMymhBm+Wp48IAmfB0FwhnGhSTPsGmy8PKTOZ2uGPDdcsNjC8CvfZ93DVew0w4ppD6G8n0SW+ffrg==; s=purelymail3; d=purelymail.com; v=1; bh=VxD8OK9t9lS9BnP/zNpAI6jCh+Tf9yIKj/R9hhCvyww=; h=Feedback-ID:Received:Date:To:From:Subject;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -167078664
          for <git@vger.kernel.org>
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 19 Mar 2026 17:45:30 +0000 (UTC)
Message-ID: <c0bb931a-3ee6-416b-8ceb-9fab013a621e@malon.dev>
Date: Fri, 20 Mar 2026 01:45:25 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git <git@vger.kernel.org>
From: Tian Yuchen <cat@malon.dev>
Subject: [Question] check_repository_format_gently() is not side-effect-free
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Git community,

In setup.c:

> static const char *setup_explicit_git_dir(const char *gitdirenv,
> 					  struct strbuf *cwd,
> 					  struct repository_format *repo_fmt,
> 					  int *nongit_ok)
> {
> 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
> 	const char *worktree;
> 	char *gitfile;
> 	int offset;
> 
> 	if (PATH_MAX - 40 < strlen(gitdirenv))
> 		die(_("'$%s' too big"), GIT_DIR_ENVIRONMENT);
> 
> 	gitfile = (char*)read_gitfile(gitdirenv);
> 	if (gitfile) {
> 		gitfile = xstrdup(gitfile);
> 		gitdirenv = gitfile;
> 	}
> 
> 	if (!is_git_directory(gitdirenv)) {
> 		if (nongit_ok) {
> 			*nongit_ok = 1;
> 			free(gitfile);
> 			return NULL;
> 		}
> 		die(_("not a git repository: '%s'"), gitdirenv);
> 	}
> 

...

> 	if (check_repository_format_gently(gitdirenv, repo_fmt, nongit_ok)) {
> 		free(gitfile);
> 		return NULL;
> 	}

I've noticed that this function behaves rather strangely. If I am 
correct, The primary purpose of this function is to verify whether the 
Git binary understands the current repository format.

The implementation is as follows:

> static int check_repository_format_gently(const char *gitdir, struct repository_format *candidate, int *nongit_ok)
> {
> 	struct strbuf sb = STRBUF_INIT;
> 	struct strbuf err = STRBUF_INIT;
> 	int has_common;
> 
> 	has_common = get_common_dir(&sb, gitdir);
> 	strbuf_addstr(&sb, "/config");
> 	read_repository_format(candidate, sb.buf);
> 	strbuf_release(&sb);
> 
> 	/*
> 	 * For historical use of check_repository_format() in git-init,
> 	 * we treat a missing config as a silent "ok", even when nongit_ok
> 	 * is unset.
> 	 */
> 	if (candidate->version < 0)
> 		return 0;
> 
> 	if (verify_repository_format(candidate, &err) < 0) {
> 		if (nongit_ok) {
> 			warning("%s", err.buf);
> 			strbuf_release(&err);
> 			*nongit_ok = -1;
> 			return -1;
> 		}
> 		die("%s", err.buf);
> 	}
> 
> 	the_repository->repository_format_precious_objects = candidate->precious_objects;
> 
> 	string_list_clear(&candidate->unknown_extensions, 0);
> 	string_list_clear(&candidate->v1_only_extensions, 0);
> 
> 	if (candidate->worktree_config) {
> 		/*
> 		 * pick up core.bare and core.worktree from per-worktree
> 		 * config if present
> 		 */
> 		strbuf_addf(&sb, "%s/config.worktree", gitdir);
> 		git_config_from_file(read_worktree_config, sb.buf, candidate);
> 		strbuf_release(&sb);
> 		has_common = 0;
> 	}

...

> 	if (!has_common) {
> 		if (candidate->is_bare != -1) {
> 			is_bare_repository_cfg = candidate->is_bare;
> 			if (is_bare_repository_cfg == 1)
> 				inside_work_tree = -1;
> 		}
> 		if (candidate->work_tree) {
> 			free(git_work_tree_cfg);
> 			git_work_tree_cfg = xstrdup(candidate->work_tree);
> 			inside_work_tree = -1;
> 		}
> 	}
> 
> 	return 0;
> }

Obviously it applies the parsed results to the global environment. Since 
this function starts with 'check_' and ends with '_gently,' it's hard 
not to think of it as a side-effect-free diagnostic function.

git grep "^[a-z_]* check_[a-z_]*(" -- "*.c"

Using the command above, we can see that there are other functions in 
the Git source code that start with 'check_' but are not entirely 
side-effect-free. However, I believe that the two variables 
(is_bare_repository_cfg, git_work_tree_cfg) this function modifies are 
much more crucial: For example, if I want to handle both a bare 
repository and a normal repository within a single process, wouldn't 
problems arise soon?

I would love to hear if there are any historical reasons preventing us 
from stripping these global side-effects out of this function.

Regards,

Yuchen
