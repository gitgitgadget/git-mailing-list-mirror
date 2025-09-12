Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5B302CDB
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677988; cv=none; b=l3laUYtxj8HAVw7cb5utSn4bdGcvu6P9B3uH7PTQcvXcbgBXU97iN+VxdBkIP0aeN9tEGK19X/sKdP/UpubIs480xOtAPig6Ky78yvWZngOeVlDOV5g8b3DXFqjXIww2ed0Axg+0sAVDcrZ2fCm4BbecEjiXchmswdutE4i5cWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677988; c=relaxed/simple;
	bh=rx9Si8fDy61EXgUiogeHffYkT1OBSrROR1CWJbJgBOA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JddHZcUD3x78ALyJCMu/DWBPVDbFPCvwtyETP6BRbq/UrYbM2nxyGUnMGuTOlfdPuxTMGn4h4ZqpZPmEH9T2tfDY+yJGVRY3fUHvhz+V+EzdgrL3RRcHreQatg3YD8zu6LGaHisKvS700CkvaklXIeMazQCkUmcBHu9tBwm519M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSuWzwKM; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSuWzwKM"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-53b174ca9bdso1081770e0c.2
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 04:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757677985; x=1758282785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNfI3lEBG+Go+cz1wG2m2OKCJ7itDgIIRRGy/dgK5uM=;
        b=lSuWzwKM6dWX2Liy3fS9MZrgIsQ6SNBvYRjIjYr6CAx+Ci29Jgi3l1iUz/EjcCqfxT
         J3uCsPkJz5ny6qgEOt/418WIxbMNbqbR/Y2jQQf3C62EPBjwOghccouuXNYXelz2Op90
         7yHGUBFmQwPf7Bb5ahxM/8NpJLIFygaW+LwQ/eQwIe3/EJliCWDcjxFVW5uTqsM5Z37+
         zEt+mX12QWvQrzSLArMeAo0aTHDwfYnU1rNgV4V1p34pg8SsVpXFRXDd4mV7ZsKb9m+6
         GMY9lbTfcwc7KULNfM7T693VcJxajf1qvD2czZJnxBdCRDzCnqwxIjvmrxnoDf6TNAgg
         AQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757677985; x=1758282785;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNfI3lEBG+Go+cz1wG2m2OKCJ7itDgIIRRGy/dgK5uM=;
        b=eN0rKfUJYdnCbDEnBR9CQLMrH4UtCAeLOuAP7vFqYsM00tmg2UWTunBN4E1Bv+uirq
         ifVSdZcNa1ozWkIO/2UfkiknBcUIFejAMbnfbOakhoCykfzFCa6eJQd2XRk5bD9BTYM0
         7QtaWjj5ws16L33PpUG+z3+uyHcjdK/TbOCPg9t6rFOWRVbz7U0T0TuEuOJ3jOlZx2hm
         IFEs7895kwTvLN+7o+quTPFQqEzulYMmQoDozuV36GLfRSU+iGciXFY/Xynv2MbUsqKg
         /HEWHjtfIyFwOOU6RQ8e+8L4wp+xyWNmvLUKCwpUHbdboeE9gE2ZTWV7oFGivgbDSoeK
         MBNw==
X-Gm-Message-State: AOJu0YwZhP21coQ5POnz+liV6G5zbvpnWsQ6PqK1u9T1NuX9d2Yzyc2h
	mYGMvNQvGKh0I50Ge0njhX9aA8rau5LTRBBim0lkuglC/BsMq6yG+Iee0z6Wj5KwnUU1IArAE5j
	puoVjUpvWYXr3JoHYiRrb+bpNCdBsXS7lHQvg
X-Gm-Gg: ASbGncs8AsO6Z4kKSp7zs/YntYqhOR7i6hHd560qWc4CQFVXotuvfTIZFXBAPTWWFS2
	7qiav4wXFS6O4lyBT8PFP9mFR8bkLTujJ0cIrYhJ9CLt6dYwJuDldg3q8opV193BbxBHYeTyo6x
	YWzPiVZV10TfQEiKY9/ZTC50XMbKbJa2jZYICoAw9RxBovnEO1pVstdsJKi+/W2gKjUKOWb7xQM
	Zm7sE3x7nN8icqQ
X-Google-Smtp-Source: AGHT+IFyMIlpdmHEbteWDdDOA9D4A+jKKhpJSS0HYZJcAiYz5s6+UG+tihvM0kSXCgXtfFdnpriOrZebWiEQ87Fvwf4=
X-Received: by 2002:a05:6122:3091:b0:539:3bb5:e4d6 with SMTP id
 71dfb90a1353d-54a16b7e309mr788578e0c.1.1757677985309; Fri, 12 Sep 2025
 04:53:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Sep 2025 04:53:04 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Sep 2025 04:53:04 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aL_SznrF61hbUMBo@pks.im>
References: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
 <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-4-b2eb2459befb@gmail.com>
 <aL_SznrF61hbUMBo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Sep 2025 04:53:04 -0700
X-Gm-Features: AS18NWB3rCiYDOTNhmyLzJ8RD5rky5M0AlrUNQ5xaYHrUsPtN77d-hzuaMgSYKM
Message-ID: <CAOLa=ZRt=HY_MrKHxGrC1g1QjOjngSYENzMwNDgUpi1gbg5yEA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] refs/files: handle D/F conflicts during locking
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Joe Drew <joe.drew@indexexchange.com>, peff@peff.net, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000f1d69d063e994b14"

