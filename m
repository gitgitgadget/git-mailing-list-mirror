Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722618;
	b=Q580Z9qWQPA5V+C5Mcfay5H5yyBDTI2s5yjLrxLGQsKZHC5VUUiYcE3wJwN8gWnYPNIP
	 lpR7Og13GMw1vKbpAho35sOd8GhPToepPYNHObm7HXVrbUDpAg83eoMg/y96nnOT6pnVx
	 hcgSA5XM3pO9hYTqJ1RU3UAwe3qGiEqln4HT/BBF4VY4HcnIrzg8rOJ4MkcC+inR+8pa3
	 65dwqYUOQaBoaxnoM2RhfsnBcKFcWFPKwqpwWXXRjjhOSABL6GihASdE+dHfyB2LNtj04
	 KoFV2h1I9MDgKRe1Akw3zEDkQoheU/kZhkT4HE1QoOrar5a7jZEjHs6WVSlyCWfOOFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DOw1juXiJEpApzGybbaMB5w+BIoGb8CZFROKEtFsTbQ=;
	b=G7D/RvDk3cY5frs2jxtug+AuRVGSVs5pYjbPuRk4al0qvlZXCEH1o9RnWGZs+b9+IY97
	 bz3uYCs3IM1T8TmJCJ2PnZICF6W25NtkcUuSfzpKvbOG5E6tHHRx/3HvJuM0+lkf5rRMB
	 Cg+oSA6CfroERNdoKwrZYlLxOzqukPCGLUoPHYHaphNAMb3b6IPCdasQ7cBHb9aWMsHnB
	 1bbh7MMPcnap+SMEmz4jmGKXvGcDoIhICEv4zJESPftsBrYxJ5vXrHmUd1eprd/cQfcuY
	 jZynfIXi4qCmVkFirU/3/yG2Tkbpb9Cu9i8ZTlzDDIY+kAjCBayNrEqRKB8/JjxLpRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ToHoWJEy;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493B7606A329
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 16:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 493B7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ToHoWJEy
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so45751815e9.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793722617; x=1794327417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DOw1juXiJEpApzGybbaMB5w+BIoGb8CZFROKEtFsTbQ=;
        b=ToHoWJEyVWIiu3CR4/7sA7eGO8OIWrd3eUEtQii31YSsrKE/cXZIaygooGwFw/sB0X
         /it1dy9rA+w95nCtAQNtQJ8kDovelKswNiBL9MjapAPAf2cFskUpWJF2IzDJX5pX5D1+
         FHKgV36rB75i+R+T3E5xinmeynnCYQxDSGagT8fFAhj6RI8HqYgWours45BfU+6lAPat
         bu9PnWl01KlAZVF/Cp785F8UAPVSRiPWPvPG68dOiszHYiiba8PrHEfcaaFVZAQzhU47
         OwgRe6MH3QT7BwUPlpMnMevEdeTO0KupI7xNdYqZp2152Vq0aWPngA1woVrUphcyxa/u
         KtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722617; x=1794327417;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOw1juXiJEpApzGybbaMB5w+BIoGb8CZFROKEtFsTbQ=;
        b=xSMxPFsygZzb0Ec5ptc8u6uZGNrEuD1bxCRUALCq4gaEQcEaM7sugfVbXNPLFD+BUe
         gfv7Mvz8cNS9GnlXPzr8xkC9aRLzYNa/Q6dthM4n7XDpIAio2unou0BbVScfh94/EPyY
         GQzU8hZ9501RPG7wD8BKgB2qnP3lGzPAdeWrmow4LsZ81LSMUNq8Z1ptlysyv8F8/wPi
         UpLNIMm/3WRsXD92rAg+aPFG66399xGzPLX6/14PB082Do2itq0MR6Mf9b45gmRbQd3W
         ELglXv8eERVZgebz0tqk0G/YaYwnUuzIj4CKPtwc+0YWv59ZXsIjXdMYdhn+y2Scl2e3
         RXLg==
