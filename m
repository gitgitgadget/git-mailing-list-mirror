Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238AA1DE4EC
	for <git@vger.kernel.org>; Thu, 15 May 2025 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307615; cv=none; b=CiyoEM4GO0NZ6h9dmCI6lwnf6nM4ZrI0mL34GqTGESg4g8s2w4liRiIxD5MbP+RJSrY0YYGT/rxFWcfSmRwVDaXeEVfZncr1MeUVUPUQjTtMLqOURvCjjAm+IikLhp/EQ4uzgrGNu9PQx3o24CMXXhytS8OeI85LO/UTdbCbEWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307615; c=relaxed/simple;
	bh=EIhFqRNkty2YCz39th0RmBysm+fBQ4myINlatkFa2lM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyLcyWDnZGdKx6+2KHrXbQ1CmMvdyZmlj9+R9VCsc6BiReI5KU07GTKXdciDT5bHQ0fA67VJpiDrVvWVpOX6esHRTIqHaJf1xwM2D8TvKZYE1ODJmYutfKDUue99rhrZtf0Uesjkin+rMT1TySqunoYcxJbgUU+T5rehSUkKRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebMq7ZOj; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebMq7ZOj"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5259331b31eso267332e0c.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 04:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747307613; x=1747912413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+SWByfNdRvrV1H2vtiuf+jKkA+Zpar5n/tesXNJ+bw=;
        b=ebMq7ZOjGBVEHHTSPSQNzgF0EehmQin8eWh1v4piSCeRldGKohgZatavLFQk+r1iXQ
         wsZVRhkDzCFLns4aWyksReyQk3tbmtZ1nYPFH8Iil/0J0XENGbQa/hfsqQlHyz2f3pqV
         1/9gkJg1Wlbk5gU4zfjXMy9DYO0bTbnNsLnO8PJ/WDPYzXPpMU2ZdbOIuESam19MseWK
         2EVGIOMHYjDKjXjQf2pdSxbBXSxQIx1wWijo9JpK6LWiopaiSq2QSH/i6SlP7FWVCfqx
         7Q/5vzMkuYgf7PlvFH9Np0cJ+UcAZFfUjDB2Y1KqyC+MRBsP/s0/fbwB74PpxGUbFoB3
         olgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747307613; x=1747912413;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+SWByfNdRvrV1H2vtiuf+jKkA+Zpar5n/tesXNJ+bw=;
        b=BKYDydrOR9eg3VTO8RUERrqioSoUiDVEe0mIqEBPa2zklM201nlDlt3VqBK+hSbBiR
         cSO8YGUrnqkN5RQyO7RjKddf3mKvY+8IL5GlRE9luuTST5QH64EGoPrF7RFB1E93SNjn
         YgnmOxTgYq3iVg2n69LabtwgOgDv3V2sIizNe2+e+IcYYndBkGzh9pJg9/5NMoQgpHnB
         JmxC03NChEN7twlrPdBSMCHHBQvVQWk6F6g9Lg6xHCjmXGheUr9tQghpfa9TqKky0FUF
         8lzUwHfg9YTLHEJG33l2pK6/kbKtWK8uYyA29zeBUnMYKVUd2eq1NvdqHxdjESQ/4iBS
         etkw==
X-Gm-Message-State: AOJu0YyH9bxTGFl6XEFOuADXZT26csiUjsGhXOhfL4Rc5ebcSkW7PrrJ
	ykMnESZoRuhxdTcNSPEMaKPUrXj36QbktRq/gPUOHBp4YcprpyWWZNu5dlk9fMLiQ9kDmzXXHSc
	jmJVMMrMSBtout1XNsR3Yz1ghhw4b5WKD
X-Gm-Gg: ASbGnctorgBwR/klro32nTJznzLI6HaCM5vW8Jz6RNfAxQWVIPwvjEIfHaugIr//M46
	Ml1YfOAo9z+RRaJVrCt78wYMruLH3MWGn9WwVfam+sYLncjh8/kp8Ib/LdjHsk+SvnnKLuBffjc
	1L5yGHevvX4jrHt5SSqn0YLfWh9CNNv54=
