Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3644F49E159
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998994; cv=pass; b=MBIPCIdwE/EjC6V2oTwTD36+q1hFVNpilSIqGH7Y7h0J3bZ2gJdWtyufhJTqv6pvhkWqrTNQKskIGY42lNOOcNSV3QgiaWsLGa8uDnT91TUEfZQ5AHoxlFcO/0mi71h8CtBivyYQ/bB4t8MNXkyoBHzx3+4NAhE87cASb5JDAnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998994; c=relaxed/simple;
	bh=tRPBzipzLIVh15jzMeh+mShq+ZaERK5KxwKCD3gxyO0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddJXgKcm2k/4dL955TZ6uuOZIFRnlqkHlcC71wNzEedEEL59W63LLIzcXNDMh1zaq6k+2PQaCFnWbG0zOnTvxa+ZfpSota/T8ggZQsUPy9cQAwQsvzI4b6tr7P44rQaaqxq4Cv6tYb/b6BgNv/s4IZLtXQdqv/q8Q57zKDpvovc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtMZzDFQ; arc=pass smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtMZzDFQ"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c979c5eca8so2059363e0c.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 06:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789998991; cv=none;
        d=google.com; s=arc-20260327;
        b=gN2zPrpI63weYuup+3mWOsNWVbGuTWUle6SOXRiA2ZkCRsv7YQzR5sA3DkbdqbOqBW
         mwvuuYmw2NmMzn035YHJ19F9jo1rvgo1XygMAMMvmjdvL5DcpVQcp/lp5Ga0Z37zfmdI
         kewBCIBeYL0QxFe+sov5L+53qtcqgD8PdKLUP8yr1fajrknGbzqpelGnYg94nzuq1PKd
         nsE4PJ4wIvT/vpPGZ45+k6/WHuOAoOhwhylJ1v8bTheW1BG6Lh2CGo8s0fYor3s+Lhko
         mOa9L7dLdLidDQj9+d26S0jGRn6LBk+LmhUgINCN0Es1EsZmuC9Mx9Af3tmvo3iCSOow
         AY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=zcZEBOuuBy7K5zCb5c90Q+5KXmULZ2EGCzOzwE56O7E=;
        fh=TeosiZGmdnKkH8ZfNe+sQiiP+21rEhZPwn8clUXYSi4=;
        b=NwnGLjcGX2sm/9eHK1/0m64dKXOI9yLZDdWvit3S6WN9qTCGWo6M5eNbfnUVcJwdvE
         ypzwnk7ka06JdD6BwSb037LxY9+8HEfhln8GHeEO8clkSEI+2ErSOulBZSpwjjYtW19I
         q2viBMVmc5MGxx9ePHK9coT0yz1RKfTfLBsbth1J2WMLq2trbD3dz/IsmA7wmVSDzIr9
         7N8HfPIucGqfKIzSJLAXMFg0VeFtI7x/X3PlHAXFU7XKrm/ltdtABH8x33Z3UzfSX+It
         aIxIEe5+Rbow5XDiCNqNEVqfJDi8LQXRghrLJP+g2h2eFkggMRrDh/SVsiE4LpxvfgJP
         BOuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789998991; x=1790603791; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zcZEBOuuBy7K5zCb5c90Q+5KXmULZ2EGCzOzwE56O7E=;
        b=qtMZzDFQfw48zqXG6rlC2qJmpU7x167zOCzmC1qNJk3dt1Z60v30vOb0rTnQ7sG1C4
         bYT7Slu2ZVJWQzYrh8S2SSKtWTKr4ETvdJXgIGX+GLwbBGvOJFexz6j/xBMp3bxeyQJ3
         wXsYOMxg6swoIKZT0izEV/6M9rRFRhl8E6z3Bw96eLQtcQmpY0CXSjmN97f1A9+7cXUb
         1eRXRUqbeAtXDakXdi7bKd7o8zeUB9CG2ZrTw0CH/v3ed4UjWtXv34Z18xB/9+u9Arxf
         BPupuKCp4dm0QWDtJ0jhal84+n3jgAb3iqkROaiDfMXcfV99jvFQ4qOYIByqRfwpNl/W
         OlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789998991; x=1790603791;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zcZEBOuuBy7K5zCb5c90Q+5KXmULZ2EGCzOzwE56O7E=;
        b=D5gOPSdrO7/OMzuSoIuoznSIupN3750oImxa3zF3C8fAyxmoZ2UISF4Myb6KdHC3Sl
         XelVWChEf98jcORDVKW9rG1IyBQoDoLtVYQS4cOfeSH2iAcsRpT+RNKR0RobeAr/O4vO
         /Ohn+2mKxNwxku8l+Rtts7Rsp/fc001e/EK9odgQqYuwvM9UOgMOvS0asyYDkgGHw7WZ
         /EauCgvgX2deh/H66BCXSCZ8FmCsjcMTXIjkGBcTTCUndqekT+8v/3c1tvcUNsVWazCc
         M/oIUL+BmcD6JR6DUKlAe94HPbbEs7fSdKVv02+9iPCRFq8SHbZAWzD1ND9cXm0tFBp4
         /pbw==
