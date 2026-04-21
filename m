Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76DE3D5667
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775529; cv=pass; b=U71HeUXN48n7qeKZ/Cf1HZfAt3FgmFk7pmEDMmWN42k1s78oP9od9K/oUctTXq/VN8UkWpMpSSslt9oyaMr+5JTbR7cxkDoml7qNl4eTomZ3nQ/75oojwpDFvBt/4kOokVgAjYtXvb4+dTE/4/sMkw/O3QNDeN1GaGGH4mIasVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775529; c=relaxed/simple;
	bh=lCgVhGX2XD5w00HMH2XdT7SzObYqJt2s0VHC+DOKciM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHX1JU97E8t4FxbJIJj1tyKxGpf7SmDu3vA8F+jvk6DiaFbACgQXAKgx9Hgmg/OobaXfDKexBegOMnB0epBO0A2h1Qu/Z6z/7sKgOS+fA9gyqUHs1PQkGTiKbr/VTcT6Vg6lUhNl5F4nEJtmuvLVkOGEuamY1jgnbG93uDURJCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfuH0Z4F; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfuH0Z4F"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-60591ade110so2886160137.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776775526; cv=none;
        d=google.com; s=arc-20240605;
        b=buJhnnYStc4kcQzj08G75eMbNGk2YbcnS1LKprXVEBgYAwUoDjB8keRogb5XYfo68O
         DH3LVtZVVK06FhHKJ8U+kz3BL03Ce9M/TGmQCtU/HB8ctFY9lxCkqE1MldyF9v7NfEir
         VyPdA07Z9qmS4caOZIfzK2nU8nn+eKjlNYEijVDxX5mWMKzav1M4dY83N4yHNGzVoWSa
         a8HHvOGRU5pTNrFXM8kxt2R+sTyiycl8OqfmNABHFuTV97Mx2NgYpJAkjHA4bra2E03r
         bvx1OpTSzQgBuHhxeePkVXjgtoVa9adk8DM5duGyuJD43BkY4j93gcHnTdFP9wStIGEi
         j49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mYcyk6La21NsNmukNnt62eL4y9f/MznR3BDenPZCDEE=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=NpMp5IjoLgA2XsKFurpkE03dqvbO4eTqc6aTjowF+Ac3fjGBXmUMM64ISBYz+gd2wD
         RShMh0t7/Z7kZbiGiLe9ujh7ZQt1+4XZLwv5sAvxpZn94Jzi7LQUcoc6TAnmS/O1z37L
         DzSK7ELnaYmvPTFE8tvq+Vec+3qIi2dmKRq4k7TQ9ehCFx05SSAeEiZo//ELHcNtPS1C
         SbmGUVuUyucsZCj99K1aLTmUMpO9QzNWS9uS2HQ8NfwQ5F9ZdoQFMTQc7KtRv/oYasd5
         LQkLwVRYkirmFpwIu/k1NVv87Q16N1whNCm/vohLbYt2GG4O/IG2zlHpdAswbOn8BCxz
         60Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776775526; x=1777380326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mYcyk6La21NsNmukNnt62eL4y9f/MznR3BDenPZCDEE=;
        b=BfuH0Z4FWP6mPZlzxws4iXHPkuhOx9dWAcm79TyERQ+u9mjuKulglmVJZem57g7xR1
         4afl1qh7PPGoDlSry2y5TPU4f6/pzotltNXYl7RknOVhd3rDJDOnolPh7UBewEVwrk0i
         fgqGVjo2iy5daDA2guShdx5JNtmXnmnyUD6HdImkBmZYpYU1yaMta6SfoKCzyo0cjPTB
         BjZC2piOLAyMT+OGrwK1n5jCtU17F/ytCDLQuCd+dH8+ALIMWMgG4/2tuS2lHQac0SEz
         JvndezJB6Ad/wWzBSyUBAlAG/Iote2uMUsdezH7z1pamXqeA3ThgLIPaJjt4OCPr9AyB
         kq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775526; x=1777380326;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYcyk6La21NsNmukNnt62eL4y9f/MznR3BDenPZCDEE=;
        b=Hm+7hPqbL17YIV7naMkJrETskXEwE6yg0MAeVp7sfdrgejkv4wCKkSRfGJSe/637pO
         os1rkkMuaQw4j5fGjPu/IczLEBv/gOwmshIb6jd26RcJJ1XVzc0Sq3qF4pVbVCCabE9n
         D89KIA93+0Cr7k1UHmm152yoTk6/I+zU0DMgrjh/xeJ2vTDB0acNhu7fLqjagCbWLCjR
         /kw+tvNpYvvLrG5ZUyToh1/b+jTtLOXqNCmIrA613MVJ14pC76hgsoJOKzAjX1987QpC
         EnTPJ+G6QvSd6FdMgM5xc8XFXpuMJ0jnFOZmVLK+hGPu/2ONoJWL4LccvARK56fwVpC2
         p0wA==
