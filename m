Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A91465B4
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771350386; cv=pass; b=HpbLBuRmf3pR1EylJJdrrIuUrd4OqwEPFQyFfq6yhrvVcenFmbugMzyHnt3tvvUNJGXyVIjwe/+wNw5lkS1FyKUJ6bM4L1fmI20AyfNLusyGyNMjT2LUMRFa8+OsL61BsRFQO0FoYnHuucrj04SAJnQi74l9L41DNFy5UV4F7rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771350386; c=relaxed/simple;
	bh=QGgmRAs5Z2lQBwCUxMm/um82j3ehLgZ4NdExmJV8mzM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwXY/6NfIi0KKgNqdKflmH9aOQu6YQzE+OxiJHJ/BXGRzUxhV1zjA18ypqOjLb+HCedK0u/9X0BiDOFGLNMv5W8kKHmZEiGfyL/1ZulY12fDlBoGHdctCLDHi0zcJEG8vqf4imR1ljBGyGqeS/GWkYSKWH2DGdROw9GZUh0+6wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0LOWjwS; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0LOWjwS"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso2038288241.2
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:46:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771350383; cv=none;
        d=google.com; s=arc-20240605;
        b=AYbkMVBESi5LV1qEWxAq4hIGNuazEPTcz/dFoLAMBmOQ3bUloQFRrC+PHs9Vwg1zKJ
         9D492UqSJZ4e/FPfxdCN+aROv+Smzyhi3F1a6zuGEmVmKUkx0ohgvckvYdC+oHNKHIGw
         Sqq4iK4NVCI1WR8oTnfhKgLsfrPhfyoMiL+q3zrzy1V8z7JbScLly54E3teZVLCaZ0wO
         aBPrPWWivAKdMedY9HJahMLt9GfB4W2Vfc+4WyzXZIjC2m5LaDnDgqKEaUUtHvdMxm+E
         0QSPVtRON738qU/gL9i8lrUoEmc6AwdqDoz3fSmdGGC1Q/LHL6lsr/NpvkQOTye/DGG0
         3dkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=V/QDlahLuKK/2RIAb18AepPz8RhZWbvVLTsWpclMWSw=;
        fh=ncJL8QFL24pXObNXVmT4WP7xerkhmzz9fsHm+sYhJj8=;
        b=ZT+cKUPMShiiMfTMTy7ZzaxoRLZBJIDr7kor/lbTDb6cqcAwi4s97DfWjuyiaSFEGP
         AQVvaTSWUTVWHU/aheBiAdldlf226fkIpLNfI/a3etMG/wd5HTi5njWhlWNrngbSe1sP
         a6/kACQuAjZ73T3fAdR3R6rhtVBDm6xyZ5Oe1P7gAWsi+9wMIFR6eTOvi/czDUKVDXUI
         nTfauhm3IDfz6A7Z2KCUGx1yJHjO8eVrZsOsF4sbfXVBtZg8oqU0fbpXn5ynfm0yAsK+
         vMWHxOg+0+5ba6sl06lrTThL7rcaVMksRYbJuAofdG0CW6wJStfjd3bl5cV24waUs1Vd
         uItw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771350383; x=1771955183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/QDlahLuKK/2RIAb18AepPz8RhZWbvVLTsWpclMWSw=;
        b=I0LOWjwSq0eTO1zhVQj1kWN5YmkzW3EB8zcbl5uhY4B80f4v4oeEKYB/QeDpAxP3FS
         5uEJH9aQklTYOBllsghjuSIzou5fzfWpnq+qTNe7RPddB5g35jbJpsagTA5cU8r8jjRz
         5t5XMW6cULRvwV02nn7LNbxmcFxHxbKOTPg9MAA5Wlu0vAU/pr5YD7JHXOVHqtwqwJEv
         1cYySpwkV6SaV8UEmkJWn5ZGM23UK8aQfN3sVlXInRI5iVXjTsOf9vtENlSuxHdiYoea
         TYZALFdd6YytGF6887ZHYAHJmtER5NfhkjDr4BJzrym12GqFRO6snQe2iPGZFIS18jrc
         npvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771350383; x=1771955183;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/QDlahLuKK/2RIAb18AepPz8RhZWbvVLTsWpclMWSw=;
        b=dG0UP9ivB9ATq1uCN9EszJVvG+fnaKeftQJCatv5kEezgbAUwEp57TOQoAzNIw5rl4
         Hh47t+sfV7Gz+hUWomIEgT/QNWA4wv20/HV+D1rUdb58zjonxWFraTcMVoavezaCefIE
         hz4oUdDfHSt0B5ky5CSGk/lON7RwpkURdV+gbhsPpTYNmMiifqBabrRI+YibnXpI7aKM
         MtmPm5sa41z+aP1BDL4rkJegurSf8esefLfO34nICaaefziJMnjD6nd+4DtKYAdkhZKc
         Oq81MEBykUQHLX2jSrdJ4lx9kw8YhKQItNE1lg65EKYeuPWehtXYCrE81+Beo8d/5BvA
         0Dtw==
