Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4549DB85
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996794; cv=pass; b=A3Pjt/6bX0Sf32umCkZgtv3zNpqwbNew9wacJQ+tUSxmGlKMbthDSXFVIh2nbCM7skKMJKcJg3aUI9oS8Dde9uSiSlDOPWQn/gwCzWFRdC7yQBEG6KHKba2Z/JgDPZ377oZJi5NpbPh6ePlqNYzq6IOSmqhKJAxv43r0w3kQYDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996794; c=relaxed/simple;
	bh=UzuQ88WCYA/QdFAU+ZUznBc0p3yUIrr2eXKYKLa+GD0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1EwKAtE4cQQXa1jhrs5/khN8597C8uPgUAIZskLmP1ASpDBP5Skt7Cv24dNsIRToUeE3qK5R7tf7KWQ8W/w6ib+XxYBdmQ1kgJfSbpNTeHEgGddUZ6z0IHH/MO1G6Rdbl9Od0fpmD1v17JhCoebzCVRjHkAqBQSM1h+0Dre19k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klbNdz+E; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klbNdz+E"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c72bfe9so628067241.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 06:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789996788; cv=none;
        d=google.com; s=arc-20260327;
        b=jHkDNuWIEW380GFYhVU2UBKdFykskhVHfgzUal2r1HFNjxzYu4VfDAGaiBG2cLYXKa
         V4vHpJyzBW+xfrhJ3zke+CCwYAsJM6F0/xSH5BT7QXU5x8d0h2mB2rQBbRmq5m1uPzEu
         Hvn9BQ0Si678CKh7s/73BMzIlaLZRyEXCziR66iP/TAd0JNmIW3aYsX0WWk+dpdV+6pb
         CRCnn4gW0RU3LTCHW86RkKDuMDFlWGufnrSOXVpV75slV4e061x4SzEClNkPHoe8o47Y
         UjZ+4cVW7/4zOUvUdO83oK4xiyNyeeXuX9/97/xVuFnwxGRSL5Rb35jz1LGuch2zP/HX
         U7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=BJvotte/EPSdE7hbPIR/z5uS1nj8j/5J8EvZibTzOIM=;
        fh=lRZ3tJbTT25zdH6OxD5LaTk4sRoYcDd+KJuK5KbfmjM=;
        b=QUfTt/dmIPtA+IZ2i2dToPf9dxkeQWLsxMjdv/0ePHaITqv5a2IX0D+hMS8ipbMm8x
         E8/hSdEXpRri6b1t05n31cA+MlR03yDEtBjANaA8zDbylJo+XddhmSIonqwiqhC+i95h
         p/4clNVSZoqvu2k6O3Bw+/3g/dUZ/NiiwMaM4VQgJi42BFzgfEk4jWwAqEqKCr969ket
         9tgmfjKkpvPuPWmq3lxtJwF932FH1iFbgE+/NW/8O1ux3CcYb+MHePeQFz1dNOegrKrK
         ZMa3ciGYZ7D/WDoa55RaUxsTGCROj9t1M7AoOyTqz+9PMDPQXuY8F+MSfPLigq7ztp/C
         93SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789996788; x=1790601588; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BJvotte/EPSdE7hbPIR/z5uS1nj8j/5J8EvZibTzOIM=;
        b=klbNdz+EsvniauygXzziWVjFRwyLc9V/kVswUeP0Ebtfi8DtqXSOesePjahI2MweEE
         E+fibs49mZkgJpMofL8d3EQQhbc4E1JT4wB/pm4Gw2/6hvO8Up1/6J9fNSqm0jgurPBw
         J0GjcfeDN8vHfuTWDt/EX5cNFru8sOx6rrZfsVIrD1LJuX964+/rK64JVslqRwP+JTnp
         49XkyZfOJUyMFBnMG1jQuVsGHZddu26FaOfkV+tZsX7NYT3YWkzPrNIicl7ddSjRPcR/
         OsD4s6FN9oGlz26/DbBigB53e2MT7IU527qegTjY9pdkJv7SOfRf1cEeVyR5y3bBiM1/
         BYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789996788; x=1790601588;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BJvotte/EPSdE7hbPIR/z5uS1nj8j/5J8EvZibTzOIM=;
        b=UxasPneONg/8NknZFcSdedmcucYyYpOFeWJHNqSkm9Jlkqhq/mCEENzIJT5fhwb+vz
         pJp83MpUuxqa3zOlJwjahBKCAsvWf+MDVghOqPmH+A5s1YL7bndIgVqf/8ZIMi6ArC1d
         Wk01Sq1R/IXXv/vWsQK1QfCg6EsKGOZOhEwGMf1enk3V4Tzrk2BUoV6qxeo+OZfzS1lR
         wvrKJ9cZJ2CLqddpJQylb2unD+UF3JndQsjdmeN2goWDhRZhZMryDE7cLOUBWioNvm2t
         okUwZTI/2Py9c3J6swFLh0bRmvrFKk5zUifLGYKH1hpepik1FP+xhqt6HXOBQysq6Xef
         5Uwg==