X-Google-Smtp-Source: AGHT+IFtwxbUO19Pktsm0Nfp4V2kvyyAMW5yL11/X+Kun3sdquWnGlRYe/RwELSXd0bfkGSRFUQz4c1cngWbczayUlc=
X-Received: by 2002:a05:6122:2501:b0:52a:bf98:55b with SMTP id
 71dfb90a1353d-52d9c5b5ea8mr6188715e0c.3.1747307612828; Thu, 15 May 2025
 04:13:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 11:13:32 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 11:13:32 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aCSNFMeh3WMav_Rn@pks.im>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
 <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-1-7c65f46493d4@gmail.com>
 <aCSNFMeh3WMav_Rn@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 May 2025 11:13:32 +0000
X-Gm-Features: AX0GCFtoOtMaGJCiuu2xPvEw82QiIzelk0mPkjKat_IJqgUbLufzrQG8YoPOfqw
Message-ID: <CAOLa=ZRbEqs6X1KJj-CikCANX-BC8r4RqbwoT06qmtF=x+7hQA@mail.gmail.com>
Subject: Re: [PATCH 1/3] fetch: use batched reference updates
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, toon@iotcl.com
Content-Type: multipart/mixed; boundary="000000000000939a8306352ac161"

--000000000000939a8306352ac161
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> Yup, this makes sense, as well. We lose a bunch of overhead by creating
> separate transactions for each of the updates, but the slow path is
> still that we have to create 10000 files for each of the references. So
> it's expected to see a small performance improvement, but nothing game
> changing.
>

Exactly, but it is still a good bump in speed. Which is always welcome

>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 5279997c96..1558f6d1e8 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1688,6 +1644,32 @@ static int set_head(const struct ref *remote_refs=
, struct remote *remote)
>>  	return result;
>>  }
>>
>> +struct ref_rejection_data {
>> +	int *retcode;
>> +	int conflict_msg_shown;
>> +	const char *remote_name;
>> +};
>> +
>> +static void ref_transaction_rejection_handler(const char *refname UNUSE=
D,
>> +					      const struct object_id *old_oid UNUSED,
>> +					      const struct object_id *new_oid UNUSED,
>> +					      const char *old_target UNUSED,
>> +					      const char *new_target UNUSED,
>> +					      enum ref_transaction_error err,
>> +					      void *cb_data)
>> +{
>> +	struct ref_rejection_data *data =3D (struct ref_rejection_data *)cb_da=
ta;
>> +
>> +	if (err =3D=3D REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_=
msg_shown) {
>> +		error(_("some local refs could not be updated; try running\n"
>> +			" 'git remote prune %s' to remove any old, conflicting "
>> +			"branches"), data->remote_name);
>> +		data->conflict_msg_shown =3D 1;
>> +	}
>> +
>> +	*data->retcode =3D 1;
>> +}
>> +
>>  static int do_fetch(struct transport *transport,
>>  		    struct refspec *rs,
>>  		    const struct fetch_config *config)
>
> Okay, so we now handle errors over here. Is the handled error the only
> error that we may see, or do we also accept other errors like D/F now?
> If the latter, wouldn't it mean that we don't print any error messages
> for those other failures at all? That might be quite confusing.
>

I was mostly trying to replicate the current behavior, which is
- For F/D conflicts print this error message.
- For any other error, simply propagate the error code.

I do think there is merit in changing this, and since you're pointing
it out too, I think we should make this change. I've modified this to
now print a better message for other errors.

