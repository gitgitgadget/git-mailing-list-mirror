Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF57F9
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297563; cv=none; b=NY6DGbRo65JTGKkPQjoOsfPGEQxzLT3MIcBaKcWobBj5vkqAFS56HJmu1t6sYuPa/F8zw5lhJrrIVnqFUcNgpEj0rTJ0g3D5AWeXt27x+3dU35qU3sjyqnOkTCVUm/Xd9wkYlCEbNINszLoFLEc01JqI0qCn2pTNyj3kGlPvDK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297563; c=relaxed/simple;
	bh=b99sSa7FwFUAwHs+SGWBThdswRpAneplmHHCLwwkdQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDd4dRkuec6XUuvIhlg8IgVJDzhl0DxnWSGtNdcIapHjDaEZbpKH6Avzm1+is1pKriiDs52Tlja1uVaR3Mkqcc+jlLTLI9wjXFFpOytg7CPJbk5wGVoLWCecFa0Z8viCSxueuBXnL/6r5Z8Xr0UR4IIgaBfDWlIot0nKOOy7m3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7Xi2cfi; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7Xi2cfi"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-41b7d1240d8so163204b6e.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753297561; x=1753902361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ik0didQal7RrH4ocsPS21NejqWaHELqRzV1pSTWrbag=;
        b=G7Xi2cfikwJv3HaN8A7xlxMOYqV1i2rVGbepZsdOKbvcpoE3L7JvsX9NWIElOveQYI
         lkDfcJdF+1pqaY/CBCRlfudYQgqTV6xw36GOfE5oFkbuIaNknz03QKuPThkLD73IckBf
         mSFc1XZ9ukH9JNBFwLZUrT+K//EYHSwZ3uJ5l2o1JNmOo69xfZGaNn3v4FzKiy4Oj8te
         5FBCa8RK7E3R/mdUnn0DKwzrXqwSCQKqfbWKcQPGNFM4XGThslvIdyt0xw4eFLOX0rfX
         /00R9Du8jlb4Yeh6ne5DFpVeSpM3IdneMeUuAQJJK6vM5iTac4mW7jSOiBLmB+HtYa2d
         ++DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297561; x=1753902361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik0didQal7RrH4ocsPS21NejqWaHELqRzV1pSTWrbag=;
        b=GpS9iW0Tv/MGZmISWoTdFp5i1U2mH+7aUL8iaKhJdPrlYrjsPGiLQbDbm1tWmYOWnC
         eq17tBghpHH+1dCV89YBnoGL42tGtov4LFRgCJ9q4l+gbSMn2KQrJChfH6REsu72EK4n
         LSiEAz9CMz+0lBhxAzOpr02eHdviqFQJGaJVj7nWFmgGXftNApY9rjCA4rqckgMEXJL1
         QzZ9wybnXmxk5dfO1cPMnVed2Bz83UQvdNJjEIOgMxphOORsnO82pwuc8QefUr6BGz1u
         9UbAqDLeenabE6rTI9b8CWMK2PIga+WNLn45Hzrv9GviFkzCR//Z8PXY86fa9CW7aqDp
         lMng==
X-Gm-Message-State: AOJu0Ywmk7ZpnC9cOiD7jMzGlxB/mt4rL2vhG8FyWATPoCm3EmKKhRc8
	K0Tgovk2yPOoM1QXDsyJBqS9sWaPGieOtPtOFwa4jlErK6rU58+d9PCUtUmKJg==
X-Gm-Gg: ASbGncsA6O1VlHvvP+vCNrWfBh1bkZPnTR46EIfnML2+qz4TOZcxn5aiiSoRCdE7Z7R
	Li7qUYfgrJ0oKGXzBj8Ge6p3BKHBubg9UTR5SOz2ZThw58DRrbV3aXhf3lufsXWQopDSAXNS/hP
	tvl3hGpRP4IkHZliynHnwdJwZUU88PmH8TiXsCeF5/Zxk/P6yPwcS6z5Nh4xMitQIhMNMVK2kUX
	iPwWizCKdwBzrmbKVpMe4iVYPbRK6WHiyDGCVCZfNtt/kaRAALLZCisxx1rmhS/NKD1FiuDepiy
	2WhjaboOpvzsQwWmUbYBLJyVIEAy3CSNDWrzUKZZZbY4u5NQEsWr7wamG5bBak4tnixOTNfVIk5
	JMzpwXnEi2v25LXc=
X-Google-Smtp-Source: AGHT+IEv2Utc9V4OXLfEl9KcQQXazGk9yr7uWV8bxFNUgeGYxf+z1Ig7pbpBqoWYuQ38N6l51Rt6ng==
X-Received: by 2002:a05:6808:1493:b0:40a:547c:20a2 with SMTP id 5614622812f47-426c53a17bfmr3088823b6e.6.1753297560764;
        Wed, 23 Jul 2025 12:06:00 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41fd1ca5832sm3364585b6e.17.2025.07.23.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:06:00 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:00:10 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 4/8] builtin/reflog: implement subcommand to write new
 entries