X-Forwarded-Encrypted: i=1; AKwUvByntTbaZfWeqjD/3s7GfuWnDoMS+HDXw2C5tDlKsOYyoqWk8btvHPPOjdRWK5wjRZgPUhA=@vger.kernel.org
X-Gm-Message-State: AFuF++mY76c4k6YyWCp35DuDGKIUveY+zhYYHjNVaN02aUiKzVaS4820
	Rb+ZPFyv99Ey0mfgU3BVAPp9sv8llEBI6w24HRoc7obX4O75VDmI73+c7k9fI6+BMEHVEeUEwmW
	2p1BFPpK/KmJ+a0qR/gAC1MvEJi2VIaU=
X-Gm-Gg: AYBFou3OGtcEQFYr27KRX7Eg6iI5aV1eQmhAw3ZF/VwAefkgHDG+H3rhIYFT5arEhKp
	OyWreM3kLRspgnFfqd6Y1WC1t0jU5xkUVkQifcHoNR7Uo+TkWbyoPwMS85pw0OyszbIgImXBd1z
	5nhcCO6eitigEZfPEqjKUGqmSIZf9xaqXNm4szOlAA+RWVaQHSrrH4tzGIJePiC/UN2QAu6jlK0
	TEmRkcx4c331NhGdw8r4bC1iwX9OJL94+tKf8PrPPaeoZGZd6iQec6+OsHWwK64aGf3DIA8hqQm
	xPsToWdtTBsdCMcphiaKvRrOuMmAivEGvH/L0KywPXila/v0ltidGFUcogf87DjeRfSBjMXmCBW
	s2vsxKkUchpfbVWOlk7H3DJVzznkujUvDikzEJCHpfN6upg==
X-Received: by 2002:a05:6123:122:b0:5c9:983e:79e4 with SMTP id
 71dfb90a1353d-5c9b58b8cc6mr5375125e0c.7.1789998990831; Mon, 21 Sep 2026
 06:56:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 06:56:29 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 06:56:29 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <461c36ccdae09fb827a3c0efc7eed5aef072e09b.1789901584.git.maciej.ciemborowicz@gmail.com>
References: <cover.1789901584.git.maciej.ciemborowicz@gmail.com> <461c36ccdae09fb827a3c0efc7eed5aef072e09b.1789901584.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Sep 2026 06:56:29 -0700
X-Gm-Features: AcwNN1VA0rgw1ZPCisSXOp6tk5Bfi6sjpoxLR8muzUgMOFlo9PfQbJDRmt0N23k
Message-ID: <CAOLa=ZRYTevU5SpkGBQu198Rbaemms4s03pFaZ4DOKCGMOV_vQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fetch, remote: retain old OIDs when pruning refs
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Phil Hord <phil.hord@gmail.com>, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000ff80e2065bfe9dec"