--000000000000f1d69d063e994b14
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Sep 08, 2025 at 02:37:38PM +0200, Karthik Nayak wrote:
>> The previous commit, added the necessary validation and checks for F/D
>
> s/commit,/commit/
>

Thanks, will change.

>> diff --git a/refs.c b/refs.c
>> index 4c1c339ed9..ec4f0e9502 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1232,6 +1232,12 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
>>  	if (err == REF_TRANSACTION_ERROR_GENERIC)
>>  		return 0;
>>
>> +	/*
>> +	 * Remove this refname from the list of refnames used for validation
>> +	 */
>
> Nit: it's obvious that we remove the refname from that list, so the
> comment is not helping much. It's much more important to explain _why_
> we do that though to give readers the necessary context.
>

Indeed, I'll add this instead

  Rejected refnames shouldn't be considered in the availability checks,
  so remove them from the list.

>> +	string_list_remove(&transaction->refnames,
>> +			   transaction->updates[update_idx]->refname, 0);
>> +
>>  	transaction->updates[update_idx]->rejection_err = err;
>>  	ALLOC_GROW(transaction->rejections->update_indices,
>>  		   transaction->rejections->nr + 1,
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 85f2e14e93..ceeec272ff 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -852,6 +852,7 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>>  				goto error_return;
>>  			} else if (remove_dir_recursively(&ref_file,
>>  							  REMOVE_DIR_EMPTY_ONLY)) {
>> +				ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
>>  				if (refs_verify_refname_available(
>>  						    &refs->base, refname,
>>  						    extras, NULL, 0, err)) {
>> @@ -859,7 +860,6 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>>  					 * The error message set by
>>  					 * verify_refname_available() is OK.
>>  					 */
>> -					ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
>>  					goto error_return;
>>  				} else {
>>  					/*
>
> Hm, interesting. Previously we'd have returned a generic error in the
> `else` branch, which reads like this:
>
> 	} else {
> 		/*
> 		 * We can't delete the directory,
> 		 * but we also don't know of any
> 		 * references that it should
> 		 * contain.
> 		 */
> 		strbuf_addf(err, "there is a non-empty directory '%s' "
> 			    "blocking reference '%s'",
> 			    ref_file.buf, refname);
> 		goto error_return;
> 	}
>
> So that directory contains something, even though we've previously
> verified that it shouldn't, if I understand correctly. The test case you
> add does seem to indicate that there are valid cases though where this
> can happen on a case insensitive filesystem?
>
> If so, the comment definitely needs to be updated to explain this
> additional error case.
>

Yeah I think that comment needs to be rewritten.

> One more question is whether it's the correct thing to unconditionally
> return REF_TRANSACTION_ERROR_NAME_CONFLICT in that case now. Could it be
> that the directory exists but contains some garbage?
>
> Patrick

This does affect case-sensitive systems too. I should've added a test
there as well to showcase this.

Basically if there is a lock file in a directory
'refs/heads/foo/bar.lock' while fetching 'refs/heads/foo', this would
reach this section of the code. Pre batched-updates, we would skip this
ref and update other refs. So it makes sense to retain this behavior.
I'll add in a test and amend the commit message to reflect this
behavior.

- Karthik

--000000000000f1d69d063e994b14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bfaf237b23433380_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qRUNaNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejVEQy85YWxmMjMxWEVDd3orY3NwVURocWtGQnVGNQpvRjZUdTlsWXpZ
Tlo0ZnkrZ29LWmJaU3d2UHhDR2lsMVZIRkpQekR5SHRLOS9WaFNPbElIdU85amNPRXZaWjBjCjRt
VGU0OHcvdHV5YzY1azNDUUlrbnUwZVhrV3pQbGpQZ1hNR2tBeURSZ2Q2bTNWQ2xKRmRJbExMcDRt
WGhOSXgKWCtvZGw0bFRvNWJHcGJZQ3NRS2VQUFA0Wmp0MFZVNGx6bXlnLzA0Rm5pRFd1NkFtVkVM
dlhNS0RxV1NVdTNQUQpPY2MraFRrRG1iVHJGQnVxTHloTHMvRzRRRE1YTnJ0WUFMcGpUMGpwbE5i
Zi9xSWNKTFhEcWl5cUhyZVJSMUN1Ckdyc1hZeC8vMVJRV3crN1RMVGxoMTlpSVpzQWJnYm5iTC9C
UnJrblBvcm1RVUxwTThudzRobkNLMExPdjJ6WnAKS0lJVmQ5R3RzMURvTExqL3ZPblMzeFJJLzND
b1ptbDdZMmxHUDZ4WDNSVGJsZ2NkSnQ4VHhLTENMWkVMYUdjcQpzbXFDeE1DNDFPaUk3aWNXNnlX
bmw4dXF5QXVmYzFhOXpId2NwOThIYVFsMVVHNXAxU0w3ME11U0tkMDUxYVNHClFHUmRJSGtoL0J2
ZHNPZFlFZXdxclFtb3hIUGoxcUlkTUx5ZzIyWT0KPVlkMHMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f1d69d063e994b14--