Message-ID: <mkqjim46zv4sfhzjjee2tcxwj23esfrupp5byienju5qlwvlht@r2gxnybioukw>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-4-183e5949de16@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-pks-reflog-append-v1-4-183e5949de16@pks.im>

On 25/07/22 01:20PM, Patrick Steinhardt wrote:
> While we provide a couple of subcommands in git-reflog(1) to remove
> reflog entries, we don't provide any to write new entries. Obviously
> this is not an operation that really would be needed for many use cases
> out there, or otherwise people would have complained that such a command
> does not exist yet. But the introduction of the "reftable" backend
> changes the picture a bit, as it is now basically impossible to manually
> append a reflog entry if one wanted to do so due to the binary format.
> 
> Plug this gap by introducing a simple "write" subcommand. For now, all
> this command does is to append a single new reflog entry with the given
> object IDs and message to the reflog. More specifically, it is not yet
> possible to:
> 
>   - Write multiple reflog entries at once.
> 
>   - Insert reflog entries at arbitrary indices.
> 
>   - Specify the date of the reflog entry.
> 
>   - Insert reflog entries that refer to nonexistent objects.
> 
> If required, those features can be added at a future point in time. For
> now though, the new command aims to fulfill the most basic use cases
> while being as strict as possible when it comes to verifying parameters.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-reflog.adoc |  1 +
>  builtin/reflog.c              | 65 ++++++++++++++++++++++++++++++++++
>  t/meson.build                 |  1 +
>  t/t1421-reflog-write.sh       | 81 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 148 insertions(+)
> 
> diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
> index 6ae13e772b8..798dbc0a00a 100644
> --- a/Documentation/git-reflog.adoc
> +++ b/Documentation/git-reflog.adoc
> @@ -12,6 +12,7 @@ SYNOPSIS
>  git reflog [show] [<log-options>] [<ref>]
>  git reflog list
>  git reflog exists <ref>
> +git reflog write <ref> <old-oid> <new-oid> <message>

The other subcommands each have an entry in the description. Do we want
to also add something for the "write" subcommand?

Also, if we want to be consistent, I noticed the order of the
subcommands listed in the description was not changed either. 