X-Forwarded-Encrypted: i=1; AJvYcCW2gfDemIqcv4ifzFd+y4QSYH4s6Wxy9qhdn9hWvKn8FVbiBrWBpSOSiwvrY6I3erzbRTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQY0KSdlGyoD6dgcbyz6kr74i0Of0rr5+FFlKhYLuXrzXCoi41
	F58eqvOWh+RosMdF/nbaGKwuRHJ0HdeWb8Ua0JjaNTrw0K7CqVkmzsOTTEJYDjj4cQpv3UZcKO1
	vwFO6NIp0YEH2e6ouPg5/REWzvSkjlUQ=
X-Gm-Gg: AZuq6aK6Lpy04E0u8vU4SMhab92RonOqVEdy5s8TAxTR6pe4jG5uPfY10ax+HrayWb7
	9yknUNiDWU6w8uFxCABc0nbN70pxZr42u0hik/lt3iXuyBoPKR+2qSJrY5RR01/gNpZqvrTnr4Q
	dwzYIkmC+BsYVvA/cduEwTO1RZ6JOucjxMjGN1JT0uhfNo+ik32oygzBtq6/MSgubTm/Gou8QeG
	I+3hQrs7IHvVdyFL2r7pd/xKQVpT4PHwrILpmAJUOgm1u3Q94lMl/2szE30h67cTHUR4sg/BHKU
	zk0pWSQbasTUmAca8XE0+TgPyqnYvBmctCVruSNDaSTyBqKtR6/R
X-Received: by 2002:a05:6102:149d:b0:5fd:ea66:92e5 with SMTP id
 ada2fe7eead31-5fe2af575f8mr4552121137.22.1771350383352; Tue, 17 Feb 2026
 09:46:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 09:46:21 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 09:46:21 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <409871a7d521b76c9eb811d3c49747e04de8defc.1771258688.git.phillip.wood@dunelm.org.uk>
References: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
 <cover.1771258688.git.phillip.wood@dunelm.org.uk> <409871a7d521b76c9eb811d3c49747e04de8defc.1771258688.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Feb 2026 09:46:21 -0800
X-Gm-Features: AaiRm52cHGvYzrMsGRHMPulcVFNLYKzsWktTzf3f2ZmaWCCfGXce4RCQqHVDg2A
Message-ID: <CAOLa=ZQKLqFn4w3s7PD87FZ_120gohoqKX5c3uLKo2vASsbxfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] wt-status: avoid passing NULL worktree
To: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005f87af064b08a624"

--0000000000005f87af064b08a624
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> In preparation for removing the repository argument from
> worktree_git_path() add a function to construct a "struct worktree"
> from a "struct repository" and use that to avoid passing a NULL
> worktree to wt_status_check_bisect() and wt_status_check_rebase().
>

Okay this makes sense, I'm curious how 'wt->id = NULL' is going to be
handled. Let's see

> wt_status_check_bisect() and wt_status_check_rebase() have the following
> callers:
>
>  - branch.c:prepare_checked_out_branches() which loops over all
>    worktrees.
>
>  - worktree.c:is_worktree_being_rebased() which is called from
>    builtin/branch.c:reject_rebase_or_bisect_branch() that loops over all
>    worktrees and worktree.c:is_shared_symref() which dereferences wt
>    earlier in the function.
>
>  - wt-status:wt_status_get_state() which is updated to avoid passing a
>    NULL worktree by this patch.
>
> This updates the only callers that pass a NULL worktree to
> worktree_git_path().
>