--000000000000ff80e2065bfe9dec
Content-Type: text/plain; charset="UTF-8"

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> get_stale_heads() records the current value of each stale local ref in its
> new_oid member. The pruning paths discard that value and request unconditional
> deletion, so reference-transaction hooks receive a null old OID.
>
> Carry the recorded values into the deletion transactions. Besides giving the
> hooks useful values, this stops a stale scan from deleting a ref that another
> process updated before the transaction acquired its locks. A concurrent
> change now makes the prune fail and preserves the new value.
>
> This reuses data collected while finding stale refs and therefore requires no
> additional ref reads. Do not print deletion status when a non-atomic prune
> fails its old-OID check.
>

This does break user behavior though, previously we would never fail on
pruning refs, but now we would and in a all-or-nothing manner. So
perhaps a better way would be to use the `REF_TRANSACTION_ALLOW_FAILURE`?

> Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
> ---
>  builtin/fetch.c                  | 13 +++++--
>  builtin/remote.c                 | 36 ++++++++++++++---
>  t/t1416-ref-transaction-hooks.sh | 66 ++++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index d202147b2..da413ace0 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1452,14 +1452,18 @@ static int prune_refs(struct display_state *display_state,
>  	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
>  	struct strbuf err = STRBUF_INIT;
>  	struct string_list refnames = STRING_LIST_INIT_NODUP;
> +	struct oid_array old_oids = OID_ARRAY_INIT;
>
> -	for (ref = stale_refs; ref; ref = ref->next)
> +	for (ref = stale_refs; ref; ref = ref->next) {
>  		string_list_append(&refnames, ref->name);
> +		oid_array_append(&old_oids, &ref->new_oid);
> +	}
>

Here `refnames` is built, but below it is only used for the non-atomic
flow. Perhaps, we should move this into the `else` block?

>  	if (!dry_run) {
>  		if (transaction) {
>  			for (ref = stale_refs; ref; ref = ref->next) {
> -				result = ref_transaction_delete(transaction, ref->name, NULL,
> +				result = ref_transaction_delete(transaction, ref->name,
> +							&ref->new_oid,
>  								NULL, 0, "fetch: prune", &err);

Nit: the formatting seems off.

Curiously, was an LLM used to create these patches? If so, please do
read our policy in 'Documentation/SubmittingPatches' regarding AI usage.

>  				if (result)
>  					goto cleanup;
> @@ -1467,8 +1471,10 @@ static int prune_refs(struct display_state *display_state,
>  		} else {
>  			result = refs_delete_refs(get_main_ref_store(the_repository),
>  						  "fetch: prune", &refnames,
> -						  NULL, 0);
> +						  &old_oids, 0);
>  		}
> +		if (result)
> +			goto cleanup;

So, previously, we'd always prune all references without checking the
old_oid. Now we should expect that this can fail. So we do need to check
for the `result`.

Seems like the other branch condition also does the same, we can extract
this out?

>  	}
>
>  	if (verbosity >= 0) {
> @@ -1487,6 +1493,7 @@ static int prune_refs(struct display_state *display_state,
>
>  cleanup:
>  	string_list_clear(&refnames, 0);
> +	oid_array_clear(&old_oids);
>  	strbuf_release(&err);
>  	free_refs(stale_refs);
>  	return result;
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 13d3cc52d..b899bec55 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -17,6 +17,7 @@
>  #include "refs.h"
>  #include "refspec.h"
>  #include "odb.h"
> +#include "oid-array.h"
>  #include "strvec.h"
>  #include "commit-reach.h"
>  #include "progress.h"
> @@ -380,6 +381,11 @@ struct ref_states {
>  	int queried;
>  };
>
> +struct stale_ref {
> +	struct object_id oid;
> +	char name[FLEX_ARRAY];
> +};
> +
>  #define REF_STATES_INIT { \
>  	.new_refs = STRING_LIST_INIT_DUP, \
>  	.skipped = STRING_LIST_INIT_DUP, \
> @@ -410,9 +416,13 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
>  	}
>  	stale_refs = get_stale_heads(&states->remote->fetch, fetch_map);
>  	for (ref = stale_refs; ref; ref = ref->next) {
> +		struct stale_ref *stale_ref;
>  		struct string_list_item *item =
>  			string_list_append(&states->stale, abbrev_branch(ref->name));
> -		item->util = xstrdup(ref->name);
> +
> +		FLEX_ALLOC_STR(stale_ref, name, ref->name);
> +		oidcpy(&stale_ref->oid, &ref->new_oid);
> +		item->util = stale_ref;
>  	}
>  	free_refs(stale_refs);
>  	free_refs(fetch_map);
> @@ -1627,6 +1637,7 @@ static int prune_remote(const char *remote, int dry_run)
>  	int result = 0;
>  	struct ref_states states = REF_STATES_INIT;
>  	struct string_list refs_to_prune = STRING_LIST_INIT_NODUP;
> +	struct oid_array old_oids = OID_ARRAY_INIT;
>  	struct string_list_item *item;
>
>  	get_remote_ref_states(remote, &states, GET_REF_STATES);
> @@ -1639,17 +1650,28 @@ static int prune_remote(const char *remote, int dry_run)
>  	printf_ln(_("Pruning %s"), remote);
>  	printf_ln(_("URL: %s"), states.remote->url.v[0]);
>
> -	for_each_string_list_item(item, &states.stale)
> -		string_list_append(&refs_to_prune, item->util);
> +	for_each_string_list_item(item, &states.stale) {
> +		struct stale_ref *stale_ref = item->util;
> +		struct string_list_item *to_prune;
> +
> +		to_prune = string_list_append(&refs_to_prune, stale_ref->name);
> +		to_prune->util = &stale_ref->oid;
> +	}
>  	string_list_sort(&refs_to_prune);
> +	for_each_string_list_item(item, &refs_to_prune)
> +		oid_array_append(&old_oids, item->util);
>

We do this in the previous block? We don't need a new iterator here.

> -	if (!dry_run)
> +	if (!dry_run) {
>  		result |= refs_delete_refs(get_main_ref_store(the_repository),
>  					   "remote: prune", &refs_to_prune,
> -					   NULL, 0);
> +					   &old_oids, 0);
> +		if (result)
> +			goto cleanup;
> +	}
>
>  	for_each_string_list_item(item, &states.stale) {
> -		const char *refname = item->util;
> +		struct stale_ref *stale_ref = item->util;
> +		const char *refname = stale_ref->name;
>
>  		if (dry_run)
>  			printf_ln(_(" * [would prune] %s"),
> @@ -1662,7 +1684,9 @@ static int prune_remote(const char *remote, int dry_run)
>  	refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
>  				   stdout, " ", dry_run, &refs_to_prune);
>
> +cleanup:
>  	string_list_clear(&refs_to_prune, 0);
> +	oid_array_clear(&old_oids);
>  	free_remote_ref_states(&states);
>  	return result;
>  }
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
> index 01b5ba8c4..2b51b216b 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -58,6 +58,72 @@ test_expect_success 'branch deletion rejects a concurrent update' '
>  	test_cmp_rev POST refs/heads/delete-race
>  '
>
> +test_expect_success 'hook gets old values when pruning remote refs' '
> +	test_create_repo empty.git --bare &&
> +	test_create_repo prune &&

test_create_repo is considered deprecated, let's use `git init`
directly. While we're at it, we should also cleanup the directories we
create here.

> +	git -C prune remote add origin ../empty.git &&
> +	test_commit -C prune one &&
> +	one=$(git -C prune rev-parse HEAD) &&
> +	test_commit -C prune two &&
> +	two=$(git -C prune rev-parse HEAD) &&
> +	git -C prune update-ref refs/remotes/origin/remote-prune-z "$one" &&
> +	git -C prune update-ref refs/remotes/origin/remote-prune-a "$two" &&
> +	git -C prune pack-refs --all &&

Why do we need to pack-refs?

> +	test_hook -C prune reference-transaction <<-\EOF &&
> +		if test "$1" = committed
> +		then
> +			# Ignore backend-internal zero-to-zero records.
> +			while read -r old new ref
> +			do
> +				case "$old" in
> +				*[!0]*)
> +					echo "$old $new $ref"
> +					;;
> +				esac
> +			done >>actual
> +		fi
> +	EOF
> +	(
> +		cd prune &&

All the commands above also run in the 'prune' directory, can we put all
of them in this subshell?

> +		git remote prune origin &&
> +		git update-ref refs/remotes/origin/fetch-prune "$one" &&
> +		git fetch --prune origin &&
> +		git update-ref refs/remotes/origin/atomic-prune "$one" &&
> +		git fetch --atomic --prune origin &&
> +		cat >expect <<-EOF &&
> +			$two $ZERO_OID refs/remotes/origin/remote-prune-a
> +			$one $ZERO_OID refs/remotes/origin/remote-prune-z
> +			$one $ZERO_OID refs/remotes/origin/fetch-prune
> +			$one $ZERO_OID refs/remotes/origin/atomic-prune
> +		EOF
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'remote prune rejects a concurrent update' '
> +	test_when_finished "rm -rf race-empty.git race-prune" &&
> +	test_create_repo race-empty.git --bare &&
> +	test_create_repo race-prune &&

same as above.

> +	test_commit -C race-prune one &&
> +	one=$(git -C race-prune rev-parse HEAD) &&
> +	test_commit -C race-prune two &&
> +	two=$(git -C race-prune rev-parse HEAD) &&
> +	git -C race-prune remote add origin ../race-empty.git &&
> +	git -C race-prune update-ref refs/remotes/origin/race "$one" &&
> +	test_hook -C race-prune reference-transaction <<-\EOF &&
> +		marker=$(git rev-parse --git-path prune-race-once)
> +		if test "$1" = preparing && test ! -e "$marker"
> +		then
> +			>"$marker"
> +			git update-ref refs/remotes/origin/race HEAD
> +		fi
> +		exit 0
> +	EOF
> +	test_must_fail git -C race-prune remote prune origin >out 2>err &&
> +	test "$two" = "$(git -C race-prune rev-parse refs/remotes/origin/race)" &&
> +	! grep "\[pruned\]" out
> +'
> +
>  test_expect_success 'hook allows updating ref if successful' '
>  	git reset --hard PRE &&
>  	test_hook reference-transaction <<-\EOF &&
> --
> 2.39.3 (Apple Git-146)

--000000000000ff80e2065bfe9dec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fc7a8fc7176da452_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xeE40c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1RqQy85Zll5YXNjUVlwSkFZYitRM2NycEd6VXhFMwp5NEhTNHQ2cW5F
bVZYYjJQdXMyckdseGZHZVhnejhnbE03eHhOS2pUTlk1VmJ2TFBSWmFkVDJFNjh4cWc5S0ltClNN
bGtwQ09yRExmT2dJc0xrdk4wR3ZuTU9pQnVpeldTcHFtc0c0emhTVjExTkN1L29Qd2gvQ1Q0bldo
MHN4azMKamdLTjlyS2IrWmtCek10dnpHdktnUld5cExKVGhuWVlaZ01RbVNVbktlTjhIL2V2NERF
QUovcnJwdmJ3VU9QQgpkOFZoV2Y3VmJEZlkvUHdLTFBZdTQvVDgzRXkzckJRRkdIMWthMk1ieS9P
MGg5bWppT1A1WDA3cis4TDlKcmRtCkJBVnd6aWQvbXFqUVMzYnJZb1pRRUhlbDdsODNpa004OStM
UTNnTFlLMnA0Wkh3L0ZxRjFDN1Q4NlhMRWxLN1MKR1A1QmlyZlFqcFF3SEFpeTBOWU9lOHgrMVl6
ZU9uSWU0akFYN1Vhekx5RVQ5RytNMkdPM3ZvRVQvQXBrTWY1dQppWG9hNlY3UG4yMklPK3h5UmRu
TE50bzhObTQyMUZ0T0NVVnhOSklIZ1dId3l2S0pzUDVwdjdHdEliVk1SZldwClN6U0o3akdHL1JH
dEl4VDZPbC9iaDZsVEQvY3FNTHM0UHZ6bmc5Zz0KPTN4bCsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ff80e2065bfe9dec--
