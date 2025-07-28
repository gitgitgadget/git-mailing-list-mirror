Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC9A21FF36
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728791; cv=none; b=I8L8gIOwWtn4NdSkPVkgD1zkmgXTXPPF8FTsjoz6p6w8j9s/Dna+4wlgHhXMtT0W0SMrGb59c5q5ZIbPAn9WB1Ulw5uWW7WQzziYt0hhPhQ0L7hCJUU0ojFkKypRiuC/9st1nDGvqozd3793rAoJyTFN3lMwYeiGGwtXaRafw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728791; c=relaxed/simple;
	bh=oY6KvxgtyO1OMZ6qVQDUkyuvHHD517rAWO6z4P6ZT5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7AGI68a9A/QhQwLLm426TXzMXAUv7MZOi5G8/KKC9cbCjJyi7VMqcOOAlMCGwTArLJ2Y8Pluk2yed+edoiLJdUbg4+YOnrCojT9yONI2GBwSLHQFVBkPNU2TI6ZdC3DhuOTP6ad07URvNpeqhPNvYRmXdXyT1C7Dimc4pLysd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1Op9xQu; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1Op9xQu"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3005517e7d0so1304278fac.0
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753728789; x=1754333589; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tT/pMGMfXj0d+R2q6B26gptslTDMM2A++bZqWj0cUeQ=;
        b=H1Op9xQu7TyDY7pLo7EYRC8rHUh3zjd6aJ4LAvC6opdzXYd4+44t5mU3u1fFn6Q5wc
         Y26D6CEAm4NCmwYk398tDZ1IkuQzqnHba/+DlTpPiWDd6tTnwKE0p1rrFzgvDFcwTukO
         Aaj23u0yuFcdtiH1fppkP41Q8j1aAE8kdBmoR86siU9IRwyvI/XePkcAr3yhLTZx/TB7
         km5/sBd2d0r0FwRD3+iue/1yd04EgrM7r2CiZgssGTA2tsTddfDg9ZGKucsPPAxofTOf
         ZDkHeL8CA5UZ/V8nW3td9lYq+Il73Xrj3PV9oHtitYH0jfLknNWMMJ98A0ssTLJ8hmLa
         k4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753728789; x=1754333589;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tT/pMGMfXj0d+R2q6B26gptslTDMM2A++bZqWj0cUeQ=;
        b=MLBRQE99GJR6LrxHYmgB0MjIhpdxRVxQfQYVEW6yQ5AyVPcOIMhHdYVDCFIN0JKFjV
         Yje10UV/s4C18txp9M84WTPVcfmyVgrBRSA6omrO9sOVe3KvKuVAEYcjuq0Cu+pPVFoo
         h1DkwhRwSnJcAM60Hxbjjm03vmxg8VaHLPFdQAGRburtEeO5Qkjcu6a8Djd1/Q6dyBX7
         s/mYdbjAf520+KyDR43k98yZVqARIeJ/vAp+es08HWCVThyH5WJEoaUPrp88B+UVH6qb
         0A2f9YQsxsHfcvRdheymmlP0wEt0qnyw80LWv2iCsc7vWHqKEgaEkPcejIzyrouKUlso
         F1dg==
X-Gm-Message-State: AOJu0YxHUb3I3PFSlBwRR0LTFqhkIpvYBsI3QkllXrpfqsJaNjdutgel
	g/2Ff/PtQhlrJ8lGpcjE8ZOvsWdJy+/3EgCyVvwf8PLGzm73pjeUsRPb
X-Gm-Gg: ASbGncvEtzh69eSpZf6tZ9vk+QONe/eMyawDSu/aBM2KOT+14poII7JohBupWra0DQj
	7YKdJjtmzSEBrPkQzaD1KWyu6PyPv7mVpr372c+nuHz60Vf3k9SlBac3tQ1tXsUVgITAR5URldk
	5RSznTYN9Q0ow8CnbNwG/r2KxR/Gn0YC/QJq3/6FAfg6L7nC44bp7/3xbXwFLH/IfsHCbOpDMGx
	NtmJ/gFUWFW4ygHWuK+YD66DUs089+PT5hfeP+9XQf55e33iLOGgginaSB5o9lQj4oE+4Gt/Vcf
	2usWFNb91q7Qomqynjxdug1z3Pw7tM2D8JChvUHGgGf4BJuMXwhrKEG2X3BiQQEWO6W+Z5l/YA2
	xSyeQSVazlb05i9E=
