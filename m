Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592600;
	b=3+CH3ebvShV5pNliOb+VITYWT3eNuoSX1owV9DLrjjf+W0tVOc+FABRwn0PWKSfcGOod
	 UtQZ1nP9mDyDZn94DjzMXrVJaPHsCq18f5EEAE0Ui19WCddDOyCdrN1zkTCCCMJ0nUyrQ
	 ma+f03R6Q8WUIEyxHCdFU8GceHilHNMkDko0vH07wPwZN/x78Zba0emG6vKc6d7oS/BCw
	 6A2J5NgYXSEiBU3Zttxv1AuEl9mh9Al/C+VUp/etfC6WNQC7ggO7WHw722VuKL/u/vl3b
	 +6HBzNCCfEodPzA8NSVzl61alGsuZZQfAvM9oXSXufPincu8qEZFHUe9LYz+SdtzlIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=rgbjqUjgri3y4Qotxqo2hzqfIjUvTE3IQoCcnnZRUrA=;
	b=i/YmKvtfpBxD/y2Z28hy+aq8r/il20T7oEIoVE0JN7902SvNXkiuSe6IUDxDqQwvSaeo
	 Xd4Hm+/SmLJJXDgG0EkFeIRNtuw6uLNwPwJnwbKnKtuxHOuX95T8jTh4wq9pLWZGYD1bw
	 yqVOxbkaVOYK2u3IfCeKFOIFMmt6aOufbkKD4hFuglZxszpH5ZyBZNp/k8816ylgHLN5w
	 Iw6JpU0rIF00IhfO2pDazKoUgA0COBP7Uyl6EIg12yZqx+uBzg/WB0ENyWOBhCyvXfRTN
	 qG+odZfGtSxCCQ+PNuncCu9mqda2auvhILgstxu8UxverNuYKYlKmS9pP5XpcrYV8GA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZGPZ4YjL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7AA606A330
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C7AA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZGPZ4YjL
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7c2f48f3a96so275628137.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792592599; cv=none;
        d=google.com; s=arc-20260327;
        b=VxDDemJKTjFdR6PUuva9U13pIHjGiGb0wbRBTEFgp4A/x/Ixolh5FfrKiLnkt48sT8
         H6RK2CIYhseuMpMcYtKxm4X75NhFFzkZqhzBERx3Fb/3Qj55YxULFHAwOhWt7bTDCiIV
         eeJQcy3irWt3lKChVs5n5bz044OpOqW2fkjDDo12Jybq87bf/F2vJHsAJfrFou7Jsu3e
         eAjfSz/4EdCNnQTEgsqyuPBTl28UlC7LjUsDEpDfUkarEQYzh/Xa16CwJaw9aQiFhJR0
         BS2O6tLJ0Yc4QDXp+FOK/khicx8rjtNeSpkNpmvBB/6iJ6dnRYowm071rumSbcxeYwED
         aOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=rgbjqUjgri3y4Qotxqo2hzqfIjUvTE3IQoCcnnZRUrA=;
        fh=Z+Sx2DP6/m1H3+192xv1TB2SL9klwG+vT7lxmms8F+k=;
        b=GneonWbbz7Qoqu4yNV1pcqbirIo8h0eMV71BI3bHGzYLfmxZRdIay7RJN0u9PLCZs0
         +rpcKxQfuSYpl8yhZsUJHlqnQg1wEc7etW2WyaNcXfB1555age3YZKuyt3/ddNgPSBgH
         /AQPCNSa8k7iRvzt7Q5bdIZQAaSNt+5Ok+u+NrPPswLzCgn25qykEkXzBGYtD1KCym+p
         voZYW6v2f6JplWSjF36cDa1X/UAFONm7qJ7AC4BIjAjAiDKxbN4g69+jSa0ZvdEU6SOl
         Fta2VoVrsqFQGPiSdGuiqjbN4dkTjwAfn1rwnfFcgPMky0iWfUo6aX7xURvqFptRvlbe
         m/Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592599; x=1793197399; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rgbjqUjgri3y4Qotxqo2hzqfIjUvTE3IQoCcnnZRUrA=;
        b=ZGPZ4YjLsHfXtEZ3j+K5tbV5Zf9tTLwirIExujqyha2JKw4i+LEivVflYm8fqRazXz
         Zgn9HwtUQDU8I6n/zi1TTvEg05pT+RBWRrNS4+GL39JqnNL+NDD5vwU/uW5HTADOwrfq
         ptLKdDVOY500JQVeiCyE1Sf26IBEfcaNxzOIZO2e8/+COognoGiqWMpyrgv8E3GgPup7
         Eo5Xz6SYTkoGAvxnTjr/z+4jvbq74HMX5dxsDqMyxsGlY7xGt6+cUb9Xt1o93In68tBf
         G0uFhfo9AL+qeI5ZW/G2HDWRqipLmVnw0JxSlEeTeJOmUdziBkdq14sQe9I2KqZqwsEh
         Du3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592599; x=1793197399;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rgbjqUjgri3y4Qotxqo2hzqfIjUvTE3IQoCcnnZRUrA=;
        b=ThCPTtUU0GjocccIphQ4IRUoOv52wXvfUZfsogO1tLO9O9ja0CifHUqp2q2v72jXxq
         zcwnmbK9NoO5BmX5Qw0nvvF8AlZuIm8Ex7WkucJ9YqD+6EJcEyXRBVB9GR7jwxE5k8Ex
         3kxUKihCUp5Ng2GSF6kyHDlmr99OfFlN2BDvAAAtMMCLI+hKZJDAbYnYgv+vey9Zs4RZ
         BpZ9jfcuwOFuJRV3nzuLkAPy35KihZ6Kjlzn4R5GLNB6xBAVIvvV2rrIbh0pnV8ERxru
         BZJvLf7kZ+H79yiQXIQdJY67jGwbTrfN6qwmiH8eI1E0lcNWG0WoU1sKz19UkaRstVV9
         OkMQ==
