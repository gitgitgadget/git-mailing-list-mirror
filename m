Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6CC78289
	for <git@vger.kernel.org>; Tue, 21 May 2024 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306104; cv=none; b=lLTJQMFUq3mKoNVKS4yIA7u+taVBor22zZ5I4q6l/3iJZli04RImZ9BsNaQKkV5VRuFsblliFrRjNsrkvFuU7utJA6yKlQACCTwr5ENCU92XUHlwFG2aonlG03yaF/i6nzLB4qMSCFVqgJ9PPQi6hN1XWTeKXiq73ha2gWHvtqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306104; c=relaxed/simple;
	bh=A5HlDcfJeQjIFlaaQeYKrI6sOggSwPArBTKR4w0GDgM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=an8CWpUK3V/yQthWQRlJSF+MnxBzkR5fnDqJ9qDY9PEUXpeqDVspN0D8g6HFw+JgDtE0mb9q+Zo8SFYUDEYJaKPm3Z2I0wsbJTYv2bFiH0Bp0kwaS0UZnYfStycs+i5FfRltMJ4qR7TFdrHVp856p9R98uwUpoVVbIch75fEAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpfevJq0; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpfevJq0"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2454156db8bso1917953fac.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 08:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716306101; x=1716910901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYGxYqTwGM8DvPxUfxsWmO3YMbbrNAs5Hk/sWeJdhbw=;
        b=LpfevJq0ybalg2Q1WxD9F6UBHCvkpKgIYTaWXeT0ie8L+359T7QoEqBeklMDYZYQ9f
         cA9MA5gWdMZ4v0u53dd5pMobi7rtCGSYghbHLuhA1FETcL/6H/yXudXXS+VvG+1dsh6R
         E31elTf+jX160dEHos9UmrWhYqOOLvbrRhk6wztyMU1AErOdV15N9ib49J3K2SozNe8g
         jyCsJiFZPPLKelVj35e2QVNbuHpJ/T1EHTztA9POFJGe1oT3cpZfThUG7l6cZqMZI5e5
         HYhQr1RWJcIeGC/TnH0F/oodwrQky0DAbrY0l8wFrcohFWTLMwpl3x5++RpLkElUsQRf
         Kesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716306101; x=1716910901;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYGxYqTwGM8DvPxUfxsWmO3YMbbrNAs5Hk/sWeJdhbw=;
        b=MqMxMUTOe1+Cb4LttOXjdrp5ERQrNiWtAR98T6COvP1G7MVN9r0vGR8Dk+ntsWxR2d
         N1DGSKwrlEqUkW0M/B2g/Pw4qCLhrqNqKYY4+Ny8f0jmZ0O6uqQxVNDvz0CzwTitX8cc
         1tqVtnLpOAetnaAvRAb+BV3dHyHcQjjpPDex1I/QukrqYYNJnAFLf9WT3MugMuRNZL6E
         XQaXU2WgnltvjojIHG9plxsER8KNU6V7L78TGbBDYhNeRFBhRYgBfb8h9JdxYSe6eUis
         8ayVm4cMkUDUjzMbVOek9wouul0fg5n5Vz/CJy9A0v0jBEcd8U32Ai4+3WtihOGxzXLb
         fEpg==
X-Forwarded-Encrypted: i=1; AJvYcCXBEv5nEqFry1iyroivKmGNXPu6Fkht+i1x1VRss8napLJ3j4OuZ8j68ZuA0nZmGGdYg+ag2ReJkCqZM2P2R6xJ9G0k
X-Gm-Message-State: AOJu0YyznguGLbkbl0I9SFWjEgZr/yvidc5WDRig687HxhxN0mi1kPSt
	EARbkCUvpPOtZz4JRLNeCcv8YcrxFJwHnqkDEzsjaAmfZ6r13+UBbzOCj3lOCDVxlXnVtCWlSv8
	OhG8zIkfLH14kpHGbDi+6wzfI4iU=