>  git reflog delete [--rewrite] [--updateref]
>  	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
>  git reflog drop [--all [--single-worktree] | <refs>...]
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index b00b3f9edc9..d0374295620 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -3,6 +3,8 @@
>  #include "builtin.h"
>  #include "config.h"
>  #include "gettext.h"
> +#include "hex.h"
> +#include "odb.h"
>  #include "revision.h"
>  #include "reachable.h"
>  #include "wildmatch.h"
> @@ -20,6 +22,9 @@
>  #define BUILTIN_REFLOG_EXISTS_USAGE \
>  	N_("git reflog exists <ref>")
>  
> +#define BUILTIN_REFLOG_WRITE_USAGE \
> +	N_("git reflog write <ref> <old-oid> <new-oid> <message>")
> +
>  #define BUILTIN_REFLOG_DELETE_USAGE \
>  	N_("git reflog delete [--rewrite] [--updateref]\n" \
>  	   "                  [--dry-run | -n] [--verbose] <ref>@{<specifier>}...")
> @@ -47,6 +52,11 @@ static const char *const reflog_exists_usage[] = {
>  	NULL,
>  };
>  
> +static const char *const reflog_write_usage[] = {
> +	BUILTIN_REFLOG_WRITE_USAGE,
> +	NULL,
> +};
> +
>  static const char *const reflog_delete_usage[] = {
>  	BUILTIN_REFLOG_DELETE_USAGE,
>  	NULL
> @@ -66,6 +76,7 @@ static const char *const reflog_usage[] = {
>  	BUILTIN_REFLOG_SHOW_USAGE,
>  	BUILTIN_REFLOG_LIST_USAGE,
>  	BUILTIN_REFLOG_EXISTS_USAGE,
> +	BUILTIN_REFLOG_WRITE_USAGE,
>  	BUILTIN_REFLOG_DELETE_USAGE,
>  	BUILTIN_REFLOG_DROP_USAGE,
>  	BUILTIN_REFLOG_EXPIRE_USAGE,
> @@ -392,6 +403,59 @@ static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
>  	return ret;
>  }
>  
> +static int cmd_reflog_write(int argc, const char **argv, const char *prefix,
> +			    struct repository *repo)
> +{
> +	const struct option options[] = {
> +		OPT_END()
> +	};
> +	struct object_id old_oid, new_oid;
> +	struct strbuf err = STRBUF_INIT;
> +	struct ref_transaction *tx;
> +	const char *ref, *message;
> +	int ret;
> +
> +	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
> +	if (argc != 4)
> +		usage_with_options(reflog_write_usage, options);
> +
> +	ref = argv[0];
> +	if (check_refname_format(ref, REFNAME_ALLOW_ONELEVEL))
> +		die(_("invalid reference name: %s"), ref);
> +
> +	ret = get_oid_hex_algop(argv[1], &old_oid, repo->hash_algo);
> +	if (ret)
> +		die(_("invalid old object ID: '%s'"), argv[1]);
> +	if (!is_null_oid(&old_oid) && !odb_has_object(repo->objects, &old_oid, 0))
> +		die(_("old object '%s' does not exist"), argv[1]);
> +
> +	ret = get_oid_hex_algop(argv[2], &new_oid, repo->hash_algo);
> +	if (ret)
> +		die(_("invalid new object ID: '%s'"), argv[2]);
> +	if (!is_null_oid(&new_oid) && !odb_has_object(repo->objects, &new_oid, 0))
> +		die(_("new object '%s' does not exist"), argv[2]);

Ok so we validate the reference name and the old/new obects names to
make sure they are sane.

> +
> +	message = argv[3];
> +
> +	tx = ref_store_transaction_begin(get_main_ref_store(repo), 0, &err);
> +	if (!tx)
> +		die(_("cannot start transaction: %s"), err.buf);
> +
> +	ret = ref_transaction_update_reflog(tx, ref, &new_oid, &old_oid,
> +					    git_committer_info(0),
> +					    message, 0, &err);
> +	if (ret)
> +		die(_("cannot queue reflog update: %s"), err.buf);
> +
> +	ret = ref_transaction_commit(tx, &err);
> +	if (ret)
> +		die(_("cannot commit reflog update: %s"), err.buf);

And here we write the reflog entry. Looks good

> +
> +	ref_transaction_free(tx);
> +	strbuf_release(&err);
> +	return 0;
> +}
> +
>  /*
>   * main "reflog"
>   */
> @@ -405,6 +469,7 @@ int cmd_reflog(int argc,
>  		OPT_SUBCOMMAND("show", &fn, cmd_reflog_show),
>  		OPT_SUBCOMMAND("list", &fn, cmd_reflog_list),
>  		OPT_SUBCOMMAND("exists", &fn, cmd_reflog_exists),
> +		OPT_SUBCOMMAND("write", &fn, cmd_reflog_write),
>  		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
>  		OPT_SUBCOMMAND("drop", &fn, cmd_reflog_drop),
>  		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
> diff --git a/t/meson.build b/t/meson.build
> index 1af289425d4..d68f5e24dbe 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -219,6 +219,7 @@ integration_tests = [
>    't1418-reflog-exists.sh',
>    't1419-exclude-refs.sh',
>    't1420-lost-found.sh',
> +  't1421-reflog-write.sh',
>    't1430-bad-ref-name.sh',
>    't1450-fsck.sh',
>    't1451-fsck-buffer.sh',
> diff --git a/t/t1421-reflog-write.sh b/t/t1421-reflog-write.sh
> new file mode 100755
> index 00000000000..e284f42178f
> --- /dev/null
> +++ b/t/t1421-reflog-write.sh
> @@ -0,0 +1,81 @@
> +#!/bin/sh
> +
> +test_description='Manually write reflog entries'
> +
> +. ./test-lib.sh
> +
> +SIGNATURE="C O Mitter <committer@example.com> 1112911993 -0700"
> +
> +test_reflog_matches () {
> +	repo="$1" &&
> +	refname="$2" &&
> +	cat >actual &&
> +	test-tool -C "$repo" ref-store main for-each-reflog-ent "$refname" >expected &&
> +	test_cmp expected actual
> +}
> +
> +test_expect_success 'invalid number of arguments' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		for args in "" "1" "1 2" "1 2 3" "1 2 3 4 5"
> +		do
> +			test_must_fail git reflog write $args 2>err &&
> +			test_grep "usage: git reflog write" err || return 1
> +		done
> +	)
> +'
> +
> +test_expect_success 'invalid refname' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_must_fail git reflog write "refs/heads/ invalid" $ZERO_OID $ZERO_OID first 2>err &&
> +		test_grep "invalid reference name: " err
> +	)
> +'
> +
> +test_expect_success 'nonexistent old object ID' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_must_fail git reflog write refs/heads/something $(test_oid deadbeef) $ZERO_OID first 2>err &&
> +		test_grep "old object .* does not exist" err
> +	)
> +'
> +
> +test_expect_success 'nonexistent new object ID' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_must_fail git reflog write refs/heads/something $ZERO_OID $(test_oid deadbeef) first 2>err &&
> +		test_grep "new object .* does not exist" err
> +	)
> +'
> +
> +test_expect_success 'simple writes' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +		COMMIT_OID=$(git rev-parse HEAD) &&
> +
> +		git reflog write refs/heads/something $ZERO_OID $COMMIT_OID first &&
> +		test_reflog_matches . refs/heads/something <<-EOF &&
> +		$ZERO_OID $COMMIT_OID $SIGNATURE	first
> +		EOF
> +
> +		git reflog write refs/heads/something $COMMIT_OID $COMMIT_OID second &&
> +		test_reflog_matches . refs/heads/something <<-EOF
> +		$ZERO_OID $COMMIT_OID $SIGNATURE	first
> +		$COMMIT_OID $COMMIT_OID $SIGNATURE	second
> +		EOF
> +	)
> +'
> +
> +test_done
> 
> -- 
> 2.50.1.465.gcb3da1c9e6.dirty
> 
> 