X-Gm-Message-State: AOJu0YyFaKpAQCxgmspWs68xYrcucyOkQ5kijAKwd8VqBu0R9gnsDU/m
	FyYQHB8b1XBCHqYzNIMHjMRjquWP4qpiqZQl4N0tBy6AKHzCVNTZTdqaikeaTxhAvGsTuuy43i7
	GrezPkq1A29o/UZuYZO8/1hcL+Zs2intafQ==
X-Gm-Gg: AeBDiesToqtKdY4j4HekLhsiHymxnJvhdWmVfaZls9c5LR1J/7fIzb4EYIVPV08+z1b
	A5J2yJ+gDDGe+XNIqpU97W9rdShfsdg3fKPno4JlilGFzyAHy+m9U4zgf/tQ1bZ0nxc0fS5U5A8
	jmW78/Mhaiy4kLI+qglP0cSnTlkVbuDXha6zVGNkuD0GQyCozjejhF2KhCzifIKYj/Mj37Spttf
	k2rDffhwOoxQWNomHaLdcsCeTjC6BHNCWnFHeAEzTiLK5WVCp7NpLiYVyeRGXbrHRdNqWavyRuy
	5A+4Zfp0yOjvZw9/
X-Received: by 2002:a05:6102:162a:b0:605:5d09:8631 with SMTP id
 ada2fe7eead31-616f807265emr8044021137.29.1776775526357; Tue, 21 Apr 2026
 05:45:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Apr 2026 14:45:25 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Apr 2026 14:45:25 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqtst5pkg3.fsf@gitster.g>
References: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com> <xmqqtst5pkg3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Apr 2026 14:45:25 +0200
X-Gm-Features: AQROBzCAzYIjvUWj9XwwcvyJmJDfB0HKmOUqxHF6V3UGA6P9nxuDeM3anEoU4XY
Message-ID: <CAOLa=ZTUjqE4msQcTDcemczdOuD+dREGuxozttp1EaPgRnTNww@mail.gmail.com>
Subject: Re: [PATCH] refs/files: skip lock files during consistency checks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000184025064ff7ca1a"

--000000000000184025064ff7ca1a
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Running consistency checks on the files reference backend involves
>> iterating over all the existing files in the 'refs/' directory and
>> running all `files_fsck_ref()` on each of them.
>>
>> Unfortunately this also includes the '*.lock' files created by the files
>> backend. While the `files_fsck_refs_name()` check was skipping over such
>> lock files, all other checks still continue to validate them.
>>
>> Avoid this situation by moving the check for lock files to a layer above
>> and skipping all checks when encountering such a file.
>
> Saying "all other checks" when there is only one other check is
> highly confusing, even though it may not be telling any lies.
> files_fsck_ref() calls files_fsck_refs_name() and
> files_fsck_refs_content(), so this change moves the test from the
> former to a higher level caller so that files_fsck_ref() itself
> won't be called, the net result is that files_fsck_refs_content)( is
> not called on these *.lock files.

You're right. I think I wanted to say that moving it to the upper layer
skips both files_fsck_refs_name() and files_fsck_refs_content() and any
other new functions which would be added to fsck_refs_fn[]. I'll modify
to explain this better with more details.

>
> And this does not explain why only one of the callers of
> files_fsck_ref() is the best place to add this "*.lock files are
> exempt" knowledge to, compared to (presumably at the beginning of)
> files_fsck_ref() itself.  If we do not anticipate that we will ever
> gain new caller to the function and the only meaningful caller that
> needs this protection is files_fsck_refs_dir(), then the choice may
> be justifiable, but if we check at the beginning of the callee, we
> do not have to rely on such an assuption, do we?
>

There are two callers to files_fsck_ref():

1. files_fsck_root_ref(): where is a callback function passed to
for_each_root_ref(), so it only iterates over root refs.

2. files_fsck_refs_dir(): which iterates overs entities within the
'refs/' dir and then runs the checks provided in fsck_refs_fn[].

We don't have to worry about encountering lock files in #1 since we rely
on the refs API, but in #2 since we manually iterate over the directory,
we need to skip the '.lock' files.

Any new checks which are added should be added via fsck_refs_fn[], so
this makes adding the check in files_fsck_refs_dir() the right place.

Will add this additional information into the commit message.