X-Forwarded-Encrypted: i=1; AKwUvBwR8GQP1vD0OelJR6Ul985AThg5HsYzZH0ttGEX/4kLAmS/jIqCnSrNtpxuHVYKVcrV5Is=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VhtxDJ4LkdnSgiN0oFW0YNw0NIiLQoPABg9NHQe+iuJo2WjQV
	/xSa/+T83WbDIReVKdsHMEwSjCrW726+dGkzeUy0G/NIympTKUOmpMQ3
X-Gm-Gg: AYBFou1oS3Sizf3DbG11aIHMNXIGxALauoOjxDmGCrJv5Fnr5uHLEAdnWy2ko9ju6VC
	5QgryZAyj2Qyl1P2gZ3Rje7/xmiMnsdKkP8hNiTb+N41Ovz1HPG/+Q7kqaKcE/SkhN6g/70JCmF
	KIZNp6CGxr+m4b/HzL2g8imMv0EUm8q8OJ5PgCihSAu/kfslsxPU5rH+1P/Uh4JFwUrR1VPoigh
	CT2dk2Dp3Uvy6z3F7mShzHA3VXCIBQGM85FCRxqvUrlGwUNM1Tr4JE6T5vLffG8gYQ5kaG1bzAt
	F8HkQaFipaUeNm8smphokYMP/R30nFRk0scJqRZiqAVNv/IrhpC8EV/+fUO+8r5/iFg8Uhji8qK
	ceWhnt1OtTtzxo5JKUO2ZT14j5cyqmuYQN3oGesxGMknej4LMvcfFuW2vYp/z3dkHKWkwvU9b6A
	tQTz7ikrWvrsqZfRJBQq2j3esZSxWoJ810boUyUN9ZW2lREXs71oOXuQ2zBEa0kiZL7t93oTPue
	AFZF1Uwb01REsSIjS/cYjE2D6fR/s+H2zc92VIqV1p2odJnannEz4vE9AHJlq553dA7ulUAnUuw
	GXsR/Oi08+4nlJRzwD5zcws4Flg/6TS5+BjOk02Nx4MFMT3HUQsc5uSNghg9SSx+GGLsYaSm7Vl
	Q1KtxKWw7QNplzQID0z9YXgHAO1U=
X-Received: by 2002:a05:600c:64c5:b0:4a2:150f:1613 with SMTP id 5b1f17b1804b1-4ac17a367edmr318289675e9.7.1793722616464;
        Tue, 03 Nov 2026 08:16:56 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e86a06078sm10039111f8f.54.2026.11.03.08.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:16:55 -0800 (PST)
Message-ID: <49144eb0-9755-4843-930e-ae7b3b519080@gmail.com>
Date: Tue, 3 Nov 2026 16:16:54 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] pretty: add %gb to name the branch of each reflog
 entry
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v3.git.git.1793090327.gitgitgadget@gmail.com>
 <dee548f9b1ca11feef2d74d0384c5c3c2e6c20d7.1793090327.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <dee548f9b1ca11feef2d74d0384c5c3c2e6c20d7.1793090327.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 27/10/2026 08:38, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a "%gb" placeholder that names the branch HEAD was on when each
> entry was recorded:
> 
>      $ git log -g --format='%h %gd: (%gb) %gs'
>      9c8d7e6 HEAD@{0}: (topic) rebase (finish): returning to refs/heads/topic
>      9c8d7e6 HEAD@{1}: (topic) rebase (pick): add tests
>      1a2b3c4 HEAD@{2}: (topic) rebase (start): checkout main
>      1a2b3c4 HEAD@{3}: (main) commit: fix typo
>      5d6e7f8 HEAD@{4}: (main) checkout: moving from topic to main

Looks good

> The branch is read from the entries that branch switches, branch
> renames and rebases leave behind.

"the entries created by ..."?
> The entries of a rebase are named
> after the branch being rebased.

This sounds very LLM, "labelled with the branch being rebased"?

> When HEAD was detached, the entry
> shows "detached at <commit>" with the commit HEAD was at when it
> moved on.

I wondered if that was a bit verbose, but having tried it, it is no 
longer than some of my branch names.