X-Google-Smtp-Source: AGHT+IGkoRMTLjGQNlb7DKAuTq5TvnMycqpcYtodY1PkPQ8lwDfCFjMmsVq3LKeyaOVEIKNZuiutQw==
X-Received: by 2002:a05:6870:1d4:b0:29e:766d:e969 with SMTP id 586e51a60fabf-30701d57701mr8089810fac.10.1753728788340;
        Mon, 28 Jul 2025 11:53:08 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-307135a4325sm1815764fac.26.2025.07.28.11.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 11:53:07 -0700 (PDT)
Date: Mon, 28 Jul 2025 13:47:13 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Jeff King <peff@peff.net>, Han Jiang <jhcarl0814@gmail.com>
Subject: Re: [PATCH 3/4] builtin/remote: rework how remote refs get renamed
Message-ID: <j75h4trgwn5dvvxy6cqjv6pbh5ernehvnoi5itqr3icogebegp@ldbsvfwtxoeo>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
 <20250728-pks-remote-rename-improvements-v1-3-f654f2b5c5ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-3-f654f2b5c5ae@pks.im>

On 25/07/28 03:08PM, Patrick Steinhardt wrote:
> It was recently reported [1] that renaming a remote that has dangling
> symrefs is broken. This issue can be trivially reproduced:
> 
>     $ git init repo
>     Initialized empty Git repository in /tmp/repo/.git/
>     $ cd repo/
>     $ git remote add origin /dev/null
>     $ git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/master
>     $ git remote rename origin renamed
>     $ git symbolic-ref refs/remotes/origin/HEAD
>     refs/remotes/origin/master
>     $ git symbolic-ref refs/remotes/renamed/HEAD
>     fatal: ref refs/remotes/renamed/HEAD is not a symbolic ref
> 
> As one can see, the "HEAD" reference did not get renamed but stays in
> the same place. There are two issues here:
> 
>   - We use `refs_resolve_ref_unsafe()` to resolve references, but we
>     don't pass the `RESOLVE_REF_NO_RECURSE` flag. Consequently, if the
>     reference does not resolve, the function will fail and we thus
>     ignore this branch.
> 
>   - We use `refs_for_each_ref()` to iterate through the old remote's
>     references, but that function ignores broken references.
> 
> Both of these issues are easy to fix. But having a closer look at the
> logic that renames remote references surfaces that it leaves a lot to be
> desired overall.
> 
> The problem is that we're using O(|refs| + |symrefs| * 2) many reference
> transactions to perform the renames. We first delete all symrefs, then
> individually rename every direct reference and finally we recreate the
> symrefs. On the one hand this isn't even remotely an atomic operation,
> so if we hit any error we'll already have deleted all references.
> 
> But more importantly it is also extremely inperformant. The number of

s/inperformant/inefficient/

> transactions for symrefs doesn't really bother us too much, as there
> should generally only be a single symref anyway ("HEAD"). But the
> renames are very expensive:
> 
>   - For the "reftable" backend we perform auto-compaction after every
>     single rename, which does add up.
> 
>   - For the "files" backend we potentially have to rewrite the
>     "packed-refs" file on every single rename in case they are packed.
>     The consequence here is quadratic runtime performance. Renaming a
>     100k references takes hours to complete.
> 
> Ideally we'd refactor the code to use a single transaction to perform
> all the reference updates atomically. But unfortunately that does not
> work in the case where you rename a remote so that it becomes nested
> into itself, as that can lead to conflicting reference updates.

Ok so we use two transactions to avoid D/F conflicts which could be
caused by something like: `git remote rename foo foo/bar`.

> The next-best thing is to do it in two transactions: one to delete all
> the references, and one to recreate the references and their reflogs.
> This signicantly speeds up the operation with the "files" backend. The
> following benchmark renames a remote with 10000 references:

We still have the problem of not being fully atomic here since the first
transaction could commit and delete the references, but the second
transaction fail. While unfortunate, this still leaves us better off
since there are fewer transactions being created.

> 
>     Benchmark 1: rename remote (refformat = files, revision = HEAD~)
>       Time (mean ± σ):     238.770 s ± 13.857 s    [User: 91.473 s, System: 143.793 s]
>       Range (min … max):   204.863 s … 247.699 s    10 runs
> 
>     Benchmark 2: rename remote (refformat = files, revision = HEAD)
>       Time (mean ± σ):      2.103 s ±  0.036 s    [User: 0.360 s, System: 1.313 s]
>       Range (min … max):    2.011 s …  2.141 s    10 runs
> 
>     Summary
>       rename remote (refformat = files, revision = HEAD) ran
>       113.53 ± 6.87 times faster than rename remote (refformat = files, revision = HEAD~)
> 
> For the "reftable" backend we see a significant speedup, as well, but
> given that we don't have quadratic runtime behaviour there it's way less
> extreme:
> 
>     Benchmark 1: rename remote (refformat = reftable, revision = HEAD~)
>       Time (mean ± σ):      8.604 s ±  0.539 s    [User: 4.985 s, System: 2.368 s]
>       Range (min … max):    7.880 s …  9.556 s    10 runs
> 
>     Benchmark 2: rename remote (refformat = reftable, revision = HEAD)
>       Time (mean ± σ):      1.177 s ±  0.103 s    [User: 0.446 s, System: 0.270 s]
>       Range (min … max):    1.023 s …  1.410 s    10 runs
> 
>     Summary
>       rename remote (refformat = reftable, revision = HEAD) ran
>         7.31 ± 0.79 times faster than rename remote (refformat = reftable, revision = HEAD~)

Nice speedup :)