X-Forwarded-Encrypted: i=1; AKwUvBxOAW6wLrp34qxFfwXij3MijzTZ9cIAV8EvPsp1AIkUMjeAIh7VdapAVIRtqDzwbK6qyx0=@vger.kernel.org
X-Gm-Message-State: AFuF++kXy0fq7FzXyJynbpEWnHC5t5eV9+j7+7Ed5JD8sPGuRA8skNPv
	swQov+2wbtW2kwH7L1ShBNpJr1TwPXeA9yml8RqXkTGCWpNjbJWN5pJuZvUdgkLxxZD58VUn0A8
	ZfjNws3AAzklA0J56Xo25uomR5FofUK8=
X-Gm-Gg: AYBFou14SF/jYA+iW8oug6QOR0tW47K6nK5AeyyNp/RRdUdFGesWl7mp5JIjUd5W8QT
	0DSHNeOPSeTa4QccT74xDG/W2hTo2LeF3ww9v0KJSU5rfwxAYhDacPCpmjhfrK1aNYAJesC8dG1
	Ya+fv1Q6JEBtPg8iC7o91Ew/7Li0le7anaR//uGZzUshfjz09UMaU1CzZlML7z8KXAiPKnHOI4Q
	gPhmUyMQ5KjdsjWuYjgZXVN4lCRxzEt5l6NRVe7EJ2JNNVg7WdqvxVdxE5kAbbRBgbPA6CPBfzx
	ryEqBdYyQqOliwj84LlmsZK7I31vWY+A8oj0oPVO4biWO9a+b7DobQPIZcktwF/rM5nEym9r1yx
	o5OD+oxIK0dJO+ko/4CtroMwx8zCB0ADIG3AvcNm7uEYAQaPkDGtEGnDH
X-Received: by 2002:a05:6102:5e86:b0:7a2:2068:6b5e with SMTP id
 ada2fe7eead31-7a6cb885c08mr2010666137.24.1789996788421; Mon, 21 Sep 2026
 06:19:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 06:19:46 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 06:19:46 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <d00fdeba2f673cf5a174f919452694c733736e84.1789901584.git.maciej.ciemborowicz@gmail.com>
References: <cover.1789901584.git.maciej.ciemborowicz@gmail.com> <d00fdeba2f673cf5a174f919452694c733736e84.1789901584.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Sep 2026 06:19:46 -0700
X-Gm-Features: AcwNN1XNOcX-OkpBf6wxo5RNJHtR8nl8iy_wTtCTgwnWwrQWUplhCVM0HFXAsZE
Message-ID: <CAOLa=ZRoNm_kS5CvUH3o208B7+2JSud8o5xAe2ikjYGNVwZiaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] branch, tag: retain old OIDs in batched deletions
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Phil Hord <phil.hord@gmail.com>, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000b93086065bfe1a39"