> When nothing older in the reflog says which branch a rebase
> started on, the rebase is taken to have started on the branch it
> rebased. For the reflog of any other ref, "%gb" is the name of that
> ref.

I'm seeing some strange behavior when GIT_REFLOG_ACTION is set, below is 
the output of "git reflog --format='%h %gd %gs (%gb)'" for my local 
HEAD. I've added comments above the lines where the branch name is 
incorrect. The "sync switch" entries come from running "git rebase" with 
GIT_REFLOG_ACTION set.

be8e0d55ec HEAD@{0} reset: moving to HEAD (sequencer-delete-REBASE_HEAD)
be8e0d55ec HEAD@{1} sync switch: checkout sequencer-delete-REBASE_HEAD 
(sequencer-delete-REBASE_HEAD)
# should be fix-nth-prior-checkout
64822b4a3b HEAD@{2} sync switch: checkout fix-nth-prior-checkout 
(sequencer-delete-REBASE_HEAD)
# should be detached at 64882b4a3b
64822b4a3b HEAD@{3} rebase: fast-forward (sequencer-delete-REBASE_HEAD)
# should be detached at 64822b4a3b
bf19b60d89 HEAD@{4} rebase (start): checkout @^ 
(sequencer-delete-REBASE_HEAD)
64822b4a3b HEAD@{5} rebase: fast-forward (detached at 64822b4a3b)
bf19b60d89 HEAD@{6} rebase (start): checkout fix-nth-prior-checkout^ 
(detached at 64822b4a3b)
be8e0d55ec HEAD@{7} rebase: checkout sequencer-delete-REBASE_HEAD 
(sequencer-delete-REBASE_HEAD)
be8e0d55ec HEAD@{8} rebase (start): checkout 
sequencer-delete-REBASE_HEAD (detached at be8e0d55ec)
64822b4a3b HEAD@{9} checkout: moving from 
64822b4a3ba71e5a823002cd5ebe0fa5fb4b3a0c to fix-nth-prior-checkout 
(fix-nth-prior-checkout)

Thanks

