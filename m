Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298CC3A7F58
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289172; cv=pass; b=DSBib4CdUqKJNQtT8sS7X2Qq7EwvkIskBN7vk/YyU4EgocWlXgc1DpqWhScZu6ehhS5TgtV7ADLyTM0P4kjD5gwfeNIXZlE7+xEo3oFWqwhsmtfkA9KU0lmVYWQSdI/jrxzGosLpRiqAQ2LG5/tKtEDOap2aQXauq+3Mw1Oovd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289172; c=relaxed/simple;
	bh=kn2KPz+D2Sbd1bi/Gf1vVuDTFIEShENW04IRoumZMAU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVWUTfPvCdCtVfp3u8SUNFSPt+p/dXE/IftS3pmLf5bEPMJkRfns4WMcvT5v8IC95pohLBtbCdmRENQwMTsGOz2Qhuaf8ZiBiARnlxPtmso5Pa3GGV46IRaImtjBIFQ6//1G7cXfO2w65pTRTzvws1OPidVzO54r0e1fvCacfpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIb77NUd; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIb77NUd"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-948a2d37896so488971241.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 02:59:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770289171; cv=none;
        d=google.com; s=arc-20240605;
        b=cELHI5VcP52Av2Lqp63dah6sU6G4dxa6y0sEp0sDhfRiuKudLbEqzcNWWUUuTHDQuZ
         Yso4jMpFWDAiXZd/kNzjzfZFPpwj75U/2lXX7GPMu4MFsGpUf4Z8uGEnJqJ/bXrC3nCH
         hzaZNx7+keFoNKOGjAvG5VF5DEbdlWWrogtxLaLlCDBhki4cOnZ2IN8Vj3y/4UdVy9V3
         MQMlJJjaDd5dokjS1GGSQ0Q29XgvW3Cvsa0f9vRFihkkv0UgHUdtrNv1ncAjcsR+/B8F
         ZMyjlz8sVf3JfK0Tl9YKl5aXnWVWIDGdz9kAgRpe30qGSkgIyPZPn3xTys0TyWCj9KFf
         WSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=alMsRxewfJOS+guFyDR4XomPyiWRfrZzDa7uP0XKAlc=;
        fh=zdSKbzSFtXYkdQm0UvFPNsyY4oXCKuYgspug081lnIk=;
        b=Pm22iclgUTVGnPu6AWki826GFwiN69orUoDvJwO1QqYLHQEaxrJdX1UPcB8hW9Aw3V
         jzyGRJbS4h1Bh4PHRt63+CnmqiVYMFaaa3sr3+R2JXZVIs3cpeO0U8kP1fMgvsnA0o39
         biiD6cVe8APjLtcNUyDOsGkiECn1qB+QxYbNkiR4jKp9E/JVqF4yzljF99Um2BFoE1na
         5SW/OBM8ARnxISjR8DCEPmmuzW3buiOCPPnZeO22rZKUz2IiCgjcfemLcrZMJ2tTfkKQ
         yzeluIQycp44dkYYQJQGQjiOTYNSS8JQ9pQ7Ie42E7OtixGuKyv8JTziwXJBeSYBBPcR
         ANsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770289171; x=1770893971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=alMsRxewfJOS+guFyDR4XomPyiWRfrZzDa7uP0XKAlc=;
        b=fIb77NUdSgbi1Q7pQ4OtbrWEFTeegE9XypfxiGNVJGh+GOYjWkA/8vigAUiw2p1ISD
         ACggULnOfDKSiUIKmVurTYAytOa4m/b67wQEyaADu9XjXlbukD8dpgqstmbghWaRK35y
         BsvlmY2MFWhtc3lUNSiQjm5DnOkneSVuf36214YvbZx8IRAYrBEeG0QkpDg+0MNpeJa7
         61qpvjaXe9eOTRHqHUP4aKUXLWP7PkJdLCzEpXJw++Wd8wVz4ExXeDP7uCUd+uzgS3+e
         WoRY2dQ9+nodmO3AselaVC6cB8su0DF0Xod/Uj134qCgaQA6a/BFs1yh/LmUo9yitln5
         yEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289171; x=1770893971;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alMsRxewfJOS+guFyDR4XomPyiWRfrZzDa7uP0XKAlc=;
        b=kPaifQp0DpGHuHwyiBbCSoAToAHGGXYMGixk/U2NfkVox6ci18kYYyK2363Xiwt7nW
         UTyjyfkiXkYDgX4sBdjH/+sKF6rvxZrIzBoTU2QWhmdncQDhqbTJUi7XzmDaIBrNkcyp
         rbkvJEe3sYcf3gb0oi/WwgMqhYO7RV0aWKdPOY65v2EYV6rx0siDP+8gvnitCE+poIQH
         Sgrghvrg11Tt9ADo1sHKFq18l25BtvjXgWLVk6wgPZRbJDLjAJT/fLT8jjzXolw6i+j3
         oQNpcPrfQIa94PFaY4KYJL33THpBpy8M3vHSuRKfQolzh0yqctysPp4tVfhXbAyb2JWv
         gChw==