--000000000000b93086065bfe1a39
Content-Type: text/plain; charset="UTF-8"

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> Before 8198907795 (use delete_refs when deleting tags or branches,
> 2021-01-21), branch and tag deletion passed each resolved old OID to
> delete_ref(). This prevented the command from deleting a ref that another
> process had changed after it was inspected.
>
> The conversion to batched deletion dropped those old OIDs. Besides making the
> deletions unconditional, this causes reference-transaction hooks to report
> zero as both the old and new OID.
>
> Both commands still resolve the old OIDs before starting the deletion. Pass
> those values to refs_delete_refs(). This restores the old race protection and
> lets hooks receive useful old values without adding any ref reads. If a ref
> changes concurrently, the transaction fails and preserves the new value.
>
> Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
> ---
>  builtin/branch.c                 |  6 ++++-
>  builtin/tag.c                    |  6 ++++-
>  t/t1416-ref-transaction-hooks.sh | 44 ++++++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index f1abeb681..9f03ebc09 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -16,6 +16,7 @@
>  #include "commit.h"
>  #include "gettext.h"
>  #include "object-name.h"
> +#include "oid-array.h"
>  #include "remote.h"
>  #include "parse-options.h"
>  #include "branch.h"
> @@ -230,6 +231,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  	struct strbuf bname = STRBUF_INIT;
>  	enum interpret_branch_kind allowed_interpret;
>  	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
> +	struct oid_array old_oids = OID_ARRAY_INIT;
>  	struct string_list_item *item;
>  	int branch_name_pos;
>  	const char *fmt_remotes = "refs/remotes/%s";
> @@ -314,6 +316,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  		}
>
>  		item = string_list_append(&refs_to_delete, name);
> +		oid_array_append(&old_oids, &oid);
>  		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
>  				    : (flags & REF_ISSYMREF) ? target
>  				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
> @@ -323,7 +326,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  	}
>
>  	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
> -			     &refs_to_delete, NULL, REF_NO_DEREF))
> +			     &refs_to_delete, &old_oids, REF_NO_DEREF))
>  		ret = 1;
>
>  	for_each_string_list_item(item, &refs_to_delete) {
> @@ -342,6 +345,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  		free(describe_ref);
>  	}
>  	string_list_clear(&refs_to_delete, 0);
> +	oid_array_clear(&old_oids);
>
>  	free(name);
>  	strbuf_release(&bname);
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 40874a292..0a3eb70fa 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -119,11 +119,14 @@ static int delete_tags(const char **argv)
>  {
>  	int result;
>  	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
> +	struct oid_array old_oids = OID_ARRAY_INIT;
>  	struct string_list_item *item;
>
>  	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
> +	for_each_string_list_item(item, &refs_to_delete)
> +		oid_array_append(&old_oids, item->util);

Nit: wouldn't it make sense to add the oid to `old_oids` within
`collect_tags()` instead of iterating over all tags again?

You would have to change the callback data sent. If not, we should call
this out in the commit message at the least.

>  	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
> -			     &refs_to_delete, NULL, REF_NO_DEREF))
> +			     &refs_to_delete, &old_oids, REF_NO_DEREF))
>  		result = 1;
>
>  	for_each_string_list_item(item, &refs_to_delete) {
> @@ -137,6 +140,7 @@ static int delete_tags(const char **argv)
>  		free(oid);
>  	}
>  	string_list_clear(&refs_to_delete, 0);
> +	oid_array_clear(&old_oids);
>  	return result;
>  }
>
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
> index 4fe9d9b23..01b5ba8c4 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -14,6 +14,50 @@ test_expect_success setup '
>  	POST_OID=$(git rev-parse POST)
>  '
>
> +test_expect_success 'hook gets old values for batched branch/tag deletion' '
> +	test_when_finished "rm -f actual" &&
> +	git branch to-delete PRE &&
> +	git tag delete-tag POST &&
> +	git pack-refs --all &&
> +	test_hook reference-transaction <<-\EOF &&
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
> +	cat >expect <<-EOF &&
> +		$PRE_OID $ZERO_OID refs/heads/to-delete
> +		$POST_OID $ZERO_OID refs/tags/delete-tag
> +	EOF
> +	git branch -D to-delete &&
> +	git tag -d delete-tag &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'branch deletion rejects a concurrent update' '
> +	git branch delete-race PRE &&
> +	test_hook reference-transaction <<-\EOF &&
> +		marker=$(git rev-parse --git-path delete-race-once)
> +		if test "$1" = preparing && test ! -e "$marker"
> +		then
> +			>"$marker"
> +			git update-ref refs/heads/delete-race POST
> +		fi
> +		exit 0
> +	EOF
> +	test_must_fail git branch -D delete-race 2>err &&
> +	test_grep "is at $POST_OID but expected $PRE_OID" err &&
> +	test_cmp_rev POST refs/heads/delete-race
> +'
> +
>  test_expect_success 'hook allows updating ref if successful' '
>  	git reset --hard PRE &&
>  	test_hook reference-transaction <<-\EOF &&
> --
> 2.39.3 (Apple Git-146)

The rest of the patch looks good! :)

--000000000000b93086065bfe1a39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d41913ddf7bf7660_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xeEx2QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlhDQy85WWxDaDdibVppaWdMb01tcTNWMVVVZlVqcgpjaUE2ZTU3MGds
aythVmFmK0xteGk5ZExPcEhNK2dsS01lcTY1QTdJd3cycXhGWWw1akI1T2NZM0ZCVldCa3lUCndJ
eEpQR2tCcFRyN3BXZzNaUitvZkZyaTBLYlZlNC9RWi9CU1R3bldUc2VyN3BhK1hRMnJMRmp5RHI1
TzBZSjkKQm5tZzFwUUNsQ0l2dHdmclNxamJWb01IajdJUDJ0eFUzQ21FOHZyQ1FqeGRkRHpKU0JB
ZnhWNnBaUmVaWjgzcQo4M3hZOFpKUDBnNm02cDBoRXl6Yk9ab1pzT2VCazdUVW5qSUwyNUc0aytm
RTdwa0lEcUZ1WHE1ajhDR0kzSENhCk9wdUwxZ0pPeU9wcmJxWXBQUi9jOFplVkU0TSsrdlo3MWl1
OWMrK2NsNVZFeFoycFVBcGRQSGtUOWlyT3RYNkEKVFVxU1lXQkV5ZC8wa3hSa1p4ZW1QcVVnd1hk
SVl6aDgwYzdkNXNmZjBaSVk4OWNSZnpIYWQzQ05BZGlyaVQ0Zwo4RkdkbVJFaVdHNkRZNENYUUhn
V29ja1lXVlZIOEpnUG5adDAzUTc1b1lWcmpXMFY1a2VtWklVcVlhWEFMQWgvCmVtbVB4QWh2L29F
Nk0vTmhlTkYrdlFjTlg1NGIrdy9sNHNGcWpRWT0KPTdVYVoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b93086065bfe1a39--