X-Forwarded-Encrypted: i=1; AKwUvByPpbtPLJNJciUa6Yaj4PIk4pPzJnINJaOui2vTEcZY4RE6pFJAG2ps+EtgjYjcSfpyxJE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCILqkq9acuGTMNTWbcP/algO1U6+8jW12ic6cZDrZgJ5aq2iz
	RwR6A4nnz+yqE7xBHPkm+UbASZhGtPme7qzpw/AnGSIVdoxZS8isRxworLcEfMrM1oz4lNv9Tf3
	14J28IylPey0Wm5Z/iEr4BcbBTRdC1cuwRg==
X-Gm-Gg: AYBFou2n87/BWQbkBdwf0U4wvIBlAQc9wRfP2LH503ordWyZgXa095b2aPG8kb6QFjG
	S9my5AAMCZ3HyKCLP4bP6bL3owaXBvzQMxnmwSLV3F9nKKnl/g9mp9uYMS11QVi0x2n6U8jD2Vz
	rM+Em1VoeRRwSEdn/FP3iw8foakyvA7BYK/f9clO4JSvAAyAjoIcfAA4rbaVEDDnH5TO666CR0J
	PxbVorRbNivwDO5QbqPvTI9eEdAIpcUaRTpLJD81FMh50g20bET8Jcg1ByyoRa+M96lKjKZAOUM
	6LA/kS8jJGOja7R8SO4sCQLTCWhEVzJnEp+1kBknAzzUaXb1S+HFls082RsOcRiG3pBND9ROS98
	+27DSRxqmk1pi0f2ZAEXGQksunVfxpb8i5lDXPjkrBn8/ixBQL1TWgEl/hTo5wuW6EavFqzTttI
	9hFlkrpWGOGNHlgOrC/ZenmMHrZTM=
X-Received: by 2002:a05:6102:d87:b0:7c1:bc57:c7f5 with SMTP id
 ada2fe7eead31-7cc92669e24mr700336137.12.1792592599154; Wed, 21 Oct 2026
 07:23:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 10:23:17 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 10:23:17 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261021-b4-pks-odb-extension-v2-5-8cf11b65eda8@pks.im>
References: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im> <20261021-b4-pks-odb-extension-v2-5-8cf11b65eda8@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 10:23:17 -0400
X-Gm-Features: AclHuK-1_wzRKlyBUbooorSK7973R_kCz6xsP7qkHpg78VkjwE_ngLOCsqU2bFI
Message-ID: <CAOLa=ZRzu_7No085hEHnULo0L50y=ntx3MSkb-VbcywChdOPZA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] builtin/init: introduce handling of object storage format
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000019a16e065e5a7dc6"

--00000000000019a16e065e5a7dc6
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> While the object storage format extension can already be configured
> manually via git-config(1), this isn't exactly an ergonomic way of doing
> so. For the reference storage format extension, users have a host of
> options available to them.
>
> Introduce the equivalent options for the object storage format.

[snip]

> diff --git a/setup.c b/setup.c
> index 98140a7641..3d74f8eeed 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2466,7 +2466,8 @@ void initialize_repository_version(struct repository *repo,
>  	 */
>  	if (hash_algo != GIT_HASH_SHA1_LEGACY ||
>  	    ref_storage_format != REF_STORAGE_FORMAT_FILES ||
> -	    repo->ref_storage_payload)
> +	    repo->ref_storage_payload ||
> +	    strcmp(repo->object_storage_format, "files"))
>  		target_version = GIT_REPO_VERSION_READ;
>