>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs/files-backend.c     | 22 +++++++++++-----------
>>  t/t0602-reffiles-fsck.sh | 21 +++++++++++++++++++++
>>  2 files changed, 32 insertions(+), 11 deletions(-)
>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index b3b0c25f84..f1bdfbe88e 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -3864,22 +3864,12 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
>>  static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
>>  				struct fsck_options *o,
>>  				const char *refname,
>> -				const char *path,
>> +				const char *path UNUSED,
>>  				int mode UNUSED)
>>  {
>>  	struct strbuf sb = STRBUF_INIT;
>> -	const char *filename;
>>  	int ret = 0;
>>
>> -	filename = basename((char *) path);
>> -
>> -	/*
>> -	 * Ignore the files ending with ".lock" as they may be lock files
>> -	 * However, do not allow bare ".lock" files.
>> -	 */
>> -	if (filename[0] != '.' && ends_with(filename, ".lock"))
>> -		goto cleanup;
>> -
>>  	if (is_root_ref(refname))
>>  		goto cleanup;
>>
>> @@ -3939,6 +3929,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>>  	struct strbuf refname = STRBUF_INIT;
>>  	struct strbuf sb = STRBUF_INIT;
>>  	struct dir_iterator *iter;
>> +	const char *filename;
>>  	int iter_status;
>>  	int ret = 0;
>>
>> @@ -3962,6 +3953,15 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>>  			strbuf_addf(&refname, "worktrees/%s/", wt->id);
>>  		strbuf_addf(&refname, "refs/%s", iter->relative_path);
>>
>> +		filename = basename((char *) iter->path.buf);
>> +
>> +		/*
>> +		 * Ignore the files ending with ".lock" as they may be lock files
>> +		 * However, do not allow bare ".lock" files.
>> +		 */
>> +		if (filename[0] != '.' && ends_with(filename, ".lock"))
>> +			continue;
>> +
>>  		if (files_fsck_ref(ref_store, o, refname.buf,
>>  				   iter->path.buf, iter->st.st_mode) < 0)
>>  			ret = -1;
>> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
>> index 3c1f553b81..fc67bee161 100755
>> --- a/t/t0602-reffiles-fsck.sh
>> +++ b/t/t0602-reffiles-fsck.sh
>> @@ -87,6 +87,27 @@ test_expect_success 'ref name should be checked' '
>>  	)
>>  '
>>
>> +test_expect_success 'lock files should be ignored' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		git commit --allow-empty -m initial &&
>> +		git checkout -b branch-1 &&
>> +
>> +		touch .git/refs/heads/branch-1.lock &&
>> +		git refs verify 2>err &&
>> +		test_must_be_empty err &&
>> +
>> +		echo "foobar" >.git/refs/heads/branch-2 &&
>> +		test_must_fail git refs verify 2>err &&
>> +		cat >expect <<-EOF &&
>> +		error: refs/heads/branch-2: badRefContent: foobar
>> +		EOF
>> +		test_cmp expect err
>> +	)
>> +'
>> +
>>  test_expect_success 'ref name check should be adapted into fsck messages' '
>>  	test_when_finished "rm -rf repo" &&
>>  	git init repo &&

--000000000000184025064ff7ca1a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f6e1c3fb55dd348f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ubmNXQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTk2REFDaDZRQnNlQmxJR2tmT0RCT0dPMjRPTG1WTQo4NFNuQlo0MmJy
V0tUWHBvazJoLzlJcFQram14ZnA2UjAvaGV1SWMwVTBDTEorai9aM1ZlZjlZaElvTUw3ekVtCkZ4
VkJOTEpkM05DbXFXMi9lWG5WY3BsWUNNOXdnQW1QWG91eFJZU2VxMzMzQ1J2aVRJZHBWTEhwMWR3
a3RLRmEKOTh5UmFZNlJQTXdlbUU5WTNPRS9oSFZZQlV2cEp5SUZRYW1GV2hYNUVSZFpHMU1sNHRL
QlV4VGhNMmtHeVFGTwpTT2JEbDBjdVFWcGZYWkxYZ0VBMjFPRkU0cHR5enJXQzFWS0gzL3F6WHdM
Q0gvVGpjbGpSUlZHb0FQN1JuYWhiCjJMQ0l5MkFJT2ZDcTM4QUZuRGZ0VnlZRDNvUjk3ZXpDNnp3
Mk96Qi94dmFWNE5ZQ3VkRTA2RWZWZWk0YXZCYjAKTjZnK2NJdy8wa2pNbXQrdTEwWVE3Y0RBQ1FZ
eTVzUkpydXU4ME9Ea3YwREJOUXc4SmdkNWpDU08ydGQ0NzF0RAo0OXpiQ09XNHdVWWhJSVFBSFFV
dWlRU3daMDdSKy9CT3k3dWo0b29xOXdoa1U0cSs2WHRrNzNNMWZLRkI2bXJCCnRULzlZdVc2a2E5
NEZXZUpnZXlYa0d4Mmc1cmV4ZDVMY2xsZkdsaz0KPUk0VXQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000184025064ff7ca1a--
