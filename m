Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F373BD63D
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835779; cv=none; b=KIyRdiYeeG7jOzLlqsWmALdH8VJAWudlr6qrXISMGJobSdDjJEyHvT/1ziXYZitdrrl36N/OUWuGUzJsFJhJbo7vhedHmADTGTrtWsuXzjjR6Xd1Gd5SRG3jCEQYciB+9WwhBVJTbaPb+MBHD3huhuhYNIUBRRIdjRxwOzXsGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835779; c=relaxed/simple;
	bh=H+RhntVnF8z3NiEY21NhLXfUnzrbRBJAJwJU2pQ4YAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsjuG8zNmpE6oH6rd7RW9KX9KRQowmPEZ84zni2tbHL09bUjEnPoKlpUAeixSOk0cB40XrzgxTVxChGZnvAJF23AM4xvNih+uVNMMCvqZ0hBSayBADJjYE65U/vlLRAj1zU0V30U2jV5nztrYtKK8l4XH6jBBuTyce6c0XP+un0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0ZPcgpz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0ZPcgpz"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so858635a91.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784835772; x=1785440572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/7MiO+8iAADlRuSMZ1FP9lDHcA0FfrPUrBuw4UcM5qA=;
        b=J0ZPcgpzrtGmY2hbrMl+1gANb8IemAZvfi3QCEa6oZ9UZGRbshzrIYNAFBrk14AXbW
         o8u8lKqaoEe8TWNFgeA1h+xZ577Ifx9dmNfEcYm0ge5bfyy9lM4tjwFLFL+czKtv8LTn
         dDpxGlFdMZthsijuF/Dnp8eZ2BGrwKJ3Z6Gk2vCDYBNUbz8yD+l9E4EfTX53X9b7VCYg
         MM3/MDQJMqqy1FPOWjoNFGqYS4L1haPjYmrAlVHInzYxsFpUMPOQmnT7Jv12wpt5RLUA
         WQcpqHAIGkUkz6f+u7Tdpz0fPAVKytEHhGrY5k8YOoYP0WQKgCMwm7lBhL7OyNCflUir
         rJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784835772; x=1785440572;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/7MiO+8iAADlRuSMZ1FP9lDHcA0FfrPUrBuw4UcM5qA=;
        b=aQ2njqvnBQ63O453pCVgB8qvrxPItcPyhLV5dD6ivh+f/BmHsikc2Bnqzz45oMUPdW
         mvnoHH3372+JsvzykdZyemDU7YoxhDUk8F5R8WUhKXQDAdw64YQhCw6NArhP8lPy4LkM
         YcwQtkb7j9yI/6PVLIiz7Oh9Gf1nXmfglb+xsu9/LWJhssyGicWUt64aUFZVqvLsoeI2
         p9wAvjEYENSRpVkjMGDGDiLPCSdoiOd1rNV1GRO8tsTXAYCNZx6Ot6lGW7lNMUbGsAag
         5QhGGpsO4ci8uh57iyvLvxWce4q6wVxmuyJ2z5foLCZLAwVu0aRo9IM2R4nlNK8SdiCB
         KT+w==
X-Forwarded-Encrypted: i=1; AHgh+RpMNewNrmgo6wNM6+aCKAhdwp0p5R9sGo1vcqT/QBfrD2dQQR4g1/ZajSlptsGbtvcBTtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ5/Cah6Y/98audHA/iyq4LESoBROtM8KtRe/Sj1jy5kc3EGJK
	y4ll2hqAItXh6nrnGP1vt/LmEDIwfNFLJ8YgqIQQGRRs6ESg9CPNh6Lo