X-Forwarded-Encrypted: i=1; AJvYcCWJCjo9fo9dvNClUMfeb3ZfhwqmcUtKjwjOxPH9Fo7E2hLs1tBeIZME6qPKROqNL5TDgak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01DlHWrzm412CDykifK4p7juI6ZSAMTVETNFejVDLoP37X9Uo
	liMi4ClfHrKOI3WFydmA7dhaFoepbWpKBipFGSzNaUMQur7mAanEviXCLVdcME8OMvzW9vs80S5
	2Veib38aDHk6tauszXiUbY+nYxGij6tE=
X-Gm-Gg: AZuq6aLUfF5KrtA3O7Lm7DuoubrqCa6v2NkXROqWeLzd+ZGM0zcPwjc4G3Kv6T24kV6
	FEP8pdDBjUPrDCdhATf4GY0LC/8Yp3uv9f1BT9G3VwQhHjEMGbtXSJUCgBROXoCoieHz8MClOLa
	KEf2+H94OXWEkjuaYz0GMw+OwOcptRNtmMpnYjcJjbAiQL/Pk6+b+f3V7FNqRY8T9qcXMF17XPy
	4+IWGtvClYkDEjt4jPej7sxpmQyqEw9HKASTNNqW52VUsTlc8fhtx6pu5YWQyYY0i3OrOTj1v+0
	UN/apxsmjp8o/QIC+GZ+lvZnGbqFdQ==
X-Received: by 2002:a05:6102:2ac2:b0:5f5:3c96:983f with SMTP id
 ada2fe7eead31-5f93947defamr2121295137.1.1770289170749; Thu, 05 Feb 2026
 02:59:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 04:59:29 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 04:59:29 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260205101524.125452-2-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com> <20260205101524.125452-2-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Feb 2026 04:59:29 -0600
X-Gm-Features: AZwV_Qhp9eZjNawGypwrRimgg0p1xCCipc4SrVO81kLBR4uFQv32XMdfItkf85U
Message-ID: <CAOLa=ZQOzNrCkKzwG7CuH5Ge+OPZcT4i0cY9nRkAJZO6T_QZQw@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] wt-status: replace uses of the_repository with
 local repository instances
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000002c5128064a119104"