Phillip

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   Documentation/pretty-formats.adoc |   3 +
>   pretty.c                          |   4 +
>   reflog-walk.c                     | 156 ++++++++++++++++++++++++++++--
>   reflog-walk.h                     |   2 +
>   t/t1414-reflog-walk.sh            | 122 +++++++++++++++++++++++
>   5 files changed, 281 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
> index 2ae0eb11a9..a8d00397c4 100644
> --- a/Documentation/pretty-formats.adoc
> +++ b/Documentation/pretty-formats.adoc
> @@ -334,6 +334,9 @@ endif::git-rev-list[]
>   +%gE+:: reflog identity email (respecting .mailmap, see
>   	linkgit:git-shortlog[1] or linkgit:git-blame[1])
>   +%gs+:: reflog subject
> ++%gb+:: reflog branch, the branch `HEAD` was on when the entry was
> +	recorded, e.g., `topic` or `detached at 1a2b3c4`. For the reflog
> +	of any other ref, this is the shortened refname.
>   ++%(trailers++`[:<option>,...]`++)++::
>   display the trailers of the body as interpreted by
>   linkgit:git-interpret-trailers[1]. The `trailers` string may be followed by
> diff --git a/pretty.c b/pretty.c
> index d8a9f370f6..1b3f7e2dc3 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1637,6 +1637,10 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>   			if (c->pretty_ctx->reflog_info)
>   				get_reflog_message(sb, c->pretty_ctx->reflog_info);
>   			return 2;
> +		case 'b':	/* reflog branch */
> +			if (c->pretty_ctx->reflog_info)
> +				get_reflog_branch(sb, c->pretty_ctx->reflog_info);
> +			return 2;
>   		case 'n':
>   		case 'N':
>   		case 'e':
> diff --git a/reflog-walk.c b/reflog-walk.c
> index 4dbeaa93a7..45b5dc09b5 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -3,7 +3,10 @@
>   #include "git-compat-util.h"
>   #include "commit.h"
>   #include "refs.h"
> +#include "reflog.h"
>   #include "diff.h"
> +#include "hex.h"
> +#include "object-name.h"
>   #include "repository.h"
>   #include "revision.h"
>   #include "string-list.h"
> @@ -18,8 +21,10 @@ struct complete_reflogs {
>   		timestamp_t timestamp;
>   		int tz;
>   		char *message;
> +		char *branch;
>   	} *items;
>   	int nr, alloc;
> +	bool branches_marked;
>   };
>   
>   static int read_one_reflog(const char *refname UNUSED,
> @@ -38,6 +43,7 @@ static int read_one_reflog(const char *refname UNUSED,
>   	item->timestamp = timestamp;
>   	item->tz = tz;
>   	item->message = xstrdup(message);
> +	item->branch = NULL;
>   	array->nr++;
>   	return 0;
>   }
> @@ -52,6 +58,7 @@ static void free_complete_reflog(struct complete_reflogs *array)
>   	for (i = 0; i < array->nr; i++) {
>   		free(array->items[i].email);
>   		free(array->items[i].message);
> +		free(array->items[i].branch);
>   	}
>   	free(array->items);
>   	free(array->ref);
> @@ -65,6 +72,113 @@ static void complete_reflogs_clear(void *util, const char *str UNUSED)
>   	free_complete_reflog(array);
>   }
>   
> +static char *branch_label(const char *name, size_t len,
> +			  const struct object_id *oid)
> +{
> +	if (name) {
> +		struct object_id hex_oid;
> +		char *branch;
> +
> +		if (skip_prefix(name, "refs/heads/", &name))
> +			len -= strlen("refs/heads/");
> +		branch = xmemdupz(name, len);
> +		if (strcmp(branch, "HEAD") && get_oid_hex(branch, &hex_oid) &&
> +		    !check_refname_format(branch, REFNAME_ALLOW_ONELEVEL))
> +			return branch;
> +		free(branch);
> +	}
> +	return xstrfmt("detached at %s",
> +		       repo_find_unique_abbrev(the_repository, oid,
> +					       DEFAULT_ABBREV));
> +}
> +
> +static const char *skip_rebase_step(const char *message, const char *step)
> +{
> +	const char *p = strstr(message, " (");
> +	const char *colon = strstr(message, ": ");
> +
> +	if (!p || (colon && colon < p) ||
> +	    !skip_prefix(p + 2, step, &p) || !skip_prefix(p, "): ", &p))
> +		return NULL;
> +	return p;
> +}
> +
> +struct branch_move {
> +	const char *from, *to;
> +	size_t from_len, to_len;
> +};
> +
> +static bool parse_branch_move(const char *message, struct branch_move *move)
> +{
> +	const char *to;
> +
> +	move->from = move->to = NULL;
> +	move->from_len = move->to_len = 0;
> +	if (skip_prefix(message, REFLOG_SWITCH_PREFIX, &move->from) ||
> +	    skip_prefix(message, REFLOG_RENAME_PREFIX, &move->from)) {
> +		to = strstr(move->from, " to ");
> +		if (!to)
> +			return false;
> +		move->from_len = to - move->from;
> +		move->to = to + strlen(" to ");
> +	} else if (((to = skip_rebase_step(message, REFLOG_STEP_FINISH)) ||
> +		    (to = skip_rebase_step(message, REFLOG_STEP_ABORT))) &&
> +		   skip_prefix(to, REFLOG_RETURNING_TO, &to)) {
> +		move->from = move->to = to;
> +		move->from_len = strcspn(to, "\n");
> +	} else if (skip_prefix(message, "rebase: " REFLOG_CHECKOUT, &to)) {
> +		move->to = to;
> +	} else if (!skip_rebase_step(message, REFLOG_STEP_START)) {
> +		return false;
> +	}
> +	if (move->to)
> +		move->to_len = strcspn(move->to, "\n");
> +	return true;
> +}
> +
> +static void mark_branches(struct complete_reflogs *array)
> +{
> +	struct ref_store *refs = get_main_ref_store(the_repository);
> +	struct object_id oid;
> +	const char *head = refs_resolve_ref_unsafe(refs, "HEAD", 0, &oid, NULL);
> +	char *branch = NULL;
> +	int unknown = array->nr;
> +
> +	if (head)
> +		branch = branch_label(head, strlen(head), &oid);
> +
> +	for (int i = array->nr - 1; i >= 0; i--) {
> +		struct reflog_info *item = &array->items[i];
> +		struct branch_move move;
> +
> +		if (!parse_branch_move(item->message, &move)) {
> +			item->branch = xstrdup_or_null(branch);
> +			continue;
> +		}
> +
> +		if (!branch) {
> +			branch = branch_label(move.to, move.to_len,
> +					      &array->items[unknown - 1].noid);
> +			for (int j = i + 1; j < unknown; j++)
> +				array->items[j].branch = xstrdup(branch);
> +		}
> +		item->branch = branch;
> +		if (move.from) {
> +			branch = branch_label(move.from, move.from_len,
> +					      &item->ooid);
> +		} else {
> +			branch = NULL;
> +			unknown = i;
> +		}
> +	}
> +
> +	if (!branch && unknown < array->nr)
> +		for (int i = 0; i < unknown; i++)
> +			array->items[i].branch =
> +				xstrdup(array->items[unknown].branch);
> +	free(branch);
> +}
> +
>   static struct complete_reflogs *read_complete_reflog(const char *ref)
>   {
>   	struct complete_reflogs *reflogs =
> @@ -234,6 +348,16 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
>   	return 0;
>   }
>   
> +static const char *short_ref(struct complete_reflogs *reflogs)
> +{
> +	struct ref_store *refs = get_main_ref_store(the_repository);
> +
> +	if (!reflogs->short_ref)
> +		reflogs->short_ref =
> +			refs_shorten_unambiguous_ref(refs, reflogs->ref, 0);
> +	return reflogs->short_ref;
> +}
> +
>   void get_reflog_selector(struct strbuf *sb,
>   			 struct reflog_walk_info *reflog_info,
>   			 struct date_mode dmode, int force_date,
> @@ -247,12 +371,7 @@ void get_reflog_selector(struct strbuf *sb,
>   		return;
>   
>   	if (shorten) {
> -		if (!commit_reflog->reflogs->short_ref)
> -			commit_reflog->reflogs->short_ref
> -				= refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
> -							       commit_reflog->reflogs->ref,
> -							       0);
> -		printed_ref = commit_reflog->reflogs->short_ref;
> +		printed_ref = short_ref(commit_reflog->reflogs);
>   	} else {
>   		printed_ref = commit_reflog->reflogs->ref;
>   	}
> @@ -287,6 +406,31 @@ void get_reflog_message(struct strbuf *sb,
>   	strbuf_add(sb, info->message, len);
>   }
>   
> +void get_reflog_branch(struct strbuf *sb,
> +		       struct reflog_walk_info *reflog_info)
> +{
> +	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
> +	struct complete_reflogs *reflogs;
> +	const char *branch;
> +
> +	if (!commit_reflog)
> +		return;
> +
> +	reflogs = commit_reflog->reflogs;
> +	if (strcmp(reflogs->ref, "HEAD")) {
> +		strbuf_addstr(sb, short_ref(reflogs));
> +		return;
> +	}
> +
> +	if (!reflogs->branches_marked) {
> +		mark_branches(reflogs);
> +		reflogs->branches_marked = true;
> +	}
> +	branch = reflogs->items[commit_reflog->recno+1].branch;
> +	if (branch)
> +		strbuf_addstr(sb, branch);
> +}
> +
>   const char *get_reflog_ident(struct reflog_walk_info *reflog_info)
>   {
>   	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
> diff --git a/reflog-walk.h b/reflog-walk.h
> index 989583dc55..fc1f344ce6 100644
> --- a/reflog-walk.h
> +++ b/reflog-walk.h
> @@ -13,6 +13,8 @@ void show_reflog_message(struct reflog_walk_info *info, int,
>   			 struct date_mode, int force_date);
>   void get_reflog_message(struct strbuf *sb,
>   			struct reflog_walk_info *reflog_info);
> +void get_reflog_branch(struct strbuf *sb,
> +		       struct reflog_walk_info *reflog_info);
>   const char *get_reflog_ident(struct reflog_walk_info *reflog_info);
>   timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info);
>   void get_reflog_selector(struct strbuf *sb,
> diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
> index be6c3f472c..0e821922ca 100755
> --- a/t/t1414-reflog-walk.sh
> +++ b/t/t1414-reflog-walk.sh
> @@ -131,6 +131,128 @@ test_expect_success 'walk prefers reflog to ref tip' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success '%gb names the branch HEAD was on' '
> +	git init branches &&
> +	(
> +		cd branches &&
> +		test_commit base &&
> +		git switch -c topic &&
> +		test_commit A &&
> +		test_commit B &&
> +		git switch main &&
> +		test_commit upstream &&
> +		git switch topic &&
> +		git rebase main &&
> +
> +		cat >expect <<-\EOF &&
> +		(topic) rebase (finish): returning to refs/heads/topic
> +		(topic) rebase (pick): B
> +		(topic) rebase (pick): A
> +		(topic) rebase (start): checkout main
> +		(topic) checkout: moving from main to topic
> +		(main) commit: upstream
> +		(main) checkout: moving from topic to main
> +		(topic) commit: B
> +		(topic) commit: A
> +		(topic) checkout: moving from main to topic
> +		(main) commit (initial): base
> +		EOF
> +		git log -g --format="(%gb) %gs" >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success '%gb names the ref of other reflogs' '
> +	(
> +		cd branches &&
> +		echo main >expect &&
> +		git log -g -1 --format=%gb main >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success '%gb follows "git rebase <upstream> <branch>"' '
> +	(
> +		cd branches &&
> +		git switch main &&
> +		test_commit main-change &&
> +		git rebase main topic &&
> +		git switch main &&
> +		git rebase main topic &&
> +
> +		cat >expect <<-\EOF &&
> +		(topic) rebase: checkout topic
> +		(main) checkout: moving from topic to main
> +		(topic) rebase (finish): returning to refs/heads/topic
> +		(topic) rebase (pick): B
> +		(topic) rebase (pick): A
> +		(topic) rebase (start): checkout main
> +		(main) commit: main-change
> +		(main) checkout: moving from topic to main
> +		EOF
> +		git log -g -8 --format="(%gb) %gs" >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success '%gb names a detached HEAD by the commit it was left at' '
> +	(
> +		cd branches &&
> +		git switch --detach topic~1 &&
> +		test_commit detached &&
> +		git rebase topic &&
> +		rebased=$(git rev-parse HEAD) &&
> +		git switch topic &&
> +
> +		left_before=$(git rev-parse --short detached) &&
> +		left_after=$(git rev-parse --short $rebased) &&
> +		cat >expect <<-EOF &&
> +		(topic) checkout: moving from $rebased to topic
> +		(detached at $left_after) rebase (pick): detached
> +		(detached at $left_after) rebase (start): checkout topic
> +		(detached at $left_before) commit: detached
> +		(detached at $left_before) checkout: moving from topic to topic~1
> +		EOF
> +		git log -g -5 --format="(%gb) %gs" >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success '%gb names the branch of a "git pull --rebase" in a fresh clone' '
> +	git clone branches downstream &&
> +	(
> +		cd branches &&
> +		test_commit upstream-change
> +	) &&
> +	(
> +		cd downstream &&
> +		test_commit local-change &&
> +		git pull --rebase &&
> +
> +		echo "(topic)" >expect &&
> +		git log -g --format="(%gb)" >out &&
> +		sort -u out >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success '%gb follows a renamed branch' '
> +	(
> +		cd branches &&
> +		test_commit before-rename &&
> +		git branch -m topic renamed &&
> +		test_commit after-rename &&
> +
> +		cat >expect <<-\EOF &&
> +		(renamed) commit: after-rename
> +		(renamed) Branch: renamed refs/heads/topic to refs/heads/renamed
> +		(topic) commit: before-rename
> +		EOF
> +		git log -g -3 --format="(%gb) %gs" >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>   test_expect_success 'rev-list -g complains when there are no reflogs' '
>   	test_must_fail git rev-list -g
>   '