X-Gm-Gg: AR+sD11cy37KcotY3KKpjX+/S91WMWccDSvxutZkb00+OvP6gsrQZsiQb7N/HJtobTs
	9pt1iWe+LO2i3QasMHMQzMsEx8TYLiF2Djhrs/nGGgZpId+iKV45h3gfo7oQgSIyXO/zAUQbbZA
	EOJFYmbOsyiwcB1cmNGxeIhm9YX+TYSdMiDfru+CyNYCrielVRowQWv7qKdUuh/ttETz7CbH7eC
	TLsvsrzhcu2pldl1vD8Bgx5DevkNtwFLJHSsQ/ekC21ssuTk3XfqFk+FOlBHmLPzyS00o86F1yI
	VciSxMbh/nxxoCeqZ5g4YrwKM3uh0/ZFK4Li9/VUxVVEhGyXl2CGw0LFRWVnmGWnL0v874xLXRP
	XqM9u5UCe+fUD6ioreemsNTUh7e7HAE2r9zr3ZYG1Obt/ClaLk/nxkwd8dukCYjwobiAVOzRQ/N
	Zjx2UE5lO025dSlhAMypRdMsL4N/LKDd8Pcwac88fZ9Kg0MNVamLCeN7I6LXsQj6T5MvLbxSEIq
	JOE0DhBHy6iqSkQCYjEHWMarRSyG4vYuabAw/xyyIhv9Q4w26jNCXAmfncGBSNIO6FbJvP3VQYg
	k1JJ3VcMiIkiqsfX8udeebai9Q==
X-Received: by 2002:a17:90b:5650:b0:38e:cb1:8ec9 with SMTP id 98e67ed59e1d1-38ec661b520mr4498293a91.42.1784835772416;
        Thu, 23 Jul 2026 12:42:52 -0700 (PDT)
Received: from ?IPV6:2409:40e3:40f2:e504:b8c9:6fa8:29d4:f006? ([2409:40e3:40f2:e504:b8c9:6fa8:29d4:f006])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm30724784c88.2.2026.07.23.12.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 12:42:51 -0700 (PDT)
Message-ID: <ec546f71-3412-47ef-a4cf-98558889a90f@gmail.com>
Date: Fri, 24 Jul 2026 01:12:47 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] builtin/repack: actually drop filtered promisor
 blobs
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
 ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260716132848.95982-7-r.siddharth.shrimali@gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <20260716132848.95982-7-r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/07/26 18:58, Siddharth Shrimali wrote:
> Make --drop-filtered remove the enumerated promisor blobs instead of
> only listing them.
> 
> The drop set is computed before repack_promisor_objects() runs, and on
> a real run it is passed in so the rebuilt promisor pack omits those
> blobs. --drop-filtered implies -d so the old promisor packs, which
> still contain the dropped blobs, are removed. Without this the blobs
> would survive in the redundant packs. The existing repack machinery
> performs the write-before-delete and fsync, so the drop is crash-safe.
> 
> The dropped blobs become absent locally but remain recoverable from the
> promisor remote, so a later access lazy-fetches them back
> transparently. --dry-run keeps its previous behavior, i.e. it lists the
> candidates and changes nothing.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>   builtin/repack.c                | 75 ++++++++++++++++++---------------
>   repack-filtered.c               | 17 ++------
>   repack.h                        |  4 +-
>   t/t7706-repack-drop-filtered.sh | 18 +++++---
>   4 files changed, 59 insertions(+), 55 deletions(-)
> 
> diff --git a/builtin/repack.c b/builtin/repack.c
> index c2b07477d2..aa3257a98a 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -15,6 +15,8 @@
>   #include "repack.h"
>   #include "shallow.h"
>   #include "list-objects-filter-options.h"
> +#include "oidset.h"
> +#include "hex.h"
>   
>   #define ALL_INTO_ONE 1
>   #define LOOSEN_UNREACHABLE 2
> @@ -143,6 +145,7 @@ int cmd_repack(int argc,
>   	struct string_list_item *item;
>   	struct string_list names = STRING_LIST_INIT_DUP;
>   	struct existing_packs existing = EXISTING_PACKS_INIT;
> +	struct oidset drop_oids = OIDSET_INIT;
>   	struct pack_geometry geometry = { 0 };
>   	struct tempfile *refs_snapshot = NULL;
>   	int i, ret;
> @@ -269,9 +272,6 @@ int cmd_repack(int argc,
>   		die(_("--dry-run only takes effect with --drop-filtered"));
>   
>   	if (drop_filtered) {
> -		if (!dry_run)
> -			die(_("--drop-filtered doesn't work without --dry-run yet"));
> -
>   		if (!po_args.filter_options.choice)
>   			die(_("--drop-filtered requires --filter"));
>   
> @@ -294,6 +294,28 @@ int cmd_repack(int argc,
>   			die(_("--drop-filtered requires a promisor remote"));
>   
>   		write_bitmaps = 0;
> +
> +		/*
> +		 * Dropping objects means rebuilding the promisor packs
> +		 * without them and then removing the old packs, so the
> +		 * redundant packs must be deleted. Imply -d on a real run.
> +		 */
> +		if (!dry_run)
> +			delete_redundant = 1;


Yes, without that the drop would not actually reclaim space.

It would be nice if the documentation mentioned that a real
--drop-filtered run implies -d.


Thanks


> +
> +		ret = enumerate_promisor_blobs(repo, &po_args.filter_options, &drop_oids);
> +
> +		if (ret)
> +			goto cleanup;
> +
> +		if (dry_run) {
> +			struct oidset_iter iter;
> +			const struct object_id *oid;
> +
> +			oidset_iter_init(&drop_oids, &iter);
> +			while ((oid = oidset_iter_next(&iter)))
> +				printf("%s\n", oid_to_hex(oid));
> +		}
>   	}
>   
>   	if (delete_redundant && repo->repository_format_precious_objects)
> @@ -406,7 +428,8 @@ int cmd_repack(int argc,
>   		strvec_push(&cmd.args, "--delta-islands");
>   
>   	if (pack_everything & ALL_INTO_ONE) {
> -		repack_promisor_objects(repo, &po_args, &names, packtmp, NULL);
> +		repack_promisor_objects(repo, &po_args, &names, packtmp,
> +			(drop_filtered && !dry_run) ? &drop_oids : NULL);
>   
>   		if (existing_packs_has_non_kept(&existing) &&
>   		    delete_redundant &&
> @@ -589,35 +612,20 @@ int cmd_repack(int argc,
>   		}
>   	}
>   
> -	if (po_args.filter_options.choice) {
> -		if (drop_filtered) {
> -			/*
> -			 * Enumerate promisor objects directly rather than
> -			 * going through write_filtered_pack(). The filter
> -			 * machinery cannot see promisor objects because
> -			 * repack_promisor_objects() handles them separately
> -			 * before the filter runs.
> -			 */
> -			ret = enumerate_promisor_blobs(repo,
> -					&po_args.filter_options,
> -					dry_run);
> -			if (ret)
> -				goto cleanup;
> -		} else {
> -			struct write_pack_opts opts = {
> -				.po_args = &po_args,
> -				.destination = filter_to,
> -				.packdir = packdir,
> -				.packtmp = packtmp,
> -			};
> -
> -			if (!opts.destination)
> -				opts.destination = packtmp;
> -
> -			ret = write_filtered_pack(&opts, &existing, &names);
> -			if (ret)
> -				goto cleanup;
> -		}
> +	if (po_args.filter_options.choice && !drop_filtered) {
> +		struct write_pack_opts opts = {
> +			.po_args = &po_args,
> +			.destination = filter_to,
> +			.packdir = packdir,
> +			.packtmp = packtmp,
> +		};
> +
> +		if (!opts.destination)
> +			opts.destination = packtmp;
> +
> +		ret = write_filtered_pack(&opts, &existing, &names);
> +		if (ret)
> +			goto cleanup;
>   	}
>   
>   	string_list_sort(&names);
> @@ -697,6 +705,7 @@ int cmd_repack(int argc,
>   cleanup:
>   	string_list_clear(&keep_pack_list, 0);
>   	string_list_clear(&names, 1);
> +	oidset_clear(&drop_oids);
>   	existing_packs_release(&existing);
>   	pack_geometry_release(&geometry);
>   	pack_objects_args_release(&po_args);
> diff --git a/repack-filtered.c b/repack-filtered.c
> index f5a1dae5b1..6f0cecca9b 100644
> --- a/repack-filtered.c
> +++ b/repack-filtered.c
> @@ -87,16 +87,13 @@ static int collect_promisor_blob(const struct object_id *oid,
>   
>   int enumerate_promisor_blobs(struct repository *repo,
>   			const struct list_objects_filter_options *filter,
> -			int dry_run)
> +			struct oidset *to_drop)
>   {
>   	struct oidset all_promisor_blobs = OIDSET_INIT;
> -	struct oidset to_drop = OIDSET_INIT;
>   	struct collect_cb_data cb = {
>   		.repo = repo,
>   		.set = &all_promisor_blobs
>   	};
> -	struct oidset_iter iter;
> -	const struct object_id *oid;
>   	int ret = 0;
>   
>   	/*
> @@ -122,22 +119,14 @@ int enumerate_promisor_blobs(struct repository *repo,
>   
>   	/*
>   	 * Apply the filter to find which blobs exceed the threshold.
> +	 * The caller has to_drop and is responsible for clearing it.
>   	 */
>   	ret = list_objects_filter__filter_oidset(repo,
>   		(struct list_objects_filter_options *)filter,
>   		&all_promisor_blobs,
> -		&to_drop);
> -	if (ret)
> -		goto cleanup;
> -
> -	if (dry_run) {
> -		oidset_iter_init(&to_drop, &iter);
> -		while ((oid = oidset_iter_next(&iter)))
> -			printf("%s\n", oid_to_hex(oid));
> -	}
> +		to_drop);
>   
>   cleanup:
>   	oidset_clear(&all_promisor_blobs);
> -	oidset_clear(&to_drop);
>   	return ret;
>   }
> diff --git a/repack.h b/repack.h
> index d08e25b852..61e554e4ed 100644
> --- a/repack.h
> +++ b/repack.h
> @@ -168,8 +168,8 @@ int write_filtered_pack(const struct write_pack_opts *opts,
>   			struct string_list *names);
>   
>   int enumerate_promisor_blobs(struct repository *repo,
> -			       const struct list_objects_filter_options *filter,
> -			       int dry_run);
> +			     const struct list_objects_filter_options *filter,
> +			     struct oidset *to_drop);
>   
>   int write_cruft_pack(const struct write_pack_opts *opts,
>   		     const char *cruft_expiration,
> diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
> index b558807847..41e7941799 100755
> --- a/t/t7706-repack-drop-filtered.sh
> +++ b/t/t7706-repack-drop-filtered.sh
> @@ -56,12 +56,6 @@ test_expect_success '--dry-run only takes effect with --drop-filtered' '
>   	test_grep "dry-run only takes effect with --drop-filtered" err
>   '
>   
> -test_expect_success '--drop-filtered without --dry-run is rejected' '
> -	test_must_fail git -C plain.git repack --drop-filtered \
> -		--filter=blob:limit=1k -a 2>err &&
> -	test_grep "drop-filtered doesn.t work without --dry-run yet" err
> -'
> -
>   test_expect_success '--drop-filtered requires -a' '
>   	test_must_fail git -C plain.git repack --drop-filtered \
>   		--filter=blob:limit=1k --dry-run 2>err &&
> @@ -136,4 +130,16 @@ test_expect_success '--dry-run does not remove the filtered objects' '
>   	git -C repo cat-file -e "$BIG"
>   '
>   
> +test_expect_success '--drop-filtered removes the promisor blob locally' '
> +	BIG=$(cat big_oid) &&
> +	SMALL=$(cat small_oid) &&
> +
> +	git -C repo -c repack.writeBitmaps=false \
> +		repack --drop-filtered --filter=blob:limit=1k -a &&
> +
> +	git -C repo cat-file --batch-all-objects --batch-check="%(objectname)" >present &&
> +	! grep -q "$BIG" present &&
> +	grep -q "$SMALL" present
> +'
> +
>   test_done