--0000000000002c5128064a119104
Content-Type: text/plain; charset="UTF-8"

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> wt-status.c uses the global the_repository in several places even when
> a repository instance is already available via struct wt_status or
> struct worktree.
>
> Replace these direct uses of the_repository with the repository carried
> by the local structs (e.g. s->repo, wt->repo).
>
> The replacements of all the_repository with s->repo are mostly
> to cases where a repository instance is already available via
> struct wt_status. All functions operating on struct wt_status *s
> are only used after s is initialized by wt_status_prepare(),
> which sets s->repo from the repository provided by the caller.
> As a result, s->repo is guaranteed to be available and consistent
> whenever these functions are invoked.
>
> This reduces reliance on global state and keeps wt-status consistent,
> though many functions operating on struct wt_status *s
> are called via commit.c and it still relies on the_repository,
> but within wt-status.c the local repository pointer
> refers to the same underlying repository object.
>
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
>  wt-status.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index e12adb26b9..f71addc35f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -150,11 +150,11 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
>  	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
>  	s->use_color = GIT_COLOR_UNKNOWN;
>  	s->relative_paths = 1;
> -	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
> +	s->branch = refs_resolve_refdup(get_main_ref_store(r),
>  					"HEAD", 0, NULL, NULL);
>  	s->reference = "HEAD";
>  	s->fp = stdout;
> -	s->index_file = repo_get_index_file(the_repository);
> +	s->index_file = repo_get_index_file(s->repo);
>  	s->change.strdup_strings = 1;
>  	s->untracked.strdup_strings = 1;
>  	s->ignored.strdup_strings = 1;
> @@ -646,7 +646,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>
>  	repo_init_revisions(s->repo, &rev, NULL);
>  	memset(&opt, 0, sizeof(opt));
> -	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;
> +	opt.def = s->is_initial ? empty_tree_oid_hex(s->repo->hash_algo) : s->reference;
>  	setup_revisions(0, NULL, &rev, &opt);
>
>  	rev.diffopt.flags.override_submodule_config = 1;
> @@ -1146,7 +1146,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
>  	rev.diffopt.ita_invisible_in_index = 1;
>
>  	memset(&opt, 0, sizeof(opt));
> -	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;
> +	opt.def = s->is_initial ? empty_tree_oid_hex(s->repo->hash_algo) : s->reference;
>  	setup_revisions(0, NULL, &rev, &opt);
>
>  	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
> @@ -1317,9 +1317,9 @@ static int split_commit_in_progress(struct wt_status *s)
>  	    !s->branch || strcmp(s->branch, "HEAD"))
>  		return 0;
>
> -	if (refs_read_ref_full(get_main_ref_store(the_repository), "HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +	if (refs_read_ref_full(get_main_ref_store(s->repo), "HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>  			       &head_oid, &head_flags) ||
> -	    refs_read_ref_full(get_main_ref_store(the_repository), "ORIG_HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +	    refs_read_ref_full(get_main_ref_store(s->repo), "ORIG_HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>  			       &orig_head_oid, &orig_head_flags))
>  		return 0;
>  	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
> @@ -1432,7 +1432,7 @@ static void show_rebase_information(struct wt_status *s,
>  				i++)
>  				status_printf_ln(s, color, "   %s", have_done.items[i].string);
>  			if (have_done.nr > nr_lines_to_show && s->hints) {
> -				char *path = repo_git_path(the_repository, "rebase-merge/done");
> +				char *path = repo_git_path(s->repo, "rebase-merge/done");
>  				status_printf_ln(s, color,
>  					_("  (see more in file %s)"), path);
>  				free(path);
> @@ -1534,7 +1534,7 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
>  	else
>  		status_printf_ln(s, color,
>  			_("You are currently cherry-picking commit %s."),
> -			repo_find_unique_abbrev(the_repository, &s->state.cherry_pick_head_oid,
> +			repo_find_unique_abbrev(s->repo, &s->state.cherry_pick_head_oid,
>  						DEFAULT_ABBREV));
>
>  	if (s->hints) {
> @@ -1564,7 +1564,7 @@ static void show_revert_in_progress(struct wt_status *s,
>  	else
>  		status_printf_ln(s, color,
>  			_("You are currently reverting commit %s."),
> -			repo_find_unique_abbrev(the_repository, &s->state.revert_head_oid,
> +			repo_find_unique_abbrev(s->repo, &s->state.revert_head_oid,
>  						DEFAULT_ABBREV));
>  	if (s->hints) {
>  		if (has_unmerged(s))
> @@ -1624,7 +1624,7 @@ static char *get_branch(const struct worktree *wt, const char *path)
>  	struct object_id oid;
>  	const char *branch_name;
>
> -	if (strbuf_read_file(&sb, worktree_git_path(the_repository, wt, "%s", path), 0) <= 0)
> +	if (strbuf_read_file(&sb, worktree_git_path(wt->repo, wt, "%s", path), 0) <= 0)
>  		goto got_nothing;
>

So if you look into `worktree_git_path()`, it has a certain check

  if (wt && wt->repo != r)
		BUG("worktree not connected to expected repository");

But this is okay with your change, the only question is, do we know wt
is always defined here? Unfortunately, wt can be NULL here, in the same
file we have:

  wt_status_check_rebase(NULL, state);
  -> get_branch(NULL, ...)

Which would crash, no? This is applicable for other parts of the code
too were we're now using wt->repo.

This is also what I was requesting in the previous round, about
explaining why it is safe to make a particular change.

[snip]

--0000000000002c5128064a119104
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c2c0b150f1df2800_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tRWVBd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUdRREFDZG1QdHIzNjdjVlI3VTZJN3hBMnF4ZnJrQwoyMEg0c3FoSCtK
S1NCY0Viam1QMFhnclBBMy9kQ2x6UEJLd3NZNS9MM211S0dFVTNuU0U0NU9tSEhvVUZWbGY2CjRN
WTFkWVNyeXNUMjJWTERGRGhmYVEwUnZTQnpldmRpeEw0M1cycVRwNXhZdjZCTnJ6SGNVS3RIQmp6
Q3BtN2oKQThDYXFxTmZTMTVoZ2x2UElCZkkrOFIvZStGeEsya3JpR3lNV0IyemJJUjEvbWNLbW1Y
T3NSTUY4djZSdkNhOAp4QUgvWmpSZkYybGltbFJjWkliVWR1V3JiTGJyZVE5V0RXZDQ1YkxXOWFq
TUtJK3RXdmFScHBzaDNSS2RYNWNaClJVUFZ3VWxMWjk0VDd2WlFaeXlRL1BheHRhSHVKU1BiUmxW
YWpLSnZkL05BRGFXVVphdnozVWhyY2tjSW1yV3QKdmtmWkJaQ1RiajZvckZHdEJjSkQ0clZuS2NQ
U2Rhb2dBVm5ZOWlWdzhRd2xrK2plZUVrelUxYWFEMkwwdWNQOApJNTl4ajc4ZU1YeUtZZmY0Z1NK
dnp6SEZjQ2I2aGZCSWVnck1lNDlQT2g5TVBnSWM5WGoyYU4vRldjeWZxY2xVCm01OGpIeUJLNHln
QVlhQytTNjJqSTBZZVZuMHpUYUViSGxjb1ZZQT0KPXcxTlEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002c5128064a119104--