X-Google-Smtp-Source: AGHT+IFgfjj9LYE1/EvpbtqBMvA8WAxStRm2EkVavOI0GPVnrQ7BkfpT9/Zvk/YdZRxYGDeJNKknoPhJe9yC+KeDF2I=
X-Received: by 2002:a05:6870:891f:b0:24c:5cda:9006 with SMTP id
 586e51a60fabf-24c5cdacf44mr1210957fac.38.1716306101281; Tue, 21 May 2024
 08:41:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 May 2024 15:41:40 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
References: <pull.1730.git.1715742069966.gitgitgadget@gmail.com> <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 May 2024 15:41:40 +0000
Message-ID: <CAOLa=ZR2QU-76ovpMF4xRvAzY447ce+oAYCaiiMTcFGL7Q52-A@mail.gmail.com>
Subject: Re: [PATCH v2] bundle-uri: verify oid before writing refs
To: blanet via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Content-Type: multipart/mixed; boundary="0000000000007e46620618f8a74d"

--0000000000007e46620618f8a74d
Content-Type: text/plain; charset="UTF-8"

"blanet via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Xing Xin <xingxin.xx@bytedance.com>
>
> When using the bundle-uri mechanism with a bundle list containing
> multiple interrelated bundles, we encountered a bug where tips from
> downloaded bundles were not discovered, thus resulting in rather slow
> clones. This was particularly problematic when employing the heuristic
> `creationTokens`.
>
> And this is easy to reproduce. Suppose we have a repository with a
> single branch `main` pointing to commit `A`, firstly we create a base
> bundle with
>
>   git bundle create base.bundle main
>
> Then let's add a new commit `B` on top of `A`, so that an incremental
> bundle for `main` can be created with
>
>   git bundle create incr.bundle A..main
>
> Now we can generate a bundle list with the following content:
>
>   [bundle]
>       version = 1
>       mode = all
>       heuristic = creationToken
>
>   [bundle "base"]
>       uri = base.bundle
>       creationToken = 1
>
>   [bundle "incr"]
>       uri = incr.bundle
>       creationToken = 2
>
> A fresh clone with the bundle list above would give the expected
> `refs/bundles/main` pointing at `B` in new repository, in other words we
> already had everything locally from the bundles, but git would still
> download everything from server as if we got nothing.
>
> So why the `refs/bundles/main` is not discovered? After some digging I
> found that:
>
> 1. Bundles in bundle list are downloaded to local files via
>    `download_bundle_list` or via `fetch_bundles_by_token` for the
>    creationToken heuristic case.
> 2. Then it tries to unbundle each bundle via `unbundle_from_file`, which
>    is called by `unbundle_all_bundles` or called within
>    `fetch_bundles_by_token` for the creationToken heuristic case.
> 3. Here, we first read the bundle header to get all the prerequisites
>    for the bundle, this is done in `read_bundle_header`.
> 4. Then we call `unbundle`, which calls `verify_bundle` to ensure that
>    the repository does indeed contain the prerequisites mentioned in the
>    bundle.
> 5. The `verify_bundle` will call `parse_object`, within which the
>    `prepare_packed_git` or `reprepare_packed_git` is eventually called,
>    which means that the `raw_object_store->packed_git` data gets filled
>    in and ``packed_git_initialized` is set. This also means consecutive
>    calls to `prepare_packed_git` doesn't re-initiate
>    `raw_object_store->packed_git` since `packed_git_initialized` already
>    is set.
> 6. If `unbundle` succeeds, it writes some refs via `refs_update_ref`
>    with `REF_SKIP_OID_VERIFICATION` set. So the bundle refs which can
>    target arbitrary objects are written to the repository.
> 7. Finally in `do_fetch_pack_v2`, `mark_complete_and_common_ref` and
>    `mark_tips` are called with `OBJECT_INFO_QUICK` set to find local
>    tips. Here it won't call `reprepare_packed_git` anymore so it would
>    fail to parse oids that only reside in the last bundle.
>
> Back to the example above, when unbunding `incr.bundle`, `base.pack` is
> enlisted to `packed_git` bacause of the prerequisites to verify. While

s/bacause/because

[snip]

> diff --git a/bundle-uri.c b/bundle-uri.c
> index 91b3319a5c1..65666a11d9c 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -400,8 +400,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
>  		refs_update_ref(get_main_ref_store(the_repository),
>  				"fetched bundle", bundle_ref.buf, oid,
>  				has_old ? &old_oid : NULL,
> -				REF_SKIP_OID_VERIFICATION,
> -				UPDATE_REFS_MSG_ON_ERR);
> +				0, UPDATE_REFS_MSG_ON_ERR);
>  	}
>
>  	bundle_header_release(&header);
> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index 1ca5f745e73..a5b04d6f187 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -20,7 +20,10 @@ test_expect_success 'fail to clone from non-bundle file' '
>  test_expect_success 'create bundle' '
>  	git init clone-from &&
>  	git -C clone-from checkout -b topic &&
> +
>  	test_commit -C clone-from A &&
> +	git -C clone-from bundle create A.bundle topic &&
> +
>  	test_commit -C clone-from B &&
>  	git -C clone-from bundle create B.bundle topic
>  '
> @@ -259,6 +262,132 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
>  	! grep "refs/bundles/" refs
>  '
>
> +#########################################################################
> +# Clone negotiation related tests begin here
> +
> +test_expect_success 'negotiation: bundle with part of wanted commits' '
> +	test_when_finished rm -rf trace*.txt &&
> +	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
> +	git clone --no-local --bundle-uri="clone-from/A.bundle" \
> +		clone-from nego-bundle-part &&
> +	git -C nego-bundle-part for-each-ref --format="%(refname)" >refs &&
> +	grep "refs/bundles/" refs >actual &&
> +	cat >expect <<-\EOF &&
> +	refs/bundles/topic
> +	EOF
> +	test_cmp expect actual &&
> +	# Ensure that refs/bundles/topic are sent as "have".
> +	grep "clone> have $(git -C clone-from rev-parse A)" trace-packet.txt
> +'
> +
> +test_expect_success 'negotiation: bundle with all wanted commits' '
> +	test_when_finished rm -rf trace*.txt &&
> +	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
> +	git clone --no-local --single-branch --branch=topic --no-tags \
> +		--bundle-uri="clone-from/B.bundle" \
> +		clone-from nego-bundle-all &&
> +	git -C nego-bundle-all for-each-ref --format="%(refname)" >refs &&
> +	grep "refs/bundles/" refs >actual &&
> +	cat >expect <<-\EOF &&
> +	refs/bundles/topic
> +	EOF
> +	test_cmp expect actual &&
> +	# We already have all needed commits so no "want" needed.
> +	! grep "clone> want " trace-packet.txt
> +'
> +
> +test_expect_success 'negotiation: bundle list (no heuristic)' '
> +	test_when_finished rm -f trace*.txt &&
> +	cat >bundle-list <<-EOF &&
> +	[bundle]
> +		version = 1
> +		mode = all
> +
> +	[bundle "bundle-1"]
> +		uri = file://$(pwd)/clone-from/bundle-1.bundle
> +
> +	[bundle "bundle-2"]
> +		uri = file://$(pwd)/clone-from/bundle-2.bundle
> +	EOF
> +
> +	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
> +	git clone --no-local --bundle-uri="file://$(pwd)/bundle-list" \
> +		clone-from nego-bundle-list-no-heuristic &&
> +
> +	git -C nego-bundle-list-no-heuristic for-each-ref --format="%(refname)" >refs &&
> +	grep "refs/bundles/" refs >actual &&
> +	cat >expect <<-\EOF &&
> +	refs/bundles/base
> +	refs/bundles/left
> +	EOF
> +	test_cmp expect actual &&
> +	grep "clone> have $(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/left)" trace-packet.txt
> +'
> +
> +test_expect_success 'negotiation: bundle list (creationToken)' '
> +	test_when_finished rm -f trace*.txt &&
> +	cat >bundle-list <<-EOF &&
> +	[bundle]
> +		version = 1
> +		mode = all
> +		heuristic = creationToken
> +
> +	[bundle "bundle-1"]
> +		uri = file://$(pwd)/clone-from/bundle-1.bundle
> +		creationToken = 1
> +
> +	[bundle "bundle-2"]
> +		uri = file://$(pwd)/clone-from/bundle-2.bundle
> +		creationToken = 2
> +	EOF
> +
> +	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
> +	git clone --no-local --bundle-uri="file://$(pwd)/bundle-list" \
> +		clone-from nego-bundle-list-heuristic &&
> +
> +	git -C nego-bundle-list-heuristic for-each-ref --format="%(refname)" >refs &&
> +	grep "refs/bundles/" refs >actual &&
> +	cat >expect <<-\EOF &&
> +	refs/bundles/base
> +	refs/bundles/left
> +	EOF
> +	test_cmp expect actual &&
> +	grep "clone> have $(git -C nego-bundle-list-heuristic rev-parse refs/bundles/left)" trace-packet.txt
> +'
> +
> +test_expect_success 'negotiation: bundle list with all wanted commits' '
> +	test_when_finished rm -f trace*.txt &&
> +	cat >bundle-list <<-EOF &&
> +	[bundle]
> +		version = 1
> +		mode = all
> +		heuristic = creationToken
> +
> +	[bundle "bundle-1"]
> +		uri = file://$(pwd)/clone-from/bundle-1.bundle
> +		creationToken = 1
> +
> +	[bundle "bundle-2"]
> +		uri = file://$(pwd)/clone-from/bundle-2.bundle
> +		creationToken = 2
> +	EOF
> +
> +	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
> +	git clone --no-local --single-branch --branch=left --no-tags \
> +		--bundle-uri="file://$(pwd)/bundle-list" \
> +		clone-from nego-bundle-list-all &&
> +
> +	git -C nego-bundle-list-all for-each-ref --format="%(refname)" >refs &&
> +	grep "refs/bundles/" refs >actual &&
> +	cat >expect <<-\EOF &&
> +	refs/bundles/base
> +	refs/bundles/left
> +	EOF
> +	test_cmp expect actual &&
> +	# We already have all needed commits so no "want" needed.
> +	! grep "clone> want " trace-packet.txt
> +'
> +
>  #########################################################################
>  # HTTP tests begin here
>
>
> base-commit: d8ab1d464d07baa30e5a180eb33b3f9aa5c93adf
> --
> gitgitgadget

This update looks good to me, Thanks.

--0000000000007e46620618f8a74d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b54759ac18f1273b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aTXdMSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlM1REFDanRraVlDeTdKeHZNZjR4NXBRM1JhUlFmUApYQWRoU2lyTXkv
eDBEYlkyZWV4TGVxTUJiMlZibG15cUpiNDMwMWpOOVlSUmY2NEorM1BlcmdpMVpxcVFLYUJhCmwy
Tk5vaVdmQUhmdHprSHBJeERiRzMxUDBMTmlrR1k5UkJxcnZ6WExJYUtmTHNQcWhUcnhJUm9obUlP
dWdpczIKaWc4OFo5aWN1VTh5ZFlxR3lHQmtrVUlqczVLNE1VeUNvNTRGM2tROXRBVXNoUE9SRVo4
bXpYZCtubTlXQkZNYgp1NVl1RFlMb2V6U1JnT2F3N3ZFWGo2a3hnVVU3dzdjRFFyUkRDeUE5eXN3
U3RxdlpRbU9RU0g3MXRDQisybSt0CklaeUlZNUsyUnZrOEhpNW00eSt3UVA4VDkzUEgwTVpMdEJx
VGZIQ2hMUExjTW42UkMwOTJ4amJZbmxlN2hvUVoKRWVRZzMyMEo5MTV5SndyRXo3RFBrcFNNNHcr
VVEySGxkNWp5L0ZxRDUyZkxHaGNqUE4zaGNhVmlwQzI2dVdBRgptZUo0aGkyTE1qd2F4RDZOZmt2
RXE0czlVVlNVOEovUmRXdld1REtzQXliQkhrdkhsOWcrSFVxdTg4YjlLVEFBClhxd0Nac2tsdmw1
MTkyeUwweEtEeHpqeWtvaFZvRFJIWTU0Y3FsYz0KPTFqelQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007e46620618f8a74d--