> While at it, fix the handling of symbolic/broken references by using
> `refs_for_each_rawref()`. Add tests that cover both this reported issue
> and tests that verify that nesting remotes into itself continues to work
> with conflicting references.
> 
> One thing to note: with this change we cannot provide a proper progress
> monitor anymore as we queue the references into the transactions as we
> iterate through them. Consequently, as we don't know yet how many refs
> there are in total, we cannot report how many percent of the operation
> is done anymore. But that's a small price to pay considering that you
> now shouldn't need the progress monitor in most situations at all
> anymore.
> 
> [1]: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>
> 
> Reported-by: Han Jiang <jhcarl0814@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/remote.c  | 280 ++++++++++++++++++++++++++++++++++++------------------
>  t/t5505-remote.sh |  71 ++++++++++++++
>  2 files changed, 259 insertions(+), 92 deletions(-)
> 
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 5dd6cbbaeed..b1c55909184 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -3,7 +3,9 @@
>  
>  #include "builtin.h"
>  #include "config.h"
> +#include "date.h"
>  #include "gettext.h"
> +#include "ident.h"
>  #include "parse-options.h"
>  #include "path.h"
>  #include "transport.h"
> @@ -612,36 +614,148 @@ static int add_branch_for_removal(const char *refname,
>  struct rename_info {
>  	const char *old_name;
>  	const char *new_name;
> -	struct string_list *remote_branches;
> -	uint32_t symrefs_nr;
> +	struct ref_transaction *tx_create;
> +	struct ref_transaction *tx_delete;
> +	struct progress *progress;
> +	uint32_t progress_nr;
> +	struct strbuf *buf1, *buf2, *buf3, *err;

My understanding is that these strbuf are stored here as an optimization
so they can be reused. It looks like, in the context of the associated
callback though, `buf2` and `buf3` and only used for `name` and `mail`
respectively. I wonder if we could be better off calling them that to be
more explicit.

> +	struct strbuf *new_refname;
> +	uint64_t index;
>  };
>  
> -static int read_remote_branches(const char *refname, const char *referent UNUSED,
> -				const struct object_id *oid UNUSED,
> -				int flags UNUSED, void *cb_data)
> +static void renamed_refname(struct rename_info *rename,
> +			    const char *refname,
> +			    struct strbuf *out)
> +{
> +	strbuf_reset(out);
> +	strbuf_addstr(out, refname);
> +	strbuf_splice(out, strlen("refs/remotes/"), strlen(rename->old_name),
> +		      rename->new_name, strlen(rename->new_name));
> +}
> +
> +static int rename_one_reflog_entry(const char *old_refname UNUSED,
> +				   struct object_id *old_oid,
> +				   struct object_id *new_oid,
> +				   const char *committer,
> +				   timestamp_t timestamp, int tz,
> +				   const char *msg, void *cb_data)
>  {
>  	struct rename_info *rename = cb_data;
> -	struct strbuf buf = STRBUF_INIT;
> -	struct string_list_item *item;
> -	int flag;
> -	const char *symref;
> -
> -	strbuf_addf(&buf, "refs/remotes/%s/", rename->old_name);
> -	if (starts_with(refname, buf.buf)) {
> -		item = string_list_append(rename->remote_branches, refname);
> -		symref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> -						 refname, RESOLVE_REF_READING,
> -						 NULL, &flag);
> -		if (symref && (flag & REF_ISSYMREF)) {
> -			item->util = xstrdup(symref);
> -			rename->symrefs_nr++;
> -		} else {
> -			item->util = NULL;
> -		}
> +	struct strbuf *identity = rename->buf1;
> +	struct strbuf *name = rename->buf2;
> +	struct strbuf *mail = rename->buf3;
> +	struct ident_split ident;
> +	const char *date;
> +	int error;
> +
> +	if (split_ident_line(&ident, committer, strlen(committer)) < 0)
> +		return -1;
> +
> +	strbuf_reset(name);
> +	strbuf_add(name, ident.name_begin, ident.name_end - ident.name_begin);
> +	strbuf_reset(mail);
> +	strbuf_add(mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
> +
> +	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
> +	strbuf_reset(identity);
> +	strbuf_addstr(identity, fmt_ident(name->buf, mail->buf,
> +					  WANT_BLANK_IDENT, date, 0));
> +
> +	error = ref_transaction_update_reflog(rename->tx_create, rename->new_refname->buf,
> +					      new_oid, old_oid, identity->buf, msg,
> +					      rename->index++, rename->err);
> +
> +	return error;
> +}
> +
> +static int rename_one_reflog(const char *old_refname,
> +			     const struct object_id *old_oid,
> +			     struct rename_info *rename)
> +{
> +	struct strbuf *message = rename->buf1;
> +	int error;
> +
> +	if (!refs_reflog_exists(get_main_ref_store(the_repository), old_refname))
> +		return 0;
> +
> +	error = refs_for_each_reflog_ent(get_main_ref_store(the_repository),
> +					 old_refname, rename_one_reflog_entry, rename);
> +	if (error < 0)
> +		return error;
> +
> +	/*
> +	 * Manually write the reflog entry for the now-renamed ref. We cannot
> +	 * rely on `rename_one_ref()` to do this for us as that would screw
> +	 * over order in which reflog entries are being written.
> +	 *
> +	 * Furthermore, we only append the entry in case the reference
> +	 * resolves. Missing references shouldn't have reflogs anyway.
> +	 */
> +	strbuf_reset(message);
> +	strbuf_addf(message, "remote: renamed %s to %s", old_refname,
> +		    rename->new_refname->buf);
> +
> +	error = ref_transaction_update_reflog(rename->tx_create, rename->new_refname->buf,
> +					      old_oid, old_oid, git_committer_info(0),
> +					      message->buf, rename->index++, rename->err);
> +	if (error < 0)
> +		return error;
> +
> +	return error;
> +}
> +
> +static int rename_one_ref(const char *old_refname, const char *referent,
> +			  const struct object_id *oid,
> +			  int flags, void *cb_data)
> +{
> +	struct rename_info *rename = cb_data;
> +	struct strbuf *new_referent = rename->buf1;
> +	const char *ptr = old_refname;
> +	int error;
> +
> +	if (!skip_prefix(ptr, "refs/remotes/", &ptr) ||
> +	    !skip_prefix(ptr, rename->old_name, &ptr) ||
> +	    !skip_prefix(ptr, "/", &ptr)) {
> +		error = 0;
> +		goto out;
>  	}
> -	strbuf_release(&buf);
>  
> -	return 0;
> +	renamed_refname(rename, old_refname, rename->new_refname);
> +
> +	if (flags & REF_ISSYMREF) {
> +		/*
> +		 * Stupidly enough `referent` is not pointing to the immediate
> +		 * target of a symref, but it's the recursively resolved value.
> +		 * So symrefs pointing to symrefs would be misresolved, and
> +		 * unborn symrefs don't have any value for the `referent` at all.
> +		 */
> +		referent = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> +						   old_refname, RESOLVE_REF_NO_RECURSE,
> +						   NULL, NULL);
> +		renamed_refname(rename, referent, new_referent);
> +		oid = NULL;
> +	}
> +
> +	error = ref_transaction_delete(rename->tx_delete, old_refname,
> +				       oid, referent, REF_NO_DEREF, NULL, rename->err);
> +	if (error < 0)
> +		goto out;
> +
> +	error = ref_transaction_update(rename->tx_create, rename->new_refname->buf, oid, null_oid(the_hash_algo),
> +				       (flags & REF_ISSYMREF) ? new_referent->buf : NULL, NULL,
> +				       REF_SKIP_CREATE_REFLOG | REF_NO_DEREF | REF_SKIP_OID_VERIFICATION,
> +				       NULL, rename->err);
> +	if (error < 0)
> +		goto out;
> +
> +	error = rename_one_reflog(old_refname, oid, rename);
> +	if (error < 0)
> +		goto out;
> +
> +	display_progress(rename->progress, ++rename->progress_nr);
> +
> +out:
> +	return error;
>  }
>  
>  static int migrate_file(struct remote *remote)
> @@ -730,7 +844,6 @@ static void handle_push_default(const char* old_name, const char* new_name)
>  	strbuf_release(&push_default.origin);
>  }
>  
> -
>  static int mv(int argc, const char **argv, const char *prefix,
>  	      struct repository *repo UNUSED)
>  {
> @@ -741,11 +854,15 @@ static int mv(int argc, const char **argv, const char *prefix,
>  	};
>  	struct remote *oldremote, *newremote;
>  	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT,
> -		old_remote_context = STRBUF_INIT;
> -	struct string_list remote_branches = STRING_LIST_INIT_DUP;
> -	struct rename_info rename;
> -	int i, refs_renamed_nr = 0, refspec_updated = 0;
> -	struct progress *progress = NULL;
> +		old_remote_context = STRBUF_INIT, err = STRBUF_INIT;
> +	struct rename_info rename = {
> +		.buf1 = &buf,
> +		.buf2 = &buf2,
> +		.buf3 = &buf3,
> +		.new_refname = &old_remote_context,
> +		.err = &err,
> +	};
> +	int i, refspec_updated = 0;
>  	int result = 0;
>  
>  	argc = parse_options(argc, argv, prefix, options,
> @@ -756,8 +873,6 @@ static int mv(int argc, const char **argv, const char *prefix,
>  
>  	rename.old_name = argv[0];
>  	rename.new_name = argv[1];
> -	rename.remote_branches = &remote_branches;
> -	rename.symrefs_nr = 0;
>  
>  	oldremote = remote_get(rename.old_name);
>  	if (!remote_is_configured(oldremote, 1)) {
> @@ -832,79 +947,60 @@ static int mv(int argc, const char **argv, const char *prefix,
>  		goto out;
>  
>  	/*
> -	 * First remove symrefs, then rename the rest, finally create
> -	 * the new symrefs.
> +	 * Note that we're using two transactions to rename the references:
> +	 *
> +	 *   - One transaction contains all deletions for references part of
> +	 *     the old remote.
> +	 *   - One transaction contains all creations of references and reflogs
> +	 *     part of the new remote.
> +	 *
> +	 * This split is required to avoid conflicting ref updates when a
> +	 * remote is being nested into itself or converted into its parent
> +	 * directory.
> +	 *
> +	 * Unfortunately this means that the operation isn't atomic. But we
> +	 * cannot avoid that, unless transactions learn to handle such
> +	 * conflicts one day.
>  	 */

We could detect if the rename operation would result in a D/F conflict
upfront and special case it by using two transactions. If we know there
isn't a D/F conflict, I think a single transaction would be sufficient.

That being said, it might be best to keep it simple for now and leave it
as-is.

> -	refs_for_each_ref(get_main_ref_store(the_repository),
> -			  read_remote_branches, &rename);
> -	if (show_progress) {
> -		/*
> -		 * Count symrefs twice, since "renaming" them is done by
> -		 * deleting and recreating them in two separate passes.
> -		 */
> -		progress = start_progress(the_repository,
> -					  _("Renaming remote references"),
> -					  rename.remote_branches->nr + rename.symrefs_nr);
> -	}
> -	for (i = 0; i < remote_branches.nr; i++) {
> -		struct string_list_item *item = remote_branches.items + i;
> -		struct strbuf referent = STRBUF_INIT;
> +	rename.tx_delete = ref_store_transaction_begin(get_main_ref_store(the_repository),
> +						       0, &err);
> +	if (!rename.tx_delete)
> +		goto out;
>  
> -		if (refs_read_symbolic_ref(get_main_ref_store(the_repository), item->string,
> -					   &referent))
> -			continue;
> -		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, item->string, NULL, REF_NO_DEREF))
> -			die(_("deleting '%s' failed"), item->string);
> +	rename.tx_create = ref_store_transaction_begin(get_main_ref_store(the_repository),
> +						       0, &err);
> +	if (!rename.tx_create)
> +		goto out;
>  
> -		strbuf_release(&referent);
> -		display_progress(progress, ++refs_renamed_nr);
> -	}
> -	for (i = 0; i < remote_branches.nr; i++) {
> -		struct string_list_item *item = remote_branches.items + i;
> +	if (show_progress)
> +		rename.progress = start_delayed_progress(the_repository,
> +							 _("Renaming remote references"), 0);
>  
> -		if (item->util)
> -			continue;
> -		strbuf_reset(&buf);
> -		strbuf_addstr(&buf, item->string);
> -		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old_name),
> -				rename.new_name, strlen(rename.new_name));
> -		strbuf_reset(&buf2);
> -		strbuf_addf(&buf2, "remote: renamed %s to %s",
> -				item->string, buf.buf);
> -		if (refs_rename_ref(get_main_ref_store(the_repository), item->string, buf.buf, buf2.buf))
> -			die(_("renaming '%s' failed"), item->string);
> -		display_progress(progress, ++refs_renamed_nr);
> -	}
> -	for (i = 0; i < remote_branches.nr; i++) {
> -		struct string_list_item *item = remote_branches.items + i;
> +	result = refs_for_each_rawref(get_main_ref_store(the_repository),
> +				      rename_one_ref, &rename);
> +	if (result < 0)
> +		die(_("renaming references failed: %s"), rename.err->buf);
>  
> -		if (!item->util)
> -			continue;
> -		strbuf_reset(&buf);
> -		strbuf_addstr(&buf, item->string);
> -		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old_name),
> -				rename.new_name, strlen(rename.new_name));
> -		strbuf_reset(&buf2);
> -		strbuf_addstr(&buf2, item->util);
> -		strbuf_splice(&buf2, strlen("refs/remotes/"), strlen(rename.old_name),
> -				rename.new_name, strlen(rename.new_name));
> -		strbuf_reset(&buf3);
> -		strbuf_addf(&buf3, "remote: renamed %s to %s",
> -				item->string, buf.buf);
> -		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, buf3.buf))
> -			die(_("creating '%s' failed"), buf.buf);
> -		display_progress(progress, ++refs_renamed_nr);
> -	}
> -	stop_progress(&progress);
> +	result = ref_transaction_commit(rename.tx_delete, &err);
> +	if (result < 0)
> +		die(_("deleting old remote refs failed: %s"), rename.err->buf);
> +
> +	result = ref_transaction_commit(rename.tx_create, &err);
> +	if (result < 0)
> +		die(_("committing new remote refs failed: %s"), rename.err->buf);
> +
> +	stop_progress(&rename.progress);
>  
>  	handle_push_default(rename.old_name, rename.new_name);
>  
>  out:
> -	string_list_clear(&remote_branches, 1);
> +	ref_transaction_free(rename.tx_create);
> +	ref_transaction_free(rename.tx_delete);
>  	strbuf_release(&old_remote_context);
>  	strbuf_release(&buf);
>  	strbuf_release(&buf2);
>  	strbuf_release(&buf3);
> +	strbuf_release(&err);
>  	return result;
>  }
>  
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 2701eef85e9..f4a407b022d 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -1658,4 +1658,75 @@ test_expect_success 'forbid adding superset of existing remote' '
>  	test_grep ".outer. is a superset of existing remote .outer/inner." err
>  '
>  
> +test_expect_success 'rename handles unborn HEAD' '
> +	test_when_finished "git remote remove unborn-renamed" &&
> +	git remote add unborn url &&
> +	git symbolic-ref refs/remotes/unborn/HEAD refs/remotes/unborn/nonexistent &&
> +	git remote rename unborn unborn-renamed &&
> +	git symbolic-ref refs/remotes/unborn-renamed/HEAD >actual &&
> +	echo refs/remotes/unborn-renamed/nonexistent >expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'rename can nest a remote into itself' '
> +	test_commit parent-commit &&
> +	COMMIT_ID=$(git rev-parse HEAD) &&
> +	test_when_finished "git remote remove parent || true" &&
> +	git remote add parent url &&
> +	git update-ref refs/remotes/parent/branch $COMMIT_ID &&
> +	test_when_finished "git remote remove parent/child" &&
> +	git remote rename parent parent/child &&
> +	git for-each-ref refs/remotes/ >actual &&
> +	printf "$COMMIT_ID commit\trefs/remotes/parent/child/branch\n" >expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'rename can nest a remote into itself with a conflicting branch name' '
> +	test_commit parent-conflict &&
> +	COMMIT_ID=$(git rev-parse HEAD) &&
> +	test_when_finished "git remote remove parent || true" &&
> +	git remote add parent url &&
> +	git update-ref refs/remotes/parent/child $COMMIT_ID &&
> +	test_when_finished "git remote remove parent/child" &&
> +	git remote rename parent parent/child &&
> +	git for-each-ref refs/remotes/ >actual &&
> +	printf "$COMMIT_ID commit\trefs/remotes/parent/child/child\n" >expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'rename can unnest a remote' '
> +	test_commit parent-child-commit &&
> +	COMMIT_ID=$(git rev-parse HEAD) &&
> +	test_when_finished "git remote remove parent/child || true" &&
> +	git remote add parent/child url &&
> +	git update-ref refs/remotes/parent/child/branch $COMMIT_ID &&
> +	git remote rename parent/child parent &&
> +	git for-each-ref refs/remotes/ >actual &&
> +	printf "$COMMIT_ID commit\trefs/remotes/parent/branch\n" >expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'rename moves around the reflog' '
> +	test_commit reflog-old &&
> +	COMMIT_ID=$(git rev-parse HEAD) &&
> +	test_config core.logAllRefUpdates true &&
> +	test_when_finished "git remote remove reflog-old || true" &&
> +	git remote add reflog-old url &&
> +	git update-ref refs/remotes/reflog-old/branch $COMMIT_ID &&
> +	test-tool ref-store main for-each-reflog >actual &&
> +	test_grep refs/remotes/reflog-old/branch actual &&
> +	test-tool ref-store main for-each-reflog-ent refs/remotes/reflog-old/branch >reflog-entries-old &&
> +	test_line_count = 1 reflog-entries-old &&
> +	git remote rename reflog-old reflog-new &&
> +	test-tool ref-store main for-each-reflog >actual &&
> +	test_grep ! refs/remotes/reflog-old actual &&
> +	test_grep refs/remotes/reflog-new/branch actual &&
> +	test-tool ref-store main for-each-reflog-ent refs/remotes/reflog-new/branch >reflog-entries-new &&
> +	cat >expect <<-EOF &&
> +	$(cat reflog-entries-old)
> +	$COMMIT_ID $COMMIT_ID $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1112912173 -0700	remote: renamed refs/remotes/reflog-old/branch to refs/remotes/reflog-new/branch
> +	EOF
> +	test_cmp expect reflog-entries-new
> +'
> +
>  test_done
> 
> -- 
> 2.50.1.565.gc32cd1483b.dirty
> 
> 