Okay so this is what also sets the 'core.repositoryformatversion'
config. I was specifically looking for that.

Does this mean that even for the files odb with a payload we need v1 of
'core.repositoryformatversion'?

>  	if (hash_algo != GIT_HASH_SHA1_LEGACY && hash_algo != GIT_HASH_UNKNOWN)
> @@ -2490,6 +2491,12 @@ void initialize_repository_version(struct repository *repo,
>  		repo_config_set_gently(repo, "extensions.refstorage", NULL);
>  	}
>
> +	if (strcmp(repo->object_storage_format, "files"))
> +		repo_config_set(repo, "extensions.objectstorage",
> +				repo->object_storage_format);
> +	else if (reinit)
> +		repo_config_set_gently(repo, "extensions.objectstorage", NULL);
> +

So this handled reinitializing the same repo. If there was a previously
set object storage format, we unset it gently.

But, we already catch and error out if the extension before and after
reinit differ, so this `else` block is not needed, no? Removing it
passes all the tests in this patch.

>  	if (reinit) {
>  		struct strbuf config = STRBUF_INIT;
>  		struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
> @@ -2726,6 +2733,7 @@ static void separate_git_dir(struct repository *repo,
>  struct default_format_config {
>  	int hash;
>  	enum ref_storage_format ref_storage_format;
> +	char *object_storage_format;
>  };
>
>  static int read_default_format_config(const char *key, const char *value,

[snip]

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index d080ab04a8..0da14e8f70 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -898,6 +898,168 @@ test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FORMAT overrides ext

[snip]

> +
> +test_expect_success 'init with --object-storage-format=files://<relative-path>' '
> +	test_when_finished "rm -rf objformat" &&
> +	git init --object-storage-format=files://objs objformat &&
> +	echo files://objs >expect &&
> +	git -C objformat config get extensions.objectstorage >actual &&
> +	test_cmp expect actual &&
> +	echo 1 >expect &&
>

Okay what I asked before is expected, files with payload is v1. Makes
sense.

> +	git -C objformat config get core.repositoryformatversion >actual &&
> +	test_cmp expect actual &&
> +	git -C objformat rev-parse --show-object-storage-format >actual &&
> +	echo files://objs >expect &&
> +	test_cmp expect actual &&
> +	test_path_is_dir objformat/.git/objects &&
> +	test_path_is_dir objformat/.git/objs &&
> +	test_commit -C objformat A &&
> +	git -C objformat rev-parse --verify HEAD &&
> +	test_path_is_missing objformat/.git/objects/pack &&
> +	test_path_is_dir objformat/.git/objs/pack

Super nit: some newlines in between would help improve readability of a
few of these denser tests.

> +'
> +

[snip]

Nice. I like the extensive testing done here.

--00000000000019a16e065e5a7dc6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d267f0c5ebe64300_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yWXl0TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0cyQy85UTdKZjMzeFNUUHRCbTcxa1NlYTVYbXByNQp2VXQxV29vMmRX
OXVDTlBVNUVDT1JwVEFnUVV5NDEyUnhZZkRybWZCWjBJMjkydno0eEFvQ2lrVlNqUG9wajdSCmZy
NzdEUVlyTlg5SUlTWGc2U0ZkOFlHQmhiT0loN0N3K2NHTUJRV29JWXMxSzQvbGpRVS83RHJRdzVQ
bU5tb3kKT01kaVpzSVFlQ3JmRmRkdW4yeTlSQzd2bGQ0WXhWb1lRZFJmekd4LzRpQjlOckpZUU9O
TWZzM2Uwd1AyOUZvRApEUjZKL3lSWTJ1THhvV25Oc2tIYWhKTk9rVHVGcGVnMkJWODcvYWFSSVU4
ZjBkaVBOMFFrbU5xNGtGb3A0Zkg1CitoaFo2U1ZUNHNqNkhFVDI4bjhkT2FscGZCTXdEbVRqMDUv
RkgreEJxZituUUQ4blpMV2wxOGE4ZDY1RmZnZU0KMDQ4ZkZWdXAwMlRad2ZlMmJoTnJFbUhQZ0dx
THVTUlRqYW4wc1p5bEYrU2dZS2xza0c5aEdPdEFDVGEwTDNlNwpNUStxSGlXWXRlSUtsWi9kK015
S21NZ0NsMThpVGloQmw4REp1VmUxQUl4aFpZTHpBUi9qYURkUG9paWhnVjBMClJWWjVBalhxcm5p
ZEREQkFLL29reldWZlNvTjhSdzhuK2VVRlJlOD0KPWxiSS8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000019a16e065e5a7dc6--