>> @@ -1808,6 +1790,20 @@ static int do_fetch(struct transport *transport,
>>  			retcode =3D 1;
>>  	}
>>
>> +	/*
>> +	 * If not atomic, we can still use batched updates, which would be muc=
h
>> +	 * more performent. We don't initiate the transaction before pruning,
>
> s/performent/performant/
>

Ah! Thanks.

>> +	 * since pruning must be an independent step, to avoid F/D conflicts.
>> +	 */
>> +	if (!transaction) {
>> +		transaction =3D ref_store_transaction_begin(get_main_ref_store(the_re=
pository),
>> +							  REF_TRANSACTION_ALLOW_FAILURE, &err);
>> +		if (!transaction) {
>> +			retcode =3D -1;
>> +			goto cleanup;
>> +		}
>> +	}
>> +
>>  	if (fetch_and_consume_refs(&display_state, transport, transaction, ref=
_map,
>>  				   &fetch_head, config)) {
>>  		retcode =3D 1;
>
> Don't transactions handle D/F conflicts for us? Isn't that the sole
> reason why for example `refs_verify_refname_available()` accepts an
> "extras" parameter that is supposed to contain refs that are about to be
> deleted?
>

My understanding was a little different, from the documentation for the
function:

  If extras is non-NULL, it is a list of additional refnames with which
  refname is not allowed to conflict.

This is to capture additional conflicts. We want a way to avoid said
conflicts. That said, there is a 'skip' parameter which does exactly
what you're saying. But the transaction logic doesn't incorporate this
entirely. Specifically in the files backend, where we create a lock in
the filesystem, this would cause a conflict, consider the following:

  =E2=9D=AF eza --tree .git/refs/remotes/
  .git/refs/remotes
  =E2=94=94=E2=94=80=E2=94=80 origin
      =E2=94=9C=E2=94=80=E2=94=80 dir
      =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file.lock
      =E2=94=9C=E2=94=80=E2=94=80 dir.lock
      =E2=94=94=E2=94=80=E2=94=80 HEAD

This is from the test 'branchname D/F conflict resolved by --prune', the
test prunes the existing reference 'refs/remotes/origin/dir/file' while
adding 'refs/remotes/origin/dir'. In 'lock_raw_ref()' we lock both and
read the reference, but this causes an issue since
'refs/remotes/origin/dir' exists as a directory already.

I would say this is logically solvable if we start treating conflict
resolution within updates as a first class problem. But perhaps that's
something of a patch series in itself and better solved outside of this?

> Patrick

--000000000000939a8306352ac161
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: acdde0fc31fe268_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nbHpGb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFZ0Qy85TVE2cStsTGozR2FETlhlR3FRWDBzTEI4agoxVmI1WUVSZzNn
MytVWFZxcm0zWjNnWTQwUHV6S0U1Ymt0cUZyL2ZwcEUxakVyVGlqclZjSjU1ZGJkOU5SYWo1ClBo
MTRCL0ZmWDdXOTBXYWdhZ3FyR0l1ZWxZRGxxTmRyMThuYUFna0FJWUN0bDdRTmtrdFRrWnhCa2pz
bkdiUUkKQjlyVExWcjY4Tzlob3JJN1k3WkI3YlpOcFhiTDN5UjVMY0J1MHR2Zk5TQlJtdkJzSFpn
blBaVGNBb0VqeWJvQgpmK0pzU2VTMWU1R2FCcWlCRkIxRXdma2xtYS9aZDdqaFcyQzF4OUJFU0xy
bFp6QWwwREtLcVl6UUtxSVNlYUhLCmVLejRMR09YVkJRYVBPdE9oa2w2eTdDOFhKSFRRbW5Xbi9I
cHJuNWxxajh3aTIvU0pEVFpTQWx4OHBHMUlYa0YKV1ZTWGRFbzUxVEQvUFBoYTUvM0dMUlpudm43
TUxHcytBLzN1Nms4TzRlVjdleEFqV0JKcXRaME9XQlVVOW1GaApGTlpwTFIyeUhtMllkMGh4WEd0
eGRiSXN4V1BFY0JuOE5iaUxSN1FXcFB1WDN1cmk0S3J5Q0w0UU0vaSttSnBNClhHV0VURG9sWEF5
NzlnRm5SZlZqODgwaTN3enpnMFdrSzF5cWVBYz0KPUw4enoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000939a8306352ac161--