I was thinking surely there must be other places where we also pass NULL
for worktree, but doesn't seem like there are any such instances.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  worktree.c  | 20 ++++++++++++++++++++
>  worktree.h  |  5 ++++-
>  wt-status.c | 15 ++++++++++++---
>  3 files changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/worktree.c b/worktree.c
> index 9308389cb6f..fd182c319b7 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -66,6 +66,26 @@ static int is_current_worktree(struct worktree *wt)
>  	return is_current;
>  }
>
> +struct worktree *get_worktree_from_repository(struct repository *repo)
> +{
> +	struct worktree *wt = xcalloc(1, sizeof(*wt));
> +	char *gitdir = absolute_pathdup(repo->gitdir);
> +	char *commondir = absolute_pathdup(repo->commondir);
> +
> +	wt->repo = repo;
> +	if (repo->worktree)
> +		wt->path = absolute_pathdup(repo->worktree);

Shouldn't this always be set? I guess my question is, will
`repo->worktree` ever be NULL?

> +	wt->is_bare = !!repo->worktree;
> +	if (fspathcmp(gitdir, commondir))
> +		wt->id = xstrdup(find_last_dir_sep(commondir) + 1);

So here we continue to treat NULL as the main worktree. Okay.

> +	wt->is_current = is_current_worktree(wt);

Since we're getting the worktree from the repo, shouldn't this be
'true'?

> +	add_head_info(wt);
> +
> +	free(gitdir);
> +	free(commondir);
> +	return wt;
> +}
> +
>  /*
>  * When in a secondary worktree, and when extensions.worktreeConfig
>  * is true, only $commondir/config and $commondir/worktrees/<id>/
> diff --git a/worktree.h b/worktree.h
> index e4bcccdc0ae..b162bbabd50 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -38,7 +38,10 @@ struct worktree **get_worktrees(void);
>   */
>  struct worktree **get_worktrees_without_reading_head(void);
>
> -/*
> +/* Construct a struct worktree from a struct repository */
> +struct worktree *get_worktree_from_repository(struct repository *repo);
> +
> + /*

Nit: extra space?

>   * Returns 1 if linked worktrees exist, 0 otherwise.
>   */
>  int submodule_uses_worktrees(const char *path);

[snip]

--0000000000005f87af064b08a624
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d36989b7941c79ae_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVXFXd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1ZJQy85YkMzUnNiV0cwaHNnMFlZbHlZSTNnWDdWTApac2t0NWk2TGdu
WnpxdkY1dlRMWFA1ajF0UlpCTU9zbXIzYmJLMWp4RVUxRmROQURIMm5aL3dyK0dWb3drODdaCmFY
QkxsWlJpb29wS1pjbk9QcnhuZE0wUFVDSG84WVRPZjlXVGt1V3NzakpuWS83SHlUdTBydU1aYUxV
TEY2WmsKQkxuWEgrYk43U3l2QlVJYzFpSWc4N1J6YmN4b0pRMm1JeFN6bi9ERk1LSWpsT0hUT21P
eFcxY0EwMU0wVTBRUQpabWF4SlpvRkhzbjFxRUFGODZJcWhzZWRDcVFYY1NKaXZQbno2cjlsMVZV
WGxMbTdJaW9lOUpwd0FSYm5SWU5KCmJPWklqWjYxU3lRVk9YdkpEMFBVaUtST2NMQTltcXlqNHlX
YjZZdUh4Tkl0bVFtbDZzTHVpb1ZCZjQ3S3BXblUKUk9UVGNoNmNYS0NoczZYbTRVaFJwK2ZPaDdQ
aDZtNk52cm1PbXk1eXE0cmQ5MUlRa0pkMHVVME5GdmVNT2s4aAp0QTVNanFtYnhYZzMzR2lIcHo1
RlFYVElrZGovbTVPSnNMSDhQYXFSZUlQU2tFQTdrV2hiOEgvUGlaNGZJTXQ4Cm5pMlY1TUJtRTR5
UUlkRTMzeFJmMVNoSkF3bERSbHduRkdDNk93Yz0KPWRROUsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005f87af064b08a624--
